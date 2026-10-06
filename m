Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A603CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 09:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAE9280B33;
	Tue,  6 Oct 2026 09:18:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id evPawDndalHT; Tue,  6 Oct 2026 09:18:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0260180AEF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791278328;
	b=POtXmgd8DFJpEuf4V9KmDgfxBkw0r4Wqq3qSxkDMx8Af4fCE1CLCeIoy5vnVbOgQbiho
	 FI+qC8PQm5m0/RCvgCuBp7DU84YjmWX7M+/wlnWcgx+pldJYPZnfj17zpGVBFg9PK1IEZ
	 NiqaOFVAEm4tpU74RwbUC30JrcBMB644IeD2N/CJPnLqBSeRLJ9Adx8t0OwQBCiHjgdZV
	 wA8F/MTGzv7C00JDhFaHeLSxqQX8x3LlUdVkuE2FJy8GtvTc0m2Cm6Od6nv5Q5BDfXzX+
	 4BEMXks+dNCFfTKfeJy/WxeTQ/JV0YRDKn3+CbVBxqBieIzeRPtBOjqtFiO7hbJny6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791278328;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hWt4qVhQP3GDUV5xUZ8HMv0gY0wC+/Ff+JoT93GB4xs=;
	b=HBDtbcMS5ECQkKcV53TN5sJ9MPQe4kfO9Fd70eDYo7bOixeYytyT4uwPkmrJ1uVdaJl8
	 ijMGsCiVyBBptEPJs8IzzMgB666S2ZKzas6bt5jXY2XPN155yn9GaQkYyCN8FFer5s9Bb
	 yet2F9cxqx+1BbAekUS2byT6hooQEkvjsQKq7rW6Q3Y6JNG1P7eL8VsD8PFMWspb7DaSz
	 tlkwvrzqo9jVnuZmxzoDBYen68G6+zmIsiIa4ABSuRs265Y3EJczg9JivRHRWIOC5oTaV
	 zZ2ir9BhSOVraexttrWt/nMfI5x2ap8YrO6dl5JUDBKek60ojpyj0TUnQTfX020SIJg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791278328;
	bh=hWt4qVhQP3GDUV5xUZ8HMv0gY0wC+/Ff+JoT93GB4xs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fa+8Qf68TjoapPtl5qB2IOLjZxk0eYXeZYA+JrpSpNOIcg3WxLg7WicrpY3BoW68J
	 NAbka1bV81SE6N5LWYpbYVgr+3VkaeTTgz+AYdS+yFSJtGbpjRbM6xyqphDpDCKaoO
	 0A8NGQpJ3dam2VDeFqODS778eNhG+HdhqrR8UcBHiol39CRuDEmMxLF9hf9XRR0838
	 f1FChtaKhaZx0iAbKV8Z+v4+StuwZiKzIbhN+woVKIDMaA8CnESpOCe8cdXMiJCnsC
	 1XS6W9GwBPemf9ifuq8ITQFQyJrg3kGDLGi7X2GxEcIQfRIUjI6xkJV5z/F0Dq8Ior
	 JqihgmlctITsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0260180AEF;
	Tue,  6 Oct 2026 09:18:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DAA275
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 138C26072F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tf8XIa6MzKZ9 for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 09:17:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8DC8B6071A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791278262;
 b=WUUjt1TYriv76+CVtQDIRi0n+D0g4JN0NP4CMyAhey6xKMwqTCzmJW7x7Jk2FK+LDtCK
 nWTRuO2WYYtbtGRoZ0CAE7IokKfqszrFbbUf8Wutkyvmwnmj0lnCCGaDiuRc+ngEOx6fG
 /9Wl9gjGuAsI2i0kYWv0kJQzMPbXSPGVTJzV6v0sBlyURBiHsauNIyIcuJ7wokl6ByZP7
 8t5vwiUL458S1IRWnf49nK5RW9iDdvksd34rDhm/o7z0SiGykEummp7nakEm6XTVUf1pE
 wX8VvWTTp/4NdZpfuOnuTdnEJn6xGxGCKDBzRgshpucR/SoesyeMoWfaIdfx7mMoZ/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791278262;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned:X-Virus-Status;
 bh=hWt4qVhQP3GDUV5xUZ8HMv0gY0wC+/Ff+JoT93GB4xs=;
 b=OmrdyHybGwnX5ekFH1pkXXx0UjJnI05Cdb6oT9OQTAH0/HiLeC3xNjlCsPT5R1gn1e0G
 cEAD5EbgHfyU2cDKfhI68R9hKUS+6KOqANkDawGO2jHQLYbvRyRSjBY4FJDh8iDscev0D
 /y19xrT7Cf+Pkk4gjD2OM/lvdDHUAa1fApK6p7jcf1Ra5qFaMTqzFsi1xB0kp/LDBD/RV
 8Lv+fFB7C8uYZHnkvVJ9dtHl5XU7fSOW9XkCDtujFgdFeCaULDJZf9pRxKxEdKh8uJvH1
 KabMjczVYCQNOyMMJB1T1DZSV6g0ZsGaWy6vwwWJTKMbLXEf0ra5myuNdOD2d28fTNA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=fail header.from=nxp.com; 
 spf=fail smtp.mailfrom=nxp.com;
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=elena.popa@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=nxp.com
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DC8B6071A
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:17:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12D4A847DA; Tue,  6 Oct 2026 11:17:39 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72219801E5
 for <u-boot@lists.denx.de>; Tue,  6 Oct 2026 11:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=elena.popa@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AC3FF1A0194;
 Tue,  6 Oct 2026 11:17:35 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A072F1A0220;
 Tue,  6 Oct 2026 11:17:35 +0200 (CEST)
Received: from lsv052348.swis.nl-cdc01.nxp.com
 (lsv052348.swis.nl-cdc01.nxp.com [10.168.26.87])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id AAC5820328;
 Tue,  6 Oct 2026 11:17:34 +0200 (CEST)
From: Elena Popa <elena.popa@nxp.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com,
 peng.fan@nxp.com, ilias.apalodimas@linaro.org
Cc: laurentiu.mihalcea@nxp.com, cosmin.stoica@nxp.com,
 Elena Popa <elena.popa@nxp.com>
Subject: [PATCH v2 0/2] Add support for the NXP MR-NAVQ95 board
Date: Tue,  6 Oct 2026 11:17:00 +0200
Message-ID: <20261006091716.487384-1-elena.popa@nxp.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

Changes in v2:
- update the DTS to match the version merged upstream in linux-next

Elena Popa (2):
  board: nxp: add MR-NAVQ95 board support
  arm64: dts: freescale: add the MR-NAVQ95 DTS

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

