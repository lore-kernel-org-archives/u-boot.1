Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494BBE77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 14:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D53801E8;
	Tue,  7 Jan 2025 15:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NyPYagg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F0C801FD; Tue,  7 Jan 2025 15:41:03 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 118BB8007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 15:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A026E5C5DF8;
 Tue,  7 Jan 2025 14:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2F8C4CEDF;
 Tue,  7 Jan 2025 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736260858;
 bh=fkJPD73XTCzvm6kfK5WXM7T4g4RPQfjE6sVbFBceYjU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NyPYagg024v8iB42lDJwSnv+JOpZMOAn4NTCeK9VCoKFvxhNGlkrQ3H12CvpaKxln
 rUHlhi/mzBmtxssLDpXfNi5ntAGo3EHhr02IdJNphrywTi7LR+AsTCOFOuANOPXLyp
 LK1oaqe9sAlZ1IVcl1Oeu2rMTGz7a2TLoe3tV/Iqtl/2dW4wkHN9Rjm91knnVDBIYw
 W7wVwgrVHCtOdMJRr2PePlP6mqA+0Rk6bWC3QvpVy6J4hvS0Pn8UYsD1ScYKWv9rF6
 ZJRR6SahepzQBnAdW6+zE8gKrP/yvGHQMawy91957QUDohvTfPMMONAJpVs8AxAztA
 cEWCV+7QefwEw==
Message-ID: <bd00f34d-08a6-490d-bb39-93b64f48b17f@kernel.org>
Date: Tue, 7 Jan 2025 16:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] configs: am68: Enable configs required for Ethernet
 boot
To: Chintan Vankar <c-vankar@ti.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Simon Glass <sjg@chromium.org>,
 Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: srk@ti.com, s-vadapalli@ti.com, danishanwar@ti.com, u-boot@lists.denx.de
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-7-c-vankar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250107093840.2211381-7-c-vankar@ti.com>
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



On 07/01/2025 11:38, Chintan Vankar wrote:
> Enable config options needed to support Ethernet boot on AM68-SK.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>  configs/am68_sk_a72_ethboot_defconfig | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 configs/am68_sk_a72_ethboot_defconfig
> 
> diff --git a/configs/am68_sk_a72_ethboot_defconfig b/configs/am68_sk_a72_ethboot_defconfig
> new file mode 100644
> index 00000000000..42469861961
> --- /dev/null
> +++ b/configs/am68_sk_a72_ethboot_defconfig
> @@ -0,0 +1,18 @@
> +#include <configs/am68_sk_a72_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SOC_K3_J721S2=y
> +CONFIG_TARGET_J721S2_A72_EVM=y
> +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am68-sk-base-board"
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_BOARD_INIT=y
> +CONFIG_SPL_DMA=y
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SPL_ETH=y
> +CONFIG_SPL_NET=y
> +CONFIG_SPL_NET_VCI_STRING="AM68 U-Boot A72 SPL"
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_RAW_IMAGE_SUPPORT=y
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_SPL_STACK_R_ADDR=0x83000000

Please avoid duplicates already in configs/am68_sk_a72_defconfig or
configs/j721s2_evm_a72_defconfig

-- 
cheers,
-roger

