Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDDACA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 13:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 844B240692;
	Wed,  7 Oct 2026 13:17:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O8tKTO5jhCwP; Wed,  7 Oct 2026 13:17:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CB56C40689
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791379020;
	b=KdoWz60wgG6dRIG0aGsI7UQUuR5G9foLiRXqeFP5wQvMoHbz7YLRK/Svm4/VWf2i4CXl
	 vVvATTOxBLqVHPQiAMnXXGZQm7YJ+5llnYga6ie2gXgnYvhqoAI2a0AQDPdBa6rY/p6uN
	 tf9mXK7AaKe43H675MRvHemWiqoNOkAarUVvpJ9eNbq5gdVOG0HvpIxotmDgtyOQ5598Y
	 P+64tJyzdPQyKiZejF3BI/Dv4dLXt8h1h39UWVXUBvOWAduGwJzSQLo9waW8g2/9fN9no
	 pI4KfghJsU/RYNIUlVd2e3m+o5lJLlHBqTQlkREi1CiUSZznb3FRS7MhD6cSkUraQ/Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791379020;
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
	b=ZhS9myUbA4xzLknVCG/R5BzJH4XYy4QNPZSADec7OQlvBbs9ZCMDGFnvqOQyI6uqFt0s
	 VN2BYjKFign2Yym5kWvm7docku/MfbJF/Ook7nTV7NXf4niQfiK5qGat7jJgRpqiKPB4e
	 q2jn09pVfdQRlBEubZXk7+5x+3heosZKAQk4BOAqM5TFE8fXWDyDql7JxGaKGWMbmBXBH
	 ei8gRJO30QJOaf6OLarh9qWLes9TU6OWdAT6c+8uY4xkIrVtmT8lJ2aBq+9dIdoOC7fM4
	 UEzUYZw4rautJtMMgRkALtnOtXsCv7W4kfoXvhS99qchtwpx+Lpgptjkk7DIA9z7CyQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791379019;
	bh=HUt/JM/Scglwm59j8X9c9VesweTC0qjgUNmbNdbwwTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F5VJyiEjjGshpHSpnoadEPbZ7ep/h6QTRgE64lsj+66LaxSDR+IgRUnYFUtds1NIL
	 K5DV6HULlCXl6GV//diat+DiJJ9WCvIhdW9xLwgUsqDN4YUkfyf+h/cZ+LxLJZnhac
	 pFEC7rtDymnThkK6zokXvqwo6Fzny1GplnM9caK6/nPMjGmsOXH0zNR0lVZQAhy29f
	 1st4jYzy38Koi3ZZVNTk/zpUrCQN2Ewtpx2I8Tp4H/+1oWTHZfZOtCKMAZ3jNjrvbU
	 Fdw9u0KW0Jxx5qGBS+b+Mg9vE2jrU89eyO1kUNX2m23s3hPFeFs3ps7R7+gNHDwa0v
	 qarNH3Ja9yF3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB56C40689;
	Wed,  7 Oct 2026 13:16:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A45A32F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 04:24:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FDA4400D0
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 04:24:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A_Zbxuatywed for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 04:24:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9706740070
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791347074;
 b=iSn3y2GRnFUEZdLd14gxtcBuRLYtNilrnFiuFue2iFayyJJuWv25go9z/Z37N5K0Hc7f
 gta4mSV/7Cx18KCjj7saEUYSCHclnP95gO+nPEp9ICY8FhcL9dHmIqx+66w5kVNO9TnIt
 z9euA+i1woHeePjB9AWmBkkz/SVH3plnQYZ5HQYK2stQsUZS25vUIg1A4cy6RYrucZ+4F
 uYROtQq5ekbak0DWGpFOOCDCYHYquWyIY7c83L/6TFoH5I/W7LwZQbCv+XdE17YVuhqQh
 la6I+3qMhSrk9P8Q1kFbgHt76InhM+TSPyKNE+sxZSlDP86sVizYk5OUcf7sl9V0h4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791347074;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=HUt/JM/Scglwm59j8X9c9VesweTC0qjgUNmbNdbwwTk=;
 b=RqvgZ5q+1IedUBBblgUSmy42j8dGLT1y5YYqmQucUsd//BMoRGH4+U2jUxuZ67WLgG+D
 WYcsY009NbTsVT1tdnoBQxFybufYP+IKrhtI2D/FvvWyJBNlsq1mJgw430CfXpLDAwvwi
 qBZTid79KVVNQQTJYm4HDF6uDvAEOuhbAndgBAdFZZ98uqBMkas5mZ8FYWrl9ZeuoHyuQ
 FCgCnlBz/PYDFbsFwomaQ/OKFRGenK0rtwemJ6Owy+mrdp7M2nczhSsxfvXh6WgxXNjFP
 8MMEH/I4VQJnVFEAYgfu0RYrYJJkS0wFvbeJyOGtyiNq9Q6QMTZhZ7Yk9wVViY79/EA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=U5clFIvN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=U5clFIvN
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9706740070
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 04:24:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791346996; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Yb88Jv9Vo7+pidzJCWjwGCytsYK0z6YvfJYHPmciP2+t0Tu3z9BUGUf4QxY+/WgLJJcalh8DtV+rTtiG7CvKdX9lrIpT8yfYwPd1VLSy0r0D0Vt//Dj0TcSVYAWvbpe4ifKrzXJLNaBgE9hMWDpeRU0QjUVsZnZqKEx8Klf5ns0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791346996;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HUt/JM/Scglwm59j8X9c9VesweTC0qjgUNmbNdbwwTk=; 
 b=dZ4/3qFO794dj7wto7yZ4geWznaPVPe9Mav384kTrMNZsLc22CN65ALdM9LEhmwmDs8xwB5bLHGaM+GDC9GxxNFhxSll5eG+p2b5QpNbBt/e3ua+Cu46hE9DsfvexjDEZ87KkA0bgcI1kRYOiR2RKQrF4O6D1JUUXv5Azpme1qw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791346996; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=HUt/JM/Scglwm59j8X9c9VesweTC0qjgUNmbNdbwwTk=;
 b=U5clFIvNHWet+IZ36dQ1F4GeU5E8W52jiim89bVXv1eyq1afRCx8X6F2To9JlaGd
 0rYLhyJZPuk5E5lUSlQvRzVl6x/ykyWgzKEL88pCsqTQ+q9rBtsWV80LUpXJj9QnwUy
 JpcMoZp3YhYjOzxOwW2eQlOvH4Zng1y/zxplaKxs=
Received: by smtp.zohomail.com with SMTPS id 1791346995603658.5587509104473;
 Tue, 6 Oct 2026 21:23:15 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Wed, 07 Oct 2026 11:33:06 +0800
Subject: [PATCH v3 2/3] riscv: sophgo: Enable RTC-backed system reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-cv18xx-rtc-sysreset-v3-2-194557fd5e78@zohomail.com>
References: <20261007-cv18xx-rtc-sysreset-v3-0-194557fd5e78@zohomail.com>
In-Reply-To: <20261007-cv18xx-rtc-sysreset-v3-0-194557fd5e78@zohomail.com>
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
Feedback-ID: zu080112272f33a3855f593a16cbfe63ea0000edf0ede7684868229e2b5866c5b6092d0ff020c053772cce6e:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Wed, 07 Oct 2026 12:54:58 +0000
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

