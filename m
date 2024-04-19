Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8496AC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 06:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85679885E0;
	Fri, 19 Apr 2024 08:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZYrGr6V0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D12B88648; Fri, 19 Apr 2024 08:51:31 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F8EF885D7
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 08:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713509488; x=1716101488;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t1u+DjtY8HoGmibKfANZlymgQKu3Rs5CeSroO+W/CpA=;
 b=ZYrGr6V0tsW6S3RkGJCq9zIi0etyAf0WrVbapk+DrOlJAH6whQ15juiWadn5nscq
 2HslXvmjb/66VBS+EYWCG/7tePhf883xsXzuHTyzeg/utsQQGPXiKt59j1PP/5mI
 /ufnOIY5KJugJpFftBMres/IWoqiXvIljVswXDNWa5c=;
X-AuditID: ac14000a-fbefe7000000290d-75-66221470466f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 2B.95.10509.07412266;
 Fri, 19 Apr 2024 08:51:28 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 19 Apr
 2024 08:51:28 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>
Subject: [PATCH 0/3] *** Migrate some PHYTEC boards to OF_UPSTREAM ***
Date: Fri, 19 Apr 2024 08:51:14 +0200
Message-ID: <20240419065117.2305346-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWyRpKBR7dARCnNYNtuPYu3ezvZLbrfqTsw
 eZy9s4PRo7+7hTWAKYrLJiU1J7MstUjfLoEr49CFTWwF63gr1kw/z9bAuI+ri5GTQ0LAROLu
 xk/sILaQwBImibnvaroYuYDsx4wS7xpes4Ak2ATUJe5s+MYKYosISEm87NzI3MXIwcEsICex
 rL8IJCws4CYxc95eJpAwi4CqxKNtWiBhXgFLib6pt5ggVslLzLz0nR0iLihxcuYTsOnMQPHm
 rbOZIWwJiYMvXjBDnCMv8eLSchaY3mnnXjND2KESW79sZ5rAKDALyahZSEbNQjJqASPzKkah
 3Mzk7NSizGy9gozKktRkvZTUTYygUBRh4NrB2DfH4xAjEwfjIUYJDmYlEV4zDsU0Id6UxMqq
 1KL8+KLSnNTiQ4zSHCxK4ryrO4JThQTSE0tSs1NTC1KLYLJMHJxSDYwzNjTU/rj5t6541YMs
 I23Rn6LH3t5iTJnmUlXx+u7BSQJ/+Tok8hfJRme1P2BL6PSavGGq/419ellWb3YkPOe+eyxL
 cafrjFMcz35d+PB2Q73agtfnlLnOKyrLqxkuee6+W0D67aSLV7mWchy7/OCz1NI9B9fnvLX2
 brjccFf5Def8E9LXzOc9V2Ipzkg01GIuKk4EAA99aBQzAgAA
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

Migrate the boards I maintain to OF_UPSTREAM.

Wadim Egorov (3):
  phycore-am62x: Migrate to OF_UPSTREAM
  phycore-am64x: Migrate to OF_UPSTREAM
  phycore-rk3288: Migrate to OF_UPSTREAM

 arch/arm/dts/Makefile                         |   3 -
 arch/arm/dts/k3-am62-phycore-som.dtsi         | 324 -----------
 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts   | 266 ---------
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi |   2 +-
 arch/arm/dts/k3-am64-phycore-som.dtsi         | 320 -----------
 .../arm/dts/k3-am642-phyboard-electra-rdk.dts | 302 -----------
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi |   6 +-
 arch/arm/dts/rk3288-phycore-rdk-u-boot.dtsi   |  19 +
 arch/arm/dts/rk3288-phycore-rdk.dts           | 271 ----------
 arch/arm/dts/rk3288-phycore-som.dtsi          | 506 ------------------
 arch/arm/mach-k3/am62x/Kconfig                |   1 +
 arch/arm/mach-k3/am64x/Kconfig                |   1 +
 board/phytec/phycore_am62x/MAINTAINERS        |   2 -
 board/phytec/phycore_am64x/MAINTAINERS        |   2 -
 board/phytec/phycore_rk3288/MAINTAINERS       |   2 -
 configs/phycore-rk3288_defconfig              |   7 +-
 configs/phycore_am62x_a53_defconfig           |   2 +-
 configs/phycore_am64x_a53_defconfig           |   2 +-
 18 files changed, 29 insertions(+), 2009 deletions(-)
 delete mode 100644 arch/arm/dts/k3-am62-phycore-som.dtsi
 delete mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
 delete mode 100644 arch/arm/dts/k3-am64-phycore-som.dtsi
 delete mode 100644 arch/arm/dts/k3-am642-phyboard-electra-rdk.dts
 delete mode 100644 arch/arm/dts/rk3288-phycore-rdk.dts
 delete mode 100644 arch/arm/dts/rk3288-phycore-som.dtsi

-- 
2.25.1

