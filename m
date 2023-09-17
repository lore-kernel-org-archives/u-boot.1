Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88F6CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 12:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99070864B3;
	Sun, 17 Sep 2023 14:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="T0o+Y9V6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AAKqa6us";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 426E186545; Sun, 17 Sep 2023 14:54:28 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 228298640F
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 14:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RpSYZ0Qb4z9sGf;
 Sun, 17 Sep 2023 14:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694955266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ttjVQZ4VorAHeKzHbwCNN1tbMgr0CDsGZ/9spQL1NDE=;
 b=T0o+Y9V6RTpEfsFMB0OG/69kbpS4fwkL4yhFK1U+T0O2lcKK4LpO33BQVPk2tVHtG7rZzV
 ZyZGNpmXt9UYZIMomSGSAaJGDWJZ8uQBn6jIN+bO258F31hmbVhkJ6VCfCG2HPC9GCHFWz
 2n3+F77dT2FyuBoun0P+HBNGJaOsUgwCFC33HGUB7aFKc9vEiF82O3e5xqGPNDRn7u3ZAM
 rSfHo+loUJE5NDUHaU/22UwbZ0Txsxk5/qhI5mP8D/BXbxNPFPVl7rwXTfFHdMBuheBFJN
 Dk294YqkJRPKhaNeszA5ACYL6SIeK1yoyekSztJWvScSLtTmptq2iytgpH1WYQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694955264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ttjVQZ4VorAHeKzHbwCNN1tbMgr0CDsGZ/9spQL1NDE=;
 b=AAKqa6us45Os9HITuvh78vjM/DkSS6AD4+OEgUmeq1rpIf6E+oWtUG2wtzjLopRS8Q8MhU
 CEhD/Eyg1+DZt34avKzRKg1AXUBxt3nbzRpqqUcd5XId4RMYQSo+TBONEoyS8Mwt9zmdG6
 ows3hBDpbaP6nWVlf+WQRChDaVNkUipxJyMQXhsB5mw1f/F/yzyR3pIo2dFNmAF8e1m51W
 6pPZy09NcpTGcLXWFBIWDeVrNdVmGrwLLno3fPEmNWlp6tueXgWyFBc6Uupsx+vixl0Coc
 SH+oDx88HZwuPqd7EDczD6SGpCaB0YxtsftueIFNCmDqqDHH//jfgBlVq0bPhw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Sun, 17 Sep 2023 14:54:07 +0200
Message-Id: <20230917125407.378467-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: df65404860569ea2374
X-MBO-RS-META: 1m3b8xht5i4jhf8f89x18wb3yrp6nz1j
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

Two ethernet fixes for this release .

The following changes since commit 252592214f79d8206c3cf0056a8827a0010214e0:

  Merge tag 'doc-2023-10-rc5' of https://source.denx.de/u-boot/custodians/u-boot-efi (2023-09-09 09:33:02 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 075e0b9050e2ec1c6a521c0a1a98be4f7feb797b:

  ARM: renesas: Enable DM_ETH_PHY on 64-bit R-Car boards (2023-09-17 13:56:34 +0200)

----------------------------------------------------------------
Marek Vasut (2):
      ARM: dts: renesas: Add compatible properties to KSZ9031 Ethernet PHYs on Salvator-X boards
      ARM: renesas: Enable DM_ETH_PHY on 64-bit R-Car boards

 arch/arm/dts/salvator-common.dtsi    | 2 ++
 configs/r8a77970_eagle_defconfig     | 1 +
 configs/r8a77970_v3msk_defconfig     | 1 +
 configs/r8a77980_condor_defconfig    | 1 +
 configs/r8a77980_v3hsk_defconfig     | 1 +
 configs/r8a77990_ebisu_defconfig     | 1 +
 configs/r8a77995_draak_defconfig     | 1 +
 configs/r8a779a0_falcon_defconfig    | 1 +
 configs/r8a779g0_whitehawk_defconfig | 1 +
 configs/rcar3_salvator-x_defconfig   | 1 +
 configs/rcar3_ulcb_defconfig         | 1 +
 11 files changed, 12 insertions(+)
