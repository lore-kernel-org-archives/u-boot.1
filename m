Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD08C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C22CC82E6A;
	Mon, 26 May 2025 12:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fJ2rrLcv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2898E82E27; Mon, 26 May 2025 12:16:20 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08D1582B0E
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-86a52889f45so44321139f.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254576; x=1748859376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SK2R0QOmRQQRlXGtA1ePpBAMVcC75WrmGw3iYFBs5o=;
 b=fJ2rrLcvk8WlryvHQeGyLcYrzXWGv50awAdCquiYEnNTKlyNVgdFpRGNiZ0Ip5ISmW
 zqfjiypfHNKOzYSOvhmYwqi2huAnjbwjEajTVq3AbvDJQUymH7o1YnSwSqREwJT+wu6m
 zxQwNyKXh+Y0KauYK6lUdC4WCoTL3W/KasFKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254576; x=1748859376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SK2R0QOmRQQRlXGtA1ePpBAMVcC75WrmGw3iYFBs5o=;
 b=Cdmlc0Ov6akUM134NaAl77welwyp/SPYjO2LkeUyw65lIu1QympL5/f2fJo3uTC3CD
 dWoQJ+OQc3W4VxwyOxk4TjxEkIEnLxs+kCZgGZ8J1s8rb2shKhYefHhnYh1WmhKxUW2W
 TG6GlYTH20CEETVg32Iqz+L7gWv6l3NzOZ2canJn9EUXla9hG0P0muUE+q7oNnQsvf2v
 i644q3ztytd3fcpL6vAEj/KJPiBDZg2DKQa15xHbLmWRiOrTv9jLD7TgszUGSJ5DLZi1
 5PvCjYGJRsnyFFwCDCFQcHxmN2dNZWhvbcmuUUArLJW4DicCEGzYfXo/QAGk3iZsfetq
 zNTA==
X-Gm-Message-State: AOJu0YzD57Cv3NmBe6oVBAwmDKetTrJ4aryDiTYsQlgdqoNjwnve+X5I
 bBC1GDS9Q/4p8lMCkOQiVyAX5kMcKPgAa+DmyIAkVlUnI73m0xxGzXmAp/xRlqZAJV2Ks32upMd
 onY7yMQC9
X-Gm-Gg: ASbGncvklN4xswNR0ohz/Z0i8v3vsoWyFTZvegOD/qoPtMRguDOpOQklid6WI45kWK1
 MLfpsx3Pvpr9mq1nE+Xl8hjw4fqIA2v78XlznIr2c0GDd/U58I1/0ZOOsMska3AWyLhp2qscRyX
 H6Gdoj9emaXoLNsY0QT7xZspHxb6yDSRPGaFkGdgHLTYZ+7YoeEagGMh+VEt8DKKR/yWSaUTXNT
 Csyxz1XAGlgz9lyMOSz8vVsPdvBOS7E2xNlwzFs0JG0A3+v0dtU71MO1I8vRGKjcXkuYhNYGUmQ
 BTV3M5TscLKwHaHtlWwx4ySMCvzQ/Fce0OhG/w6M8ZCMC64e8mRRUpZU/u+vYRIqXLbfMCiAO8e
 oHvLFZQMtNszo
X-Google-Smtp-Source: AGHT+IHsJbLH5dgPIl4bNFOPRE7ZikH5vAFw+KRL9gNthrGxtI615Hqb2jt4rXkhU9tMZQldy9AmKg==
X-Received: by 2002:a5d:9124:0:b0:86c:bbdd:d873 with SMTP id
 ca18e2360f4ac-86cbbddd8a7mr657118139f.0.1748254576220; 
 Mon, 26 May 2025 03:16:16 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 08/25] rockchip: Add SPL into the main FIT
Date: Mon, 26 May 2025 04:14:54 -0600
Message-ID: <20250526101541.3254628-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

VBE may want to load the SPL image from the same FIT as contains U-Boot,
if there is enough memory, so add it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Use FIT_ARCH instead of ARCH

Changes in v2:
- Move VPL things into a separate file

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index 475dbc53796..dc1664d7b2d 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -38,3 +38,32 @@
 		};
 	};
 };
+
+&binman {
+	template-1 {
+		images {
+			spl {
+				description = "U-Boot SPL";
+				type = "firmware";
+				os = "u-boot";
+				arch = FIT_ARCH;
+				compression = "lz4";
+				load = <CONFIG_SPL_TEXT_BASE>;
+				entry = <CONFIG_SPL_TEXT_BASE>;
+				phase = "spl";
+				section {
+					compress = "lz4";
+					u-boot-spl-nodtb {
+					};
+					u-boot-spl-bss-pad {
+					};
+				};
+			};
+		};
+		configurations {
+			@config-SEQ {
+				fit,firmware = "atf-1", "u-boot", "spl";
+			};
+		};
+	};
+};
-- 
2.43.0

