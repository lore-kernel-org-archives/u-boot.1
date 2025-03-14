Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B8AC35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23B5081EEF;
	Fri, 14 Mar 2025 17:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OWora1fM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C651781F0D; Fri, 14 Mar 2025 17:11:23 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCA3F81E1C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e033c2f106so3184391a12.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741968681; x=1742573481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrxCjGSIYMyaNyxH925aWwPMQ7dYmX+aDOBTJqjy92w=;
 b=OWora1fMgBFTcb23CVjZr8do2IkiEn9UF4aVbu30Yfzqp7uBSR+00I+f7xk0OyFl+N
 +CGSYWNyEjz1xK1Nl1nYKnOrfUrT2+TTfHaMQ80W5YVjQtLh0JTlRE9uYcQwFO8Pmo3p
 j+I3qKRqXHMH+szscEQWKZTD/B/Rbyfw5hfGV5DuwVYDtz8gPrrHOVyOBCjrBwTVnZ89
 2FRnal0DgHaitrpdB0+J4VdQQhhDKAH9F3e6OMXJKI4wKcNqsLSxehOfMPQWSTq+aKOJ
 yovLVSvMXgTQuexTqbkYLK57M+3FFpa07m0wAKZdg9VBDwsvQi44ZnZ0Lj3fdg2s0hW0
 cEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968681; x=1742573481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QrxCjGSIYMyaNyxH925aWwPMQ7dYmX+aDOBTJqjy92w=;
 b=R26xh2DP1Zj4+X3jsryfLReGmtTMk9VGEUJLVe/2KKXXPt5Q2dHI7owOHTh4Z5Kap2
 sFpDnz+NyjECUBu34T5moqmPYyo9UsPuICFCH1cS2AcBipDIbWUz1xFOEgrZUu8s6k9m
 vaibQgF4nyEi8gCKB+1WPWBI4tv23Wq+nrf1pAUC13wOk8VNG9U8qVkG2SwD6Qta+Ngy
 n6W3puNgNAX8cIdpS6wjC9gGKG1I6sOG1s6S8uqnMjatwunJtgM7MucbDnjbu/cDdFAs
 KxdkexxomKaulejNJrcMPrq1wY41EsQYrRMaNje4jLST2VO2dzFXidsaFYAJjYqdfv6S
 Z0Gw==
X-Gm-Message-State: AOJu0YyuxJ9edoSlt0mgfL7xafqqIWuU5jFgxBKUFS7UtpsaGhSUUUOx
 YhqQBOiIydUpDpcTVjJckEbkMRpfO1YJtTNJukuuJusVhi+dMEsb
X-Gm-Gg: ASbGnctQ/S4KJrikh2x0yIwpGMdnQUY6iHLO76hxT6V8d9pmZV0iCJgYELyX9BqhmOu
 1FmARe/0dpodbBxpC1WfodFh06r4zMCnDBluYYFOp1TMc9wG6SYf2EcSlCdVwZ9Iuaa5wz88kcH
 JiAhmVr+xR7HjseKuZ/34qwMVF9zD2npCLwE24aClCz5M0BSdVUdW9h6ahTAdksBEjHEBDcNFEr
 7jvFvN2tQzKVXfLIaIARZhv0zjX7cZPY7IbMjIP59yabZzAcW0lwCD7TlMbHylEpiFPN6tXMVtl
 sm3KdAU1TQXkgs+x7w09JGHwindVhm89FWsO
X-Google-Smtp-Source: AGHT+IEJwus/wwqje7vQw0UlLmNM2AVX550MeyAPOJc+jExXFMXifB/u5euiWbDs/6eva+Ba4oSBrA==
X-Received: by 2002:a05:6402:3550:b0:5df:25e8:26d2 with SMTP id
 4fb4d7f45d1cf-5e89e6b1121mr3845775a12.5.1741968680408; 
 Fri, 14 Mar 2025 09:11:20 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e8169bcdb3sm2161904a12.43.2025.03.14.09.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:11:20 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/4] pinctrl: tegra: adjust default values of pins
Date: Fri, 14 Mar 2025 18:10:57 +0200
Message-ID: <20250314161100.36894-2-clamor95@gmail.com>
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

The current default pin and drive values were more of temporary
placeholders. They have to be replaced with accurate default values as
specified in the TRM and header file.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra.c | 34 +++++++++++++--------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index e6b957f5537..b04be168bc8 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -23,18 +23,18 @@ static void tegra_pinctrl_set_drive(struct udevice *config, int drvcnt)
 		return;
 	}
 
-	drive_group[0].slwf = dev_read_u32_default(config, "nvidia,slew-rate-falling", 0);
-	drive_group[0].slwr = dev_read_u32_default(config, "nvidia,slew-rate-rising", 0);
-	drive_group[0].drvup = dev_read_u32_default(config, "nvidia,pull-up-strength", 0);
-	drive_group[0].drvdn = dev_read_u32_default(config, "nvidia,pull-down-strength", 0);
+	drive_group[0].slwf = dev_read_u32_default(config, "nvidia,slew-rate-falling", PMUX_SLWF_NONE);
+	drive_group[0].slwr = dev_read_u32_default(config, "nvidia,slew-rate-rising", PMUX_SLWR_NONE);
+	drive_group[0].drvup = dev_read_u32_default(config, "nvidia,pull-up-strength", PMUX_DRVUP_NONE);
+	drive_group[0].drvdn = dev_read_u32_default(config, "nvidia,pull-down-strength", PMUX_DRVDN_NONE);
 #ifdef TEGRA_PMX_GRPS_HAVE_LPMD
-	drive_group[0].lpmd = dev_read_u32_default(config, "nvidia,low-power-mode", 0);
+	drive_group[0].lpmd = dev_read_u32_default(config, "nvidia,low-power-mode", PMUX_LPMD_NONE);
 #endif
 #ifdef TEGRA_PMX_GRPS_HAVE_SCHMT
-	drive_group[0].schmt = dev_read_u32_default(config, "nvidia,schmitt", 0);
+	drive_group[0].schmt = dev_read_u32_default(config, "nvidia,schmitt", PMUX_SCHMT_NONE);
 #endif
 #ifdef TEGRA_PMX_GRPS_HAVE_HSM
-	drive_group[0].hsm = dev_read_u32_default(config, "nvidia,high-speed-mode", 0);
+	drive_group[0].hsm = dev_read_u32_default(config, "nvidia,high-speed-mode", PMUX_HSM_NONE);
 #endif
 
 	for (i = 1; i < drvcnt; i++)
@@ -142,31 +142,31 @@ static void tegra_pinctrl_set_pin(struct udevice *config, int pincnt)
 
 	pinmux_group[0].func = i;
 
-	pinmux_group[0].pull = dev_read_u32_default(config, "nvidia,pull", 0);
-	pinmux_group[0].tristate = dev_read_u32_default(config, "nvidia,tristate", 0);
+	pinmux_group[0].pull = dev_read_u32_default(config, "nvidia,pull", PMUX_PULL_NORMAL);
+	pinmux_group[0].tristate = dev_read_u32_default(config, "nvidia,tristate", PMUX_TRI_TRISTATE);
 #ifdef TEGRA_PMX_PINS_HAVE_E_INPUT
-	pinmux_group[0].io = dev_read_u32_default(config, "nvidia,enable-input", 0);
+	pinmux_group[0].io = dev_read_u32_default(config, "nvidia,enable-input", PMUX_PIN_NONE);
 #endif
 #ifdef TEGRA_PMX_PINS_HAVE_LOCK
-	pinmux_group[0].lock = dev_read_u32_default(config, "nvidia,lock", 0);
+	pinmux_group[0].lock = dev_read_u32_default(config, "nvidia,lock", PMUX_PIN_LOCK_DEFAULT);
 #endif
 #ifdef TEGRA_PMX_PINS_HAVE_OD
-	pinmux_group[0].od = dev_read_u32_default(config, "nvidia,open-drain", 0);
+	pinmux_group[0].od = dev_read_u32_default(config, "nvidia,open-drain", PMUX_PIN_OD_DEFAULT);
 #endif
 #ifdef TEGRA_PMX_PINS_HAVE_IO_RESET
-	pinmux_group[0].ioreset = dev_read_u32_default(config, "nvidia,io-reset", 0);
+	pinmux_group[0].ioreset = dev_read_u32_default(config, "nvidia,io-reset", PMUX_PIN_IO_RESET_DEFAULT);
 #endif
 #ifdef TEGRA_PMX_PINS_HAVE_RCV_SEL
-	pinmux_group[0].rcv_sel = dev_read_u32_default(config, "nvidia,rcv-sel", 0);
+	pinmux_group[0].rcv_sel = dev_read_u32_default(config, "nvidia,rcv-sel", PMUX_PIN_RCV_SEL_DEFAULT);
 #endif
 #ifdef TEGRA_PMX_PINS_HAVE_E_IO_HV
-	pinmux_group[0].e_io_hv = dev_read_u32_default(config, "nvidia,io-hv", 0);
+	pinmux_group[0].e_io_hv = dev_read_u32_default(config, "nvidia,io-hv", PMUX_PIN_E_IO_HV_DEFAULT);
 #endif
 #ifdef TEGRA_PMX_PINS_HAVE_SCHMT
-	pinmux_group[0].schmt = dev_read_u32_default(config, "nvidia,schmitt", 0);
+	pinmux_group[0].schmt = dev_read_u32_default(config, "nvidia,schmitt", PMUX_SCHMT_NONE);
 #endif
 #ifdef TEGRA_PMX_PINS_HAVE_HSM
-	pinmux_group[0].hsm = dev_read_u32_default(config, "nvidia,high-speed-mode", 0);
+	pinmux_group[0].hsm = dev_read_u32_default(config, "nvidia,high-speed-mode", PMUX_HSM_NONE);
 #endif
 
 	for (i = 1; i < pincnt; i++)
-- 
2.43.0

