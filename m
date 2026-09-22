Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDEDC982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 05:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C84A680C10;
	Tue, 22 Sep 2026 05:27:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IddmGc_Sg6k4; Tue, 22 Sep 2026 05:27:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8486180C7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790054846;
	b=QlOvtn0egcV1mS1V6bNg2Pqt0SiOGzrBsSemD4E9dOeTdeHfxTV9xAOE8kjcz717hEMX
	 u3/c+8BnWyR91OcsvsgZGjm2j4+B4UTCfVGi+vgXLSp5oPffpzp6y0EhjFyrtR2XE/d1f
	 FkrtX2yarlXvUD/KrLXsh3/6PwjGUwK2ircgr3/xdi7guhdx467uMLhZVwRmvD/v5kKUn
	 hu12VL+kPXyqUtqIxzeo0PavNKLlqf2ziisvkmK/1u3qGCZdvqjcqCdhoHyJqv22+0Elk
	 w7SMHAdWct1vylKRmlxNj7iZTzjnUHcUlc/BUTxL4APZXlxRT7fNUWbDp/uPhGPZCVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790054846;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Y1v3poFtx04Lx2oQudN5Z//Vtwf49q7o/t4tfu3rgp0=;
	b=ZVfB+S8ks1bpaL/Cd8PzKLU1HUMONBmwI+ZZKpDDw3HEE5ZSqs0spKVMkYh6ZWJxsqKc
	 WSbxZpR52DngRBIW4MPFUbLcqRiGSId+2mHNFOhAhsK+v6RRcdCpQMUa8J4hg84j4HKcR
	 11JCuxyQPobaL5K4ZR5XWbsUrbdXT3Yww1GNFyWoV5NQue/YUly6klY5hPZaGisxQlExr
	 6Uh8pNH3f8EAMiXPFheN3AKX9xp9kGIQq5SLaEdn5Yr9Tzau9KD2LRLaaE03Ek/1cDWRZ
	 eKxue6GfQnL3hqjfHHaFaJhvBgWU9/lADKUnvIniUQyRLOupRkJYFltqPPy9BiBPuOg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=IT6Xu070;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790054846;
	bh=Y1v3poFtx04Lx2oQudN5Z//Vtwf49q7o/t4tfu3rgp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wAe0PeA+LMe6JkZvaAV1N3UumeZF1I3AEZ08uelV9jZ3eoszo+w7536Um0eNq05zM
	 ORPC1Z2kFTdDtq+QVLoXDNEps+hRbsSqCECZ1ec1qWWuO5sW0FvN6YGf2wZohp2W8o
	 LIFIKaZdL5XBtNWRLsbtlfNaP2PJR38jSwnvJm0vj25THAxLzuYPQ2BWGmRZcuFuym
	 BIPiDZqgHaXPK+QtPCDppgxuciJXmeEw7pQ4EiNoaQePrUiAeUJlV+qSFow95IgVy3
	 04TWY/GK2kAHZjCficdPKHji1RCks8IcdFE9eHfNWSCGd/mpgYWWI+KaMDc8huceE3
	 H9IEM9GZu1zaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8486180C7A;
	Tue, 22 Sep 2026 05:27:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AE353A20
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F5A180C10
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:27:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lwQFxTP5oGDp for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 05:27:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3DC2580C7A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790054844;
 b=XusQ9Tqoj/Z+v9N2vOpgyuNnBmsiaFtwmuObOW3kNGWS1lGMzmO27R7EUgisvwS/up4p
 16JQSu1I+P6YjBOOmYUDwxPPyL9ulDsrXGb6+RzWdpPoyProZGJvTc4QdJFSjyhnXwZHI
 1EH28KFmC8XGYIhCBpOPKo/UTN4+DsE9agXGpygFzcXUk07LQHI+YIA54TvE6/wy0DrHX
 6Gk3rG3I0rZiIDninOGiK6t0NN9StIIo4pO5K2lo7XbRjt2UziGfG2rTrGo+g6dQ42rQ5
 96jnqyN7KkJE01k5juHBDK6kW6h8AV8W8Wj84MKd9+Qty4UW9FfO5bwB3xvjEbp/3jQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790054844;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=Y1v3poFtx04Lx2oQudN5Z//Vtwf49q7o/t4tfu3rgp0=;
 b=fMwXYPRBiqE+b5c2Bdrlqc46Spyh945qBvvN8mxKMrLjBdWBhD2svV7w8/LSaiYAwYgw
 0PsiuCfRDZLnG8HKfOVa21oeL8OrrWqf+rOEk4YbzFqqKgvxF6zOK36Il9gj1qx3rvC3Q
 JyR9T1QDaYKVbGCrs4xKVtSpNKVefPQiAvkZqxLF2A6CVelGC4u+o+IXMJIppyhAkiJta
 5Pdd4fqhB+vId+zUAmuVmTkrt5tDDDNbww/ryuj0Ye8j92xFnj3GMMsXSOFQtUKXl8DEP
 wEABFXOaEGId8TGeOHLiXeyqmDGCGQ65Abo+abuQoF7tSg88YTkbsPmcBONeLT2/f8A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=IT6Xu070; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=IT6Xu070
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DC2580C7A
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:27:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2B381105660; Tue, 22 Sep 2026 07:27:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790054837; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Y1v3poFtx04Lx2oQudN5Z//Vtwf49q7o/t4tfu3rgp0=;
 b=IT6Xu070HK6DF/sDQ6W5wiEzV1/Gz6AeAr/xNhkg8g3efUQG2eRDkduYJvmT1YktOVlz8R
 q8cVsw3m0MbTli3/BvQfFgLUzTJqj/noUipd/EkSPzSJBSCgcx8QZkq3IgrZ6xTsfFm1ck
 r3hCm5Ngk2nQTLnn3BPBAQATSe7P2vL1wsSLYhzYWgQfNkIxMnlKJ47DJe8HaKRBkA9fPY
 2Vf7zLeURbK+1of401uJ9/MOfu9Al7Pu9ndBgBAOv6nJ9gBUyAKMB+mLRXnJ8UR7hmWoAe
 R7HuFvLOgxb0qyZAg6KJXFZ8Z4BcQmqNOOJcNrCkjjA1lgZIBfRk76xkEqzhew==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Gaurav Jain <gaurav.jain@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Heiko Schocher <hs@nabladev.com>, Utkarsh Gupta <utkarsh.gupta@nxp.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v1 1/2] crypto: fsl: run the CAAM RNG self test on affected
 i.MX6 chips
Date: Tue, 22 Sep 2026 07:26:47 +0200
Message-ID: <20260922052700.528451-2-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922052700.528451-1-hs@nabladev.com>
References: <20260922052700.528451-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The boot ROM of a few i.MX6 revisions runs the RNG self test incorrectly.
It leaves a HAB event behind on every boot:

    STS = HAB_WARNING (0x69)   RSN = HAB_ENG_FAIL (0x30)
    CTX = HAB_CTX_ENTRY (0xE1) ENG = HAB_ENG_CAAM (0x1D)

NXP recommends to run a rng self test before any RNG related
crypto implementations are done.

Affected are i.MX6Solo, i.MX6DL and i.MX6SX revision 1.4, i.MX6Q
revision 1.6 and i.MX6QP revision 1.1, and no other revision of those
chips. Both chip and revision are read at runtime and have to match.

Run this test on affected chips and stop if test fails.

Part of the code is taken from u-boot-imx NXP tree, from the commit
linked below, and adapted to mainline.

Link: https://github.com/nxp-imx/uboot-imx/commit/541284a3c55f90446ca179b26500f93ed201eb96
Signed-off-by: Utkarsh Gupta <utkarsh.gupta@nxp.com>
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
Rework against NXP base:
- adapt the chip detection
- checkpatch cleanup
- Kconfig symbol renamed and set a default

It may be worth discussing whether triggering a panic() and bringing the entire
system to a halt is appropriate in this case.

 arch/arm/include/asm/arch-imx/cpu.h |   2 +
 drivers/crypto/fsl/Kconfig          |  22 ++++
 drivers/crypto/fsl/Makefile         |   1 +
 drivers/crypto/fsl/jr.c             |   3 +
 drivers/crypto/fsl/jr.h             |   1 +
 drivers/crypto/fsl/rng_self_test.c  | 157 ++++++++++++++++++++++++++++
 6 files changed, 186 insertions(+)
 create mode 100644 drivers/crypto/fsl/rng_self_test.c

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index bbc4b421a02..f2225df9519 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -95,7 +95,9 @@
 #define CHIP_REV_1_1            0x11
 #define CHIP_REV_1_2            0x12
 #define CHIP_REV_1_3            0x13
+#define CHIP_REV_1_4            0x14
 #define CHIP_REV_1_5            0x15
+#define CHIP_REV_1_6            0x16
 #define CHIP_REV_2_0            0x20
 #define CHIP_REV_2_1            0x21
 #define CHIP_REV_2_2            0x22
diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
index 244a9bd905d..41de402c530 100644
--- a/drivers/crypto/fsl/Kconfig
+++ b/drivers/crypto/fsl/Kconfig
@@ -100,4 +100,26 @@ config FSL_DCP_RNG
 	  and a Pseudo-Random Number Generator (PRNG) to achieve a true
 	  randomness and cryptographic strength.
 
+config FSL_CAAM_RNG_SELF_TEST
+	bool "Run the CAAM RNG self test on affected i.MX6 chips"
+	depends on FSL_CAAM
+	default y if MX6S || MX6DL || MX6Q || MX6QDL || MX6SX
+	help
+	  The boot ROM of a few i.MX6 revisions runs the RNG self test
+	  incorrectly and leaves a HAB warning behind, which reads
+
+	    STS = HAB_WARNING (0x69)   RSN = HAB_ENG_FAIL (0x30)
+	    CTX = HAB_CTX_ENTRY (0xE1) ENG = HAB_ENG_CAAM (0x1D)
+
+	  The warning itself is harmless and this option does not make it
+	  go away. What it does is run the self test correctly, before
+	  anything else uses the RNG, so that a genuinely broken RNG is
+	  found rather than assumed to be the known warning. The board is
+	  stopped if the test fails.
+
+	  Affected are i.MX6Solo, i.MX6DL and i.MX6SX revision 1.4, i.MX6Q
+	  revision 1.6 and i.MX6QP revision 1.1, and no other revision of
+	  those chips. Chip and revision are read at runtime, so a build
+	  covering several of them behaves correctly on each.
+
 endif
diff --git a/drivers/crypto/fsl/Makefile b/drivers/crypto/fsl/Makefile
index 965c4938c8c..14b53db7844 100644
--- a/drivers/crypto/fsl/Makefile
+++ b/drivers/crypto/fsl/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_RSA_FREESCALE_EXP) += fsl_rsa.o
 obj-$(CONFIG_$(PHASE_)FSL_CAAM_RNG) += rng.o
 obj-$(CONFIG_FSL_DCP_RNG) += dcp_rng.o
 obj-$(CONFIG_FSL_MFGPROT) += fsl_mfgprot.o
+obj-$(CONFIG_FSL_CAAM_RNG_SELF_TEST) += rng_self_test.o
diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 07d336c074a..3a5032bcaf6 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -804,6 +804,9 @@ init:
 	pamu_enable();
 #endif
 
+	if (IS_ENABLED(CONFIG_FSL_CAAM_RNG_SELF_TEST))
+		rng_self_test();
+
 	if (get_rng_vid(caam->sec) >= 4) {
 		if (rng_init(sec_idx, caam->sec) < 0) {
 			printf("SEC%u:  RNG instantiation failed\n", sec_idx);
diff --git a/drivers/crypto/fsl/jr.h b/drivers/crypto/fsl/jr.h
index b136cd8d05a..d8bd0797331 100644
--- a/drivers/crypto/fsl/jr.h
+++ b/drivers/crypto/fsl/jr.h
@@ -132,4 +132,5 @@ struct caam_regs {
 void caam_jr_strstatus(u32 status);
 int run_descriptor_jr(uint32_t *desc);
 
+void rng_self_test(void);
 #endif
diff --git a/drivers/crypto/fsl/rng_self_test.c b/drivers/crypto/fsl/rng_self_test.c
new file mode 100644
index 00000000000..7dabdc26551
--- /dev/null
+++ b/drivers/crypto/fsl/rng_self_test.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * CAAM RNG self test for the i.MX6 chips whose boot ROM gets it wrong
+ *
+ * Copyright 2018, 2021 NXP
+ * Copyright (C) 2026 Stefan Bigler, Securiton AG
+ * Copyright (C) 2026 Heiko Schocher, Nabla Software Engineering <hs@nabladev.com>
+ */
+
+#include <cpu_func.h>
+#include <log.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <vsprintf.h>
+#include <asm/arch/sys_proto.h>
+#include <linux/kernel.h>
+#include "jr.h"
+
+/* Number of words in the descriptor below */
+#define RNG_DSC_SIZE		0x36
+
+/* Size of the known answer the descriptor produces */
+#define RNG_KAT_SIZE		32
+
+/*
+ * Descriptor of the self test, taken from the NXP tree. The word five
+ * from the end holds the address the result is written to and is filled
+ * in before the descriptor is submitted.
+ */
+#define RNG_DSC_RESULT_IDX	(RNG_DSC_SIZE - 5)
+
+static const u32 rng_dsc[RNG_DSC_SIZE] = {
+	0xb0800036, 0x04800010, 0x3c85a15b, 0x50a9d0b1,
+	0x71a09fee, 0x2eecf20b, 0x02800020, 0xb267292e,
+	0x85bf712d, 0xe85ff43a, 0xa716b7fb, 0xc40bb528,
+	0x27b6f564, 0x8821cb5d, 0x9b5f6c26, 0x12a00020,
+	0x0a20de17, 0x6529357e, 0x316277ab, 0x2846254e,
+	0x34d23ba5, 0x6f5e9c32, 0x7abdc1bb, 0x0197a385,
+	0x82500405, 0xa2000001, 0x10880004, 0x00000005,
+	0x12820004, 0x00000020, 0x82500001, 0xa2000001,
+	0x10880004, 0x40000045, 0x02800020, 0x8f389cc7,
+	0xe7f7cbb0, 0x6bf2073d, 0xfc380b6d, 0xb22e9d1a,
+	0xee64fcb7, 0xa2b48d49, 0xdf9bc3a4, 0x82500009,
+	0xa2000001, 0x10880004, 0x00000005, 0x82500001,
+	0x60340020, 0xFFFFFFFF, 0xa2000001, 0x10880004,
+	0x00000005, 0x8250000d
+};
+
+static const u8 rng_result[RNG_KAT_SIZE] = {
+	0x3a, 0xfe, 0x2c, 0x87, 0xcc, 0xb6, 0x44, 0x49,
+	0x19, 0x16, 0x9a, 0x74, 0xa1, 0x31, 0x8b, 0xef,
+	0xf4, 0x86, 0x0b, 0xb9, 0x5e, 0xee, 0xae, 0x91,
+	0x92, 0xf4, 0xa9, 0x8f, 0xb0, 0x37, 0x18, 0xa4
+};
+
+/**
+ * rng_self_test_jobdesc() - build the self test descriptor
+ *
+ * @desc:	descriptor to fill in, RNG_DSC_SIZE words
+ * @result:	where the CAAM is to deposit the generated data
+ */
+static void rng_self_test_jobdesc(u32 *desc, u8 *result)
+{
+	uint i;
+
+	for (i = 0; i < RNG_DSC_SIZE; i++)
+		desc[i] = rng_dsc[i];
+
+	desc[RNG_DSC_RESULT_IDX] = (uintptr_t)result;
+}
+
+/**
+ * rng_test() - run the self test once and compare against the known answer
+ *
+ * A failure means the RNG cannot be trusted, so the board is stopped
+ * rather than left to carry on with keys derived from it.
+ */
+static void rng_test(void)
+{
+	u8 *result;
+	u32 *desc;
+	uint size;
+	int ret, i;
+
+	result = memalign(ARCH_DMA_MINALIGN, RNG_KAT_SIZE);
+	if (!result) {
+		puts("RNG:   not enough memory for the result\n");
+		return;
+	}
+
+	desc = memalign(ARCH_DMA_MINALIGN, sizeof(u32) * RNG_DSC_SIZE);
+	if (!desc) {
+		puts("RNG:   not enough memory for the descriptor\n");
+		free(result);
+		return;
+	}
+
+	rng_self_test_jobdesc(desc, result);
+
+	size = roundup(sizeof(u32) * RNG_DSC_SIZE, ARCH_DMA_MINALIGN);
+	flush_dcache_range((ulong)desc, (ulong)desc + size);
+	size = roundup(RNG_KAT_SIZE, ARCH_DMA_MINALIGN);
+	flush_dcache_range((ulong)result, (ulong)result + size);
+
+	ret = run_descriptor_jr(desc);
+	if (ret) {
+		printf("RNG:   self test descriptor failed: %d\n", ret);
+		goto err;
+	}
+
+	invalidate_dcache_range((ulong)result, (ulong)result + size);
+
+	for (i = 0; i < RNG_KAT_SIZE; i++)
+		debug("%02x", result[i]);
+	debug("\n");
+
+	if (memcmp(result, rng_result, RNG_KAT_SIZE))
+		goto err;
+
+	free(desc);
+	free(result);
+	puts("RNG:   self test passed\n");
+
+	return;
+
+err:
+	free(desc);
+	free(result);
+	panic("RNG:   self test failed\n");
+}
+
+/**
+ * rng_self_test_needed() - is this chip one of the affected ones?
+ *
+ * Chip and revision both have to match one of the pairs that NXP names
+ * as impacted, and no other revision of those chips is on that list.
+ */
+static bool rng_self_test_needed(void)
+{
+	if (is_cpu_type(MXC_CPU_MX6QP))
+		return soc_rev() == CHIP_REV_1_1;
+
+	if (is_cpu_type(MXC_CPU_MX6Q))
+		return soc_rev() == CHIP_REV_1_6;
+
+	if (is_cpu_type(MXC_CPU_MX6SOLO) || is_cpu_type(MXC_CPU_MX6DL) ||
+	    is_cpu_type(MXC_CPU_MX6SX))
+		return soc_rev() == CHIP_REV_1_4;
+
+	return false;
+}
+
+void rng_self_test(void)
+{
+	if (rng_self_test_needed())
+		rng_test();
+}
-- 
2.55.0

