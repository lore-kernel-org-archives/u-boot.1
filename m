Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD7DD70E0C
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 02:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C800800AB;
	Fri, 19 Dec 2025 03:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cN8TOX29";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qNTYW523";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C6A80433; Fri, 19 Dec 2025 03:38:27 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D2F980050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 03:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dXWtR6Nn7z9smP;
 Fri, 19 Dec 2025 03:38:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766111903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+5Iypo2mBNRaLUnWpm91JUO12CvZhdChcVxQLBPI5R0=;
 b=cN8TOX2947GoR9C9Ytbyg5pTGjlANFZDfp3GrErsugLzjzppetY4MUsB63mWZmkiTuZxlT
 qSJJAn04h7hXaRT5zT3XSLMd1JQHTuBEw2WZ7c6pVLxV2vhC5Qzn6phbdOccd/NpCvSf+x
 cKT5vbGVLhSw4fBVlSu+niYkhrsDwoKAga7orv6VYBUALrc31jh3aQvsg/km5RnRR2D1lj
 64AxIr9jjKqXF1z3zsuayNwa2G+wxf1hncZyh1qar2e4lrn/j1Lpo4TnLyXjheMV9IusAW
 cQaO2cbqIVwU7/US5hhK0QVl4JmVLFJtAPmfchX/J/qsUkWlKBuHSO+GaThCzg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=qNTYW523;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766111902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+5Iypo2mBNRaLUnWpm91JUO12CvZhdChcVxQLBPI5R0=;
 b=qNTYW523fuPFo3ZZBWNq0dIBkvWPnK/vuqBJPTD2vQG8l7H2K2NcP6RzSIpQyNGRrCF0Qn
 ANoolHaESWDIUnq23FJm97yyf53hZUIQoXCSdAAsPYb7K/5fhFJT5XeSX0x30ApHrfOXlu
 MTxT0SryjQHPNTiQK7MPrwRiUO+X0c6wjV71YeJYxO7ziNSBcTmbNTnKf5Lv0BozrHy9hW
 FdR9lzeJtCLPWjx4pYM4clZxe5CRzcWBnTJJRjY00ohe6I2GfccXhZ7Dn8gh/pOqcRM6mx
 OMnGSd10fet2eB4SJX74BHZWy80I4bgYrnqICShBu41+e5eM88mKtwrOn07nkw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] kbuild: Produce diff between base DT and U-Boot augmented
 DT if DEVICE_TREE_DEBUG=1
Date: Fri, 19 Dec 2025 03:37:32 +0100
Message-ID: <20251219023818.144681-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5fa9124108984cc4018
X-MBO-RS-META: tnpygbhwcct5fqdisu854jskzjd4zmy8
X-Rspamd-Queue-Id: 4dXWtR6Nn7z9smP
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

In case DEVICE_TREE_DEBUG is set, produce a diff between the base DT and
DT with U-Boot extras, to show how much does the U-Boot DT differ from
the base DT. This is particularly useful together with OF_UPSTREAM, to
minimize the diff between upstream DTs and U-Boot DTs.

This requires DTC 1.7.2 which does not resolve phandles when used in
the 'dtc -I dts -O dts ...' mode. With older DTC, the diff is full of
churn due to the resolved phandles.

Example usage:
$ make r8a779g3_sparrowhawk_defconfig && make DEVICE_TREE_DEBUG=1
$ cat ./dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dtb.diff

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: - Update commit message to mention DTC 1.7.2
    - Fix failure when building without DEVICE_TREE_DEBUG , in that
      case set cmd_dtc_diff = true
---
 scripts/Makefile.lib | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b062db7e87f..04220111ba6 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -388,10 +388,31 @@ ifeq ($(CONFIG_OF_LIBFDT_OVERLAY),y)
 DTC_FLAGS += -@
 endif
 
+# In case DEVICE_TREE_DEBUG is set, produce a diff between the base DT and
+# DT with U-Boot extras, to show how much does the U-Boot DT differ from
+# the base DT. This is particularly useful together with OF_UPSTREAM, to
+# minimize the diff between upstream DTs and U-Boot DTs.
+ifdef DEVICE_TREE_DEBUG
+cmd_dtc_diff = \
+	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtn-tmp) $< ; \
+	$(DTC) -s -O dts -o $@.clean.dts -b 0 \
+		-i $(dir $<) $(DTC_FLAGS) $(dtn-tmp) || \
+		(echo "Check $(shell pwd)/$< for errors" && false); \
+	$(DTC) -s -O dts -o $@.full.dts -b 0 \
+		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) $(dtc-tmp) || \
+		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false); \
+	(diff -Naru $@.clean.dts $@.full.dts > $@.diff || true)
+
+dtn-tmp = $(subst $(comma),_,$(dot-target).dtn.tmp)
+else
+cmd_dtc_diff = true
+endif
+
 quiet_cmd_dtc = DTC     $@
 # Modified for U-Boot
 # Bring in any U-Boot-specific include at the end of the file
 # And finally any custom .dtsi fragments specified with CONFIG_DEVICE_TREE_INCLUDES
+
 cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	(cat $< > $(pre-tmp)); \
 	$(foreach f,$(subst $(quote),,$(dtsi_include_list) $(CONFIG_DEVICE_TREE_INCLUDES)), \
@@ -402,7 +423,8 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
 		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
 		; \
-	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
+	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile) ; \
+	$(cmd_dtc_diff)
 
 dtsi_include_list_deps := $(addprefix $(u_boot_dtsi_loc),$(subst $(quote),,$(dtsi_include_list)))
 
-- 
2.51.0

