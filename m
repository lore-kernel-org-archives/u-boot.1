Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426C8CDD0E1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 20:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAB41892E0;
	Tue, 22 Oct 2024 22:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WchXzomH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A28C889092; Tue, 22 Oct 2024 22:07:58 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A0418929F
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 22:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbd550b648so43652686d6.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729627675; x=1730232475; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMS8OZbP44OFpZgEIpTlpRVhxpfbyEzzkkiaCoJfhU0=;
 b=WchXzomHHXwsRtRi4SmkypkyrpDKxVUfpfbICLhogwYJZEyhgS3QXqKI+msqpADAjA
 61Gc5bmic10B9WxpQwUXs7/zhRurWYkQf4g6+E5EOUZM+vmIkOZhq3NHBqtKHFyel1h/
 OLWomNCeAwXYVwSFqZor2b+QoHNbhX3cUy0I57PS0wMC4N2bQHgNvPJ9uh8907MOq+A3
 SbBCddHZIOK90D8RWBZA5Dkko/G5vDpnx2KttrcNVtrTMxpoekGb5ZJ1cq6k3RgWbenx
 h6MbApKZmWc0truW32Qk87kTboqcdyILogpa+BXivM9JMOVScZZxtulQ36VP0wJuJL9z
 kGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729627675; x=1730232475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMS8OZbP44OFpZgEIpTlpRVhxpfbyEzzkkiaCoJfhU0=;
 b=FKkVLft5wOIE7VEimMfHeSfalwPxCaSXmwdRB7xz4Gv+vDO824XNcChDSDqxi1JErv
 1uWl58+UAjkrKlz8GyR75h944GAYCp0AYZoM9QB8S2LYRD9I7Ojit6HYUQGxwZeDgvEq
 x+SNjeaQcZRl9EjnG7BKRXPJoooFf/wy0lPQNMTf5yY2vewX9jX/nNk+8feMNv/0dO5E
 MUjdLDQaGbMB/CSbXt+k1G07zzVXbmjwG/Ber+cHrJ6XtvHiiUoS2FTMmlJ7blxNpUzg
 ijak+wity0N+1l/NSmLcrDkME//dLvM54dmfXBG/IWCt8Q9mtEMyDF25hZZih/VvTP0w
 myTA==
X-Gm-Message-State: AOJu0YylKmdxkQTAL69OQm0wZWIz7wq2D5KGBedYxwtmQHczQD0uiaVP
 V31OYZYioblYe1a+Hk6ZTTxVwFwlFrvU4DtS54Hbkb02tjeoVIqVXwBORdOTWRArWCgMy7+YHqO
 YFUs=
X-Google-Smtp-Source: AGHT+IE4DFmVUT3k70x9tmlz9vf0NlOtJYBy0UwQ8Hyz5xh2WkT+Ls+4tO+VttAjZnxuCKHMycEg3w==
X-Received: by 2002:a05:6214:2b87:b0:6ce:ee:dbb5 with SMTP id
 6a1803df08f44-6ce341cbfcemr3614016d6.5.1729627675155; 
 Tue, 22 Oct 2024 13:07:55 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce0091a255sm32519956d6.59.2024.10.22.13.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 13:07:54 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: iwamatsu@nigauri.org, marek.vasut+renesas@mailbox.org,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 8/8] configs: Enable sysinfo for QEMU Arm64
Date: Tue, 22 Oct 2024 13:05:29 -0700
Message-Id: <20241022200543.116343-9-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022200543.116343-1-raymond.mao@linaro.org>
References: <20241022200543.116343-1-raymond.mao@linaro.org>
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

Enable sysinfo smbios by default for arm64.
When SYSINFO_SMBIOS is enabled, disable QFW_SMBIOS.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.

 configs/qemu_arm64_defconfig | 2 ++
 drivers/misc/Kconfig         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 088ba39f18e..72d1cd4f995 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -61,6 +61,8 @@ CONFIG_PCIE_ECAM_GENERIC=y
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

