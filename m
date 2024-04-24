Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA6BC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 12:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63164887BC;
	Wed, 24 Apr 2024 14:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FQ038gcA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D0BF887BC; Wed, 24 Apr 2024 14:53:48 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4DCE887B2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 14:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713963224; x=1716555224;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ayhb0My4hLnhlgEVFyBLPmnaG/6rovWYuwoP9XMZrVs=;
 b=FQ038gcAEv0Ws8p34qpKqyBGHAKm/oSWaZ5oWKmP6BVdP/QMk9wkXg99JYtv+SPu
 Dt1TGXcWNk6r3BI8UwWJbFQxAN2H19D/n83MF6JtYsfZo3ngOoQnN7xwAeGr8ii7
 j0wC8Rqv0DirKiP1AbIATmPaCykMxQzIHNyIuB4BDEI=;
X-AuditID: ac14000a-fbefe7000000290d-33-662900d8fbe5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 69.3A.10509.8D009266;
 Wed, 24 Apr 2024 14:53:44 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 24 Apr
 2024 14:53:44 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>
Subject: [PATCH 2/2] phycore_am64x_a53_defconfig: Enable CONFIG_BOARD_LATE_INIT
Date: Wed, 24 Apr 2024 14:53:35 +0200
Message-ID: <20240424125335.2306132-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424125335.2306132-1-w.egorov@phytec.de>
References: <20240424125335.2306132-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWyRpKBR/cGg2aawdaF+hZv93ayW3S/U3dg
 8jh7ZwejR393C2sAUxSXTUpqTmZZapG+XQJXRnvPB5aCZWwVHXN+MDcwHmXtYuTkkBAwkbh1
 +QpTFyMXh5DAEiaJKacfskA4jxklXl07AlbFJqAucWfDNzBbREBK4mXnRuYuRg4OZgE5iWX9
 RSBhYQF/ib1r3zCD2CwCqhKbvraB2bwClhKHmh5BLZOXmHnpOzuIzSlgJTF96jQwWwioZnX/
 VXaIekGJkzOfsIDYzED1zVtnM0PYEhIHX7xghqiXl3hxaTkLzMxp514zQ9ihElu/bGeawCg0
 C8moWUhGzUIyagEj8ypGodzM5OzUosxsvYKMypLUZL2U1E2MoPAVYeDawdg3x+MQIxMH4yFG
 CQ5mJRHemx810oR4UxIrq1KL8uOLSnNSiw8xSnOwKInzru4IThUSSE8sSc1OTS1ILYLJMnFw
 SjUwJngHeSnITdvsmpi9SP/9IQFl3pqDH3I9i5ME/Aubfi8o5rqrOTmCOSxVPXlNkJc1F//O
 +hJVJ13+HI1juiqe1w74CR+2+HxQOF4mUTXC8PG7+PKXcavKf/CGNr8Xm2Le76f0xuHk+4jL
 ZlMUi7K7Pm9/7+v3fLrpsR9iybkZL8P/7f/5daISS3FGoqEWc1FxIgDIhM5qTQIAAA==
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

Enable CONFIG_BOARD_LATE_INIT to use PHYTECs common board_late_init()
to set handy environment variables for u-boot.
Also, resync after savedefconfig.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am64x_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index bd1e05bee58..8990d08d30a 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -38,6 +38,7 @@ CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTCOMMAND="run mmcboot; bootflow scan -lb"
 CONFIG_DEFAULT_FDT_FILE="oftree"
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x180000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-- 
2.34.1

