Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD79C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 09:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E68B1810F2;
	Thu, 20 Mar 2025 10:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0XjVp6ba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1A0B81101; Thu, 20 Mar 2025 10:25:39 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F4DB809D4
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 10:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so4742765e9.1
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 02:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742462737; x=1743067537;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7UjcEo4atXR20xnpU9tOPNzOstYOc3S3BrWPfLvWp28=;
 b=0XjVp6baEzniEh8wseBohPXYEQOHzpXTsl2tx/znqYKQ0HDMTXW0PZAQ7Flk/PSeV7
 l8bvVq7l2LCNfjY/xelpzdVToRI70E1u+8AJ2Bn++3jMoPgQJrSELAVHyH38WCNedCcp
 jdle6ilJrMWNMZ7phLWs4KoR9aepAigKE7OZpCD9mIQTUKqvyb7nD8NSLmAR8O3PnjSf
 6MpFi8VEpRjoeFgyTYWcJ/GRMGvHBuKFqgFdzlnayYT1fQJYnIeFMZKlVzk2poFPs60D
 xLebYo5zas76KrXZNXnjaWxFZzw9XVsZt8lRXPmLDsKLsFsbuTsZvNIKQQ78R2e+IkLm
 bVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742462737; x=1743067537;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7UjcEo4atXR20xnpU9tOPNzOstYOc3S3BrWPfLvWp28=;
 b=uYHJ/YJr3soKFqMAXL1g5vpuWdh/5vpLz1e1o01tomNl39TenRbnAGULh/563GVsD5
 /W4Tdo687o2zWdz3Reo8JC2Z+/laCpil7tq5IJhm3aex3yp4fqNIB/kOUIPD0zYuBIwt
 hoHcRRpg2I+KsgqI1n2138FxPxi0BDmwh6Jp+muPsAmZNjlmZOBz5b004w9dr/Cq7P5I
 Kkuf5sbLU6YWk6/KDJpC9tmSqJMSt5zaZGiCkGP5wTA0iMJb+oIJe3+WZFzM1cQlT5LC
 ueCmH60hfdHBZYxsA1jrhWEkGdiYjFZKRF+0Fn7Omj9a8Eh7mgAG1rjqlkyIdcDi3dj6
 hU2Q==
X-Gm-Message-State: AOJu0YzXTs6hbJlBa3zXG2R44udxHrM3gTMOgHlTsNR3NJBZONeE0TB0
 ykLN+bPB0Esgcv3rvymytQMymdAx9is6DPgvsHT9XvcuErkMI3W+x+vkeKgiySE=
X-Gm-Gg: ASbGncvoGUkYpt2pXZujOqJUqDVvvm1nhtIn6fWx24WOXN2TlI0wt0VffE9hT4Ny+e4
 5CUqCSqzqTYN/ASmg3/Iv6J9tEisE7LT9f0rnNveoulboJ5WsNwLzrOR+NSqRpzzD6u2zlKsi63
 yftF4VcAP2cwprPGFfSy5gtS34xp7Yx/hZY4YGj+06vCGuLpXa1Obb0LpguOEW2+FFxJBorMOTj
 mAo1OcVpxP77syVd6tKj8/YO80LqiBskrwoanQ3Xqn2lY77tSrCUVVUkcdhq80E9QbvTj67zIx1
 4shqnsCCFEF/FvY5jMGRAfOybxP4AsaHT/IMvPox4hUJGT3c
X-Google-Smtp-Source: AGHT+IFGvJRz9Su8ZreUTmeUM7UBc0IlDxUA21Ou5fDcVPNtx6A26Q+zwdewmu2dlKtSVXYbTopx6w==
X-Received: by 2002:a05:600c:34d5:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-43d4379615bmr53747055e9.13.1742462736804; 
 Thu, 20 Mar 2025 02:25:36 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43d803f6sm43625045e9.0.2025.03.20.02.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 02:25:35 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Michael Walle <mwalle@kernel.org>, Tom Rini <trini@konsulko.com>, Jerome
 Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH 1/3] fastboot: lift restrictions on !NET_LWIP for USB
In-Reply-To: <20250312073655.2281377-1-mwalle@kernel.org>
References: <20250312073655.2281377-1-mwalle@kernel.org>
Date: Thu, 20 Mar 2025 10:25:31 +0100
Message-ID: <87cyecdpf8.fsf@baylibre.com>
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

Hi Michael,

Thank you for the patch.

On mer., mars 12, 2025 at 08:36, Michael Walle <mwalle@kernel.org> wrote:

> Fastboot works either over TCP, UDP or USB. The latter doesn't have
> anything to do with networking, thus should work just fine with
> regardless which network stack is selected. In practice, header symbols
> are used inside common code paths. Add some ifdeffery to guard against
> that.
>
> This will make fastboot over USB work with the new LWIP stack.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

checkpatch.pl reports some issues with this:

$ ./scripts/checkpatch.pl --strict --u-boot --git HEAD^..HEAD

<snip>
WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
<snip>

Some occurences below could be fixed. Could you please have a look?

> ---
> Alternatively, we could add the defines and stub functions to the lwip
> header.
> ---
>  cmd/fastboot.c               | 4 ++++
>  drivers/fastboot/Kconfig     | 1 -
>  drivers/fastboot/fb_common.c | 4 ++++
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> index d4cfc0c7a28..be84a482b81 100644
> --- a/cmd/fastboot.c
> +++ b/cmd/fastboot.c
> @@ -16,6 +16,7 @@
>  #include <linux/printk.h>
>  #include <linux/stringify.h>
>  
> +#if CONFIG_IS_ENABLED(NET)

I think this can be dropped. I hope that since it's a static function,
-if there are no users in the file- the compiler will optimize it out.
Note: I have not verified this, so I might be wrong.

If you measure and see size changes between keeping the #if and not
keeping it, please ignore this comment.

>  static int do_fastboot_udp(int argc, char *const argv[],
>  			   uintptr_t buf_addr, size_t buf_size)
>  {
> @@ -55,6 +56,7 @@ static int do_fastboot_tcp(int argc, char *const argv[],
>  
>  	return CMD_RET_SUCCESS;
>  }
> +#endif
>  
>  static int do_fastboot_usb(int argc, char *const argv[],
>  			   uintptr_t buf_addr, size_t buf_size)
> @@ -160,10 +162,12 @@ NXTARG:
>  
>  	fastboot_init((void *)buf_addr, buf_size);
>  
> +#if CONFIG_IS_ENABLED(NET)
>  	if (!strcmp(argv[1], "udp"))
>  		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
>  	if (!strcmp(argv[1], "tcp"))
>  		return do_fastboot_tcp(argc, argv, buf_addr, buf_size);
> +#endif

This can be replaced with:

	if (IS_ENABLED(CONFIG_NET)) {
		if (!strcmp(argv[1], "udp"))
			return do_fastboot_udp(argc, argv, buf_addr, buf_size);
		if (!strcmp(argv[1], "tcp"))
			return do_fastboot_tcp(argc, argv, buf_addr, buf_size);
	}

>  	if (!strcmp(argv[1], "usb")) {
>  		argv++;
>  		argc--;
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 1eb460f5a02..70207573de2 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -1,6 +1,5 @@
>  menu "Fastboot support"
>  	depends on CMDLINE
> -	depends on !NET_LWIP
>  
>  config FASTBOOT
>  	bool
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 12ffb463deb..68f92c4b887 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -183,11 +183,15 @@ void fastboot_handle_boot(int command, bool success)
>  	switch (command) {
>  	case FASTBOOT_COMMAND_BOOT:
>  		fastboot_boot();
> +#if CONFIG_IS_ENABLED(NET)
>  		net_set_state(NETLOOP_SUCCESS);
> +#endif

This can be replaced with:

		if (IS_ENABLED((CONFIG_NET))
		    net_set_state(NETLOOP_SUCCESS);

>  		break;
>  
>  	case FASTBOOT_COMMAND_CONTINUE:
> +#if CONFIG_IS_ENABLED(NET)
>  		net_set_state(NETLOOP_SUCCESS);
> +#endif

Same here.

>  		break;
>  
>  	case FASTBOOT_COMMAND_REBOOT:
> -- 
> 2.39.5
