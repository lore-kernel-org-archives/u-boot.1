Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2ADC3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 17:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F5A6820EB;
	Wed,  7 May 2025 19:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=cairnwater.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cairnwater.com header.i=@cairnwater.com header.b="XkWZ+nsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A3481FAB; Wed,  7 May 2025 18:30:19 +0200 (CEST)
Received: from euk33.eukhosting.net (euk33.eukhosting.net [213.175.196.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C95B8059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 18:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=cairnwater.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=u-boot@cairnwater.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cairnwater.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 Message-ID:Subject:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WMnFgxRdQk1BB13jV4uDTP2Ty9UfM7HVaCFrJK89DMI=; b=XkWZ+nsEx6OLWfF+1T/kn+uVjG
 C/LENoivIV3N16OhyPrXyrUTYWmI4xfqF/eZzOGuVvgaB8AVoCr17dFJQV1kXRXI4ZLkp7wMLcNMR
 zka3fTHJdyT6VgJdTMi8mmZtbT37+jPp16RC8ci5iNYWj7fH3YsWffyc0r2B+gKBKN7r6rpczi4JQ
 PTgenwTO8ChOHBOUwXiPUvL7ssd1AuC/bNe0xMORbvhSpKLPAaiLH1gqVt2lxQVou7z2JRf4IzUNy
 mKT8ZdFdBiuD+ae6zP213Aw7Q2vpOBWiRYIP85o+gL9q526/uYV4MagejkFikzdaN9AiCsMHzHO1U
 mLnd6QPw==;
Received: from [::1] (port=58404 helo=euk33.eukhosting.net)
 by euk33.eukhosting.net with esmtpa (Exim 4.98.1)
 (envelope-from <u-boot@cairnwater.com>) id 1uChew-0000000E5IG-3SAm
 for u-boot@lists.denx.de; Wed, 07 May 2025 17:30:14 +0100
MIME-Version: 1.0
Date: Wed, 07 May 2025 17:30:14 +0100
From: u-boot@cairnwater.com
To: u-boot@lists.denx.de
Subject: Adding Device Tree Overlays for MIPI-CSI2 Camera and libcamera to
 u-boot in a buildroot or Yocto Build
User-Agent: Roundcube Webmail/1.6.9
Message-ID: <c0a6f0833fd3e4d887066dfe2ff405a5@cairnwater.com>
X-Sender: u-boot@cairnwater.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - euk33.eukhosting.net
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cairnwater.com
X-Get-Message-Sender-Via: euk33.eukhosting.net: authenticated_id:
 u-boot@cairnwater.com
X-Authenticated-Sender: euk33.eukhosting.net: u-boot@cairnwater.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Wed, 07 May 2025 19:35:11 +0200
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

Hi,

Does anyone have any advice on how to add DTOs needed by libcamera to a 
u-boot in a buildroot or Yocto build or on whether it's more appropriate 
to add them as part of u-boot or as another part of the build?

We'd like to add Kieran's DTOs

https://git.uk.ideasonboard.com/camera/dt-overlays/src/branch/main/arch/arm64/boot/dts/freescale

to the buildroot default configuration for Debix Model A SBC

https://github.com/buildroot/buildroot/blob/master/configs/polyhex_debix_model_a_defconfig

Ideally we'd also like to add the overlays for the Sony IMX 708 Image 
Sensor used in the RPi V3 camera but these aren't mainline:

https://github.com/raspberrypi/linux/blob/rpi-6.12.y/arch/arm/boot/dts/overlays/imx708-overlay.dts
https://github.com/raspberrypi/linux/blob/rpi-6.12.y/arch/arm/boot/dts/overlays/imx708.dtsi

We're planning to use the Debix Model A SBC or Debix SoM A with SoM A 
I/O board to prototype a new open source wildlife camera for our work in 
conservation of tree dwelling endangered dormice

https://new-homes-for-old-friends.cairnwater.com/

then after field studies with the prototype design a custom board for an 
NXP i.MX 8M Plus SoM.

The analysis for the new open source wildlife camera is here:

https://github.com/William-Robert-Robertson/WildCamera

Will
