Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824E9CF6483
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 21:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A9B889146;
	Fri, 27 Sep 2024 23:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727473818;
	bh=/sQ+rDYtPETxrPiY6FHv61y1h6bDxssyw3ViFw7Uh8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=chqum+/Tz1ATZFhkdPz6nlKRRglclRo3unN5eUZSB9b2Ole3cq0x4pcJhVG2T+ZYK
	 rqOUiUXmyW5Vm29kX5SBKnbHX6GtO/DLn/31M1SEOMAPaS26Sb2Ke5n+sxskxLx+qw
	 L7/2QEo4c5qS6QXhWgC4jFhmQ8GPBt4CPnMjAu1ftgAwVbShxkiP59t6ZXFLJjJeJ8
	 lI/7GDd1HZFt1yuoi8KMAqsGK91YiAC2vtAOpxSPr5Y8aLMMGh8pgKMubE3YfEZe3K
	 ruX0mRYrt8xlgz1QK0pX4z9qQwq7HOD763brSbRynYyutbCikx1fvGUVxVCuHaEOER
	 NpEMbHPRQ6BzQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 21C788910E;
 Fri, 27 Sep 2024 23:50:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727473814;
 bh=/sQ+rDYtPETxrPiY6FHv61y1h6bDxssyw3ViFw7Uh8Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tDYR6UGBVPd63LKItblK/EWL/4maOkJiJnVgmApgB37PEkv8rrJ9RZ5SXNrurrYcn
 IXB4cYQcISD1d3HdgBc5TA0xxlAsfIuj3VjC+wkkK4T17KnsKc+GV3eB4DaILinK6w
 yO3s07t2Rx9G4TlOORh/e3eW9mWxmMv1XRPk3TFdIQPGgW3mj7xrNbyP28qdo1MtbH
 MIydFVT3635FlzCq8UNRhVZ/5Y7IUfyi6uUxOYCvVBb7H2DUJhR6x2YQBSZzrqBp9X
 zRRJFgGym4dabiiIEcuRgsePzGrXqnIgs8HvTHgX2O+LBWpQ+6bzeDOmV2i2sHgNT7
 KMcpiIuDvopFg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH 2/3] dts: Add ability to build DTOs only from arch/$(ARCH)/dts
Date: Fri, 27 Sep 2024 23:48:28 +0200
Message-ID: <20240927214955.394224-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240927214955.394224-1-marex@denx.de>
References: <20240927214955.394224-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently the enablement of OF_UPSTREAM results on the build system
searching for DTs only in dts/upstream/ . There are platforms which
use U-Boot specific DTBOs applied on top of U-Boot control DT during
SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.

Add dedicated 'dtbos' target which builds only .dtbos and not .dtbs and
in case OF_UPSTREAM is enabled, build this target for arch/$(ARCH)/dtb
to generate local U-Boot specific DTBOs.

Adjust top level Makefile so binman would search for .dtb and .dtbo in
both OF_UPSTREAM specific paths and arch/$(ARCH)/dtb for the .dtbo case.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 Makefile             |  5 ++++-
 dts/Makefile         | 11 +++++++++--
 scripts/Makefile.dts |  5 ++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 525576f987d..fba8e48681e 100644
--- a/Makefile
+++ b/Makefile
@@ -1194,6 +1194,8 @@ else
 dt_dir := arch/$(ARCH)/dts
 endif
 
+local_dto_dir := arch/$(ARCH)/dts
+
 ifeq ($(CONFIG_MULTI_DTB_FIT),y)
 
 ifeq ($(CONFIG_MULTI_DTB_FIT_LZO),y)
@@ -1377,7 +1379,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		build -u -d u-boot.dtb -O . -m \
 		--allow-missing $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
 		-I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
-		-I $(dt_dir) -a of-list=$(CONFIG_OF_LIST) \
+		-I $(dt_dir) -I $(local_dto_dir) \
+		-a of-list=$(CONFIG_OF_LIST) \
 		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
 		-a atf-bl31-path=${BL31} \
 		-a tee-os-path=${TEE} \
diff --git a/dts/Makefile b/dts/Makefile
index d6c2c9daf31..f872a867667 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -11,12 +11,16 @@ DEVICE_TREE := unset
 endif
 
 ifeq ($(CONFIG_OF_UPSTREAM),y)
+local_dtbos := local-dtbos
+local_dtbo_dir := arch/$(ARCH)/dts
 ifeq ($(CONFIG_ARM64),y)
 dt_dir := dts/upstream/src/arm64
 else
 dt_dir := dts/upstream/src/$(ARCH)
 endif
 else
+local_dtbos :=
+local_dtbo_dir :=
 dt_dir := arch/$(ARCH)/dts
 endif
 
@@ -40,7 +44,7 @@ endif
 
 targets += dt.dtb
 
-$(DTB): arch-dtbs
+$(DTB): arch-dtbs $(local_dtbos)
 	$(Q)test -e $@ || (						\
 	echo >&2;							\
 	echo >&2 "Device Tree Source ($@) is not correctly specified.";	\
@@ -49,10 +53,13 @@ $(DTB): arch-dtbs
 	echo >&2;							\
 	/bin/false)
 
-PHONY += arch-dtbs
+PHONY += arch-dtbs local-dtbos
 arch-dtbs:
 	$(Q)$(MAKE) $(build)=$(dt_dir) dtbs
 
+local-dtbos:
+	$(Q)$(MAKE) $(build)=$(local_dtbo_dir) dtbos
+
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
 # support "out-of-tree" build for dtb-spl
diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 1fe142f2bbf..f4d3a37010a 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -17,8 +17,11 @@ endif
 
 targets += $(dtb-y)
 
-PHONY += dtbs
+PHONY += dtbs dtbos
 dtbs: $(addprefix $(obj)/, $(dtb-y))
 	@:
 
+dtbos: $(addprefix $(obj)/, $(filter-out %.dtb,$(dtb-y)))
+	@:
+
 clean-files := *.dtb *.dtbo */*.dtb */*.dtbo *_HS
-- 
2.45.2

