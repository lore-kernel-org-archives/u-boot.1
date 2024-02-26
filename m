Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73C2C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 21:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C06287F70;
	Mon, 26 Feb 2024 22:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GgM+1mFA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A24687A80; Mon, 26 Feb 2024 22:19:41 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8975887F53
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 22:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJU1G069707;
 Mon, 26 Feb 2024 15:19:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708982370;
 bh=XnMrBygh2gY8g/SpGDgLkBTDA0A0TJL9gBEbfvF2X+M=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=GgM+1mFA0Lgg6pZRSADRGxfd0ekJo3LpUMiwgwcm2e/HQwCG0PGAZ4CLd4naYgMb3
 6kKug4CknPYrVnz+i0x7HYnt280f7wHtElh+0xIPqX/5TP9ezh4BpjmL5JSWsPAfjP
 IXfjvrT0CwXq9pUcc44hKaz6agdRzPv9vUbj7jBU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41QLJU0Z030255
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Feb 2024 15:19:30 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 15:19:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 15:19:30 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJU7s058320;
 Mon, 26 Feb 2024 15:19:30 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 26 Feb 2024 15:19:17 -0600
Subject: [PATCH v3 11/13] Makefile: remove hardcoded device tree source
 directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v3-11-04cbb42eaa6f@ti.com>
References: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Hari Nagalla
 <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3406; i=bb@ti.com;
 h=from:subject:message-id; bh=cIrtHofIBUWLazsj6sZH4cWfa3l79wsSh1XsLN0ZA/4=;
 b=owNCWmg5MUFZJlNZyMPmRwAAbH/////tt3197X/96/vf27vOxf//9fVXjE/vwz/ovvl3ld+wA
 RsxSBoNNNDQPUGIAANAAAAeoA00PU9QAAaAAGgAA0yAA00PUbSDyj1PUaaYTTaQ71QANAAADTQN
 AAMjQNGgANAY1AZGmmjQAAaGnqNAeoaA9TQA9QA09QB6jeqHQ2o0NNMQNBo0BkGho0GQ0aNADEA
 GhoZNGjQ0yGRhDQYgNNAAaNDIGTBADIAAMhXHgCtYV/yn6E1YN8hiBiTA6pT+vgryIDgtK/UXjN
 6E6YGPhCamxknI1Qy9li8B430WIvMr3fF9QGpRdL/Sp/MJrkheuL14RNZQ8LWYlXH8idGK28qlI
 fo0SRoEcdImaHW6O1EZ6rscqiKPUkHAk46XcliE2p8LMogbeycL3T748OojPVGaMlkyIBhuhmS6
 dgVTaKXoDOBJBRWVUuazPo0m1x8IYrqVGke4R7BFuSiUnZ1YAWRfygTgQrcvzt6XOXmvFjbMBcO
 LEGyd8faWyQ/YqEBIQHiiVY6VzWHsYP9QqQqlRYzzOnKY/cbde538tWyOMkpPo3H6pJBdHEH6RY
 r+ZzCKMGG5exGOArsFB9oRshCCLAdFOFQAvGpLCGT9bbgYfuZeIA2hR0ouiYXwUoQmNkDKcGNvI
 4JKYB612Wz/i7kinChIZGHzI4A=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Some boards that choose to utilize the OF_UPSTREAM directory for their
device tree files will need to specify that directory instead of the
traditional arch/$(ARCH)/dts/* path.

Include the correct path to the board's dtbs depending on if OF_UPSTREAM
is selected or not.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 Makefile             | 18 ++++++++++++++----
 scripts/Makefile.spl | 17 +++++++++++++----
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 0f0c7f30d2717..51b57d26857f1 100644
--- a/Makefile
+++ b/Makefile
@@ -1184,6 +1184,16 @@ dt_binding_check: scripts_dtc
 quiet_cmd_copy = COPY    $@
       cmd_copy = cp $< $@
 
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+ifeq ($(CONFIG_ARM64),y)
+dt_dir := dts/upstream/src/arm64
+else
+dt_dir := dts/upstream/src/$(ARCH)
+endif
+else
+dt_dir := arch/$(ARCH)/dts
+endif
+
 ifeq ($(CONFIG_MULTI_DTB_FIT),y)
 
 ifeq ($(CONFIG_MULTI_DTB_FIT_LZO),y)
@@ -1209,7 +1219,7 @@ endif
 
 MKIMAGEFLAGS_fit-dtb.blob = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
 	-a 0 -e 0 -E \
-	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) -d /dev/null
+	$(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) -d /dev/null
 
 MKIMAGEFLAGS_fit-dtb.blob += -B 0x8
 
@@ -1407,9 +1417,9 @@ MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
 	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
 	-p $(CONFIG_FIT_EXTERNAL_OFFSET) \
 	-n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
-	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(DEVICE_TREE))) \
-	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) \
-	$(patsubst %,-b arch/$(ARCH)/dts/%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
+	$(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(DEVICE_TREE))) \
+	$(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) \
+	$(patsubst %,-b $(dt_dir)/%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
 else
 MKIMAGEFLAGS_u-boot.img = -A $(ARCH) -T firmware -C none -O u-boot \
 	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
diff --git a/scripts/Makefile.spl b/scripts/Makefile.spl
index 407fc52376a50..d074ba2350065 100644
--- a/scripts/Makefile.spl
+++ b/scripts/Makefile.spl
@@ -559,9 +559,15 @@ FORCE:
 $(obj)/dts/dt-$(SPL_NAME).dtb: dts/dt.dtb
 	$(Q)$(MAKE) $(build)=$(obj)/dts spl_dtbs
 
-PHONY += dts_dir
-dts_dir:
-	$(shell [ -d $(obj)/dts ] || mkdir -p $(obj)/dts)
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+ifeq ($(CONFIG_ARM64),y)
+dt_dir := dts/upstream/src/arm64
+else
+dt_dir := dts/upstream/src/$(ARCH)
+endif
+else
+dt_dir := arch/$(ARCH)/dts
+endif
 
 # Declare the contents of the .PHONY variable as phony.  We keep that
 # information in a variable so we can use it in if_changed and friends.
@@ -569,8 +575,11 @@ dts_dir:
 
 SPL_OF_LIST_TARGETS = $(patsubst %,dts/%.dtb,$(subst ",,$(CONFIG_SPL_OF_LIST)))
 SHRUNK_ARCH_DTB = $(addprefix $(obj)/,$(SPL_OF_LIST_TARGETS))
+$(dir $(SHRUNK_ARCH_DTB)):
+	$(shell [ -d $@ ] || mkdir -p $@)
+
 .SECONDEXPANSION:
-$(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, arch/$(ARCH)/dts/%, $$@) dts_dir
+$(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, $(dt_dir)/%, $$@) $(dir $(SHRUNK_ARCH_DTB))
 	$(call if_changed,fdtgrep)
 
 targets += $(SPL_OF_LIST_TARGETS)

-- 
2.43.2

