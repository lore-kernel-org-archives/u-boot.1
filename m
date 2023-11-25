Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEB1C4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 16:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 202B7874DE;
	Sat, 25 Nov 2023 17:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qxJND4Q6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4312687174; Sat, 25 Nov 2023 17:27:24 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 303D0870D9
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 17:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3APGRIgT082171;
 Sat, 25 Nov 2023 10:27:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700929638;
 bh=cF8F3kxks7MOpRiuUrNMvUM6gntojY+xNj5iPzYqkZY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=qxJND4Q6fEll/0i7V/DUIbG+ZuPEG00z7RFG6NZ+soitJnGPxlNvHllxVdjqI+ILX
 xr931Uzk7R53ChOehN+6m4VxYdX2JSbcarHN2qXYlJuJZ3anREHEELbjhNge6+60cl
 Ur2xY7dKziuKKTzE1r8nxxJDjbfDQx8mFDdYRTKU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3APGRIKE031324
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 25 Nov 2023 10:27:18 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 25
 Nov 2023 10:27:17 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 25 Nov 2023 10:27:17 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3APGRHov003154;
 Sat, 25 Nov 2023 10:27:17 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v4 8/8] doc: spl: Add info regarding memory reservation
Date: Sat, 25 Nov 2023 21:57:05 +0530
Message-ID: <20231125162705.1383401-9-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125162705.1383401-1-devarsht@ti.com>
References: <20231125162705.1383401-1-devarsht@ti.com>
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

Add details regarding scheme which need to be followed in SPL and
further stages for those regions which need to be preserved across
bootstages.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V1->V3:
No change.

V4:
Split this to separate patch and add more details regarding
memory reservation scheme that needs to be followed at SPL.
---
 doc/develop/spl.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
index 814530d348..0a3e572310 100644
--- a/doc/develop/spl.rst
+++ b/doc/develop/spl.rst
@@ -173,3 +173,31 @@ cflow will spit out a number of warnings as it does not parse
 the config files and picks functions based on #ifdef.  Parsing the '.i'
 files instead introduces another set of headaches.  These warnings are
 not usually important to understanding the flow, however.
+
+
+Reserving memory in SPL
+-----------------------
+
+If memory needs to be reserved in RAM during SPL stage with the requirement that
+the SPL reserved memory remains preserved across further boot stages too
+then it needs to be reserved mandatorily starting from end of RAM. This is to
+ensure that further stages can simply skip this region before carrying out
+further reservations or updating the relocation address.
+
+Also out of these regions which are to be preserved across further stages of
+boot, video framebuffer memory region must be reserved first starting from
+end of RAM for which helper function spl_reserve_video_from_ram_top is provided
+which makes sure that video memory is placed at top of reservation area with
+further reservations below it.
+
+The corresponding information of reservation for those regions can be passed to
+further boot stages using a bloblist. For e.g. the information for
+framebuffer area reserved by SPL can be passed onto U-boot using
+BLOBLISTT_U_BOOT_VIDEO.
+
+The further boot stages need to parse each of the bloblist passed from SPL stage
+starting from video bloblist and skip this whole SPL reserved memory area from
+end of RAM as per the bloblists received, before carrying out further
+reservations or updating the relocation address. For e.g, U-boot proper uses
+function "setup_relocaddr_from_bloblist" to parse the bloblists passed from
+previous stage and skip the memory reserved from previous stage accordingly.
-- 
2.34.1

