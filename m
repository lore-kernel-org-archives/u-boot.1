Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3332ACAC594
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 13:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 072E183559;
	Sun, 14 Sep 2025 15:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PFWo3YZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E3F80B9B; Sun, 14 Sep 2025 13:01:05 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A81F481E13
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 13:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-61da7b78978so2145456eaf.1
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757847662; x=1758452462; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXcIYuAeCyZs0p3wKB4BvxAtUUjz1Y4qsumcTyR6N44=;
 b=PFWo3YZTXTyvZtmvJhwmyqke6/FcFBXA25mNWByNGGj2gwPNltCqB5p0vlsJ1En7oe
 V7gyh4ko1Y38a60EY/6L924ISwXFereNhuZTpBbYkdl8UalcfS2rGF3ZS3YS4A6P3U55
 AH5nLFv0G5mfH5+ZbD4VtHPFzD1ADE2zZns/OJxIplALR87RZrFmysNgg5KDfPb796BX
 AFxbR1Th3xzfs9oIAJ0m5bkH0hALQtgMR0w4E5y2LfZa42Zr1M7If2UlFKMbOI3+VQPw
 /fj5ne3fAN+CXPCvaD6A0BBYSOCg6hQP0H2yuIlcgsDG2Nl2mAyo1l9abuhVsMFeEEbe
 j2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757847662; x=1758452462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXcIYuAeCyZs0p3wKB4BvxAtUUjz1Y4qsumcTyR6N44=;
 b=naMZVaLAdZ6Jc8ZkAFfehhz1mkyA0AEg+vWxLI86gik1BEOKr/r75w9RqRzFuJUBmr
 kTefJLFfKj6wynNB+UEr9+kimn46awZjupU6nFvrVkaK6SUJV4nxvvzB83O+Nzq5dKch
 63cdeJsw1BbJp0Dz4D7f3vbgVvEWjjHGCZcU7DxBUJzQxCOMesMr6GBDhYLtq0tQuqrr
 +e6MNuBsvgj4+TooDscqDiBemiLk3ZBMTVrUFv44uqiXMR38Ps60gYMbdmKp696HrfxC
 SmNpqP6lSbmePzH6fhVS8kAxcVXlgvHygwkeqTfLcK9pKIajPrTZGYa0khmORBSjGTrI
 G9wQ==
X-Gm-Message-State: AOJu0YxvGD54gdj4KFOw7/56DwFJADXBrGifNwOJkj1AxJGY5EnYYNOB
 fIGeA8PF00gvMKyf5Rd6yVBhdus5Aqd59swlN1seNrxlRLNKV7Cfoso2Gy2krS1d
X-Gm-Gg: ASbGncu+drTGsNtI0EH8/WkycNiVAlf2DHWHhjIvnxX5gvQ/IO7thKSW/4ozGE8idnL
 do5Or91K30tf5ToyxQJ4vekO57j9KFbu3HnxfQ9g/LV0MONlbnQPkRY2qkAlOmWfFcaJD+rG5cO
 M4f1lyeB5MRCRRNQ3X23J0EEgDzDcytPtViMgaoO/na++WFTgoMqtjS3is+amnXtY6B9Xa0W+l+
 UPp7yxdmbjICJWLJuH6+hCadyxY1GH305gm34EC18EQA0iDtIB5CfR5aHO9C/3rFhVVGOlG00Ry
 u+0kmWaTDxnUcY5+hUnao7Dsuz/zcnG6hRKeLSQrERzyAzCHBFC+P/3rZ/6o1Lf37/nEyMTXv97
 YSDH1exqRTc7grxlrONKYYkGhWdSdck5W+uFjEqb8puOwX6Fik7kwzsfJ8yz+ysf6wIzL7eM=
X-Google-Smtp-Source: AGHT+IFXASKVsyoRGz4SgAGNqNekDHKXEkn6kKINiJgdAKeKQR5jXgQZ1C298rgB66HevvH9CwjaHQ==
X-Received: by 2002:a05:6870:5587:b0:319:c063:1f1a with SMTP id
 586e51a60fabf-32e5477902cmr4477871fac.1.1757847661879; 
 Sun, 14 Sep 2025 04:01:01 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d32d56557sm2612720fac.1.2025.09.14.04.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Sep 2025 04:01:01 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 quentin.schulz@cherry.de, alice.guo@nxp.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 2/7] binman: Fix FIT image overlap issues
Date: Sun, 14 Sep 2025 10:59:27 +0000
Message-ID: <20250914110021.4103-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914110021.4103-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Sep 2025 15:13:36 +0200
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

Fix three binman tests that has memory region overlap issue, the test
cases needed to be updated to use non-overlapping memory layouts.

* Tests fixed:
  - testFitFirmwareLoadables
  - testFitSignSimple
  - testFitSignNoSignatureNodes

* Changes made:
  Updated DTB test files to change U-Boot load addresses from 0x0 to
  0x2000 to avoid overlapping with ATF in the 0x10-0xfc range:
  - 276_fit_firmware_loadables.dts
  - 340_fit_signature.dts
  - 342_fit_signature.dts

An upcoming commit will validate if the memory region is overlapped

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/binman/test/276_fit_firmware_loadables.dts | 4 ++--
 tools/binman/test/340_fit_signature.dts          | 4 ++--
 tools/binman/test/342_fit_signature.dts          | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/binman/test/276_fit_firmware_loadables.dts b/tools/binman/test/276_fit_firmware_loadables.dts
index 2f79cdc9bb8..d344036a11a 100644
--- a/tools/binman/test/276_fit_firmware_loadables.dts
+++ b/tools/binman/test/276_fit_firmware_loadables.dts
@@ -19,8 +19,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/340_fit_signature.dts b/tools/binman/test/340_fit_signature.dts
index 9dce62e52de..1c25d52cba4 100644
--- a/tools/binman/test/340_fit_signature.dts
+++ b/tools/binman/test/340_fit_signature.dts
@@ -20,8 +20,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
diff --git a/tools/binman/test/342_fit_signature.dts b/tools/binman/test/342_fit_signature.dts
index 267105d0f68..2ac600b1c70 100644
--- a/tools/binman/test/342_fit_signature.dts
+++ b/tools/binman/test/342_fit_signature.dts
@@ -20,8 +20,8 @@
 					arch = "arm64";
 					os = "u-boot";
 					compression = "none";
-					load = <0x00000000>;
-					entry = <0x00000000>;
+					load = <0x00002000>;
+					entry = <0x00002000>;
 
 					u-boot-nodtb {
 					};
-- 
2.43.0

