Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643E5C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 15:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A0F8783B;
	Fri, 10 Nov 2023 16:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H22xTHpi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB3858783F; Fri, 10 Nov 2023 16:30:01 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7BAA87805
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 16:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AAFTtjK093072;
 Fri, 10 Nov 2023 09:29:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699630195;
 bh=qRAfeT+4NOlCPDuifAZOi/9UYKrJmmQP+JC90pNMDNo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=H22xTHpi/oT9oHWVax+NyVOE9SmIJzKyVEfaDd7R3mXw0AN6JIZKcWNYtVsgtlQFP
 ag08h9xbLv6cuEnbx9FYc696IpXudWUrRSoEnOL9dJlk2MhMOPs8wG7Nl9/aHU6WvA
 V5ml3R23R4kTGT7GRuT6/x3JadsX6gTgEN3eflQA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AAFTt3r005121
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 Nov 2023 09:29:55 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 09:29:54 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 09:29:54 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AAFTrXR023387;
 Fri, 10 Nov 2023 09:29:54 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v2 6/6] doc: spl: Add info regarding memory reservation and
 missing Kconfigs
Date: Fri, 10 Nov 2023 20:59:44 +0530
Message-ID: <20231110152944.647535-7-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110152944.647535-1-devarsht@ti.com>
References: <20231110152944.647535-1-devarsht@ti.com>
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

Add information regarding memory reservation scheme in SPL
and details regarding scheme which need to be followed while reserving
those areas which need to be preserved across bootstages.

Also add missing CONFIG_SPL Kconfigs and new ones which were added
recently.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V1->V3 : No change
---
 doc/develop/spl.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
index 76e87f07c7..fc570589eb 100644
--- a/doc/develop/spl.rst
+++ b/doc/develop/spl.rst
@@ -65,6 +65,15 @@ CONFIG_SPL_NAND_LOAD (drivers/mtd/nand/raw/nand_spl_load.o)
 CONFIG_SPL_SPI_LOAD (drivers/mtd/spi/spi_spl_load.o)
 CONFIG_SPL_RAM_DEVICE (common/spl/spl.c)
 CONFIG_SPL_WATCHDOG (drivers/watchdog/libwatchdog.o)
+CONFIG_SPL_SYSCON (drivers/core/syscon-uclass.o)
+CONFIG_SPL_GZIP (lib/gzip.o)
+CONFIG_SPL_VIDEO (drivers/video/video-uclass.o drivers/video/vidconsole-uclass.o)
+CONFIG_SPL_SPLASH_SCREEN (common/splash.o)
+CONFIG_SPL_SPLASH_SOURCE (common/splash_source.o)
+CONFIG_SPL_GPIO (drivers/gpio)
+CONFIG_SPL_DM_GPIO (drivers/gpio/gpio-uclass.o)
+CONFIG_SPL_BMP (drivers/video/bmp.o)
+CONFIG_SPL_BLOBLIST (common/bloblist.o)
 
 Adding SPL-specific code
 ------------------------
@@ -164,3 +173,16 @@ cflow will spit out a number of warnings as it does not parse
 the config files and picks functions based on #ifdef.  Parsing the '.i'
 files instead introduces another set of headaches.  These warnings are
 not usually important to understanding the flow, however.
+
+
+Reserving memory in SPL
+-----------------------
+
+If memory need to be reserved in RAM during SPL stage so that area won't get touched
+by SPL and/or u-boot, it need to be reserved starting from end of RAM.
+
+Also the regions which are to be preserved across further stages of boot need to be reserved first starting from
+framebuffer memory which must be reserved from end of RAM for which helper function spl_reserve_video_from_ram_top is provided.
+
+The corresponding information of reservation for those regions can be passed to further stages of boot using a bloblist.
+For e.g. the information for framebuffer area reserved by SPL can be passed onto u-boot using BLOBLISTT_U_BOOT_VIDEO.
-- 
2.34.1

