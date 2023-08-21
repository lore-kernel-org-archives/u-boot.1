Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7B3EE49A4
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 01:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3F886EE9;
	Mon, 21 Aug 2023 03:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="QqDVUtnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E2A86A69; Mon, 21 Aug 2023 03:04:14 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A302386AF4
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 03:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20230821010403epoutp03e9b2a921eb2dd815960dddcdd88d07fb~9QGZtYet-0898908989epoutp03k
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 01:04:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20230821010403epoutp03e9b2a921eb2dd815960dddcdd88d07fb~9QGZtYet-0898908989epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1692579843;
 bh=IwUh8xiLq+x9ifwJ6PSr7S7q95ABUP1oqZzSe9jI2OE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QqDVUtnPGJfZyidCgUPr+qywDwfHasOgl67PiDcvXtpRthA3bZpWPGcFNJvA5gOL1
 AicZpBq1uc5osimhDBEfQvPtF2hIhhx+dMqwifLl4Vg1PIwGmmOP0ETna9je1CHBwX
 4xlhjsL3qQ8f126LE1G84Lh2ZZ+3n0nlcXuJeSKk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20230821010403epcas2p20c3b7dca3ff19e87b013f40b5c50f9fe~9QGZRPVP00928409284epcas2p27;
 Mon, 21 Aug 2023 01:04:03 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.98]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4RTZ4L4RLwz4x9Px; Mon, 21 Aug
 2023 01:04:02 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 E8.E5.49986.208B2E46; Mon, 21 Aug 2023 10:04:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20230821010402epcas2p1c95064ca145f66800fc48d03540a3088~9QGYXWjoJ2944329443epcas2p1r;
 Mon, 21 Aug 2023 01:04:02 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230821010402epsmtrp10a53aa910544e84e74e83b940206e7d8~9QGYVewIK0928709287epsmtrp1F;
 Mon, 21 Aug 2023 01:04:02 +0000 (GMT)
X-AuditID: b6c32a43-5f9ff7000000c342-32-64e2b8020578
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 32.ED.64355.108B2E46; Mon, 21 Aug 2023 10:04:02 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230821010401epsmtip22ff1d884c56acaf8ef01bc5c8aca6aeb~9QGYEtkrc1197311973epsmtip2A;
 Mon, 21 Aug 2023 01:04:01 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 3/3] timer: riscv_aclint_timer: add timer_get_boot_us for
 BOOTSTAGE
Date: Mon, 21 Aug 2023 10:03:50 +0900
Message-Id: <20230821010350.324112-4-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230821010350.324112-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmqS7TjkcpBvvey1pc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKKybTJSE1NSixRS85Lz
 UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
 8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjPezxIteM9ZsfjNYfYG
 xikcXYycHBICJhLvLh9j7GLk4hAS2MEosbTzHzOE84lRYvrE22xwzoFXX1hhWu7sWwJVtZNR
 4uuGFVD905gklp3rYwOpYhPQldjy/BVQgoNDRKBc4tg9fpAws4C2ROfnKewgtrBAqMThR4tY
 QGwWAVWJn7P3g7XyCthLXJ14igmkVUJAXmLxAwmQMKeAg8TtE/OYIEoEJU7OfMICMVJeonnr
 bLB7JAROsUu839zBBnGoi0TT9APsELawxKvjW6BsKYmX/W3sEPPLJXYsS4LobWGUaG7bwwxR
 Yy/x4+YUVpAaZgFNifW79CHKlSWO3IJayyfRcfgv1BReiY42IYhGdYkD26ezQNiyEt1zPrNC
 lHhI/N/iDgmnyYwSL6+fZprAqDALyTOzkDwzC2HvAkbmVYxiqQXFuempyUYFhvDYTc7P3cQI
 ToNazjsYr8z/p3eIkYmD8RCjBAezkgiv9PeHKUK8KYmVValF+fFFpTmpxYcYTYEhPZFZSjQ5
 H5iI80riDU0sDUzMzAzNjUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi4JRqYFrbcveTwt2G
 aWsdXkxwfyXlfeCW6uVz9gEyPVHfEkzUn+0Nm//OSePT2f1NN82Pp8aa6KzVrTLmSYhW1Et8
 YpddkSUnJTclOOp6U5xCicXCB2vP636oOFp8v7/HeP5Bxac7Qp+4ZO2WsfljedRVwz5dOXBt
 3dn2qNtHVq7xmcC45e/rPdNvm+9Kzr94U/Vux+kfS5UV/+7cISlnLxa3xdp2y7bwf+o32c8v
 y0h5pa6acztQZqrphws9z0QlJy1nKp0mu3iptGJV7YoX9Xk7YoTbeyuEHASuiX96Ls6+ZN+c
 s/aqd2JCmjb6/Nk8zfG47PzNkdUCLwsWpGVYrXvDUVKhrniobu6yu2pbTM9VbVdiKc5INNRi
 LipOBAALO75bDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvC7TjkcpBrNyLC7v17Z4++Iso8W3
 LdsYLd7u7WS3eHzoNZMDq8ee07OYPWY3XGTxOHtnB6NH35ZVjAEsUVw2Kak5mWWpRfp2CVwZ
 72eJFrznrFj85jB7A+MUji5GTg4JAROJO/uWMHcxcnEICWxnlHg7ZSMbREJW4tm7HewQtrDE
 /ZYjrBBFk5gkLvSvAkuwCehKbHn+ihHEFhGolnj+aAdYM7OAtkTn5ylgNcICwRJ3/jcyg9gs
 AqoSP2fvB6vhFbCXuDrxFFMXIwfQAnmJxQ8kQMKcAg4St0/MYwKxhYBKnpz4xAhRLihxcuYT
 Fojx8hLNW2czT2AUmIUkNQtJagEj0ypG0dSC4tz03OQCQ73ixNzi0rx0veT83E2M4FDVCtrB
 uGz9X71DjEwcjIcYJTiYlUR4pb8/TBHiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5zTmSIkkJ5Y
 kpqdmlqQWgSTZeLglGpg0o+2eVh1Zk3T6cqKR9/F2XdnlC3/7C7qWLj/6J5TCp6dJ3ZUXTi2
 OXLSqgOT4xL57s6Z8zttz2sxBpMb9bXHgk9Xz+Ree8+WzdHHMUpd9JfVG/PrCzpWSOXaTGH3
 9E7/vX3BrQ2nErUCzDZUr+J7/ordSdNv4f2bKzoO3GbP7raYYNmls2nypBD1h8El3zhqGE5e
 3c1y+MrbpyaTD664fkd0rtT53+ZTy9ccjeO9FXY9O2teSEzZV8bH6molHjn5fpNr/GMkbkZX
 SZ976RQeolGmb7H8tL+8ceIRx2WXrU/bZhY4lCX0np4b2qxUdub9cpaF664aLA8/9q98UlD/
 5QettRPf5pms1OTovfBwmRJLcUaioRZzUXEiAGC1B4zEAgAA
X-CMS-MailID: 20230821010402epcas2p1c95064ca145f66800fc48d03540a3088
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230821010402epcas2p1c95064ca145f66800fc48d03540a3088
References: <20230821010350.324112-1-chanho61.park@samsung.com>
 <CGME20230821010402epcas2p1c95064ca145f66800fc48d03540a3088@epcas2p1.samsung.com>
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
 drivers/timer/riscv_aclint_timer.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/timer/riscv_aclint_timer.c b/drivers/timer/riscv_aclint_timer.c
index e29d527c8d77..442b48d55adf 100644
--- a/drivers/timer/riscv_aclint_timer.c
+++ b/drivers/timer/riscv_aclint_timer.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <clk.h>
+#include <div64.h>
 #include <dm.h>
 #include <timer.h>
 #include <asm/io.h>
@@ -44,6 +45,27 @@ u64 notrace timer_early_get_count(void)
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
+		rate = RISCV_MMODE_TIMER_FREQ;
+		ticks = readq((void __iomem *)MTIME_REG(RISCV_MMODE_TIMERBASE,
+							RISCV_MMODE_TIMEROFF));
+	}
+
+	return lldiv(ticks * 1001, (rate / 1000));
+}
+#endif
+
 static const struct timer_ops riscv_aclint_timer_ops = {
 	.get_count = riscv_aclint_timer_get_count,
 };
-- 
2.39.2

