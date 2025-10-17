Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327C7CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 22:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A018382E;
	Sat, 18 Oct 2025 00:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yhuwE9sX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="A5JQ2tEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6DC83849; Sat, 18 Oct 2025 00:07:30 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDEFF83804
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 00:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cpJpS3n03z9syB;
 Sat, 18 Oct 2025 00:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760738848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+q4LNJG5SLYNZLJUs+E0mOxzfZ7yZGF8UhpW4qvOFQw=;
 b=yhuwE9sXV2FT/VFGpLoI471fyUdPuOTYN7fVcdM1uUUeHjVAFXlS+1u73n0pt4b2DJa8tm
 Uk+cTjdoV7r7KAvtM9wmegyFgrBAsYKKtJd6Ey48ruIc+BtzI5qs+HJnzwRI7T5rxPdPx1
 9d7WI6naImp3y6Hp7b8uQ6JK11etNIF/iAxeXUKl4LASB/s2TF/6wFh6Z0NY/zpEobuoTM
 sZXiT7OtfRFIs69uucZNoexPVbrAz07YgOC2pyeFqZzXvpVXd7JDV3to/4YD+S9aG6GEMs
 /sLQrPNbH9/XeMZpQOJOsNZrOw4p+kkBJQgEo4aPzIAhr7koBEArSeXgn/qM/Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=A5JQ2tEe;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760738846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+q4LNJG5SLYNZLJUs+E0mOxzfZ7yZGF8UhpW4qvOFQw=;
 b=A5JQ2tEelWckMogb2SxVTspl195d2K3sud8uBrdE73AaHZLKxCgovG6eQ4KsTUIrbCA09g
 IYUr3RkazOPuMwjErcwClQnRmgUn2ZdYCAlKBw3VI2Q3V+jzEr0GuMbpOgC98QtJ/dvLz/
 4urL8g1GkfQ938TpUSWgtZ2ZWB8W8uNomsjNtE2yEBeXwyxj2rfiQRF2Ndmqb+n/pFaLgN
 DTI8JvoZ2Yy1iD+ji3TFQe1+YYUrq6rG1VNcbMBgei1qXsP0ksre0uI7gLvjKhunk+hhAS
 YPAVvW2I3uJgZqFrj305m+8QMnd/NDC3R9ni4LdlHeyTuAzFKr3QZIn0lQ88MA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: dts: renesas: Reinstate R8A779H0 V4M U-Boot DTs
Date: Sat, 18 Oct 2025 00:06:33 +0200
Message-ID: <20251017220712.138333-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 42c8f406630c15a9b87
X-MBO-RS-META: ix9nj5busueu4wim51tzr6ic5s7bw16a
X-Rspamd-Queue-Id: 4cpJpS3n03z9syB
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

Commit 63da3a795e86 ("ARM: dts: renesas: Drop R8A779H0 V4M DTs with OF_UPSTREAM counterparts")
removed unnecessary V4H DTs from arch/arm/dts , but in the process
also incorrectly dropped the -u-boot.dtsi U-Boot extras. Reinstate
those extras.

Due to DT file name change for the R8A779H0 V4M Gray Hawk, update
the r8a779h0-gray-hawk-u-boot.dtsi filename to newly matching
r8a779h0-gray-hawk-single-u-boot.dtsi .

Align r8a779h0-u-boot.dtsi with clean up commits
1487c34efa7b ("arm64: dts: renesas: Deduplicate extalr_clk bootph-all")
dd8f57ed2f0b ("ARM: dts: renesas: Drop most of bootph-* tags")

Fixes: 63da3a795e86 ("ARM: dts: renesas: Drop R8A779H0 V4M DTs with OF_UPSTREAM counterparts")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 .../dts/r8a779h0-gray-hawk-single-u-boot.dtsi | 41 +++++++++++++++++++
 arch/arm/dts/r8a779h0-u-boot.dtsi             | 11 +++++
 2 files changed, 52 insertions(+)
 create mode 100644 arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a779h0-u-boot.dtsi

diff --git a/arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi b/arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi
new file mode 100644
index 00000000000..91e1ee1f890
--- /dev/null
+++ b/arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source extras for U-Boot for the Gray Hawk board
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#include "r8a779h0-u-boot.dtsi"
+
+/ {
+	aliases {
+		spi0 = &rpc;
+	};
+};
+
+&pfc {
+	qspi0_pins: qspi0 {
+		groups = "qspi0_ctrl", "qspi0_data4";
+		function = "qspi0";
+	};
+};
+
+&rpc {
+	pinctrl-0 = <&qspi0_pins>;
+	pinctrl-names = "default";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	spi-max-frequency = <40000000>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "s25fs512s", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+	};
+};
diff --git a/arch/arm/dts/r8a779h0-u-boot.dtsi b/arch/arm/dts/r8a779h0-u-boot.dtsi
new file mode 100644
index 00000000000..40e070be9a8
--- /dev/null
+++ b/arch/arm/dts/r8a779h0-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source extras for U-Boot on R-Car R8A779H0 SoC
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+&rpc {
+	bank-width = <2>;
+	num-cs = <1>;
+};
-- 
2.51.0

