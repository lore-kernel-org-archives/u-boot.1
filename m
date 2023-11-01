Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA63C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 12:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A37287CF4;
	Wed,  1 Nov 2023 13:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="CkG+Wxh7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 299AF87702; Wed,  1 Nov 2023 13:17:37 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C881087AEF
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 13:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231101121717epoutp0140241e761841de5c16d2b17c4a389964~Tfuw0bAnp1980119801epoutp01g
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:17:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231101121717epoutp0140241e761841de5c16d2b17c4a389964~Tfuw0bAnp1980119801epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698841037;
 bh=bjw3/ORzYww3ZVaRsqPckoL0vWKLRb6E8nT9Ogrpbj8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CkG+Wxh7epZqgc+a3HzWTGRSzBUVQs+w37YqeIVIpuqUpjKP1HRc82J22Ek7KCV73
 9AARTl0JBNlVzCztJVgi6mZyW4BkMO3Oj7CaIgudNah7roxIj2MJ6rr9QXN9k/HVSu
 wUg5PBq2ihV/lS/F+G4BGlOzUTbtbOuUyNquRWAU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20231101121717epcas2p3adb2a277df8220595072cf1b21b43569~TfuwgF5sK1994519945epcas2p3t;
 Wed,  1 Nov 2023 12:17:17 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SL5bw3nTjz4x9Pw; Wed,  1 Nov
 2023 12:17:16 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 0A.13.10022.CC142456; Wed,  1 Nov 2023 21:17:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20231101121716epcas2p335461b14cfdeb28ed5682c295f9170d3~TfuviBcfy2435424354epcas2p3X;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101121716epsmtrp28c4f88c6f87977b7de8b9f8de4ab8f13~TfuvhcWxT2459324593epsmtrp2K;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-5b-654241cc505a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 8E.68.08755.BC142456; Wed,  1 Nov 2023 21:17:15 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101121715epsmtip1bfee132d98fca88d677b0afb3d3cabd0~TfuvV4HQb0809708097epsmtip1H;
 Wed,  1 Nov 2023 12:17:15 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v4 1/5] riscv: import read/write_relaxed functions
Date: Wed,  1 Nov 2023 21:16:48 +0900
Message-Id: <20231101121652.1865516-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101121652.1865516-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdljTVPeMo1OqwYcHkhaX92tb3PjVxmrx
 9sVZRot71+Qs3u7tZLc4PPUDo8XjQ6+ZHNg99pyexezx4WOcx51re9g8zt7ZwejRt2UVYwBr
 VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
 iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTs
 jN6nexkLGiQqDv+8wdbAOE+ki5GTQ0LAROLPl1bWLkYuDiGBHYwSM5YuZoNwPjFKfH/Xwwjh
 fGOUmLjgJCtMy+Ufd6Fa9jJK7Hz0C6pqGpPEkd8NTCBVbAK6EluevwJLiAhcZZR4P+sNM0iC
 WUBbovPzFHYQW1jASaL50k0wm0VAVeLHlZVgNq+Ag8TMS1+BbA6gdfISix9IgIQ5BRwlrjav
 Z4YoEZQ4OfMJC8RIeYnmrbOZQXZJCDxil5g3aQrUqS4SXw9vZ4GwhSVeHd/CDmFLSXx+t5cN
 Yn65xI5lSRC9LYwSzW17mCFq7CV+3ASZwwG0QFNi/S59iHJliSO3oNbySXQc/gt1Ja9ER5sQ
 RKO6xIHt06GWykp0z/kMdYyHxKXn85ggQTWFUWLO75/sExgVZiH5ZhaSb2YhLF7AyLyKUSy1
 oDg3PbXYqMAYHsPJ+bmbGMGJUst9B+OMtx/0DjEycTAeYpTgYFYS4T1s6pAqxJuSWFmVWpQf
 X1Sak1p8iNEUGNQTmaVEk/OBqTqvJN7QxNLAxMzM0NzI1MBcSZz3XuvcFCGB9MSS1OzU1ILU
 Ipg+Jg5OqQYmzrK6LWdP6M+98e+mEl+Ofo1d54uCVd1LQiw0P+5/teSrpbTamfXHO+6ssfRd
 vtvKLmn9LoYSQ2X1hlp37q+PhZ/ePhM77YOW6c3Tq/f8CWEQk1WJcmKXfjgr0D7l1wm2pYZf
 16U1Bib/2mjDV2aXZnYvXH1q+co5Qe6rY6cLHoiXXB1cKHChsSRBfcFkez12PQmeZf+XHrN5
 wOgnJsD+6/ICz3PLMq2bE5zPhRgZNR0s53CWfZn8dKGZ3cTrj1cvtTpsPWWTjOz0c5OuVqQ8
 bJzA9PPmo2Sjy/9iDM42uSU9i3vo3nP8cTzbky2JRlP+xLZmBNtZz3sixvKx9bVrEVvjj4R1
 1zYvjMlTmyOsxFKckWioxVxUnAgAdeciYR0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnO5pR6dUg68vLS0u79e2uPGrjdXi
 7YuzjBb3rslZvN3byW5xeOoHRovHh14zObB77Dk9i9njw8c4jzvX9rB5nL2zg9Gjb8sqxgDW
 KC6blNSczLLUIn27BK6M3qd7GQsaJCoO/7zB1sA4T6SLkZNDQsBE4vKPu6xdjFwcQgK7GSUu
 /57MDJGQlXj2bgc7hC0scb/lCFTRJCaJv4snsoAk2AR0JbY8f8UIkhARuMkosXDOV7AEs4C2
 ROfnKWDdwgJOEs2XboLZLAKqEj+urASzeQUcJGZe+gpkcwBtkJdY/EACJMwp4ChxtXk92BFC
 QCXvlrxngygXlDg58wnUeHmJ5q2zmScwCsxCkpqFJLWAkWkVo2RqQXFuem6xYYFhXmq5XnFi
 bnFpXrpecn7uJkZwSGtp7mDcvuqD3iFGJg7GQ4wSHMxKIryHTR1ShXhTEiurUovy44tKc1KL
 DzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBKNTDJR3gt5156Outs1q1zlo953zvxq6hu
 ORqcf//w/NsHjF6uqb73+8H9czdWBKVf0hJSvLNEx+9PXenxYBn7zfmvzqqe/5K05/InC3GL
 dXlrem5PqDB94PanvLzq+ouYeIZgvyP2Ny6VWOi8XvtNrFBcZOk3XWFzno/zWFQiP+t+WBWz
 LSf9ftZjTbu3ISdeXtLadVpaoYK1ZYqk1t/Gh+765QJ7d+bba0/y3r9sMZMKg5e18w87LsFj
 nxktlFbP3tsi8sswpeIRk10Xv2ZIxpOXO25mn7gxV/950qE5P+rf1h/aeGJCh+i5es6EqWXu
 3EJ3lU7V/xH4K98QHPC1ZSG7viX/xPw+ltiHX87ssl+oxFKckWioxVxUnAgAshmmw9gCAAA=
X-CMS-MailID: 20231101121716epcas2p335461b14cfdeb28ed5682c295f9170d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101121716epcas2p335461b14cfdeb28ed5682c295f9170d3
References: <20231101121652.1865516-1-chanho61.park@samsung.com>
 <CGME20231101121716epcas2p335461b14cfdeb28ed5682c295f9170d3@epcas2p3.samsung.com>
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

