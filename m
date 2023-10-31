Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2E1C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 08:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9BE686FF7;
	Tue, 31 Oct 2023 09:56:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="qt4GrT+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C5E874CE; Tue, 31 Oct 2023 09:56:33 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BB4686FBC
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 09:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231031085623epoutp0272b827062d767a078de122406281fdf3~TJWE0dTdx2397023970epoutp02a
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:56:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231031085623epoutp0272b827062d767a078de122406281fdf3~TJWE0dTdx2397023970epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698742583;
 bh=VhQaZpwpqwxcck+vC85iV8O7dMGwIm1tbnINIUuAjwI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qt4GrT+eDQEjK6/tmw3tutfkUNFC88wOF13NbS1NOoQA2vAsGWdkdxoSCmCWU5yMT
 eeQpggd+QII2w2WhAeAc94UvFHYDTkw/++hPLhBpwKoCwQImwhGcEo+i+TjobbqerW
 cGTupBO+AlAR40AHC5nmx9hv+C19sgIbNq9c7uis=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20231031085623epcas2p32f1d1d59bcb59682a5fcc666bd4b2bb4~TJWEjHyOK0538605386epcas2p36;
 Tue, 31 Oct 2023 08:56:23 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SKPBb1bLdz4x9Q8; Tue, 31 Oct
 2023 08:56:23 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 A7.BA.10022.731C0456; Tue, 31 Oct 2023 17:56:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20231031085622epcas2p24e5478072ed8a62ee79235c4993aaad4~TJWD7K4wt0813908139epcas2p2y;
 Tue, 31 Oct 2023 08:56:22 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031085622epsmtrp11e884f51b3123730fd037d5b832d9e08~TJWD6mkC42665426654epsmtrp10;
 Tue, 31 Oct 2023 08:56:22 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-62-6540c1375a5a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 A3.D8.18939.631C0456; Tue, 31 Oct 2023 17:56:22 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031085622epsmtip1298c26a0bd431b8f3286b28ab9e32259~TJWDtbJ-x2884228842epsmtip1s;
 Tue, 31 Oct 2023 08:56:22 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Yanhong Wang <yanhong.wang@starfivetech.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 1/2] riscv: cpu: jh7110: Add gpio helper macros
Date: Tue, 31 Oct 2023 17:55:59 +0900
Message-Id: <20231031085600.992544-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031085600.992544-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmqa75QYdUg3lruSwu79e2ePviLKPF
 272d7BY/uh4xWjw+9JrJgdVjz+lZzB5n7+xg9OjbsorR4/ZZ3gCWqGybjNTElNQihdS85PyU
 zLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKC1SgpliTmlQKGAxOJiJX07m6L8
 0pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjI331zMXNEtUPP57nqWB
 sV2ki5GTQ0LARGLGvlssXYxcHEICOxgldrfvYYNwPjFK3Fj2hB2kCsx59M8HpuPVwRZGiPhO
 RolVfzgg7GlMEkcm8IPYbAK6Eluev2IEGSQi0Moo8f7lYbAGZgFtic7PU8CGCgvYS2w8+5wJ
 xGYRUJW4dWACM4jNCxS/teELkM0BtExeYvEDCZAwp4CDxKI1h6FKBCVOznzCAjFSXqJ562xm
 kF0SAqfYJWYu/sYEcaiLxKKpWxghbGGJV8e3sEPYUhIv+9vYIeaXS+xYlgTR28Io0dy2hxmi
 xl7ix80prCA1zAKaEut36UOUK0scuQW1lk+i4/BfqCm8Eh1tQhCN6hIHtk9ngbBlJbrnfGaF
 sD0kJn5ezwwJ2smMEuu+XmSbwKgwC8k3s5B8Mwth8QJG5lWMYqkFxbnpqcVGBcbw6E3Oz93E
 CE6DWu47GGe8/aB3iJGJg/EQowQHs5II72FTh1Qh3pTEyqrUovz4otKc1OJDjKbAoJ7ILCWa
 nA9MxHkl8YYmlgYmZmaG5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQxcXBKNTDNj7L5L2cS
 F2h7/pNhqoGnG/vyTUZaf4/+654s3PhUyf5Sd96fxu+iwq57vsxtn1obdWDNQdagn5O+vApj
 Xv/jGvdio4ylm7r3sTItZBZTe39eX8+laGI/Q8znwNi6fetXar+3ivht47LE/PCX9ldbjvcz
 BjRNZfou7cP3SFTt0f533xuUjj5sXD25JGFX1r1wi9plG1KW/BA5VP3FeEJaX5hoBO8Sdntu
 ni31D+78XpQl2qb/7u5sue61E87FTMlYreKWLO3mX36S5eO8znJzC604/Ut2j/7lPjm6upTL
 498+0Uum1zUra2Mn3mcp17Y0iTg14/n+4v7nGzWj5G9sefNGrOO3l81JdYnbl/KVWIozEg21
 mIuKEwGJBQPLDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSnK7ZQYdUg3NrjC0u79e2ePviLKPF
 272d7BY/uh4xWjw+9JrJgdVjz+lZzB5n7+xg9OjbsorR4/ZZ3gCWKC6blNSczLLUIn27BK6M
 jffXMxc0S1Q8/nuepYGxXaSLkZNDQsBE4tXBFsYuRi4OIYHtjBK3J31hh0jISjx7twPKFpa4
 33KEFaJoEpNE//IJbCAJNgFdiS3PXzGC2CICnYwSq98VgdjMAtoSnZ+ngDULC9hLbDz7nAnE
 ZhFQlbh1YAIziM0LFL+14QuQzQG0QF5i8QMJkDCngIPEojWHwUqEgErezd7CDlEuKHFy5hMW
 iPHyEs1bZzNPYBSYhSQ1C0lqASPTKkbR1ILi3PTc5AJDveLE3OLSvHS95PzcTYzgYNUK2sG4
 bP1fvUOMTByMhxglOJiVRHgPmzqkCvGmJFZWpRblxxeV5qQWH2KU5mBREudVzulMERJITyxJ
 zU5NLUgtgskycXBKNTDFLtKtWf7mfEvdubViJ9gY9zqc8mG4IOszpcP7gdP0wIdK3Y8+GT9w
 4cv68M5dQ+jY5++uDNtdf5os2v9dIDxJ4mdfWABv+36/78WKir8ep7O3W0k6Lf9vIqis0RlS
 PPeMDU9zRxVXZeNLLR1/00uPrs+fs6Kh9qrmvLwX581cnFY7XAzkXmpmtTD61CPf811Vfpql
 Z/mnqi9WtEjLOPZU9352/jpvySfGjVNnKl85GbZheY/rNdP8tYlJm+y1RK4aqd2Y6euwg9mw
 SUVeLc/bnP8c57HXc66ceBWp+HvZia1v1vtv323p7uaityCzy/Lc3vdlxk8fRE+Uc7rac/1X
 2Bs+vxchGofyZ3OJyiuxFGckGmoxFxUnAgCJmRN0xQIAAA==
X-CMS-MailID: 20231031085622epcas2p24e5478072ed8a62ee79235c4993aaad4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031085622epcas2p24e5478072ed8a62ee79235c4993aaad4
References: <20231031085600.992544-1-chanho61.park@samsung.com>
 <CGME20231031085622epcas2p24e5478072ed8a62ee79235c4993aaad4@epcas2p2.samsung.com>
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

Add gpio.h header file that includes JH7110 helper macros. The file is
imported from StarFive github[1] with small changes such as alignment.

[1]: https://github.com/starfive-tech/u-boot

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 arch/riscv/include/asm/arch-jh7110/gpio.h | 85 +++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 arch/riscv/include/asm/arch-jh7110/gpio.h

diff --git a/arch/riscv/include/asm/arch-jh7110/gpio.h b/arch/riscv/include/asm/arch-jh7110/gpio.h
new file mode 100644
index 000000000000..90aa2f8a9ed4
--- /dev/null
+++ b/arch/riscv/include/asm/arch-jh7110/gpio.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author:	yanhong <yanhong.wang@starfivetech.com>
+ *
+ */
+
+#ifndef _GPIO_STARFIVE_H_
+#define _GPIO_STARFIVE_H_
+
+#include <asm/arch/regs.h>
+
+#define GPIO_NUM_SHIFT		2 /*one dword include 4 gpios*/
+#define GPIO_BYTE_SHIFT		3
+
+#define GPIO_INDEX_MASK		0x3
+
+#define GPIO_DOEN_MASK		0x3f
+#define GPIO_DOUT_MASK		0x7f
+#define GPIO_DIN_MASK		0x7f
+#define GPIO_DS_MASK		0x06
+#define GPIO_DS_SHIFT		1
+#define GPIO_SLEW_MASK		BIT(5)
+#define GPIO_SLEW_SHIFT		5
+#define GPIO_PULL_MASK		0x18
+#define GPIO_PULL_SHIFT		3
+#define GPIO_PULL_UP		1
+#define GPIO_PULL_DOWN		2
+
+#define NR_GPIOS		64
+
+#define GPIO_OFFSET(gpio)	\
+	(((gpio) >> GPIO_NUM_SHIFT) << GPIO_NUM_SHIFT)
+
+#define GPIO_SHIFT(gpio) \
+	(((gpio) & GPIO_INDEX_MASK) << GPIO_BYTE_SHIFT)
+
+enum gpio_state {
+	LOW,
+	HIGH
+};
+
+#define GPIO_DOEN		0x0
+#define GPIO_DOUT		0x40
+#define GPIO_DIN		0x80
+#define GPIO_EN			0xdc
+#define GPIO_LOW_IE		0x100
+#define GPIO_HIGH_IE		0x104
+#define GPIO_CONFIG		0x120
+
+#define SYS_IOMUX_DOEN(gpio, oen) \
+	clrsetbits_le32(JH7110_SYS_IOMUX + GPIO_OFFSET(gpio), \
+		GPIO_DOEN_MASK << GPIO_SHIFT(gpio), \
+		(oen) << GPIO_SHIFT(gpio))
+
+#define SYS_IOMUX_DOUT(gpio, gpo) \
+	clrsetbits_le32(JH7110_SYS_IOMUX + GPIO_DOUT + GPIO_OFFSET(gpio), \
+			GPIO_DOUT_MASK << GPIO_SHIFT(gpio), \
+			((gpo) & GPIO_DOUT_MASK) << GPIO_SHIFT(gpio))
+
+#define SYS_IOMUX_DIN(gpio, gpi)\
+	clrsetbits_le32(JH7110_SYS_IOMUX + GPIO_DIN + GPIO_OFFSET(gpi), \
+			GPIO_DIN_MASK << GPIO_SHIFT(gpi), \
+			((gpio + 2) & GPIO_DIN_MASK) << GPIO_SHIFT(gpi))
+
+#define SYS_IOMUX_SET_DS(gpio, ds) \
+	clrsetbits_le32(JH7110_SYS_IOMUX + GPIO_CONFIG + gpio * 4, \
+			GPIO_DS_MASK, (ds) << GPIO_DS_SHIFT)
+
+#define SYS_IOMUX_SET_SLEW(gpio, slew) \
+	clrsetbits_le32(JH7110_SYS_IOMUX + GPIO_CONFIG + gpio * 4, \
+			GPIO_SLEW_MASK, (slew) << GPIO_SLEW_SHIFT)
+
+#define SYS_IOMUX_SET_PULL(gpio, pull) \
+	clrsetbits_le32(JH7110_SYS_IOMUX + GPIO_CONFIG + gpio * 4, \
+			GPIO_PULL_MASK, (pull) << GPIO_PULL_SHIFT)
+
+#define SYS_IOMUX_COMPLEX(gpio, gpi, gpo, oen) \
+	do { \
+		SYS_IOMUX_DOEN(gpio, oen); \
+		SYS_IOMUX_DOUT(gpio, gpo); \
+		SYS_IOMUX_DIN(gpio, gpi); \
+	} while (0)
+
+#endif /* _GPIO_STARFIVE_H_ */
-- 
2.39.2

