Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00034D6E2DC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99AD7805D7;
	Thu, 18 Dec 2025 20:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MODZ8K5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BE618003E; Thu, 18 Dec 2025 20:42:51 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C7A78309A
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so848929b3a.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766086967; x=1766691767; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/OzeZRZE1Nm4m0gJMSIV5HwGFHIzGtqdTLz0UhRTYE=;
 b=MODZ8K5G8mfK/c+oR98xsGjuLnhcfXSp0ouRKajyHEHsy7jK8JsozgrIFpvfEdOXad
 V1ijXeNb5DTpv57L/EpVDI+vPFxFyQ/Ug71Lfbj9aKP1+WtJjsBdGGnp8V4LTvc/xNay
 YJxQWyrsehvWvVnJVKUou8wgjozJ1QtevGLxM0iDS4/vWP1cyBn3BhfoEGsbO94W3y5t
 aOQGXne4kNF5qY6VZBgCqqkN59R7Q/VUqDzzXxJL97BYTVo6LV8yx2HmM+mpTSxS5dJM
 dXuyw+6JYbDuL80pJOuivHBxV3GYi3ZAaMMfIou5cx92r9ao5gH5FUBlMFA5wOkZJCcB
 ea/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766086967; x=1766691767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x/OzeZRZE1Nm4m0gJMSIV5HwGFHIzGtqdTLz0UhRTYE=;
 b=TRaxsTvQfX/PRuzSZ7IBiksfbqIxDvOsY2kbVRQYDTo3d1xyysNP8IHzySdxpBqF/9
 NkyQTvUO/4CfwOFHpCcA8gVaK1Ai/9H4vx0JxcK0bKDFgnmqJFdmDIC5valc2Ffi5RRw
 nhdlHfvG8uZdqsKPrQit3L5nXh6ETxgtY8D9VFWjlZzN2yg5NOUE6lzz/Ma0tX9gbV1j
 TBhx3OCbiT6Vz+6tx2w8B5kVrufZsN/JBnGM2oJM0r2LIHyKbhpsbgPUe2Qm47Jeu0qx
 tmR1bVxs4K9z2vNkbsU+fX/3BnkaUBxKDlRXxDzntCVM1oRSyJDLabt0A7JZfiVY8mvQ
 K+jg==
X-Gm-Message-State: AOJu0Yy644CcpPo6ekTQc2s2NCg8k4Lv235tfnWTpnkI9fy9Shv8WTWe
 a6L8UDOQQv0WeGzbeFRSOt7dT/0wPQ/3ol1nkjj9WQ1YAD/iRL2We6Pk
X-Gm-Gg: AY/fxX5X0gjUIvDLxCdhomt0uMlHTojmI+Xu6CYpbuIchQHGOeUG5fJiiHfFqIwDppo
 Ovap4zQgMBRkq35+dDA7aRFvUQfNFh8cbrKuYn1Pz13iRR0dMlhvmi1Ykz/ycUCW4Fjj4Y1RK3D
 0seqJw7zVtj5+za98sYs6tKUT7XIsdoKFcc8oFf1XZpxYAjJDfqG8I+MV/D/XcxPvxFMgubMdlL
 2t9mRcgDi3yuSp4szvSmWXBIpOgBIw62dv+CbiNAC0AxnDmt8kLRlvm4hio8ukNl6C3JPZ0eton
 4WSV6cbOoIYdulA6pZaXMYawzKguPJb1jzzGGtuoR83qczt3eij9Msu1osGjoatQsz6W73slUyl
 1YSk7uyJkToQJTTRxf+FH4QjLSBsiekHSKliK40EkwWMxHfsginu4TO3mnmEotQuUOPCw4qxwyC
 72bscNzzHaEuGMmVgHmkD4BPaV
X-Google-Smtp-Source: AGHT+IFGQ26sD2bwVZI2TYrJ8MU6KqE6RTSrTUFh0STUX8q4j8pJrfNanEc9sTLkq44F4n57Pgx3og==
X-Received: by 2002:a05:6a20:3c8d:b0:35d:5d40:6d77 with SMTP id
 adf61e73a8af0-376a7cecaedmr487729637.31.1766086967568; 
 Thu, 18 Dec 2025 11:42:47 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:dc63:c226:257b:b4c4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7c146aabsm116413a12.25.2025.12.18.11.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:42:47 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: trini@konsulko.com,
	stefan.roese@mailbox.org
Cc: u-boot@lists.denx.de,
	Chris Packham <judge.packham@gmail.com>
Subject: [PATCH v2 2/3] arm: mvebu: db-xc3-24g4xg: Remove marvell,
 nand-keep-config
Date: Fri, 19 Dec 2025 08:42:17 +1300
Message-ID: <20251218194218.1972757-3-judge.packham@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218194218.1972757-1-judge.packham@gmail.com>
References: <20251218194218.1972757-1-judge.packham@gmail.com>
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

nand-keep-config is used to retain the NAND controller configuration
from an earlier boot stage. In U-Boot's case there isn't an earlier boot
stage so reconfiguring the NAND controller is required.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

Notes:
    Changes in v2:
    - None

 arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi b/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi
index dc20643bfa37..ad64813e7704 100644
--- a/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi
+++ b/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi
@@ -5,7 +5,6 @@
 	status = "okay";
 	label = "pxa3xx_nand-0";
 	nand-rb = <0>;
-	marvell,nand-keep-config;
 	nand-on-flash-bbt;
 	nand-ecc-strength = <4>;
 	nand-ecc-step-size = <512>;
-- 
2.52.0

