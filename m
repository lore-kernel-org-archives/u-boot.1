Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B1AC369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CAF982CAC;
	Wed, 16 Apr 2025 09:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y43bqoej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3BCC82CD6; Wed, 16 Apr 2025 09:31:19 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D5D81E14
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7VFm3261706
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 02:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744788675;
 bh=b70juzi8/vzCOBAsOZDXtLU/xusY+0RmAYXJk5ByUZI=;
 h=From:To:CC:Subject:Date;
 b=y43bqoejrJNRK51kpRBa8qW6qH6FM5oRee5h454/paxTWlinGoMLG2w4Jp5K69cQN
 RtalGjKvf1KGOQLH6xZI6nptzlB7roqVzLyLu0dy/RsJe9t85QVK8Ubygr8UwNRC4i
 7jnhFdII439RLOe/R0/1XMOmr3VOlk98CdblSLT0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7VEsr120740
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 02:31:14 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 02:31:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 02:31:14 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G7VD4Y051418;
 Wed, 16 Apr 2025 02:31:14 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <nm@ti.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>
Subject: [PATCH v1 0/4] k3: migrate SPL_TEXT_BASE to new address
Date: Wed, 16 Apr 2025 13:00:53 +0530
Message-ID: <20250416073058.1441001-1-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The change to ATF's PRELOADED_BL33_BASE[1] requires respective changes to
SPL_TEXT_BASE on u-boot side. This is necessary to allow the ATF to jump
directly to linux kernel (like in falcon mode) which requires a 2MiB aligned
load address[2]. The current address ATF jumps to is 0x80080000 which is not
2MiB aligned.

Therefore in parallel to the ATF change, this patch set makes the corresponding
changes to u-boot. To maintain backwards compatibility with older ATF builds
(that still use older address of 0x80080000), the patch set also adds a
jump-stub which modifies the execution as follows:

Old ATF -> 0x80080000 -> 0x822000000 (Main domain SPL or kernel image)
           jump stub    SPL_TEXT_BASE

With the following instructions loaded by the jump-stub:
ADDR       | Instruction
0x80080000 |   mov x15, CONFIG_SPL_TEXT_BASE (0x822000000)
0x80080004 |   br x15

Depends on:
 * [PATCH v3] configs: set SPL_TEXT_BASE by default for k3 platforms
   https://lore.kernel.org/u-boot/20250415095028.446254-1-anshuld@ti.com/

[1]:
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/37447
[2]:
"The Image must be placed text_offset bytes from a 2MB aligned base
address anywhere in usable system RAM and called there."
- Documentation/arch/arm64/booting.rst (linux kernel)

Anshul Dalal (4):
  spl: Kconfig: k3: set SPL_TEXT_BASE to 0x82200000
  mach-k3: add a jump stub to support older ATF builds
  binman: k3: add jump-stub to tispl.bin
  binman: k3: add jump-stub as loadable

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  2 +-
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  4 +--
 arch/arm/dts/k3-am625-sk-binman.dtsi          |  4 +--
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  |  4 +--
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi |  4 +--
 arch/arm/dts/k3-am62a-sk-binman.dtsi          |  4 +--
 arch/arm/dts/k3-am62p-sk-binman.dtsi          |  2 +-
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi |  8 ++---
 arch/arm/dts/k3-am64x-binman.dtsi             |  8 ++---
 arch/arm/dts/k3-am65-iot2050-boot-image.dtsi  |  2 +-
 arch/arm/dts/k3-am65x-binman.dtsi             |  4 +--
 arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi  |  2 +-
 arch/arm/dts/k3-binman.dtsi                   | 31 +++++++++++++++++++
 arch/arm/dts/k3-j7200-binman.dtsi             |  4 +--
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  2 +-
 arch/arm/dts/k3-j721e-binman.dtsi             |  4 +--
 arch/arm/dts/k3-j721s2-binman.dtsi            |  4 +--
 arch/arm/dts/k3-j722s-binman.dtsi             |  2 +-
 arch/arm/dts/k3-j784s4-binman.dtsi            |  4 +--
 arch/arm/mach-k3/Makefile                     |  7 +++++
 arch/arm/mach-k3/jump_stub.S                  | 16 ++++++++++
 common/spl/Kconfig                            |  2 +-
 22 files changed, 89 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/mach-k3/jump_stub.S

-- 
2.49.0

