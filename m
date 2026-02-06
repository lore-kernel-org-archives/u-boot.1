Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF95EB28D6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 08:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 525088382A;
	Fri,  6 Feb 2026 09:34:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dobho/aU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B2183A64; Fri,  6 Feb 2026 09:34:51 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 535B1836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 09:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7E69A3F78E
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 08:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1770366887;
 bh=Yh0iTstrUWfgVOTV3WvWyLcxCJxvczkyPHxDVsNGXVg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=dobho/aU2Vf4A1f6Uvtta6JxsqnAsxmOYpXCsi7Q2DBYD/OsPe1tTKg+UZEWtj5XG
 tQXs5k+5zWhMKXkru9FsTJUCPtKAVKTn+06kJUVLC7kXaYT6x1CfKkX9N/mszWl2Pa
 K8GEC087FSxiTuu4MTSEEORKHkeVSod9X2v9gqb7xjkxAl+Pv9NW3qN5vlW5xKRJmE
 yr9n2pOLM3xwW14UP63m2tX0Em5anvJsqOlR+mTVX3KTfjJAEOxh/OpiDeeBPzoa+3
 IoOSf9XSqVPtesPQ3kad8AnuRfFaYvez0xj4Ej8HQsk37nIpdT0IOq9D2mX5B5mVha
 gHgmBjPqYIh06jmvT+pLbNvV3Liuf/lFVzM8zX6uq505sY4fshHhx87ytUhkaWbUcl
 AS6LS3s6ZWpBEH4fs8IGfs5NrdjIhStU0BaPxbrgy05haAjnFIhYubxcoGPYjIQN38
 2kCh8H3W/+VjCsxufHUr/c+vBor+5lov3aiktAU7MgjzYXFHnoVwsFOMTrbaLtvQUL
 NQvHfAfGpZ0sYn0jDyGMJhtw+QHrEpVRagtQjLtNOZc+0qRjCB7ZzB0icCuUlOBc5v
 jZMWiIbmusbxFO1LdQydx8GOWu4qlUOBFXPYeWBaBcoSFDd/RgmFPnry2anw+zFDQg
 rEaeAVXW0Q/6fZ6nwQfA8/kw=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806b12ad3fso20004045e9.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 00:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770366887; x=1770971687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yh0iTstrUWfgVOTV3WvWyLcxCJxvczkyPHxDVsNGXVg=;
 b=CvHmsn6zzTyx762W/yg1eGHM7qXUtnhRleYe331SClSxGBei3jR+SwkMfsT06oIrJL
 AjtdTZHEtnmg86kTE5xVbPc5Chpx1xDAENeBX79QYZgOEmsga+fXY/O11/ngyK9x64sn
 tglYXbXXVLa5/17afELBOLOb8AeT4Blg1ZjCu9M7KP4h3GCnb1NnaLpGw8vG5v0c50iu
 tISss2RO0CcaSRpGRuRPfJQx1AfkLvCMb+tbEbOXesehaXmsqM1DBP3tdU9ZgSuAB95q
 OnZzIkUDrOe35ozCqb+KO6xpQTPtaXBDlQpage1vqZHiBWk6kUMRhBTvtZwhWtjaZIWE
 C1kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWALYsya5X8EO567IV9wMXa2Ssi5CiUPQ7g6D/RiKnlsDCgRPIeeM7qDh14PBaaoAdsqVRkvss=@lists.denx.de
X-Gm-Message-State: AOJu0Yywq3S88RXAcjJTuBC8mlHzBN/z7UtE0vdoHgrNupiYxPAHX5c/
 eLpbfzR4kP5gbtRYzEc/9zA+UjsC7LmtZd3HYM4DncRhSvqwZAaExSgPvFJCVTDfEXo0KqqwXkv
 FNuDoSF5EuAJj+COE5eZBTcyIERLQYP04nm5Fjpj+dM642qVbIW4D0LOX/SM0LXJEbt4NmaY=
X-Gm-Gg: AZuq6aIxSRnbAKyosQpGvud/ydgkLwCYWkTPE1cKybTBrO5SXooqThrL5l3jinWzQU9
 8ezd3CNHaG4Q98RX5fNkSo23ShSF26sIZqq08x11aHSOWw+J5jnaRz0MPAo7NhW++Q2OvuHXakV
 ADz0tqUILybdaY6llwYcQtglPHvidY+i7dHXXFsby4CdzGq0v/iO6agnFaR2xsoPcohyPIHEw1T
 vKEcFIiSIRbBDoyPUF9ncQXBalnhFdVy6GD9WjUkLrT+cekussY4ulTy3iU4yVnWtdbgijrybK4
 W63Wj8b3oRwIbHq+lpKT1kxBnhNPi6OfbIB3yMM8ZnrZpR+SlpA3vAj98t7CDjjQCkMEoasl0bq
 KXbldz3OSw5edD0lTckcaXUnZ52Zk2pXp4ec8I/KwpJfGBg8PrNbrCio8SRwhmudwJKfHp+XzXO
 JAUd/1Oac=
X-Received: by 2002:a05:600c:3b23:b0:480:4be7:4f53 with SMTP id
 5b1f17b1804b1-4832021da3dmr29409205e9.31.1770366887027; 
 Fri, 06 Feb 2026 00:34:47 -0800 (PST)
X-Received: by 2002:a05:600c:3b23:b0:480:4be7:4f53 with SMTP id
 5b1f17b1804b1-4832021da3dmr29408945e9.31.1770366886604; 
 Fri, 06 Feb 2026 00:34:46 -0800 (PST)
Received: from [192.168.103.128]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483179dbdcfsm143441455e9.0.2026.02.06.00.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 00:34:46 -0800 (PST)
Message-ID: <48a831ae-ef60-44c6-baf5-1997ade040ac@canonical.com>
Date: Fri, 6 Feb 2026 09:34:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi_loader: fix use after free in efi_exit() with tcg2
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
References: <20260123105814.1083834-1-vincent.stehle@arm.com>
 <20260127161843.2676862-1-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260127161843.2676862-1-vincent.stehle@arm.com>
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

On 1/27/26 17:18, Vincent Stehlé wrote:
> The efi_exit() function frees the loaded image memory by calling
> efi_delete_image(). However, when CONFIG_EFI_TCG2_PROTOCOL is enabled, the
> image_obj->image_type structure member is accessed after the memory has
> been freed.
> 
> Fix this by performing the tcg2 measurement before the image deletion.
> 
> Fixes: 8fc4e0b4273a ("efi_loader: add boot variable measurement")
> Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> ---

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> 
> Hi,
> 
> Here is a respin after feedbacks. [1]
> 
> Changes for v2:
> - Move the event measurement before image deletion instead of keeping a
>    copy of image_type (thanks Ilias!)
> 
> This can be verified with sandbox_defconfig + CONFIG_VALGRIND=y and the
> following command:
> 
>    valgrind --suppressions=scripts/u-boot.supp \
>      ./u-boot -T -c "setenv efi_selftest start image return; \
>                      bootefi selftest"
> 
> This was lightly tested for regression with sandbox_defconfig and the
> following commands:
> 
>    ./u-boot -T -c "ut measurement"
> 
>    ./test/py/test.py --build-dir="$PWD" -s -k "test_efi_bootmgr \
> 	or test_efi_loader or test_efi_selftest or test_efi_secboot"
> 
> Adding some instrumentation in efi_exit() and tcg2_log_append() shows no
> change in the event measurements sequence.
> 
> [1] https://lore.kernel.org/u-boot/20260123105814.1083834-1-vincent.stehle@arm.com/
> 
>   lib/efi_loader/efi_boottime.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index ddc935d2240..b424d924896 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -3494,12 +3494,6 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
>   		if (ret != EFI_SUCCESS)
>   			EFI_PRINT("%s: out of memory\n", __func__);
>   	}
> -	/* efi_delete_image() frees image_obj. Copy before the call. */
> -	exit_jmp = image_obj->exit_jmp;
> -	*image_obj->exit_status = exit_status;
> -	if (image_obj->image_type == IMAGE_SUBSYSTEM_EFI_APPLICATION ||
> -	    exit_status != EFI_SUCCESS)
> -		efi_delete_image(image_obj, loaded_image_protocol);
>   
>   	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
>   		if (image_obj->image_type == IMAGE_SUBSYSTEM_EFI_APPLICATION) {
> @@ -3510,6 +3504,13 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t image_handle,
>   		}
>   	}
>   
> +	/* efi_delete_image() frees image_obj. Copy before the call. */
> +	exit_jmp = image_obj->exit_jmp;
> +	*image_obj->exit_status = exit_status;
> +	if (image_obj->image_type == IMAGE_SUBSYSTEM_EFI_APPLICATION ||
> +	    exit_status != EFI_SUCCESS)
> +		efi_delete_image(image_obj, loaded_image_protocol);
> +
>   	/* Make sure entry/exit counts for EFI world cross-overs match */
>   	EFI_EXIT(exit_status);
>   

