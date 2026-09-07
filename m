Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CB5C79FA1
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 15:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76E4160690;
	Mon,  7 Sep 2026 15:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5XDbONX-OiYG; Mon,  7 Sep 2026 15:35:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AE31960675
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788795351;
	b=P+OA181f5im1HKff+2LqYjE1UsawHVT0TEfd3u0eR7l21Ewpbr33TRY0f5fDipDoI3B2
	 8yCdX7uOeNOJwbEnhH8m8knitNaDJMa5k9LB2GeaP9PKtXaA2UMPmeUajZgZOZhLa08Y3
	 yPyFhFVapZpnF1ORdKQ00vx9AZvzsc+CtcHOCx9usLDgc4x1+UHNbHyyRtxq6vV2pRPwJ
	 5XoJ6dLFfU6Gx+7752k2xcCJTUbmySfpJfjxNXtSiPcafpqHEgm+JptVcZhSWIF1WVcUu
	 QmiRWCEchPxgfS1zbpGG1Xzt8DF+lSm7WYLv0KxVbzGNkVh+4uNSLlzC8ZKi2qSm+6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788795351;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lW33oY/6dPGTalJ9ePwHCxgyD7EFpS8qMW++pAbz+js=;
	b=MyTIdYdSaAThDXr1CDWyzsc6YKfM9wj+Nr17nhR4AHEmd0jgj2EOzMB96yQ0Z6l6gx0O
	 rV4LCnsTBPizSfIrCUdbqE5sYsUpneE4KHUtjbu/q3QRcIX/pE1l6Eqrk3OgfYSaWa87E
	 OoFyN5T0wsu8nObC41TaudBrMOcsxjZ8nObdDBvzT3Fvd09qkgYsbcDvIsQD0G7zmbJbt
	 bRCE+rO0YEny9ZlEl4pgkX3cMvNnyJCEKQf13LYZqY/jrUuvUA+3ef/qX5O4o1v/JeD9i
	 CxWHBmTUcSsi3v4bX+9OAlJEybc+r2rtuKm06XxKtnf/xCckloVEW/Z/IwUkmUiNfFA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788795351;
	bh=lW33oY/6dPGTalJ9ePwHCxgyD7EFpS8qMW++pAbz+js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IUFu+u4WY0A5CQCFsKJetdFnHv2cogaaEU4HuuCbqv37jyo3MYmyl3iJdqvg72ipF
	 6uavPPpgqiwtuNURS2RhskuhT4YYppgfD9F87CxhnZtidSgCGKMsz2yBNzLlKIJv1d
	 YX5gJqSpZdBITR2YSJICDwuYLQy4QxJ5uomZCHSyn5pv/hM+vw9J9EkaWLR3G/N9Ts
	 lCc4oTIi+miYyTuvYjgQM16gXZ9Lnr67FBfqBWVXvmeDmDdX2x7iupeQYkCV7HZejx
	 lFwCdH6UNj8H2Y1FuoyJ/IOQHlyy6xKRLUIMFZNF2kxpN3GaMXGgZvFdRn6pfh25ke
	 QE4q9//YsmRKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE31960675;
	Mon,  7 Sep 2026 15:35:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB6C029B
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5FCC4055D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:35:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sulQlCxKXuyz for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 15:35:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 006F3403F8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788795350;
 b=FHv3D4c5aFJhXtwtHnL2SqqKIN+4AE07xWJnvZwOGLEoNrvwaOVGqOLrLKnKkR+eDTM7
 teWjQOrlsarGskUxA0txPVVwwjrgclb7pxd8fAaHn/ElgIlkdat5S99zkSYd94By/kz60
 qxiVQ14iqN9lncbx+NINpidocSwkyavG+DFLz+B2BfbtlZku+Ik4XCkntrpxSdt0WmOZO
 WFF+sPjF/rop58NR4LQThE2C2xtBVIJxL8QnXDynrY9UXE2pg50F+QnfOPGNNRyCDcO9l
 EL+zo3+BVmlGvwP+MF5Bs9nRfoi5ZxrvzfBUdJqTxYLjlTbbLWDYcXal63e3vzo1HcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788795350;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=lW33oY/6dPGTalJ9ePwHCxgyD7EFpS8qMW++pAbz+js=;
 b=sVixP7G4v0/HCshlzWRi++pO4yIsyPVGte7JhqTqZXZuTsCli1R8cC2OvpRx9hpNTLCq
 gQFmcwai3p5zVuThiLeyjNg5xRZRXCSAN0+rYbEHCFKwfz082QfDg3gLlYOQR4FGz6DUx
 FUMygyUj8mA5qNfm/d+qrA/XIpgTjr2DY1VbqgtCP2B81pWFJ+ws/hspKtTfKpW6Wtrp9
 vtD0cqcsWQkOtLfJ1qVZmyA6gh5cakQeeyOk2i1xU/9XQ7FDRDDUpYKNvmjuuNdKn3QPF
 RlCAnNuB6SxifcvVmUlssxewJNirrClBJY1Koxi4aQXVMG/tx5EixP5enKelrvothZA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=AiPTtIps; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=AiPTtIps
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 006F3403F8
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:35:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 98482B0057C;
 Mon,  7 Sep 2026 17:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1788795347;
 bh=K/+IuYgg7gX6n8pxxAxa2yDvzu9VjJo7z8XAGCLlyBU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AiPTtIpsj3tb2TNsvDB6PjIKZ9U7L112Nr+SGnUHH73+7MZJz767BWDBbqB8pR7wr
 qyeXm3THk8up7hbkPByB4yWDbcuamDR2a660n+ONT/ll7+oHY/xCC5Ds04P9YPi3AE
 oGAd5YtkBkSDImI2PYpoGTVK90LsbgYsvp48bSn3yFotpAfM0R9FC7XoyntpPW/mnr
 fiQISM5Ei5hLV6qUb94k8CQFpNvoqTGI4IS7B1hJ0U5VC5+d/h/46a8543VgEkhccy
 v+L7V/Hkz29fYbd67F2IvsGJ/MSwfF0Ybt+igEbofOGYoxrzN/cM+Q6XE4lL/GKFNR
 okrtgJOro7bkQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Simon Glass <sjg@chromium.org>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 4/8] board: nbxv3: add boot-time PMBus PSU traces
Date: Mon,  7 Sep 2026 17:34:06 +0200
Message-ID: <20260907153411.2207773-5-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907153411.2207773-1-vjardin@free.fr>
References: <20260907153411.2207773-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Reuses the shared
  pmbus_print_telemetry() / pmbus_print_status_word() helpers,
for the 48V->12V Flex PSU reports.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 board/nxp/lx2160a/nbxv3/Makefile    |  1 +
 board/nxp/lx2160a/nbxv3/psu_pmbus.c | 72 +++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 board/nxp/lx2160a/nbxv3/psu_pmbus.c

diff --git a/board/nxp/lx2160a/nbxv3/Makefile b/board/nxp/lx2160a/nbxv3/Makefile
index e4aa5309804..24874138833 100644
--- a/board/nxp/lx2160a/nbxv3/Makefile
+++ b/board/nxp/lx2160a/nbxv3/Makefile
@@ -4,3 +4,4 @@
 
 obj-y += eth_nbxv3.o
 obj-y += mps_pmbus.o
+obj-y += psu_pmbus.o
diff --git a/board/nxp/lx2160a/nbxv3/psu_pmbus.c b/board/nxp/lx2160a/nbxv3/psu_pmbus.c
new file mode 100644
index 00000000000..d188633f69b
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/psu_pmbus.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile, Vincent Jardin
+ *
+ * Nodebox v3 boot-time info of the carrier PMBus PSU(s).
+ */
+
+#include <dm.h>
+#include <event.h>
+#include <i2c.h>
+#include <pmbus.h>
+#include <dm/uclass.h>
+#include <power/regulator.h>
+
+#define NBXV3_GENERIC_PMBUS_DRIVER	"pmbus_generic_regulator"
+
+static void nbxv3_psu_snapshot_one(struct udevice *reg)
+{
+	struct udevice *parent = dev_get_parent(reg);
+	struct udevice *chip;
+	int bus_seq, addr;
+	const struct pmbus_active_dev *act;
+
+	if (!parent || device_get_uclass_id(parent) != UCLASS_I2C)
+		return;
+	bus_seq = dev_seq(parent);
+	addr = dev_read_addr(reg);
+	if (addr < 0 || addr > 0x7f)
+		return;
+
+	/* Select the device: caches MFR_* + reuses the generic info. */
+	if (pmbus_set_active(bus_seq, (u8)addr))
+		return;
+	act = pmbus_active();
+	if (!act)
+		return;
+	if (pmbus_active_get_i2c(&chip))
+		return;
+
+	printf("PMBus PSU @ i2c%d:0x%02x", act->bus_seq, act->addr);
+	if (act->name[0])
+		printf("  rail=\"%s\"", act->name);
+	if (act->mfr_id[0])
+		printf("  MFR_ID=\"%s\"", act->mfr_id);
+	if (act->mfr_model[0])
+		printf("  MODEL=\"%s\"", act->mfr_model);
+	printf("\n");
+
+	pmbus_print_telemetry(chip);
+
+	pmbus_print_status_word(chip);
+}
+
+static int nbxv3_psu_pmbus_last_stage_init(void)
+{
+	struct udevice *reg;
+	struct uclass *uc;
+
+	if (uclass_get(UCLASS_REGULATOR, &uc))
+		return 0;
+
+	uclass_foreach_dev(reg, uc) {
+		if (!reg->driver || !reg->driver->name)
+			continue;
+		if (strcmp(reg->driver->name, NBXV3_GENERIC_PMBUS_DRIVER))
+			continue;
+		nbxv3_psu_snapshot_one(reg);
+	}
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, nbxv3_psu_pmbus_last_stage_init);
-- 
2.43.0

