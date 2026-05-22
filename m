Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24BCCD5BB4
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 15:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA258488F;
	Fri, 22 May 2026 17:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HfRAaExe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F05ED847EF; Fri, 22 May 2026 17:39:50 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD1158486A
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 17:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=EY/5/CXiM4R96beZ2b+aikWz/ogU6Sh1pRs2M8ShD7c=; b=HfRAaExeSiWXYq0ZYpKVe6p7sb
 NNJN5kSlQit1Lz+8mR7HJXwA/TIuFsPKANsDfBFjfrxAG0TadnMDTVYR5euJpPdhfsB9hVn9JnU6I
 sBCWkeCsV0kI6fG9bipd2VaNmQ6DQoj538endrJi08YVAxNshw2m1f7GhP6JEz9U8FVwJqPGlaviG
 JlNKPVD9KZ9nZSRl+tplSJFWn3YfxKYNYs2M9Q68rcEOPS70TjTO1vXfVrupxKSfhFwWzbGZHIfOd
 kkebRnzOE04YXap9PzrndDy9T0DU/loUjazCs3G5XEF+m8aXmlY/CiZtaJKmjuvLAROfVnzUOv3yH
 gjqU31NQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyU-000OMx-1M; Fri, 22 May 2026 17:39:46 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyT-0002ma-17; Fri, 22 May 2026 17:39:46 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 9/9] drivers: Kconfig: rtc_pcf85063: note unsupported chip
 features
Date: Fri, 22 May 2026 17:39:29 +0200
Message-Id: <20260522153929.2472552-10-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522153929.2472552-1-Alexander.Feilke@ew.tq-group.com>
References: <20260522153929.2472552-1-Alexander.Feilke@ew.tq-group.com>
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
index 65d9bf533cb..3b74770b18a 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -163,6 +163,9 @@ config RTC_PCF85063
 	help
 	  If you say yes here you get support for the NXP PCF85063 RTC
 	  and compatible chips.
+	  Support for the following chip features is currently not implemented:
+	  - NVMEM device for RAM register
+	  - CLKOUT generation
 
 config RTC_PCF8563
 	bool "Philips PCF8563"
-- 
2.34.1

