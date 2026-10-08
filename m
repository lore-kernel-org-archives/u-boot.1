Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13D4CA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 07:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4812A6078E;
	Thu,  8 Oct 2026 07:30:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvlmPZF_HplO; Thu,  8 Oct 2026 07:30:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8385C606FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791444627;
	b=jekKbFV5pE9BEL4pBkAybhB4SnQKxZB945w65S8ecHVM+S3rS5MOIkwSvVASqz81h5b5
	 MLp1HED5UBkNKDsvmxhDyVPHxn2E27iRjpNIYVH8xzTysAt8JnW3pyrxpjnB9QxuqdJC7
	 fx/6SG50CgJ/HW0UM0U6XXiwllUo+MrOt114pEiBh95hQtW76Q0qcCLDgkc6QiXRPs78J
	 2454sHhUFNn2d/fOQtwmXiyJpO8qGd8qbXjZhtWI0uycu456zs5sgYMziXYIsvkHvLM+B
	 XQPRgRLwEPotga61tcYtg9rcO4KthanTmrT8rhyA5Z6tev5lXzXkugJe5JsnISp7ApA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791444627;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5Iog8Ye8wpYNWucooszlYlOJprXc/H0Sa9MwDbM0n4s=;
	b=ZlHz+ez2tlyaJKBbuzj4AGK+lnWwJvzuGrWunZAsNSO2peXqWM7brwbSpbAEZweSz47+
	 yeNaiZfTOAbV1xnEqHcBflM7/n7iY5jVz1Vriw4JvfacJ/Zl2FvuW/c0RfGqdM+ID/4wF
	 FChWGAn2YJEatVFs21NoVfGEDIY3/g4u3VZK9z4xZyfq6GgiIxPnnIpYMg0tvT0dgS39I
	 XnscFrLge1qaZ7aTeKOLIMh8sBaXGnhUDO6UelCU2ng0aUU5t8ThICH+5PH4TKL3Ge+bL
	 xbl6uRWV2QPyi80YCbwit0f2e0XXmIVn1/oQEGiyJn98Y6kANk885d2JuQHwozm9uvA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=nxp.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791444627;
	bh=5Iog8Ye8wpYNWucooszlYlOJprXc/H0Sa9MwDbM0n4s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F6dHYcSTThT8uzced8c/8fN66xTnq/k23VhCsPZKfW6OeZiloQ+sWVb9ZYTTX33wo
	 lrTAoHLmjecj5BTJj20gF+kflIDOECszvd0zEqYho9r+dovbfjTY17EPsPwDMdctFa
	 SrE8DPV5ycTUCcEyipu2Z8udhOGIZKIPEPDHgka2GYQsGk51Ss55a+ommHUCroZ85e
	 dYqypsIlleBVVVBb2Jzrxy2YQz5RBqvu2CiPD71Arnsu/gAAnP8QOX2frdQwOjHnCF
	 HoIS2w654g9M00Wp6+5GGMq88m3PCmRqSXSoW0MP9EAqR7NivahxLlaqrMvmo4pd6I
	 iP2AzjSNUKsrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8385C606FF;
	Thu,  8 Oct 2026 07:30:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C1C3C150D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B34086076D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:30:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 58AvgxuAzoUa for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 07:30:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AA1AF60672
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791444625;
 b=EZBOikklyF+RnZwhRN5JhOUuCOtSaVrQwOrbZ004mpLGsj4i7IJChy/A40Y/Ayj1ZaEa
 bY/XPmNXDqkFWtj7F5sB2+cdQCvHV0hTi1aBpIlshgCNWk9tyqxUWywC19Bk+KOIlCkFi
 MAq6gLXrRgl6eM07nnW4LESz9bxl45IWNE0hgyzAFarZdnyd3dMszZKE3RpAjJ9YU4PuI
 CdI+yPSbTiWvFm3HMvQ/NiuFXZ8ScY9+U/DRqiUJHfzW78+Cy5ouu7FF04bVYizSoqqDO
 qNPzGIkwTFDQETU61ujUlRtIaHWzqzYpypQg3yJjFkcW1u1LkRKG/YWtSE+XO4nZbQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791444625;
 h=Received-SPF:Received:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned;
 bh=5Iog8Ye8wpYNWucooszlYlOJprXc/H0Sa9MwDbM0n4s=;
 b=rjFPZO0UL7LYVIXXtrPU6LBAaLccjgroTy0Oz4Jsjfsh93UxQ4dpOe2BMmgNQlVOXzLp
 R8m69YwpHorTB4c2EGl+2Zhq8PZAqCAXBUUkP39kCf+k44rvDZvcvePmVWqj2PdXQQvI3
 rUyFT0fMqDE8c8P1bW227Xc+4LDwoaw/YuDxaFE1R0cTe/xr3U4Wf2pPw4wxY0HwHgqM3
 5fH4K2iZO5lLJvZtiWZmXPiRV+6npVxwk2eJBnkapC054lz+3MtmQ1k5nZPUsIn8eGimN
 Vy3LS9uGZj4pu/AyQS11MxzkyAt4e/GEV/OICqLOzeGAnSX8tZLHckJMvpWLg8iKDRA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 arc=none smtp.remote-ip=92.121.34.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=92.121.34.21;
 helo=inva021.nxp.com; envelope-from=elena.popa@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA1AF60672
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:30:23 +0000 (UTC)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D84CE20024B;
 Thu,  8 Oct 2026 09:30:21 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C8A07200249;
 Thu,  8 Oct 2026 09:30:21 +0200 (CEST)
Received: from lsv052348.swis.nl-cdc01.nxp.com
 (lsv052348.swis.nl-cdc01.nxp.com [10.168.26.87])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 39097203CB;
 Thu,  8 Oct 2026 09:30:21 +0200 (CEST)
From: Elena Popa <elena.popa@nxp.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com,
 peng.fan@nxp.com, ilias.apalodimas@linaro.org
Cc: laurentiu.mihalcea@nxp.com, cosmin.stoica@nxp.com,
 Elena Popa <elena.popa@nxp.com>
Subject: [PATCH v3 0/2] Add support for the NXP MR-NAVQ95 board
Date: Thu,  8 Oct 2026 09:29:54 +0200
Message-ID: <20261008073014.1184539-1-elena.popa@nxp.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series adds initial U-Boot support for the MR-NAVQ95 board, an i.MX
95-based platform from NXP designed for robotics and edge AI
applications.

Changes in v3:
- reorder patches to place the DTS patch before board support
- fix RST section underline lengths to match their titles
- correct System Manager toolchain version typo (1.5.3.rel1 -> 15.3.rel1)
- update System Manager configuration name from mx95navq to mr-navq95

Changes in v2:
- update the DTS to match the version merged upstream in linux-next

Elena Popa (2):
  arm64: dts: freescale: add the MR-NAVQ95 DTS
  board: nxp: add MR-NAVQ95 board support

 arch/arm/dts/imx95-navq-u-boot.dtsi |   6 +
 arch/arm/dts/imx95-navq.dts         | 228 ++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig      |   8 +
 board/nxp/imx95_navq/Kconfig        |  12 ++
 board/nxp/imx95_navq/MAINTAINERS    |   6 +
 board/nxp/imx95_navq/Makefile       |  11 ++
 board/nxp/imx95_navq/imx95_navq.c   |  24 +++
 board/nxp/imx95_navq/imx95_navq.env |  94 ++++++++++++
 board/nxp/imx95_navq/spl.c          |  82 ++++++++++
 configs/imx95_navq.config           | 154 +++++++++++++++++++
 configs/imx95_navq_defconfig        |   1 +
 doc/board/nxp/imx95_navq.rst        | 117 ++++++++++++++
 doc/board/nxp/index.rst             |   1 +
 include/configs/imx95_navq.h        |  22 +++
 14 files changed, 766 insertions(+)
 create mode 100644 arch/arm/dts/imx95-navq-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-navq.dts
 create mode 100644 board/nxp/imx95_navq/Kconfig
 create mode 100644 board/nxp/imx95_navq/MAINTAINERS
 create mode 100644 board/nxp/imx95_navq/Makefile
 create mode 100644 board/nxp/imx95_navq/imx95_navq.c
 create mode 100644 board/nxp/imx95_navq/imx95_navq.env
 create mode 100644 board/nxp/imx95_navq/spl.c
 create mode 100644 configs/imx95_navq.config
 create mode 100644 configs/imx95_navq_defconfig
 create mode 100644 doc/board/nxp/imx95_navq.rst
 create mode 100644 include/configs/imx95_navq.h

-- 
2.43.0

