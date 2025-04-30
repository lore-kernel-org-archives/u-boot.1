Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE43C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 21:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B9EC800C1;
	Wed, 30 Apr 2025 23:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="P4q8zWlq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C3680194; Wed, 30 Apr 2025 23:54:52 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E64180079
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 23:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-39c14016868so373840f8f.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1746050088; x=1746654888; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2mUdNIfaFL6rhY6NA8p5svZ4q5QVDtXLivXujYYcrl0=;
 b=P4q8zWlqn2iVNRXG3gCgttNfK7Fw87kmlRQhLYYcc554kQLoFK0VM5enIIJcG1ixBe
 3ILehjSv+BZhTl8PWlIOZUOlkiDY1Uqq77z063wKqKcFQw/v4Otklso0TAXc499moeYI
 b6mUofPu7kpKXpDSfVLoYL5f/xznaUGS5dzkXLfSQPJ3Sjet+IWhcbStiaiBCNgEbvJc
 BGdFIlSX0qFrxII8bivGlcioBMMMRzc7x2ORiFiqgXrDzrjRLMYyLf/JVNR5VScKekDE
 2+GtV52wgpyZFSL0lvlcutrteF2lYnsxKiwuhIcHUNNyrxnCBn0YcLADyzakIlWk5GJT
 vQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746050088; x=1746654888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2mUdNIfaFL6rhY6NA8p5svZ4q5QVDtXLivXujYYcrl0=;
 b=tXut4EraPT8WIlN0S7QltKYmkZpVhBQ91x7GBjJN1WjelRye7o4WWUh6hhFOgqFSjb
 JxH9IKe4OpOUkCxenN4XTkTedY9sYJQ7bolvUMx56tIdFRCLx6fh7MpeYuSorOZGFLtN
 znd+qBX8ktJFpo7GzLFyjZE2wH3l78UVipWxLtPPB4MRwVuw9ccLeDsYSz5Rrm6k+0HW
 IAsXw+jz6/KX1MmMpLLANhdIckhMVqyucESF/tOevz+RGKlcwZl6d4suwlJ1T+LATcEl
 ALegim+zkh70fVZwhz4CByvu//vp11B2bgM2d6C/acn4w8zhBX52NyFymPAIMdwMNHlw
 D2Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuqzn3d1VuOrdsa+DOL8lQBDYFpvtnd3kdTzF6yJ4brktADRcQHW/YAXhNebhq5YMMlXnRNzc=@lists.denx.de
X-Gm-Message-State: AOJu0YyHzroIz2ReGZOD+B9lON57+oqHTplJcECuHz0/kz5Imix+kIjO
 USh0p2urccfKq5fsaHNgkrzs400Tw0MstTeBHZO1inT2ZD8EiSVYjbPneF5htBU=
X-Gm-Gg: ASbGncst3bedo8CU17fHziRKwe6JLixHgfMWTefZnXJfqs4abolL6NuGL36a0/rs8Gu
 qGVOczePCeJFnrMIyFfpevL4rKEgJbpOF9zsoZYk1OB9aHi+irK3TObIGiN0IG/PFEol6+6tbUF
 pghMEx9kmKVOw7BV4yBe/MxP2XwvWrZr/70/cBApsZlqOSoF57UPimsqpQp7nKVjfVOCvskcFNc
 ctVdC/xC8C3UF4InDGJyE7V36KiPdbGrXH0sljTkPBiTdxiSueuojNmKcuV5+QC4cNQcSbKsVq1
 VaNharcNdo6Pdg6TG5tR+0jImE+1j31LXYynhnE2QRo5vpoSM3CeEMk6NrqiM/DpoHb82qSF4Ki
 8Ig3OTTI7STX4AzFYZCQHGnEQYZxCHoiRGwOTaVucZJfb/G162gLaDUOXq1AgHLuzWatM
X-Google-Smtp-Source: AGHT+IE+1uBJJA9pkhujYtrOP3i3TXR/bTOux5Qaw3mGD0SxEIr5o42MN9deJ+ha03SjNLAoASXLqA==
X-Received: by 2002:a05:6000:1844:b0:3a0:8598:8e7c with SMTP id
 ffacd0b85a97d-3a09404400dmr62056f8f.6.1746050088474; 
 Wed, 30 Apr 2025 14:54:48 -0700 (PDT)
Received: from ?IPV6:2003:ce:9701:5f00:17f5:3d4b:e519:e403?
 (p200300ce97015f0017f53d4be519e403.dip0.t-ipconnect.de.
 [2003:ce:9701:5f00:17f5:3d4b:e519:e403])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b3ae0c19sm29759515e9.24.2025.04.30.14.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 14:54:48 -0700 (PDT)
Message-ID: <6f0bf199-73a1-4338-b3b9-87533cc1cdaf@suse.com>
Date: Wed, 30 Apr 2025 23:54:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rpi: set NR_DRAM_BANKS to 8 to accommodate RAM
 on 16GB models
To: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250430171555.144243-1-sairon@sairon.cz>
Content-Language: en-US
From: Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20250430171555.144243-1-sairon@sairon.cz>
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



On 4/30/25 19:15, Jan Čermák wrote:
> Raspberry Pi 5 can now have up to 16 GiB of RAM where the memory spans 8
> DRAM banks in total. Increase the config value to 8 to initialize the
> whole RAM. Without this change, kernel only sees 8 GiB of RAM on the 16
> GiB CM5 as reported in [1].
> 
> [1] https://github.com/home-assistant/operating-system/issues/3989
> 
> Signed-off-by: Jan Čermák <sairon@sairon.cz>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
> 
>   configs/rpi_arm64_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
> index 9fe5d177943..69e8e72c5d7 100644
> --- a/configs/rpi_arm64_defconfig
> +++ b/configs/rpi_arm64_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>   CONFIG_POSITION_INDEPENDENT=y
>   CONFIG_ARCH_BCM283X=y
>   CONFIG_TARGET_RPI_ARM64=y
> +CONFIG_NR_DRAM_BANKS=8
>   CONFIG_ENV_SIZE=0x4000
>   CONFIG_DEFAULT_DEVICE_TREE="bcm2711-rpi-4-b"
>   CONFIG_OF_LIBFDT_OVERLAY=y

