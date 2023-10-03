Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB6CE7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D963387445;
	Tue,  3 Oct 2023 08:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CUPIPQnY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53FB587445; Tue,  3 Oct 2023 08:37:20 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0C5A87451
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50567477b29so601534e87.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315024; x=1696919824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gdf6SmxQUlQAklUXdPqUNkFbWizUqrzHuRb95fMGVj8=;
 b=CUPIPQnYiXoJZ9UxEjZ3JiF/VlRWYAbhezCV9MsT40AADk5McmYxH5CxD/6DuH6MA0
 eLZHfm8MSsJCXxl2hfl9NdWhxOurTqC1Y0VetnY0LZogEef3AW3D4PrZyl3JGGTMn2TJ
 jaFzdan4zIZ+sHn5/eZHOQAsZ0HZ95EvhOCa+g35dHldCFhHDIO8BCkGpxTWk5l8MdzC
 qVvoiu4sErCzON5OUp0aysb6B6E2xf2hps6HXVYWbZ00sqCZZ0eAZLYSVYdFy6b7o1wz
 utZOIKYBjNLWsnXC5wceZvcYFkf1FgdXfJZYEb23pjdT8b8e6dvZmjr0dr+/4IiXMp6o
 17yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315024; x=1696919824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gdf6SmxQUlQAklUXdPqUNkFbWizUqrzHuRb95fMGVj8=;
 b=Fh665V28/Wn29V5t5Ghj7tRROTlrXa8nfXr0Vcwfc5atYaWJxP0BRj8EWJ7Z7HTvjp
 sKuMntlpG+7udYK1jhzSr/X5w8vD0mquy1XcaYUzOHNePxsUsr9vnBn8WMLcu3nfsf8e
 Uo7r1m3gpbXvwaAfuwy41H3SVkJ002xjM0UlaJ73WOHY/VscGOmyOrxYCOKiO6yWcqdy
 KgTnIOQuMpgzXkJh9tOfwm0ozIgzerFbJPK+z1p1yoW1V0sWAYRn1m+6XSVxzsbMGbWm
 O+u41EHoVQhQmW+xlsmeEd6IyhdoPsBnwDkSGi2uYwNVH/5Ma3FpYySkTEHVwJ4xnCuY
 mPYQ==
X-Gm-Message-State: AOJu0YwAvWt7yixb15gu4vVGKd2D6WdYXQjzvJbBZ9DmQ5TvyxWIvnQv
 YkTTQm6NgTTOaQwJHVV9ktQ=
X-Google-Smtp-Source: AGHT+IFA8GVUfHG5MoWxPIlophNEIDo9Hh0bPQGzb7GLHQYgcIHwhNdT6Ui+S00WFgAukWEqWQS7RA==
X-Received: by 2002:a05:6512:3d20:b0:503:95b:db0a with SMTP id
 d32-20020a0565123d2000b00503095bdb0amr13098775lfv.12.1696315024080; 
 Mon, 02 Oct 2023 23:37:04 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:37:03 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 11/16] configs: grouper: drop I2C_MUX
Date: Tue,  3 Oct 2023 09:36:42 +0300
Message-Id: <20231003063647.42770-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063647.42770-1-clamor95@gmail.com>
References: <20231003063647.42770-1-clamor95@gmail.com>
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

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/grouper_common_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/grouper_common_defconfig b/configs/grouper_common_defconfig
index e90cae2bb8..ead0f970d6 100644
--- a/configs/grouper_common_defconfig
+++ b/configs/grouper_common_defconfig
@@ -59,8 +59,6 @@ CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_GPIO_HOG=y
 CONFIG_SYS_I2C_TEGRA=y
-CONFIG_I2C_MUX=y
-CONFIG_I2C_MUX_GPIO=y
 CONFIG_BUTTON_KEYBOARD=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_REGULATOR=y
-- 
2.39.2

