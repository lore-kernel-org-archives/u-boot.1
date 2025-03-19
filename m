Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1077BC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 08:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C8CA8197D;
	Wed, 19 Mar 2025 09:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="M+VUhi1k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC6181101; Wed, 19 Mar 2025 09:48:02 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 088DB81B52
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 09:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=f-akthar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52J8lwvK278795
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 03:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742374078;
 bh=uIyo3b7+acHUVvUuF5wB350XwXFnPdBK9mVuMysk7yM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=M+VUhi1k6L9Kz4A4LTI3sozQ/WFgABehf5sqpH+BjdaJ8wAZsmfIlJeNlARd9w6Yd
 KAkl6L9moH8DLxw/NfwlTORRgD/KSTvXZ9kz/DcemWR5ug3w4Z5lDs//j0HMP9ugMs
 EA2mkbmFHlzB7RCLOUU8NBvxZEF1lwQ0TQdk9lUw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52J8lwks120725
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Mar 2025 03:47:58 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 03:47:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 03:47:57 -0500
Received: from localhost (fayaz-hp-z2-tower-g4-workstation.dhcp.ti.com
 [172.24.227.181] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52J8lv39054658;
 Wed, 19 Mar 2025 03:47:57 -0500
From: Harsha Vardhan V M <h-vm@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>
Subject: [PATCH 5/5] doc: cmd: Add fuse writebuff cmd documentation
Date: Wed, 19 Mar 2025 14:17:14 +0530
Message-ID: <20250319084714.335777-6-h-vm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319084714.335777-1-h-vm@ti.com>
References: <20250319084714.335777-1-h-vm@ti.com>
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

Add fuse writebuff sub-system command documentation.

Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
---
 doc/usage/cmd/fuse.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/usage/cmd/fuse.rst b/doc/usage/cmd/fuse.rst
index 6e330eddfea..42c6e209f99 100644
--- a/doc/usage/cmd/fuse.rst
+++ b/doc/usage/cmd/fuse.rst
@@ -17,6 +17,7 @@ Synopsis
     fuse sense <bank> <word> [<cnt>]
     fuse prog [-y] <bank> <word> <hexval> [<hexval>...]
     fuse override <bank> <word> <hexval> [<hexval>...]
+    fuse writebuff [-y] <addr>
 
 Description
 -----------
@@ -79,6 +80,16 @@ Commands
   fuses have already been programmed or are locked (if the SoC allows to
   override a locked fuse).
 
+- **fuse writebuff [-y] <addr>**
+  Programs fuse data using a structured buffer in memory starting at 'addr'.
+  This operation directly affects the fusebox and is irreversible.
+
+  The structure of the buffer should contain all necessary details for
+  programming fuses, such as the values to be written to the fuse, optional
+  metadata for validation or programming constraints and any configuration
+  data required for the operation. Define CONFIG_CMD_FUSE_WRITEBUFF to
+  enable the fuse writebuff command.
+
 Examples
 --------
 
@@ -144,10 +155,19 @@ fuse override
     u-boot=> fuse override 0 1 0x00000003
       Overriding bank 0 word 0x00000001 with 0x00000003...
 
+fuse writebuff
+~~~~~~~~~~~~~~
+
+::
+
+    u-boot=> fuse writebuff -y 0x84000000
+      Programming fuses with buffer at addr 0x84000000
+
 Configuration
 -------------
 
 The fuse commands are available if CONFIG_CMD_FUSE=y.
+The fuse writebuff command is available if CONFIG_CMD_FUSE_WRITEBUFF=y.
 
 Return code
 -----------
-- 
2.34.1

