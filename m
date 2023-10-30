Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11709C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 07:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5AE87A0D;
	Mon, 30 Oct 2023 08:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="o/2D6qXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8257A879E5; Mon, 30 Oct 2023 08:32:38 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B213E879EB
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 08:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231030073231epoutp0224639a401840d01f675d0afd002b42fe~S0jjaK9SA1310313103epoutp02j
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 07:32:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231030073231epoutp0224639a401840d01f675d0afd002b42fe~S0jjaK9SA1310313103epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698651151;
 bh=bjw3/ORzYww3ZVaRsqPckoL0vWKLRb6E8nT9Ogrpbj8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o/2D6qXKrDfR4ne0ODLAhKaJzzGXWjfnbv2DaS6mZ1Po/Mu2I5Dbxwv6mfgRnvz+R
 jmfjSI1INH/7+cw0AROXEYVX6GVYkrI7w3DKeLlk7OEnlE/gHyCb6CQJycpYPuWmVp
 95/ZFK4oLW62IRXE+cTXpiyyNm+uq0NnQia8nNEk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20231030073230epcas2p3a4536d6f916a5096bd9bcc3e12fae06c~S0ji5vmnj0946009460epcas2p3v;
 Mon, 30 Oct 2023 07:32:30 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.69]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SJlNF6qbrz4x9Q3; Mon, 30 Oct
 2023 07:32:29 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 86.C7.10022.D0C5F356; Mon, 30 Oct 2023 16:32:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231030073229epcas2p1dce6383581ade83d9dea3df50dd89de9~S0jhqe4G_2104121041epcas2p1t;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231030073229epsmtrp278b74cf6b6caa0a5effab09b3bdd8eca~S0jhp3Jjh2856128561epsmtrp2p;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-35-653f5c0d2721
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F1.26.08755.D0C5F356; Mon, 30 Oct 2023 16:32:29 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231030073229epsmtip146bddcd21341fbe1fbeb982c9c6af4d5~S0jheA9ZV0286002860epsmtip1m;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 1/5] riscv: import read/write_relaxed functions
Date: Mon, 30 Oct 2023 16:32:00 +0900
Message-Id: <20231030073204.150030-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030073204.150030-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTTJc3xj7V4PpRc4vL+7Ut3r44y2hx
 75qcxdu9newWh6d+YLR4fOg1kwObx57Ts5g9PnyM87hzbQ+bx9k7Oxg9+rasYgxgjcq2yUhN
 TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHar6RQlphTChQK
 SCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzuh9upex
 oEGi4vDPG2wNjPNEuhg5OSQETCSWLf/HDGILCexglHg1P66LkQvI/sQo8ezyU2YI5xujxJ2+
 +YwwHY0X5rBAJPYySqx5doEdwpnGJPHz43mwKjYBXYktz18xgiREBFYzSmzb38wOkmAW0Jbo
 /DwFzBYWsJfomPyZCcRmEVCVWH3kKVgzL1C87cNfoN0cQOvkJRY/kAAJcwo4SCyZ8p8JokRQ
 4uTMJywQI+UlmrfOBjtVQuAWu0TXrI8sEKe6SNxq+8QGYQtLvDq+hR3ClpL4/G4vG8T8cokd
 y5IgelsYJZrb9jBD1NhL/Lg5hRWkhllAU2L9Ln2IcmWJI7eg1vJJdBz+yw4R5pXoaBOCaFSX
 OLB9OtQBshLdcz6zQtgeEh8+nGeDBNVkRolJB74yT2BUmIXkm1lIvpmFsHgBI/MqRrHUguLc
 9NRiowJjeAQn5+duYgQnRy33HYwz3n7QO8TIxMF4iFGCg1lJhJfZ0SZViDclsbIqtSg/vqg0
 J7X4EKMpMKgnMkuJJucD03NeSbyhiaWBiZmZobmRqYG5kjjvvda5KUIC6YklqdmpqQWpRTB9
 TBycUg1Mcg66Z/84NKV1ucvuEQqbOHn5frndKZw96llhRXHTVKZdPLJPm9e4l7/nxZmAYztv
 HFteOvF7dlGVb2OkFLvsuyDTzJkfu86Ksk57eSh5YVf2eZ+noXcyVK+9DXjIszB0i6TZU6ni
 2kl/pt73q96q0/D2wbwF1st7VM6alORoaq9lnV+y3O58+2P3gttzd7080vVSYmX7hOU7ws+8
 YVe6HrjumoreugkdEi8dHB62Sb/9lLI2oOHLjL1Hp277bn34Gf9FW5tILR6xU79ajXunPCh9
 cvV3zZOfHgZxFUcPatt+bP67w6PmpzLT4gS3SY/fZt0I+r6Pb3/Kos7SzH8XT/wx5BVeIJb7
 gk3nTv7eFUosxRmJhlrMRcWJAJl7p0EXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnC5vjH2qwdQWDovL+7Ut3r44y2hx
 75qcxdu9newWh6d+YLR4fOg1kwObx57Ts5g9PnyM87hzbQ+bx9k7Oxg9+rasYgxgjeKySUnN
 ySxLLdK3S+DK6H26l7GgQaLi8M8bbA2M80S6GDk5JARMJBovzGHpYuTiEBLYzSjRcnI/E0RC
 VuLZux3sELawxP2WI6wQRZOYJNa++cgMkmAT0JXY8vwVI0hCRGA9o8SP5e9ZQRLMAtoSnZ+n
 gHULC9hLdEz+DDaVRUBVYvWRp4wgNi9QvO3DX6BBHEAb5CUWP5AACXMKOEgsmfIfrFwIqOTx
 m0+sEOWCEidnPmGBGC8v0bx1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0u
 zUvXS87P3cQIDmQtzR2M21d90DvEyMTBeIhRgoNZSYSX2dEmVYg3JbGyKrUoP76oNCe1+BCj
 NAeLkjiv+IveFCGB9MSS1OzU1ILUIpgsEwenVAOTLpPEE65lAS1BSZLn/Oz5vk7Nq3bPWc52
 i4llrnOlzPkUrxw2NZsF6rZTeq9LTLyyWDPm8glZ5rVZCrdnvr3zQllwtcPJFtmd/24LzVl5
 8ZjfPtajInZiQmH+WWcTNOvb3Wb2lr+dfPDW+ca1tX/5ZZ61qdr8rd0Z1CGjWL0oqeptjmqa
 1eK9Tz/90gvePvnbcot4dc4brA3JJS+6VBX0nJwnRH2evm2JqFu7p6jEAa/JliFb6w6zNmq1
 NEsztACTi/u+3O1ytyXzrocz7MzI+fRvpuqXLGch75Uusi7Xz365uepzicnf29f2GJgat+39
 rX1KSdlO/WWYhURaX+wEYc7t4YZduYfit0cdU2Ipzkg01GIuKk4EAMYT+ADTAgAA
X-CMS-MailID: 20231030073229epcas2p1dce6383581ade83d9dea3df50dd89de9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231030073229epcas2p1dce6383581ade83d9dea3df50dd89de9
References: <20231030073204.150030-1-chanho61.park@samsung.com>
 <CGME20231030073229epcas2p1dce6383581ade83d9dea3df50dd89de9@epcas2p1.samsung.com>
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

