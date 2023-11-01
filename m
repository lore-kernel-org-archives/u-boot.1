Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D4AC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 11:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C353E87ADE;
	Wed,  1 Nov 2023 12:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="CTAE5vm7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07B8A87ADE; Wed,  1 Nov 2023 12:40:50 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39FB7876D3
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231101114041epoutp0445cdd982674b3d9781e4de0079564b63~TfOzVrYqW0825108251epoutp04h
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 11:40:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231101114041epoutp0445cdd982674b3d9781e4de0079564b63~TfOzVrYqW0825108251epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698838841;
 bh=bjw3/ORzYww3ZVaRsqPckoL0vWKLRb6E8nT9Ogrpbj8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CTAE5vm7cQZH8BxO+ReqrlbmL4ujLWkIDZfxvDUayLPoQdp9TgR6TIFGxxANlFOuq
 ZsIveKjWHwsEl6JiScLjcM3DSZstxTySKgp/kTlFVpZGi0BQiqbamDcVpAruEtLIEg
 So98zvWlGd4TYM6nH2b2y7ee5d8eTndC1DgVWtqQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20231101114040epcas2p2e0713f4d08db78adb096600039270db5~TfOzCBUJM2671326713epcas2p2A;
 Wed,  1 Nov 2023 11:40:40 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.101]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SL4nh1SZ8z4x9Pq; Wed,  1 Nov
 2023 11:40:40 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 5B.23.18994.83932456; Wed,  1 Nov 2023 20:40:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231101114039epcas2p11cf2adf548a2d2bcccfb14add9550a07~TfOyMxHWU1995719957epcas2p1Z;
 Wed,  1 Nov 2023 11:40:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101114039epsmtrp29e121c6ed94e7c1430bd779d3477ccbf~TfOyMJh3s0429404294epsmtrp2r;
 Wed,  1 Nov 2023 11:40:39 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-c4-654239382867
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A9.87.08755.73932456; Wed,  1 Nov 2023 20:40:39 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101114039epsmtip19352e1347c9fb107328fd6cbed940553~TfOx_aOKY1681316813epsmtip1R;
 Wed,  1 Nov 2023 11:40:39 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 1/5] riscv: import read/write_relaxed functions
Date: Wed,  1 Nov 2023 20:40:13 +0900
Message-Id: <20231101114017.1845960-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101114017.1845960-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdljTXNfC0inVYOMFDovL+7UtbvxqY7V4
 ++Iso8W9a3IWb/d2slscnvqB0eLxoddMDuwee07PYvb48DHO4861PWweZ+/sYPTo27KKMYA1
 KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gIJYWy
 xJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2
 Ru/TvYwFDRIVh3/eYGtgnCfSxcjJISFgInH65D72LkYuDiGBPYwSuxe+YoZwPjFK/Fy7jwWk
 SkjgG6NEy/QYmI4NUxtYIYr2Mkr8W3ESqmMak8TG/w1gHWwCuhJbnr9iBEmICFxllHg/6w0z
 SIJZQFui8/MUoIUcHMICThJzFkmBhFkEVCWer1zKBGLzCjhIrLx4lQ2kREJAXmLxAwmQMKeA
 o8TKtj9sECWCEidnPmGBmCgv0bx1NtgNEgIv2SVmNd1mgrjUReL413/MELawxKvjW9ghbCmJ
 z+/2Qs0vl9ixLAmit4VRorltD1S9vcSPm1NYQWqYBTQl1u/ShyhXljhyC2otn0TH4b/sEGFe
 iY42IYhGdYkD26ezQNiyEt1zPrNC2B4Sl74+hobUFEaJnQ1fmScwKsxC8s0sJN/MQli8gJF5
 FaNUakFxbnpqslGBoW5eajk8jpPzczcxgpOllu8Oxtfr/+odYmTiYDzEKMHBrCTCe9jUIVWI
 NyWxsiq1KD++qDQntfgQoykwuCcyS4km5wPTdV5JvKGJpYGJmZmhuZGpgbmSOO+91rkpQgLp
 iSWp2ampBalFMH1MHJxSDUzp8d/+Ptz8rXECy9KpuxMvPb/H8nPJfHWZ+8s2RS3eed7mzv/k
 eZO1Ive9vlDV8aoq73mLqCj/8XLBNjvrvrwZN/JMl3G5i+1z0z/0ZqW2crZ/wQebjhn/l/et
 Ornv8dH5p8tbL1eWeYbkGEvymX0W5cx5u1Lj6J6tEboKt88si/2T8p751u1vGo81n69NeGZV
 LCG6pXrD49/GLnmzg4L3aQgFn5zws1jruCXjrVPcS594xB0+r3A43SvhnOB1af0zix8UO4Y5
 ZbIFczXxLlx1RMKlSYt74aECjYXW+9uqTE9vMY/abWUw3f7znF++956xXhJ2mtnxVsLpstP/
 9q3TGnVX8xxbzffa6u+DsDMNSizFGYmGWsxFxYkAjSi7/R8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSnK65pVOqwbZePYvL+7UtbvxqY7V4
 ++Iso8W9a3IWb/d2slscnvqB0eLxoddMDuwee07PYvb48DHO4861PWweZ+/sYPTo27KKMYA1
 issmJTUnsyy1SN8ugSuj9+lexoIGiYrDP2+wNTDOE+li5OSQEDCR2DC1gbWLkYtDSGA3o8TS
 XU+ZIRKyEs/e7WCHsIUl7rccgSqaxCSxZs1BNpAEm4CuxJbnrxhBEiICNxklFs75ygKSYBbQ
 luj8PAWom4NDWMBJYs4iKZAwi4CqxPOVS5lAbF4BB4mVF6+ygZRICMhLLH4gARLmFHCUWNn2
 B2y8EFDJ3NsrWSHKBSVOznwCNV1eonnrbOYJjAKzkKRmIUktYGRaxSiZWlCcm55bbFhgmJda
 rlecmFtcmpeul5yfu4kRHNBamjsYt6/6oHeIkYmD8RCjBAezkgjvYVOHVCHelMTKqtSi/Pii
 0pzU4kOM0hwsSuK84i96U4QE0hNLUrNTUwtSi2CyTBycUg1MXXsYdZmSJ3Mxt213Tg7qMV9S
 Zij977h/UUOv/cabEqlSBVubp+o8uSs5ecfDtOUTAmVXOL8RrViW8s3/0rSMxZ7yr1X5A7Yt
 vCz5yn9fdWR9+s0js3xvan9YmmF3xM3pTHmonP82J7GiG8tUNKv2S0p3Pkpin55Vq3Xm30Fn
 FY0Th3b+/6NRpXX1546TcdaNEzpPvV+pdFTgssULo46P31PvHcqobXE6z+t3NyjEIuLdmrWH
 r90u3ptwJHF97KS7lztrf10z/fn9/UumNv07sjVVS1rFvk2/vKPMcbWUADOLi1MFo4pFydT1
 d260H1oVxMnyuPV544J6vuSPSfFH76/lC1ug4PXw/tuf1030lFiKMxINtZiLihMB4ZLcNNcC
 AAA=
X-CMS-MailID: 20231101114039epcas2p11cf2adf548a2d2bcccfb14add9550a07
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101114039epcas2p11cf2adf548a2d2bcccfb14add9550a07
References: <20231101114017.1845960-1-chanho61.park@samsung.com>
 <CGME20231101114039epcas2p11cf2adf548a2d2bcccfb14add9550a07@epcas2p1.samsung.com>
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

This imports mmio functions from Linux's arch/riscv/include/asm/mmio.h
to use read/write[b|w|l|q]_relaxed functions.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 arch/riscv/include/asm/io.h | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index b16e6dfa3760..4170877a1ae0 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -323,6 +323,51 @@ static inline void writesl(unsigned int *addr, const void *data, int longlen)
 #define insw_p(port, to, len)		insw(port, to, len)
 #define insl_p(port, to, len)		insl(port, to, len)
 
+/*
+ * Unordered I/O memory access primitives.  These are even more relaxed than
+ * the relaxed versions, as they don't even order accesses between successive
+ * operations to the I/O regions.
+ */
+#define readb_cpu(c)		({ u8  __r = __raw_readb(c); __r; })
+#define readw_cpu(c)		({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
+#define readl_cpu(c)		({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
+
+#define writeb_cpu(v, c)	((void)__raw_writeb((v), (c)))
+#define writew_cpu(v, c)	((void)__raw_writew((__force u16)cpu_to_le16(v), (c)))
+#define writel_cpu(v, c)	((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
+
+#ifdef CONFIG_64BIT
+#define readq_cpu(c)		({ u64 __r = le64_to_cpu((__force __le64)__raw_readq(c)); __r; })
+#define writeq_cpu(v, c)	((void)__raw_writeq((__force u64)cpu_to_le64(v), (c)))
+#endif
+
+/*
+ * Relaxed I/O memory access primitives. These follow the Device memory
+ * ordering rules but do not guarantee any ordering relative to Normal memory
+ * accesses.  These are defined to order the indicated access (either a read or
+ * write) with all other I/O memory accesses to the same peripheral. Since the
+ * platform specification defines that all I/O regions are strongly ordered on
+ * channel 0, no explicit fences are required to enforce this ordering.
+ */
+/* FIXME: These are now the same as asm-generic */
+#define __io_rbr()		do {} while (0)
+#define __io_rar()		do {} while (0)
+#define __io_rbw()		do {} while (0)
+#define __io_raw()		do {} while (0)
+
+#define readb_relaxed(c)	({ u8  __v; __io_rbr(); __v = readb_cpu(c); __io_rar(); __v; })
+#define readw_relaxed(c)	({ u16 __v; __io_rbr(); __v = readw_cpu(c); __io_rar(); __v; })
+#define readl_relaxed(c)	({ u32 __v; __io_rbr(); __v = readl_cpu(c); __io_rar(); __v; })
+
+#define writeb_relaxed(v, c)	({ __io_rbw(); writeb_cpu((v), (c)); __io_raw(); })
+#define writew_relaxed(v, c)	({ __io_rbw(); writew_cpu((v), (c)); __io_raw(); })
+#define writel_relaxed(v, c)	({ __io_rbw(); writel_cpu((v), (c)); __io_raw(); })
+
+#ifdef CONFIG_64BIT
+#define readq_relaxed(c)	({ u64 __v; __io_rbr(); __v = readq_cpu(c); __io_rar(); __v; })
+#define writeq_relaxed(v, c)	({ __io_rbw(); writeq_cpu((v), (c)); __io_raw(); })
+#endif
+
 #include <asm-generic/io.h>
 
 #endif	/* __ASM_RISCV_IO_H */
-- 
2.39.2

