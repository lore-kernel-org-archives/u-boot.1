Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1804606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uMHcjIDm;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=hNcGSoLI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B324440659;
	Wed, 25 Nov 2026 23:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id brv9LOouLb6p; Wed, 25 Nov 2026 23:15:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0CD20405C8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795648533;
	b=byHNRdToeWwkRgfOHBljFBUoBqXOWZdIjbngAswDDp4c7xyWCBpL0ZOQEazzHw4JfoEy
	 EgjPX4pa9e+rpdixSqwzC27gzhyIhO+f2kFJR8KLauE8kIWueL897LjuX6sPXwyAMX83H
	 YIwZWXcIiKBokPRA7YNNyIiXV/tWAsVL71ch9WoM2NSl72hS8/SvN/p/PFB2NbS+wy+ER
	 E2OCvikhmgjZKfvHzFYv9Fxosu8JXA0kDtkwGOSRFYMZvFexWzbD8TxRtdys1KNZvq935
	 dnBhppdQ8rBqYiYTSFZ991Vp+GYe///+IUqENVMoGdxoRdath+P7VIymz22jPmwNDYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795648533;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ri0UTjr1EiuUjmeBzbydULX3wArImi/DjDe5YU99DZM=;
	b=AYBqETWnqYGAlSdkPpOQCPBWKfT8Mzc1U6q9vWoy/QoQL3Gp6rxa9jYETIvhClEIi1w1
	 otWVpcSN8wDoY7wsKEef6MaJWlGd2hqXVgoINQ2Vacy5MQPm9Onj9X/D7MkKFeSusg2Ub
	 qfn0ZV6rVXEUeg6TCjwntQ2kipgH9UpWXW0oy5DZYUdklj6xnBrM7+KZkVmuRIpoDgjSJ
	 3dVpvs/njogLW4Agnm4Nh+wwsl0LLS0bchYx0X6dF7j22cECUQue7d9Yqb1QYzVXeSVMp
	 AGIIYRc1Xm2cLF2tOwb/8TTk0CIK6xVN9nNoS09+1xqnt1uM+eRAiKGHjEOx+X++/+A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795648533;
	bh=ri0UTjr1EiuUjmeBzbydULX3wArImi/DjDe5YU99DZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uMHcjIDmZytXrSYl8uJmriVRxExREVDVCpzZecTh2WC3JCtHTCvwA4kZW7bi62c+r
	 bmZ0pLhDQlYK8OTkknirOGnWwMhozUGlVsU64ZDJaMcgshvVLyxWYXR/FdZXpD0RPR
	 giKFWsQHBbScwQ3ypwVUvn4Hng3NthoP34kcyTlwrEA/k/2Jrgu4dR9GHaep1o8P01
	 giGWBl21zAcWQvdIsmZM2IbqqrlPCntKuZaumb0KCx1Gt0eHuyefLzScdxLuIuguvu
	 rGuFeE9fc7qrHBVm5A4V8IhjIWAQGv2nWpUOEAjyDK8rXS3Lz9LDWx29Uu1EESBUcP
	 GhcZ3LO0W1PzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CD20405C8;
	Wed, 25 Nov 2026 23:15:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 441BE26D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 23:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 369134004D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 23:15:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pPm-EhgrSnc7 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 23:15:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7C29240024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=hNcGSoLI
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C29240024
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 23:15:29 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id C06AB4C966;
 Thu, 26 Nov 2026 10:15:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1795648520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ri0UTjr1EiuUjmeBzbydULX3wArImi/DjDe5YU99DZM=;
 b=hNcGSoLI1wLGvuxzG8ex0Pi76RMrplbjh6VYvPL57pd+jWKkmOcOV5ZVV/n4TrQ7+pG1gn
 r3u/yFecW+EkZsKJxNR0mu3HiVw98ijqFCZFJHvbfVocrRlTE0ePx3ueOND4IDFf4zjY1U
 ItFQHdmaAvfhGy75Q1C76j0/oo43+YbP8nkKzSyBL27tS96yyG/wtSqrFp4AZwH0P7cLN6
 I1GFCVKANvAUHfCiAbY42kNezp7nxGYYQZIlZ+n3ryUy+RQDMGZgE6+k9WxQyMUpZ4FaW8
 oNvcN8y7UJ5jrIY/AuiZNhXegYEuOOUDxpB1Mri5gFZez8zstUoxudkhy+LYtw==
X-GPT-Reason: legitimate; the email is a technical patch submission
 related to kernel/firmware development (sunxi: dram: a733) which
 aligns perfectly with the personal mailbox of alastair@d-silva.org;
 the From domain (d-silva.org) matches the sender's identity and
 the content is a standard, non-promotional technical update; there
 are no phishing indicators, urgency tactics, or suspicious links.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 6/7] sunxi: dram: a733: Wire ARC PMU firmware into Kbuild
Date: Thu, 26 Nov 2026 10:14:40 +1100
Message-ID: <20261125231442.1266343-7-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125231442.1266343-1-alastair@d-silva.org>
References: <20261125231442.1266343-1-alastair@d-silva.org>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add CONFIG_DRAM_SUN60I_A733_PMU and SPL Kbuild rules to compile the ARC EM4 PMU firmware into dram_sun60i_a733_pmu_fw.h.

Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/arm/mach-sunxi/Kconfig  |  9 +++++++++
 arch/arm/mach-sunxi/Makefile | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index b7ee14c6678..94360881996 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -755,6 +755,15 @@ config DRAM_MBUS_CLK
 
 endif
 
+config DRAM_SUN60I_A733_PMU
+	bool "Allwinner A733 LPDDR5 ARC PMU firmware"
+	depends on ARCH_SUNXI
+	default y if DRAM_SUN60I_A733
+	help
+	  Build the freestanding ARC EM4 LPDDR5 PHY Management Unit (PMU)
+	  training firmware header (dram_sun60i_a733_pmu_fw.h) during SPL
+	  builds.
+
 config DRAM_ZQ
 	int "sunxi dram zq value"
 	depends on !MACH_SUN50I_H616
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index ff475d8fff5..54f7246cc5c 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -50,4 +50,37 @@ obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_sun50i_a133.o
 obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_timings/
 obj-$(CONFIG_MACH_SUN55I_A523)	+= dram_sun55i_a523.o dram_dw_helpers.o
 obj-$(CONFIG_DRAM_SUN55I_A523)	+= dram_timings/
+
+ifdef CONFIG_DRAM_SUN60I_A733_PMU
+PMU_FW_DIR := $(srctree)/arch/arm/mach-sunxi/pmu
+PMU_FW_SRCS := \
+	$(PMU_FW_DIR)/pmu_primitives.c \
+	$(PMU_FW_DIR)/pmu_clock.c \
+	$(PMU_FW_DIR)/pmu_telemetry.c \
+	$(PMU_FW_DIR)/pmu_cbt.c \
+	$(PMU_FW_DIR)/pmu_deskew.c \
+	$(PMU_FW_DIR)/pmu_eye.c \
+	$(PMU_FW_DIR)/pmu_train.c
+PMU_FW_HDRS := \
+	$(PMU_FW_DIR)/sunxi_pmu_abi.h \
+	$(PMU_FW_DIR)/dwc_ddrphy_pmu_regs.h \
+	$(PMU_FW_DIR)/pmu_fw.h \
+	$(PMU_FW_DIR)/pmu.ld
+
+quiet_cmd_pmu_fw = PMUFW   $@
+      cmd_pmu_fw = $(PYTHON3) -B $(PMU_FW_DIR)/build_pmu_fw.py \
+		   $(if $(ARC_CROSS_COMPILE),--cross-compile $(ARC_CROSS_COMPILE)) \
+		   $(if $(PMU_FW),--pmu-fw $(PMU_FW)) \
+		   $(if $(filter 1 y,$(BINMAN_ALLOW_MISSING) $(ALLOW_MISSING)),--allow-missing) \
+		   --src-dir $(PMU_FW_DIR) \
+		   --ld-script $(PMU_FW_DIR)/pmu.ld \
+		   --out $@ $(PMU_FW_SRCS)
+
+$(obj)/dram_sun60i_a733_pmu_fw.h: $(PMU_FW_DIR)/build_pmu_fw.py $(PMU_FW_SRCS) $(PMU_FW_HDRS) $(PMU_FW) FORCE
+	$(call if_changed,pmu_fw)
+
+always-y += dram_sun60i_a733_pmu_fw.h
+targets += dram_sun60i_a733_pmu_fw.h
+clean-files += dram_sun60i_a733_pmu_fw.h
+endif
 endif
-- 
2.53.0

