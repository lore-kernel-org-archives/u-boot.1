Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B26EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0800B864F6;
	Tue, 22 Aug 2023 18:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CSi7k7m2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BF138648C; Tue, 22 Aug 2023 18:41:20 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5250864B2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfBEj078800;
 Tue, 22 Aug 2023 11:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692722471;
 bh=eX1pQbU7/14Lx1QYLes3GhkNsgi/SkS+jR0xpIGfxv4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CSi7k7m2PGT+igymDuNHx6uF5Su/9ACvDeDQThfFrcg2Zn9YNo92m8/+jiRWmTZ4i
 sUvc42j3kMQRfKvExVBHGDN3Q25Tc8BoGgd0bmkTy8HT5JH8nPnnLKPFDjLNjdweFV
 iOtBCYHnOZiSSKAFFF87SwvWi1m7zHjodq28OK04=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MGfA3l105296
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 11:41:10 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 11:41:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 11:41:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MGfA7S022028;
 Tue, 22 Aug 2023 11:41:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Neha Malcom Francis
 <n-francis@ti.com>, <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 01/13] doc: board: ti: k3: image alt texts
Date: Tue, 22 Aug 2023 11:40:55 -0500
Message-ID: <20230822164107.2272231-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230822164107.2272231-1-nm@ti.com>
References: <20230822164107.2272231-1-nm@ti.com>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Provide alternative texts for images.

Fixes: 6e8fa0611f19 ("board: ti: k3: Convert boot flow ascii flow to svg")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes since v1:
* Minor expansion of WKUP domain, main domain.

V1: https://lore.kernel.org/r/20230819024948.30103-1-heinrich.schuchardt@canonical.com

 doc/board/ti/k3.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 5f9bd4dfcbe9..843e66eb2e60 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -48,6 +48,7 @@ including a 32bit U-Boot SPL, (called the wakup SPL) that ROM will jump
 to after it has finished loading everything into internal SRAM.
 
 .. image:: img/boot_flow_01.svg
+  :alt: Boot flow up to wakeup domain SPL
 
 The wakeup SPL, running on a wakeup domain core, will initialize DDR and
 any peripherals needed load the larger binaries inside the `tispl.bin`
@@ -57,6 +58,7 @@ starting with Trusted Firmware-A (TF-A), before moving on to start
 OP-TEE and the main domain's U-Boot SPL.
 
 .. image:: img/boot_flow_02.svg
+  :alt: Boot flow up to main domain SPL
 
 The main domain's SPL, running on a 64bit application core, has
 virtually unlimited space (billions of bytes now that DDR is working) to
@@ -65,6 +67,7 @@ which loads more firmware into the micro-controller & wakeup domains and
 finally prepare the main domain to run Linux.
 
 .. image:: img/boot_flow_03.svg
+  :alt: Complete boot flow up to Linux
 
 This is the typical boot flow for all K3 based SoCs, however this flow
 offers quite a lot in the terms of flexibility, especially on High
-- 
2.40.0

