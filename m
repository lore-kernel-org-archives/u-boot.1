Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF305C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C34688232;
	Fri, 26 Apr 2024 16:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d0cx6Tu/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59D2788233; Fri, 26 Apr 2024 16:52:16 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E9088231
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5176f217b7bso3954782e87.0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714143133; x=1714747933; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9RpfaeB2vq0SjZNqzOr+riQeKxus54Gtbizdj1GUORE=;
 b=d0cx6Tu/Qy+vkGMKf9ZdJuUjk0fq14D7voL781rcsgQCtT5f6Cc/ZV/1cQhsFSS0kZ
 kr8eKZqQYsQ3pz4/8xl+60P0Ofmuzbi8hti7uYxNmKYNlr3u+MU3NfSuJW1VGvRNiHQf
 97wV4KjnCCeXsyxPLK1ONR+hqvEOVSQLFfJqT9eV0yTJJJDFMg5OMbs1CawGuLDXedy7
 HkZzQ+t6OnCMZCk1XHXEe7ABsbuJbI3gTmpdFhZSYcqrqr5ExC2UXdk5CaUCfCtCECVW
 7PB5FH9dt2D2wZVm/BxyzyN4buRlw3NUptRxwDvy50t9MkminN+S/KfeX1fQwUq1sqfu
 5fcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714143133; x=1714747933;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9RpfaeB2vq0SjZNqzOr+riQeKxus54Gtbizdj1GUORE=;
 b=D6mT4IkVqDBtpWosdtj9+rHGXPNyYK1dIy0WUL0mFPCIzzziQ5ZvHvUz6Ic8HS0MOc
 f+FKRcGaJ8oCMkMl5TJk+AY3qfUy1Gl9xXubbD/cMQCUwzwiT1FIpbLuFVjdjyU4yEyB
 zVr0QuhNx35Lpfj5JEvVldxCrFGmdIVwTC6aWIU215ZYUHUNv4rF5APnxWpjZ1JOpaos
 kJwAcE9I57YX7xzOMz7EKoz9pzvlyAGXuK9MJA8orhRsR4uVcuko5P5su1j6aQDqKLLm
 eXUu6Z4R3OOh+ahA4OSQCnsmte05ILZWnnjy1ghmXD2vOerhSnaaBY7o8tQY3LdIKX2x
 xJoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWRP71H+1vaLBuXaRSbBftBikpC1r0QrRLzW//SKpKsz7kpQdmRGv6AqP6mEWbad5/8E3YGK+GKlseg3eGcbOkc/++aA==
X-Gm-Message-State: AOJu0YzDD8I34N46MYY9PaxkbEnVgZg1ykvnKSrZEP+PTpe038wLw1wO
 dt1z3Y8l0LdxMuk4txCXvS2RWzkol86KpvoKH99zD+06Be+esDrwIDr77gBEEKc=
X-Google-Smtp-Source: AGHT+IFqiF+ydz/5RVBeMsYiP0OBhIrO6zto9YUNNap9rMycOrhWT5BTcilWscABCwynGeWTACc/Qw==
X-Received: by 2002:ac2:4989:0:b0:51b:528e:ce7d with SMTP id
 f9-20020ac24989000000b0051b528ece7dmr1895884lfl.34.1714143133083; 
 Fri, 26 Apr 2024 07:52:13 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::9b06? ([2a02:8109:aa0d:be00::9b06])
 by smtp.gmail.com with ESMTPSA id
 em3-20020a170907288300b00a5871e215c8sm5091828ejc.127.2024.04.26.07.52.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 07:52:12 -0700 (PDT)
Message-ID: <6440a35f-1dfd-4eac-b59d-dc49e25e1ee7@linaro.org>
Date: Fri, 26 Apr 2024 16:52:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 11/14] efi_loader: move distro_efi_get_fdt_name()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-12-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240426141321.232236-12-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Heinrich,

On 26/04/2024 16:13, Heinrich Schuchardt wrote:
> Move distro_efi_get_fdt_name() to a separate C module
> and rename it to efi_get_distro_fdt_name().
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   boot/bootmeth_efi.c      | 60 ++-------------------------------
>   include/efi_loader.h     |  2 ++
>   lib/efi_loader/Makefile  |  1 +
>   lib/efi_loader/efi_fdt.c | 73 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 78 insertions(+), 58 deletions(-)
>   create mode 100644 lib/efi_loader/efi_fdt.c
> 
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index aebc5207fc0..40da77c497b 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -144,62 +144,6 @@ static int distro_efi_check(struct udevice *dev, struct bootflow_iter *iter)
>   	return 0;
>   }
>   
> -/**
> - * distro_efi_get_fdt_name() - Get the filename for reading the .dtb file
> - *
> - * @fname: Place to put filename
> - * @size: Max size of filename
> - * @seq: Sequence number, to cycle through options (0=first)
> - * Returns: 0 on success, -ENOENT if the "fdtfile" env var does not exist,
> - * -EINVAL if there are no more options, -EALREADY if the control FDT should be
> - * used
> - */
> -static int distro_efi_get_fdt_name(char *fname, int size, int seq)
> -{
> -	const char *fdt_fname;
> -	const char *prefix;
> -
> -	/* select the prefix */
> -	switch (seq) {
> -	case 0:
> -		/* this is the default */
> -		prefix = "/dtb";
> -		break;
> -	case 1:
> -		prefix = "";
> -		break;
> -	case 2:
> -		prefix = "/dtb/current";
> -		break;

This is a bit of a tangential point (and shouldn't block this series at 
all). But where do we find a balance with this search algorithm? The 
distro I work on (postmarketOS) actually installs DTB files to "/dtbs" 
(not "/dtb").

No doubt we can come up with a bunch of clever ideas for optimising this 
with wildcards or whatever, but is that something we want to implement?

What about distros that support falling back to previous kernel versions 
(and consequently have the DTB dir named after the kernel version).

Presumably in these situations the distro would have systemd-boot, GRUB, 
etc. Would it make sense to just inform the bootloader what the .dtb 
file name is so that they can handle the path building?

(I understand there are other usecases and reasons to load the DTB ahead 
of time in U-Boot).
> -	default:
> -		return log_msg_ret("pref", -EINVAL);
> -	}
> -
> -	fdt_fname = env_get("fdtfile");
> -	if (fdt_fname) {
> -		snprintf(fname, size, "%s/%s", prefix, fdt_fname);
> -		log_debug("Using device tree: %s\n", fname);
> -	} else if (IS_ENABLED(CONFIG_OF_HAS_PRIOR_STAGE)) {
> -		strcpy(fname, "<prior>");
> -		return log_msg_ret("pref", -EALREADY);
> -	/* Use this fallback only for 32-bit ARM */
> -	} else if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)) {
> -		const char *soc = env_get("soc");
> -		const char *board = env_get("board");
> -		const char *boardver = env_get("boardver");
> -
> -		/* cf the code in label_boot() which seems very complex */
> -		snprintf(fname, size, "%s/%s%s%s%s.dtb", prefix,
> -			 soc ? soc : "", soc ? "-" : "", board ? board : "",
> -			 boardver ? boardver : "");
> -		log_debug("Using default device tree: %s\n", fname);
> -	} else {
> -		return log_msg_ret("env", -ENOENT);
> -	}
> -
> -	return 0;
> -}
> -
>   /*
>    * distro_efi_try_bootflow_files() - Check that files are present
>    *
> @@ -241,7 +185,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
>   	ret = -ENOENT;
>   	*fname = '\0';
>   	for (seq = 0; ret == -ENOENT; seq++) {
> -		ret = distro_efi_get_fdt_name(fname, sizeof(fname), seq);
> +		ret = efi_get_distro_fdt_name(fname, sizeof(fname), seq);
>   		if (ret == -EALREADY)
>   			bflow->flags = BOOTFLOWF_USE_PRIOR_FDT;
>   		if (!ret) {
> @@ -340,7 +284,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
>   	sprintf(file_addr, "%lx", fdt_addr);
>   
>   	/* We only allow the first prefix with PXE */
> -	ret = distro_efi_get_fdt_name(fname, sizeof(fname), 0);
> +	ret = efi_get_distro_fdt_name(fname, sizeof(fname), 0);
>   	if (ret)
>   		return log_msg_ret("nam", ret);
>   
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 0ac04990b8e..ed2b517b130 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1187,4 +1187,6 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
>    */
>   void efi_add_known_memory(void);
>   
> +int efi_get_distro_fdt_name(char *fname, int size, int seq);
> +
>   #endif /* _EFI_LOADER_H */
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 034e366967f..2af6f2066b5 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -59,6 +59,7 @@ obj-y += efi_device_path.o
>   obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_device_path_to_text.o
>   obj-$(CONFIG_EFI_DEVICE_PATH_UTIL) += efi_device_path_utilities.o
>   obj-y += efi_dt_fixup.o
> +obj-y += efi_fdt.o
>   obj-y += efi_file.o
>   obj-$(CONFIG_EFI_LOADER_HII) += efi_hii.o
>   obj-y += efi_image_loader.o
> diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
> new file mode 100644
> index 00000000000..0edf0c1e2fc
> --- /dev/null
> +++ b/lib/efi_loader/efi_fdt.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Bootmethod for distro boot via EFI
> + *
> + * Copyright 2021 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + */
> +
> +#include <efi_loader.h>
> +#include <env.h>
> +#include <errno.h>
> +#include <log.h>
> +#include <string.h>
> +#include <vsprintf.h>
> +
> +/**
> + * distro_efi_get_fdt_name() - get the filename for reading the .dtb file
> + *
> + * @fname:	buffer for filename
> + * @size:	buffer size
> + * @seq:	sequence number, to cycle through options (0=first)
> + *
> + * Returns:
> + * 0 on success,
> + * -ENOENT if the "fdtfile" env var does not exist,
> + * -EINVAL if there are no more options,
> + * -EALREADY if the control FDT should be used
> + */
> +int efi_get_distro_fdt_name(char *fname, int size, int seq)
> +{
> +	const char *fdt_fname;
> +	const char *prefix;
> +
> +	/* select the prefix */
> +	switch (seq) {
> +	case 0:
> +		/* this is the default */
> +		prefix = "/dtb";
> +		break;
> +	case 1:
> +		prefix = "";
> +		break;
> +	case 2:
> +		prefix = "/dtb/current";
> +		break;
> +	default:
> +		return log_msg_ret("pref", -EINVAL);
> +	}
> +
> +	fdt_fname = env_get("fdtfile");
> +	if (fdt_fname) {
> +		snprintf(fname, size, "%s/%s", prefix, fdt_fname);
> +		log_debug("Using device tree: %s\n", fname);
> +	} else if (IS_ENABLED(CONFIG_OF_HAS_PRIOR_STAGE)) {
> +		strcpy(fname, "<prior>");
> +		return log_msg_ret("pref", -EALREADY);
> +	/* Use this fallback only for 32-bit ARM */
> +	} else if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)) {
> +		const char *soc = env_get("soc");
> +		const char *board = env_get("board");
> +		const char *boardver = env_get("boardver");
> +
> +		/* cf the code in label_boot() which seems very complex */
> +		snprintf(fname, size, "%s/%s%s%s%s.dtb", prefix,
> +			 soc ? soc : "", soc ? "-" : "", board ? board : "",
> +			 boardver ? boardver : "");
> +		log_debug("Using default device tree: %s\n", fname);
> +	} else {
> +		return log_msg_ret("env", -ENOENT);
> +	}
> +
> +	return 0;
> +}

-- 
// Caleb (they/them)
