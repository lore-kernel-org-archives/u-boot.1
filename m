Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152B8E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 154468022B;
	Thu, 12 Dec 2024 11:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CKDf7Mes";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E37D8021F; Thu, 12 Dec 2024 11:13:44 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F4C2801DA
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9f60bf4so610765a12.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998422; x=1734603222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5hCW6RD1vCq1vpwv4SItXpSueT1cNfLosmcglDpglM=;
 b=CKDf7MesMiQ9MhkUkIdGJAaGKEaIePaVg0PTbOxHZbcFlhk3C8jBD1DVyZ+1+WWVwp
 TQ8ZZtzV1eam0I86Q+qdSkjuBl2GfZ1wFF0GEZ5WXs4l3cfGX6AjSh1jUNeZbaQHbmm6
 What1heCpOuO2/AdjzmvLqNc5Cz/8jLMBgE+6VPk+K9a+aawVkCRwwtowIA6Bw0NNiii
 CvgX0YdD38Ox8clIS6fE8wXAlE5ALUI80qhzlj9y/qPX5EQbSRFc9V7+C9fsnmZaWExP
 NsgDpO3jUflGzaoasJFzuzbQl1Kdt6XQ9ywIwQpe2h0Pjhry9xlxllQQxny5tK6p41hB
 FGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998422; x=1734603222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5hCW6RD1vCq1vpwv4SItXpSueT1cNfLosmcglDpglM=;
 b=qQ2oSFpybu48BhXZ/w27UXbZiwuYNdn2MJtOlaUyN/Bpyh7fHEbop3YmMYV99r1TpG
 qON6jpXwIjINyx/TZhKY1nAnO5mK3ZJPWcaIU0slgK22NeRhUoZLjWu6PSIDz3yR1cMu
 3ae8dESqqMK0FkjQ/h3A205DUzuMtYsNPnFQ9Vd0quOZ+X4WSAAN3qBMoPpgxjpSq0Ac
 kS9St37YYPSbrYepZbgSlOxEntO4JdD4cCyynOTLk5/TJEvI3q+UWSyKPt0vRiY+wedo
 R8h0fDggfNX8dLmAtDmAMoOAekhdN5MmfDZE34XJpL9rXQjZN7e1pbOIfgh+mqAACMZn
 aNWA==
X-Gm-Message-State: AOJu0Yxx2fuZL25qQ0itDuTNG0TQByPYFd+blPfGnjoWRhkD24pmTwPy
 7qrWm8PFJe9M31sXvBQqR3ql4MvMAAXgSPAW1HSWUy3jkr8GvtU1wPbY2w==
X-Gm-Gg: ASbGncs/nXyxdQ6Vyu6Xiih0ezVpuV947SHCh4fuGMjPegacJoooewui6ffeNte9xvd
 2jApKOtLksG/XEyVbzq6zK2kStlcUmO45mHP5EnJtC30wItT+9A2CvfbxVpfzM8axjUGXqetZj0
 4AZYTd67hKX9ugcOB6ioGLPzvIvJo2AYvFxbhemCDVuW79UC9tPvJNuhk0Y25QHGOKc8sjutHDN
 fdgatKk7J+u215wXF8TZD56iPpbZcaIuzHL/By2Pj0WqXWP
X-Google-Smtp-Source: AGHT+IEa/GvixyscG6ClWklAd0sqLvAQ1m2Oz33hASkMr6/4IRUzrJ5fW5iTeMsnzaMxqNqBL5f5HQ==
X-Received: by 2002:a05:6402:2344:b0:5cf:420a:9 with SMTP id
 4fb4d7f45d1cf-5d54762816fmr288931a12.5.1733998421969; 
 Thu, 12 Dec 2024 02:13:41 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d149a25cdcsm10192647a12.9.2024.12.12.02.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:13:41 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/5] ARM: tegra30: dts: complete DSI nodes
Date: Thu, 12 Dec 2024 12:13:29 +0200
Message-ID: <20241212101331.6135-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212101331.6135-1-clamor95@gmail.com>
References: <20241212101331.6135-1-clamor95@gmail.com>
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

Sync DSI nodes with Linux tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30.dtsi | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/tegra30.dtsi b/arch/arm/dts/tegra30.dtsi
index 1177e2ab1f4..d5de1ecaf05 100644
--- a/arch/arm/dts/tegra30.dtsi
+++ b/arch/arm/dts/tegra30.dtsi
@@ -218,10 +218,29 @@
 		dsi@54300000 {
 			compatible = "nvidia,tegra30-dsi";
 			reg = <0x54300000 0x00040000>;
-			clocks = <&tegra_car TEGRA30_CLK_DSIA>;
+			clocks = <&tegra_car TEGRA30_CLK_DSIA>,
+				 <&tegra_car TEGRA30_CLK_PLL_D_OUT0>;
+			clock-names = "dsi", "parent";
 			resets = <&tegra_car 48>;
 			reset-names = "dsi";
 			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		dsi@54400000 {
+			compatible = "nvidia,tegra30-dsi";
+			reg = <0x54400000 0x00040000>;
+			clocks = <&tegra_car TEGRA30_CLK_DSIB>,
+				 <&tegra_car TEGRA30_CLK_PLL_D_OUT0>;
+			clock-names = "dsi", "parent";
+			resets = <&tegra_car 84>;
+			reset-names = "dsi";
+			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 	};
 
-- 
2.43.0

