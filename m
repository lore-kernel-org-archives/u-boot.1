Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E64EE49A6
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 01:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A4A86C53;
	Mon, 21 Aug 2023 03:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="F5AODmhH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B29386BE9; Mon, 21 Aug 2023 03:04:11 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0A73869C4
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 03:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20230821010403epoutp01e5cdb0ff8ceb6d3f185373381b47c72c~9QGZvwqc71181811818epoutp01b
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 01:04:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20230821010403epoutp01e5cdb0ff8ceb6d3f185373381b47c72c~9QGZvwqc71181811818epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1692579843;
 bh=Z6836NvZBGUjQv+ZlkaqMYupHNhZF9Rc6ZNoURmErm0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F5AODmhHZAy4AFlFI0dquRYTFSu/nw7R4qZKfopXoPAfGbcr/6WHZ4YCP34NvswSq
 sr0ZBHejl8Q180MZSRcHk1SFVQvsnGyWXxK6DHOhtlnw+JgEN0w9vrVm3NXl2nx3zM
 qecxHLbpXsmTNurY5IiJRcGEy5q7gMgCb+NHHG1s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20230821010403epcas2p2eb62ff15fb5bc0b778cbd8dcfaa6dfc1~9QGZI6iQ21056610566epcas2p2w;
 Mon, 21 Aug 2023 01:04:03 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4RTZ4L3CQ6z4x9Q3; Mon, 21 Aug
 2023 01:04:02 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 B0.9A.49913.208B2E46; Mon, 21 Aug 2023 10:04:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20230821010401epcas2p2ae4be39a1b5b176e6144b9b26e218fcd~9QGYLxDQe1296912969epcas2p2B;
 Mon, 21 Aug 2023 01:04:01 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230821010401epsmtrp1cd284948978200ca88e7b8e85393b5c7~9QGYKeTrG0926909269epsmtrp1O;
 Mon, 21 Aug 2023 01:04:01 +0000 (GMT)
X-AuditID: b6c32a45-83dfd7000000c2f9-c4-64e2b802a0ce
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DD.2B.14748.108B2E46; Mon, 21 Aug 2023 10:04:01 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230821010401epsmtip2400cf12cc5a2f108df2271cea2b95980~9QGX_5Coq1075110751epsmtip20;
 Mon, 21 Aug 2023 01:04:01 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 2/3] riscv: timer: add timer_get_boot_us for BOOTSTAGE
Date: Mon, 21 Aug 2023 10:03:49 +0900
Message-Id: <20230821010350.324112-3-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230821010350.324112-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmhS7TjkcpBpePillc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKKybTJSE1NSixRS85Lz
 UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
 8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjPevbnDWtDDWbHi+XbW
 BsY97F2MnBwSAiYSfW0v2boYuTiEBHYwSpz438AI4XxilDj38AE7hPONUeL6i39ADgdYS3tj
 GkR8L6PE4ubtLBDONCaJ1rvnmEDmsgnoSmx5/ooRpEFEoFzi2D1+kDCzgLZE5+cpYKuFBdwk
 /p7/DWazCKhK7Jq0khXE5hWwl/h04D4TxC55icUPJEDCnAIOErdPzGOCKBGUODnzCQvESHmJ
 5q2zmUFOkBC4xi5x/P5kqF4Xif0XPCG+FJZ4dXwL1MdSEi/726BeKZfYsSwJorWFUaK5bQ8z
 RI29xI+bU1hBapgFNCXW79KHKFeWOHILaiufRMfhv1BTeCU62oQgGtUlDmyfzgJhy0p0z/nM
 ClHiIfH2ligkmCYzSvyc2cw4gVFhFpJfZiH5ZRbC3gWMzKsYxVILinPTU4uNCgzhkZucn7uJ
 EZwEtVx3ME5++0HvECMTB+MhRgkOZiURXunvD1OEeFMSK6tSi/Lji0pzUosPMZoCA3ois5Ro
 cj4wDeeVxBuaWBqYmJkZmhuZGpgrifPea52bIiSQnliSmp2aWpBaBNPHxMEp1cAU0eXE94t/
 crGLqMFRnSktZ7fnnfp/J6mdPzFoxUZtpRfPz08RmfwjkYtr0YkH071VNvkf959S7imkZHyV
 69/uRQH6m+7Gc20yEOWfOMlhWq77hbWbDjGfTbBZ7nlu14l1gc9XnjrEJHWA4+513Z6UQyvi
 BWa2zed42e7vW9P1366IP2d7tOW7a7uPrNi8KvfhtfdvlusK7lHlulja8naFx6bQRZ8KkoVi
 l8zIdbKsVWM67FVQx1mSpMF68/Tq/7Ez1Mz2VJ7bayCcIHZJzqB71eoGzcnrX3xZ/oEh9XHA
 4gaWKdt4bk2o1m9e+On4x/wy/tKHz7+6Zrze8KJm/g1OtVUt6dmznjXPjL43U6vophJLcUai
 oRZzUXEiAAVABdULBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSvC7jjkcpBhc7LCwu79e2ePviLKPF
 ty3bGC3e7u1kt3h86DWTA6vHntOzmD1mN1xk8Th7ZwejR9+WVYwBLFFcNimpOZllqUX6dglc
 Ge/e3GEt6OGsWPF8O2sD4x72LkYODgkBE4n2xrQuRk4OIYHdjBLnt0qA2BICshLP3u1gh7CF
 Je63HGHtYuQCqpnEJNG1/x8TSIJNQFdiy/NXjCC2iEC1xPNHO9hAbGYBbYnOz1PAmoUF3CT+
 nv8NZrMIqErsmrSSFcTmFbCX+HTgPhPEDfISix+A7eUUcJC4fWIeE8Q99hJPTnxihCgXlDg5
 8wkLxHh5ieats5knMArMQpKahSS1gJFpFaNkakFxbnpusmGBYV5quV5xYm5xaV66XnJ+7iZG
 cMhqaexgvDf/n94hRiYOxkOMEhzMSiK80t8fpgjxpiRWVqUW5ccXleakFh9ilOZgURLnNZwx
 O0VIID2xJDU7NbUgtQgmy8TBKdXAFLp8goHwviN8qyVK1h2IZEje9+jpwtZ9O00f1Ky/9vUz
 V98s86VHs1/kxc24obDjw6JbtXnrf9QUHz57ssYva6vQqQYp95UWcWZPFva0mL3SWMwmf47p
 gPbr8vp7FqI5p1I+H1AyEtY98Psdi+lqwYCEV+UyLJn7rl/YXDN9jaFr4IQXn9+z72P4WP1F
 TmD58tWR4hVd/od8P9eX3m3c5JVgm7Nmxqzvvfl+8h7zK869TzzKwrdpnqTd/NoFx76b3eTa
 9uq3T2Tf4zCnPS2/Za99lNDl+L1M3iFq119/1+etUTY1nz9WtehMOXbMYkXUocTFaxw2/i+5
 fWzRIsWG3crvt+20XGscLRHBK5kvNleJpTgj0VCLuag4EQClyKkkyAIAAA==
X-CMS-MailID: 20230821010401epcas2p2ae4be39a1b5b176e6144b9b26e218fcd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230821010401epcas2p2ae4be39a1b5b176e6144b9b26e218fcd
References: <20230821010350.324112-1-chanho61.park@samsung.com>
 <CGME20230821010401epcas2p2ae4be39a1b5b176e6144b9b26e218fcd@epcas2p2.samsung.com>
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

timer_get_boot_us function is required to record the boot stages as
us-based timestamp.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/timer/riscv_timer.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/timer/riscv_timer.c b/drivers/timer/riscv_timer.c
index 3627ed79b819..f9fc7dae37d0 100644
--- a/drivers/timer/riscv_timer.c
+++ b/drivers/timer/riscv_timer.c
@@ -11,6 +11,7 @@
  */
 
 #include <common.h>
+#include <div64.h>
 #include <dm.h>
 #include <errno.h>
 #include <timer.h>
@@ -50,6 +51,26 @@ u64 notrace timer_early_get_count(void)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(BOOTSTAGE)
+ulong timer_get_boot_us(void)
+{
+	int ret;
+	u64 ticks = 0;
+	u32 rate;
+
+	ret = dm_timer_init();
+	if (!ret) {
+		rate = timer_get_rate(gd->timer);
+		timer_get_count(gd->timer, &ticks);
+	} else {
+		rate = RISCV_SMODE_TIMER_FREQ;
+		ticks = riscv_timer_get_count(NULL);
+	}
+
+	return lldiv(ticks * 1000, (rate / 1000));
+}
+#endif
+
 static int riscv_timer_probe(struct udevice *dev)
 {
 	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
-- 
2.39.2

