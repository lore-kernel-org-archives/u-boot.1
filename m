Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C0EC47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9712287D14;
	Thu,  1 Feb 2024 04:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Y7i+vUrO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA5887CD4; Thu,  1 Feb 2024 04:06:56 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A611A87CE9
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41136c7O076958;
 Wed, 31 Jan 2024 21:06:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706756798;
 bh=UHFXe9c9NhXgYWqgaiMfRMC7veD2K/WYhKTrFhEkIBk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Y7i+vUrOjIVKpA4BZe0FEqpl21w6JZArRFhR2zuKixHYY4Z9ycwzSGtRTvkpkmKpA
 KnZxYSVBRi3A5JSeWITU3HNyRgNBsHbP3rOLp4sr/eZF4SvrOW6fZR6umKHbvbWxKA
 MD/lQfGWivGnO23uzbpGZkiZ2byg/4jcwgbEGV9o=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41136cmx124164
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 21:06:38 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 21:06:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 21:06:37 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41136bkx043593;
 Wed, 31 Jan 2024 21:06:37 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 11/13] Makefile: remove hardcoded device tree source
 directory
Date: Wed, 31 Jan 2024 21:06:47 -0600
Message-ID: <20240201030634.1120963-28-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201030634.1120963-16-bb@ti.com>
References: <20240201030634.1120963-16-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3355; i=bb@ti.com;
 h=from:subject; bh=5yIp7uMtn03XCKoZAQzNxJvJa3epd+SY7ltCTH16eHk=;
 b=owNCWmg5MUFZJlNZxMFQHgAAan////7f56+//nz7P3fqev/Tuy57b8cI3/6/+lv+vXjX/X+wA
 Rs1BigA0DRoAABoaAAAAAGgAaAaADQAGjT1ADRoNADQHlHqAB4ozSem1Q6BpoAaGhoDQAAA0APU
 0ADQZDQNND1ADI9QaNGmm1HpGmnpDQMjaj1NGhkaA00NAIaMgNNNA00MQDEAaNGE09QNNDQxADQ
 aGTQBkA0ZNDQaaNDE0AGTQDJkyZADICBKcLPG+d/xH0pDhojiI9o1+vVtsTe9UN0iYZ6o0HgRqO
 wFnAUQ23ATgdxhmCWGmarmo5mU5CfiQBkoQ2COA9GT+AxFJMDIteduVZMo49ooh110soUv0lZxM
 vs5dqcKaOs2jz+ajDqFFscESeRcY8xXJ0dkJXKrG4qmEayaEAwGeY1GCGCCHZcIlG9kJvYGXQCE
 kRwhzsg+pZP8grlAkHlcYMViohjFWvPN90/yie0KQ9o6ToSHiqfuq1gOEGYAilJLQSxJFWPsmmh
 udXpf6CUfjYMmv1yz5eVvXEEdeeWqe/08wjn9MvyBEKSpw4pMWdMAgOmbpfqpPNAXMV6MR+//ZL
 bSpFysQsNCOsNtgyVBbtVx6grZWfg7DcmWKpPjBlhAWxeC9JWNnWshuOblLhtEgASM/k4QYJ2ar
 9bnR8ooGX/F3JFOFCQxMFQHgA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Some boards that choose to utilize the OF_UPSTREAM directory for their
device tree files will need to specify that directory instead of the
traditional arch/$(ARCH)/dts/* path.

Include the correct path to the board's dtbs depending on if OF_UPSTREAM
is selected or not.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 Makefile             | 18 ++++++++++++++----
 scripts/Makefile.spl | 17 +++++++++++++----
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 996a43c8624ae..f81d09c892b80 100644
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
2.43.0

