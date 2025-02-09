Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B2AC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3423480ECB;
	Sun,  9 Feb 2025 22:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XjHxfj1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A84480EB1; Sun,  9 Feb 2025 22:16:13 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 641FB80C96
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85522610e26so7044939f.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135769; x=1739740569; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EHgwegIl/RhlZrP+fxQxW6qKjbWsBAy/nTYoFmwPpE=;
 b=XjHxfj1nYmSCK72NY5p6c8JG7HSFNPiSJ3dN4p7vf4idHMjXxtlh+qo/QlS8uCiUg8
 oWcLsrDxNE8gNpMVDJJwcovva/mA/2iJwcIs9UOOidcxhPeiOMBoTmaXNCYDq0J5szvn
 6Sxz1866JmR67/VvSezkWDkG484hM5peKhRbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135769; x=1739740569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EHgwegIl/RhlZrP+fxQxW6qKjbWsBAy/nTYoFmwPpE=;
 b=NxDLJm0JfYwl+Zaye4/GgcKxFl/Zhibu5sdgxwFsnBXuG0YQy6cJJXbQffj2r0lFK9
 xfV6gIMexWKCg2AcFiCjFUEi04bZ3xRFQCFgbYa8+pAwXM2kQE+GiyIpTWiU9NEA6Orw
 N2Qw51WY/VRdAv10Khpo7FCxU3/M/m6UVTKwPm44Wzc+W/H+72faxwX4EgBm9ntcFC23
 wkDkS4u7Den8TTaOoFdX6sPvee7pR9iMDTHGjBF81HMBUBgN6uG7TToekfJNAhmzv/Pc
 Y6IkILXnomF/3784fEzeLyQzfuGUxnvLoi20AIOPRjL8WwfvK0EWhKLyoQYFem7x7r+W
 Uhqw==
X-Gm-Message-State: AOJu0Yyh7PdHg6zPHYFTlHgK9qhsNIZ9VM417XalzRC+A/k+XkkZV0XR
 j2ORu3JfNW+bm0f126IBi4bWpGhElyspz8bnOts0lSzxFI0nuIpEG6aBPrn1NJjtQczodyMXXpM
 =
X-Gm-Gg: ASbGncsXS+X+ELu376XX2Kwyk0Op/qJLS+JtzxooX3DqmMporBqmp5KHdjWnjD3G52B
 1PCd8G6mU4BHVqQ5l+rng+mvj54IWKW1N2T2j7QGwQbWloTvRwmTcjv+2nX6ML9cr4mBchk+gcf
 KvoBOhj+p0Pql6jDGh+cJzmilXqvznhl/3L7za7rv4mHMdBqkv7qZwp/Eu6KyErMDj0QrMV45MJ
 fJTJjP6WHGoWhKmfcc8Jre63smnJL+j3tEiacxpQwZZboN/vQE4WbXV4+EP6zVnAVMj00MQriH/
 LZWQXP4ynq9fPuI8MvPFBOo5af0cFyy65KEyjkhnFqqOesmy/zxm
X-Google-Smtp-Source: AGHT+IGm/FgZD2eRHc5oXV5i9+9qy+2j3ORuXjqqL4QIx7QsIQXNtkIzSjiTQYiijymsK169SloSHQ==
X-Received: by 2002:a05:6e02:b43:b0:3d0:23ac:b29f with SMTP id
 e9e14a558f8ab-3d13dcee786mr94579425ab.1.1739135769570; 
 Sun, 09 Feb 2025 13:16:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 19/35] rockchip: Add a template for SPL
Date: Sun,  9 Feb 2025 14:14:40 -0700
Message-ID: <20250209211502.2299245-20-sjg@chromium.org>
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

The SPL phase has a single SPL binary plus a devicetree for each board
we need to support.

The devicetree is run through fdtgrep to remove unwanted nodes and
properties and reduce its size.

While it would be nicer to just have a single FIT holding both the SPL
and U-Boot images, there may not be enough SRAM to support that. So we
end up providing this special image just for SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/rockchip-u-boot.dtsi | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index c2a795957fb..9525cb9c21a 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -153,6 +153,49 @@
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
+				arch = ARCH;
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
 #endif /* HAS_FIT */
 
 	simple-bin {
-- 
2.43.0

