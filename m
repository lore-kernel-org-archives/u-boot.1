Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AD7C3601E
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 13:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C15A82EA9;
	Mon,  7 Apr 2025 15:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qp4KEIHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CD8282D0C; Mon,  7 Apr 2025 15:28:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CB0182D0C
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BEFF95C5D31;
 Mon,  7 Apr 2025 13:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D06DC4CEE7;
 Mon,  7 Apr 2025 13:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744032515;
 bh=tg12pz8i4UR+RAB6bBc6VlBoiKs0Z2jem5UJ6MHxLEU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qp4KEIHL5QY6j3yxmjTvQBeCyPzCteyQPHfdYCYWIgCdcDe2zwVld5yD73yXxXTi/
 FYCKfMOjY7qzCmVSmyEYdwXItwHx+m1H1e2HsPO/zBEwIq2wB0RikiOqyRUN7k+aaW
 eheMBWo0/GEm6p9gm9BtnQbq72Edgd+qSlZmAmzDiVchXqqdgLkmhpvoMREu5DMAbS
 g1dbFjSnvX4ughw13HUbMWjF11XZ2MLQ8Ed38hfjhNJoKqoVe6PJywImuqcHuBhFW1
 pS/wvLJO0ADTQTRvrHzZoLypXBZIpnHwACBNkxrhY0P4LPnsRMGux+dlspBRs+h94Q
 VnaPyYvNWTe9g==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 1/2] arm: dts: Add override for RB1
Date: Mon,  7 Apr 2025 18:58:09 +0530
Message-ID: <20250407132810.35149-2-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407132810.35149-1-sumit.garg@kernel.org>
References: <20250407132810.35149-1-sumit.garg@kernel.org>
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

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

