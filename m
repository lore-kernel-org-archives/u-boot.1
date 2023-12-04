Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD7FC10DC3
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F5978789A;
	Mon,  4 Dec 2023 09:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EJOW3b0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9707B87812; Mon,  4 Dec 2023 09:21:09 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC739876A3
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c9bd3ec4f6so50541141fa.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701678067; x=1702282867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8aglCpPk/PWQTZX6uhZdahIQFhuhfJMJBZGbRRv+qs=;
 b=EJOW3b0Kt2C/hoX6YCBHXbI/ylSiI5TrvsJnVtaZmEyQPnUZ6NwTCMqvrp8RxBH+fK
 YlGRHu3NMSheVyk7LJdFz1VGo8inrnTWadcPYYdYOFhFdXPPN3d4bJSBR1QwqMKvGyXd
 REL5GeBfjoVrXKNY/De0H7zlKK1F1BVovj6aWjILB2hc4JLEixkyMgL6qfmvbt7/zi56
 +x5vwXHyyPrnw/6ZIMrWLrL0YOodgB/BXfldJ+FPHHofVh1EG8DYouJ/oEFlOYwS3thg
 02pJqj3zJWedolVp5nfEGoGlOgrpVNUemcw+TCrGvSq7FfPubsJm/7Ju8qxB2SV8uLZc
 4WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701678067; x=1702282867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w8aglCpPk/PWQTZX6uhZdahIQFhuhfJMJBZGbRRv+qs=;
 b=IlNsxwNj8Ga7iByyooj8hoManqZYZmT4ZZSp5LDOaavhT2tB0LIpRGZMgjW9b/pwZZ
 +OkJGjnIlA2pv+eNULJ8ZnHKhzZIkDAdVKssBvBNnwEO5CUnCxcKTzn2zRsKW+lCqvgl
 nDGNuUZLehdk/K6xO33nw7hvXMkmmcMiH+fZfpjOmIHZyDDGCNxb9JzrMRh/9emuY9Zf
 xOlGsCj+uCegwaCQtWJAMcn3mHsHADFjfHVW1iCpQpJyNr/R+mUTmnmsWhnnQQpKER/F
 5gk6w7uE84YHZXoK2CP3bcxmE/5KrEFPGcvlVeZL0+hlwWceLTrfOj20i0IUoquc28G7
 ONEA==
X-Gm-Message-State: AOJu0Yz7fsxbZYvm/3S/5nqMRScoAGFvAQNVu7WO0J1jCo996PVxAYrl
 mM4aj6XnzuJ/X/T0LA2s/eg=
X-Google-Smtp-Source: AGHT+IF2nYuNakAvKJERtyyL+Eu89mq1Z83vnbWNzAJANUHX6dUbyp9ToingfK2wGeraB8zWbLmP5w==
X-Received: by 2002:a05:6512:281c:b0:50b:f9b2:d00 with SMTP id
 cf28-20020a056512281c00b0050bf9b20d00mr228321lfb.22.1701678066832; 
 Mon, 04 Dec 2023 00:21:06 -0800 (PST)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 q16-20020a19a410000000b0050bfe62b073sm3655lfc.170.2023.12.04.00.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:21:06 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ramin Khonsari <raminterex@yahoo.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/8] ARM: mach-tegra: rearrange SPL configs
Date: Mon,  4 Dec 2023 10:20:47 +0200
Message-Id: <20231204082054.4943-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204082054.4943-1-clamor95@gmail.com>
References: <20231204082054.4943-1-clamor95@gmail.com>
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

SPL configs are used only by the ARMv7-based Tegra SOC's, so move
SPL_SYSRESET under TEGRA_ARMV7_COMMON selection and enable SPL_DM
since SPL_SYSRESET depends on it.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index f273778128..547372a639 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -61,7 +61,6 @@ config TEGRA_COMMON
 	select OF_CONTROL
 	select SPI
 	select SYSRESET
-	select SPL_SYSRESET if SPL
 	select SYSRESET_TEGRA
 	imply CMD_DM
 	imply CRC32_VERIFY
@@ -78,7 +77,9 @@ config TEGRA_ARMV7_COMMON
 	select CPU_V7A
 	select SPL
 	select SPL_BOARD_INIT if SPL
+	select SPL_DM if SPL
 	select SPL_SKIP_LOWLEVEL_INIT_ONLY if SPL
+	select SPL_SYSRESET if SPL
 	select SUPPORT_SPL
 	select TIMER
 	select TEGRA_CLKRST
-- 
2.40.1

