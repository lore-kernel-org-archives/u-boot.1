Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7027CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A6786C96;
	Mon, 25 Sep 2023 15:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="heVP0M3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF57686C64; Mon, 25 Sep 2023 15:26:29 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88CB286BE8
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38PDQP5p111887;
 Mon, 25 Sep 2023 08:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695648385;
 bh=85fsfQUUumyw6ZI4x6oxtrV/pk35JV63oeGp1n3uSWY=;
 h=From:To:CC:Subject:Date;
 b=heVP0M3juuPiaruiFPe7lBG+kMASJqPdkO2ZDZGupX9D0gOLC8d/6y4GuU/U031mW
 fii7sC6eVdfiwzGbIiRTvDS1WU+UYgH+60vxQrJBqgZz2Mh7CDNcgkAfXHvB9f6C2p
 YQtmBfjuoI9xuk6qzjDoBy4FuYEaKjIm9P3ZLzJk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38PDQPXM035969
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Sep 2023 08:26:25 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 08:26:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 08:26:25 -0500
Received: from keerthy.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38PDQMsI023302; 
 Mon, 25 Sep 2023 08:26:23 -0500
From: Keerthy <j-keerthy@ti.com>
To: <trini@konsulko.com>
CC: <j-keerthy@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>
Subject: [PATCH 0/2] arm64: ti: k3-j7: Add the ESM nodes
Date: Mon, 25 Sep 2023 18:56:12 +0530
Message-ID: <20230925132614.3747-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

https://lore.kernel.org/linux-arm-kernel/5187c590-ee9a-4c46-b326-655f4c371aaf@linaro.org/T/#me178708007a6b3b9695ae0ff84475fa4f49f283c

I have posted the ESM patches to the linux kernel device tree mailing
list. These are neeeded in R5 SPL to enable watchdog support.


Keerthy (2):
  arm64: dts: ti: k3-j721s2: Add ESM instances
  arm64: dts: ti: k3-j7200: Add MCU domain ESM instance

 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi  |  7 +++++++
 arch/arm/dts/k3-j721s2-main.dtsi       |  7 +++++++
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi | 14 ++++++++++++++
 3 files changed, 28 insertions(+)

-- 
2.17.1

