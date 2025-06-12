Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863AAC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 23:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9A1E82C30;
	Fri, 13 Jun 2025 01:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A673A82C2F; Fri, 13 Jun 2025 01:19:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E032C828A2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 01:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF9C41CDD;
 Thu, 12 Jun 2025 16:19:33 -0700 (PDT)
Received: from e134369.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 208633F59E;
 Thu, 12 Jun 2025 16:19:52 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 0/2] sunxi: add YuzukiHD Chameleon board support
Date: Fri, 13 Jun 2025 00:19:43 +0100
Message-ID: <20250612231945.981893-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

The Chaemeleon board is an Open Source hardware devboard developed by
YuzukiHD, featuring an Allwinner H618 SoC.
Import the devicetree, recently merged into the Linux kernel tree, and
add the defconfig, to allow mainline U-Boot on this board. Since the SoC
is quite well supported, there is not much else to add at this point.

Cheers,
Andre

Andre Przywara (2):
  arm64: dts: allwinner: h616: add YuzukiHD Chameleon support
  sunxi: H616: add support for YuzukiHD Chameleon board

 configs/yuzukihd-chameleon_defconfig          |  30 +++
 .../sun50i-h618-yuzukihd-chameleon.dts        | 222 ++++++++++++++++++
 2 files changed, 252 insertions(+)
 create mode 100644 configs/yuzukihd-chameleon_defconfig
 create mode 100644 dts/upstream/src/arm64/allwinner/sun50i-h618-yuzukihd-chameleon.dts

-- 
2.43.0

