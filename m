Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DC0C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1896982D08;
	Sun, 25 May 2025 12:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="USEPJBDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4935A82E28; Sun, 25 May 2025 12:48:25 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2747682AA7
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so16375455e9.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170102; x=1748774902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+uLuw695MFvoe1UsaUZSHA9UsqpUK4CaBRhCZ/r+0U=;
 b=USEPJBDPi7FuI2JvFOfdTZk812ObsUgE3TK6V6jr+JxIVh60HcxdCx/obvkqJN7Cb3
 8t/WqZGhMpHsogCwDrswkuak0I1N3vuHB4unb8wvQED+a3c07p0V4ptMw6+ln1t/t+LQ
 F4lYUcg/HS2SyuC78FcvdE7jFwhMkt3DlpO8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170102; x=1748774902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+uLuw695MFvoe1UsaUZSHA9UsqpUK4CaBRhCZ/r+0U=;
 b=bKU1/iJHkqUYCT/sRLT6JjScBnbNmkmj2V8TWnovPPOwsf5yvHJhNMNMGBW71MiknK
 HPy7UFGZcljyu9i0XANt95lMLTfbEPY8ewfewmJnCJu5BT4AKuoK31p4iE/tmveActpl
 MgUXLMz8/NFhxP4t5kbsi3azO4HpinMvpzcWe/eZy7NCEMosHRTNiRioT/59I7qcHtQy
 rZU0fecJCfiA2IFoZRUk6EUDcly29tfoqonEpKqrM0gBafF8duflYW3h/SnalxNNL2ME
 BSqNwAsJGa+4kJK5yo8YbSGAk1qUZsGT47QJFH1nqz0B7PNckvnKAy/oPPxKzGUtYAQZ
 F4lQ==
X-Gm-Message-State: AOJu0YwpS7qAuHq1OKtzCwm2//SeZ56VrTcO3fE4JgUl8o9mqavGcIzA
 YvWfMKgpxPmKoT7ciXniW4Immce5Jt/1mHvcA7WuNWB2949N8HyG6V/eoGZG5vEN4frKxgE7ljG
 zcBC7DHp+
X-Gm-Gg: ASbGncsFm26pJi1sXx9DQOYCRiI8pvZns7qxpaHhY9QhT/PThkDND4Bphys5gukZJWF
 LiChUbjM2T9J8zrDCGTBwvVYRy3Am//S/R8V4r5KJLWYQhLTqqhMUWnN19vYeixoM5RU7klXzz/
 yX92dTa+UjWYGvN6cXOlO2uq3Bl5AUyIkbTZunoPmgZDU1Q1vvX1VrMr1tF7w/lpauuz0DD1pdF
 87az5+5vXQ+F07ov7AO11Yi86W2a2AkPXC/8qirwNxJ194WpiH/r1EYoa9jnhQeITGv1Ww05oHA
 apNjL1q+7CpTkufxm8SwR+RI4fsc/4373CdrC5CgJDvVew0Qr2VAUpbdEKit3bT0VChVLf8=
X-Google-Smtp-Source: AGHT+IHYUuLuiYGOJBJYwNJPTHhhiPJs0zdmhm8V8yatG5793XvVMG8uK0WzNJha+Iqow4bBpy44CA==
X-Received: by 2002:a05:600c:46c3:b0:43d:745a:5a50 with SMTP id
 5b1f17b1804b1-44c9229d7d8mr38409775e9.19.1748170101972; 
 Sun, 25 May 2025 03:48:21 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 09/25] rockchip: Add a template for SPL
Date: Sun, 25 May 2025 11:47:45 +0100
Message-Id: <20250525104801.1440260-10-sjg@chromium.org>
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

The SPL phase has a single SPL binary plus a devicetree for each board
we need to support.

The devicetree is run through fdtgrep to remove unwanted nodes and
properties and reduce its size.

While it would be nicer to just have a single FIT holding both the SPL
and U-Boot images, there may not be enough SRAM to support that. So we
end up providing this special image just for SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Use FIT_ARCH instead of ARCH

Changes in v3:
- Move template to the vpl file

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 43 +++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index dc1664d7b2d..9604972543b 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -66,4 +66,47 @@
 			};
 		};
 	};
+
+	spl_template: template-2 {
+		type = "fit";
+		description = "FIT image for U-Boot SPL";
+		#address-cells = <1>;
+		fit,fdt-list = "of-list";
+		fit,align = <512>;
+		fit,external-offset = <0>;
+		images {
+			spl {
+				description = "U-Boot SPL";
+				type = "firmware";
+				os = "u-boot";
+				arch = FIT_ARCH;
+				compression = "lz4";
+				load = <CONFIG_SPL_TEXT_BASE>;
+				entry = <CONFIG_SPL_TEXT_BASE>;
+				section {
+					compress = "lz4";
+					u-boot-spl-nodtb {
+					};
+					u-boot-spl-bss-pad {
+					};
+				};
+			};
+			@fdt-SEQ {
+				description = "fdt-NAME";
+				compression = "none";
+				type = "flat_dt";
+				fit,fdt-phase = "spl";
+			};
+		};
+		configurations {
+			default = "@config-DEFAULT-SEQ";
+			@config-SEQ {
+				description = "NAME.dtb";
+				fdt = "fdt-SEQ";
+				fit,firmware = "spl";
+				fit,loadables;
+				fit,compatible;
+			};
+		};
+	};
 };
-- 
2.34.1

