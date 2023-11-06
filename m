Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2678C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9537687137;
	Mon,  6 Nov 2023 17:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SxWLsbea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA5358715B; Mon,  6 Nov 2023 17:33:33 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C9C86FF4
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-778a25cad6dso20894985a.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699288408; x=1699893208; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5ac8wda8A2f5qn7q6xsYEyagdbLtJ4niwDPheQw5ZVs=;
 b=SxWLsbeatWu0fwsd47RdK/7Fxcs0RyRUNdtVK3oj6hVzWz1Iql75dq5cBjcOJMdRBC
 pYjt6ypxEBwiRJPaDnoVys3Xbbe61bQMbKR46FliwXlJ4ihMmywrbulXEozulSaGRcvj
 M+DRnWLz4LxcQkielGmBEUgyvK/T2m67PVv7a+vcRA2JVCW0KvW452rRNMUbYRKWH0fG
 bJebuod70g7kmjK8aa2ycxphF9/4nXBwX6fdnlyTZMAvFy5gVsOE/p26YRDImcgVTY/m
 XyXsipSJh5pEpfDHChtXfl6NOxQZ8uW8RrXKDCiytFTBJCN8nOzoZQmcYjcde7OknM0o
 Cn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288408; x=1699893208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ac8wda8A2f5qn7q6xsYEyagdbLtJ4niwDPheQw5ZVs=;
 b=wAi22P44QVyKZjpSdUhj8Xfsx/RqoWSQE3bVJnkffGmBcAoku4Og9JO0cvSnYd6R7R
 InirrpJn0AdvkK1ytTkaV6AToCR2Gx8piNe9oCjURnRkndAR5ivJG4ChsM/VYLnBPGB2
 je4bAt7gQySsEz2XYsvCg7XnNjRUJzQRmtkGQYZWUD/4SMwxHCpCx/p+0Kz0E93QB6yC
 ZNSR4PVUcsDehrmkoCVzrZ4AcXcCbjVOi91MbkBRqsf7PklQ6QCzDToHxCl2QIvohNu9
 wB4Y41pW/1Lek9W39a5Afjn5chIndx1h5I0F6k+nlB4nKyBwpLT9ruOKwPnK+RRiDYGX
 ociw==
X-Gm-Message-State: AOJu0YwEEfYWy9tdd99lR06A/KxODDKctUfMggO8MsIq9vbeMnUd2ouw
 kEcJxVmb34QieQHtp6856dK4I3aBfHI=
X-Google-Smtp-Source: AGHT+IHN0DpG5VrrEtzoqIuyFETHP1agvtY1WXpqfMIJr2jk8L93kj9nJvrtnP6Am56FXm99BxCiog==
X-Received: by 2002:a05:620a:1a1a:b0:773:a789:cd15 with SMTP id
 bk26-20020a05620a1a1a00b00773a789cd15mr33598563qkb.6.1699288407876; 
 Mon, 06 Nov 2023 08:33:27 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:91e3:ce2:e2f8:4628])
 by smtp.gmail.com with ESMTPSA id
 az42-20020a05620a172a00b0077407e3d68asm3407235qkb.111.2023.11.06.08.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:33:27 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] imx7s-warp-u-boot: Fix aliases and chosen nodes
 indentation
Date: Mon,  6 Nov 2023 13:33:22 -0300
Message-Id: <20231106163323.2883561-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The aliases and chosen nodes are currently indented using spaces.

Fix them to use the standard tab indentation.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx7s-warp-u-boot.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/imx7s-warp-u-boot.dtsi b/arch/arm/dts/imx7s-warp-u-boot.dtsi
index 49b992dcccaf..4f44598c9a27 100644
--- a/arch/arm/dts/imx7s-warp-u-boot.dtsi
+++ b/arch/arm/dts/imx7s-warp-u-boot.dtsi
@@ -1,12 +1,12 @@
 / {
-    aliases {
-        mmc0 = &usdhc3;
-        usb0 = &usbotg1;
-    };
+	aliases {
+		mmc0 = &usdhc3;
+		usb0 = &usbotg1;
+	};
 
-    chosen {
-        stdout-path = &uart1;
-    };
+	chosen {
+		stdout-path = &uart1;
+	};
 };
 
 &aips3 {
-- 
2.34.1

