Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30533C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D796D80AE5;
	Sun,  9 Feb 2025 22:16:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BcJW2XdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E113F80A0A; Sun,  9 Feb 2025 22:16:03 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A634B803B5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d04932a36cso35027195ab.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135760; x=1739740560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwmK0xdhlLBK/kDAP1Pet4es9YTMIEMC/W3WioeDbXo=;
 b=BcJW2XdJv8n6w3SrLHQ8jAcyZG47xFoa4suwcfkMzL+DB8JrRXsavoksNP03IyjK2T
 dOrl7i0fqnc6mB4NkPTgf2S6iADpo42x0f6GFABa5gi5BSJlTpshvclhe92nmqh69z/m
 gTGtQ7lZQxB3blF2c2jwO7zzKO7/jy5nSmQ+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135760; x=1739740560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwmK0xdhlLBK/kDAP1Pet4es9YTMIEMC/W3WioeDbXo=;
 b=GQ7pFm9hzQCkPBK5KwgJ51aEdcgjvQO6iRcx/CNGOMiRcy3SO9qth/v6bIUbo3xYAd
 SdvAyjorQXivPbfyDDCiXGcPwR/pv85lVPG3kKM31wyYSgQfjwowGN6pjAZVMU8hHnHT
 CG8sdGzAU8KRF0KDJ5U5vVulnlO72n6NijLsbcQoIDQT7TixGTdOiRwxkZ6hL5kMpZu+
 NS8efpQlkWwaVRhv/HagE0+DE1mmVMBXH2k7HkvH68TVWwb7cR/tmR7uv1ckQalRO8y1
 BHNDwYq4rv5ZK4saIpGx/bCsXBbMriV350f/u5OtI+c121BxCV+A2hMOYheWXOYvQAQ6
 +SQg==
X-Gm-Message-State: AOJu0Yz7k7s3EX2yVm2DTgT7ZuyXsNZI5m56JwunqZTHwV8N3hUtXpww
 awJnngmyVCGtQ/TJ0YN8Gl+6LY4X5tRQk2c2SkoD7aQTVMpUzG99HZtSQeeEU4RUw3wgzZ0GUDA
 =
X-Gm-Gg: ASbGncsYTtZoPZQ7roxN+MSATm+N39va/0OIXWGvY9o5IYT2VPC9hkgu2FddNapJwVZ
 mZeuTQMwwBpuJJJ6fpG7ydndZfcyo+KS4tSt6hv4prmEzrZnt530MXo8MWFP5GpIaVdexZZyRxz
 y8T/VWCjaf3ADlxg7UXfdpzOaezLACyPr2eRx044eGoFqvmTU6B5ggtV5w0xJdXcvcHqhsuu/Pv
 0BUTBHemLPRdtTo4uhC4/717ZwiVGHScXCMbp8Hk+bsrhYuVgFrV5Ayx0K7A9fom2xkVQuCLGM6
 y55wvbuxfBRV2kCZIqCVwZ0MQ1NulFBFNEIERfgYW2P5Qo6ls0//
X-Google-Smtp-Source: AGHT+IGlBmMqF/nUA4k955xkuzWKZjQ8JRrEILgSG2Zwzc1hZVIH1Hodm7h50+KWTe6WVEByXZNeYA==
X-Received: by 2002:a05:6e02:156d:b0:3cf:cd87:1bf9 with SMTP id
 e9e14a558f8ab-3d13df557d2mr83267275ab.22.1739135759865; 
 Sun, 09 Feb 2025 13:15:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 15/35] rockchip: dts: Specify the phase in the image
Date: Sun,  9 Feb 2025 14:14:36 -0700
Message-ID: <20250209211502.2299245-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

Add 'u-boot' as the phase for the images intended for use with U-Boot
proper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/rockchip-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 79f4188b76b..c899e8e6005 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -52,6 +52,7 @@
 				compression = COMP;
 				load = <CONFIG_TEXT_BASE>;
 				entry = <CONFIG_TEXT_BASE>;
+				phase = "u-boot";
 				u-boot-nodtb {
 					compress = COMP;
 				};
@@ -70,6 +71,7 @@
 				arch = ARCH;
 				os = "arm-trusted-firmware";
 				compression = "none";
+				phase = "u-boot";
 				fit,load;
 				fit,entry;
 				fit,data;
@@ -89,6 +91,7 @@
 				arch = ARCH;
 				os = "tee";
 				compression = "none";
+				phase = "u-boot";
 				fit,load;
 				fit,entry;
 				fit,data;
@@ -111,6 +114,7 @@
 				compression = "none";
 				load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
 				entry = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
+				phase = "u-boot";
 
 				tee-os {
 				};
-- 
2.43.0

