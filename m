Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C30CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A637484C5F;
	Fri,  8 May 2026 10:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mU34435B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4BE184BBD; Fri,  8 May 2026 10:21:48 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BDD384C3F
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=NeQYqtmf8LdnSy9b3tWZ8x/ao56dk1uI302l/8jPbp4=; b=mU34435BcPoVnroP/D3Y9EeiJy
 RM9DjZC/ubOjb3DOGcPwMJ30F8X8mkp2IwRK3mwcTuEdTRZL1XlFTZO/xBrwMtmd4Y3kWQiH/s2Uc
 gPU8UoRSZL9LUmsvwKyZZo+u26fIbfWz9KUTPOtrS0mVlbdadsHzO3b1Jb5wMNI968CjgP6GNasPh
 oEwHrsVrPTm1VJFBV97iOZeSWBoiegy3miKjF1a/Y9AoLqLQPjMSkg1o6nSLMgOi42SXj+lMm7PVz
 ap1LrSduQSvUGsl2WRzYmwSShi6E63d1HYU1ncRTX5VIoKclFIOMAwCAWWo5cFnAzrKjWfj7q6JB0
 UjUAtZzw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGSs-0005p7-2P; Fri, 08 May 2026 10:21:42 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGSs-000P5H-2n; Fri, 08 May 2026 10:21:42 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/8] drivers: Kconfig: rtc_pcf85063: note unsupported chip
 features
Date: Fri,  8 May 2026 10:21:32 +0200
Message-Id: <20260508082132.25476-9-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508082132.25476-1-Alexander.Feilke@ew.tq-group.com>
References: <20260508082132.25476-1-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/rtc/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index ef1663f3450..ccb0709a953 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -168,6 +168,9 @@ config RTC_PCF85063
 	help
 	  If you say yes here you get support for the NXP PCF85063 RTC
 	  and compatible chips.
+	  Support for the following chip features is currently not implemented:
+	  - NVMEM
+	  - CLKOUT generation
 
 config RTC_PCF8563
 	bool "Philips PCF8563"
-- 
2.34.1

