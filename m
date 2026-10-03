Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4E4CA5FC1
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFB5F81362;
	Sat,  3 Oct 2026 12:48:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NOWODJFurcT4; Sat,  3 Oct 2026 12:48:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 174318138C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791031692;
	b=FkjFtlLpEcJ8hJVdEluw8OPF3+M8hsITPuB94hdWcH6wUZ9l6ZwGWB7fazKDQk4A358g
	 5OfBUY00Hhz3k9BnIoI3kiQhjtqgzNv7Xh/gqqnPx3yeZ26gH8wiuNpwuHDTrIIaDPtUe
	 sRITT1ixw7VgiKWgTsk6ruL9NAe14dmmA/ms6Ke8hE26mRMSCyhalwkQPGQBlfIabmiIy
	 KDZh8a3dUx6qj6ThbKBiUXcfTE/sSdjz8uG04UU1EMGmJDzQmkcnwWcpDDZvumUJqjnYc
	 NRRDVHpO59pdxP3/pf5lBjczrf53rR6DCCAfKyRX1G4K5DAyghaQ0XN/4Q1SyaI1kYw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791031692;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HnjIjqVmy/SmP5fG7IYV92Dj655I84cq/8WEiJSYAwE=;
	b=besaAeLyfbxzNFVGOgfPjgZr2A1dTJJhEl2jxvtNXCCOsipZhgU6Kg2LeAhYn6KL0Uyw
	 t1eJeO9ejQEcu/S/Bz04fQVuJ8wtjzP3JRQeLEGxvpsE07v0QBAfSWQ2wwQdweaJXjQ0E
	 IO2nJq3AeDi0lVkeBjBlKHGMIGaevzKPmcIED18asZGCu1Npz84BJpuCh4R64VVmf/dUK
	 u06ZwaVtUyzT0qe7gUe08zeH4/qau5zkZAtTkWvahQcOPBTRAYkn1qz1I0mVUgUpkPH7g
	 PlfCbN2tJN1CXgTgLDJmbyVCyYA92sk3Kvk9kolScTmkoC9Cn6sBvAuihKm1+Zx3nIw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=f2OoFnND;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791031692;
	bh=HnjIjqVmy/SmP5fG7IYV92Dj655I84cq/8WEiJSYAwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VdXSR9M8M5WATVfKy2GxFF3ENZWMOmZZcRcVZO8dCXBFu8tI32yOQnYcpZBSLgkXr
	 elNQejf6gjEezPvfdVydQzLd+iq6FH1WrWKpokO/anw/N4e6Hjx3ZN0HvjzMKzoV2h
	 ymq1608lf8nktfaJkltdd3wYfYrIvHzT4wk3n4FpTxZp74MnMPFS8i03D/UNHjbEpu
	 N0mUFugfOX/bDoeYXhIi1800rvl0lphLVWTPTphs+rlAAzGkfrEi54Bqv8DATWJVJz
	 BlH5L4lkbFLdz5pY9JdRFcG88WM0hVPwHKh9mh5sRHJH2dWLQwcdeH0UcKaoiywha6
	 +pT/QFBM3yh8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 174318138C;
	Sat,  3 Oct 2026 12:48:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BDD5022B
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A41AC810DA
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:59:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TU0fLLutXym2 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 11:59:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 07BBE810C7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791028741;
 b=OWn3HST0lPPKzyz5YxyfkCAnOsBuoN1vYCMWCWik6nsqM/IGl3P93lzFLwdaggJB/+Y3
 gKB48Fy2dBlQXrERnQ0Qrk2OwIxZ3aRw9AQlo1ubfqL8KJwytn1YdtQ6N5SsGsK8NpXm7
 mTLs1x/NCDicvN+99ZqyVY0PJh5S7fYlVlq48FRpBSsyzz7R32+jVGU0EDqAxXpJa2NXT
 eJnzlYxidMGqkMjE2wGPpT3JjLOzijN3i7xTjhB+rMUWqqn9JroSKsoj5lfgVAruYrjyj
 KcZmOwEBowmKBiAYTf8MNmQbw8pFB8NouWdNEsFiBDVdG6P2X0w4DN7nzGFLHKBwJ/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791028741;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=HnjIjqVmy/SmP5fG7IYV92Dj655I84cq/8WEiJSYAwE=;
 b=UaFf/AyC0bFnpAdtxgWoguNuRNCv6PYOZtw39gx7iwkXFhGmMiURUniU4/djrFZhenrA
 OpWmGjoy966DPDSdiZspOf4yU8XeSQ+i1tXNP7Kq9BuS2DatqTPQkbBHu9vzqMByEC/4l
 OoXKsHspYhLIzDY3RrbNDMjifZvXU0cjqhxzYBRa/mhbdb2DBYrfcui0imxWZ7/KtfJ5d
 pVKWa4RV9Di7/qLW/43uzZD1bm1tCr5S6cJ+Cr1mTDAdGlDI7pt7Dhbd6QY4l3wXZHjgQ
 DR+pbIO4YYiD4P/O+/Lk9HaVpcqNEW2+rjqCQzJhvTTlioSfvjXVckJuLBTVxapDbaA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=f2OoFnND; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=f2OoFnND
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 07BBE810C7
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791028666; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YziyvLPkl5IiakVpif75LUvFJgYbjLI6Ng+Ps9ThLve21EXwFFUhNiS8w1WTkXLSfm6GLGzGuk0rAuZ+U4y0vKkW5YTqD5XMlkZfaeC+iN4mxpXX5Ivb6tpEAW6oBJupeOBOcLLEKDAGR9Xpn7+7T+QOQOJvWi8kg8Aid6m+iyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791028666;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HnjIjqVmy/SmP5fG7IYV92Dj655I84cq/8WEiJSYAwE=; 
 b=I4iNAAQyGtNdVRthQkeayc8zyj4TDUQGF5FrvEYKChJg14XL2j1n4xOhq8EhnMKXt20UNIIPgqTSdBhEKecvQIPjmMLfM2t2xtyvqpolK+zqVxl3n67HRjOTl64EaX5KjfRbC2/i8IuHEJiOPRKu1YASpK01wv4epvCA6+Y0uMQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791028666; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=HnjIjqVmy/SmP5fG7IYV92Dj655I84cq/8WEiJSYAwE=;
 b=f2OoFnNDVSmFvymJ+pCLhgG/MIcIyTuDOqEDp8D63smp1Ye++3QTZlEFgkv9spnx
 OaB2a4ByryTatqk7EnIJ6XtJb/I4CRfGOLOJt8NXB1Jlb2gA08Bwb+zFuO+z0c4grqX
 oP5A/8Ccd+H52jL0+RuwRWpEx17ZvRmJr9+bzg1c=
Received: by smtp.zohomail.com with SMTPS id 1791028665284579.0258223701103;
 Sat, 3 Oct 2026 04:57:45 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Sat, 03 Oct 2026 19:55:07 +0800
Subject: [PATCH 2/3] riscv: sophgo: Enable RTC-backed system reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-cv18xx-rtc-sysreset-v1-2-c0837e26eb29@zohomail.com>
References: <20261003-cv18xx-rtc-sysreset-v1-0-c0837e26eb29@zohomail.com>
In-Reply-To: <20261003-cv18xx-rtc-sysreset-v1-0-c0837e26eb29@zohomail.com>
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
Feedback-ID: zu08011227b55d75b3f8732c777571f0b900002ccb981d3cfb263fe5c59ccb347a373013ab57aae019c63b26:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Sat, 03 Oct 2026 12:47:49 +0000
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

Enable the CV1800 RTC driver for Milk-V Duo, Milk-V Duo 256M,
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

