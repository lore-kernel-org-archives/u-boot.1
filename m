Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF30CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C29F80D0F;
	Thu,  8 Oct 2026 12:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5fEWT4dEv6uh; Thu,  8 Oct 2026 12:52:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D935780DE1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463935;
	b=drcSdiZeJpepsYHHWJq7clU+ZOFemeJk1zQI5hlLn3bFETbT/9xkx+TdJ80eiOWl6eBT
	 aUgojHPJaEkSWMVYEtNskhiMD4P7hPwG6b0oUeoDYJiF0ni5P5Av9m7YPPqwwMDyHt4l5
	 bL4gqtEphrzy721uC0+Ys48XOQ8VVSNWJMGHh7IUWxodPvY/DaOvjbKpCrxi8fcIJFdKA
	 DOTEGYx4f6uXZWcy+KMZltA/GkmBll/pLJe/m3EyCJJuYzKmrycBvKoDG6gpA6DQ8+fPZ
	 dTi4/q6TYIihu57aOcbHULtoDY7t702gZ5SOQLt1zienj/oub2GlxGbi/6DlJ8UrFBA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463935;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nTXcmzNykoHxhi/QcJDSuvpVWWjGqe3eRdhbUbLnB0M=;
	b=j+5Rgn0bvccM9P8LWTfOw+T18XcX/4emuraiX5WJDnWDBDZ7w4IqixPyt4yinYgIsiOx
	 V7O2XlTbOiyAgwI8QW/VF2vY/jmten0Z3gWPu34VVxm9SOYqeppAV35asjt/jTHb2ot/6
	 c+uBteUlI59LjS3oPPPh8/SiVpdmlFioXZbE4N7fWRtUz9RoGJLimph8L2fHIA5eZnFRt
	 8kwyGczV9bjXkShsofwUqbb8od2xwmibkwG2+wXhwspuri+4nJtQ1Ghrybrsq368w9Ozq
	 XlGxv+JvMmOWRilYmnAZ7RhTgm7KTwNUK7S9ezKM2vlUh5xq3EbCRMrTyMcLH08osMQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463935;
	bh=nTXcmzNykoHxhi/QcJDSuvpVWWjGqe3eRdhbUbLnB0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=01OloZ1CErmeDL9a1X14btqWvvnKB+jhpPis5OHsE/CYIXv5sMj6MJLqedaRBKYDb
	 BBffN1/rANABrVk+tFNgtDmaNhc8Dor5ktzpUs2RhmvTLHMIIMZSTnrU2I+6W2RC+z
	 qo/xuGwMZ8zI5+pC0Db36FTDp2qByKcE+FOcG9tSwQyEaYDgAslylVFEaXJShhO5bV
	 O1J1Wx/Ibx3GbQxyFaUyeTb9GihCwlI1csVahs1c7gglKwdHQ6btaZpg6M0bJVvpwm
	 BW7kYfpd7Hq2VdEzzm4bFLt39VLN8hB5tcOJfcnLL+QOT00YPNxAVnnXmOdR7Kxmiu
	 dsBqCgoVc/07g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D935780DE1;
	Thu,  8 Oct 2026 12:52:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D0F011D2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 968B540A93
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:41:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kJfb82Sz5T_V for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 11:41:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BA5A540A8E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791459709;
 b=bkXQ/yxyifHhPLS/uOilxsrbiV3N1AGK/5N7vgDxcj2o8fDFqH7HSrOFWyTaY2pmIzAa
 P/MBGAmgaUBF6WiGxg7E0W90GwoGuJnXt/Hu2ORfDTvanIk8nzNiq+LR3Puq+ZinFJg5X
 0j5eE+OtUdxjkmAWx2QvNXNB254uJxzaORdZG70O63RA/H5NldW47TQ+feaHsD/SDbmOZ
 ntW41Ve/4S0XZR+0TiqzlawTPKn7HtprPBnn70prMbY0/qZiQlqlhgyEiDEkRDl7jlvUA
 RptPuAWegQotRC6kXQgR6bco2PYAt9vS9INDZPiF3jr3FAh/ENZi4/fetO8ij4L5/lA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791459709;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=nTXcmzNykoHxhi/QcJDSuvpVWWjGqe3eRdhbUbLnB0M=;
 b=hGOUQz9UAaaO+zTgkzvB3a1ovKUW4bFvIDaVUaJaQ6VauUgd7Iw9NvBnd+i84cf8e2I5
 hDM+fgpHPI07zcuBvwIKRhQC4iMTLcY0RmtAcC2bJbij+nWm4idSiAnNV8xPTg7B/LDPG
 NEBHeJSn/WuBgPPRrgDNlPnmeWUEeGJL7nhIraW188oXSVdo7vrtjHntTItU6bCYEAHoq
 I4eqjhMFyLapLBk9Llj7Ryl6IwynwlTgHwKwGuEbtZPUqXCu0/CcFe6BRR/zHWhVGu/n+
 F3J0Z8Sm6a6IP37efu4dgBW/+E/kZvQescTkHfLsV0bbuNz6zADI3BeGHPrPIjbApNw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=bLJyR8jg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=bLJyR8jg
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA5A540A8E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791459626; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Fb0Dbe/TrJ781RZ4nNRihCW6+VY1fhjnSVF3IcMjFY4YmncETbh7HKp+kQlbnN9Edws4k39KNPYv7pihtstl6gTMe1JTib0qS7FmOoWMeAdlK4yPWYOEt9S3a7/O4H+p0sOI0zkwh4mhg63nsqA+CMgc+qLhF1+AJ5xRx3xLqG4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791459626;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nTXcmzNykoHxhi/QcJDSuvpVWWjGqe3eRdhbUbLnB0M=; 
 b=NvhdsFuU7Gh4AVT0Wyxy/a+ACm8KfBOxz2Q9MMy605liWbTEXrSML6nX7owKDaMjzrUPayn7CAiaExAN0zRger9Nv4/Z3qP3E+ZZ1gQ+FqbJ9zvW8ssGqYIfs0tEGnph0vbjtCFC48m/bxPVIxHKvmRilULJrZwlvfYXfGD+Q5E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791459626; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=nTXcmzNykoHxhi/QcJDSuvpVWWjGqe3eRdhbUbLnB0M=;
 b=bLJyR8jgml77Yfko/r5gxYFqfhOOx2ZyomDF7sRPqHo90qhYvJNwL9nRoP/6UZfL
 UT+/1XofTTYjMoV5i2scjUSD0pqaBo2ybl45KQilfc6Ws9oRzY0NBfOIDN5ShfpnwS1
 CLVBDwYX0si5QuIrRMQNWiPfiWCyj8FoHXdpwsKA=
Received: by smtp.zohomail.com with SMTPS id 1791459624299624.8533596020111;
 Thu, 8 Oct 2026 04:40:24 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Thu, 08 Oct 2026 19:30:47 +0800
Subject: [PATCH v4 2/3] riscv: sophgo: Enable RTC-backed system reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-cv18xx-rtc-sysreset-v4-2-62cebd76d440@zohomail.com>
References: <20261008-cv18xx-rtc-sysreset-v4-0-62cebd76d440@zohomail.com>
In-Reply-To: <20261008-cv18xx-rtc-sysreset-v4-0-62cebd76d440@zohomail.com>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexander Koch <akoch@initse.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Leo Yu-Chi Liang <leo.liang@sifive.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@nabladev.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu08011227bdc50f0c3b92f2c07abfb17600003481d790f2a3e8c955c1e83568343fd9ffc96c3c478b877757:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 08 Oct 2026 12:52:09 +0000
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

Enable the CV1800B RTC driver for Milk-V Duo, Milk-V Duo 256M,
and LicheeRV Nano. Remove the board-level sysreset binding on
Milk-V Duo now that the RTC driver binds the sysreset child from
the devicetree node. Reset register access is unchanged here.

Reviewed-by: Hiago De Franco <hfranco@baylibre.com>
Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 board/sophgo/milkv_duo/board.c         | 5 -----
 configs/milkv_duo_256m_defconfig       | 2 ++
 configs/milkv_duo_defconfig            | 2 ++
 configs/sipeed_licheerv_nano_defconfig | 2 ++
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/board/sophgo/milkv_duo/board.c b/board/sophgo/milkv_duo/board.c
index 34339c42925..3423f54012e 100644
--- a/board/sophgo/milkv_duo/board.c
+++ b/board/sophgo/milkv_duo/board.c
@@ -3,15 +3,10 @@
  * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
  */
 
-#include <dm/lists.h>
-
 #include "../common/ethernet.h"
 
 int board_init(void)
 {
-	if (IS_ENABLED(CONFIG_SYSRESET_CV1800B))
-		device_bind_driver(gd->dm_root, "cv1800b_sysreset", "sysreset", NULL);
-
 	if (IS_ENABLED(CONFIG_NET_LEGACY))
 		cv1800b_ephy_init();
 
diff --git a/configs/milkv_duo_256m_defconfig b/configs/milkv_duo_256m_defconfig
index fda0baa3277..f15b41e1451 100644
--- a/configs/milkv_duo_256m_defconfig
+++ b/configs/milkv_duo_256m_defconfig
@@ -38,6 +38,8 @@ CONFIG_MMC_SDHCI_CV1800B=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_MDIO_MUX=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_CV1800B=y
 CONFIG_MDIO_MUX_MMIOREG=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index 9d6b80362d5..77c8d89701d 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -35,6 +35,8 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_CV1800B=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y
diff --git a/configs/sipeed_licheerv_nano_defconfig b/configs/sipeed_licheerv_nano_defconfig
index 21b8fece201..75229787d2f 100644
--- a/configs/sipeed_licheerv_nano_defconfig
+++ b/configs/sipeed_licheerv_nano_defconfig
@@ -40,6 +40,8 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_CV1800B=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y

-- 
2.56.0

