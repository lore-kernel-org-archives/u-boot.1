Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8714AC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D18A5876A5;
	Thu, 30 Nov 2023 15:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="S+COLjgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B196387698; Thu, 30 Nov 2023 15:40:43 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A07875EE
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 15:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50bd4fcbde1so246225e87.1
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 06:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1701355239; x=1701960039;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nl7qKs0xMYqVNDHH9WM4FezV7LHdF3ESnzYoyQ/wiNc=;
 b=S+COLjgfgBwKTjec7UFEKUmmmK9NfnPqCGiXTT3JpA0XaaVGenlunbYPt6eHztrdON
 DIy2Gy2Hg/oOBRSgTvYBHWEkmprxdkO7W5vtGcO2G1Fu9TV2laoJ27zg97HlrustAiWB
 ILH2LN6FjAqvs4ymDmPC9MRmNYcHAbnKrOqr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701355239; x=1701960039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nl7qKs0xMYqVNDHH9WM4FezV7LHdF3ESnzYoyQ/wiNc=;
 b=c21lUFTlBlBULjqox7g+ucBFr3/TwXObQCLdYVyQ0vi59N9QVOKRQSaJqCHaeyMCk/
 ybKBH3plUAJ97XRAjBAbiXjt81yROASI8rVPe/LXwZBoMwNz+jWJjJmBtXyNkwaCjcMU
 Xg54v9w21wvO99lupgkBrDxeYFQtid58q2sODaUsgvEgEhSGqJMFaLf8rZvjmE5kBsab
 yMlXzEo9tlVCzVlCc3noKHhr3t2vwsVW3m1ZPfB0joInnHpVuGIMqnbl7ptUxj1z+GZB
 layxajGpgut8+q4ww1E7zfsT1gk5Cof9hlQtmPLrXopxyjNYjdE5FKWVcAZczYMhc5Jf
 jV5A==
X-Gm-Message-State: AOJu0YybLcQNlKXq5InSs/oNP3iHrVbzxunExV1Zoff1BPF1hmdE2EuU
 G2uu26bf5J6fHGBkZuH/X/ZoKkmER1jaNuyG7NwD+A==
X-Google-Smtp-Source: AGHT+IFPLJIZ00kzHbdg1p5ZlWgoE+kuhys/QRV3xPtAJLJdTEjAvMQjDoGy8cth2tfgswu4IlzDJQ==
X-Received: by 2002:ac2:510a:0:b0:50b:d177:d9d9 with SMTP id
 q10-20020ac2510a000000b0050bd177d9d9mr1035944lfb.46.1701355238985; 
 Thu, 30 Nov 2023 06:40:38 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:d1eb:b106:516d:db0a])
 by smtp.gmail.com with ESMTPSA id
 x21-20020a1709064a9500b00a18399ff790sm733470eju.215.2023.11.30.06.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 06:40:38 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [RESEND RFC PATCH v2 0/5] Support display on stm32f469-disco board
Date: Thu, 30 Nov 2023 15:40:01 +0100
Message-ID: <20231130144033.1850298-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

The series adds support for the Orise Tech OTM8009A display on the
stm32f469-disco board. Substantial differences in the drivers for clock
management, LTDC and DSI compared to Linux, made it necessary to modify
the device tree. These changes were made in stm32f469-disco-uboot.dtsi to
avoid altering the Linux device tree. It is therefore desirable, as soon
as possible, to add these drivers the functionalities so that they do not
require device tree properties that deviate from those present in the Linux
version.

Changes in v2:
- Add Patrice Chotard's Reviewed-by tag to patches 1, 2 and 3 of the series.
- Fix frame buffer allocation for stm32f469 discovery board.

Dario Binacchi (5):
  ARM: dts: stm32f469-disco: sync with Linux 6.5
  ARM: dts: stm32: make the LTDC clock usable by the clock driver
  ARM: dts: stm32: make the DSI clock usable by the clock driver
  ARM: dts: stm32: support display on stm32f469-disco board
  board: stm32f469-disco: add splash screen with stmicroelectronics logo

 arch/arm/dts/stm32f469-disco-u-boot.dtsi |  13 ++++++++++
 arch/arm/dts/stm32f469-disco.dts         |   4 +--
 configs/stm32f469-discovery_defconfig    |  16 ++++++++++++
 drivers/video/stm32/stm32_ltdc.c         |  31 +++++++++++++++++++++++
 include/configs/stm32f469-discovery.h    |   2 ++
 tools/logos/stm32f469-discovery.bmp      | Bin 0 -> 18532 bytes
 6 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 tools/logos/stm32f469-discovery.bmp

-- 
2.43.0

