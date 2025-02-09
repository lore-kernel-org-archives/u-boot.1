Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5823BC0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6B0180EF7;
	Sun,  9 Feb 2025 22:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W9nAV+E/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1092680EF7; Sun,  9 Feb 2025 22:16:52 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D8F80F68
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d149f4c64aso5890485ab.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135806; x=1739740606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uRVQRDRCd25/L8GRZjIwK93tjscCcT6k4wJSYvltSs=;
 b=W9nAV+E/DBn4TDjfrhMPFq94z7m6tIHrhUfkxWk5OMa0ykEoy3ycskyOCaKpLJmmcO
 cvQrwjscEh01uh1Sea0kx5uml3eelOWYk62yiBdvwv4apQ29DAuyR9AVESuVtWVKLfkQ
 /JGmt1cHU4e5KR8+KLtWoq+0NZ/EWtwiyY/ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135806; x=1739740606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1uRVQRDRCd25/L8GRZjIwK93tjscCcT6k4wJSYvltSs=;
 b=UH669zthw+4T5d9IOnPccN/4IYwGrjw3fe+QFW91WwVDju3TMFowC6R54Bk0szwr/c
 h5nyvoVNlfk3DttNPVCsYQuNt4MK2OVbec3Fwe0QbWUYyxyNcFOb4bX/UqnvT/ihwhJ2
 29MLO66FHOHre/YTJjzneYNJt05E5lRng2u5q++6R5QKsY/B1sHH3tXSiJMpJo2SoH7a
 vifxmqrTNpuGWvMU0i31zKbVaMOeojmiPSGaKh9Kbxy0q7ySQWavSZE5I2CPmQnyigrZ
 wAiVtMswjlh8jdopXEH2urHlDOj5NQCXFC0rC3Se1hVodYyNz9VaiBO6xwYnZHw/6aZo
 a4dA==
X-Gm-Message-State: AOJu0YxOFcZh9EkfEutRs4uYRpjnsOlQXPCGenpkHKxA1idOV5felAEY
 mcHuo+lKalTh0UY8Kzh0tGCVp8WcOyCuAt9vAgczfwQ4KCNC7l2LZqSu8P5CGjwlWE/YYcBZJsk
 =
X-Gm-Gg: ASbGnctcCwEYysNeoORcZCRQtISSUtblaLRUEVibbXDGPGjBO1n6iIFKjT950u8Xelc
 GVRKOubvQz8xyW5VpwkZxrAf+RaxMmcrBuTVdDSALpxJ6w0Ii3vXNfxcvfAVIRrQa2yBi/H6ayE
 JcMiBQVH3jAWwWnUBqBVPkfG7RFisYQWrN+OqlZlzn5icZtGo8r8NVw5kwjVZut6dPfY8q5EXa5
 dY+1JIlMHFK/TduYybWeo0Gj5ZhB6ibG5ezug6VA87LfxK6No46ZccB0IjCxpAv1pqLTn8nZ5bJ
 lLBlebxbLekgQ0KcEvjFl2wwWG6HnRek81cmOVoENG4u9gGeVmSI
X-Google-Smtp-Source: AGHT+IG55kC5ORU0kKAUjpwYiPVVmJqPN4VMpBmw0v+sWgUvo2nKSs6jN+W4K3MqfQ2djO+zgHjMyg==
X-Received: by 2002:a05:6e02:214b:b0:3cf:b3ab:584d with SMTP id
 e9e14a558f8ab-3d13de9fc27mr80920115ab.13.1739135806338; 
 Sun, 09 Feb 2025 13:16:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 32/35] rockchip: Update binman image for new skip-at-start
 setup
Date: Sun,  9 Feb 2025 14:14:53 -0700
Message-ID: <20250209211502.2299245-33-sjg@chromium.org>
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

Now that the skip-at-start feature is properly used in Binman, drop the
various workarounds in the image.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split out the fixes for skip-at-start into a new patch

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index 621161f6c86..71d7a98e5ac 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -19,7 +19,6 @@
 			bootph-verify;
 			compatible = "fwupd,vbe-abrec";
 			storage = "mmc0";
-			skip-offset = <0x8000>;
 			area-start = <CONFIG_SPL_PAD_TO>;
 			area-size = <0x800000>;
 			state-offset = <(CONFIG_SPL_PAD_TO - 0x400)>;
@@ -77,7 +76,7 @@
 
 		vpl {
 			type = "fit";
-			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200)>;
 			description = "FIT image for U-Boot TPL";
 			#address-cells = <1>;
 			fit,fdt-list = "of-list";
@@ -122,7 +121,7 @@
 # ifdef CONFIG_BOOTMETH_VBE_ABREC
 		vbe-a {
 			type = "section";
-			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			offset = <CONFIG_SPL_PAD_TO>;
 			spl-a {
 				insert-template = <&spl_template>;
 				size = <0x100000>;
@@ -159,7 +158,7 @@
 # else /* CONFIG_BOOTMETH_VBE_SIMPLE */
 		vbe {
 			type = "fit";
-			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			offset = <CONFIG_SPL_PAD_TO>;
 			insert-template = <&common_part>;
 		};
 # endif /* VBE method */
-- 
2.43.0

