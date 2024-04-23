Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6817AC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 12:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C42D388518;
	Tue, 23 Apr 2024 14:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lN90g6vL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FCB788530; Tue, 23 Apr 2024 14:12:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9693E884EF
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 14:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0ECC36143D;
 Tue, 23 Apr 2024 12:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7776CC3277B;
 Tue, 23 Apr 2024 12:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713874332;
 bh=hvfGw64XGqQeVJGyrTV0M1HVJ2HWd+br4JDZSDlno+A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lN90g6vLWHrFS9Ay03Aqm06Oyg3ZAYNj8C9rY9MV10Gx3oS87FOoMKL+OR9cdiazU
 nvcSQTsS5h5v4zzNrapcW6MDZ/GK6XBzKG2MQM+zSgylRiixwc6gv2I4pXEESSOLMP
 Y4a+D8X2ileXoSkyBrt/iaRRzYheIwuR//NZUKvc/EgpUrCvzQGhY+5bFrr5Yro+Es
 b7mhD6vNrpyXRH8Q48ag5/LxhRhpLA0HrpX2R/FlZuC76BE6Aqt7CckrNesKITUPL+
 dvJ3fNr/Ijg5wDULS74j7E7oxXkWOjuDoOBliO/Yq5k/6rODgcAMC/vt4KeGaqHUpk
 XR7NL7YZwM0TQ==
Message-ID: <2960c049-fbbf-40fd-82ee-b8e289679664@kernel.org>
Date: Tue, 23 Apr 2024 15:12:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/19] configs: am64x: Enable EFI capsule update
To: Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240419205701.163821-1-j-humphreys@ti.com>
 <20240419205701.163821-4-j-humphreys@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240419205701.163821-4-j-humphreys@ti.com>
Content-Type: text/plain; charset=UTF-8
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

Checkpatch warns:

WARNING: Missing commit description - Add an appropriate one


On 19/04/2024 23:56, Jonathan Humphreys wrote:
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  configs/am64x_evm_a53_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
> index e000549d6d0..c9bdd7b54cc 100644
> --- a/configs/am64x_evm_a53_defconfig
> +++ b/configs/am64x_evm_a53_defconfig
> @@ -178,3 +178,5 @@ CONFIG_USB_FUNCTION_MASS_STORAGE=y
>  CONFIG_SPL_DFU=y
>  CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>  CONFIG_EFI_SET_TIME=y
> +CONFIG_EFI_CAPSULE_ON_DISK=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

-- 
cheers,
-roger
