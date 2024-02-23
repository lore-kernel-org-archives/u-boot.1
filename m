Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DCDC54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 20:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE2987C56;
	Fri, 23 Feb 2024 21:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="w+RW1/Ut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B6D87653; Fri, 23 Feb 2024 19:52:41 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ECD48765B
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 19:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41NIqKrq099093;
 Fri, 23 Feb 2024 12:52:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708714340;
 bh=EHksUa60zP5kHitYtm3xo7GZWCXL8PKXEBys8V71WoQ=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=w+RW1/UtYi4pFDgDiScaD0f4a0qLB2/QmYxHGvtvYb0IsgzeooepewRyX+erBmeBy
 T2glgsTxNGZvZnBmofQ5Uc5Gy9GVmwTGSTLOrukMVVBlRMem7UUxoHP270vJ0ye0fd
 xejnzxXLC3BWB0flDoyw7bKbJOGfiGVqoMj9MXo8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41NIqKww049331
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Feb 2024 12:52:20 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 12:52:19 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 12:52:19 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41NIpvhi051632; 
 Fri, 23 Feb 2024 12:52:09 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Tom Rini <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>, "Lukasz
 Majewski" <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Kever Yang <kever.yang@rock-chips.com>, Michal Simek
 <michal.simek@amd.com>, Marek Vasut <marex@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Tianling Shen
 <cnsztl@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, "Hari Nagalla" <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Roger Quadros <rogerq@kernel.org>,
 "Aradhya Bhatia" <a-bhatia1@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Bhavya Kapoor <b-kapoor@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Nikhil M Jain <n-jain1@ti.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Vignesh Raghavendra <vigneshr@ti.com>, Udit
 Kumar <u-kumar1@ti.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>, Jason
 Kacines <j-kacines@ti.com>, "Jayesh Choudhary" <j-choudhary@ti.com>, Andre
 Przywara <andre.przywara@arm.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v9 01/15] Makefile: remove hardcoded device tree source
 directory
Date: Sat, 24 Feb 2024 00:21:42 +0530
Message-ID: <20240223185156.3065032-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223185156.3065032-1-a-nandan@ti.com>
References: <20240223185156.3065032-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 23 Feb 2024 21:25:51 +0100
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

From: Bryan Brattlof <bb@ti.com>

Some boards that choose to utilize the OF_UPSTREAM directory for their
device tree files will need to specify that directory instead of the
traditional arch/$(ARCH)/dts/* path.

Include the correct path to the board's dtbs depending on if OF_UPSTREAM
is selected or not.

Signed-off-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
 Makefile             | 18 ++++++++++++++----
 scripts/Makefile.spl | 17 +++++++++++++----
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 0f0c7f30d27..51b57d26857 100644
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
index 407fc52376a..d074ba23500 100644
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
2.34.1

