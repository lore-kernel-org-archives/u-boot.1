Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7669AC3ABC9
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 12:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1B2882E2D;
	Wed, 21 May 2025 14:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="f0925c1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FC882EDA; Wed, 21 May 2025 14:29:09 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C97A82E9F
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 14:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7236647066=antonio.borneo@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LC0f19017098;
 Wed, 21 May 2025 14:29:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=W7/zcALgui6R9BdBkaPxe3
 ZPckl7A/FufUkxvtoZ+Sw=; b=f0925c1YaKQG5n5Kkvn9cgFsOh09PutlWsFS78
 o3CTHmSFn5qXD2KpZ5QWocn4/IuIyDC55qrLcEy5pkj886uMdww9BVv4AmZwn4IL
 0wXP3emT0EUnjmEfcnVgVwR+jYZmCP40jn0fCYyUZwWLrV+8RZr5vt2U3IGZUM9p
 M/ZEve/2E5ZZsjCk7qAn9dOHrlEdeIgmA16JNZ1DRpCE/cSxjXHUngtcw7sPk5Ef
 7XYdFL7KfaqI8sZArQVX9Om82kSw8jZQw/ZOvMHVjvfYtK+HnTy4LmCa/RgC3N3k
 DdxY+TMtGeO/D1FJBoqzim73mKOTQz8yOGVX/DqnEcKIgmmQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46rwfc3wjr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 14:29:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 11FAB40049;
 Wed, 21 May 2025 14:28:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C2EFBDE792;
 Wed, 21 May 2025 14:28:09 +0200 (CEST)
Received: from localhost (10.252.16.84) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 14:28:08 +0200
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=
 <clement.legoffic@foss.st.com>
Subject: [PATCH 0/4] watchdog for STM32MP family
Date: Wed, 21 May 2025 14:27:51 +0200
Message-ID: <20250521122755.265760-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.16.84]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Mailman-Approved-At: Wed, 21 May 2025 14:36:09 +0200
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


Antonio Borneo (2):
  watchdog: wdt-uclass.c: add wdt_set_force_autostart() helper
  watchdog: arm_smc_wdt: get wdt status through SMCWD_GET_TIMELEFT

Clément Le Goffic (1):
  watchdog: stm32mp: check the watchdog status

Patrice Chotard (1):
  watchdog: don't autostart watchdog on STM32MP boards

 drivers/watchdog/Kconfig       |  1 +
 drivers/watchdog/arm_smc_wdt.c | 17 +++++++++++++++++
 drivers/watchdog/stm32mp_wdt.c | 33 +++++++++++++++++++++++++++++++++
 drivers/watchdog/wdt-uclass.c  |  9 +++++++++
 include/wdt.h                  |  9 +++++++++
 5 files changed, 69 insertions(+)


base-commit: 0bc9b288fab3d9d143066db71299a4c047be38b9
-- 
2.34.1

