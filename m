Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8C5C35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B47081EE7;
	Fri, 14 Mar 2025 17:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D8ZlOPur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C3BF81F0D; Fri, 14 Mar 2025 17:11:25 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 228AB81EE7
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e56b229d60so6224023a12.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741968682; x=1742573482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JtBjT6+vtmucb2+4Ynew4mSWvaX1J9BwGbtlxwy66JY=;
 b=D8ZlOPurfiyUi0ebXXliDthSkf/43WLbaWkjNQ9uEz6iaJoEbE4ESHKvtJr61rNYsc
 LJOXBUsBTuwiRApDhTjRReHov1uweS5PUkxTkpLtCbM2Z15Yu+b4jz0LEnQ2iI6esmo+
 EGu+WNqDB/drX7VAS0y2WWRUBJG6a661Wj3zdoIjFuw5Cd3vGwXDa6cRWx3SVTbDZxu4
 yu7sYWk1pnkTRpmEAMldBGuP+lGp4RrgLImDINaBLgTcPVOxs6ZkG6xD+OJYr+yyI81T
 aYZKDHk3lp8ac6MgV/HnHecu3GFhYKk9rY1WLqyIEup3AGMrEc0S4CS4O+Iefc7SF1n1
 8NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968682; x=1742573482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtBjT6+vtmucb2+4Ynew4mSWvaX1J9BwGbtlxwy66JY=;
 b=PG0VxPs9PblGaFrq4r7VuP8sBzmq72quBe720p3TAZeUZpPGi2WbaXpcIZuQFW8s8G
 gpUWgrErrCQMj56HHf+90W1z788q9twK6kgWjWaiTBdQKhjFHd8rqoxEdTjD8pL5erre
 4CX3vWO64dZpKL7cSqQ5j3HZwQix0FrtfTcnuXdVwFTSXIVMKdDwWH4H0XnN4vL5iv+X
 eqtozK2YKB9sJDy0QOZ89z/d6w6GW51QLZFKUPlsXq88vTWUQmgw0KZbR84LhDz6QkfQ
 aTDrggjUoJhKVsfK8WfUM5WjrVHoUu22lrH9S/Z7x03ZnCZ9IB4XiDY6rydUVxZLUDjP
 VNtw==
X-Gm-Message-State: AOJu0YyHeFbRwXQfRqmwGMXVd1lHsdBFCiQLjxir4/Kg9hiLE8NaG056
 CxWGseqWDZcLs/0KTlbAKRlwBwk7K7WL87vVKHtgsD43vEkMCbAVreLFBA==
X-Gm-Gg: ASbGnctcvEc/KcGgo0H98kciy6PvNym627+/oCimlgb9NcnmZytbeK0JMWAR6h+w3ce
 EiqQyShmMCGBWQ1Phf07tz/DUXxQBn3LdiTd0nKuZBLCSUwyYn8176d5EWDL5Z254LlzCJLU2G6
 77MZx/+bJl0bZ/0FS6uUIPJUXz2i7rdNcl8kZPzrJVCZGgrOZa6Qm8n93mCtOYtSuxad8TVpKtw
 uYubB7UnzbhG460rUaZrj+9oPQVPky4W9Yeisyt0y26rI6tRIEPmJkLMKVSwgUPiLk2dzbYMzvm
 NSNbv2C3xvQydoxCTjgv1KQkmdjKKkHAyxxu
X-Google-Smtp-Source: AGHT+IFv+U91aX3oeABGnKBq3y6gSD4au5rEmBdURUjjLn1rPv2DVyIXTwNm2i9DciOUHv0skTNfbw==
X-Received: by 2002:a05:6402:42ca:b0:5e6:11be:f5d0 with SMTP id
 4fb4d7f45d1cf-5e814f0b1f9mr7768922a12.12.1741968681284; 
 Fri, 14 Mar 2025 09:11:21 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e8169bcdb3sm2161904a12.43.2025.03.14.09.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:11:20 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/4] pinctrl: tegra: adjust pin state lists
Date: Fri, 14 Mar 2025 18:10:58 +0200
Message-ID: <20250314161100.36894-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314161100.36894-1-clamor95@gmail.com>
References: <20250314161100.36894-1-clamor95@gmail.com>
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

Modify the pin state lists for lock, io-reset, rcv-sel, and e-io-hv
properties by repositioning the default value to the end. This change
addresses conflicts with device tree representations of TEGRA_PIN_DISABLE
and TEGRA_PIN_ENABLE.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra/pinmux.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra/pinmux.h b/arch/arm/include/asm/arch-tegra/pinmux.h
index 4b6e8419504..9a5cc93884c 100644
--- a/arch/arm/include/asm/arch-tegra/pinmux.h
+++ b/arch/arm/include/asm/arch-tegra/pinmux.h
@@ -34,41 +34,41 @@ enum pmux_pin_io {
 
 #ifdef TEGRA_PMX_PINS_HAVE_LOCK
 enum pmux_pin_lock {
-	PMUX_PIN_LOCK_DEFAULT = 0,
-	PMUX_PIN_LOCK_DISABLE,
+	PMUX_PIN_LOCK_DISABLE = 0,
 	PMUX_PIN_LOCK_ENABLE,
+	PMUX_PIN_LOCK_DEFAULT,
 };
 #endif
 
 #ifdef TEGRA_PMX_PINS_HAVE_OD
 enum pmux_pin_od {
-	PMUX_PIN_OD_DEFAULT = 0,
-	PMUX_PIN_OD_DISABLE,
+	PMUX_PIN_OD_DISABLE = 0,
 	PMUX_PIN_OD_ENABLE,
+	PMUX_PIN_OD_DEFAULT,
 };
 #endif
 
 #ifdef TEGRA_PMX_PINS_HAVE_IO_RESET
 enum pmux_pin_ioreset {
-	PMUX_PIN_IO_RESET_DEFAULT = 0,
-	PMUX_PIN_IO_RESET_DISABLE,
+	PMUX_PIN_IO_RESET_DISABLE = 0,
 	PMUX_PIN_IO_RESET_ENABLE,
+	PMUX_PIN_IO_RESET_DEFAULT,
 };
 #endif
 
 #ifdef TEGRA_PMX_PINS_HAVE_RCV_SEL
 enum pmux_pin_rcv_sel {
-	PMUX_PIN_RCV_SEL_DEFAULT = 0,
-	PMUX_PIN_RCV_SEL_NORMAL,
+	PMUX_PIN_RCV_SEL_NORMAL = 0,
 	PMUX_PIN_RCV_SEL_HIGH,
+	PMUX_PIN_RCV_SEL_DEFAULT,
 };
 #endif
 
 #ifdef TEGRA_PMX_PINS_HAVE_E_IO_HV
 enum pmux_pin_e_io_hv {
-	PMUX_PIN_E_IO_HV_DEFAULT = 0,
-	PMUX_PIN_E_IO_HV_NORMAL,
+	PMUX_PIN_E_IO_HV_NORMAL = 0,
 	PMUX_PIN_E_IO_HV_HIGH,
+	PMUX_PIN_E_IO_HV_DEFAULT,
 };
 #endif
 
-- 
2.43.0

