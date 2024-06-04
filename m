Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66285C25B74
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 06:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66598844C;
	Tue,  4 Jun 2024 08:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G3j/85h+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EAFB88418; Tue,  4 Jun 2024 08:09:34 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 862F088458
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 08:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45469The008288;
 Tue, 4 Jun 2024 01:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717481370;
 bh=WfbDZLTv3e8F7qlmjZhOZ2bbK099eKFdBgQ6SHlBILI=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=G3j/85h+szmLn5A8uWVY6i131ZyMEBJBp2M7t2NJnhStiEUBlaYuLuTvcetufJPJm
 y0aVrSwi74CgEQTijqF/VU9eA4kYjp1muir2B/b0U+7U+erppdqa5jgOgkLD0T3IKx
 uFcUy/pWSXgscz19Q/l+HLiOvuGpfAQRO+qkcAeY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45469TuJ008567
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Jun 2024 01:09:29 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 01:09:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 01:09:29 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45469BfH022510;
 Tue, 4 Jun 2024 01:09:26 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 4 Jun 2024 11:39:13 +0530
Subject: [PATCH v3 4/4] configs: j721s2_evm_*_defconfig: Enable OSPI
 configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240604-b4-upstream-j721s2-ospi-support-v3-4-738aa77d9202@ti.com>
References: <20240604-b4-upstream-j721s2-ospi-support-v3-0-738aa77d9202@ti.com>
In-Reply-To: <20240604-b4-upstream-j721s2-ospi-support-v3-0-738aa77d9202@ti.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, "Tom
 Rini" <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>, Jon Humphreys <j-humphreys@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717481351; l=1209;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=TWkLdsu3ppSWKXBsx2H62afdyCbR4bM5Fr4HkL6DgkE=;
 b=cES6KGXRzQ36NU//5xnRx3QlMVDrcAzPBRoWFFEvXcpM5byGuXyALK/nGRVRqJIqLkiLc2dJB
 MSYfh2MtEQnCWg2u/pD+6NfumqK0ZRQw4GyfBx+kGpRlVFPLsLlnAw1
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Enable OSPI related configs to boot using OSPI

Reviewed-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 configs/j721s2_evm_a72_defconfig | 1 +
 configs/j721s2_evm_r5_defconfig  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 5ed8d00662e3..5c3b52baaee7 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -10,6 +10,7 @@ CONFIG_SOC_K3_J721S2=y
 CONFIG_TARGET_J721S2_A72_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
+CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 3c958cafbe8f..7413ddd08106 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -10,6 +10,7 @@ CONFIG_K3_EARLY_CONS=y
 CONFIG_TARGET_J721S2_R5_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x41c76000
+CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y

-- 
2.45.1

