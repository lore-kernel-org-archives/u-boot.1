Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447A5C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31236807D9;
	Wed,  5 Feb 2025 02:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="maTi6kNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49480807F1; Wed,  5 Feb 2025 02:56:51 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD79805E7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:56:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5fa3714d4bbso2790534eaf.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720606; x=1739325406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cerJYCKXR7gwrxUBQ66P6BkGVs8cNXVOWi0c9a0mzik=;
 b=maTi6kNG0XRHMjDfPnm39jHBjD/PdAHXpbXV5taztZzC+qHBHq/ZmY/U9zoxOajEuo
 KEb1K3rQJi1uDVoeUpCutNCF/FJuBQvqrAWh2E66g29A/8Gx2gAoo16lMA2fHN4bi0KD
 7RcbHFKlmPlsmOJWmGPOtfbyxnLz0EMwLqsMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720606; x=1739325406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cerJYCKXR7gwrxUBQ66P6BkGVs8cNXVOWi0c9a0mzik=;
 b=qODmwdaTxSlhgrP2OPYCHRctSJ2yUIO1qzcSDWkf75n0RMBib3XKi7P6Polww60rD5
 p8E7IsDDp3ZGlpM0MOTpPoKliYaL+wV1KDa1ARBB54WpueD5Tfxa/M9SVgpebxHxVRna
 7xXOzD5EL31dmoccW6vtBu+xFr/cqoC1uw99HAgjmV90UTjoNgAbNRZsB+m9SylGyfoh
 V61LZr/YnH1///X3TTBv+0G4eEC4SvBNTPSbeRpFLbcK3Xt9rZ/7aHye+VbEJmfu6XIC
 TobzLJBLhM+8TBkHW5kChexM0OAE2tDMIxDgrX8DEh31QpvjPHbJfXh43sIYwKRggoE4
 1Skg==
X-Gm-Message-State: AOJu0Yz1QmO7lyjMv+nQCumQs/rOifJcaODpvxbzA07UedBQFsJ03IY3
 mVqy2eiI8ZC/omXKpalgHM7INqUhdAcCxrPtpWDZWk1Cli0LnbF9H0ZwAEDncDoRh++YwskbOfY
 =
X-Gm-Gg: ASbGncsksjP/+pJ90F6I1gY/qD3RlQOCMF0jMCMdaPmYNfxmNZOMQFdKqv2tHzjA9Yk
 bpZXm3ijLAp0PNTV8g19b94ujeMIYMmivLyMHqsWmDpVlhfIA41Oz19n74YcTQZYWJWLqzJmgdn
 pOrM5A08+Su0azRbXgayylVKxpVhzs6hxWlzKAw97AVC6rnvrrXciZI1JF8tEnYJtsOP4n6ZrhR
 uKr5q6OCQjwbjDJbONru6EiQ0DwSxIWHMaEYkMKTgJ5pnJMGwefH9rhr1ljojZamuPRWVxe7oOs
 e0ERTLrRohCMnOqXsXehuK1j/pYkbm7tU8tdbBGVDI18hvayPdOt
X-Google-Smtp-Source: AGHT+IF7VunHdaEye4Dy1knMeq5Y2NQTDHU/jmnHIHzyZosiFiMfVtZ72v/CYL60CZwwpGm3K3tPTA==
X-Received: by 2002:a05:6820:2208:b0:5fa:9407:a416 with SMTP id
 006d021491bc7-5fc4799f449mr777073eaf.4.1738720606542; 
 Tue, 04 Feb 2025 17:56:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 09/29] rockchip: dts: Create a template for the FIT
Date: Tue,  4 Feb 2025 18:54:59 -0700
Message-ID: <20250205015606.2686149-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

 arch/arm/dts/rockchip-u-boot.dtsi | 57 ++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index da0ac078cb6..8418635ed84 100644
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

