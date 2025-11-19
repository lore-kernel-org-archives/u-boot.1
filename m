Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB56CF256C
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 04:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765638397A;
	Wed, 19 Nov 2025 05:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="VZlxwJYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C1608398D; Wed, 19 Nov 2025 02:56:47 +0100 (CET)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 030868397A
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 02:56:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kernel@airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1763517364;
 bh=vZleOfFhUxLyu/n2fhg44qAJd9C2ZaZalrr2mmuwRFg=;
 h=From:To:Subject:Date:Message-Id;
 b=VZlxwJYfwwX0hEcnSqf8FnIenZJ91PXwefINEQkILhUCGkpI6T3Bwn7/5sWtu+Mn1
 Lu5mwX1mEj/dXecn5GQMfjXImHriZTn3SNXOz0/MlOGwrqj6Nd1Z34pxsQVL/0Y5xc
 cyontgjOP+rrljz/9zOeR/JN+J9WK6STB98+nklQ=
X-QQ-mid: esmtpgz12t1763517361t3f9555a0
X-QQ-Originating-IP: vUDQogImCpmwzSNiuU+YzJZIfdJzE36mX5AtXI/5bWw=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 19 Nov 2025 09:56:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12206587374338150515
From: Chaoyi Chen <kernel@airkyi.com>
To: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH] configs: rockchip: Enable RK806 PMIC on rk3588-evb
Date: Wed, 19 Nov 2025 09:55:54 +0800
Message-Id: <20251119015554.153-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OBUGnm9pFasAhF/tanTg4gnR6scWqStkAF6hMfZjQb27URgg5XHPNYSl
 di0f0t3vztamPovpzM97CN0AXprNZ0flQYD0TecnSvNIkAhHM1jKsXn2tvV9jy/5vBHw2yO
 s/bOAMFj5znI/cV3GJM8E2UngMyoei5DyEyt2G4FAddAy5GS4SH5PX6XoCg/HQXhOmqQXL5
 boWdauk07VAFIAF45NRCi7f0YQfgFiJAtpYTN+K9woFuO+psukMunZeHW5pTDq0p604WsiC
 gdiMfYtyGHvobbghR+khQiGXe78gy5ItUaCeIUfJdT58ntxKkEzfl8AOn6STv84LbgZw70Q
 Bvpwu/rgij0arTwh39cPjTcpbqDQ9KqQv8aXoMWqnUAbRfwraq2sMKlKH58jFJkY+eaIm2j
 N+aVjiysHOFD70QO+DrGiF5AhH4+QeCYb4clcnIXgGls78ojnzhWPRE0VAJPqDdlAInjd31
 M1y9HZK01WbuY/uPdKiA8Um4x4VQAqfCu+yA+VF6sFuKS+TheN31LRne6+56jfF53mN10Dk
 XO1vHaTUzPBpxpVI1+a3iMRXwFfNtYcHhlSeYSU/7YlGOyAwdODZn46JZOkE9fHwI3kgX4y
 aNWwceVGkcKHK+T6G4MTM0Tbre55RNqhNcCtR8L2RzIbuSwkq74I4n83s3e5xGn5nDXQyLc
 3Ytvock/aYVhCr7stvb5Ulrbvb/wNHi/8CwN+o72cs6QkBM4gZ8uPSQD+iRq6q8rzlYkE84
 hZi0Lur/tK3+G5U6apAgGarmXVypAF4OM00HJXwChFKrCQ27tK5X+SePDtS4OMfHnkm9Z+l
 VnrLW1uNq7okugICvimM8SrvkhYXWhGLVv/E3h8/XlPQD0jWo7o782TWpgdLcqfsIy6rlmf
 duuv28mgAFdcTZSut86aOV/VyqFADf/rLyPDMKzLMVZociQvH+c6iHhLfiLgiq0H+fSIv63
 +FYfu9VRVy2meeNMsAVhhiBHRh6T4hnOQa1/5yTPkIap1cw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Wed, 19 Nov 2025 05:47:22 +0100
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

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Some pmdomains rely on RK806 PMIC for power supply. If we don't
enable them in U-Boot, random panic may occur during the Kernel
boot process.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 configs/evb-rk3588_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index 5aaecebdafc..0ad60252b0d 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -51,6 +51,10 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_SPL_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
-- 
2.51.1

