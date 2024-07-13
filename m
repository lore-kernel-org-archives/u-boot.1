Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1F4C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C895288905;
	Sat, 13 Jul 2024 15:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MaG8HQ7r";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GusdEaY9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC927888A5; Sat, 13 Jul 2024 15:21:56 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D938891A
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WLpyp3WNvz9sZv;
 Sat, 13 Jul 2024 15:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JxHOthqM/e78TyH47lKpUzBvWQm99sgdEQng85Iamc=;
 b=MaG8HQ7rqC+4zJneBnLp1j2XdDkjt6+U0mYLM68lhv+yoW5ThFEtsqO9vHV2jKWr4kBBVT
 MHigYONE9VeG8hbKKX62G5YzsyCgBw+Ky4HVf2QgVDCPAIQ3uxENoeRffE6KEFnvaoe+7+
 sYlbPUdsg/ahP5Ro2syx8L9CXW3GnRt9GTpZU7jkHIKHgNT1d1dJGbLJ5U6VVv1PsSJEXH
 kTHWYVanbPoXD4O1YbpkOGeexcMcoC15eJHB201cGJjf5k/HDA9xgTsFu+5soAOVw0x8Mw
 b30S5abTV4FOXtV8mVcXYDxP+qfqMnmP9el/aCxfei1QJQHYu2GlP+C+IRiE3Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JxHOthqM/e78TyH47lKpUzBvWQm99sgdEQng85Iamc=;
 b=GusdEaY9b53kTf8yvbP3RAlzeGEOHpRi33YgsisPZwIf0eybDRu8Qn5NE9LPef0rwX/UHc
 XS3lmCO3IurnjMiEFqdM3ahuRISnWJJN2q6KU9oonaARUkOP32NqiwRhoPHdEWyXI2eqh3
 l8f6OTWoKntXOSEmksBsaBKOtzQiknFiNzdt3lOujqLcLnhOcusjFRHKrFt33zt6O70fuu
 POOCANpiInJIweG87VoqQp/pioVVpv/FpEdjJqIj8XvFaIHKGb5Hj9/16g2mXmnTRd9/ak
 1eEtohbjnxfl/Gcep5+ZtpAG61zBhystnVHNNY6mJznhZocfer1fxxlNfr9gEQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 44/45] x86: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:35 +0200
Message-ID: <20240713132021.57650-44-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c1126f8b316046bd94e
X-MBO-RS-META: 74x1ijyk88uraykhqa11hycq3ewriuc1
X-Rspamd-Queue-Id: 4WLpyp3WNvz9sZv
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/x86/cpu/intel_common/itss.c               | 1 -
 arch/x86/cpu/intel_common/me_status.c          | 1 -
 arch/x86/cpu/quark/smc.c                       | 1 -
 arch/x86/include/asm/arch-broadwell/pch.h      | 1 -
 arch/x86/include/asm/arch-broadwell/pei_data.h | 1 -
 arch/x86/include/asm/bitops.h                  | 1 -
 arch/x86/include/asm/byteorder.h               | 1 -
 arch/x86/include/asm/io.h                      | 4 ----
 arch/x86/include/asm/ist.h                     | 1 -
 arch/x86/include/asm/me_common.h               | 1 -
 arch/x86/include/asm/mpspec.h                  | 1 -
 arch/x86/include/asm/msr.h                     | 1 -
 12 files changed, 15 deletions(-)

diff --git a/arch/x86/cpu/intel_common/itss.c b/arch/x86/cpu/intel_common/itss.c
index 6d3184f969f..168857feb76 100644
--- a/arch/x86/cpu/intel_common/itss.c
+++ b/arch/x86/cpu/intel_common/itss.c
@@ -101,7 +101,6 @@ static int restore_polarities(struct udevice *dev)
 	reg_start = start / IRQS_PER_IPC;
 	reg_end = DIV_ROUND_UP(end, IRQS_PER_IPC);
 
-
 	for (i = reg_start; i < reg_end; i++) {
 		u32 mask;
 		u16 reg;
diff --git a/arch/x86/cpu/intel_common/me_status.c b/arch/x86/cpu/intel_common/me_status.c
index a09bd5029eb..905519abddc 100644
--- a/arch/x86/cpu/intel_common/me_status.c
+++ b/arch/x86/cpu/intel_common/me_status.c
@@ -127,7 +127,6 @@ static const char *const me_progress_policy_values[] = {
 	[0x10] = "Required VSCC values for flash parts do not match",
 };
 
-
 /**
  * _intel_me_status() - Check Intel Management Engine status
  *
diff --git a/arch/x86/cpu/quark/smc.c b/arch/x86/cpu/quark/smc.c
index a7e92b3f5c1..070833fd0e2 100644
--- a/arch/x86/cpu/quark/smc.c
+++ b/arch/x86/cpu/quark/smc.c
@@ -245,7 +245,6 @@ void perform_ddr_reset(struct mrc_params *mrc_params)
 	LEAVEFN();
 }
 
-
 /*
  * This function performs some initialization on the DDRIO unit.
  * This function is dependent on BOARD_ID, DDR_SPEED, and CHANNEL_ENABLES.
diff --git a/arch/x86/include/asm/arch-broadwell/pch.h b/arch/x86/include/asm/arch-broadwell/pch.h
index ecdf6d16f94..b0ccf542b1a 100644
--- a/arch/x86/include/asm/arch-broadwell/pch.h
+++ b/arch/x86/include/asm/arch-broadwell/pch.h
@@ -30,7 +30,6 @@
 #define TCO1_CNT		0x60
 #define  TCO_TMR_HLT		(1 << 11)
 
-
 /* Device 0:0.0 PCI configuration space */
 
 #define EPBAR		0x40
diff --git a/arch/x86/include/asm/arch-broadwell/pei_data.h b/arch/x86/include/asm/arch-broadwell/pei_data.h
index 4442beac5e4..29699005787 100644
--- a/arch/x86/include/asm/arch-broadwell/pei_data.h
+++ b/arch/x86/include/asm/arch-broadwell/pei_data.h
@@ -62,7 +62,6 @@ struct usb3_port_setting {
 	uint8_t fixed_eq;
 } __packed;
 
-
 struct pei_data {
 	uint32_t pei_version;
 
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 196fcf9d3f6..50cad28186c 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -5,7 +5,6 @@
  * Copyright 1992, Linus Torvalds.
  */
 
-
 /*
  * These have to be done with inline assembly: that way the bit-setting
  * is guaranteed to be atomic. All bit operations return 0 if the bit
diff --git a/arch/x86/include/asm/byteorder.h b/arch/x86/include/asm/byteorder.h
index a2d1fd8703b..2f13a1d6498 100644
--- a/arch/x86/include/asm/byteorder.h
+++ b/arch/x86/include/asm/byteorder.h
@@ -5,7 +5,6 @@
 
 #ifdef __GNUC__
 
-
 static __inline__ __u32 ___arch__swab32(__u32 x)
 {
 	__asm__("bswap %0" : "=r" (x) : "0" (x));
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 5efb2e1b21e..c6d90eb794a 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -46,10 +46,8 @@
 
 #include <asm/types.h>
 
-
 #ifdef __KERNEL__
 
-
 /*
  * readX/writeX() are used to access memory mapped devices. On some
  * architectures the memory mapped IO stuff needs to be accessed
@@ -142,7 +140,6 @@
 #define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO
 #endif
 
-
 /*
  * Talk about misusing macros..
  */
@@ -152,7 +149,6 @@ static inline void _out##s(unsigned x value, unsigned short port) {
 #define __OUT2(s,s1,s2) \
 __asm__ __volatile__ ("out" #s " %" s1 "0,%" s2 "1"
 
-
 #define __OUT(s,s1,x) \
 __OUT1(s,x) __OUT2(s,s1,"w") : : "a" (value), "Nd" (port)); } \
 __OUT1(s##_p,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));}
diff --git a/arch/x86/include/asm/ist.h b/arch/x86/include/asm/ist.h
index 80b8597d54c..acd9bd3ef2a 100644
--- a/arch/x86/include/asm/ist.h
+++ b/arch/x86/include/asm/ist.h
@@ -7,7 +7,6 @@
  * Copyright 2002 Andy Grover <andrew.grover@intel.com>
  */
 
-
 #include <linux/types.h>
 
 struct ist_info {
diff --git a/arch/x86/include/asm/me_common.h b/arch/x86/include/asm/me_common.h
index aa478594ec9..ed2925b9049 100644
--- a/arch/x86/include/asm/me_common.h
+++ b/arch/x86/include/asm/me_common.h
@@ -221,7 +221,6 @@ struct me_fw_version {
 	u16 recovery_hot_fix;
 } __packed;
 
-
 #define HECI_EOP_STATUS_SUCCESS       0x0
 #define HECI_EOP_PERFORM_GLOBAL_RESET 0x1
 
diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index a25f8f03a12..3c12e07590c 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -374,7 +374,6 @@ void mp_write_pci_intsrc(struct mp_config_table *mc, int irqtype,
 void mp_write_lintsrc(struct mp_config_table *mc, int irqtype, int irqflag,
 		      int srcbus, int srcbusirq, int destapic, int destlint);
 
-
 /**
  * mp_write_address_space() - Write a system address space entry
  *
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 27764fc56cb..af5f9a11980 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -245,7 +245,6 @@ do {                                                            \
 
 #endif	/* !CONFIG_PARAVIRT */
 
-
 #define checking_wrmsrl(msr, val) wrmsr_safe((msr), (u32)(val),		\
 					     (u32)((val) >> 32))
 
-- 
2.43.0

