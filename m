Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E50FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D122840AB;
	Sat, 25 Apr 2026 19:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="loOzN12/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 961DA841DF; Sat, 25 Apr 2026 19:08:59 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58E2A840AB
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 678DE4048C;
 Fri, 24 Apr 2026 10:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDA9C2BCB9;
 Fri, 24 Apr 2026 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777027366;
 bh=5vxQ/yerrc0T6oNjk3IJr+fUwGuyYCqEVuNH2NjmMoU=;
 h=From:To:Cc:Subject:Date:From;
 b=loOzN12/6qpEvwKxLU/rJe6Dc4ENRJv7Z6/nNBgiqV8Kfh9FYggkOyDmFBeHI/qvu
 9xzmLKRiohsrrB6wCHbQXqE4MPYxAfZ88mCuVoH0zNChLCdk6OJFcpNL6+SVdtg8oI
 p4w+xkVuuZDbSH/n1iNK6AcuR8z8l3EubEGNA6hEgNgPGMlRDPaWz284ZiyEM1bqqc
 PA06k8bVbxE+RjWAG7ZVly728ddH9dzQgdjvm1EhJQnDvwKI6HO+q2gJ9AZSOzPXwZ
 qX7+vwmBfDy5Y0ll66U3pg11iahPtLYUqKzj8JDfQAoOJaNyo8JSvwCewr3NSCAAlq
 s+4xsDbftPUpA==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot@lists.denx.de
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2] dts: lemans-evk-u-boot: add override dtsi
Date: Fri, 24 Apr 2026 16:12:37 +0530
Message-ID: <20260424104237.968195-1-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Add initial support for the lemans EVK platform based on lemans SoC.
Define memory layout statically.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---

Changes in v2:
- Fix last DRAM bank of memory layout

 arch/arm/dts/lemans-evk-u-boot.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 arch/arm/dts/lemans-evk-u-boot.dtsi

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
new file mode 100644
index 00000000000..cdd3d32f61a
--- /dev/null
+++ b/arch/arm/dts/lemans-evk-u-boot.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2026, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/ {
+	/* Will be removed when bootloader updates later */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x3ee00000>,
+		      <0x0 0xc0000000 0x0 0x0fd00000>,
+		      <0xD 0x00000000 0x2 0x54100000>,
+		      <0xA 0x80000000 0x1 0x80000000>,
+		      <0x9 0x00000000 0x1 0x80000000>,
+		      <0x1 0x00000000 0x3 0x00000000>,
+		      <0x0 0xd0000000 0x0 0x01900000>,
+		      <0x0 0xd3500000 0x0 0x2cb00000>;
+	};
+};
-- 
2.51.0

