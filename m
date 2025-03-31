Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB896C36011
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 19:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A6F381F4E;
	Mon, 31 Mar 2025 21:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="FOhQ+o1A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F1B81ECD; Mon, 31 Mar 2025 21:16:35 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5794981DE3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 21:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso31480385e9.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743448593; x=1744053393;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=553YqliBuGHFd78WBLbhKmA3ISuG6bQ7MXSC3++r4bI=;
 b=FOhQ+o1AJVkeu1y2td3r5g9YBW1t3V53CpvtYdvniUWlywgTTKL25+1Su/tKCuOGY/
 4PwqRotmV9IWXV9Xe3DNRj71vA0DfcAPWYbYuKXsr1YQwgVTnyA/Cf3enrIMHEDCwDrL
 rfzCQaXLdNtXoA+3Hd+tpj/GSe0VVOz3f0oir1YrbCOEJugM+Tnzf5LA6V49gUC63KRx
 liDpSRA4AhlWMDgc/n5QP1go54S/rFISBdb6AkZZ3KQvbagm+IkaLOZKUREAf37f3NTb
 POYIgXDPWu1jtrbHLxrplTpoDH3JNwEvKcxmCXIAnH2eBxX3oF8jMuA3w193Ie3BKyS+
 A/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743448593; x=1744053393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=553YqliBuGHFd78WBLbhKmA3ISuG6bQ7MXSC3++r4bI=;
 b=Bx69aYAkX5vfDLZinQ3SywSyQnj7az1Xv8Doy2USP3WM4O45K/O03sNNbxM9XYvxLC
 C2rW2gv2N6lgtzrrZQC8tLFMkrFUrBufeONI1lxe6sVh9DwXpT7IXmez93y31YdOZF/9
 ffLWZDKgeiKQ2TnhcjgfhW/dJe0DZkT+rS8Ue6IZjM5/cW+pBDqSGqdtVfvoVy/bOBaZ
 B9Tm5zCB425xj8iNa5ngjfjsHANO0hDYyaglol0Vd6S1+aIT6kbOgESrYnGBmH+EJoDN
 UiEQ8Sy1yQrX4M52UjAlRW9+kD4Br/Qz0ztwrr5wT7kPHcXRTPYf5S5caBOvPh9Mo0pd
 Jo6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVtjJZnjcafLs0UhyXd35dqTdnmp7nZAEDzSwIw9MVtyev+aXpy+QSAfrARgEbXwVT3rnfnBk=@lists.denx.de
X-Gm-Message-State: AOJu0YwZH5hwktFyQHSqJvbUJWQQqfaUWudu98ZUM6zablV2uPMfYwiy
 NV6A+9J4MlSy9eWSmmqBia0/jSwWAuEKp8gsRUUvVr5vJRwlWP8VcIf+QtDdvzs=
X-Gm-Gg: ASbGncsJSF9NbKIDGTTsiuS+ozeOTWCD0W3KjKYC9P0ZD1ZI41ARdbgNwtsXiBmBoxD
 6ussb94WtlIEcFtD1i+WGhPkifL4oBiuoBiot7vdqTK/guWFqyrP/rN1BXh35HcEGrpr0TxwTHR
 SduxNTggr9zPGSCvZl1TiTc/hIHGSBZnpW0+08KChVSBkGp4grSFooO78UFDlPbhIClo249pBzm
 Asgp/wzvq/sdBV9afPjhvwXtwBssX6EWcPHHohEKyGxsutz3n78gyQps9F5A75u1bxG8KenqIaV
 m+7bOUTAo1yJf0aE71yoM+P+3FIDKeSptcHuVzwVg4IfCUWcHUbiER4H
X-Google-Smtp-Source: AGHT+IGcvK9Q5doVBnLIHy3TbISZBEDAJdpDuBNfMvN4gVEhofIjlo3h4xk/OWDFSn9MMQYrVzQoYQ==
X-Received: by 2002:a05:600c:4f82:b0:43d:17f1:2640 with SMTP id
 5b1f17b1804b1-43db62b5ba8mr81646425e9.26.1743448592777; 
 Mon, 31 Mar 2025 12:16:32 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d82dede98sm173144165e9.6.2025.03.31.12.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 12:16:32 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>,
	Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH 4/7] arm: at91: wdt: Add SAM9X60 register definition
Date: Mon, 31 Mar 2025 21:15:13 +0200
Message-ID: <20250331191520.1805001-5-admin@hifiphile.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331191520.1805001-1-admin@hifiphile.com>
References: <20250331191520.1805001-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Mar 2025 21:19:48 +0200
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

SAM9X60 has different watchdog register definition.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/mach-at91/include/mach/at91_wdt.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
index a5accbae521..9ba5283123b 100644
--- a/arch/arm/mach-at91/include/mach/at91_wdt.h
+++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
@@ -33,14 +33,22 @@ struct at91_wdt_priv {
 
 /* Watchdog Mode Register*/
 #define AT91_WDT_MR			0X04
-#define AT91_WDT_MR_WDV(x)		(x & 0xfff)
+#define AT91_WDT_MR_WDV(x)		((x) & 0xfff)
+#define AT91_SAM9X60_MR_PERIODRST	0x00000010
 #define AT91_WDT_MR_WDFIEN		0x00001000
+#define AT91_SAM9X60_MR_WDDIS		0x00001000
 #define AT91_WDT_MR_WDRSTEN		0x00002000
 #define AT91_WDT_MR_WDRPROC		0x00004000
 #define AT91_WDT_MR_WDDIS		0x00008000
-#define AT91_WDT_MR_WDD(x)		((x & 0xfff) << 16)
+#define AT91_WDT_MR_WDD(x)		(((x) & 0xfff) << 16)
 #define AT91_WDT_MR_WDDBGHLT		0x10000000
+#define AT91_SAM9X60_MR_WDIDLEHLT	0x10000000
 #define AT91_WDT_MR_WDIDLEHLT		0x20000000
+#define AT91_SAM9X60_MR_WDDBGHLT	0x20000000
+
+/* Watchdog Window Level Register */
+#define AT91_SAM9X60_WLR		0x0c
+#define AT91_SAM9X60_WLR_COUNTER(x)	((x) & 0xfff)
 
 /* Hardware timeout in seconds */
 #define WDT_MAX_TIMEOUT		16
-- 
2.49.0

