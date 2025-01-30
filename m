Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD88C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 22:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01AD08214F;
	Thu, 30 Jan 2025 23:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gY8Oi4dK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F5A880F0E; Thu, 30 Jan 2025 23:33:03 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D7A480EFB
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 23:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50UMWvFM1557746
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jan 2025 16:32:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738276377;
 bh=p3AFGoc5fe2qYWHEDPUd+BcSKQF1xusB4Jx2flwOT4g=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gY8Oi4dKJveXj/sAhNOamuUK+PqbPAJ4QSv4c48+Tlh3FYLhH8A0PwuoABC+K3OoZ
 VtlvOmOJ/TI4EurEJJ8UN5OB+ZXxuS7QZKKhDJO+RCtiBKOe0Nh01orR2E8cm3Q7TO
 XU56iEuMzK8MOFIJs5cudRcNhi9stt2OkAXC6LqA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50UMWvCk017661
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jan 2025 16:32:57 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 Jan 2025 16:32:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 Jan 2025 16:32:57 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50UMWuHm029547;
 Thu, 30 Jan 2025 16:32:57 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, Daniel Schultz
 <d.schultz@phytec.de>, Judith Mendez <jm@ti.com>
Subject: [PATCH v3 4/4] configs: am64x_evm_a53_defconfig: Enable R5F and M4
 remote proc support
Date: Thu, 30 Jan 2025 16:32:56 -0600
Message-ID: <20250130223256.1944522-5-jm@ti.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250130223256.1944522-1-jm@ti.com>
References: <20250130223256.1944522-1-jm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

From: Hari Nagalla <hnagalla@ti.com>

Add support for R5F and M4 remoteproc drivers.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
Changes since v2:
- No change
---
 configs/am64x_evm_a53_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index a501f3f567e..3036b427974 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -151,6 +151,8 @@ CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_REMOTEPROC_TI_PRU=y
 CONFIG_CMD_REMOTEPROC=y
+CONFIG_REMOTEPROC_TI_K3_R5F=y
+CONFIG_REMOTEPROC_TI_K3_M4F=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
-- 
2.48.0

