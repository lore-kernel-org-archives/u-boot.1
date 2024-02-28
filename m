Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F4EC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 10:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 096D788023;
	Wed, 28 Feb 2024 11:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kpr3HVTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C86987FEB; Wed, 28 Feb 2024 11:36:08 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E631E8800C
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 11:36:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6485F6175D;
 Wed, 28 Feb 2024 10:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3574AC433F1;
 Wed, 28 Feb 2024 10:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709116562;
 bh=JxQDVWh/sj8yOIj4Ue6SHLwqbiRLOv2YQtOnWc1+rvA=;
 h=From:Subject:Date:To:Cc:From;
 b=Kpr3HVThtI0OFIpBjS3q+5tQQr5Q4dmaWcphX/bIX3a/WQXljDro7E/52Gm68ky4e
 XAIbc9/mlBlPpo18BDho0UWUomdX/ogWGSUYm/X6ofBhMVtK2aVSPnMJ7Lu53a0+ak
 5Y0ytJ22b9lgLzi7DSXoDD6dA6btZdvdGDb9A6x9+JN13nkcYh1p8w9TiezVFe+kKd
 /26FGUPNZzFp4hr2DaAr7IZgfzB0VnIeCrQJNVf8V0EZysX8+oHqHXSjWghphWIfWr
 rOE0yqse1a8A0RSdfJQacVGb5ybfe9qEX0ywA1X90k0ybCBiB4zG9JX0wdj9o6ZQ6e
 LAwcprg2XXuEw==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/2] net: ti: am65-cpsw / cpsw-mdio: Switch to DM MDIO
Date: Wed, 28 Feb 2024 12:35:25 +0200
Message-Id: <20240228-for-2024-07-am65-cpsw-mdio-v2-0-f74f972eafeb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG0M32UC/33Nyw6CMBCF4Vchs3ZMW7mIK9/DsCgwwERpydSgh
 vDuFhK3Lr+z+M8CgYQpwCVZQGjmwN5FmEMCzWBdT8htNBhlUmV0jp0X3ICqQDvmGTZTeOHYskc
 6NTqrTVmkqYEYmIQ6fu/xWxU9cHh6+exfs97WX7b8l501KrQdldbWNjsrfb2TOHocvfRQrev6B
 fXE9DfFAAAA
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 nm@ti.com
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, mripard@kernel.org, 
 dannenberg@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com, 
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=JxQDVWh/sj8yOIj4Ue6SHLwqbiRLOv2YQtOnWc1+rvA=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl3wyKPxV0lzJNMfpBCgb6ScDhCaL7BWXQ5/QCz
 W+7dOpMC6OJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZd8MigAKCRDSWmvTvnYw
 k57nD/4q7MYx9Fi7JS3qvofIwcUyq/qXQ5axdAe+YDXhun3zel0KxoXIiho/G4ttHUUVu2pgUb6
 D9rxWU+w1tqaznoiC1zHEWG7hbS04bagf16UwfQ6Tz+SXsUAEuu43HkEj4aLBEUZZQKqqwew0gR
 //2N7Kp+moD3cgjybASpbAOJ47eUAuml7oe0z6+2QBEtQKYpR6QtueZnWRWzyhaa+U07Nf5iUtf
 U+KhsdK5u5nwjLs7zmsx8tIz9q0t20AZYooPoH68pQFUqvqMOhG6g0zlyKZ17+CH0vTNW9ZCmaX
 mRspCN7Q6RW+zCC++0d1fcz4a9nJJa50fzh8/LSeM9HNs2/rLky+Ps2BnQxX7nkM12AbKzImO57
 60KSeE7NZTe6YdRalus/rkacOwucttXanHUtADAQd96+FvGYWCiNfeQuMMqAt0kaofZb6XVukg/
 tvA4srWi3tQsO/tH8V6+QICx8+W69qu7PP3IjTxveANh1oyKMHrN0YHU96x2UPpy6v+mglRJHFl
 D4qaocu3mvzHNsRcdyiiQdtygnD2JIGunRye06//IzH6kfBk87hJ3f9ZnDPgjRcD/pdOEWRxidh
 jBmf/X34mHcV8CzClhRdscOIsrdcIxXEyWo4UmTdhqP8Mb6AZTSq1S2EB0E7cuVPtP/hv0Bt7XJ
 9jI/NH0F/wR+4nA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

Hi,

This converts cpsw-mdio into a proper Driver Model
driver and introduces the new Config symbol CONFIG_MDIO_TI_CPSW.

It also cleans up the am65-cpsw driver so it porperly uses
the DM PHY interface.

It does not convert the legacy cpsw and keystone-net drivers.

Tested on SK-AM62, SK-AM64, j721e_beagleboneai64 and AM335x BeagleBone.

CI tests: https://github.com/u-boot/u-boot/pull/493

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changes in v2:
- Fix build if DM_GPIO not set.
- Fix build on platforms that don't define <asm/gpio.h>
- Link to v1: https://lore.kernel.org/r/20240219-for-2024-07-am65-cpsw-mdio-v1-0-afe9aaba5801@kernel.org

---
Roger Quadros (2):
      net: mdio: Handle bus level GPIO Reset
      net: am65-cpsw: cpsw_mdio: Switch to proper DM_MDIO framework

 drivers/net/ti/Kconfig          |   8 ++
 drivers/net/ti/Makefile         |   3 +-
 drivers/net/ti/am65-cpsw-nuss.c | 190 ++------------------------------------
 drivers/net/ti/cpsw_mdio.c      | 198 +++++++++++++++++++++++++++++++++++-----
 drivers/net/ti/cpsw_mdio.h      |   2 +
 include/phy.h                   |   7 ++
 net/mdio-uclass.c               |  37 +++++++-
 7 files changed, 239 insertions(+), 206 deletions(-)
---
base-commit: d49fa3defa50c6d3f04acbb52fd486c13c14ab6a
change-id: 20240216-for-2024-07-am65-cpsw-mdio-e3c15b297442

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>

