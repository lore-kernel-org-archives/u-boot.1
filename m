Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B00D711D3
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 02:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7561F800AB;
	Fri, 19 Dec 2025 03:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XnFLsRt4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jITMSj9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F6688309A; Fri, 19 Dec 2025 03:41:09 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA3C80050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 03:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dXWxZ4hKnz9spZ;
 Fri, 19 Dec 2025 03:41:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766112066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gZ9kDmChZKdxExgXyY+PGrOiL7UjGRcODpcb9/gBBxE=;
 b=XnFLsRt4nRHDZnoWOsDOdnZAcGVydn63k3kD5YlO9ip0TsvFTL3zIzt4u89hM1RbO3/KYp
 0WZN7ZphB0o/DyRKuAhADilZhdBmrMMwBohUr1PeEM+P9sK3DKZFtV4GR4ac+2no0KTx9H
 yVKm4/nfJROcvmaDSlayM1/eaTNsARWz9XCQK9tZBeGPk3xUcuD6G6rdDItHsdURuTtaYw
 h7FbKKMj8oPfqqrGtXeG7l3uOIOAgz+wRDFP5yV/8iU6LzhBe9Kgh4RGZ3sn+fhhspM3Hc
 KW5dUMy8OHT5InRrb4qizqS7Lx/I2K0IhxG1Gqyr0ejdQ4WerrSTZffqYkV3uA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766112064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gZ9kDmChZKdxExgXyY+PGrOiL7UjGRcODpcb9/gBBxE=;
 b=jITMSj9cYyQkJJyX8CzEMV3Lmk5nrn2Coh7Lnc66YFmJ7sd8fVfCdGomk8d8vgBEGi/gqS
 s4LzAw93izPPjixU1/LTbNF+xDTQYeLlaltinb0EWfeuEJEkQEHxkODpMQDvu3VvPP0VJB
 MDuhwYq8rmhI1dyFVvK3RzwiuAbXX1OFCVeDeqldLhqYriTrjP3nSn/mCaEf8kUt4jw8yy
 5oX5SJwoNjbD5ZLoF1pANN4aVxWpnoidAeURzIlM4fUMRVDvKKkmFmzSPth6bXiSY4EVfc
 VF9O11bEjIdnX9bjvM2uT4t1/MZi+//AbPB/FyM20BR0za4xcrs+6llmm6CkzQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3] kbuild: Produce diff between base DT and U-Boot augmented
 DT if DEVICE_TREE_DEBUG=1
Date: Fri, 19 Dec 2025 03:40:44 +0100
Message-ID: <20251219024102.145220-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 055a85a344f488781b0
X-MBO-RS-META: uqafwq6a39tgr818g5x3j6kgorptfq4s
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
V3: Drop extra newline leftover
---
 scripts/Makefile.lib | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b062db7e87f..22960e46a6b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -388,6 +388,26 @@ ifeq ($(CONFIG_OF_LIBFDT_OVERLAY),y)
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
@@ -402,7 +422,8 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
 		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
 		; \
-	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
+	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile) ; \
+	$(cmd_dtc_diff)
 
 dtsi_include_list_deps := $(addprefix $(u_boot_dtsi_loc),$(subst $(quote),,$(dtsi_include_list)))
 
-- 
2.51.0

