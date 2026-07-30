Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82110C5516D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 20:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 537BC40C64;
	Thu, 30 Jul 2026 20:24:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Exo4GTZLNyzG; Thu, 30 Jul 2026 20:24:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9740D40D44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785443089;
	bh=HYH0z6PcjMsW7jVlOomtnKZdxhD4/OpOGRsHxg5RPOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C51Lb4YzxjYnLfNtmw1btq/Pi+cm7Hf2gZewHunx5q5iB69JwDDARE5fFNhIxQM1g
	 JMGZAjIYNeHZqMMU2uvrJKbxz29Tb/YLTo4/SL6AAjZzQwIihOAymI+IOb4QlLPgGT
	 zcgc89WQbJg7uwRhFtZolVsrE+Vzq/BheIiwFjN8c/0KRqG8tcPyPt2Q52HcghPW7R
	 lJfqPQsnfRNS1U5/KieS8nQGIrpJoOrRPct75tNGdL66Twau7PlN3BGcIBHSSyhWU4
	 zoH4d6lIuiEmA9/vW3MGWx4WnsfA639Lp18P+lfYKigeD82eNpLX/k0kRmVNbMP/mM
	 gsAluoeilTL1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9740D40D44;
	Thu, 30 Jul 2026 20:24:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 81D662CE
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7357B40D3D
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:38:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hcQvFYN4w1Nr for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 19:38:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=elliotjb@elliotjb.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1892840D14
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1892840D14
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1892840D14
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 19:38:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8FE84A0B; Thu, 30 Jul 2026 21:38:26 +0200 (CEST)
Received: from MTA-12-4.privateemail.com (mta-12-4.privateemail.com
 [198.54.127.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F6C849BC
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 21:38:24 +0200 (CEST)
Received: from mail.privateemail.com (K8S-PROD-WORKER-15 [77.233.63.4])
 by mta-12.privateemail.com (Postfix) with ESMTPA id 4h9zyM3VQbz3hhTX;
 Thu, 30 Jul 2026 15:38:18 -0400 (EDT)
From: Elliot Berman <elliotjb@elliotjb.com>
Date: Thu, 30 Jul 2026 12:37:45 -0700
Subject: [PATCH 1/3] x86: qemu: Describe pflash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-qemu-x86-pflash-v1-1-fb403348e29b@elliotjb.com>
References: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
In-Reply-To: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Elliot Berman <elliotjb@elliotjb.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 30 Jul 2026 20:24:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=elliotjb.com; s=default; t=1785440302;
 bh=hus4gTZQ33U8hLHynRlEeTjs9/ULFoWvCxcs1hZo2c4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=R7AaRtcH6tttmKPx9Lj7hggX+YIG4DZIVtc8bytHtACtvLTNra8ArxFlKkYd1AfOt
 MT8z3rRXyQwTIS+pxD0Rr0xe2UBLtMhJnFH1U1HYpGmv/pFZ7NFzj/bAkegBbSBnwi
 wCLbxPXED0oA2XXPLjFHCtGm61ZPPiWB+7tNc5DA5qhhB7ccawnmaqzO72SW28jvao
 661gfwGhjO/4WvcApXTVdGtDPlyYs1bY5SFuXAu5siAirw23CqYIsYpHxX6GgbKCf3
 42jbL9bOzyiIRlPD14w3d9z5wkRbCItX5Otk8DbHlH3R22Veu5VzPsfwgCfQTGa6KB
 NjbM0MRvTMi+A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.a=rsa-sha256
 header.s=default header.b=R7AaRtcH
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=elliotjb@elliotjb.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.b="R7AaRtcH";
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

QEMU pflash is mapped just below 4GiB. Describe it as a cfi-flash
node so the MTD subsystem can probe it. When a flash device is not
exposed to the guest by QEMU, the address is still backed by ROM, so
we'll just see no flash found rather than faulting.

Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
---
 arch/x86/dts/pflash.dtsi         | 14 ++++++++++++++
 arch/x86/dts/qemu-x86_i440fx.dts |  1 +
 arch/x86/dts/qemu-x86_q35.dts    |  1 +
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/dts/pflash.dtsi b/arch/x86/dts/pflash.dtsi
new file mode 100644
index 00000000000..ce69bcc6865
--- /dev/null
+++ b/arch/x86/dts/pflash.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * QEMU pflash (CFI NOR) mapped just below 4GiB. QEMU aligns the pflash so
+ * that it ends at the top of the 32-bit address space.
+ * https://gitlab.com/qemu-project/qemu/-/blob/e1705a25aff35635c360bbaba4c2731d019a422a/hw/i386/pc_sysfw.c#L128
+ */
+
+/ {
+	pflash {
+		compatible = "cfi-flash";
+		reg = <(0x100000000 - CONFIG_ROM_SIZE) CONFIG_ROM_SIZE>;
+		bank-width = <1>;
+	};
+};
diff --git a/arch/x86/dts/qemu-x86_i440fx.dts b/arch/x86/dts/qemu-x86_i440fx.dts
index 3bb2f121de3..7f9ff6b1cfb 100644
--- a/arch/x86/dts/qemu-x86_i440fx.dts
+++ b/arch/x86/dts/qemu-x86_i440fx.dts
@@ -15,6 +15,7 @@
 
 #include "tsc_timer.dtsi"
 #include "smbios.dtsi"
+#include "pflash.dtsi"
 
 / {
 	model = "QEMU x86 (I440FX)";
diff --git a/arch/x86/dts/qemu-x86_q35.dts b/arch/x86/dts/qemu-x86_q35.dts
index 63931cd6dd9..24c93c45677 100644
--- a/arch/x86/dts/qemu-x86_q35.dts
+++ b/arch/x86/dts/qemu-x86_q35.dts
@@ -25,6 +25,7 @@
 
 #include "tsc_timer.dtsi"
 #include "smbios.dtsi"
+#include "pflash.dtsi"
 
 / {
 	model = "QEMU x86 (Q35)";

-- 
2.54.0

