Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9901C369D1
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 08:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F58982045;
	Thu, 24 Apr 2025 10:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P+rZ6y4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED2A582103; Thu, 24 Apr 2025 10:29:23 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF1B381F7E
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 10:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-30c091b54aaso7018241fa.3
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 01:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745483361; x=1746088161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxbi0v43STPV3xN0UOCrTAYd6ZBb8U76QD76ktelUcg=;
 b=P+rZ6y4fepgeOF5/ST+J/CeVqiJh7kk3bPpRV34Xi4tt6KQMELQRQgu+Rssm+LEwXx
 j5fT43h6DtNbcl4LwKXxIxCOYmYcv8v/cHKpv9VZcHb/mCN83Gryylu2J9Cl7VbA8KsM
 Aj9U0HlUJjZKOJZQjtTeHSINByPABu1Bw7TIiG8k7UmwuWB8+AG1+YkHIHw0SR8Dtjc5
 fnfNURWxkD2ijanrkYSGKIxO95V4W99aSEVQpwX5ZEaqqWVpRtLfnSwbePZKslJWpntz
 ShC6BGcAL2vbnFzhpvw0cy+UVcBga4GjSjG4QGx5hnjL7L6JhIy5Z1+i/7yUbfXAnOyN
 CPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745483361; x=1746088161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxbi0v43STPV3xN0UOCrTAYd6ZBb8U76QD76ktelUcg=;
 b=MRV5kanKrJShvxYDZtp1WO43D2YGj5iDh97LtybrYWiQVvHonm+WNcavnCyYbyOrYd
 V0q6GN01WGAXTvfHiDyNdoqqLArBA2KdzCyZHAA8bNVoQMYC1P2kuTD6qho0wW0YHoS8
 Wq9HzSdyc+mJfKzTVBABp+ql1T7xNzd8QXWIU16xUJUrpxLHbqcwJw5OOnRAOBU9rRMz
 eTP5IpZQWqK5VhvhFfjQrvZYhJ/K1/UPPhv/NENV07AcgZSDDqtx1+siC9DFfLYarNPy
 JFgHL/aRE55HB7tiLrXa6Fda7JOydWJqqY+SPwwYvGpH+VpM+fPGUFqr24iderdgJoF9
 rcUA==
X-Gm-Message-State: AOJu0YxtcmVhZwu/k9AfP6E644jiiy2NXbesXaWCPR0awQ8yK4bCxQiI
 3JttrpkyRtCP/Wb7ghYXFSKg2s1FmMAVjKbFLsDNHPXIR1ZZaNrL
X-Gm-Gg: ASbGncvCkJui6JdhP8bpk5QuIidLZKqTREESuY9ONsc1Imd5MGUozt0aRIPgjugWNOH
 XH8fH9bXXXOMVMn0vk0eq2LSNwzYUALToe8C72w2b9rwZJoQG/upQaYWplCuBYrprbX+N1wTcJp
 o7YYY4GZ/UCaf0Mi1OAgmYtzyqLkq2Ftd0erxJSWFjJbMz5ocvuOPu5g9K4RIoLm+j7TcdcJ7N/
 Ik4lzeW1nxWi+hKOc9vug/g52CwBfz5KtHKdQQvf2OAS6FNmc7i4h2drvhwItGDFyT+3Ng/vrSA
 Y6+3+JxoxNo1pEcboNTjaWy3W7dqDIqt
X-Google-Smtp-Source: AGHT+IGmBYimZ7E6AfcsTaO3QRlTsliK7RiHOiPFSA6WGO4Ap1lXbGwJVjMGOs1DzrF8JitfAG9VzA==
X-Received: by 2002:a05:651c:3133:b0:30b:b204:6b98 with SMTP id
 38308e7fff4ca-3179e7fddc9mr7312281fa.12.1745483361047; 
 Thu, 24 Apr 2025 01:29:21 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-317d16a832csm1627581fa.67.2025.04.24.01.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 01:29:20 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Allen Martin <amartin@nvidia.com>, Peter Geis <pgwipeout@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/4] ARM: tegra: drop CONFIG_DISABLE_SDMMC1_EARLY
Date: Thu, 24 Apr 2025 11:28:33 +0300
Message-ID: <20250424082834.17538-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424082834.17538-1-clamor95@gmail.com>
References: <20250424082834.17538-1-clamor95@gmail.com>
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

This was a temporary workaround for the Tegra210 Jetson Nano board. It is
not used by any device anymore, so let's remove it.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/board2.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2.c
index 68534dcbb22..396851c5bd8 100644
--- a/arch/arm/mach-tegra/board2.c
+++ b/arch/arm/mach-tegra/board2.c
@@ -227,31 +227,6 @@ int board_early_init_f(void)
 		arch_timer_init();
 #endif
 
-#if defined(CONFIG_DISABLE_SDMMC1_EARLY)
-	/*
-	 * Turn off (reset/disable) SDMMC1 on Nano here, before GPIO INIT.
-	 * We do this because earlier bootloaders have enabled power to
-	 * SDMMC1 on Nano, and toggling power-gpio (PZ3) in pinmux_init()
-	 * results in power being back-driven into the SD-card and SDMMC1
-	 * HW, which is 'bad' as per the HW team.
-	 *
-	 * From the HW team: "LDO2 from the PMIC has already been set to 3.3v in
-	 * nvtboot/CBoot on Nano (for SD-card boot). So when U-Boot's GPIO_INIT
-	 * table sets PZ3 to OUT0 as per the pinmux spreadsheet, it turns off
-	 * the loadswitch. When PZ3 is 0 and not driving, essentially the SDCard
-	 * voltage turns off. Since the SDCard voltage is no longer there, the
-	 * SDMMC CLK/DAT lines are backdriving into what essentially is a
-	 * powered-off SDCard, that's why the voltage drops from 3.3V to ~1.6V"
-	 *
-	 * Note that this can probably be removed when we change over to storing
-	 * all BL components on QSPI on Nano, and U-Boot then becomes the first
-	 * one to turn on SDMMC1 power. Another fix would be to have CBoot
-	 * disable power/gate SDMMC1 off before handing off to U-Boot/kernel.
-	 */
-	reset_set_enable(PERIPH_ID_SDMMC1, 1);
-	clock_set_enable(PERIPH_ID_SDMMC1, 0);
-#endif	/* CONFIG_DISABLE_SDMMC1_EARLY */
-
 	pinmux_init();
 	board_init_uart_f();
 
-- 
2.43.0

