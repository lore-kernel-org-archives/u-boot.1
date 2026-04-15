Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA697FA0C26
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 05:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5694383936;
	Wed, 15 Apr 2026 07:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SnoS26Q9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C1E2839D5; Wed, 15 Apr 2026 07:27:36 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A5E838BB
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 07:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C24B40B37;
 Wed, 15 Apr 2026 05:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE96BC19424;
 Wed, 15 Apr 2026 05:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776230852;
 bh=5GVBShWrXs4pxw8yY80o1cPn3WVjPTxEwtezj8qnqhM=;
 h=From:To:Cc:Subject:Date:From;
 b=SnoS26Q9wTkQi8q57TDhfvaHyrqBJa9DxsYD4lGyq51S4FVJWu5dP+v8aAg6cdcKl
 kNBsPcKtrY7yW+7MsQBo9k2spgApGbLW/sj9LZ5ysap0Rv28t+CmHAblOykzUGs82B
 dpdXvJqt4zwuMLONZ/F65oUPncqF5tveTCpCaKxJayCvVLfmpXcqMbsUr6e0Rtf3cc
 WrJbEObnXtBMzzrXSTIOKYgMKfyx6XjiZTM4ar6p4bPWIy93T6YqqESHoe58Q5mT/c
 Lq9Y6HJXkRhpWHb39QoHsO1akLpeQs56gmlOaZ0BohhrveyS0OE2WUuMb89vChecGh
 b1o4um7h5PKjQ==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot@lists.denx.de
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH] dts: lemans-evk-u-boot: add override dtsi
Date: Wed, 15 Apr 2026 10:56:59 +0530
Message-ID: <20260415052659.507928-1-sumit.garg@kernel.org>
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
 arch/arm/dts/lemans-evk-u-boot.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 arch/arm/dts/lemans-evk-u-boot.dtsi

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
new file mode 100644
index 00000000000..c79ef80d1c5
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
+		      <0xD 0x00000000 0x2 0x80000000>,
+		      <0xA 0x80000000 0x1 0x80000000>,
+		      <0x9 0x00000000 0x1 0x80000000>,
+		      <0x1 0x00000000 0x3 0x00000000>,
+		      <0x0 0xd0000000 0x0 0x01900000>,
+		      <0x0 0xd3500000 0x0 0x2cb00000>;
+	};
+};
-- 
2.51.0

