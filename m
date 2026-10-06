Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45D0CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 16:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D69560810;
	Tue,  6 Oct 2026 16:02:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VrewufJMLpy3; Tue,  6 Oct 2026 16:02:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3C02C607CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791302575;
	b=TatLJlttR7h+7StUYe/3v70k2snvZal0n38ZgNzIiOhKB1Ugd3tfgNyl4WP9GudZr+e1
	 fL3Bd8+FuLnLFsFJgD0x7pNKxJaV+hqLZ4oEnzATJGM7GyTUr8ueRC2dTUAJhhLnXBxvE
	 D8pMQKTFCADyySVB4tyLmV1INGYzmt2oEtMuKZz6ryIBftonsL1OdXViqU/u7DZ0bgwgh
	 DrmJlK8AofHz9+mbEprmoA87Td6oKIvB1PIOtrxrTGqLRKT+T14p5iM44K6bMng9bs6LG
	 8BcnHmaLvtI6ESk1PFG092ow3PgydMiRSBqtH4vjYtsqpG59z446cdxxsqgdRDtdvCQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791302575;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HUt/JM/Scglwm59j8X9c9VesweTC0qjgUNmbNdbwwTk=;
	b=CLpxJ9jgslN4p33ewEBR0Yb4P5mFsHDX3rIsbvjExMGR+f7T4u8puidCeMLlEzU1wXQK
	 DBrkl8lJC+HZs4WD6K4JmOZZw3XrOjFoCMkb7NcdzD+u0mWlOCunE98aTnNzn0vChYCbV
	 LvT87DeGGo4RSltj5HlExn1q9EuZu8oUTDeKDw38e5GAM/4wUXuvscQ2BUlr5FRlrRuQk
	 /9L+dri1xx0Mkay1SA4Lk6ehZGco1FZEa8AfyccDDYrZha5Dkv3AvCc/jwND5p9DkhZHm
	 qYqloGyjCXiF7Je49wInUgymVo26gqn0l4fiVHgxspRrNcR8FVfuzPgAye1MBf6E8cg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791302575;
	bh=HUt/JM/Scglwm59j8X9c9VesweTC0qjgUNmbNdbwwTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=slT0BHwUZm+X2LAFfPh8NLurbBxDR9iEkbksni36wyusLl+jcvGyIjuBKnT/qjAHz
	 +m3HdGCK9WMQrqP70Lk6v/aAg8O9w0wMtq9JEqqUxmBmL2+GTUzzq+ZZ61Eg67rN4J
	 vz4tfB5CuPw74ousuwYnOq45e+/Y360t3ckdxD1yCVLqszCsGdfIwPEmJ0+T+BWZ25
	 aXC8R841zP8cW/pwVDuYsFt9RYsNqbvRApK2CmloCZA1rHPl1VDd44/u37YEOcelWi
	 BzV1aj8aJx5xDumw5UvHv/tRngfP33qrlFODTbT3PIzPg7mSQHX32S5vGpmbuhv9ZO
	 /CQsPFQjMK9uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C02C607CB;
	Tue,  6 Oct 2026 16:02:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D2F2C32F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B7BC84062B
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:49:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QcYYLIF9NGgk for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:49:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 195C24061A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791301794;
 b=GFGtLzfxldJ0Yg6wQOfCq/91YC8XTCdZjxqM9a8PDcqnBxWnnJ2zs+Ez9bdMkKJ5Iqhf
 1aBA+du+vMpGPN7ClD/lFar1SIeAyXT0IWuNsE6D4FaAHWldD0TDhrROTTun8pmgwPPKM
 LBnZCzN+ao95Y+hPAewci/XplQkek93712d6A/5aVFyHf8rRQJsUas+JmZ46EUXqOlkvG
 IstW9YT0jJNwR7kyWACIWITXiFaJfHkwrc0ZspBvhuVJJsgsgCVPLN6lkZb2v7DyGFUd8
 39La0T8HXtgaWk7P1Kosyk+VqhoTtiB6Tj41XkH7cxlP14EaZwtEJS7oyRhX15/8aLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791301794;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=HUt/JM/Scglwm59j8X9c9VesweTC0qjgUNmbNdbwwTk=;
 b=lUWmyGCzX7yk5cUdviH3Kb05q5+Mn2DL5tFGSVgrZlKUDyWyluzTqt9DiOup9Mu82ACm
 nWFOrlbTeelSN+TWpeKwu2VIymbU1Z/eK3DEccQPYOJYpFS6iJWV0o/XdQvi8xTmPizGk
 I0UnWNBjCHPAPlxvNz3Efzyy58f9JxSDKD2D8yugY7LyAVEh75LQ6za98IvZHO0bsSs8I
 P4V3jxTfX/gDDqdc9pDrW7rR4+jovS6gV9QLxK5eyshTuMxDyGXmOUWU8f01iiVGZB3xi
 Q9EwQcezwDm9WI3ziEgzj7rrBcNra8OjEANmIZnf9ngF7+jIFdZdE067zg9e6Bl7GEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=PWqsSvQO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=PWqsSvQO
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 195C24061A
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791301736; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fhUy3jxq2n9lkG1vP/yS/bLM33/qz9aTbqz0ip75S6sCRsV21mjm//9IEU1OMz5Q/sCaO6kTYQALlHB8/yoE+AicHO0F9LsnBQSWW+Y0blqrWwtxMDyWYDVIUrAMWjsmcB1IAHOC99TsJY81/AhJ044KTOz1eprBXnJ5ijtuQgg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791301736;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HUt/JM/Scglwm59j8X9c9VesweTC0qjgUNmbNdbwwTk=; 
 b=kzYr5ecvp6dc3VMy4819V4joIbdCCPXfHkPGKvFu4atq1BOGpYdjbTz6G8e/DSLo/z3p+miBBC15wu63LMsTwMwlNxAIloeqhzLPGC4FN/hFUVK8y7iHqg5jeKNnXGnLltgdBB/jxMhgK4ZoI4s+AhUkbOnfxGC3P/lHeHa3FNA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791301736; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=HUt/JM/Scglwm59j8X9c9VesweTC0qjgUNmbNdbwwTk=;
 b=PWqsSvQOaTFelJyVWlC7Tuuq5K6Ky1UsyHMc2+kg0nMLOtmbENhrIoGvhlVt0Y8C
 tBQTtByiaR2ndW2ulJBhnOcFa3HIRzZ4mUwQB0VVNHpgQi7XtF1XO/4q5n9D9fvGDHW
 qFo1VtyiYJtv6FG9sytcTCXyxT8A3ok28OAm2fzA=
Received: by smtp.zohomail.com with SMTPS id 1791301735887430.27345626207375; 
 Tue, 6 Oct 2026 08:48:55 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 06 Oct 2026 23:45:07 +0800
Subject: [PATCH v2 2/3] riscv: sophgo: Enable RTC-backed system reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-cv18xx-rtc-sysreset-v2-2-67872888384e@zohomail.com>
References: <20261006-cv18xx-rtc-sysreset-v2-0-67872888384e@zohomail.com>
In-Reply-To: <20261006-cv18xx-rtc-sysreset-v2-0-67872888384e@zohomail.com>
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
Feedback-ID: zu08011227d9a2f2579f5895a09b75692c000071be7dbcaaba8c7a535d3f8619e450f2000ea0f384e460924e:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 06 Oct 2026 15:59:54 +0000
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
2.55.0

