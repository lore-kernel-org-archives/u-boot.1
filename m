Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4502AC021AD
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 08:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F926801DE;
	Thu, 20 Feb 2025 09:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="toOX2Amk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E38F80A46; Thu, 20 Feb 2025 09:11:33 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C3F801CF
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9DA353F1DD
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 08:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740039090;
 bh=vlyX1N+AJ7m5+KAMvACJWeHcRYYJKUthUc94Ng87K+4=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=toOX2AmkT1SnKJBEmxXfkoidM+OS7W3Hb2vmI0pO7xjGi0RSrofldm4veqd5bgfCk
 AQKzilSF6QjSU6VHvOztDwm5jEzHxAovPix7z8aTkgBXx74Z+KVpmmD+0mXArvOlYG
 0BPtrXd3tFKUflxITJMDluMpmwYdyg2CNHqzpuVTCnUi2GR5XxpQYBb7M3LUYWknWA
 pMN5X7y18SWnghzkBV8/T2DAAqfhkIzg4fShTmF1QZNQ7ls0pKPDxzj7ZRNN7lIggN
 UT9yF4Cmg6E6j2T18DrHSTDyFt5xs3lwoe2oy3NXZl/bGNF+BYpUb95eUSYi9l9tNT
 asi6vYHq87lPw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f36f03312so270805f8f.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 00:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740039090; x=1740643890;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vlyX1N+AJ7m5+KAMvACJWeHcRYYJKUthUc94Ng87K+4=;
 b=WJRSNNkfiYN1r0y6zamk5Gb+/r585SjVQJ9pEVEW/0LrKLxbh56N2KO6cVa2LeRMP8
 D+OeBn05MY3P5KrTX6coVKKM/4QbeDmzgbbJqbAKl1l70hzdUszUH0VZOlhPIcPcRT2H
 p/OPfiS6WQa4t2faLNmgbLPzCqZoN0QbMuKemRLXjNDH3qO/FxMUo7Y8PtGWiazWQv7H
 nkBPKCHUIyOM8w/pf65EU954QWJGgxIR3TUMsZh2DGbAJadpC9bL6hvfirfGxsQKVU1P
 CMw0R8YyLUXK9fov8uvnYpai7jZbenRYmTxR/LggzTBbsbY2EUy0YfMCR3XDvUuieVYd
 kg0A==
X-Gm-Message-State: AOJu0YxEFCD6sS+YS5bw4EIpg06lDXxk0fuyjivkOu/rfMaXFwI2H8I/
 R9BD2aSw0GTKMYZljA2oaiFgVZeXX0I+F5RJld7L1g9upSy3UxNYT6xHc1pcx+iQeKUOBEDA5wb
 K6SRwML8WKNQHJ60x7Nkzb6MQCsNToptNpetdyALunnvOzIhjIJIlvh7xelkXpK40M/4=
X-Gm-Gg: ASbGnctFEyy2bKYCbdSKNgm6xUAIHPQh1blhvbgA2jHQm4/NpQvWCd4sevdYcdFRypI
 vnHPOfvTvXFuRyXph9NgtgR1PdMcrsm9eApMBlyba2XAi9NA14eyFnpnPkDkjjNQMb6Jdyr1Gcv
 wmTb6m+WimKyzvoS/Zs4pPBkXkaMm7kSXKBk+t5EVvER/fYNmgQfeqAiEbKcnXcYBkQyVU4Pzqi
 KAF7dseTeAIOsexkPAaMVfmOqAkm6aeGHyetFjnh5lYprVqIOws5pM+aVSiURNQnYFrFXioorpX
 4MpPZ/VlGIiGr+elnv8WHlxT04f95pPDiTRw9ICbLrfLHifqj4Xx5fuQ3NwRsdKuy7CGrjpPnB6
 0DQ==
X-Received: by 2002:a05:6000:eca:b0:38d:a879:4778 with SMTP id
 ffacd0b85a97d-38f33f357cemr16994145f8f.33.1740039090240; 
 Thu, 20 Feb 2025 00:11:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5Ji7qLh82WseU6tWwymgCTH2+dnH8nOv7DOA/mHyWdomH6lvLNFTaWt0QWAGUXVekcQr5nA==
X-Received: by 2002:a05:6000:eca:b0:38d:a879:4778 with SMTP id
 ffacd0b85a97d-38f33f357cemr16994128f8f.33.1740039089917; 
 Thu, 20 Feb 2025 00:11:29 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7b68sm19579552f8f.85.2025.02.20.00.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 00:11:28 -0800 (PST)
Message-ID: <531d1602-85e0-44fa-82d7-08566ecd66b8@canonical.com>
Date: Thu, 20 Feb 2025 09:11:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Fix potential deref-after-null
To: Maks Mishin <maks.mishinfz@gmail.com>
References: <20250202175940.2150031-1-maks.mishinFZ@gmail.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250202175940.2150031-1-maks.mishinFZ@gmail.com>
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

On 2/2/25 18:59, Maks Mishin wrote:
> After having been compared to a NULL value at efi_disk.c:426,
> pointer 'part_info' is dereferenced at efi_disk.c:534.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>   lib/efi_loader/efi_disk.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 1f3de0a233..83e8eb6fe4 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -531,13 +531,15 @@ static efi_status_t efi_disk_add_dev(
>   
>   	/* Store first EFI system partition */
>   	if (part && efi_system_partition.uclass_id == UCLASS_INVALID) {
> -		if (part_info->bootable & PART_EFI_SYSTEM_PARTITION) {
> -			efi_system_partition.uclass_id = desc->uclass_id;
> -			efi_system_partition.devnum = desc->devnum;
> -			efi_system_partition.part = part;
> -			EFI_PRINT("EFI system partition: %s %x:%x\n",
> -				  blk_get_uclass_name(desc->uclass_id),
> -				  desc->devnum, part);
> +		if (part_info) {
> +			if (part_info->bootable & PART_EFI_SYSTEM_PARTITION) {

Hello Maks,

Thank you for spotting this and providing a patch.

U-Boot has scripts/get_maintainer.pl to find whom patches should be 
addressed to.

We could use a single if statement with &&. But that is just a matter of 
taste.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +				efi_system_partition.uclass_id = desc->uclass_id;
> +				efi_system_partition.devnum = desc->devnum;
> +				efi_system_partition.part = part;
> +				EFI_PRINT("EFI system partition: %s %x:%x\n",
> +					blk_get_uclass_name(desc->uclass_id),
> +					desc->devnum, part);
> +			}
>   		}
>   	}
>   	return EFI_SUCCESS;

