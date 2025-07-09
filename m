Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDB7C83F10
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 22:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD225835CE;
	Thu, 10 Jul 2025 00:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aYsB7wsK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1935E8354B; Thu, 10 Jul 2025 00:29:33 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D83F98354B
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 00:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so256089fac.0
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752100169; x=1752704969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jgT2fRvfNr4c2d+0rvl0U7k8AcbcmcJU8vT+ZFzt2U=;
 b=aYsB7wsK6cUrRVzLR5UAH7/Y2IFZwy9pWq8BdPRumTgqqZGVztEmHbaocqoqi/V97D
 PMbNHvsV35kIGHPBswfePmcAmzOOvAdcJjlNVKQrph6L6XjDYNyJVv/H3W4hnC20EqVi
 Yb+EE3zjDpn/c1/B7GY/rK8LAOEnQ3Wx0INN0g5i8tvrkUWtHR6yFtLP6FDFT6+mLYp+
 3PkmcYehszhoqdRpqcQD/diWqRjTxG2K38/lCwdGIgnHCHlzxuLCA7+K0IvTDNW0rkuJ
 ctgIwAbuwaQI+ZhkBJ/47vdQXG3+qKE6pjVdxUeahbFC5sPsYebM9Rt14ZsnUcTvEpw8
 UIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752100169; x=1752704969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jgT2fRvfNr4c2d+0rvl0U7k8AcbcmcJU8vT+ZFzt2U=;
 b=pdrA10APQp/DRuOpYTSyH+4eXgGs3Z21rTndFRrLhXkzCmZGckTLkH5mhRMBMtfqFR
 O7uiQWkNqAYSq4rk01G1Q0FWVOFQ4O8e8PfprOEMDE8/NSaJ/zY9S8hOMXK7O9VHpOsu
 8qHOJvRsTXXKwJcTwl/4zx7mQc5n095EgmVkAQyjmFLItKPWbfdxyPgwKvVAcyrYgfxA
 WDBYO65lvMHukvyiOjJNim8DeSHg4cEVAQW5a1qo9d6d9MhGyryJ49OzQp4cpU2YSPas
 vh1QgELYl5jd/291LCLYgoKlo2ELstOuvd1NiZ9o6Ocn6jxzbWZw3PWzuJ3nvI3+wAbL
 AHUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb14nZq3FlL01i+pbbKXyrl7f17tFZmzLyj29RTbkfnTEGO3qIuNXF7rELUE1hCsC/gXJxS10=@lists.denx.de
X-Gm-Message-State: AOJu0YyeuGykZA5XnWXgTvOR/GILT1HDQumjiYMhlvzNYDbeyJsgz0Lp
 yJ2Y48cYTPOcMZzBGZ2uZeOm6lgTk8FZZOeDLCbOOuO3nbFxqSYIXRi1Kq7eVPWYRyqpwyYR4x2
 xHYJM
X-Gm-Gg: ASbGncuCf0FX8kTaLQjUMOBKnGkIYNqYS7pWaEJSM/ArXU20REVtiaDYwaLrapxB/df
 KoVCAm9x5f+0dX1RvmOfq5Ul8WyyYx6zQYMihTeBYSfO89g9U4Hpmo0gPs3jMdGO1xdvwjy7i6y
 HkSMapEExoCWGjexwN7JYxUALdZB7ghBLrhV5f9NKr9yTi8B20y3E0dSOD7o9f7z4gxLVD88ann
 1GSUc4GIVJZOaQgMHnxPmG4uZI7f3S1NkexNpE7HMbHr51D/TqS2dzeWywMuxoYOjGNxz9ZtZmq
 XyHNkmNboX+X9ns5oKCHTzFtBDHA3JnlIztF1uFUO0HcLhsVCJJ83p6CXl2T937y+/Mj+tk/
X-Google-Smtp-Source: AGHT+IGFGqD6Kdup1zyajHIIQ7XQvh0PloOS9rQM1zYKV4YGpKyPMwN8R814Xpo6HkQSgekoclqYZg==
X-Received: by 2002:a05:6870:7a9:b0:2d6:b7f:1e6d with SMTP id
 586e51a60fabf-2fef80ab807mr3064481fac.0.1752100169523; 
 Wed, 09 Jul 2025 15:29:29 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff116d3541sm42756fac.35.2025.07.09.15.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 15:29:29 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Simon Glass <sjg@chromium.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH 3/9] board: samsung: e850-96: Setup serial# env var
Date: Wed,  9 Jul 2025 17:29:20 -0500
Message-Id: <20250709222926.24671-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709222926.24671-1-semen.protsenko@linaro.org>
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
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

Setup "serial#" environment variable from the chip ID. The chip ID is
read from Exynos850 SoC OTP (One Time Programmable) memory, which acts
like an EEPROM and contains unique SoC ID. This "serial#" variable is
further used for "fastboot devices" serial number, etc.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.c | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index 3bbd95201b5f..addfe0460973 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -4,9 +4,17 @@
  * Author: Sam Protsenko <semen.protsenko@linaro.org>
  */
 
+#include <env.h>
 #include <init.h>
+#include <mapmem.h>
+#include <asm/io.h>
 #include "fw.h"
 
+/* OTP Controller base address and register offsets */
+#define EXYNOS850_OTP_BASE	0x10000000
+#define OTP_CHIPID0		0x4
+#define OTP_CHIPID1		0x8
+
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
@@ -17,6 +25,33 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
+/* Read the unique SoC ID from OTP registers */
+static u64 get_chip_id(void)
+{
+	void __iomem *otp_base;
+	u64 val;
+
+	otp_base = map_sysmem(EXYNOS850_OTP_BASE, 12);
+	val = readl(otp_base + OTP_CHIPID0);
+	val |= (u64)readl(otp_base + OTP_CHIPID1) << 32UL;
+	unmap_sysmem(otp_base);
+
+	return val;
+}
+
+static void setup_serial(void)
+{
+	char serial_str[17] = { 0 };
+	u64 serial_num;
+
+	if (env_get("serial#"))
+		return;
+
+	serial_num = get_chip_id();
+	snprintf(serial_str, sizeof(serial_str), "%016llx", serial_num);
+	env_set("serial#", serial_str);
+}
+
 int board_init(void)
 {
 	return 0;
@@ -26,6 +61,8 @@ int board_late_init(void)
 {
 	int err;
 
+	setup_serial();
+
 	/*
 	 * Do this in board_late_init() to make sure MMC is not probed before
 	 * efi_init_early().
-- 
2.39.5

