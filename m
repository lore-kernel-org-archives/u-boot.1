Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29EBC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 09:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EFD3864D3;
	Mon, 28 Aug 2023 11:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="uNR28o2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17438864C5; Mon, 28 Aug 2023 11:50:02 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC872864CA
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 11:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20230828094954epoutp01de3cd985f934592666c09cd8f33fd334~-gyh7QlDT0667506675epoutp01b
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 09:49:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20230828094954epoutp01de3cd985f934592666c09cd8f33fd334~-gyh7QlDT0667506675epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693216194;
 bh=dKsU3gUeG1PxX5iWv+j/nM2bHalXy+Iks1TNrtmLJao=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uNR28o2ymsS7vtVJswEtbZoUuyvPp5vnYxB66Xs+Yj5b48FtcQR+5NiwDSYnsf0lU
 7TmyT42m6FdK8wxKbpcNsu+JmNfEU+/R+j8vDk1nlSsnlvFetUcuNcOHvdPLbFZwwS
 y2WSL8PNYJPryZtQH7DKrZ3szM688xBmir9Jop5k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20230828094954epcas2p4c891239db833ff31b7f38c9151d2beb7~-gyhqp5573028630286epcas2p4o;
 Mon, 28 Aug 2023 09:49:54 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.100]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4RZ5Ps6vLXz4x9Q9; Mon, 28 Aug
 2023 09:49:53 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 44.B8.19471.1CD6CE46; Mon, 28 Aug 2023 18:49:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20230828094953epcas2p3fc191dd7a0d387cfd987240b972c79b5~-gygVRnjC2634726347epcas2p3K;
 Mon, 28 Aug 2023 09:49:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230828094953epsmtrp289b1298d676d040442b2b5d931110420~-gygUsidL1352013520epsmtrp2z;
 Mon, 28 Aug 2023 09:49:53 +0000 (GMT)
X-AuditID: b6c32a4d-dc5ff70000004c0f-62-64ec6dc1d14a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B3.84.08788.0CD6CE46; Mon, 28 Aug 2023 18:49:52 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230828094952epsmtip2c67c1b3f550693138227619e8e379bd7~-gygF62972737827378epsmtip2E;
 Mon, 28 Aug 2023 09:49:52 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 3/3] timer: riscv_aclint_timer: add timer_get_boot_us for
 BOOTSTAGE
Date: Mon, 28 Aug 2023 18:49:38 +0900
Message-Id: <20230828094938.2061606-4-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828094938.2061606-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmqe7B3DcpBvO3iFtc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKKybTJSE1NSixRS85Lz
 UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
 8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjOW9P1gKZjIVTHr/gzm
 BsYtHF2MnBwSAiYS2552s3QxcnEICexhlFj+so8ZwvnEKHGl9wo7hPONUeLS5tlAGQ6wlhNz
 YiHiexklfrX+gmqfxiRx7PkGJpC5bAK6Eluev2IEaRARKJc4do8fJMwsoC3R+XkKO4gtLBAh
 cartMQuIzSKgKjF3/Q1GEJtXwEGiZdp8Vohd8hKLH0iAhDkFHCXO/v3LDFEiKHFy5hMWiJHy
 Es1bZ4MdLSFwiV3i1JY5bBCvuUicfvOFGcIWlnh1fAs7hC0l8fndXjaI+eUSO5YlQfS2MEo0
 t+2BqreX+HFzCtgNzAKaEut36UOUK0scuQW1lk+i4/Bfdogwr0RHmxBEo7rEge3TWSBsWYnu
 OZ9ZIWwPiW8fF7BBAmoKo8TEfx9YJzAqzELyzSwk38xCWLyAkXkVo1RqQXFuemqyUYGhbl5q
 OTyKk/NzNzGCE6KW7w7G1+v/6h1iZOJgPMQowcGsJMJ7yfFVihBvSmJlVWpRfnxRaU5q8SFG
 U2BwT2SWEk3OB6bkvJJ4QxNLAxMzM0NzI1MDcyVx3nutc1OEBNITS1KzU1MLUotg+pg4OKUa
 mKY+kz/r69gaX2wmtGzekxpTb9UnjKXrrno5vXzu1rigy+allvieHh9LnfWrJ/5hvWaVY2R8
 fga3OFPwMt/wX5s/dz47YH1iLUPmv6vT6+e3bndgeHdhU6O9nKAc0ympX879d0JPrjvnVGhX
 pv+Q6YCPcuwmxbMyqa7bLNz8rP5ImB1KawnXXpoqlGLtIyS/0Cc0z6WqYsZj18yI9XGNCVsO
 SE80cFL1lb6w8dfJ52fq4xnTHjAUXpuQp7nxodPFSPafpbGHbh/yOvtyi5VlRezLqUnGLb17
 7ZMv2r8pDv/9232vWc28C2eWrYx/r8PgweceHOWVuvDJN4mOqCXO02aYn785eftimxaulmk2
 SizFGYmGWsxFxYkAwfRwlxEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSvO6B3DcpBqfXWVpc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKK4bFJSczLLUov07RK4
 Mpb0/WApmMhVMev+DOYGxi0cXYwcHBICJhIn5sR2MXJxCAnsZpR4unwHYxcjJ1BcVuLZux3s
 ELawxP2WI6wQRZOYJC7s/gFWxCagK7Hl+SswW0SgWuL5ox1sIDazgLZE5+cpYM3CAmESb9a3
 gMVZBFQl5q6/AVbPK+Ag0TJtPivEEfISix9IgIQ5BRwlzv79ywxiCwGVbFr6gg2iXFDi5Mwn
 LBDj5SWat85mnsAoMAtJahaS1AJGplWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMFB
 q6W1g3HPqg96hxiZOBgPMUpwMCuJ8F5yfJUixJuSWFmVWpQfX1Sak1p8iFGag0VJnPfb694U
 IYH0xJLU7NTUgtQimCwTB6dUA5Og0gH/jHNPD+/5N233+m8VzTm96wo1V+Rz3Jx+o/09/7bH
 vSL5gc281UsSa7/5bRAO7/xven975yVLw3VhZ7fLbb+3s8SCT/fPE8fQ05J6KxWk1x6cfEYx
 Pb3kC0+W+v4+7n7Lfexrp5lZKbxwMJjxZq7WogNfXi69UXqwmGexeQ1PxtLeh3m9GlryDceP
 351nKsT0rtbCsNDPL3Hi83mmfUIPyg6aTt6mmBZdfG7NtVmLn3Yy/k6f/ET8/nXVmitvBbg3
 Xnn5tCG8pUVH+HtN/L4ZrWXHb+RVnrrVGVB+tKZsyfbjZ78nmpgU9OjcTtrwl2WFGp+QkWH9
 g7igc3zP2hcqvVv2uO78egOdF9eVWIozEg21mIuKEwF9AL3/yQIAAA==
X-CMS-MailID: 20230828094953epcas2p3fc191dd7a0d387cfd987240b972c79b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230828094953epcas2p3fc191dd7a0d387cfd987240b972c79b5
References: <20230828094938.2061606-1-chanho61.park@samsung.com>
 <CGME20230828094953epcas2p3fc191dd7a0d387cfd987240b972c79b5@epcas2p3.samsung.com>
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
index e29d527c8d77..8b67745bb4a2 100644
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
+	return lldiv(ticks * 1001, (rate / 1000));
+}
+#endif
+
 static const struct timer_ops riscv_aclint_timer_ops = {
 	.get_count = riscv_aclint_timer_get_count,
 };
-- 
2.39.2

