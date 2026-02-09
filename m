Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98220E81BD3
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 043548397D;
	Mon,  9 Feb 2026 19:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bQwjvR1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE37183C5E; Mon,  9 Feb 2026 19:03:51 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9D1080325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-59e3810df30so5468145e87.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770660229; x=1771265029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O9h6r8cb3iuaJ2fmf1cSeeTGg44YzXFEFN2v3+MH2Wc=;
 b=bQwjvR1WNRn3YFA88J4+t0/5jzKElZ2sBJspVJCoFmm2rcHzb1uelCA4EDMqVNe5qr
 zW6gYH1qJh2wK9cH3TTwraZIOHY2mVdKJlD5/7+T1gftPsTpyhvTPqwM7cw4oqbWuyqZ
 z+Wk+Bq/tg/WXaWCSkBJprwsJkERXny9GY5xN5jKXiG7oXCBhyGAeIrxZZV/AHZhuqmU
 BuTTScfVQnwVJ7HmJXldng3bz8gPAGpCGU92ZhTD3cvHGGXm1EweYfEr2WOeNzGfiKTi
 JMA5tc60JLy4ndTbkfwPU9vmiF24ctOMKVW97SNSCeqfSy8EmIT80rkgmwK+lnwfEYXl
 S6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660229; x=1771265029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9h6r8cb3iuaJ2fmf1cSeeTGg44YzXFEFN2v3+MH2Wc=;
 b=keNegfN2KON5l5NRnNfR2R6Z48Ky2qHfhTnB1GaYdQkuBn0rQ56V6iHs3Oe4zjuwmc
 OqwKVghoFTP1LFg2dXlLsQ27RzWl8AcyHjVwgQtHha56cfSmBrowuwTBhxGrkyOkkLIo
 pMSKGQjXl+rcpygpdVVv3VcdwluxItO4Eh2KUBvxjrvOsbcLAjEvTA/0pLINOdyJhtPx
 yg8dHNRIeoLPUOuHkC5HZKuo/k4Pap9yhEKSn44OPF8L2CrffX3F7CVJ4umU3HvVNAda
 q/8+QeB+yUiPnzRjwB5z0iobKdKYmOi3a/luV++g3+nUpj7gK8P5O+X/xIMUEiDjRQrO
 vjCQ==
X-Gm-Message-State: AOJu0Yzl5WIYzxhNmSoRJX2kOqwR+2nDYVGkjsarEyUzVQMFZds3mk90
 V/JkZQYc03B+XK5D1kuWGBSq+uFvHzN3QYAmQqnOevOGaNPedlF2fPY7
X-Gm-Gg: AZuq6aLaPAZVbXCRO10rio/ftV7t9bruHM1pi1T2ZgXplVizn2HzoCUvtjCHhOhdILq
 O/H/QikYygFqjehha+O4EjynL0qDmhn+GCcW0yzCCHES6esoOM0yNNSkVmPzqHiAEg7U5oGmv8I
 bHjTic5a/eSWOa0mftG/qt8tEABGXLaYN12w6me1uHKf5AKKIowGRI2eXpbqFVXMhfq2J4TsO6r
 2F4IVm+DdJJ3d8ong3+gV0DpSL1Pk1Z1xtF4SYUVoutVp8yLflpACcY8huKgax1oEmc8wocBCVy
 TFbDEL/Iv8z56JQEVtbHsIlGVd1Ic8ZDUT8wW5pmYTEKABW3+4HUiCz1gjgei7cTnXuX1D5QgRN
 pV/yafYGB9chruXuJIoK3X3/1BbL1fLqruQXWxDs/hjaqRrhZl1EdtE0DPUYsKdXAcrlkVJ+DQO
 Hk
X-Received: by 2002:a05:6512:400b:b0:59d:d799:b7a0 with SMTP id
 2adb3069b0e04-59e4515947bmr3501382e87.36.1770660228910; 
 Mon, 09 Feb 2026 10:03:48 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-386b6236383sm27285351fa.10.2026.02.09.10.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:03:48 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/4] pwm: tegra: improve PWM module handling
Date: Mon,  9 Feb 2026 20:03:22 +0200
Message-ID: <20260209180326.32190-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Align driver closer to the Linux kernel to better handle various
PWM use cases.

Ion Agorria (1):
  pwm: tegra: properly calculate pulse and frequency divider fields

Jonas Schwöbel (3):
  pwm: tegra: add probe function
  pwm: tegra: add set_invert PWM operation
  pwm: tegra: fix pulse_width calculation

 drivers/pwm/tegra_pwm.c | 85 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 7 deletions(-)

-- 
2.51.0

