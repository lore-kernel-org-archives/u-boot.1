Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A934DC3DA7F
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 02:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12AC7884AC;
	Sun, 11 Aug 2024 04:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gAMs4La6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C71B884C3; Sun, 11 Aug 2024 04:48:15 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE278847B
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 04:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yasuharu.shibata@gmail.com
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-492a01bce97so1169391137.2
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 19:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723344492; x=1723949292; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N33wSrx2c74WqVS0IFornSoAIne39TF11h+TIMQrSu4=;
 b=gAMs4La6sdNMLaIbcJlbPxN1d/krAcoqPgOXBwVXv8caxD0gD02wUmLWrPESaODQMe
 lFRkFrX+LMqj1/PEawo5fE/cNyOB+jOpDDeQK0L33cCgLX9J6B+yFzlVAYWHAkI91u0P
 +xRNMVfBhl7Daf7mUz0azXsO1MjYtDAl0D1AK5KWJIZRLizt7+F8t9DvXzLallZZ+Sox
 QwH+jZikD9hLVXomRweMy1AACmqkLWp2jhStCjQfQsFUMSdwAJmc8ZGztlolLRdmz+r5
 RqlAS8upvfJCTGp+MmFNwbBWcIipkO9zz0eDUlWbffpXW7EWbr8S/H33NwrKjBgRfm4c
 p2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723344492; x=1723949292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N33wSrx2c74WqVS0IFornSoAIne39TF11h+TIMQrSu4=;
 b=dF1kt9YpTbnkVUhbLESH0Bi33ueT9JyAX5ed0S5HORwxTSNzGAI5897tsQOfCUXBru
 GwudjLhllgXRJl030Qf419xfmK5I77lFW5G5QFvxOiDQJ3fzAmkhg+QvTiFW5M0L8wmv
 c+24mQZ4+RWCZ+5UNaCoBiFabXndBmhaUG3iUKYkn3vbyCjjF+GdvKdpH5d7NnWQOmZu
 /Ibxhf4p/JQAnT8X8+2QuawMd1wOrQ7YJppTgVKjqp4TOONHXE5db5S2MiNPCGBjFjNp
 hj0Ykk+Xpmixuqy6z0mcKImh4Q6C5+IjlrIHN8dYgG18xj0LsSrjBtMdAqZ1g0MI6f2w
 3C6g==
X-Gm-Message-State: AOJu0Yyr0oynz4R6wDtiruzMYIR1EykGko/ou5NsmR1ygz6K5TnvyJOg
 /l0pchm+o1pYNfh/0/g2aMN9f5s/1SJwTcRG+bpy92LRdRxSIL2pdeg8s0QRXLPo1uVRsooYgdV
 nWPPPA8sqj1i8/MMEPUIzsFXwKEs=
X-Google-Smtp-Source: AGHT+IERs71lPG/PXqSFp7D/fGTfsPsaRjiRa8zL5KTM9nYoPPCaeXkelcXNcMA8iSVikTANnxd33xRRqJPmiX7MgyE=
X-Received: by 2002:a05:6102:4189:b0:48f:447d:7915 with SMTP id
 ada2fe7eead31-495d8453712mr8371695137.15.1723344491981; Sat, 10 Aug 2024
 19:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240810205205.3403177-1-sjg@chromium.org>
 <20240810205205.3403177-8-sjg@chromium.org>
In-Reply-To: <20240810205205.3403177-8-sjg@chromium.org>
From: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Date: Sun, 11 Aug 2024 11:47:00 +0900
Message-ID: <CALu9rSbrAcxkGkFHuiFSBd-JMTm0kfEwDuBCDNYZc33eTLVU9w@mail.gmail.com>
Subject: Re: [PATCH 07/21] Revert "net: wget: Support retransmission a dropped
 packet"
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marex@denx.de>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Dear Simon,

Could you inform me how the wget test was broken?
As I explained in the commit log, I fixed the bug in specific conditions.
Without the details of how the break happened,
it is difficult to find a proper patch.

Best regards,
Yasuharu Shibata






On Sun, 11 Aug 2024 at 05:52, Simon Glass <sjg@chromium.org> wrote:
>
> This breaks the wget tests, so revert it until a proper fix can be
> figured out.
>
> This reverts commit cab7867cff33f9c21025102ea9ca3b26e362fb52.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  net/wget.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/net/wget.c b/net/wget.c
> index f1dd7abeff6..5eabb413116 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -49,7 +49,6 @@ static unsigned long content_length;
>  static unsigned int packets;
>
>  static unsigned int initial_data_seq_num;
> -static unsigned int next_data_seq_num;
>
>  static enum  wget_state current_wget_state;
>
> @@ -272,18 +271,17 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>
>                 current_wget_state = WGET_TRANSFERRING;
>
> -               initial_data_seq_num = tcp_seq_num + hlen;
> -               next_data_seq_num    = tcp_seq_num + len;
> -
>                 if (strstr((char *)pkt, http_ok) == 0) {
>                         debug_cond(DEBUG_WGET,
>                                    "wget: Connected Bad Xfer\n");
> +                       initial_data_seq_num = tcp_seq_num + hlen;
>                         wget_loop_state = NETLOOP_FAIL;
>                         wget_send(action, tcp_seq_num, tcp_ack_num, len);
>                 } else {
>                         debug_cond(DEBUG_WGET,
>                                    "wget: Connctd pkt %p  hlen %x\n",
>                                    pkt, hlen);
> +                       initial_data_seq_num = tcp_seq_num + hlen;
>
>                         pos = strstr((char *)pkt, content_len);
>                         if (!pos) {
> @@ -397,13 +395,9 @@ static void wget_handler(uchar *pkt, u16 dport,
>                            "wget: Transferring, seq=%x, ack=%x,len=%x\n",
>                            tcp_seq_num, tcp_ack_num, len);
>
> -               if (next_data_seq_num != tcp_seq_num) {
> -                       debug_cond(DEBUG_WGET, "wget: seq=%x packet was lost\n", next_data_seq_num);
> -                       return;
> -               }
> -               next_data_seq_num = tcp_seq_num + len;
> -
> -               if (store_block(pkt, tcp_seq_num - initial_data_seq_num, len) != 0) {
> +               if (tcp_seq_num >= initial_data_seq_num &&
> +                   store_block(pkt, tcp_seq_num - initial_data_seq_num,
> +                               len) != 0) {
>                         wget_fail("wget: store error\n",
>                                   tcp_seq_num, tcp_ack_num, action);
>                         net_set_state(NETLOOP_FAIL);
> --
> 2.34.1
>
