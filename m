Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E96C369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 13:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A8C682132;
	Fri, 25 Apr 2025 15:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LkK1ABuK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A352982140; Fri, 25 Apr 2025 15:52:39 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D33C820F6
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 15:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3031354f134so1910788a91.3
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 06:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745589156; x=1746193956; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WipG9lCERsTUPPRzwDzI/LewZw68xh9KIYQpWqqToNI=;
 b=LkK1ABuKeK/fXqo0iU23/IWz1xoJvBIzBW8PKkRzUbuqv7dYqH/gdaGDdZC3qLJwL+
 Qdbxt2K5qIc3PobeJqZcjTY6M4zH7Fa4kgs/z4vC/XkAyK1VKweX2abak05ohQUNYvcO
 h01u8AsHejJDZcDm3wkZOIfio2h2BF/zVZIZooH6/hGLxF/aEPikwGUhqgcfo63o3z2/
 xV1hV3S4thKDQnoa0ZF3zlH3+0Breb9YM4LjAb2Us2an9FybxX5eaXsDxUZajvy7eXVY
 vxg1bw4Wmwjqp0kugrvADDaECs3gh31Ouz75eJ81mpNTRvufhrgWPJo25ri1TFh0hPxY
 Ad8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745589156; x=1746193956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WipG9lCERsTUPPRzwDzI/LewZw68xh9KIYQpWqqToNI=;
 b=DcQScO1hWSvK0CA8O85ViW6LZrOuQ22SrXxX0nN2GQpJ4v9lTPdq3WFL3T59SmHvqy
 7ar4fd3ARTgrA0k92Vl+bahaHyyEqIpSmnqQtZSpyQGGacbeFQT6rU3OphC1uf9NrRum
 iS5L6bbnQk9bRGU5cs/kCKflkzr0aqbQMiNRBJNANFT9oTLcnPTZN9dAzrDnajoDlzsu
 qVRr/O1vXiF4g+XJizYJLGOQSh4brMVDQW9JH7DoXZdCRZvJB9ps2e2Ay8/oVq+4a9ap
 PMuMRh9Aj6wLNkwuNPqgKU2kbQHyAcnyMBFsFPQelbFCsMiMymqIYBrBKw0Fw0dooRMQ
 t4ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCiulbodE0BTznDrtckCaxG4P2p20SolgRxDeYWvLvgSfpp5g0K0TkjiMupYDrXWfMb0rXP0I=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4rKwEN7bXnx6NkcFm34vJrrngI5wgeXGsqUmI+u6mfboZk8su
 ngBDn9x2XKssgZDdsZC++heT+P30v/zXUAfR01dcFDyVpw67AXRx
X-Gm-Gg: ASbGnctbJgXg8qYGMbnyuoKyRoUAfGQyyYzkkDbYrcPqX5cKtcokmvUCsX/ul9BiBOp
 dyelhII2k3Fu6MuZ3nLa0l1YVTmRfoP5Pwe9I0mJZfeEXzrGlcsGHcB1pxhvrreo+X6K/c3sAeR
 pPiYfIEumPMdxODFIRrl5qSZSA2p/xRlwslmSFG8QlTKXDc097DQmWUG+lfwD/cbc9M6GRJGKwK
 JbkzW+kBJbgfDFjPUliAEBsXlxRfKP9w3HEgnQVWC9ZK9heTdIagTG/ooJ3yOwOD63fk2w6X5PV
 MrhFnhtW9pxARDzfJ2c1tT76HYTJglOUiSaTQoRbLvMXDpGQagcc/O6QpQMt/Tv2Yg==
X-Google-Smtp-Source: AGHT+IFg1Tt6qw5eY2uAWxp6X5A6V67/vtwMMgTmjgxryKLW8/LH2xgTpO86NyY0Ptnu6KDusaJ9sQ==
X-Received: by 2002:a17:90b:17c9:b0:301:1bce:c255 with SMTP id
 98e67ed59e1d1-309f7e82045mr3831230a91.27.1745589155908; 
 Fri, 25 Apr 2025 06:52:35 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:6fb9:f343:690b:2e7d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f77371d1sm1619864a91.2.2025.04.25.06.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 06:52:35 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: trini@konsulko.com, aford173@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 4/4] arm64: dts: imx8mm: Allow osc_24m to be available in SPL
Date: Fri, 25 Apr 2025 10:52:20 -0300
Message-Id: <20250425135220.1929510-4-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250425135220.1929510-1-festevam@gmail.com>
References: <20250425135220.1929510-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Align the osc_24m node with the imx8mn, so that it can be available in SPL.

This fixes a long pause in SPL when loading U-Boot proper.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index abb3aa5b635..a1ae2371773 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -229,6 +229,10 @@
 	/delete-property/ assigned-clocks;
 	/delete-property/ assigned-clock-parents;
 	/delete-property/ assigned-clock-rates;
+#ifdef CONFIG_SPL_BUILD
+	clocks = <&osc_24m>;
+	clock-names = "osc_24m";
+#endif
 };
 
 &iomuxc {
-- 
2.34.1

