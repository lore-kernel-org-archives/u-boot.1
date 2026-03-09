Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFBAF3C245
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 12:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FB583BC7;
	Mon,  9 Mar 2026 13:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eap5O7CH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CC5D83F14; Mon,  9 Mar 2026 13:23:58 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A7028063E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 13:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9871A3F16E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1773059035;
 bh=PdL7DI1MP9Z3DtRuaq/29Y7eHExWoYqEE8kIDuXeG7E=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=eap5O7CHuw9l91aPGhIpFy1xjBkwDH5pUGi3cPbvsfqHhbEnZdu0UX4KFM9yRieBu
 WTAkbfvibzTOuDiq+6Dt1aCywJLTYVjTBsByToqOl9eIVAZqBkzUf1Qs23rxqqyNbp
 r5v5A14ZHR1VTHwPIrNOgIKYe1uBhj6IyR5TrTK4jhsuMdmr9XnKydt942J1LKmsij
 gVhPXx5UvFPPhVMLrMmtjB9RPehM7/FuxVhHPmAgkLmSNb4o28j8qxOohvSOOkZ69b
 1W+/4zA5h7wkDjg6yb/UlofJnh2AESzyelta6/njuZpHsz7Y7tdGlKWr1iUn80fqTw
 jVNY0rR/weayNwt2iAse9xYMbmk2LIMdDTvKtRwJ+E/RJ7OTsnFL7y2+EcxaeevRPt
 9dkQQtc4CAJKFpX9KznNp52iQZuj95EVjCkJWxFn2ACz+WEmSMLNEoStd7b1ognMMa
 swuYKFOlSoG4la82pxOpt3q1d6Ea3aogm7NWU9b/tfETsvrqB0R8BpMzWlnINE9/+B
 CqzH0z2dAE3QRO+vkMQjBcclwZN7t2YxQEs/qtFfkw7s0WXriWxUNx2Ku75Cox06SF
 WvmuXj7WVM4aNKgud7o0S9xPezyruzjXZdn5TxvCPBuWQoRY9PvjAXTVbrUamx0eg1
 210qWyNhWATy/zSR9AE92QaA=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4853a9467c5so6176925e9.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 05:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773059035; x=1773663835;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PdL7DI1MP9Z3DtRuaq/29Y7eHExWoYqEE8kIDuXeG7E=;
 b=PsT3FCtNrDDgWqkJ8kEYoDxSDhsBCOdF+5AeF3ncSej3P3hJkVh6rAWErQlGYCSEQI
 Agayx16BO0s4Uea0PrzDoPJP2iu/vKwwOF3fx/CN7U3Dpopumm3S0JkKRctuyPxPWcXv
 JrGwq/DUqTd5kuNL3sF0fpa4WY0qPuN6F4uJdVDozI2xVPnmjDuJR4+GZmRSNWxrmCse
 HRv6XwHz6IRcnUIAajmjUEs49XedX0gmaEtI8MuMk9LEax7BRsfuxk2eXWmD0EDqoR/g
 4Ly31IAYTR9EEVCGcyyVoTMaOxnxZ9lVgsBQ1goXsae1PtZ6ZboDr/v0YPe55TrMmRq6
 0b4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSsOxhgRKOBAq6Bo8a4j0f1zMLIFPS3pkNWyVCICJSlTOYk9VIuGFNMBhF19MRte7o4n77Hoc=@lists.denx.de
X-Gm-Message-State: AOJu0YxoJFK/osWftXJxeBMByoXvCkdo3R/8TCmoPR/CKFJBLrE0Pd+k
 Fkdl5+BWrhaYRiQxvfQu2q08IhCq4tyGVb1Jb4qXGYZHJaBJ7RESDwpetEN0sQLL33dLnw4KY61
 m5ZAUEjqOGGgUkyAW+00IGYTsfW+e3Yc5KBzczCtTff+DXcokIp+N14gBVqjmteRW0aTrHj0=
X-Gm-Gg: ATEYQzwhfSDM8tNFgEcYEWRqizVkAP4c2T5CezvBG+xTkXVCv9UDORs5+18VmTBPzm8
 WfMwFfEw3d4FJ/0GjQCoaSx66jO26XqjtALhaPkeoJRSdusqznyH43G88UrQ6wQWHKOY+Foa8AM
 S6z35aJa3yNtzS3Os7B8IZoG8XkmzV5ACx+bHcOaiLmGgbWRshiojtcrHBwiH+AYClEoUyhCZ5A
 90Mdvviejzl2oPlrMBCZfiORgszyHASi9K0t582oIB2JYCOeeFsO7EwS4PA8TKBeHBUaF3A5sxE
 E3eun5QahcHPMP/PhJMAKs+egiphOAvRw8uq37JmrmeWQaAuMXTsB+vp9BPdDXSLfPBkyO32PIq
 OP5j8OWNIr9twJ+/hx8j7Unm64AWslj4dp9EwNBjXUAtac+S8exFIX8TV9QHO2cPjGL+6x+Rcjs
 lWPH7FqcesMyKPP83LEH9cBi1abI1LcY1hjQ==
X-Received: by 2002:a05:600c:1e85:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-4852691c657mr184407425e9.6.1773059035143; 
 Mon, 09 Mar 2026 05:23:55 -0700 (PDT)
X-Received: by 2002:a05:600c:1e85:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-4852691c657mr184406875e9.6.1773059034711; 
 Mon, 09 Mar 2026 05:23:54 -0700 (PDT)
Received: from [192.168.103.129]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb3668csm537989115e9.13.2026.03.09.05.23.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 05:23:54 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <a0d7e83b-1721-41c6-a416-cc88af49bb22@gmx.de>
Date: Mon, 9 Mar 2026 13:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cmd: efidebug: add ecpt command
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
 <20260305161349.2317130-4-vincent.stehle@arm.com>
Content-Language: en-US
In-Reply-To: <20260305161349.2317130-4-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/5/26 17:13, Vincent Stehlé wrote:
> Add an "efidebug ecpt" command, to print the conformance profiles in the
> ECPT:
> 
>    => efidebug ecpt
>    cce33c35-74ac-4087-bce7-8b29b02eeb27  EFI EBBR 2.1 Conformance Profile
> 
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   cmd/efidebug.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
> index 109496d9e95..672214a54b7 100644
> --- a/cmd/efidebug.c
> +++ b/cmd/efidebug.c
> @@ -533,6 +533,47 @@ static int do_efi_show_defaults(struct cmd_tbl *cmdtp, int flag,
>   	return CMD_RET_SUCCESS;
>   }
>   
> +#if CONFIG_IS_ENABLED(EFI_ECPT)
> +/**
> + * do_efi_show_ecpt() - show UEFI conformance profiles in ECPT
> + *
> + * @cmdtp:	Command table
> + * @flag:	Command flag
> + * @argc:	Number of arguments
> + * @argv:	Argument array
> + * Return:	CMD_RET_SUCCESS on success,
> + *		CMD_RET_USAGE or CMD_RET_FAILURE on failure
> + *
> + * Implement efidebug "ecpt" sub-command.
> + * Show all the UEFI Conformance Profiles listed in the EFI Conformance Profiles
> + * Table (ECPT).
> + */
> +static int do_efi_show_ecpt(struct cmd_tbl *cmdtp, int flag, int argc,
> +			    char *const argv[])
> +{
> +	const struct efi_conformance_profiles_table *ecpt;
> +	u16 n;
> +
> +	if (argc != 1)
> +		return CMD_RET_USAGE;
> +
> +	ecpt = efi_get_configuration_table(&efi_ecpt_guid);
> +	if (!ecpt) {
> +		log_info("ECPT: table not present\n");

This looks like an error situation. Should this be:

	log_err("ECPT table missing\n");

> +		return CMD_RET_SUCCESS;
> +	}
> +
> +	for (n = 0; n < ecpt->number_of_profiles; n++) {
> +		const efi_guid_t *guid = &ecpt->conformance_profiles[n];
> +
> +		printf("%pUl  %s\n", guid->b,
> +		       uuid_guid_get_str(guid->b) ?: "(unknown)");

Isn't the following enough:

	printf("%pUs\n");

%pUs:   GUID text representation if known or fallback to %pUl

Best regards

Heinrich

> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> +#endif /* CONFIG_IS_ENABLED(EFI_ECPT) */
> +
>   static const char * const efi_mem_type_string[] = {
>   	[EFI_RESERVED_MEMORY_TYPE] = "RESERVED",
>   	[EFI_LOADER_CODE] = "LOADER CODE",
> @@ -1586,6 +1627,10 @@ static struct cmd_tbl cmd_efidebug_sub[] = {
>   			 "", ""),
>   	U_BOOT_CMD_MKENT(defaults, CONFIG_SYS_MAXARGS, 1, do_efi_show_defaults,
>   			 "", ""),
> +#if CONFIG_IS_ENABLED(EFI_ECPT)
> +	U_BOOT_CMD_MKENT(ecpt, CONFIG_SYS_MAXARGS, 1, do_efi_show_ecpt,
> +			 "", ""),
> +#endif
>   	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_show_images,
>   			 "", ""),
>   	U_BOOT_CMD_MKENT(memmap, CONFIG_SYS_MAXARGS, 1, do_efi_show_memmap,
> @@ -1680,6 +1725,10 @@ U_BOOT_LONGHELP(efidebug,
>   	"  - show UEFI handles\n"
>   	"efidebug defaults\n"
>   	"  - show default EFI filename and PXE architecture\n"
> +#if CONFIG_IS_ENABLED(EFI_ECPT)
> +	"efidebug ecpt\n"
> +	"  - show conformance profiles in the ECPT\n"
> +#endif
>   	"efidebug images\n"
>   	"  - show loaded images\n"
>   	"efidebug memmap\n"

