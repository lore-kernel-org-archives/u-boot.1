Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A80EB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 05:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D44D86907;
	Wed,  6 Sep 2023 07:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Li0z8nNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC9786961; Wed,  6 Sep 2023 07:18:42 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 785FC866DA
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 07:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20230906051832epoutp011e9f45ca7716f16bd649a8a5c68c516f~CN5KYoEjR1314213142epoutp01N
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 05:18:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20230906051832epoutp011e9f45ca7716f16bd649a8a5c68c516f~CN5KYoEjR1314213142epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693977512;
 bh=zpFEGjN8ECbCDGuvmDZ5APz45k/v/lq6z//idUfXEfE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Li0z8nNxUbSMOiAZydt3K+X+k8ioKBGqEX+g0yLDGXtuy5dQTx6OsJO/PJ+C2zpBY
 NDL+ZYOUg4uSpwDUc/FaX8O4qWHhQD4cePWrfxCvG5+CUmyFNICkL0VhLAgITpakFd
 XF5fy+6+3vromwb03bQOV31PIzDKkvAc91cbTZg4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20230906051832epcas2p39ab6d48ce610818ee0477236757b0d32~CN5KDY4gQ2364923649epcas2p3Z;
 Wed,  6 Sep 2023 05:18:32 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4RgVyb4lfxz4x9QB; Wed,  6 Sep
 2023 05:18:31 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 7E.CA.09649.7AB08F46; Wed,  6 Sep 2023 14:18:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20230906051831epcas2p4b7b6569a55abbab22621658b88bac9d6~CN5JKAzMM2922929229epcas2p4E;
 Wed,  6 Sep 2023 05:18:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230906051831epsmtrp2d99eb1567871527dc7acf18923c54863~CN5JIE1i-1156411564epsmtrp2u;
 Wed,  6 Sep 2023 05:18:31 +0000 (GMT)
X-AuditID: b6c32a46-b9ffa700000025b1-42-64f80ba79d9a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 60.1E.18916.7AB08F46; Wed,  6 Sep 2023 14:18:31 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20230906051831epsmtip13c881c947b09b5a28d43a2a60f879b3e~CN5I5vmEh0505605056epsmtip17;
 Wed,  6 Sep 2023 05:18:31 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 2/3] riscv: timer: add timer_get_boot_us for BOOTSTAGE
Date: Wed,  6 Sep 2023 14:18:13 +0900
Message-Id: <20230906051814.1393464-3-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230906051814.1393464-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmme5y7h8pBmdXqlhc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKKybTJSE1NSixRS85Lz
 UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
 8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjN+3F3BVHCDu2LTlses
 DYxHObsYOTgkBEwkFr1S6GLk4hAS2MEo8XjbPRYI5xOjxNPXP9jgnKsrLjB3MXKCdcyf/Q3M
 FhLYyShxZ6MRRNE0JonurXMZQRJsAroSW56/YgRZISKQKPH4cD2IySzgKHFuqhFIhbCAp8SD
 HVdZQGwWAVWJhrm3WEBKeAUcJA5s84e4TV5i8QMJkApOoMbulp9g1bwCghInZz4Bs5mBSpq3
 zmYGOUBC4By7RN/BqSwQV7pI7GvdAHWxsMSr41vYIWwpic/v9rJBzC+X2LEsCaK3hVGiuW0P
 VL29xI+bU1ghLtaUWL9LH6JcWeLILai1fBIdh/+yQ4R5JTrahCAa1SUObJ8OdYCsRPecz6wQ
 tofEjXWtrJBgmsIo0bZ9KdsERoVZSL6ZheSbWQiLFzAyr2IUSy0ozk1PLTYqMILHbXJ+7iZG
 cArUctvBOOXtB71DjEwcjIcYJTiYlUR438l/SxHiTUmsrEotyo8vKs1JLT7EaAoM6YnMUqLJ
 +cAknFcSb2hiaWBiZmZobmRqYK4kznuvdW6KkEB6YklqdmpqQWoRTB8TB6dUAxOnQNz8Gzme
 UlMKfn7gOusWev7ZJmG5vCMpShrlJR8CHZZHX2LbH+ZplrGD3dqAdf8H+4KFT3x/10rHrA+4
 lclxf9FlDgbhO3aZGVLMJxWXXH3Vpt7kL+bAaJa+98vhnz2FPdrPfrtXGs+X+fXr9UTN45de
 ryoxagxyO59zyUpfP5WV9+wlQ7Fw0xazIrm/BcK8UQVZKS8fs3A3bVWfJD1rabDzoU9Lf3jz
 r5Kf5bEw8MrUX2cmJQfcNdPwripawDlBs67PdJVBNzND/IO3zXy2R9Okv3+7nHNzprr1uQ+q
 ZxY94cg4/Wtlau+NzIsntG4vuter8emTQInzsRkXLtbZfLiiyqhqIbm+78IMdiWW4oxEQy3m
 ouJEAD06Jd8KBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSnO5y7h8pBie+s1tc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKK4bFJSczLLUov07RK4
 Mn7cXcFUcIO7YtOWx6wNjEc5uxg5OSQETCTmz/7G3MXIxSEksJ1RYv3lJWwQCVmJZ+92sEPY
 whL3W46wQhRNYpK4ebWPFSTBJqArseX5K0YQW0QgWeJiTxdYA7OAs8Sdc9vBaoQFPCUe7LjK
 AmKzCKhKNMy9BWRzcPAKOEgc2OYPYkoIyEssfiABUsEp4CjR3fITrFoIqOLejBfMIDavgKDE
 yZlPWCCmy0s0b53NPIFRYBaS1CwkqQWMTKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLzczcxgoNV
 K2gH47L1f/UOMTJxMB5ilOBgVhLhfSf/LUWINyWxsiq1KD++qDQntfgQozQHi5I4r3JOZ4qQ
 QHpiSWp2ampBahFMlomDU6qBKVm2ana/xL8fm7z09aJ1HmWH7NCx+Jm/vpSn5knvll3yHsp9
 5Qrdt39zPDVdK7D07Ouy61UL1n4S5jgms7DixtXL2x8q9lzclLDQL5yr8sY2a4spH9uvXag5
 s99eY0eOvfmOIwKaaoskZu52EN25u1uw6MkGhYWHvbWeLcr/kR+18Hj83KJFFwOTGNsiV8hz
 vTHdnbYrrTf7yJcp9qeMhJLSD/u9kRZa3iCVah0mNnmp2KoXRQ/qM/ar7j2Uurkkn+P76lTf
 KTtF7PRUMwLD+U30PoT8yMkMi08X3+Ipo77yr0iyt+vfN2cLLb+68K79fqpk+pYJKm82PnTp
 sZ6TwXYvweTxg9td6qF7tOW/KLEUZyQaajEXFScCAD5F8HPFAgAA
X-CMS-MailID: 20230906051831epcas2p4b7b6569a55abbab22621658b88bac9d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906051831epcas2p4b7b6569a55abbab22621658b88bac9d6
References: <20230906051814.1393464-1-chanho61.park@samsung.com>
 <CGME20230906051831epcas2p4b7b6569a55abbab22621658b88bac9d6@epcas2p4.samsung.com>
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
 drivers/timer/riscv_timer.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/timer/riscv_timer.c b/drivers/timer/riscv_timer.c
index 28a6a6870b81..169c03dcb5c1 100644
--- a/drivers/timer/riscv_timer.c
+++ b/drivers/timer/riscv_timer.c
@@ -11,6 +11,7 @@
  */
 
 #include <common.h>
+#include <div64.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdt_support.h>
@@ -51,6 +52,27 @@ u64 notrace timer_early_get_count(void)
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
+	/* Below is converted from time(us) = (tick / rate) * 10000000 */
+	return lldiv(ticks * 1000, (rate / 1000));
+}
+#endif
+
 static int riscv_timer_probe(struct udevice *dev)
 {
 	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
-- 
2.39.2

