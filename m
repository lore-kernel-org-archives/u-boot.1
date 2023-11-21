Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A774C54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 10:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D8387585;
	Tue, 21 Nov 2023 11:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HNI9Vgxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E4738758C; Tue, 21 Nov 2023 11:29:57 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FBE787595
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b26d700a1so5429625e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700562593; x=1701167393;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=g29+BSb4XPEOcy5eYdx42ykb5X7x+KYOzrWebkq+sI0=;
 b=HNI9VgxaoKOzqt0kcKvKbuPpLisLN/kojTQbDvJmxd7IGgoO/ywfRsNoaIb3jHWO8f
 YcOPneRPjd+nD4ehRGQWSh5rEQ4i26FmfMbOdnL/jbTtNXE9qbsxINbRRj1+7drRWNrF
 C9FPHW5QFJJNZyjNoFLK3B2h/nxmCyGEbPB07P96BlsOJMLksnbv9VHrE/ZITjySvMuO
 OF5J3vDED4z3Y3ElHfc7Sn4pTiuY/y+h5+vCxKUpUn3UHQL8xN9XaWQnPjsGDnFUaTAV
 y8j9BaUBFFB61sdx8DZBHDkuhPaV5Yo73bmuv2c/DdhDK1r6ppeG2ip/Ww343h2lg2un
 lp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700562593; x=1701167393;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g29+BSb4XPEOcy5eYdx42ykb5X7x+KYOzrWebkq+sI0=;
 b=AqjCYoXH43qLkVrgd9kqNERub0HCInlJHNNywlgujDVlyHzPx5T9n45uFzyuHqRsFC
 g3y6Xcfq09G25tf/WebBC8VBZsMQ7NSblB9Mml4KQ1BZTOk6uZ8HMHz58croSQmCy0ah
 T0eHwbAA3O+MF2CzqYE+V2QitGNGFI/6gWM/sq63KHjHJ39XVFQ0i3LU63VmqSVmCLuX
 +zqHaDJKII/4BdMCQs7Wj1ucxcGHDpvTuwM77tdDwJO/uWnx0/XRGRz5QAY1P0o3c54C
 2Tgzqm3kAQBeuJudPmmrcIe6WWg9OydBxr8FYRFOgxF3tWuuP2hvNa0yAPybQpMmIHUq
 R2aQ==
X-Gm-Message-State: AOJu0YygRfpRqjPYOT0/7hXA8SAaR3DkB3gLaLloA1CFmabenoCjdFLr
 goDE+8KQqvXwcq2+vezWG4Q5yA==
X-Google-Smtp-Source: AGHT+IFfjiUjCNmgASjyKVr5ozw+jS+gWYNcDWp+P0hjIny0Ud9/bgYt/BOhPGeDTAX4h/pJPefdeQ==
X-Received: by 2002:a05:600c:444d:b0:409:79cb:81a3 with SMTP id
 v13-20020a05600c444d00b0040979cb81a3mr7237019wmn.30.1700562592877; 
 Tue, 21 Nov 2023 02:29:52 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 21-20020a05600c229500b004090798d29csm16210782wmf.15.2023.11.21.02.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 02:29:52 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, Svyatoslav
 Ryhel <clamor95@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>, Heiko
 Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/5] lib: membuff: fix readline not returning line in
 case of overflow
In-Reply-To: <20231115153836.16537-5-clamor95@gmail.com>
References: <20231115153836.16537-1-clamor95@gmail.com>
 <20231115153836.16537-5-clamor95@gmail.com>
Date: Tue, 21 Nov 2023 11:29:51 +0100
Message-ID: <871qcjmmao.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Svyatoslav,

Thank you for your patch.

On mer., nov. 15, 2023 at 17:38, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> From: Ion Agorria <ion@agorria.com>
>
> If line overflows readline it will not be returned, fix this behavior,
> make it optional and documented properly.
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/bootmeth_extlinux.c | 2 +-
>  common/console.c         | 2 +-
>  include/membuff.h        | 5 +++--
>  lib/membuff.c            | 4 ++--
>  4 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
> index aa2a4591eb..ae0ad1d53e 100644
> --- a/boot/bootmeth_extlinux.c
> +++ b/boot/bootmeth_extlinux.c
> @@ -82,7 +82,7 @@ static int extlinux_fill_info(struct bootflow *bflow)
>  	log_debug("parsing bflow file size %x\n", bflow->size);
>  	membuff_init(&mb, bflow->buf, bflow->size);
>  	membuff_putraw(&mb, bflow->size, true, &data);
> -	while (len = membuff_readline(&mb, line, sizeof(line) - 1, ' '), len) {
> +	while (len = membuff_readline(&mb, line, sizeof(line) - 1, ' ', true), len) {
>  		char *tok, *p = line;
>  
>  		tok = strsep(&p, " ");
> diff --git a/common/console.c b/common/console.c
> index 8a869b137e..cd56035171 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -846,7 +846,7 @@ bool console_record_overflow(void)
>  int console_record_readline(char *str, int maxlen)
>  {
>  	return membuff_readline((struct membuff *)&gd->console_out, str,
> -				maxlen, '\0');
> +				maxlen, '\0', false);
>  }
>  
>  int console_record_avail(void)
> diff --git a/include/membuff.h b/include/membuff.h
> index 21051b0c54..4eba626ce1 100644
> --- a/include/membuff.h
> +++ b/include/membuff.h
> @@ -192,10 +192,11 @@ int membuff_free(struct membuff *mb);
>   * @mb: membuff to adjust
>   * @str: Place to put the line
>   * @maxlen: Maximum line length (excluding terminator)
> + * @must_fit: If true then str is empty if line doesn't fit
>   * Return: number of bytes read (including terminator) if a line has been
> - *	   read, 0 if nothing was there
> + *	   read, 0 if nothing was there or line didn't fit when must_fit is set
>   */
> -int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch);
> +int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit);
>  
>  /**
>   * membuff_extend_by() - expand a membuff
> diff --git a/lib/membuff.c b/lib/membuff.c
> index 36dc43a523..964e504d5b 100644
> --- a/lib/membuff.c
> +++ b/lib/membuff.c
> @@ -288,7 +288,7 @@ int membuff_free(struct membuff *mb)
>  			(mb->end - mb->start) - 1 - membuff_avail(mb);
>  }
>  
> -int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
> +int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch, bool must_fit)
>  {
>  	int len;  /* number of bytes read (!= string length) */
>  	char *s, *end;
> @@ -310,7 +310,7 @@ int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
>  	}
>  
>  	/* couldn't get the whole string */
> -	if (!ok) {
> +	if (!ok && must_fit) {
>  		if (maxlen)
>  			*orig = '\0';
>  		return 0;
> -- 
> 2.40.1
