Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9390BC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB7C380BAE;
	Sun,  9 Feb 2025 22:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hc2L1n05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F349180836; Sun,  9 Feb 2025 22:16:38 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD04480836
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3ce873818a3so37594375ab.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135794; x=1739740594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmSxKOHlRMcnTtY1R/VUdHG6Qkw+nbjndHwZP+FBuHQ=;
 b=hc2L1n05OvVQC5CQd4+mcNXA4J8UcZRLF3Xa6yT8IkHBozrP/WiQArWTmMaHZP++9J
 1uDLuc9DhZtKcAM8RVIhgZBfD+yN8zymGOfcppvxQy0NZE7raLWbqEvNIRq1YJoPppSU
 LeiIR6czRlfNm/RkqsDGQyGnudYu6NVh3yPi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135794; x=1739740594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XmSxKOHlRMcnTtY1R/VUdHG6Qkw+nbjndHwZP+FBuHQ=;
 b=Bjci/vR76ozedXVx9KdToYW3FlEDiu8HGuuQ38PkApv7ivY3k8RhWKb2dc4+CvfPlk
 M66VgYwZR80NQuL5zD4WgXxyR9aLsZAEZpQC1YHccXZJo/9vFXphsOdEO7T3qpVaUNVB
 8AgokUGbt2gvQm/EIEDeEVVDwUlgS3FeJfM3CfPtNASU3Urq3TMiUNxQkF3B6okJQ/v8
 3bO4JD6KZ63eZM2S1hKYkX+/YXi7gzcdXdNzgbtMUSM2n8t9vtIdyopx/RTra0Cg8lks
 9mwrspjL66dN9RBarUew0KIYUOgMAij6ezBfC9zfjSxYUw/5hQhJU7PjhG0OuvSGtvwM
 kmvA==
X-Gm-Message-State: AOJu0Yznm/34SvHTLGRhI54KpnvYJOM8MQ+pXMfOM082uTscjSkjoEGN
 T9jHjqOVC5nGJkZuJLKRV0rVt/+GGCAqA/Ce0lnw6q0WySUgMP2Y2IManD/rdMpSH0hMa1JmrtA
 =
X-Gm-Gg: ASbGncv1Vi3CKxpoRGafdXL6NjKa5v3ie3hENvwo6wnI7FYrp+SqVP+Y35Ygtllyxcz
 4AqA9oKRX+tPhJ2drjHD3nJOgXb/A6XCp++pend/+jzGUEEAzWDbjy3SruxWiO2a6iwhyqWmwDS
 3EcV4UfGAnedP9wBqakk3QqmNla9jp0qXRMDhSj5rNfUo3xCimnuagUdX5Ik93JUhZRZdtDsew4
 TE+jT66I3gJ2oEPXnThCLs9lhLjtwoxP2BHN51fZVwTHxNvvgJ+BT0xUqNsppY+9Djz5ZaCEJS8
 tNr+mNFsbEat2WPmp3pr7OcUfS3Nx722UUybcwo7zuh5meeeem+z
X-Google-Smtp-Source: AGHT+IEOfqb8EkIjVm8oQzivs7U72yx454J6Pm6K0O6JVR2CSTBA6xLai0K0KsdjeaSWVIbLEnfJhw==
X-Received: by 2002:a05:6e02:12c5:b0:3ce:7d8f:3d73 with SMTP id
 e9e14a558f8ab-3d13dd0ade0mr87114565ab.1.1739135794632; 
 Sun, 09 Feb 2025 13:16:34 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Chris Morgan <macromorgan@hotmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sebastian Kropatsch <seb-dev@mail.de>, Tianling Shen <cnsztl@gmail.com>,
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v2 28/35] rockchip: Add documentation for VBE
Date: Sun,  9 Feb 2025 14:14:49 -0700
Message-ID: <20250209211502.2299245-29-sjg@chromium.org>
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

Now that VBE is running at a basic level on rk3399, add mention of it in
the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/board/rockchip/rockchip.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 1407080f1f4..73d7c7de923 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -490,6 +490,19 @@ config-flash.ini:
         [OUTPUT]
         PATH=RK30xxLoader_uboot.bin
 
+Verified Boot for Embedded (VBE)
+--------------------------------
+
+VBE is supported on rk3399 at present, with SDRAM being set up in SPL. The full
+A/B/recovery flow is supported in U-Boot.
+
+To build this, use the rk3399-generic board, setting CONFIG_OF_LIST to the list
+of boards you want to support. All boards must use the same SDRAM type.
+
+VBE uses internal SRAM (IRAM) for the TPL, VPL and early SPL phases. The stack
+stop is near the top of this (0xff8eff00) with the 256-byte bloblist immediately
+following.
+
 TODO
 ----
 
-- 
2.43.0

