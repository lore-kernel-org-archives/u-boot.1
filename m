Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08D0C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC11880F12;
	Thu, 27 Feb 2025 13:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yx3mKFXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5979A80FF0; Thu, 27 Feb 2025 13:09:56 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88CF0801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22349bb8605so15622805ad.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740658192; x=1741262992; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=54VYyLHBYKSttrAi4TqCddbxLvMtQdIqVL9G0w46dF0=;
 b=yx3mKFXB9LskH+GKbOPOkgAHmkwe7EUqSSpFP9MAMwUlBbxG2snB6IGu6bzATfLKx4
 YxL066Tdkiamt8GhktF0ZKHUi08YD37+X4bya6SICQD6354melN/qW5vWc3BLnPSon+K
 Rp6kV1Ls4SOxLk7SaqD6jb6chpgseNfIaqsWj59PFRo62SaeRZVJjMVbUbk35tihR64X
 3dz+MjhpnagPekQv/pnyqVeiDIOsbe3Zi0IwxADPV5yq8tFFufD+g95DovLx3BhcvKvZ
 5QebQCgm7VoVHmt4MbqNnrSBFCcNJF4w/M8HaSNdK3xOrY9siv8tPGsXKPGKdn71zrQ2
 hYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740658192; x=1741262992;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=54VYyLHBYKSttrAi4TqCddbxLvMtQdIqVL9G0w46dF0=;
 b=gL/H4l5Tokso+yZb7Bg94SxU8t2negoMFOidL+7uulQx7FcaM4waYGywaglSlurlTA
 y4DGmHL52fvLXr5JkBu5IQMrtmYdEojRI9OAcz/9p/tbIgryN2bV9w5/EciKrlCm5VJ3
 zAM8t/9WZZ7sWNq+6N1tGfGhYuWiAqjShNqInUEyjofXTxz99drg++GR7U+0z9Maroo+
 IaKGUgKcQzU8p0iq3Wcj2DW7OzpVENwcm8ZVt4Pg/CaWrTFdMSaUiUXnmhTiGAmnCzRw
 Vi9MjxoUCRpv1tRR8CLW2yjnU6moRlISALvmos+znDdnGEaJgiPIV0Pzu/Eob5B7XE3Y
 tR5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/udQBhXfrUPoC/EbG0h5sWB1k82nwrXBvdeQpKSu7wpdTPYN7JymUQ6/cEAnfyGHmq2EesHI=@lists.denx.de
X-Gm-Message-State: AOJu0YxL0pcIdI1msEu0+gDCff1VGI/WQegc3IaoQslCGTKUITuO30eV
 te9XM/4BMlEghTa3pER6g8oq8Pzx3+wCSvdQPy4kdeNQ2WuWotLVpCRYzVL8pkc=
X-Gm-Gg: ASbGncudNYu8O8QVRLhMn53dx4xLHJGF2TsW4lB7DXR780mfNfk3QyEJq3qQS7JlYbs
 5Hj9AN2ZW0eWyd6Bmq09y4K4tKs1afJ8cW/4G7RslB07Of8cr5i7+rppTQrwrrVke+CBgSXL6Xg
 pH1mqRWHs+xk/pxK1OovICrtIMcxudmB6Pbxx0epsVeWdLpDWxgKc2q1OIIIxND+JnFyzD3X7sa
 MHbuRempn02TlpjEwAvgerOkFo8Z65yBUvunfJp2BwmDSiKEH2UlRAOZO8upyOUeYX7yav0Rhp8
 xhl6t0rw5RuPVPBSErqcYEwaspL+
X-Google-Smtp-Source: AGHT+IEQBPtxiZ2WON+6JxjsDg7/Duj7zVbHU8+/JLW035qYuQefx/iUz/OAVNk2zYLLHYOLbrxPUQ==
X-Received: by 2002:a17:90a:e18d:b0:2ee:e518:c1d8 with SMTP id
 98e67ed59e1d1-2fe68d05c6cmr17102533a91.30.1740658192049; 
 Thu, 27 Feb 2025 04:09:52 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825b7b10sm3469309a91.11.2025.02.27.04.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:09:51 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: trini@konsulko.com
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, sumit.garg@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] MAINTAINERS: .mailmap: Update Sumit Garg's email address
Date: Thu, 27 Feb 2025 17:39:04 +0530
Message-ID: <20250227120904.1811565-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Update Sumit Garg's email address to @kernel.org.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index dc11775d4e7..50dd61dce76 100644
--- a/.mailmap
+++ b/.mailmap
@@ -123,6 +123,7 @@ Srinivas Neeli <srinivas.neeli@amd.com> <srinivas.neeli@xilinx.com>
 Stefan Roese <sr@denx.de> <stroese>
 Stefano Babic <sbabic@denx.de>
 Stefano Stabellini <stefano.stabellini@amd.com> <stefano.stabellini@xilinx.com>
+Sumit Garg <sumit.garg@kernel.org> <sumit.garg@linaro.org>
 Tom Rini <trini@konsulko.com> <trini@ti.com>
 Tomas Thoresen <tomas.thoresen@amd.com> <tomast@xilinx.com>
 TsiChung Liew <Tsi-Chung.Liew@freescale.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index c1851280e6e..5795b3ce471 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -639,7 +639,7 @@ F:	include/env/adi/
 ARM SNAPDRAGON
 M:	Caleb Connolly <caleb.connolly@linaro.org>
 M:	Neil Armstrong <neil.armstrong@linaro.org>
-R:	Sumit Garg <sumit.garg@linaro.org>
+R:	Sumit Garg <sumit.garg@kernel.org>
 L:	u-boot-qcom@groups.io
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
@@ -1043,9 +1043,10 @@ F:	common/cyclic.c
 F:	include/cyclic.h
 
 DEVICETREE REBASING SUBTREE
-M:	Sumit Garg <sumit.garg@linaro.org>
+M:	Sumit Garg <sumit.garg@kernel.org>
 S:	Maintained
 F:	dts/upstream/
+N:	OF_UPSTREAM
 
 DFU
 M:	Lukasz Majewski <lukma@denx.de>
@@ -1451,7 +1452,7 @@ S:	Maintained
 F:	tools/patman/
 
 PCIe DWC IMX
-M:	Sumit Garg <sumit.garg@linaro.org>
+M:	Sumit Garg <sumit.garg@kernel.org>
 S:	Maintained
 F:	drivers/pci/pcie_dw_imx.c
 F:	drivers/phy/phy-imx8m-pcie.c
-- 
2.43.0

