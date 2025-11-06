Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEBECCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 21:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D72E83C0E;
	Thu,  6 Nov 2025 22:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uKq4XzTg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nt0y19Eo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2974883C11; Thu,  6 Nov 2025 22:08:37 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A30383A15
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 22:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d2ZYG0BQXz9v75;
 Thu,  6 Nov 2025 22:08:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762463314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PcH+fUB7ndmiXxipSCg/zTI2Z0PKJ50Xa8zrC24ZzAY=;
 b=uKq4XzTgWyDl8HjaJeKzCIwF7ELvfJQ+urcbqUdOXfbsfc3MqOOkviFw2+4VoZq9cxyOP2
 LSY1ugi3tzvWKthR7Ir1853QNtvWxjqRmNbO09yd8mFBAK4iaX5j/Zg+0ws9QoAm/QCbQL
 uZqHo9/wzOctClZA0mJcfbtjHWTLOMJpGeZnAWRvOTwVUukioWD0XmkCcNioTC2MRtOH+l
 eSDIHJpLRdFD/e1PZUrJXMSMl+Ej8xTH/iRSmdNNFXCvaICFD/0r+FIUKktACCzcsr6835
 g/OcGyUnZQj8nPFwdEZuU9ZQJya5II1g8LBOHQDyZFdne7Lpv2JweCSf+eys4g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=nt0y19Eo;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762463312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PcH+fUB7ndmiXxipSCg/zTI2Z0PKJ50Xa8zrC24ZzAY=;
 b=nt0y19EoPn9tiKO6W/sQTZgmSGWbYBmOqaU46dJoO88MUuQ0FGHvZ5ywq3Txbt2urFxsDw
 PbQ3lEfelpomqEN20KrbIP8XJiMS36srxC9TN3PgXMpuFaWSGqGZzvx8lIEBvEvWpFj5KC
 IWKMnb2U81LRzIhtF87+DDwa1UwclNR7zP/4+mhoKxEZfnpf+ahQQ9CQnDkVyq94B/Vz0b
 Svr0qGPcjhslkeehV32Npp3s49pMm2nxgHF04EY75NMUQE3YNRquITx9M24hD5KNdR3d8W
 IIOiEljJKObQj6aT44Ye57EGeE3Zl8o1qJWhjvnXg8XPHXhDU/WciQsB4w0r9w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC][PATCH] kbuild: Produce diff between base DT and U-Boot
 augmented DT if DEVICE_TREE_DEBUG=1
Date: Thu,  6 Nov 2025 22:08:18 +0100
Message-ID: <20251106210826.371672-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cbb0de7bb60adc1688b
X-MBO-RS-META: ypdbkfd3xc9cd6xdpeou7supmstj3cm1
X-Rspamd-Queue-Id: 4d2ZYG0BQXz9v75
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

Example usage:
$ make r8a779g3_sparrowhawk_defconfig && make DEVICE_TREE_DEBUG=1
$ cat ./dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dtb.diff

This still has a downside. Even 'dtc -I dts -O dts ...' applied on
base DT and U-Boot augmented DT can produce different phandle IDs
for the same node in those two DTs, which results in a lot of noise
in the resulting diff. The only way I can think of is to patch DTC
to emit full paths in those phandles instead, something like a
phandle = <&{/full/path/to/remote/end} ...>;

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
 scripts/Makefile.lib | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5db2fbc418a..2d8bf3c04f4 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -386,10 +386,31 @@ ifeq ($(CONFIG_OF_LIBFDT_OVERLAY),y)
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
+cmd_dtc_diff =
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
@@ -400,7 +421,8 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
 		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
 		; \
-	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
+	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile) ; \
+	$(cmd_dtc_diff)
 
 dtsi_include_list_deps := $(addprefix $(u_boot_dtsi_loc),$(subst $(quote),,$(dtsi_include_list)))
 
-- 
2.51.0

