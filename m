Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E733BC021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D5F80FE1;
	Thu, 27 Feb 2025 13:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YKlsvtLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81A8880FE2; Thu, 27 Feb 2025 13:48:25 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C958083E
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22356471820so8039335ad.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740660501; x=1741265301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FNc8SgjNGL5UIZhivcP2zjPSCJQsb4WeAJC5ShIBC9A=;
 b=YKlsvtLEaON5tG2vOiXkEPuUqXcDuUMft//eDCC9waGNU1+Nhix0arfCCJ9jaGuA0N
 1dJJER+Hxrw36rrxPrhBf7GEUfiPuawxlfunKQLs/doYBiprorclozEgNPDNruk76UAo
 VoeXOzZBzTg7ox1/Ek7fAskJLLvhuxcgvxIk+CjeooI7a6lQvD3uCv1wVh0q97HJrlqj
 u1L6cVk5BqJDEgOkbicjX26nQdnelQnO84qW3p12aGFuevidMk4ELJF1AQqNn4QS8O0y
 XZS2Qf69cmZq0Bxi7Sb8K1dYPMoob3tbScQ+C4GYFc2Y81ChBBtJcNdXD28RVqceM8FT
 m2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740660501; x=1741265301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FNc8SgjNGL5UIZhivcP2zjPSCJQsb4WeAJC5ShIBC9A=;
 b=GRZCxtBkTMdGnO+ZCxxQOupbikVyhgvo/JDaRiNh7V6KzjgdTY0fjN+k1LNOTUjUhh
 Uv3GmANz/JJCAOlbjTXJoizljz90PZh0z4iiSztJ9BQkwdLAjFHQsH3l97lzjee+mhSu
 XKhblEG95HTF7ceW/rZhP4GwWWL8uGiealS5f025niDi4oImpKgLanM3W3xfg4dqJnGS
 QgTuQqz1r18Frrb35lw0VHg5pmTFlvj8A6KrW0Vd2DS0H1fcF07hJ44cAPL1uf+bSOcy
 q/LJ53rrTCbR5rGxCfdZSe1PzmcUaI3gRfUPUTQQKbqg0Hog8SLqOan76z+SJoCThj4t
 C10Q==
X-Gm-Message-State: AOJu0YzpYqnPxzbfB7DdH0elkIXIg8KhAOoHJ7USRwa7+/MFTcCP4XkT
 luqc+UIECO0M8UOOcIHEm57Y05g5xyDdu5A5eawkEoiof0wCFpgkFfV6cg==
X-Gm-Gg: ASbGnctsf3wm3FCSFoeM7sWqucW5jQYuT21cQz/t+jsRiNdGA94LhG9hNYnRba8yAZz
 LyrGPHpx4KOrFbi3VBBcbdUzTVM7tvcM/AgsuMKi95hpZ/lTtmdVN/L45iLWY0eNwmNC1gwRaiK
 vxWeHJVJx4SkiSVkPls4Vy/hTnxvIcvDqXkB4D80Qr9L3vZHdaY/Wz+r2KQjqLKBnzyJnFze7ay
 4B7X3Dtamw86Y+Hb2F2FX6ceCCZetg4q3hSJ2DbgAiy+ZgUrXG7EhF1QtxCvtNKP4pzOw7Tn7AQ
 7fM4MDf28enqR6O24XbOA6bohe2EiyeuiwGie5x9
X-Google-Smtp-Source: AGHT+IESQzerHx/QWX1WFXTtHWn1x3c+UG6K6GCE57wTvB7RIxGmIPr9iiphngSUI/qXsExpEH1mrw==
X-Received: by 2002:a17:902:e84d:b0:223:2630:6b82 with SMTP id
 d9443c01a7336-22326306f44mr102048755ad.10.1740660501458; 
 Thu, 27 Feb 2025 04:48:21 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5a29:6887:1512:7ff3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235053e41asm13214595ad.255.2025.02.27.04.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:48:21 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250227
Date: Thu, 27 Feb 2025 09:48:16 -0300
Message-Id: <20250227124816.187928-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit 57bbc4de75f6f6eb066462c777bf18cb8b8d4631:

  Merge tag 'qcom-fixes-2025.04-rc4' of https://source.denx.de/u-boot/custodians/u-boot-snapdragon (2025-02-26 08:55:32 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250227

for you to fetch changes up to 11ad9f8b15b983054ee7a3ec6ada1fd4e0194d6d:

  imx8mp_evk: Pass kernel_addr_r (2025-02-27 09:42:49 -0300)

u-boot-imx-master-20250227
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/24872

- Fix bootstd booting on imx8mm_evk, imx8mq_evk, imx8mp_evk and imx93_evk
----------------------------------------------------------------
Fabio Estevam (2):
      imx93_evk: Pass kernel_addr_r
      imx8mp_evk: Pass kernel_addr_r

Peng Fan (2):
      imx8mq: imx8mq_evk: fix DEFAULT_FDT_FILE
      imx8mm: imx8mm_evk: fix BOOTSTD boot

 arch/arm/mach-imx/imx8m/Kconfig           | 2 ++
 board/freescale/imx8mp_evk/imx8mp_evk.env | 1 +
 board/freescale/imx93_evk/imx93_evk.env   | 1 +
 configs/imx8mm_evk_defconfig              | 3 ++-
 configs/imx8mm_evk_fspi_defconfig         | 4 ++--
 configs/imx8mq_evk_defconfig              | 2 +-
 6 files changed, 9 insertions(+), 4 deletions(-)
