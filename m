Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E81C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 09:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11FD4864DA;
	Mon, 28 Aug 2023 11:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="e6nHCthT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCB9F864D7; Mon, 28 Aug 2023 11:50:01 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FACD864C5
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 11:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230828094954epoutp04d4fb06014955a94984b685e5100c89cd~-gyiAkJs_1948219482epoutp04P
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 09:49:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230828094954epoutp04d4fb06014955a94984b685e5100c89cd~-gyiAkJs_1948219482epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693216194;
 bh=PR9dyg7OiA3d53I3yNTI1TWhNpuVQqS06wMkgFgwU0w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e6nHCthTInjD8D+rMUfd37mc1SqWDdMMsn78wDV2mVc/p3m7xHXrKtVbMKzisL9eX
 enjIyTeQvwVYJsH4//vZP3M55NNCugscWh3DB4u+D5mzXBt5INhWgdvK2z5ZyALnAV
 Sb3zntd28lJVp5M6JlSN7WfBd6okrd+UUAjTeCho=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20230828094953epcas2p3311bc64e1e38caaadbc7bf282fb453a9~-gyhKsYSl2004120041epcas2p3n;
 Mon, 28 Aug 2023 09:49:53 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.100]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4RZ5Ps36WNz4x9Q0; Mon, 28 Aug
 2023 09:49:53 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 A3.86.09765.1CD6CE46; Mon, 28 Aug 2023 18:49:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20230828094952epcas2p1826292dae2e93fb619cc5fa146bb0787~-gygMsPxi2825528255epcas2p1u;
 Mon, 28 Aug 2023 09:49:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230828094952epsmtrp26b20ef11be16c6789c78975cc199d903~-gygMI-0u1363313633epsmtrp2Y;
 Mon, 28 Aug 2023 09:49:52 +0000 (GMT)
X-AuditID: b6c32a48-40fff70000002625-2d-64ec6dc1b66d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 50.B4.08742.0CD6CE46; Mon, 28 Aug 2023 18:49:52 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230828094952epsmtip2be52ab5b48bb1ddace5c88c374de5cc4~-gygAHN4T2737227372epsmtip2I;
 Mon, 28 Aug 2023 09:49:52 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 2/3] riscv: timer: add timer_get_boot_us for BOOTSTAGE
Date: Mon, 28 Aug 2023 18:49:37 +0900
Message-Id: <20230828094938.2061606-3-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828094938.2061606-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmhe7B3DcpBlP7eSwu79e2ePviLKPF
 ty3bGC3e7u1kt3h86DWTA6vHntOzmD1mN1xk8Th7ZwejR9+WVYwBLFHZNhmpiSmpRQqpecn5
 KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAe5UUyhJzSoFCAYnFxUr6djZF
 +aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2Rnzr09jL1jHWdHy9zZj
 A+Md9i5GTg4JAROJj2tuMnYxcnEICexglDi08i0bhPOJUeLThSdMIFVCAt8YJT5stoHpuNiz
 hxWiaC+jxJXeA8wQzjQmicdP1oHNZRPQldjy/BXQXA4OEYFyiWP3+EHCzALaEp2fp4CVCAt4
 Stw8/Z4ZxGYRUJW4+eYNWJxXwEFi17J77CCtEgLyEosfSICEOQUcJc7+/csMUSIocXLmExaI
 kfISzVtng50gIXCOXWLLtVvMEIe6SOxctIQVwhaWeHV8C9TLUhKf3+1lg5hfLrFjWRJEbwuj
 RHPbHqhee4kfN6ewgtQwC2hKrN+lD1GuLHHkFtRaPomOw3+hruSV6GgTgmhUlziwfToLhC0r
 0T3nMytEiYfEq1M8kHCawijxb9tS5gmMCrOQPDMLyTOzEPYuYGRexSiWWlCcm55abFRgAo/d
 5PzcTYzgNKjlsYNx9tsPeocYmTgYDzFKcDArifBecnyVIsSbklhZlVqUH19UmpNafIjRFBjS
 E5mlRJPzgYk4ryTe0MTSwMTMzNDcyNTAXEmc917r3BQhgfTEktTs1NSC1CKYPiYOTqkGptDb
 3mdmay7ZK2Y1f7PFZZmUjHV8pR3TPu9adDpyg8bv6coFSz9fMfp+odE36/Zmy/pFfdX2GzZN
 5d/ZGdv7bW9b94F3sT+XfKqP23JeNufW8dzPuqIXJ3jWxx7+Yiv8v7B4avCnEq/5wsyrmANC
 5CPn7d91y7TmWsOdVW/+2Z/d/MdS0ST5mFGKY8fsZtXFm84JflV+d/7foltfXpkeE61LTXhs
 ujE/LfKWXeq8fXeN3X99Wn/rz/IPfrHpJ5f3bnr7mjs2uGnl/P292zawejcqNfbvUBHMe7hr
 bge3m9CvO1bKqpITWLb+mG+fPjM9hbvs/9usKGsWsy6HxNC2/58yDkv27Ll8yj2P5cDRtFVK
 LMUZiYZazEXFiQBQrQ6TDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSvO6B3DcpBg3PTS0u79e2ePviLKPF
 ty3bGC3e7u1kt3h86DWTA6vHntOzmD1mN1xk8Th7ZwejR9+WVYwBLFFcNimpOZllqUX6dglc
 GfOvT2MvWMdZ0fL3NmMD4x32LkZODgkBE4mLPXtYuxi5OIQEdjNK7Hm6kBkiISvx7N0OqCJh
 ifstR6CKJjFJbPj8kQkkwSagK7Hl+StGEFtEoFri+aMdbCA2s4C2ROfnKWDNwgKeEjdPvwcb
 yiKgKnHzzRuwOK+Ag8SuZfeAbA6gBfISix9IgIQ5BRwlzv79C1YuBFSyaekLNohyQYmTM5+w
 QIyXl2jeOpt5AqPALCSpWUhSCxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBIet
 luYOxu2rPugdYmTiYDzEKMHBrCTCe8nxVYoQb0piZVVqUX58UWlOavEhRmkOFiVxXvEXvSlC
 AumJJanZqakFqUUwWSYOTqkGprK7R/8w2cdw+m1IPNfXtOT5R7+u0AvH37072hOS7Sv8cEWs
 fGvI3RsLp2m4xtooVrrXfqq0/Xd71vdHCq8+O/s7TGL5sNrCbO7fDoVK60mhH2Rt5J48a3A5
 NYfhCYPk6rtsSbXlry/wH6zpm/t/Hvv1QoaVWnziVYxXn1h1T5zGYDwrxv7l/kQ/i8zGp1Ku
 fWulxWSeB8ruFdubc5VTQN9gc4v1r1/NJ0xjzYsbdY4KpsyLuHNOSK5s+kMrcaFVRQZd/kys
 T31kn552See0s2K8U6ibeXT5NePPMqddz0T8tVl+1WPzushcn58TNqbUF/zccN60M3h+wrb1
 lsc2bql9+vjjHYXUYwZzr62XVWIpzkg01GIuKk4EAKlpBjbKAgAA
X-CMS-MailID: 20230828094952epcas2p1826292dae2e93fb619cc5fa146bb0787
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230828094952epcas2p1826292dae2e93fb619cc5fa146bb0787
References: <20230828094938.2061606-1-chanho61.park@samsung.com>
 <CGME20230828094952epcas2p1826292dae2e93fb619cc5fa146bb0787@epcas2p1.samsung.com>
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
index 3627ed79b819..6cb589fcdc45 100644
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
 
+#if CONFIG_IS_ENABLED(RISCV_SMODE) && CONFIG_IS_ENABLED(BOOTSTAGE)
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

