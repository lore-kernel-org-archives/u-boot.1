Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12303C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F122C83600;
	Fri, 23 May 2025 18:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="L0+yBEOG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C70C831C3; Fri, 23 May 2025 11:48:06 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E3A830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 11:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7238a91f03=antonio.borneo@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N826KS024909;
 Fri, 23 May 2025 11:48:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 J5zTpSUWmnmvaB+ebeoyiNcmeSkixkYVC82YamZI3h8=; b=L0+yBEOGQKxSiIr/
 gHZwBI+TXExcWKQZHzNDjPcDhHpSzdd2J/4R4+ow30TjttP8iXOEegzK+Org22hC
 vK0d6xiBtFTyE/mJ1b9yPSuHPaBNVhbYu08ZIXbSBHeG8kXIpqC8dM4+u060eWCX
 232kxqWufy5AvgAjOjLbmOmdA51GQBNVYdTq8lRFFqgEKMX+IkgfR3WW+xWjX0el
 y27WvrD0KRzJkOWBlZO3lcvVxHxPTU38me+xzVQw/fNOY6i8zriiUZx7p+7vZs1+
 g8ljdsvP3b1iDWb/DYcYqFVm/vlbZLSjIinhOCCA+Djg6ADs2p4+nY/PzD6Mt369
 6bSgNw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46rwfanecg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 11:48:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CA4944004C;
 Fri, 23 May 2025 11:47:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 679FBAD36F6;
 Fri, 23 May 2025 11:47:11 +0200 (CEST)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 11:47:11 +0200
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=
 <clement.legoffic@foss.st.com>
Subject: [PATCH v2 0/4] watchdog for STM32MP family
Date: Fri, 23 May 2025 11:46:54 +0200
Message-ID: <20250523094658.299730-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521122755.265760-1-antonio.borneo@foss.st.com>
References: <20250521122755.265760-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.132]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01
X-Mailman-Approved-At: Fri, 23 May 2025 18:55:43 +0200
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

This series addresses the two watchdog drivers used on STM32MPxx
family platforms.

On the generic watchdog framework, it adds a new method
wdt_set_force_autostart() used by the watchdog drivers to force
the autostart status of the watchdog.
This is used when the driver detects that the watchdog has already
been started by a previous boot stage (e.g. HW, bootrom, Secure
OS, ...) and needs to be kicked by U-Boot regardless of the
autostart flag set in DT or in config.

On the driver arm_smc_wdt, it adds the API to query the Secure OS
about the state of the watchdog, and if at probe the watchdog is
already started it invokes wdt_set_force_autostart().

On the driver stm32mp_wdt, it adds the code to detect the state of
the watchdog, and if at probe the watchdog is already started it
invokes wdt_set_force_autostart().

At last, since all the watchdog drivers used on STM32MPxx family
platforms can query the status of the watchdog and use it
consequently, set WATCHDOG_AUTOSTART default to 'n' on such
platforms. This implies that U-Boot, by default, will respect the
status of the watchdog set by a previous boot stage.
For backward compatibility on platforms using SPL, still let
U-Boot to autostart the watchdog.

V1 ==> V2
- Fix backward compatibility on defconfig based on SPL
- Fix inconsistency in the commit message
- Rebase on current branch next

Antonio Borneo (2):
  watchdog: wdt-uclass.c: add wdt_set_force_autostart() helper
  watchdog: arm_smc_wdt: get wdt status through SMCWD_GET_TIMELEFT

Clément Le Goffic (1):
  watchdog: stm32mp: check the watchdog status

Patrice Chotard (1):
  watchdog: don't autostart watchdog on STM32MP architecture

 ...stm32mp15-icore-stm32mp1-ctouch2_defconfig |  1 +
 ...tm32mp15-icore-stm32mp1-edimm2.2_defconfig |  1 +
 ...-microgea-stm32mp1-microdev2-of7_defconfig |  1 +
 ...mp15-microgea-stm32mp1-microdev2_defconfig |  1 +
 configs/stm32mp15_basic_defconfig             |  1 +
 configs/stm32mp15_dhsom.config                |  1 +
 drivers/watchdog/Kconfig                      |  1 +
 drivers/watchdog/arm_smc_wdt.c                | 17 ++++++++++
 drivers/watchdog/stm32mp_wdt.c                | 33 +++++++++++++++++++
 drivers/watchdog/wdt-uclass.c                 |  9 +++++
 include/wdt.h                                 |  9 +++++
 11 files changed, 75 insertions(+)


base-commit: ef305ceff9c875a7c16fdffc5e120d8ddf6243b7
-- 
2.34.1

