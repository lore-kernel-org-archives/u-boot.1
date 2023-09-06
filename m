Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7438EEB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 05:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B624586997;
	Wed,  6 Sep 2023 07:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="m1CCwlBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A69866DA; Wed,  6 Sep 2023 07:18:42 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EBDB8679F
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 07:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20230906051833epoutp0242ef25412a6098a4a591385e3ba2a29c~CN5LDHpYS2276222762epoutp02c
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 05:18:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20230906051833epoutp0242ef25412a6098a4a591385e3ba2a29c~CN5LDHpYS2276222762epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693977513;
 bh=Z+QdkTZ9zTQwb8GHWYIyBdP6qjm7PIy2Rq4YJoR5zqc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m1CCwlBIGrU1/Wh8rC0CECBBlJZZDHSh4/3cl3PAquQzGnGx30EVo4Gim8AVBRGx3
 NsAzW8FuG6LznuizGM+6IvIC0JLdeGIM4i/sciru2Labs0xSLfMjB1z+UvXgY4//dF
 Ib2ukd4UwKLDHKVoj+V5Z07FCoFElqXI9z3Z7CSA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20230906051832epcas2p29b150d513c3bc44ab760d3bb4966d9c7~CN5KnpFYP0205002050epcas2p2h;
 Wed,  6 Sep 2023 05:18:32 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.100]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4RgVyc1y6lz4x9Pr; Wed,  6 Sep
 2023 05:18:32 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 47.EE.08583.7AB08F46; Wed,  6 Sep 2023 14:18:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20230906051831epcas2p2641bd65052f96115e5d8130f1974ad18~CN5JMHXv50197301973epcas2p2a;
 Wed,  6 Sep 2023 05:18:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230906051831epsmtrp2793a8b0a63e5f1ecacd62e3dd5028a28~CN5JJ0ZhJ1149911499epsmtrp2R;
 Wed,  6 Sep 2023 05:18:31 +0000 (GMT)
X-AuditID: b6c32a43-6f7ff70000002187-d8-64f80ba7b2f6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 2C.3F.08788.7AB08F46; Wed,  6 Sep 2023 14:18:31 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20230906051831epsmtip1d0c440b23c424d06e101ecfc21bacba9~CN5I9y1dC0460504605epsmtip1g;
 Wed,  6 Sep 2023 05:18:31 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 3/3] timer: riscv_aclint_timer: add timer_get_boot_us for
 BOOTSTAGE
Date: Wed,  6 Sep 2023 14:18:14 +0900
Message-Id: <20230906051814.1393464-4-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230906051814.1393464-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmme5y7h8pBm3PVCwu79e2ePviLKPF
 ty3bGC3e7u1kt3h86DWTA6vHntOzmD1mN1xk8Th7ZwejR9+WVYwBLFHZNhmpiSmpRQqpecn5
 KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAe5UUyhJzSoFCAYnFxUr6djZF
 +aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2RmTb+5kLtjKU/Hy5GWW
 BsbpXF2MnBwSAiYSE349Z+li5OIQEtjBKHHh8Xx2COcTo8TrxvVsEM43RomGFS+YYVrerdvN
 DJHYyyjxcPtnKGcak8Ttxh52kCo2AV2JLc9fMXYxcnCICCRKPD5cD2IyCzhKnJtqBFIhLBAh
 MWNhG9hMFgFViX+TXzKB2LwCDhJLVvWCdUoIyEssfiABEuYE6uxu+ckCUSIocXLmEzCbGaik
 eetssAskBC6xSxy/f4MZotdF4vRJAYiThSVeHd/CDmFLSXx+t5cNoqRcYseyJIjWFkaJ5rY9
 UC/aS/y4OYUV4mJNifW79CHKlSWO3ILayifRcfgvO0SYV6KjTQiiUV3iwPbpLBC2rET3nM+s
 ELaHxNkTy6CBOYVR4u/tB2wTGBVmIXlmFpJnZiEsXsDIvIpRLLWgODc9NdmowBAeu8n5uZsY
 wWlQy3kH45X5//QOMTJxMB5ilOBgVhLhfSf/LUWINyWxsiq1KD++qDQntfgQoykwpCcyS4km
 5wMTcV5JvKGJpYGJmZmhuZGpgbmSOO+91rkpQgLpiSWp2ampBalFMH1MHJxSDUxbFXKcr1wP
 +rXXze6g08qz4rc03+b+slPKvf2gLbr9xRuWJZfui/qoCOqFr5JtvqWUudjd/8qqe/Y6amcy
 rn5NdYhmY/Kpm2WnGsW7+GVn7lklprtf9z7zfrlzVaC5wzehGW+TZeYKH8nfv3fvD77jmcuK
 9Gu2761P+v/Earpo9+Sfj97u9EycH5T9/vfjP7fM2VYcFZiz5Etyb1Xw/jfqzc+mMFW8yuA5
 08eRMqPsS8llve1Fi94duzB9wQ/fGd7p+ftXX24szStr/jZ/74r5Ek//iz/Nu7nlDDvPEvnv
 +QU2PQ/eXF8YsYORlzUxeIL5wbYMd1OvD6rqxhqCu9w9qtvtVj6z332s3Srotr6jEktxRqKh
 FnNRcSIA0LovEQwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnO5y7h8pBsvvcVtc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKK4bFJSczLLUov07RK4
 Mibf3MlcsJWn4uXJyywNjNO5uhg5OSQETCTerdvN3MXIxSEksJtR4su6a8wQCVmJZ+92sEPY
 whL3W46wQhRNYpJ4dnQaE0iCTUBXYsvzV4wgtohAssTFni6wBmYBZ4k757YDNXBwCAuESay/
 xQESZhFQlfg3+SVYK6+Ag8SSVb2MICUSAvISix9IgIQ5BRwlult+soDYQkAl92a8YIYoF5Q4
 OfMJC8R0eYnmrbOZJzAKzEKSmoUktYCRaRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4m
 RnDQamntYNyz6oPeIUYmDsZDjBIczEoivO/kv6UI8aYkVlalFuXHF5XmpBYfYpTmYFES5/32
 ujdFSCA9sSQ1OzW1ILUIJsvEwSnVwOT04HJyVeP+0/r7Zhm/72Tfcr7Lam0LV5GbqfXJLWsn
 3PJ9FrrGpOpy9I6P6Q/cb/LLzthle4VvTZn+ppVHCv3aO+2DOPf/Tov+wG//4Twby4pyf0Ph
 DUt+8WSbXs75mJb73MXatPzYCYMWv1cH0ldMkQx9O/WC7bQHu5S+TWKpnjv1a5lZyR6NUo2f
 LM6NO2OzkvuVHmXVXwm0bX0sFa98ReeASWKLpEQ0Z916p9mrWZyLLgjrG91pV9NtTnwh4jvv
 f92qlFvrPcXzu4q2WG3O/V37Kjrd1kp2hfTD8I7Wr2vtT5jduvhUM2jtt9ulRQs5bHieSyln
 LfIuM1Pb8qvxy+4iB9Z9ezzeMHZOV2Ipzkg01GIuKk4EAIfD61fJAgAA
X-CMS-MailID: 20230906051831epcas2p2641bd65052f96115e5d8130f1974ad18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906051831epcas2p2641bd65052f96115e5d8130f1974ad18
References: <20230906051814.1393464-1-chanho61.park@samsung.com>
 <CGME20230906051831epcas2p2641bd65052f96115e5d8130f1974ad18@epcas2p2.samsung.com>
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
To get a micro-second time from a timer tick, this converts the
formula like below to avoid zero result of (tick / rate) part.

From: time(us) = (tick / rate) * 10000000
To  : time(us) = (tick * 1000) / (rate / 1000)

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/timer/riscv_aclint_timer.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/timer/riscv_aclint_timer.c b/drivers/timer/riscv_aclint_timer.c
index e29d527c8d77..73fb87912851 100644
--- a/drivers/timer/riscv_aclint_timer.c
+++ b/drivers/timer/riscv_aclint_timer.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <clk.h>
+#include <div64.h>
 #include <dm.h>
 #include <timer.h>
 #include <asm/io.h>
@@ -44,6 +45,28 @@ u64 notrace timer_early_get_count(void)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(RISCV_MMODE) && CONFIG_IS_ENABLED(BOOTSTAGE)
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
+	/* Below is converted from time(us) = (tick / rate) * 10000000 */
+	return lldiv(ticks * 1000, (rate / 1000));
+}
+#endif
+
 static const struct timer_ops riscv_aclint_timer_ops = {
 	.get_count = riscv_aclint_timer_get_count,
 };
-- 
2.39.2

