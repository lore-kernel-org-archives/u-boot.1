Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CC6C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 10:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5084088A2F;
	Fri,  9 Aug 2024 12:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CSZPIyMJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82EA088BD6; Fri,  9 Aug 2024 12:51:25 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43FD8889F1
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 12:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d1bb65e906so1478013a91.3
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723200682; x=1723805482; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XwcjA/e74UfRO+6iCZSxhq/Vs7O1xjGNKgdrznMmjI8=;
 b=CSZPIyMJ35fWxi1g7Eur5MiJRpq2gE+29v/kLsgpgDQV6LIo2AwoS7veupIRN8eNhf
 ecEpqOw01Rkng9LJMEg4B5yOww7yVH+T+wUWMcXfAzexIYR1EuncsevweCFINk/K8ZYt
 FCSZ9ay9xIrvQDRdvCal6c8LQwlwANaGsA2iilsu9HoVzeFEWrzyLUNuElJRXey0OpVN
 pFbuKUhX9QHh/qYh0vumqYebYcY7hmBCJQ+U4ZY0jlmS0X0chdaZg9LhA5Njkj3ntwcA
 +IMMAdP/eLt81CCGheMJNK/lCj/YrqfOwOlvQ4wouCm4NeOIHWMOIv03Z+4zoMuAdLDK
 +agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723200682; x=1723805482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XwcjA/e74UfRO+6iCZSxhq/Vs7O1xjGNKgdrznMmjI8=;
 b=LZkxDyC04uddWW40/XF8nmR8vbl9BH52Ye+SUd7hk4DYHld/SPeoI2hqsRkfXdZUcs
 qVU1g0Y+B5kV32/QGYgISJSWWrK38voQbhWmtkrcn8rkAYuTA5y2KU68/5YH5XVjbGik
 GRmrGCLgkXugUNVmitEsrFkg41y1dI1Uvfu6eR8fsTxgJ5uA8vOf5nhotWnImK6SsQF9
 EAM1ynoszPenleXEbOHLySqS+myWOMmpRuFA6k7tVfvcCNMp1O2eBA3BcJUDCNv+jkO3
 jX0i1nonUtuLbiEZolmBYx6grR+zpHyNhtEO+57rI0GeeOv3N/eN/M9VgJUeA5gxcxzR
 EAaw==
X-Gm-Message-State: AOJu0Yz7DFnPL2DSZhV36kw/WBvFbssn1M+tI7xeAYldqQQUqThqf9UO
 s8amIh0UKQpa3GfeBuFlduPWiYHaRcuRGPGtbvsdMzi73R/MbO+v1LPchGXGn6vukSm7wqyPjQ3
 0HlX0uxrrXMcsp+vuuIllr3go4sIpXSw9ggPo1w==
X-Google-Smtp-Source: AGHT+IENO9cYFg8CrLvXw8Vt22mPkQ6uV0L3YurREch2idnQfvegtE7Fe3XZHiYZCPeIMvhXBXWlXTqI2PifBg94GcU=
X-Received: by 2002:a17:90b:f81:b0:2d1:b368:83d1 with SMTP id
 98e67ed59e1d1-2d1e805fb23mr1062809a91.30.1723200681328; Fri, 09 Aug 2024
 03:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <23a2099efe241dd512a615e51e85e1941fc20a0b.1723050310.git.jerome.forissier@linaro.org>
In-Reply-To: <23a2099efe241dd512a615e51e85e1941fc20a0b.1723050310.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 9 Aug 2024 13:50:45 +0300
Message-ID: <CAC_iWjK1+Lw0TXzUTQHrE3K12XfMtgoriEqZvEYYMohUcymCcw@mail.gmail.com>
Subject: Re: [PATCH v8 02/23] net: wget: removed unused function wget_success()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, Simon Glass <sjg@chromium.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
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

On Wed, 7 Aug 2024 at 20:12, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> wget_success() is used nowhere so remove it.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/wget.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/net/wget.c b/net/wget.c
> index f1dd7abeff6..0e4dc5159d0 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -199,13 +199,6 @@ void wget_fail(char *error_message, unsigned int tcp_seq_num,
>         wget_send(action, tcp_seq_num, tcp_ack_num, 0);
>  }
>
> -void wget_success(u8 action, unsigned int tcp_seq_num,
> -                 unsigned int tcp_ack_num, int len, int packets)
> -{
> -       printf("Packets received %d, Transfer Successful\n", packets);
> -       wget_send(action, tcp_seq_num, tcp_ack_num, len);
> -}
> -
>  /*
>   * Interfaces of U-BOOT
>   */
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
