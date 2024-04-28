Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610E0C4345F
	for <u-boot@archiver.kernel.org>; Sun, 28 Apr 2024 14:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8091C8840F;
	Sun, 28 Apr 2024 16:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F7MfgaD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 548528825A; Sun, 28 Apr 2024 16:24:29 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 313DF880F4
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 16:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heesub@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ece8991654so3458458b3a.3
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714314265; x=1714919065; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLPcSsYOGC7yeRIQB9qfjJusu+l3TpKrOdRhNn83rlw=;
 b=F7MfgaD12F2KJ29Hpe3qxTIxBpYw2nkBg0G7vq9FiL6tvkc/AKx9mLA+PMTKQGM1Uk
 ArHS3ihWBloujNvRsMYwspEEgSYAAV4h3cy1vnR5APjPMcKRIIV/0FiY1ZLfI0fno/YN
 p0yHHP/G0PsS70Pjuo5FTJvcYv+zevZWfoI2oRWA5uQdIwaYMsx/LG02ONtgM5v15M9h
 0EDX1N0qOLewWTN5vMck0lQ/zjwaEdEW/bW57fxw2njy7tR2izhJbMLW3cG7cSa96fB+
 pQpGaKcHFiL4WZ9YR4Z3O13I2Ye3mIuE/1MD1/wq1F2ZfXFgoW0EP4OtDbjrk6Y/oMS+
 75Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714314265; x=1714919065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLPcSsYOGC7yeRIQB9qfjJusu+l3TpKrOdRhNn83rlw=;
 b=OXv2LPxCsn+D16A0tZdJ/xBQEC6z2v8P9pN4DamBRkuBhgEL/qMHSBnFjLyaKBQJ80
 mD1rj2gRnA05heSlB0z9ll1yFmv3a3RV4BLij9PywGLOK2+oDVoKjblmcXIGxc/FAXhr
 zM9v/HJRa/h+OXaCnp7Kukaa1zQelVOK+FW3Yg/2nZ0FuoB3HL8kVRFHRuw26hhJJnY8
 CXqykS38ic2qSaEtsbahJzLvVL+0kDYjLBhj8vT5Vffsionqgvk+0LcOzWyEAz9S1WK1
 VuTvn3XZ7tLeEX3Hbl+7XppcLw5ejSb3FPi20sth2Ucqc9UTJfG1wgumHu/z4QdoaTBK
 Y5sA==
X-Gm-Message-State: AOJu0YwKUGMod/OQmCR60ntsAueB9Kwq7JzFnqp/NmuK/05++TGTw1Km
 qFf6y7TruKW1ovX/RRym0eUPoA8mICB+gp97LuqM/vThOBP8MF5puw3mHg==
X-Google-Smtp-Source: AGHT+IEWltyz6DDTlR9d5GUzznHVAy6O3560ofwBxnhNWZy2b85GVE+iME4kgnu3modt+FBvfttNMA==
X-Received: by 2002:a05:6a21:789b:b0:1a9:b4ed:a with SMTP id
 bf27-20020a056a21789b00b001a9b4ed000amr11369499pzc.20.1714314265465; 
 Sun, 28 Apr 2024 07:24:25 -0700 (PDT)
Received: from heesub-ubuntu.localdomain ([58.229.217.38])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a635343000000b005f077dce0f6sm17568744pgl.31.2024.04.28.07.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Apr 2024 07:24:25 -0700 (PDT)
From: Heesub Shin <heesub@gmail.com>
To: u-boot@lists.denx.de
Cc: Heesub Shin <heesub@gmail.com>
Subject: [PATCH 5/5] dts: stm32mp157c-odyssey: add phy-reset-gpios property to
 ethernet node
Date: Sun, 28 Apr 2024 23:24:06 +0900
Message-Id: <20240428142406.28445-5-heesub@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428142406.28445-1-heesub@gmail.com>
References: <20240428142406.28445-1-heesub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Apr 2024 16:40:40 +0200
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

In Odyssey board, we should reset the PHY chipset, toggling G0 pin.

Signed-off-by: Heesub Shin <heesub@gmail.com>
---
 arch/arm/dts/stm32mp157c-odyssey.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/stm32mp157c-odyssey.dts b/arch/arm/dts/stm32mp157c-odyssey.dts
index b6210cf8b2..4cc5e07683 100644
--- a/arch/arm/dts/stm32mp157c-odyssey.dts
+++ b/arch/arm/dts/stm32mp157c-odyssey.dts
@@ -75,6 +75,7 @@
 	phy-mode = "rgmii-id";
 	max-speed = <1000>;
 	phy-handle = <&phy0>;
+	phy-reset-gpios = <&gpiog 0 GPIO_ACTIVE_LOW>;
 	st,ext-phyclk;
 
 	mdio0 {
-- 
2.34.1

