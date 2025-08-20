Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9672ACA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 17:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66CB82FC7;
	Wed, 20 Aug 2025 19:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="SfSDgdfY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4801B82E05; Wed, 20 Aug 2025 18:20:22 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92EF382E34
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 18:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=03278829c7=raphael.gallais-pou@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KG2weZ022097;
 Wed, 20 Aug 2025 18:20:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=d35EPuPJtFCqmgMiIJjoZU
 isLNGUbwJFsKvq+r8GTDE=; b=SfSDgdfYRueOG+cC+tBf47I2zMGLyvxBuDS+4m
 pwi7Hk1BhcjDTVmRSYqBAtdD2f6gTJYBKXIbF4WDPXuFmh6LQEel+imXjLktB3bS
 o35yB6mZpAMU+6A1hGzpu8qTke9pFtlwWv13tYfgDISsGRP8yE5J3VkTrCgncn42
 M+0yQLMDKqjnkwjg1CXVU0DhRkWfCZ4Vp+SnlX+VM6Vxbg6+LGqTrrxuSIcYz6ai
 xJ193XloRMcKCqH9ilyXmviWJdKmWNhZgN6NHw4ZUmt1vPaLiEUPY3tp4nAgEQ8C
 D8lwSFwZ4JRt+LK7OV0AA1/CJtVSa/o2RFFzkPkg/0yOx7lQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n7w5tm9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 18:20:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5FFCA4004D;
 Wed, 20 Aug 2025 18:19:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8089272B801;
 Wed, 20 Aug 2025 18:18:55 +0200 (CEST)
Received: from localhost (10.252.7.99) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 18:18:55 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: [PATCH 0/8] Add display support for STM32MP25
Date: Wed, 20 Aug 2025 18:17:39 +0200
Message-ID: <20250820-master-v1-0-fc76f18ab2fd@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACP1pWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Nj3dzE4pLUIl0j4+RUS4vkxJTUVAMloOKCotS0zAqwQdGxtbUASuA
 oalgAAAA=
X-Change-ID: 20250813-master-23ce98cadee0
To: Tom Rini <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Dillon Min
 <dillon.minfei@gmail.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
X-Mailer: b4 0.14.2
X-Originating-IP: [10.252.7.99]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Mailman-Approved-At: Wed, 20 Aug 2025 19:14:09 +0200
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

This series aims to add basic LVDS display support for STM32MP257F-EV1
board.

It introduces:
- the STM32 LVDS Display Interface Transmitter driver.
- a new version of the STM32 LTDC driver.
- the support of "panel-lvds" compatible.

It adds and enables driver support for stm32mp257f-ev1-u-boot
It also brings fixes to the ofnode driver.

This work is based on the Linux device-tree sent recently [1].

[1] https://lore.kernel.org/lkml/20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
Raphael Gallais-Pou (8):
      ofnode: support panel-timings in ofnode_decode_display_timing
      video: simple_panel: add support for "panel-lvds" display
      video: stm32: STM32 driver support for LVDS
      video: stm32: ltdc: support new hardware version for STM32MP25 SoC
      video: stm32: ltdc: properly search the first available panel
      ARM: dts: stm32: use LTDC and LVDS nodes before relocation in stm32mp25-u-boot
      ARM: dts: stm32: remove panel property in stm32mp257f-ev1-u-boot
      configs: stm32mp25: enable LVDS display support

 MAINTAINERS                              |   1 +
 arch/arm/dts/stm32mp25-u-boot.dtsi       |   8 +
 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi |   4 +
 configs/stm32mp25_defconfig              |   3 +
 doc/board/st/st-dt.rst                   |   1 +
 drivers/core/ofnode.c                    |  17 +-
 drivers/video/simple_panel.c             |   1 +
 drivers/video/stm32/Kconfig              |   9 +
 drivers/video/stm32/Makefile             |   1 +
 drivers/video/stm32/stm32_ltdc.c         | 157 ++++++-
 drivers/video/stm32/stm32_lvds.c         | 673 +++++++++++++++++++++++++++++++
 11 files changed, 855 insertions(+), 20 deletions(-)
---
base-commit: 54fbdd408873413af86d86de03a490c5abf280f1
change-id: 20250813-master-23ce98cadee0

Best regards,
-- 
Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

