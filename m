Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A43CC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 11:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B8EC886F0;
	Mon,  8 Jul 2024 13:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pGqEXunE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6412886F0; Mon,  8 Jul 2024 13:51:11 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 724518862E
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 13:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 468Bp5jY069706;
 Mon, 8 Jul 2024 06:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720439465;
 bh=zIIRLRVSGI5VkVlalOslN29Ug7uRwymkMRcBESuV2wA=;
 h=From:Date:Subject:To:CC;
 b=pGqEXunEpQUkJPUVWwjCSts7xZLBNfNbvxqplN82ulsKOt61NAfIEFfGAC0fm2ZqM
 e5ce6ee3kSSXT/CzJmqm7K8FZK+g9oan0CAN4aLmWi21WhUdEAEFvcXC6LkAHWGe9G
 Dnsy8JtmJOyPv5pHeLSQBHMmqLKtcDzHEfkYhhvE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 468Bp5i5043432
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jul 2024 06:51:05 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jul 2024 06:51:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jul 2024 06:51:04 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 468Bp4Kv084798;
 Mon, 8 Jul 2024 06:51:04 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
Date: Mon, 8 Jul 2024 17:20:40 +0530
Subject: [PATCH] configs: am62x_evm_a53_defconfig: Remove CONFIG_SYS_BOOTM_LEN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240708-remove-bootm-len-v1-1-2a537061426c@ti.com>
X-B4-Tracking: v=1; b=H4sIAI/Si2YC/x2NzQrCMBAGX6Xs2YVYY/x5FfGQ1E+7YBLZLUUof
 XdTj8MwzEIGFRhdu4UUs5jU0mC/62gYY3mB5dGYetd7d3JnVuQ6g1OtU+Y3Csfk4YM7XMIxUMt
 StKY1lmHcwhxtgm7io3jK9/+63df1B2JOXPx7AAAA
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <praneeth@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720439463; l=1150;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=/0l8Xr/zMg5u0X/dem7Frdphr8VfV4Mn1GxPJJH5yxU=;
 b=rDcBa4BiAivdJ7eEUYk1WOQY6SscANSD3OG8nGBhyxlh7TqTGv52s9yE/ixZo/jRJHCroSIqR
 CQdO0uphtdQBRCCQ98S9e+PEJTulXpNYEAZlZcOKyDu86I8YWhURKIH
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
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

Increase the maximum size of the buffer that is used to decompress
the OS image in to.

If image size is greater than the buffer, boot
will fail with following error,
"Error: inflate() returned -5"
"gzip compressed: uncompress error -1"

Default limit for ARM64 platforms is 0x4000000, remove
CONFIG_SYS_BOOTM_LEN=0x8000000, so that it follows default limit.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 configs/am62x_evm_a53_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index ca993b427b..dfa5ecc847 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -32,7 +32,6 @@ CONFIG_SPL_SPI=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
-CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_BOOTCOMMAND="run findfdt; run envboot; bootflow scan -lb"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000

---
base-commit: fd46ea0e701920eb205c2bce9d527bf0dec10b59
change-id: 20240708-remove-bootm-len-ab4e46039656

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>

