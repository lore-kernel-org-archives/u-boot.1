Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E21AC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D73B82BA7;
	Wed, 30 Jul 2025 07:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BQjtJT0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 143E482BCD; Tue, 29 Jul 2025 14:51:03 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 193AE82063
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 14:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ae9be1697easo170262266b.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 05:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753793460; x=1754398260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqKwYProZdkDOF8Q2eyR82xVddt8tUbcfKhEDjgGemU=;
 b=BQjtJT0T5ISiCFpqGoPoud2UmVG6deyU93hN9NdWNXZTMQSi7Ix1G7prdky/MnUyX3
 gTurAq+4MTWsrgASj8Xn8Dh59JeYOz5nQF4KpuJKLqxc3xLBvKPtNd2xb4nmjVoEzaKw
 4LDLGNwvFnRKDF2AObb/aWz4JJGiiww3Ddn3ZnrlEYr7WXugP2OvjxUumZL5YsXgx6v+
 zSwtawDvgksPlXjBkFmEn6HSj0poHboRltrUD8ygvtQMuXBXfikJHzxDPt4QPfJ6plND
 19vx1omIrGWyIVjZBI5FGUj27rMr/FwAUDmvbGRCTaVK2yYUI/W+SFMWmWgxtgJIZQNq
 a8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753793460; x=1754398260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqKwYProZdkDOF8Q2eyR82xVddt8tUbcfKhEDjgGemU=;
 b=vlBLW6AwxiQYbta2ga7U2U7f3LH5ucCAL95ZVpaXfSfCZoVpYFti49FKw8uP2B5Si4
 uNduzSeWXG8x5riGZFMiKFQtMqY0Dww+sC5W128h3d5XDtSrcphyl+/hvL6FTC16H+8M
 Kt/2KuQWg/Pc1dPdoTOEKJp3FPtQC/kak+vM9gzkt+mPrax3Ihp+kjQenvEIdtSismJj
 zrml4/t1X8BX9Nep1YmdZZptelGvf0hd1AUaayuUg2UrP2QoKa/hS27IMbdnlsnD7Sx+
 HP9Xco0eZrUu4My9BEH9UZaZLYA7xBcnHfIqDNTxMWAue1gDIjyv6V7Ds7CRktdckePo
 X/xw==
X-Gm-Message-State: AOJu0YysDlEgscUGpTcCTO4SgacIm8HPuSp+uQe97TCHgR+OXlG40kI+
 LWbdQ8odTVlUISxNiRK+OZaXxUqkaYMM6NlMOiAt44DyTwzKMg/regnca4vwiM9S
X-Gm-Gg: ASbGncvOe88WKeACsvR1KmYA2/6kk5aphDG1k68z7nYL6AAM73kL45ojBLWTR4mZMVy
 JWgv9cj9zS6U93BI6j1Z6/YcsC7V02hRiM+UiB9h48tLEsASWHN/pOZapyiBuydFG2pruneVBan
 vel+qMgTSKXhqE8pfWCC0M7KfYm0HW/ZaD5VRH8AK7yDNUqnzvyO2E9dDWRfQyrTLMaRj5vUazC
 M3KAwQiopWk96PADr4JPfv5kxoTvyqIBt7v0pkykrW8H9pS2jEHP1Lnr5uf1dmtiR0NrbCFFVxc
 vJLE+VbLwQYfIt5itKJLRTN9K7ZDdbYpLsV5SBuCLBLf9/7hcbt05yiwiu9pORMf0pxGDhVQyC+
 XC2OGUokntQzUeumk4QVtl18XLWPQHRmbODb325FlenBj5NeDSb14H2WsxJgt8nvR+WTkL2E=
X-Google-Smtp-Source: AGHT+IFQGeCEhiYvXjxZ04ZgiERh4QqCn+5gh1SkP9Wu6g3/HtMTRavfAupWW3w2NMPAYEZC1B/m6A==
X-Received: by 2002:a17:907:3c8e:b0:ae6:d51a:4ca3 with SMTP id
 a640c23a62f3a-af7bfd76504mr351883166b.25.1753793459949; 
 Tue, 29 Jul 2025 05:50:59 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635acc99esm572223366b.115.2025.07.29.05.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 05:50:59 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 1/5] binman: Fix FIT image overlap issues
Date: Tue, 29 Jul 2025 12:48:52 +0000
Message-ID: <20250729125022.4220-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729125022.4220-1-aristo.chen@canonical.com>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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
  - testFitSignNoSingatureNodes

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

