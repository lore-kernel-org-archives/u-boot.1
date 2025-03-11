Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8DCC28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 18:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FBF281760;
	Tue, 11 Mar 2025 19:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ugJGvfLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E8908141D; Tue, 11 Mar 2025 15:35:08 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01111807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 15:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=5165985d62=cheick.traore@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BBP1Io032117;
 Tue, 11 Mar 2025 15:35:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=7qrObWKXJMeZ9YuLfCA7fz
 yVX5ktCjcsTNoyh+fy544=; b=ugJGvfLAUsru+MtEPUWjM1OuRVyC6fP1PXuMi5
 e5GGIGY/u911VEpWGyKD6fiR+mKL1VuoC0e6kWhafhKCS2F1ofmahTAoeCB0c6IX
 ZdK5vh7xh41odzfXsfuA1wRswaPzgd4VfMoptTtOV8ue3THWck79dqoMF0Q2YU5P
 h4znPNAsBFzEE5j5Lb1du69kEWwvQBEFJQiIJU7SqiMasYTUAkkvhDC4cN5QLRgH
 dfGto574W8Pj82YN9JzjqH0p9dJ1wH/P86LN6UJau8WSfOPZ826BQmMwFqZYiwoh
 8ufXAqKL8yV2q/526FQkjy0YRt0dxxwIjtxKRBHPkjyfeHHg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 458f57dk95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 15:35:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4D6AA400A3;
 Tue, 11 Mar 2025 15:33:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 50B9F598413;
 Tue, 11 Mar 2025 15:31:27 +0100 (CET)
Received: from localhost (10.48.86.119) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:31:27 +0100
From: Cheick Traore <cheick.traore@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Cheick Traore
 <cheick.traore@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2 0/4] Add support for STM32 TIMERS and STM32 PWM
Date: Tue, 11 Mar 2025 15:30:33 +0100
Message-ID: <20250311143037.818675-1-cheick.traore@foss.st.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.119]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Mailman-Approved-At: Tue, 11 Mar 2025 19:37:25 +0100
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


This serie adds:
* drivers for MFD STM32 TIMERS and STM32 PWM, the driver split is
  inspired by kernel model
* enable these drivers on stm32mp13 for PWM backlight available on
  stm32mp135f-dk
* timer node, pwm subnode and pinctrl for PWM Backlight on
  stm32mp135f-dk

Changes in v2:
- remove pwm-uclass patch because some drivers already manage the config
  in case the duty_ns exceeds period_ns
- add the check of duty_ns and period_ns parameters in pwm-stm32 driver

Cheick Traore (4):
  mach-stm32: add multifunction timer driver support
  pwm: stm32: add driver to support pwm with timer
  configs: stm32mp13: Enable MFD timer and PWM for stm32mp13_defconfig
  ARM: dts: stm32: Add TIMERS inverted PWM channel 3 on STM32MP135F-DK

 arch/arm/dts/stm32mp13-pinctrl.dtsi         |  15 ++
 arch/arm/dts/stm32mp135f-dk.dts             |  14 ++
 arch/arm/mach-stm32mp/Kconfig               |   6 +
 arch/arm/mach-stm32mp/Makefile              |   1 +
 arch/arm/mach-stm32mp/include/mach/timers.h |  55 ++++++
 arch/arm/mach-stm32mp/timers.c              |  82 ++++++++
 configs/stm32mp13_defconfig                 |   4 +
 drivers/pwm/Kconfig                         |   8 +
 drivers/pwm/Makefile                        |   1 +
 drivers/pwm/pwm-stm32.c                     | 205 ++++++++++++++++++++
 10 files changed, 391 insertions(+)
 create mode 100644 arch/arm/mach-stm32mp/include/mach/timers.h
 create mode 100644 arch/arm/mach-stm32mp/timers.c
 create mode 100644 drivers/pwm/pwm-stm32.c

-- 
2.34.1

