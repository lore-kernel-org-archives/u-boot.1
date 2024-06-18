Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319DFC2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F00E88137;
	Tue, 18 Jun 2024 16:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vqdAPT7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B69A881DB; Tue, 18 Jun 2024 16:51:14 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A0E68812C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IEow1q004407;
 Tue, 18 Jun 2024 09:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718722258;
 bh=0/4tyIzwMuHOjeOd7aR2N3zFKjhzA6TaYsuvmETWhDc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=vqdAPT7Lq5YkHEqLc0hsC7a8HvvaL1Ooy/mHXnqNSpWjtkH34Vz0frGJf7zKrZ+8h
 QTd2S/HkTFy3VATU9RnjUcj7/sbOEfxVsnKFCiK8P/S0ZFWJNeMaoQlePoMLj+yo/8
 ntF+BCJm8n5QWJPnSdRykxvUv4xgzBPpqYuCCMJU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IEowqk092577
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 18 Jun 2024 09:50:58 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 09:50:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 09:50:58 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IEowdB070775;
 Tue, 18 Jun 2024 09:50:58 -0500
Date: Tue, 18 Jun 2024 09:50:58 -0500
From: Nishanth Menon <nm@ti.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
CC: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Tom Rini
 <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 00/24] EFI: ti: Enable EFI capsule updates
Message-ID: <20240618145058.552eapp5iiz772ej@hardcore>
References: <20240614163551.2610212-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240614163551.2610212-1-j-humphreys@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 11:35-20240614, Jonathan Humphreys wrote:
> Enable on disk capsule updates, which includes defining the firmware
> components (tiboot3, spl, u-boot) and enabling processing of raw capsule
> updates.
> 
> This is enabled for several TI SoC based platforms: AM64, AM62, AM62p,
> AM69, BeaglePlay, J7, and BeagleboneAI. The configs to enable this are in a
> single base config file. This will make it more scalable to add additional
> EFI capsule features (like authentication) across all TI boards that have
> capsules enabled.
> 
> This series also includes enabling serial flash DFU for AM62 and MMC DFU
> for beagleplay.
> 
> Changes from v1:
> - Added sysfw.itb capsule definition to beagleboneai64
> - removed extra commas in structure definitions
> 
> Changes from v2:
> - Added documentation on OSPI flash layouts
> - Improved comments for capsule GUIDs definitions
> - Defined board unique capsule GUIDs and put definitions in board specific
>   files
> - Added a Capsule Update porting section to the documentation
> 
> Changes from v3:
> - Added better commit messages based upon checkpatch warnings.
> - Remove conditional inclusion of capsule update firmware info
> - Converted OSPI layout diagram to svg format
> Link to v3: https://lore.kernel.org/r/20240419205701.163821-1-j-humphreys@ti.com
> 
> Changes from v4:
> - Added am69 SK board
> - Corrected a few spelling mistakes and clarity improvements in k3 docs
>   section
> - Added CONFIG_SET_DFU_ALT_INFO guard around set_dfu_alt_info()
> Link to v4: https://lore.kernel.org/r/20240509164123.1753050-1-j-humphreys@ti.com
> 
> Changes from v5:
> - Created an EFI capsule base config for TI boards, making adding
>   additional capsule features on TI boards more scalable.
> Link to v5: https://lore.kernel.org/r/20240531222118.2618041-1-j-humphreys@ti.com
> 
> Changes from v6:
>  - Rebased on latest -next
>  - added tags
>  Link to v6: https://lore.kernel.org/r/20240607223858.1971290-1-j-humphreys@ti.com
> 
> Jonathan Humphreys (24):
>   doc: uefi: capsules: Add Capsule Update porting section
>   doc: ti: k3: Correct spelling mistakes and improve clarity
>   configs: ti: Create base EFI capsule configs for TI K3 devices
>   board: am64x: Define capsule update firmware info
>   configs: am64x: Enable EFI capsule update
>   doc: board: ti: am64x: document OSPI layout
>   board: j721e: Define capsule update firmware info
>   configs: j721e: Enable EFI capsule update
>   doc: board: ti: j721e: document OSPI layout
>   board: beagleplay: Define capsule update firmware info
>   configs: beagleplay: Enable DFU for MMC
>   configs: beagleplay: Enable EFI capsule update
>   board: am62x: Define capsule update firmware info
>   configs: am62x: Enable EFI capsule update
>   doc: board: ti: am62x: document OSPI layout
>   board: am62px: Define capsule update firmware info
>   configs: am62px: Enable EFI capsule update
>   doc: board: ti: am62px: document OSPI layout
>   board: beagleboneai64: Define capsule update firmware info
>   configs: beagleboneai64: Enable EFI capsule update
>   configs: j784s4_evm: Enable serial flash DFU support
>   board: sk-am69: Define capsule update firmware info
>   configs: j784s4: Enable EFI capsule update
>   doc: board: ti: j784s4: document OSPI NOR layout

Jon,

Could you submit a follow on patch to add under the appropriate
subsection of [1] instructions for build environment and steps
to copy the capsules?

I just ran into an issue with next where my build container was missing
uuid-dev package and my builds broke overnight for u-boot/next. looking
for documentation, I did not see the change.


[1] https://github.com/u-boot/u-boot/blob/master/doc/board/ti/k3.rst?plain=1#L203

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
