Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BCDD2E9E4
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 12:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C39C88FAF;
	Mon, 11 Nov 2024 13:47:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z47oom6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 114AE89275; Mon, 11 Nov 2024 13:47:53 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B746B88C4C
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20c693b68f5so45490635ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 04:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731329269; x=1731934069; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zKtT7WX4g6Nc85D7/Lwu8bkRgM/NE8f62PJWIR5GsiY=;
 b=Z47oom6c0LPsXOw2gufjwBkqtSya3yKJxI64bAj1vPHhDS8Wg4otBnsoFE2vCo/kQv
 eBmxv5E5jFqMV7tKzE9JAPXqXmrOJnDJHyQr8RokH8EAWp/ssNTVpHtbBigZCMCcBTnJ
 hAh42hKHbV592xLxiyIrY279HSiCUs9pjmnXk7A84pPaNfBc76/dHtOtzT7PBVp6fY5w
 BCJ2lLDcvfY8cDUzgg6puE/78xMPpXLO3otC1Y2PZxKYt0ZMdfc8Y4kigJDHeF1aFKlV
 WtwChwhjpsZ0Ol+/AvXH+1EEZj3qTyJmp9c48jcPa7MsymOv7VMVvODBEnC3E/AT4C9B
 PK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731329269; x=1731934069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zKtT7WX4g6Nc85D7/Lwu8bkRgM/NE8f62PJWIR5GsiY=;
 b=qEJ1PUDM0n45oNNovzMZsppRMB0EZ4KvPTLmkvKdMzBABKask4MRZU5VXTmuVN9xeI
 eju/oS6CUVH0IxtnoT72AkqAXVRNmPD6S2hUPtRvYROgSw6eySNkAQ41W6pyo1ZzMe4Z
 dAqZ6lP7I3QQhj5rODx39HRtKWHwtZvEHdpnS44yKYJkgkJv9U/64qfUO2zH97fKcJh0
 2WRwb4LGp8Jur2EzDTb9Zp/jROOW7yGpfKNX1qZ4Bezi9BqdcNgt9HE03FnJh/4vxdJ6
 26JAh5M/1ZUZ1VU+T1rBpIuzuqnog6n6lCiDyrboetQUOk3t2ubyU8wWOmTpm7j0STSL
 Apfw==
X-Gm-Message-State: AOJu0YzLm47KP4Ju4YTcGYi0QofroRakF2qsoZgzjPx/PhJvt40lLeNb
 UriiWdEjuxFYs8GI6qbUtuf7p9ffu0TzKUnysRZUAczxeepSFg4FB0xm44TygCWVJZ6LnzQewtP
 OnqWIBmFzxGa3wYJkFP3MRnY75/5uwT65kUG89w==
X-Google-Smtp-Source: AGHT+IHWMtib5YGZOFLijfzlgVp8/vNHA8NYmDWedZmLfyaY42QdQV1yse9DRphsfUGH6bpJ7RzElG3dk4zM82B9seo=
X-Received: by 2002:a17:90b:1807:b0:2e2:cd79:ec06 with SMTP id
 98e67ed59e1d1-2e9b16955c6mr18842725a91.10.1731329269245; Mon, 11 Nov 2024
 04:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20241105110849.41348-1-jerome.forissier@linaro.org>
In-Reply-To: <20241105110849.41348-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 14:47:13 +0200
Message-ID: <CAC_iWjKhO3FnjbAYujbyp5kdfs7w2GLJ6hoyEtK19nh0UHXe5g@mail.gmail.com>
Subject: Re: [PATCH] nwt: wget: drop Content-Length processing
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Jerome,

On Tue, 5 Nov 2024 at 13:09, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> We don't do anything with Content-Length except a debug print, and the
> strict_strtoul() call is incorrect (it always returns -EINVAL and leaves
> content_length to zero due to the presence of trailing characters after
> the decimal valuoe of Content-Length). So let's just drop this piece of
> code.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/wget.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/net/wget.c b/net/wget.c
> index 635f82efbb3..361817ace65 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -26,7 +26,6 @@ static const char bootfile1[] = "GET ";
>  static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
>  static const char http_eom[] = "\r\n\r\n";
>  static const char http_ok[] = "200";
> -static const char content_len[] = "Content-Length";
>  static const char linefeed[] = "\r\n";
>  static struct in_addr web_server_ip;
>  static int our_port;
> @@ -46,7 +45,6 @@ struct pkt_qd {
>  #define PKTQ_SZ (PKTBUFSRX / 4)
>  static struct pkt_qd pkt_q[PKTQ_SZ];
>  static int pkt_q_idx;
> -static unsigned long content_length;
>  static unsigned int packets;
>
>  static unsigned int initial_data_seq_num;
> @@ -251,17 +249,6 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>                                    "wget: Connected Pkt %p hlen %x\n",
>                                    pkt, hlen);
>
> -                       pos = strstr((char *)pkt, content_len);
> -                       if (!pos) {
> -                               content_length = -1;
> -                       } else {
> -                               pos += sizeof(content_len) + 2;
> -                               strict_strtoul(pos, 10, &content_length);
> -                               debug_cond(DEBUG_WGET,
> -                                          "wget: Connected Len %lu\n",
> -                                          content_length);

How much work would it be to fix the parsing properly? We could look
into that value and drop it if the memory is > our available memory

Thanks
/Ilias
> -                       }
> -
>                         net_boot_file_size = 0;
>
>                         if (len > hlen) {
> --
> 2.40.1
>
