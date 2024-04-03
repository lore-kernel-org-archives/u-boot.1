Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993E3CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 13:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0DAA881E5;
	Wed,  3 Apr 2024 15:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="IqVQL81x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E58B881BE; Wed,  3 Apr 2024 15:59:21 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FC9A881F7
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 15:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1712152759; x=1714744759;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h6JtQo4BtSnkYbu3H8Vs2PyS0NYhHSO8DtTTr8A8MGg=;
 b=IqVQL81x8TgFtv+Ru6ArJOx5s1RHACbivrexBCoAlxscSuSWbKQg60MeaTJwy9wP
 y6+eO99ffG2OcDIyCD6jFng9bXRsM+p+6j7SohDtTNMBU41jipnKTdUf8z+NiFEa
 IerAe8NrCgwjXCVmRRpJKriEERuyUOR9TKYZuavat6I=;
X-AuditID: ac14000a-fadff7000000290d-fe-660d60b7b35d
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id EB.D4.10509.7B06D066;
 Wed,  3 Apr 2024 15:59:19 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Apr 2024
 15:59:18 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <nm@ti.com>, <upstream@lists.phytec.de>, <bb@ti.com>, <vigneshr@ti.com>
Subject: [PATCH v2 0/3] *** Introduce get_boot_device() for K3 platform ***
Date: Wed, 3 Apr 2024 15:59:08 +0200
Message-ID: <20240403135911.1987293-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWyRpKBR3d7Am+awd4zPBZz3xxgtXjz4yyT
 xdu9newW3e/ULf6f/cDuwOpx9s4ORo/+7hZWj+M3tjMFMEdx2aSk5mSWpRbp2yVwZTy8tJu9
 4D1XxbkTv9gaGPdwdDFycEgImEjM+RnZxcjFISSwhEni9YUTjBDOI0aJDa9WAjmcHGwC6hJ3
 NnxjBbFFBKQkXnZuZAZpZhbwlrg7jQ0kLAxk/r/ynwkkzCKgIvFujipImFfAUuLWp+fMILaE
 gLzEzEvf2SHighInZz5hAbGZgeLNW2czQ9gSEgdfvACzhYDiLy4tZ4HpnXbuNdScUImtX7Yz
 TWAUmIVk1Cwko2YhGbWAkXkVo1BuZnJ2alFmtl5BRmVJarJeSuomRlDIijBw7WDsm+NxiJGJ
 g/EQowQHs5IIb7cDb5oQb0piZVVqUX58UWlOavEhRmkOFiVx3tUdwalCAumJJanZqakFqUUw
 WSYOTqkGRhEzt5+r1tWuE3hmv1VW1H/3gjVGbU9eu8/vuzyry8/zAtfbe19e/f8uVpx1gP9e
 f0ZFgZfEvQBVcZt+JofFiZaHz7mKGnPmhNful9izndmMxdzxxPHbARkPOqb/1lc7IP7ZNplf
 7PMFw2UXg0oaBThjlF/InU22kc3afaj4c752QX782c9TlViKMxINtZiLihMB/PqaSUcCAAA=
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

It is handy to have some u-boot environment variables set based on
the current booting device.
Provide a way to obtain the boot device for non SPLs by factoring out
spl_boot_device() into an own function get_boot_device().

v2:
  - Relocate bootindex to OCRAM, drop misleading comments and remove not needed changes
  - Make get_boot_device() read bootindex out of OCRAM
  - Add user for get_boot_device(), patch 3

v1: https://lists.denx.de/pipermail/u-boot/2024-February/546770.html

Wadim Egorov (3):
  arm: mach-k3: am625: copy bootindex to OCRAM for main domain SPL
  arm: mach-k3: am625: Provide a way to obtain boot device for non SPLs
  board: phycore-am62x: Extend for better environment handling

 arch/arm/mach-k3/Makefile                     |   1 +
 arch/arm/mach-k3/am625_init.c                 | 103 ++----------------
 arch/arm/mach-k3/am62x/Makefile               |   2 +
 arch/arm/mach-k3/am62x/boot.c                 | 103 ++++++++++++++++++
 arch/arm/mach-k3/include/mach/am62_hardware.h |   1 +
 arch/arm/mach-k3/include/mach/hardware.h      |   1 +
 board/phytec/phycore_am62x/phycore-am62x.c    |  64 +++++++++++
 configs/phycore_am62x_a53_defconfig           |   1 +
 8 files changed, 182 insertions(+), 94 deletions(-)
 create mode 100644 arch/arm/mach-k3/am62x/Makefile
 create mode 100644 arch/arm/mach-k3/am62x/boot.c

-- 
2.34.1

