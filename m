Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4B0C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 11:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40BB0879FC;
	Fri, 23 Feb 2024 12:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q+hiF7XW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 917DC87ABC; Fri, 23 Feb 2024 06:25:04 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C548C87A00
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 06:25:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41N5Os5C032570;
 Thu, 22 Feb 2024 23:24:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708665894;
 bh=2K0JU3P7xrBxjDmE4Cz/K3BMaVtup8HYnZQUcPda10o=;
 h=From:To:CC:Subject:Date;
 b=q+hiF7XWg0pVLsQFf1a34q90Ibn6lBImsfBg9a7S+unqR+jlyj0JcKJGsEA+esl1b
 4+QPlYFLML2rg1WOYYVESEFs6ORaFKBQ9hXbstmC3pJn8OqlFHkhNSIfsc9BHHjyLZ
 OC0MmNtuwL8HwyPadyaukeTMljsV7unGxG0KS8KE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41N5Osmr007926
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Feb 2024 23:24:54 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 23:24:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 23:24:54 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41N5OsZa035157;
 Thu, 22 Feb 2024 23:24:54 -0600
From: Jonathan Humphreys <j-humphreys@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH 0/2] enable OSPI support on AM64x
Date: Thu, 22 Feb 2024 23:24:36 -0600
Message-ID: <20240223052438.2013610-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 23 Feb 2024 12:56:24 +0100
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

This series enables OSPI support for AM64x by setting the proper configs, and DT
entries for SPL.

fixes: fa09b12dc5f6 ("arm: ti: k3: Resync dts files and bindings with Linux Kernel v5.14")

Jonathan Humphreys (2):
  configs: am64x_evm_*_defconfig: Enable OSPI support
  arm: dts: k3-am642-evm/sk: Enable OSPI support in SPL

 arch/arm/dts/k3-am642-evm-u-boot.dtsi | 24 ++++++++++++++++++++++++
 arch/arm/dts/k3-am642-r5-evm.dts      |  5 +++++
 arch/arm/dts/k3-am642-r5-sk.dts       |  5 +++++
 arch/arm/dts/k3-am642-sk-u-boot.dtsi  | 24 ++++++++++++++++++++++++
 configs/am64x_evm_a53_defconfig       | 14 ++++++++++++--
 configs/am64x_evm_r5_defconfig        | 14 ++++++++++++--
 6 files changed, 82 insertions(+), 4 deletions(-)

-- 
2.34.1

