Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07585C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 22:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FD5088550;
	Sat,  8 Jun 2024 00:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SR70E3W6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F355884D5; Sat,  8 Jun 2024 00:39:43 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37DD9884A9
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 00:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457MdUaO026904;
 Fri, 7 Jun 2024 17:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717799970;
 bh=ZB4Yg/YoBeu8s1O8mXYXK1nIo+TRa5YumnFSn1ikL7Y=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=SR70E3W6/67VpLsyAdz0XtYh5PhMaH7aL+QJ/itOoMEMjpnmr3rbZBK5JQz+VuRx+
 ZWleTAyWK0OXB5yHMKmGqEGNNN2B5MAD7hPrvF5v6GApXj61tW1NV5OcdyKwVCf9jk
 Xyfd/uWts0iX3c2FirCyTU3SpVg65lApLdzmssFU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457MdUlg093524
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Jun 2024 17:39:30 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 17:39:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 17:39:30 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457MdTxl011241;
 Fri, 7 Jun 2024 17:39:29 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v6 01/24] doc: uefi: capsules: Add Capsule Update porting
 section
Date: Fri, 7 Jun 2024 17:38:35 -0500
Message-ID: <20240607223858.1971290-2-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607223858.1971290-1-j-humphreys@ti.com>
References: <20240607223858.1971290-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Created a capsule update porting section in the documentation that outlines
the steps a board developer must do when porting from an existing reference
board implementation.

In particular, added a big warning that new capsule GUID's need to be
defined.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 doc/develop/uefi/uefi.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 0389b269c01..36ac75278fa 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -631,6 +631,18 @@ where version.dtso looks like::
 The properties of image-type-id and image-index must match the value
 defined in the efi_fw_image array as image_type_id and image_index.
 
+Porting Capsule Updates to new boards
+*************************************
+
+It is important, when using a reference board as a starting point for a custom
+board, that certain steps are taken to properly support Capsule Updates.
+
+Capsule GUIDs need to be unique for each firmware and board. That is, if two
+firmwares are built from the same source but result in different binaries
+because they are built for different boards, they should have different GUIDs.
+Therefore it is important when creating support for a new board, new GUIDs are
+defined in the board's header file.  *DO NOT* reuse capsule GUIDs.
+
 Executing the boot manager
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.34.1

