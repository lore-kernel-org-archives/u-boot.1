Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189BDEA3F27
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 09:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED4F831AC;
	Wed, 11 Feb 2026 10:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="R7+0kKwe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8117783CB5; Wed, 11 Feb 2026 10:56:35 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D95682BF2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 10:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0F6253F787
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1770803793;
 bh=oXxpFpMMb5OEfhft452/BjzbNTYXSDYM+gQtVCWK0Bs=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=R7+0kKwePn/tiZl0N8Rfvc4GvnfUuEI2K51QImRGtZATghgCjc6xFbDoGJltqS4hg
 olTQwZE0YCh28rYbkfTlme9pEa3HUoTARumcyQs07KybsUoOplxWDgaJPPfKs3em0y
 9VK/X7vFZ4V8Ic1vnET/rTDzIsSyhB1HB0+j0/qCnLdGl1PFu6zY/EFmUEAqvQi4pU
 +4R+KoSoNZXd4go4f9t8TRi2S5AJlisHUoLifq2d2OBvXKX5P0giFraAMzfuy52Cy9
 WZU+MpY+HFObpRlroM7JaGk0noJKmltUc6PJeszOmAGcxRyiXX37RKj6jQjAEcLLgT
 zNAybMhMeO6Eav5fTpuNYNkZEyel25ijNzGHKCSWTJqpAcMb4UT4yo1Xg/IH4d+5zG
 V0vJux4LFymeP7lQ7E9yWKKLj6UIXFiOYQwCTUGjrB7aMXIYmkgkFwt/V7rHmb39Ll
 lfCqgrMkImuKxsbwxIbywGEDQwYRMi2Hb/6ri75X8St/zHISaRvii9XhENQotRiDgz
 oe66/hRSUhxtwmwXcBeKJqU6juY7QJio+wclNLJXH7Ejbb1W30swsJFe64tyPNtC+H
 egmbZdbNmibgNDJEd38AuY9Di4XcEFIQGDYITZ+F3aWGmtEBoIscpA0NJxLVlhbTGw
 MzBwqyleopt2nrJDSeOtz4No=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4832c4621c2so44105365e9.3
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 01:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770803792; x=1771408592;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oXxpFpMMb5OEfhft452/BjzbNTYXSDYM+gQtVCWK0Bs=;
 b=AsN5gy6kINVRqphk9FcKDOBnWw82iseyX1BrwE0DmwkhNf4JmAvTMQWPcQSki4KMNY
 jHjTUbWHIo/zo6HPHpZZwh//+GdE7hPR6a0TYsZYjXrPtCPNRv9vrblQvbuUrT2hLsCw
 m0q2xw1YbrKO1DK5AQR8bl6YcuKNKXa/2+18lSTJwi1tKkYsYY6DRLYdIVgMl9qbu+nI
 8GlJZAxQPyMjK9xKZ8PRPKsx5jIfOQpU3cw9KQp/ZJ1y8YFHhSxb8aTgRPVglmLgWvZy
 lHTb8Afj4ydLpeW3goNBV7+A03MwnGkKfSgxJPacxHbHIxeKLleIm6uW4mL2TaNzAF+Q
 zWRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6+ErdKr+3jLEAVqk5YYgHevQEqFOyrAYCLV+nOOf9/mXUR07J9A+JR0KpeI24KrgdoA75AY0=@lists.denx.de
X-Gm-Message-State: AOJu0YxEPCEKU0lrHHwlHPqucCXxCLxemwjKP2KoWB0f85vSucmNwd2f
 4mlE+iPnVb26AT+1c+YKRSMkso92D2KTFQ4/RxhMRQM6ZKpC5yYgDMd5aIlnmF/u6iPEYK6guqc
 ItOI0ROTE2swNXLA0e0us1rQSrwzNJBg2YkB2A2WptWryiztAwDZwyybQGwFz3H51FYcgcIY=
X-Gm-Gg: AZuq6aJHSMJasxsTATs8QM7Qp6kgaVaaRz8r91EXs72J2o5rnFQwjwRHrfE3dK/dz+Q
 Wa/ryihLYQhpe5lFfpm5JXejXnSsdoPtIR3dmWs/3A3zkS8fxuJo2OicK0zrjkcwwNj15kAMDIx
 X7olwQxUY0elkfAB+aKyIngai6E/n79uE+VHcbMiiwxjf34f312kjVVmgGP8giktXkjPicusd9a
 k9fP7jumJvdBVOzxVbJC0rHeG1vncGphtJ1Q/tS7svPpL3vWNNUsXxMFrhhOVdGmV3VsziFj2j3
 qWeJu93DxJpuAh7QqxfyhleAkTCfyvSL4sROc9c+JasdYWruQs0p1S/LiLawxL35bITARO9iag9
 Q1eAlPhfCYuGonzioBtIdiSZ3AguDK2S4oEfxHbiNcXdqa97XehUt3/z/9ub8tj2Uwwx2lA5vR1
 HV4A==
X-Received: by 2002:a05:600c:4e13:b0:479:1ac2:f9b8 with SMTP id
 5b1f17b1804b1-4835081ed39mr81056115e9.21.1770803792580; 
 Wed, 11 Feb 2026 01:56:32 -0800 (PST)
X-Received: by 2002:a05:600c:4e13:b0:479:1ac2:f9b8 with SMTP id
 5b1f17b1804b1-4835081ed39mr81055665e9.21.1770803792176; 
 Wed, 11 Feb 2026 01:56:32 -0800 (PST)
Received: from [192.168.103.128]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5e0ed5sm110952025e9.5.2026.02.11.01.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 01:56:31 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <a386de9e-1dc9-4b50-a86c-bb8dfd845eef@gmx.de>
Date: Wed, 11 Feb 2026 10:56:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: fix ecpt size computation
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Jose Marinho <jose.marinho@arm.com>,
 u-boot@lists.denx.de
References: <20260211093308.3265022-1-vincent.stehle@arm.com>
Content-Language: en-US
In-Reply-To: <20260211093308.3265022-1-vincent.stehle@arm.com>
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

On 2/11/26 10:33, Vincent Stehlé wrote:
> The size of the memory allocated for the EFI Conformance Profiles Table is
> computed with `num_entries' always equal to zero, which is incorrect when
> CONFIG_EFI_EBBR_2_1_CONFORMANCE is enabled.
> 
> This can be verified by allocating the ECPT memory with malloc() instead of
> efi_allocate_pool(), building u-boot with sandbox_defconfig and
> CONFIG_VALGRIND=y, and by finally running the following command:
> 
>    valgrind --suppressions=scripts/u-boot.supp \
>      ./u-boot -T -c 'efidebug tables'
> 
> Fix this by using an array of the supported profiles GUIDs instead, which
> should also be easier to extend in the future.

Thank you Vincent for this patch.

Maybe mention in the commit message that U-Boot should publish all 
supported EBBR revisions.

> 
> Fixes: 6b92c1735205 ("efi: Create ECPT table")
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Jose Marinho <jose.marinho@arm.com>
> ---
>   lib/efi_loader/efi_conformance.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_conformance.c
> index 2bae93a94bd..9768b5ae824 100644
> --- a/lib/efi_loader/efi_conformance.c
> +++ b/lib/efi_loader/efi_conformance.c
> @@ -13,8 +13,12 @@
>   #include <malloc.h>
>   
>   static const efi_guid_t efi_ecpt_guid = EFI_CONFORMANCE_PROFILES_TABLE_GUID;
> -static const efi_guid_t efi_ebbr_2_1_guid =
> -	EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID;
> +
> +static const efi_guid_t profiles[] = {

As profiles[] is not used outside efi_ecpt_register(), there is no need 
to make it a static variable.

Otherwise looks good to me.

Best regards

Heinrich


> +#if CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE)
> +	EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
> +#endif
> +};
>   
>   /**
>    * efi_ecpt_register() - Install the ECPT system table.
> @@ -23,12 +27,11 @@ static const efi_guid_t efi_ebbr_2_1_guid =
>    */
>   efi_status_t efi_ecpt_register(void)
>   {
> -	u16 num_entries = 0;
>   	struct efi_conformance_profiles_table *ecpt;
>   	efi_status_t ret;
>   	size_t ecpt_size;
>   
> -	ecpt_size = num_entries * sizeof(efi_guid_t)
> +	ecpt_size = sizeof(profiles)
>   		+ sizeof(struct efi_conformance_profiles_table);
>   	ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, ecpt_size,
>   				(void **)&ecpt);
> @@ -39,12 +42,9 @@ efi_status_t efi_ecpt_register(void)
>   		return ret;
>   	}
>   
> -	if (CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE))
> -		guidcpy(&ecpt->conformance_profiles[num_entries++],
> -			&efi_ebbr_2_1_guid);
> -
> +	memcpy(ecpt->conformance_profiles, profiles, sizeof(profiles));
>   	ecpt->version = EFI_CONFORMANCE_PROFILES_TABLE_VERSION;
> -	ecpt->number_of_profiles = num_entries;
> +	ecpt->number_of_profiles = ARRAY_SIZE(profiles);
>   
>   	/* Install the ECPT in the system configuration table. */
>   	ret = efi_install_configuration_table(&efi_ecpt_guid, (void *)ecpt);

