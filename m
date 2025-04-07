Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20E3C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4D8830B6;
	Mon,  7 Apr 2025 20:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9D7982CEB; Mon,  7 Apr 2025 15:22:18 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D918F82D0C
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=u/I6=WZ=oss.qualcomm.com=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C9084441F5;
 Mon,  7 Apr 2025 13:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4D6C4CEDD;
 Mon,  7 Apr 2025 13:22:13 +0000 (UTC)
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 1/2] arm: dts: Add override for RB1
Date: Mon,  7 Apr 2025 18:51:56 +0530
Message-ID: <20250407132157.34628-2-sumit.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407132157.34628-1-sumit.garg@oss.qualcomm.com>
References: <20250407132157.34628-1-sumit.garg@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Apr 2025 20:15:00 +0200
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

Add U-Boot override for RB1 to for USB in host mode as OTG mode isn't
supported. Also, disable sdhc_2 as it's currently not supported, sdhc_1
works fine though.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 arch/arm/dts/qrb2210-rb1-u-boot.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 arch/arm/dts/qrb2210-rb1-u-boot.dtsi

diff --git a/arch/arm/dts/qrb2210-rb1-u-boot.dtsi b/arch/arm/dts/qrb2210-rb1-u-boot.dtsi
new file mode 100644
index 00000000000..1e136ee405a
--- /dev/null
+++ b/arch/arm/dts/qrb2210-rb1-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* This is usually OTG but U-Boot doesn't support that properly */
+&usb_dwc3 {
+	dr_mode = "host";
+};
+
+/* SDHC_2 isn't supported in U-Boot as of now */
+&sdhc_2 {
+	status = "disabled";
+};
-- 
2.43.0

