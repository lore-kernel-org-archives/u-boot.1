Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D34BC83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 11:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04760830CA;
	Mon,  7 Jul 2025 13:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="urxmstAg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E03A830E4; Mon,  7 Jul 2025 13:37:32 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 945B58305C
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 13:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6097b404f58so4429246a12.3
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751888250; x=1752493050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5t1XT2yto6/zZVNtc2w2MxFrDf/EzrTaYhX6jsG7xYU=;
 b=urxmstAgjY9ERGz3sj5Pny8ViPsbWbQJub+QlINVxPzoe6OgtB8JPQVsmIkhXevOOI
 T1cenn5qEY6V1dTQkrLc/DxOfsKcfBCLGC2msgLGPbrZ1LJUz2WUQ5TztouOPA2BmEH1
 MFRzp0mcLxTcA2lHpkGfz/ZT/NebwR7lWD5HnxqU/xvn9Za+1KQPu/KTwutMWhPdF2dk
 rOM/SK+7GlzxhIkLJe8vSVnCJalKF6ASldMOh+m9etYNDSziM6BFgG7Ol/reU1i34lwh
 QZRzfgz/a0OL6jd+tXmwY2r4oZyazlHt+NU4/mH0tz34hnxIHCO2slifASS191jK9wAi
 B4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751888250; x=1752493050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5t1XT2yto6/zZVNtc2w2MxFrDf/EzrTaYhX6jsG7xYU=;
 b=dHtCzF9ayZRCn9YWkkDGtG/aNDvKFbpLaCw8sv289M7A9F3ijc65+Ihtdv7n8jSYhi
 EvLUtZGJDmDWLvVrzuLAex0WTkmUy+oxFkfzrBGbS25vFkiOYQTcd1N1OWACKuapLbcs
 o5nilPvrpoBzhs4Ummi0ErVT+QUDttCBOFCeHddzSm+kU89U0PVJyfH8uWGP0MBcAwfz
 jdVduLTEgyKUAUfQd3Sn+QiH9MF3L56PUoCMliq+WqkfTnHGM5PMJCZZ+DGjK4DCvSY8
 MqzfItQJHzflrRUfPt9fwIixDp70V8SapYnpL3HoHCDikTNufGF06x/0GXzlc7FAMIP8
 pdrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMgquGzsFCJgPXtvNITYP2/bBKIRR2jb8H9SQ+Gp7fX5/U+756qX7GyACAGa6dEqkIkgAgAY8=@lists.denx.de
X-Gm-Message-State: AOJu0YwJ4gwr6lS3i6W0a0auS/P/uq+Q/MATodJBp81KineKO6bVxSUo
 KbwbgIQEhx9dfl8ROcLAYEfbg4QqDScpeohEHX0d+dl6t8TEMtOUQ1tCUSJYB8RfGJA=
X-Gm-Gg: ASbGncuA4TUxuAP6IFgwbhSn5MT6wsfyMAVK+zlxkhzc4JLQ4kiF5SSfOaYw46FCjpa
 WFCLpGZP6BEhDwL4g9RNGgxuGT/NRp0TaKwFqJo1vgs8ueTU4Z//umckzUOqRHIPNd5lHCi81y0
 xutII9KoCxOoMuWkWUqdR31N9j/7PXl4eYd+MHOU80wEkqvlwTlywMFQTV/Im9qHscPg0mo1LHq
 kSFuTjIeQrvAsAAQmw8Dzxm2jK2xVTANCiCxs8FD07kDIausEio0BhdZS5wT1azDmKkYvkmvE5I
 JWAALsyst1GYQtq7Tnd/BP3jEMf2IBZo0W3DVcZAHDriDOYhZnOuZQAm1V8jkE/J8pMLpG3d5yb
 9wA7aILBXUqaZhUOuyZuzv/9EVJdIkIvq
X-Google-Smtp-Source: AGHT+IEa8ACYDcqaXua/bqbfRk7LQHibc9dupoQwT9xA3bR1PTmJ1HFeVPvTLPPWYkt9Mb0s5W2kYw==
X-Received: by 2002:a05:6402:50ce:b0:606:ebd9:c58b with SMTP id
 4fb4d7f45d1cf-60ff3818095mr5997722a12.1.1751888249976; 
 Mon, 07 Jul 2025 04:37:29 -0700 (PDT)
Received: from hades.. (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fcb1f7618sm5405206a12.55.2025.07.07.04.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 04:37:29 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH] tools: gen_ethaddr_crc: Make functions static
Date: Mon,  7 Jul 2025 14:37:25 +0300
Message-ID: <20250707113726.118630-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

These functions are only used locally. Enabling -Wmissing-prototypes
triggers a warning. Mark them as static.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/gen_ethaddr_crc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/gen_ethaddr_crc.c b/tools/gen_ethaddr_crc.c
index e73d0429a04e..277172075809 100644
--- a/tools/gen_ethaddr_crc.c
+++ b/tools/gen_ethaddr_crc.c
@@ -16,12 +16,12 @@
 #define ARP_HLEN_ASCII (ARP_HLEN * 2) + (ARP_HLEN - 1) /* with separators */
 #define ARP_HLEN_LAZY (ARP_HLEN * 2) /* separatorless hardware address length */
 
-uint8_t nibble_to_hex(const char *nibble, bool lo)
+static uint8_t nibble_to_hex(const char *nibble, bool lo)
 {
 	return (strtol(nibble, NULL, 16) << (lo ? 0 : 4)) & (lo ? 0x0f : 0xf0);
 }
 
-int process_mac(const char *mac_address)
+static int process_mac(const char *mac_address)
 {
 	uint8_t ethaddr[ARP_HLEN + 1] = { 0x00 };
 	uint_fast8_t i = 0;
@@ -45,7 +45,7 @@ int process_mac(const char *mac_address)
 	return 0;
 }
 
-void print_usage(char *cmdname)
+static void print_usage(char *cmdname)
 {
 	printf("Usage: %s <mac_address>\n", cmdname);
 	puts("<mac_address> may be with or without separators.");
-- 
2.43.0

