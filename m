Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AB3C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDFAD80C5A;
	Sun,  9 Feb 2025 22:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g1r/proD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AFFD80BAF; Sun,  9 Feb 2025 22:15:55 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 283E680A0A
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3cf8e017abcso12347415ab.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135751; x=1739740551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqiL6PQTnvWayoVEuR7OtA7+H99WVrtjLxgocewNkpg=;
 b=g1r/proDDJ1voA5xCyEYDR78UcCItpGd5Jz90y/ZMGEMbKbsOw/aXTabjeDb9gZs09
 nT9hi6S0IlYlx7XjwVIgBoWA5zpCY+wTy99T8MR8H262cIWT/pJ/7gpKMDsgFrya5UY4
 kFB/XEhb6nomtLN/hUgps9N4UvqCZ1CLPkvU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135751; x=1739740551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QqiL6PQTnvWayoVEuR7OtA7+H99WVrtjLxgocewNkpg=;
 b=RjcIIHrSGENTX2rX4yJ/1xzb1IGviYqNoDSOFdESk+bGxBqNPitLvEBbtYAW4dgLWW
 84ePUj9YIH1r4UeLrEmlzLlLaiDUopL2w/F4uX9AIeffmipk3jDTE5PPwn3E4krrbePB
 LETnyHk+aENNYRqUpjXIgje1ty2Pcpm/QT27Qxe2/zM/npTkvAQdNO8aDQCkMmb8B21W
 K/DgfRRp5BPCPDmFAaRYe9QXThvuiKhPaUuXI16ctY1yPaDpwd7PezDBe0WPDfoRoBG+
 +2uc8YrNWR6UtUuTs6JvBayul0pWnkd6DuJ7JV7jzGAtWhUCJcB723IMZBkxPuGZO7c4
 WKwA==
X-Gm-Message-State: AOJu0Yxq7elIp1+BLsqvs9CAMLAQXZv7/lX7IGHVm+2CAkWo8hmqQQUS
 kuoXC1ukl0GHxCCbUhrmigwMnros7gOmreBqkTxCeW4zdxMYgHszUQ5ELz4isKFV/6l2KAss9f4
 =
X-Gm-Gg: ASbGncu+jYqgBSPy9xxr8vtlbcamlHW1KhJcJ3YUvo4lpjyUFBVZxextD+wTjCruWO6
 AhbWrwVlc+W0RNuPmAE5sutqZwEHE6gJV8UggMHTh+X5Scy9i0b4gzWM9B15CG/w3UKc5TNqe47
 Ts+sXzNbPi0bjHL0TUunmDpDgBDXKjgD5Uu823OTPGuHIOq2mrwN7asgXOfPu96+kjGEqHdOqBr
 mjaPclz65Yhwfxat1OB98hywazVyM3VnFR/HYjWhnXVFY09ZYYgNdN6s48Em3iovcXtdOAj+aQ1
 bd/T1eFPuN9YE37QbyYdA+wqcFlI0z0wAMXEdv6DfXAfx/0RPZbL
X-Google-Smtp-Source: AGHT+IH7pkUDelp+yRzR+pWiXdmSG59NCZYZDRr3JOoNPzZtcVov6R3yH6fHRAdmZsE3eZL7eT38VQ==
X-Received: by 2002:a05:6e02:3421:b0:3d0:4ba1:adf1 with SMTP id
 e9e14a558f8ab-3d13df5718fmr111848415ab.22.1739135751412; 
 Sun, 09 Feb 2025 13:15:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 12/35] rockchip: dts: Create a template for the FIT
Date: Sun,  9 Feb 2025 14:14:33 -0700
Message-ID: <20250209211502.2299245-13-sjg@chromium.org>
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

Move the FIT description into a template so that it can (later) be used
in multiple places in the image.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/rockchip-u-boot.dtsi | 57 ++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 64a6b57d5fd..ca666ba0cd4 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -19,6 +19,10 @@
 #define COMP	"none"
 #endif
 
+#if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
+#define HAS_FIT
+#endif
+
 / {
 	binman: binman {
 		multiple-images;
@@ -27,28 +31,9 @@
 
 #ifdef CONFIG_SPL
 &binman {
-	simple-bin {
-		filename = "u-boot-rockchip.bin";
-		pad-byte = <0xff>;
-
-		mkimage {
-			filename = "idbloader.img";
-			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
-			multiple-data-files;
-
-#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
-			rockchip-tpl {
-			};
-#elif defined(CONFIG_TPL)
-			u-boot-tpl {
-			};
-#endif
-			u-boot-spl {
-			};
-		};
-
-#if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
-		fit: fit {
+#ifdef HAS_FIT
+	common_part: template-1 {
+			type = "fit";
 #ifdef CONFIG_ARM64
 			description = "FIT image for U-Boot with bl31 (TF-A)";
 #else
@@ -59,7 +44,6 @@
 			filename = "u-boot.itb";
 			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
 			fit,align = <512>;
-			offset = <CONFIG_SPL_PAD_TO>;
 			images {
 				u-boot {
 					description = "U-Boot";
@@ -164,6 +148,33 @@
 					fit,loadables;
 				};
 			};
+	};
+#endif /* HAS_FIT */
+
+	simple-bin {
+		filename = "u-boot-rockchip.bin";
+		pad-byte = <0xff>;
+
+		mkimage {
+			filename = "idbloader.img";
+			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
+			multiple-data-files;
+
+#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
+			rockchip-tpl {
+			};
+#elif defined(CONFIG_TPL)
+			u-boot-tpl {
+			};
+#endif
+			u-boot-spl {
+			};
+		};
+
+#ifdef HAS_FIT
+		fit {
+			offset = <CONFIG_SPL_PAD_TO>;
+			insert-template = <&common_part>;
 		};
 #else
 		u-boot-img {
-- 
2.43.0

