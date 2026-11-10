Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB8606A331
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QnzZqYdW;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=AfE+/y5B
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C20D810A1;
	Tue, 10 Nov 2026 07:54:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dGwd1UljxKny; Tue, 10 Nov 2026 07:54:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 67F198104D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794297269;
	b=m5qKSitmE5fbNXulqO80suhboKoeYaR165z4N9LE0qhIFyS5I2VSkmQqZnk+vhOyy4sx
	 Zu3KKXfDtUNju599V3yHFaOALzOGZAjMh8IX8q1QCx1jn/6qok0eFO7g51SrYzTH7K5Vg
	 1c21Vj2+2l5KONy518QXvIUTCWE6Cl37ixS1OIqi/OTcolcnqse+dn1Jugb2BF/+vCbLF
	 fG7mxm2DjUVMqba5WzDdaOeYQBIPfZxy2AEPg/17UA3H0ioDKkw2hj3s/+unlLzecyv3v
	 K1+LOL7iTlCueCuUedr6PvKC3kAHAtRKAj3kWJqIJEd29WaE622IKCcPZ0ojZVnNbbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794297269;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Pwzy6b/ib7WzCnw7Row4htevSlQQLeKT8O3afWXBCUw=;
	b=KvuPOSDHbi5CU0WdQWhriQrBapRCKQyD7Q5laKftXRQ3xH2KE82Ue2edfsLVnKHOprjP
	 05GMmyR0tE6i5vtMDoudj8epA9CDl8mNimFzTKzK7hFkIy9VipUThnM4QgiNRnS4+TbPf
	 PUmOEbK7M3s9rCfM++2PrZevJb+Op0Pir7cqkgcHIZrLKM5L4b4xcaFTe10NgbAArPet8
	 5aspzkxIkXE/TKTaO+ilZ4+13jWsCYZH2/DAGvt+oHHdum2XtHP/thujpRqnBO3eX8Rcm
	 e8hFwfkj/vynf408D3JEn7JFfemuJGvG1h7/KWb6CJC1ZG+9dX8EpkGGB0vTj8SdcWA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b="AfE+/y5B";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794297269;
	bh=Pwzy6b/ib7WzCnw7Row4htevSlQQLeKT8O3afWXBCUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QnzZqYdW5k2ejAvPrpUi7BCHBzpo5uEWWP4P6Wykwfjols32VvGGvj3JHQeicXXPQ
	 FrmlnpyA0dmtCKqWTknADhj5FPJayaLFaDlGwK8nEnjbxSEopcGppptfwX6eBksmGI
	 PZPt415McDkMLG6lCG0bl3LabmY1UrlcQ9NhNFYjsjN13jN5OuMXcidr6YWCQTOdww
	 rA/GsgIV9W6jD29X97LrMg2LZTILmcmWV4edlb14YDH1Q2Z6aAscTEzkcmnBzvXEB1
	 wkeajl6mnAK09llQNeZd3e+Cd+93h5PAKa3HhrVR2pm5/kag5HcFMM5nVIXJFe1Mjx
	 gEUIPzJO0YDWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67F198104D;
	Tue, 10 Nov 2026 07:54:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ABB3631F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9155D8104D
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:54:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VhBn9dt-Aagl for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 07:54:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5461A80FFE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=AfE+/y5B
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5461A80FFE
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 07:54:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 96EF1B0055A;
 Tue, 10 Nov 2026 08:54:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1794297264;
 bh=kKHFo8BdBBbffU7Z8LnhJjMq1IN7t+5btasxjX/0+Io=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AfE+/y5ByNAageqWB+oAnUADIfQFwsvDpWrIHfp9N1ADskoJOX8oagmjq1Iv/pSRy
 tS4HDGf6a2gI6uspachfuMFW7lvnd8+rPFplzub/7tqp6NPNqWsIqBoDAi6hcoXi+x
 pVJfzDeVeHMPrZvJlvZH7eTApvSi0x8DI6OXOrMxGHh32CZe9szHdFhbepY6Y6Xoam
 h9xNGUc82Zsy+cDmZkX8XUnQol7pHccHBbYj747O7BBGzxp4d4hvXBLFThtdd9TnAd
 oSTbw+HJ1ZPwibhBECUfCk65is3fBKBT3uxHVROg0cCvCFLdzExluO/+0E2iEgBER/
 vXh3kf7iVw66Q==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Denis Mukhin <dmukhin@ford.com>, E Shattow <e@freeshell.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vincent Jardin <vjardin@free.fr>,
 =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes=20=28Schneider=20Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v2 3/3] dts: build the device tree from a directory outside
 the tree, EXT_DTS_DIR
Date: Tue, 10 Nov 2026 08:52:56 +0100
Message-ID: <20261110075256.1800130-4-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110075256.1800130-1-vjardin@free.fr>
References: <20261110075256.1800130-1-vjardin@free.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A board whose device tree is not in U-Boot directories has to be
copied in:

- Buildroot copies the .dts of BR2_TARGET_UBOOT_CUSTOM_DTS_PATH into
arch/<arch>/dts, it adds/patches a dtb-y line with sed, it copies
into dts/upstream/src/<arch>/<vendor>

- A Yocto layer does about the same in its do_configure. Each copy depends
on the layout of the release it targets, and the -u-boot.dtsi has to go to
yet another place. EXT_DTB takes a .dtb compiled elsewhere, without the
include paths, the -u-boot.dtsi and the DEVICE_TREE_INCLUDES of the
U-Boot build.

Let's add EXT_DTS_DIR=<dir>:
the .dts of DEVICE_TREE, OF_LIST, SPL_OF_LIST and OF_OVERLAY_LIST
which are compiled from that directory instead of dt_dir.
It can use scripts/Makefile.dts as dts/upstream is, with the same automatic
.dtsi handling and the same include paths, where the directory stands in
for dt_dir: an OF_UPSTREAM board which keeps its <vendor>/ subdirectory
finds the SoC files of dts/upstream before the older copies of
arch/<arch>/dts, as in the tree.

The directory is only read: the .dtb files are generated into dts/external
of the build tree, based on dt_dir, so dt.dtb, u-boot.img, fit-dtb.blob
and binman use them from there.

A Makefile or Kbuild in the directory is used if present, to add DTC_FLAGS
or dtb-y entries, if not scripts/Makefile.dts is used.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v2:
- Rebase on next, v2027.01-rc2
- control.rst: for a WIP board that (Tom Rini)
- 3/3 log: wording: directories, not folders (Marek Vasut)

 .gitignore                         |  1 +
 Makefile                           |  9 +++++-
 doc/develop/devicetree/control.rst | 45 +++++++++++++++++++++++++++++-
 dts/Makefile                       | 20 +++++++++++--
 scripts/Makefile.build             | 11 +++++++-
 scripts/Makefile.dts               |  9 ++++++
 scripts/Makefile.lib               | 10 +++++--
 7 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/.gitignore b/.gitignore
index 5cb135fc58c..f829c0e05ee 100644
--- a/.gitignore
+++ b/.gitignore
@@ -19,6 +19,7 @@
 *.dtb.clean.dts
 *.dtb.diff
 *.dtb.full.dts
+/dts/external/
 *.elf
 *.exe
 *.fit
diff --git a/Makefile b/Makefile
index 519866b82ea..ceecb92a281 100644
--- a/Makefile
+++ b/Makefile
@@ -834,6 +834,13 @@ else
 dt_dir := arch/$(ARCH)/dts
 endif
 
+ifneq ($(EXT_DTS_DIR),)
+dt_src_dir := $(abspath $(EXT_DTS_DIR))
+dt_dir := dts/external
+else
+dt_src_dir := $(dt_dir)
+endif
+
 include $(srctree)/arch/$(ARCH)/Makefile
 endif
 endif
@@ -1468,7 +1475,7 @@ fit-dtb.blob.gz: fit-dtb.blob
 fit-dtb.blob.lzo: fit-dtb.blob
 	@lzop -f9 $< > $@
 
-of_list_srcs := $(patsubst %,$(dt_dir)/%.dts,$(subst ",,$(CONFIG_OF_LIST)))
+of_list_srcs := $(patsubst %,$(dt_src_dir)/%.dts,$(subst ",,$(CONFIG_OF_LIST)))
 fit-dtb.blob: dts/dt.dtb $(of_list_srcs) FORCE
 	$(call if_changed,mkimage)
 ifneq ($(SOURCE_DATE_EPOCH),)
diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 5c1b46b94ab..83af5eab309 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -120,6 +120,13 @@ prompted by Kconfig. Another option is that you can use the "pick" option of
 `tools/update-subtree.sh` mentioned above to bring in the commits that you
 need.
 
+A board that is not finalized yet, during its bring-up or while its
+devicetree source is maintained with the kernel's, can build it from a
+directory outside the tree using `EXT_DTS_DIR` (see :ref:`extdtsdir`). It is a
+make variable, like `EXT_DTB` and `DEVICE_TREE`: no defconfig sets it and no
+board in the tree depends on it. A board sent upstream shall still come with its
+devicetree source, in `dts/upstream` or `arch/<arch>/dts` as above.
+
 This should include your CPU or SoC's devicetree file. On top of that any U-Boot
 specific tweaks (see: :ref:`dttweaks`) can be made for your board.
 
@@ -152,7 +159,8 @@ EXT_DTB=<filename> to 'make', as in::
    make EXT_DTB=boot/am335x-boneblack-pubkey.dtb
 
 Then U-Boot will copy that file to u-boot.dtb, put it in the .img file
-if used, and u-boot-dtb.bin.
+if used, and u-boot-dtb.bin. To compile the devicetree from files
+outside the tree instead, see :ref:`extdtsdir`.
 
 If you wish to put the fdt at a different address in memory, you can
 define the "fdtcontroladdr" environment variable. This is the hex
@@ -232,6 +240,41 @@ outside the U-Boot repository. You can use `DEVICE_TREE_INCLUDES` Kconfig
 option to specify a list of .dtsi files that will also be included when
 building .dtb files.
 
+.. _extdtsdir:
+
+Devicetree sources outside the tree
+-----------------------------------
+
+A board may keep its devicetree sources outside U-Boot: in a board support
+layer of Yocto or Buildroot, or in a repository shared with the kernel during
+a bring-up. Point the build at that directory with `EXT_DTS_DIR`::
+
+   make EXT_DTS_DIR=/path/to/dts DEVICE_TREE=myboard
+
+The `.dts` files of `DEVICE_TREE`, `OF_LIST`, `SPL_OF_LIST` and
+`OF_OVERLAY_LIST` are then compiled from that directory instead of
+`arch/<arch>/dts` or `dts/upstream/src/<arch>`, with the same include paths,
+so they may include the SoC files of either, and with the same automatic
+`*-u-boot.dtsi` and `DEVICE_TREE_INCLUDES` handling. A `<name>-u-boot.dtsi`
+next to the source is used first (see :ref:`dttweaks`). The names are
+relative to the directory, as they are to `dts/upstream/src/<arch>` for
+`OF_UPSTREAM` boards: keep the `<vendor>/` subdirectory, the sources then
+find the SoC files of `dts/upstream/src/<arch>/<vendor>` before the older
+copies of `arch/<arch>/dts`, as they do in the tree. Every name of those lists
+comes from the directory: a missing one stops the build with a message, so
+trim `OF_LIST` to what the directory provides.
+
+The directory is only read: the `.dtb` files are written to `dts/external` in
+the build tree, and the rest of the build, binman included, takes them from
+there. This directory does not need a Makefile: `scripts/Makefile.dts` builds
+it, with the directory-wide `DTC_FLAGS` of the directory it stands in for, so
+the `.dtb` comes out as it does from the tree. If it has a Makefile or a Kbuild
+file of its own, that one is used instead: it should include
+`scripts/Makefile.dts`, as `dts/upstream/src/arm64/Makefile` does, and may add
+`DTC_FLAGS` or `dtb-y` entries.
+The path is taken as given, so for an `O=` build pass an absolute one.
+`EXT_DTB` remains the way to use a devicetree compiled elsewhere.
+
 Scripts embedded in control DTB
 -------------------------------
 
diff --git a/dts/Makefile b/dts/Makefile
index befc6de1805..2793e0dcde3 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -24,6 +24,22 @@ else
 dt_dir := arch/$(ARCH)/dts
 endif
 
+# EXT_DTS_DIR=<dir>: compile the device tree sources of that directory, outside
+# the tree, instead of those of dt_dir: the .dtb files land in dts/external of
+# the build tree.
+ifneq ($(EXT_DTS_DIR),)
+dt_src_dir := $(abspath $(EXT_DTS_DIR))
+# built by a Makefile or Kbuild of its own if it has one, else by
+# scripts/Makefile.dts
+ext_dts_mk := $(firstword $(wildcard $(dt_src_dir)/Kbuild $(dt_src_dir)/Makefile) \
+		$(srctree)/scripts/Makefile.dts)
+ext_dts_flags := $(shell MAKEFLAGS= $(MAKE) -s -rR --include-dir=$(srctree) \
+		-f $(srctree)/scripts/Makefile.build obj=$(dt_dir) __dtc_flags)
+ext_dts_args := src=$(dt_src_dir) kbuild-file=$(ext_dts_mk) \
+		ext_dts_shadow=$(srctree)/$(dt_dir) ext_dts_flags="$(ext_dts_flags)"
+dt_dir := dts/external
+endif
+
 ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
 local_dtbos := local-dtbos
 else
@@ -61,7 +77,7 @@ $(DTB): arch-dtbs $(local_dtbos)
 
 PHONY += arch-dtbs
 arch-dtbs:
-	$(Q)$(MAKE) $(build)=$(dt_dir) dtbs
+	$(Q)$(MAKE) $(build)=$(dt_dir) $(ext_dts_args) dtbs
 
 ifneq ($(CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS),)
 PHONY += local-dtbos
@@ -86,7 +102,7 @@ dtbs: $(obj)/dt.dtb
 spl_dtbs: $(obj)/dt-$(SPL_NAME).dtb
 	@:
 
-clean-files := dt.dtb.S
+clean-files := dt.dtb.S external
 
 # Let clean descend into dts directories
 subdir- += ../arch/arc/dts ../arch/arm/dts ../arch/m68k/dts ../arch/microblaze/dts	\
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 73b6769ab90..8b0bef91cf2 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -4,6 +4,9 @@
 # ==========================================================================
 
 # Modified for U-Boot
+ifeq ($(origin src),command line)
+prefix := .
+else
 prefix := vpl
 src := $(patsubst $(prefix)/%,%,$(obj))
 ifeq ($(obj),$(src))
@@ -17,6 +20,7 @@ prefix := .
 endif
 endif
 endif
+endif
 
 PHONY := __build
 __build:
@@ -57,7 +61,8 @@ include scripts/Makefile.compiler
 
 # The filename Kbuild has precedence over Makefile
 kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
-include $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
+kbuild-file := $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
+include $(kbuild-file)
 
 # Added for U-Boot
 asflags-y  += $(PLATFORM_CPPFLAGS)
@@ -499,6 +504,10 @@ $(subdir-ym):
 	need-builtin=$(if $(filter $@/built-in.a, $(subdir-builtin)),1) \
 	need-modorder=$(if $(filter $@/modules.order, $(subdir-modorder)),1)
 
+PHONY += __dtc_flags
+__dtc_flags:
+	@echo $(DTC_FLAGS)
+
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
 
diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index fd9ff420585..bcf89b3b3a0 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -17,6 +17,15 @@ dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
 
 endif
 
+ifneq ($(ext_dts_shadow),)
+ext_dts_missing := $(strip $(foreach f,$(dtb-y),$(if $(wildcard \
+	$(src)/$(patsubst %.dtb,%.dts,$(patsubst %.dtbo,%.dtso,$(f)))),,$(f))))
+ifneq ($(ext_dts_missing),)
+$(error EXT_DTS_DIR: $(src) has no source for $(strip $(ext_dts_missing)); the device \
+	trees of DEVICE_TREE, OF_LIST, SPL_OF_LIST and OF_OVERLAY_LIST all come from it)
+endif
+endif
+
 ifneq ($(CONFIG_SYS_DTC_PAD_BYTES),0)
 DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)
 endif
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index e3b49148b7c..1910e08f30c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -256,9 +256,15 @@ upstream_dtsi_include = $(addprefix -I, $(srctree)/dts/upstream/src/ \
 	$(if (CONFIG_ARM64), \
 		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*))) \
 		 $(sort $(dir $(wildcard $(srctree)/dts/upstream/src/arm64/*/*/*)))))
+ext_dts_flags_extra = $(filter-out $(DTC_FLAGS),$(ext_dts_flags))
+ext_dts_shadow_include = $(if $(ext_dts_shadow),\
+	-I$(ext_dts_shadow)/$(dir $(patsubst $(obj)/%,%,$@)) \
+	-I$(ext_dts_shadow)/$(dir $(subst $(quote),,$(CONFIG_DEFAULT_DEVICE_TREE))))
+
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 $(UBOOTINCLUDE)                                         \
 		 -I$(dir $<)                                             \
+		 $(ext_dts_shadow_include)                               \
 		 -I$(u_boot_dtsi_loc)                                     \
 		 -I$(srctree)/arch/$(ARCH)/dts/include                   \
 		 -I$(srctree)/include                                    \
@@ -443,7 +449,7 @@ cmd_dtc_diff = \
 		-i $(dir $<) $(DTC_FLAGS) $(dtn-tmp) || \
 		(echo "Check $(shell pwd)/$< for errors" && false); \
 	$(DTC) -s -O dts -o $@.full.dts -b 0 \
-		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) $(dtc-tmp) || \
+		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) $(ext_dts_flags_extra) $(dtc-tmp) || \
 		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false); \
 	sed -i '/\<phandle\> = <0x[0-9a-f]\+>;/ d' $@.clean.dts; \
 	sed -i '/\<phandle\> = <0x[0-9a-f]\+>;/ d' $@.full.dts; \
@@ -464,7 +470,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
 	$(HOSTCC) -E @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
-		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
+		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) $(ext_dts_flags_extra) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
 		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
 		; \
-- 
2.43.0

