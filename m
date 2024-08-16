Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FC4C531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 15:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFAB588C09;
	Fri, 16 Aug 2024 17:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j7ZUjhHl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE751889E9; Fri, 16 Aug 2024 17:48:27 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD4288BA4
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 17:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7a1e0ff6871so141873185a.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723823300; x=1724428100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtYO8sIBqQo3XsAFIFT9ACrOFv5k+mW4YVAdg0gERB8=;
 b=j7ZUjhHlZ3fG0JtHNZZiNlRfTqgN086+zoY4G6d+hyvADANB9LbIUki7tVkS4JQ2wm
 J/4sZ7JYogj8DRBgilvTZysRCd9JmIITP5rnVtT0CFQe8V9fXzV4rjAyy2M7zXqh+CCG
 2CpzD0b9SGHdyOTUC1hT/s2gvLwTufLqOTbaYVG2FQSyLs/plbv6vFJXAJaO/ZqX0fwy
 /mlTfqPhCBYk+I8KGnbBQ4tRTqOG3OVvGYI3gbM63jPNfi4fQPmazBTYCemVshppibcY
 4ueY8zl1sB7BJBj54OcbcApraMf9lE00Clpz9KHAis9qMZdycP8xnQ+Bc+7RLmcGp+M5
 Cdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723823300; x=1724428100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtYO8sIBqQo3XsAFIFT9ACrOFv5k+mW4YVAdg0gERB8=;
 b=egntpb4JwUpviEezmHbUikIVxxzmfBGs1hf/wqEdxXHKPwDpw8nkJ8hgxU8MDy0v3u
 6KXWpUAzzJT2TtFKaxd7xyQ8eSXVl0QImZMBTH3oRwmPYqNwqOzw/qi0NX9ghsZYOrtP
 KhG9T4yqvbeS+I1mXBX+syiXy61k/BTvDXrSTCkjgRRr60pOQBPCFqJNXRLLAQXQtKBf
 qfmcGuPafSgIMo1FZVxlnxegJ5KQFXNJj0rv9Tg8CjaeBhUSH+u/KergQB4r9MMqgrSN
 ln1vhQBLm/TnYduZwF1t0gzTzw8TJUP48/7u9B6a9TQ/dRHthhEe3HuGWsI8akBVxyQ9
 ivZQ==
X-Gm-Message-State: AOJu0YwARm1AM3PKTk0QtqYLaRYV/7aHAEN2kWWfhcGJVi3nhmZBj0Qd
 AjjVisVW+o++ZgFolk3AJZcSgZ4os7IUvzsXyju6urVxujtlxfLVKNCuAUGnDktjTbUJ9Vq1TXv
 +1nw=
X-Google-Smtp-Source: AGHT+IFBZU3iZvgvxs98XbOLyNVHmQmDRWsyRGVguH5xnUNwX1ZtApT9//cCSJCBYraWhOTwJv+tqw==
X-Received: by 2002:a05:620a:c51:b0:7a1:3ffb:e88e with SMTP id
 af79cd13be357-7a64c75a983mr6526285a.9.1723823300567; 
 Fri, 16 Aug 2024 08:48:20 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff0e53d8sm187041185a.85.2024.08.16.08.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:48:20 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Michal Simek <michal.simek@amd.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 09/10] configs: Enable sysinfo for QEMU Arm64
Date: Fri, 16 Aug 2024 08:46:52 -0700
Message-Id: <20240816154658.1866186-10-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816154658.1866186-1-raymond.mao@linaro.org>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
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

Enable sysinfo smbios by default for Arm64.
When SYSINFO_SMBIOS is enabled, disable QFW_SMBIOS.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 configs/qemu_arm64_defconfig | 2 ++
 drivers/misc/Kconfig         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 7e166f43908..dac656f5c88 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -60,6 +60,8 @@ CONFIG_PCIE_ECAM_GENERIC=y
 CONFIG_SCSI=y
 CONFIG_DEBUG_UART_PL011=y
 CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_CMD_POWEROFF=y
 CONFIG_SYSRESET_PSCI=y
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6009d55f400..da84b35e804 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -568,7 +568,7 @@ config QFW_MMIO
 config QFW_SMBIOS
 	bool
 	default y
-	depends on QFW && SMBIOS && !SANDBOX
+	depends on QFW && SMBIOS && !SANDBOX && !SYSINFO_SMBIOS
 	help
 	  Hidden option to read SMBIOS tables from QEMU.
 
-- 
2.25.1

