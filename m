Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7897C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E7A687896;
	Mon,  4 Dec 2023 09:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fItr0Cr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB8C4878AC; Mon,  4 Dec 2023 09:02:48 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB19E87896
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:02:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c9f9db9567so11096501fa.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701676966; x=1702281766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ln3KgPpp1NYN+iVWQh3XxcDMGlOeA3EogC0M2DyRCxM=;
 b=fItr0Cr7+nnc+/F0bqbpYMacHvUeDTs+RcbTNKdRIVtiCMgcX/Ndtj0/sF0N4wABSh
 zcSbuvtl23udUp42Ayrz/iGi9M65kED5DPgUvTaZfn/Bq9zyPJZozUxxNHONEWhHUWxT
 009LW4DKAAdGPXQ+fne8K15KcRltg2u/ftsgywzJkiAIoLqOfxk+xCG9q3ZCo8rfl9Ht
 qEClG1GifwyyYbkS+Kzy8N3gtvxuHKIcBCCvzG+ZWrwjmWABYFKiFFYUW8Tya2tDp6Nr
 Gdbrv06GTkeKok0VrA7ve63PIt7lD/7KSjQh7VyUxg6mcuBm6ytE9CLoqDsMJFGX0TLV
 KYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701676966; x=1702281766;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ln3KgPpp1NYN+iVWQh3XxcDMGlOeA3EogC0M2DyRCxM=;
 b=XWMdMm9ghG6vG9Raj8LbtmtTBeexzlf/+BC07SwR2vE/ImpxA1AeKd/uYQmKeb+NTI
 WM1epS3E14tZBmo29ycoVKhxAcbPy1uIh+NYTEUwKZmBzTXrIuwNbH9Vsufr2FNSvm5J
 KCQhgR06OInfhp4/B4+jHuHXHgrqS7GzWvmo60eVlM1IbVZAqV18VlQJ7aVbd+fDZRGv
 jsLoXS/szLaZIwU0p654/ES1SH7TtQPj8txRCG/HgSERTJAlPKe3JvCYdFXYMGTLWFjv
 liDmQ5+Jc/9Hi2MQpuX99jTtlvCUX82oFP7sQkKvYFsaWsXGY7KKWuGTRbBTc1a0uDxY
 t9/w==
X-Gm-Message-State: AOJu0YyFTtNteQ9geJEwYgRf1h0Bztg1px63n+94NOf1yNzQ9GF1AS+C
 W9/aV854r2UXHValMnhGdMA=
X-Google-Smtp-Source: AGHT+IGe4Xn6WioKuZxJ/OdmGbO+tJwxUmNRKVfWT7ATIFVE4V8ZZRGutjLDQN6imwgXu9q4Ahppfw==
X-Received: by 2002:a05:6512:118f:b0:50b:d763:fe4b with SMTP id
 g15-20020a056512118f00b0050bd763fe4bmr3116843lfr.102.1701676965876; 
 Mon, 04 Dec 2023 00:02:45 -0800 (PST)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 v6-20020ac25606000000b0050572fcf1a2sm1183048lfd.283.2023.12.04.00.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:02:45 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/3] Add T114 video support
Date: Mon,  4 Dec 2023 10:02:28 +0200
Message-Id: <20231204080231.4316-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

T114 is not that different from T30 and all T30 drivers will work
on T114 as well with some minor adjustments.

Commits pass buildman for tegra and U-Boot tests.

Svyatoslav Ryhel (3):
  video: tegra20: dc: add T114 support
  video: tegra20: add MIPI calibration driver
  video: tegra20: dsi: add T114 support

 arch/arm/dts/tegra114-u-boot.dtsi            |   9 +
 arch/arm/include/asm/arch-tegra/dsi.h        | 235 +++++++++++++++++++
 arch/arm/include/asm/arch-tegra114/display.h |  28 +++
 arch/arm/include/asm/arch-tegra114/pwm.h     |  13 +
 arch/arm/include/asm/arch-tegra30/dsi.h      | 211 +----------------
 drivers/video/tegra20/Makefile               |   2 +-
 drivers/video/tegra20/tegra-dc.c             |   1 +
 drivers/video/tegra20/tegra-dsi.c            |  78 +++++-
 drivers/video/tegra20/tegra-mipi.c           | 185 +++++++++++++++
 9 files changed, 550 insertions(+), 212 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-tegra/dsi.h
 create mode 100644 arch/arm/include/asm/arch-tegra114/display.h
 create mode 100644 arch/arm/include/asm/arch-tegra114/pwm.h
 create mode 100644 drivers/video/tegra20/tegra-mipi.c

-- 
2.40.1

