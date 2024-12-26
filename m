Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41C5E77188
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 09:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72C3803AB;
	Thu, 26 Dec 2024 10:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DZelurSx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827BC80378; Thu, 26 Dec 2024 10:21:05 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A02A803AC
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 10:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so7540448a91.3
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 01:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735204861; x=1735809661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nCR0pjanfUPzTZBJDaIXDUx9P4znlSsPGum/A20OAE=;
 b=DZelurSxpgXip6727cYOK38ajNSGxvA9VxNz1J32ckwivOLd8VAFm+E8GvwWpMENk2
 D78hEts+EFBz3lHkCg/HDhGWWhUfSeXXivrsAArfjz0JMm78aOTPiO7tQaOuhh6+6QpL
 9A3w2PjCRMhehyDWEdjW/9NBG+WBKAVZb4IJ+OHsBdOYC55jJOSE3mja9uvNsHB/VRdJ
 g/EwfZCBabE2ltD+7HtzFM3HuOvDfarPeQJKm7AEeJsicJB1qOzGKPrN/1wroM//s6ao
 f2Az9CfNlwOgc5KF+xrJnba+GqALJA/mjODUnSLTJHM1cgTZiS4CCxPHaazB1Bro2bL9
 eKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735204861; x=1735809661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nCR0pjanfUPzTZBJDaIXDUx9P4znlSsPGum/A20OAE=;
 b=iAKuyV/BAh9PXyKZrgQLbO3f3h5ApvOXEP10ypYYg+XkzJJ2VoBwNeCrZ/r4t3LFH0
 oOTL4O5fy1RgNn8MiAXE1/oI55XjQUxMKFlVwZKWP2Kmixo4OG8NTyHutcEUsyQ7lzNf
 ou9s4Z3ba0yrk826Xw9CNDTUrdB22PZtMLoV4Jsg0X+NJWP8SPWCLykwWwvDN0tDTa/I
 rJJiS+TjrvY60QhK/jPx5AjHvhXz4vsJZgZw00vaYBvDM8KJ4zgIfkc1G4ULG0n9qF4e
 y4h+zVtXEM28dV5QDvBZqT5Q6mLHwQyGkXH4TfAW3CclKPit+0PIlzuKWxKU9s/M9RLC
 An3Q==
X-Gm-Message-State: AOJu0YzKd6I2qSdwJkyStquhWO9scRAQGVbZxfuEla9jIBUiEx45cbZl
 i6tgPvy/j5ICNOJaKnMUJ+tWXNPyAb9kbifSslfoTRlzls4FdRuT
X-Gm-Gg: ASbGnctXBYsYpazVdABca5JAROyToVdq/yC3O6s3qPl7flMm9dc4MYwVEknySt0gyHZ
 nTNcWUkCyHmX681kMooQBNYyB/3TgfJHGI2Oaaz9jcgQQbey7wkhBENfFbxo7y2cPGpjl6I1IDS
 IEDn9mgafEPHxPmUevsBKOOFkHefYj5M6zTt8oWqpEu/SxGekomDz5u5dCXqF9o0Tqu6RerXiGR
 ahTwpRPqZskG+pqs209Vg0fzsTKzf9ti8JQciseslM8Rq9vNpG/wroItoQ=
X-Google-Smtp-Source: AGHT+IHiH/LliyqDiP4mbsXDawv0jOlBksTP+oVhUbqsv8YtNJChB2A2Frd9UfzF6rWnQmxdzPWjaw==
X-Received: by 2002:a17:90a:d647:b0:2ee:c9dd:b7ea with SMTP id
 98e67ed59e1d1-2f452eb12famr33927391a91.24.1735204860721; 
 Thu, 26 Dec 2024 01:21:00 -0800 (PST)
Received: from CNSZTL-DEB.lan ([2408:8362:245d:5fa2:bc4b:53ff:fead:2725])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d948fsm116347985ad.150.2024.12.26.01.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2024 01:21:00 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/7] arm64: dts: rockchip: fix model name for FriendlyElec
 NanoPi R3S
Date: Thu, 26 Dec 2024 17:20:38 +0800
Message-ID: <20241226092043.419511-3-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241226092043.419511-1-cnsztl@gmail.com>
References: <20241226092043.419511-1-cnsztl@gmail.com>
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

Use the marketing name for model name, this matches the dt-binding.
Also update the website url in copyright.

Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Link: https://lore.kernel.org/r/20241022193537.1117919-2-cnsztl@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: b5bf84206a5c77528f9dd4cbca4e72caa063c102 ]

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
index a7a55d68db..6bc17f755b 100644
--- a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
@@ -3,7 +3,7 @@
  * Copyright (c) 2020 Rockchip Electronics Co., Ltd.
  *
  * Copyright (c) 2024 FriendlyElec Computer Tech. Co., Ltd.
- * (http://www.friendlyarm.com)
+ * (http://www.friendlyelec.com)
  *
  * Copyright (c) 2024 Tianling Shen <cnsztl@gmail.com>
  */
@@ -17,7 +17,7 @@
 #include "rk3566.dtsi"
 
 / {
-	model = "FriendlyARM NanoPi R3S";
+	model = "FriendlyElec NanoPi R3S";
 	compatible = "friendlyarm,nanopi-r3s", "rockchip,rk3566";
 
 	aliases {
-- 
2.47.0

