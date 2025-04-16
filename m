Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF40EC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CC1A82CF6;
	Wed, 16 Apr 2025 13:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KUPj4TYy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E94BE82D17; Wed, 16 Apr 2025 13:24:25 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2196F80FDA
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53GBOIG92643365
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 06:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744802659;
 bh=m/UBFxJQ2M+k7dqF5vaMSwXXFmxhnPkhdxz4vPu4ynk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=KUPj4TYyX2Bx0Rwhj0fgneBjtMRP5099YrkF18Le3YGF6saT8s86IEm4nboZz5Cmx
 KDtVIhiwZzgJSOsO+PkHpAMvA6FxD/NisHPVzhAKj52QgQwgpqiR0mmBDJDMod8n2I
 gi3sCqLYezaeNHZ4O1dMEG8/4JI5TPcLbRdOTroQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53GBOIwx112382
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 06:24:18 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 06:24:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 06:24:18 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53GBOIXd075712;
 Wed, 16 Apr 2025 06:24:18 -0500
Date: Wed, 16 Apr 2025 06:24:18 -0500
From: Nishanth Menon <nm@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>
Subject: Re: [PATCH v1 0/4] k3: migrate SPL_TEXT_BASE to new address
Message-ID: <20250416112418.nod2fut4v77qlmfq@hummus>
References: <20250416073058.1441001-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250416073058.1441001-1-anshuld@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 13:00-20250416, Anshul Dalal wrote:
> The change to ATF's PRELOADED_BL33_BASE[1] requires respective changes to
> SPL_TEXT_BASE on u-boot side. This is necessary to allow the ATF to jump
> directly to linux kernel (like in falcon mode) which requires a 2MiB aligned
> load address[2]. The current address ATF jumps to is 0x80080000 which is not
> 2MiB aligned.
> 
> Therefore in parallel to the ATF change, this patch set makes the corresponding
> changes to u-boot. To maintain backwards compatibility with older ATF builds
> (that still use older address of 0x80080000), the patch set also adds a
> jump-stub which modifies the execution as follows:
> 
> Old ATF -> 0x80080000 -> 0x822000000 (Main domain SPL or kernel image)
>            jump stub    SPL_TEXT_BASE
> 
> With the following instructions loaded by the jump-stub:
> ADDR       | Instruction
> 0x80080000 |   mov x15, CONFIG_SPL_TEXT_BASE (0x822000000)
> 0x80080004 |   br x15
> 
> Depends on:
>  * [PATCH v3] configs: set SPL_TEXT_BASE by default for k3 platforms
>    https://lore.kernel.org/u-boot/20250415095028.446254-1-anshuld@ti.com/
> 
> [1]:
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/37447
> [2]:
> "The Image must be placed text_offset bytes from a 2MB aligned base
> address anywhere in usable system RAM and called there."
> - Documentation/arch/arm64/booting.rst (linux kernel)
> 
> Anshul Dalal (4):
>   spl: Kconfig: k3: set SPL_TEXT_BASE to 0x82200000
>   mach-k3: add a jump stub to support older ATF builds
>   binman: k3: add jump-stub to tispl.bin
>   binman: k3: add jump-stub as loadable


	How about u-boot documentation?
> 
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  2 +-
>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  4 +--
>  arch/arm/dts/k3-am625-sk-binman.dtsi          |  4 +--
>  .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  |  4 +--
>  arch/arm/dts/k3-am62a-phycore-som-binman.dtsi |  4 +--
>  arch/arm/dts/k3-am62a-sk-binman.dtsi          |  4 +--
>  arch/arm/dts/k3-am62p-sk-binman.dtsi          |  2 +-
>  arch/arm/dts/k3-am642-phycore-som-binman.dtsi |  8 ++---
>  arch/arm/dts/k3-am64x-binman.dtsi             |  8 ++---
>  arch/arm/dts/k3-am65-iot2050-boot-image.dtsi  |  2 +-
>  arch/arm/dts/k3-am65x-binman.dtsi             |  4 +--
>  arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi  |  2 +-
>  arch/arm/dts/k3-binman.dtsi                   | 31 +++++++++++++++++++
>  arch/arm/dts/k3-j7200-binman.dtsi             |  4 +--
>  .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  2 +-
>  arch/arm/dts/k3-j721e-binman.dtsi             |  4 +--
>  arch/arm/dts/k3-j721s2-binman.dtsi            |  4 +--
>  arch/arm/dts/k3-j722s-binman.dtsi             |  2 +-
>  arch/arm/dts/k3-j784s4-binman.dtsi            |  4 +--
>  arch/arm/mach-k3/Makefile                     |  7 +++++
>  arch/arm/mach-k3/jump_stub.S                  | 16 ++++++++++
>  common/spl/Kconfig                            |  2 +-
>  22 files changed, 89 insertions(+), 35 deletions(-)
>  create mode 100644 arch/arm/mach-k3/jump_stub.S
> 
> -- 
> 2.49.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
