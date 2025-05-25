Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE3EC54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD16582C75;
	Sun, 25 May 2025 12:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="etUPE5Jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 004FD82CB6; Sun, 25 May 2025 12:48:28 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1015B82AA7
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so10031655e9.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170105; x=1748774905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTMtdsBKadP/AM+bAmAOJUSyXZpMnOX6N3F5bYodVoU=;
 b=etUPE5Jle5oIyxLdlBj9iSVvEwuDhF+N6f4ctWQPrw7Zr8B3pzCs2+EVRH5q5J2nHI
 VePyXxFlk5t+EPHQ6O6MtJzwCEZYk0etn9Iyi/eKhkLqMakPJE0/zxuRh9XII3tQ9d45
 WJQZVo+z4TbREjLUwaHk9WKfdUEPPodHLyuK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170105; x=1748774905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTMtdsBKadP/AM+bAmAOJUSyXZpMnOX6N3F5bYodVoU=;
 b=Y3wPkoXJblyyOUqaF4X9dHKB7OePy7MNBsJKjV9l3qW0z3KXaMnOj2/xi398ex5bOe
 fhZuldUXZlJ3rM+6k9kmBptis3YNfd9SorNj5UI3Gkt64Pw+tvyW5aM/0LpEY+mZgrKh
 qwqfhgNClsEyoKoYCpukmLf24HedAW9RR+9djHlJ0HAA+YooiG1uMeOS/jPEC7pBymdg
 kbB6oEO2likrkjohi4HWTHmlv0yrCLLPQ3k+TpTvIfOWx7Q/jIjMqA1OoXVs3JvNofBR
 Tw1TbqTeSfSANiGDwHLO0CTGG4EL5Rjb9ftrW/kV9/8whLcycL+A1jKfY5cGGsVC4tNk
 hAgg==
X-Gm-Message-State: AOJu0YxVoAUUZRLQmAXqsbDOlNsQwm2baO1gj21EB2sDtdsZQv7YPWIb
 Gb65MOBM6OszlPD5bKb38/C3jDVN19sCdG+V1xX23Qly0G2ju9/yVJyiEN5OuHXtVQ6aIk9HkKP
 jEW+O3eM4
X-Gm-Gg: ASbGnctP8bWePrSfHV4TKIiYQcNzwFgpoNNeGZAzwy4oEmCmY5gRsuryo0QT0J4GD59
 0kfl13CrLLfIw9fNtIuaP5XLxk8d2aDjM7PGdd5ZvwTdoQbIFDZI4aq3qJ/9zz5nGnpgyGX1BmL
 9irFo9q7ELFAHLzbu9xCge5Kbq6XsMkxd/LPj3EO0XOeSQHz89s9v0z9O1jpuzTPW5pGl/STvMq
 L0M3tk/33I/kcGCFaVIElC11GaAtTHfjnANrrYZt6eLXL+uepC87HZSmw6Zsk4zUt+JTa+/l+g/
 iw+YKydnEA7ak2p4IUG+H/qxMPZKKrmcWfHJHKdDxRiV0d8ncm97PhghZ/OHYPU3ToMnbkjnNKJ
 bUwONSg==
X-Google-Smtp-Source: AGHT+IEHGGNKiwpwVMxiLNWXdJ4hhlaqYowPvbl/3T4+brAKUUsMzps/siaECxIIlIGuQaaZBeqaLQ==
X-Received: by 2002:a05:600c:3c84:b0:442:f4d4:53a with SMTP id
 5b1f17b1804b1-44c9151293fmr55730855e9.2.1748170104948; 
 Sun, 25 May 2025 03:48:24 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 11/25] rockchip: Add TPL alternatives
Date: Sun, 25 May 2025 11:47:47 +0100
Message-Id: <20250525104801.1440260-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

The TPL image must be built for each board we need to support. It is the
only part of the image which is board-specific.

This helps to save space and reduce the size of TPL, so that it can fit
within the internal 192K IRAM of the RK3399 SoC.

As with other phases, the TPL devicetree is run through fdtgrep to
remove unwanted nodes and properties and reduce its size.

Update the fdtmap so it is at the end of the image, since templates are
added after existing nodes.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Put the fdtmap at the end of the image
- Update the comment at the end of the '#ifndef CONFIG_VPL' block

Changes in v2:
- Mention RK3399 with respect to the memory limit
- Move VPL things into a separate file

 arch/arm/dts/rockchip-u-boot.dtsi     |  3 ++-
 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 18669f73402..905706c68e7 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -171,6 +171,7 @@
 		filename = "u-boot-rockchip.bin";
 		pad-byte = <0xff>;
 
+#ifndef CONFIG_VPL
 		mkimage {
 			filename = "idbloader.img";
 			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
@@ -196,10 +197,10 @@
 #endif
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
-#endif
 
 		fdtmap {
 		};
+#endif /* !VPL */
 	};
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index 0d767113408..c5d55b87164 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -111,6 +111,22 @@
 	};
 
 	simple-bin {
+		alternates-fdt {
+			fdt-list-dir = "dts/upstream/src/arm64/rockchip";
+			filename-pattern = "alt-NAME.bin";
+			fdt-phase = "tpl";
+
+			mkimage {
+				filename = "idbloader.img";
+				args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+				multiple-data-files;
+
+				u-boot-tpl {
+					symbols-base = <0>;
+				};
+			};
+		};
+
 		vpl {
 			type = "fit";
 			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
@@ -199,5 +215,7 @@
 			insert-template = <&fit_template>;
 		};
 # endif /* VBE method */
+		fdtmap {
+		};
 	};
 };
-- 
2.34.1

