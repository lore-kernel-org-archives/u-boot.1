Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA0DC3DA6E
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 16:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DC80876BA;
	Sat, 23 Dec 2023 17:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MM5h7xkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E18876BA; Sat, 23 Dec 2023 17:45:56 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 012028772E
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 17:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40d5336986cso1202245e9.1
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 08:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703349953; x=1703954753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELC+u4eB5GyPw+iFQ/rYdrPKgOxYXR4Y5i1wUexhDG0=;
 b=MM5h7xkdLxZbZMiuxvNSQoTHHExhbAx3XLA9/3KchBvf9+orUOlLTc6EXQiN/yBZHY
 CMH0KVb2ShU9gTAfmXxhbNYrAavk6pGjOcvSdZgD2uXCKz6xehCRKSMEqKWcyjnPAfyq
 ftRSUJkcLcnC7vleI8NQdzp6sWjXSh/lcF6AgnYi8MzaY54+gteoWgyescJo71hlGzb8
 fCHp5G2bNTqVkeqM7usoc4xYxQSllR86PJFkhd8QOV71ahsPeQnaPL0F0h2xHgU8qUpi
 o3l8qzBT+eKXQzEcTkjWm7xNBL1mGlcnvmajIRUrfbXfTxIM/bKL3jvSBbWhDBCPWj5l
 jbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703349953; x=1703954753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELC+u4eB5GyPw+iFQ/rYdrPKgOxYXR4Y5i1wUexhDG0=;
 b=IFom+ZEe/wqxHtiQZckhxDheUPIw48kDJ7hSS3qWg+5uPU+ZZLfREH9pK8weCgBt1o
 pGxjGAdAk7Tb1SZtECbsc2Y5bsNOkl3Bk0J8nQXcjcdjoDgNEdkWmAa8QAl7OHLpNMk+
 HUfkwEXRRAdteLgNcFfZiLUC54qYSlBhoiyvfINKTWklVpa91A5gianvNzh925IlvGGC
 koHcJwJKLrAS7naql2XUT7fCwPok4qv/kOg4ypyiiwY5z4Yj1GN5o2NulUG6/j5BhNCq
 7uo0tVi0Qcb6gEVQa8WOgEVxpbp6mlOYtTJOyXFVH5UJdB/jYBQxGCnwOzmn67HmJw2u
 xZ5w==
X-Gm-Message-State: AOJu0Yyb3QYvlas+lyq5LBHRWXyCf2JdC4Tx1qazci70ugZEXF5Ah9Tz
 cB2NvSgr0MQAlIEkV/iFljY=
X-Google-Smtp-Source: AGHT+IFHTcPhM7BcQcb4av18fbi2bQWvaWcf49gJLFfWGCiX5yvb6JwnowfdDLuoOuE+H6GWpTAqJA==
X-Received: by 2002:a05:600c:41c1:b0:40d:2c0d:7a4f with SMTP id
 t1-20020a05600c41c100b0040d2c0d7a4fmr1636437wmh.94.1703349953236; 
 Sat, 23 Dec 2023 08:45:53 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 h1-20020a17090791c100b00a235e5139d5sm3221139ejz.110.2023.12.23.08.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Dec 2023 08:45:52 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Sean Anderson <seanga2@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/3] ARM: tegra114: support nonsecure state detection
Date: Sat, 23 Dec 2023 18:45:25 +0200
Message-Id: <20231223164525.3660-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231223164525.3660-1-clamor95@gmail.com>
References: <20231223164525.3660-1-clamor95@gmail.com>
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

Prinsiple is exactly the same as on T124, testing of register
which behaves differently in secure and non-secure states.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index fb1a46b780..c8907bccec 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -178,7 +178,7 @@ config TEGRA_DISCONNECT_UDC_ON_BOOT
 
 config TEGRA_SUPPORT_NON_SECURE
 	bool "Support executing U-Boot in non-secure (NS) mode"
-	depends on TEGRA124
+	depends on TEGRA114 || TEGRA124
 	help
 	  Certain impossible actions will be skipped if the CPU is in NS mode,
 	  such as ARM architectural timer initialization.
-- 
2.40.1

