Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B885C36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D89CB81FBC;
	Fri, 28 Mar 2025 16:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K6urJiM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E73D81FAA; Fri, 28 Mar 2025 16:36:14 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC4581F0B
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d45875d440so9563905ab.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176170; x=1743780970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AW8ngkcfEN04aYFcTy+svHf+QSMa1gudY7AKya+I170=;
 b=K6urJiM4wtKg/l2kolzz0n7p8+13xj7m2JYFYCevZDBGjT5hz3Ck9/BMDp8yT9pbB0
 luSKzaSuoxQBbsapZsA7pVMlSxenA7qnl6YtFLb3Tek48uly70t/tuYRs8w0/nL6l2pO
 l+PHnGs82U/SfyAPYIKWejSi8gsbmaIJbjVKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176170; x=1743780970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AW8ngkcfEN04aYFcTy+svHf+QSMa1gudY7AKya+I170=;
 b=I81h3qWhwY0ZtW/IDPcRH5mf4Ang2FC3oVdzvDsz9/kwKDnKmL3Tfq/JdPrPl1xuIR
 idkmytiY3I1rr+931Tz19tT7wZjKo0LG9FtCSaoaEnNGVWkBZHvoGsWHOKNpq8iV8QpA
 LssJbttq5YVhcFpJncCOX9yfd6gta6XSxl7Iv760bIi1khM/igjE2BCmQUUpha5YPLmx
 MaVoju8s7trKhPh76KZpY2jArfpYqhp5/Gq7wqDyXRaWbbFg+mBRTjyEOla0HpwNFWTH
 r5x5nSSKMVr2hT5zHVXvYFTEcZUNfdjWLQWEgjTiHXMBFeaBdMQ/TWark89OIBaJxEzj
 gXLA==
X-Gm-Message-State: AOJu0YywBj0HCbEC00JF+r3f7e4MxnUid9Q6T4J3JwW9bXywpT17kx6v
 oJCxh2xOx9y29pZPhdKwbOpfi7A9NytGb9aUEMGyGyzB3kK7Ytwe4EGpjt96NnTnIeU9ZApB00Q
 =
X-Gm-Gg: ASbGnctjaF73/gt9UzXb7e9/6nNvVxrdgt2MSmOg6xdQlp5g6+l5c4UXuKUX0OFbF5A
 2kKAGfwtEpxSiF4AW5mnMODyfltWG65SfHZjRgQrwZ2n2q/Xchx8e9WHo2XPCZKMIpkawKhyR1q
 6sW5n7HMIIFmknPzrTHGAJzB2REeT7CeuoiV/maoZIz1lGi8nd3CIDVOFL30g7BziWw5E9ublhM
 rIdApKxsbFzNFX8MnBuxOce/rqUG9YPxDmN3Wyi7BKzQEMuF3R8NzFBYvKsm3Wxc+PTl/cd1y7S
 23mAWvkXoW3RxXGZZNniujITF84iBPBo/ghOZOiUQ2yDdVffKXwslTEkzgVpivt9bh4Lvgh6i2x
 u1jQWRQ==
X-Google-Smtp-Source: AGHT+IHpWn1YMNOC9MCSj2f9He8BRZi7VyuHn6CupaBCBehsT/S1YekV9gRJtJwzttYul/ewruK8QQ==
X-Received: by 2002:a05:6e02:198d:b0:3d3:faad:7c6f with SMTP id
 e9e14a558f8ab-3d5ccdc1fadmr80633465ab.5.1743176170263; 
 Fri, 28 Mar 2025 08:36:10 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 15/31] rockchip: Add a template for SPL
Date: Fri, 28 Mar 2025 09:34:55 -0600
Message-ID: <20250328153522.3555472-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

Changes in v3:
- Move template to the vpl file

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 43 +++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index b3759b88db5..d15c593bf7f 100644
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
 };
-- 
2.43.0

