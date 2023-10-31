Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316F3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 08:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C93287506;
	Tue, 31 Oct 2023 09:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ViDcE02C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1FBC86FBC; Tue, 31 Oct 2023 09:56:33 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F5D8702C
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 09:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231031085624epoutp04d0997c66ecd543d333e751b76fc7c32b~TJWFQ4XCm1237812378epoutp04E
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:56:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231031085624epoutp04d0997c66ecd543d333e751b76fc7c32b~TJWFQ4XCm1237812378epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698742584;
 bh=kYCzIlVj89POu/jnlA0IlIqtH/WSdaMAINWqPsvFl3Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ViDcE02CPhReiRzkLL0z+bt1sZ9CAn27QiZkfRQrw4CGMsRf0rHnmJTPNEE5mCVci
 YySl3c7+ysj7lGOb44WbYASaVhi+42oG8JrsjyFGwOBHtZb4pPo9QJM2p3yzGhM/w7
 kTkwuJMQQbEihdGDylam3dtvtXQQGr7UA1S/xaJE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20231031085624epcas2p274a9d61a8a92189b632db161c7d58ccf~TJWFCUKP20596605966epcas2p2C;
 Tue, 31 Oct 2023 08:56:24 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.101]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SKPBb2MF6z4x9Q6; Tue, 31 Oct
 2023 08:56:23 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 06.C0.08648.731C0456; Tue, 31 Oct 2023 17:56:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20231031085623epcas2p2db84ad3e0578fc0014b109edea4462b7~TJWEAnyPd0813908139epcas2p2z;
 Tue, 31 Oct 2023 08:56:23 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231031085622epsmtrp2ddcc9da6204d71836e3f1af81e5d5f64~TJWEAGH911663616636epsmtrp2T;
 Tue, 31 Oct 2023 08:56:22 +0000 (GMT)
X-AuditID: b6c32a43-721fd700000021c8-e9-6540c137d9d6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 C3.D8.18939.631C0456; Tue, 31 Oct 2023 17:56:22 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031085622epsmtip1f3d31a740dd4b33e89bd176029501dbc~TJWD0dOd51937519375epsmtip12;
 Tue, 31 Oct 2023 08:56:22 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Yanhong Wang <yanhong.wang@starfivetech.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 2/2] board: starfive: spl: Support jtag for VisionFive2 board
Date: Tue, 31 Oct 2023 17:56:00 +0900
Message-Id: <20231031085600.992544-3-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031085600.992544-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmua75QYdUg00nBS0u79e2ePviLKPF
 272d7BY/uh4xWjw+9JrJgdVjz+lZzB5n7+xg9OjbsorR4/ZZ3gCWqGybjNTElNQihdS85PyU
 zLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKC1SgpliTmlQKGAxOJiJX07m6L8
 0pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjFObH7AW/OWpeNp3nL2B
 8RxXFyMnh4SAicT+t8vZuxi5OIQEdjBKPO7/ygbhfGKUmHb0HoJzdc4VJpiWReueQSV2Mkq8
 u9LMCpIQEpjGJLHwtiGIzSagK7Hl+StGkCIRgVZGifcvDzOCJJgFtCU6P09hB7GFBfwlbs3o
 AIuzCKhKrG2HiPMK2Eu87W4HinMAbZOXWPxAAiTMKeAgsWjNYWaIEkGJkzOfsECMlJdo3jqb
 GWSXhMAxdolzFxezQvS6SOx+pgNxtLDEq+Nb2CFsKYnP7/ayQZSUS+xYlgTR2sIo0dy2hxmi
 xl7ix80pYGOYBTQl1u/ShyhXljhyC2orn0TH4b/sEGFeiY42IYhGdYkD26ezQNiyEt1zPrNC
 2B4SD84dZ4KE2mRGibmdr1gnMCrMQvLMLCTPzEJYvICReRWjWGpBcW56arJRgSE8fpPzczcx
 ghOhlvMOxivz/+kdYmTiYDzEKMHBrCTCe9jUIVWINyWxsiq1KD++qDQntfgQoykwpCcyS4km
 5wNTcV5JvKGJpYGJmZmhuZGpgbmSOO+91rkpQgLpiSWp2ampBalFMH1MHJxSDUwL7WQyVVXW
 K92eZ9AbxM8nf6Ph/xn3B4KMq2a0Sl84I5HM1KJvH3Vc4deShscuggkMz3KlDVz+utiZTnJr
 f5Xrkr5UpL88l+HCgXfO7V+82xwsPqTcfD7N9LSlQWUBz+0HzevNtMQay5qCeYL4JnsssD9y
 /dLPPV8u/WHxk/8nYKNhvHfxfqu7Seorg+3Xd+46wLYu98rTmDuphiWCzh21Vik1/hs6G7b/
 CmLJns9eWx5zmikyl3H3Cf+vTIeyMqdNSev382e49d5BoHSJ64VE+ycnVh69w9eg+Dl3gZWk
 cRNfVZr8f/OfqllGHW6NT4xbRbrLLsx0z+9PeqFSffOWgd+2F9XT3B/OvJupxFKckWioxVxU
 nAgAf/CMbQ0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSnK7ZQYdUg7fbzC0u79e2ePviLKPF
 272d7BY/uh4xWjw+9JrJgdVjz+lZzB5n7+xg9OjbsorR4/ZZ3gCWKC6blNSczLLUIn27BK6M
 U5sfsBb85al42necvYHxHFcXIyeHhICJxKJ1z9hAbCGB7YwS20/KQ8RlJZ6928EOYQtL3G85
 wtrFyAVUM4lJYn73C7AEm4CuxJbnrxhBbBGBTkaJ1e+KQGxmAW2Jzs9TwGqEBXwlzjR8B6th
 EVCVWNsOEecVsJd4290OFOcAWiAvsfiBBEiYU8BBYtGaw8wQ99hLvJu9BapcUOLkzCcsEOPl
 JZq3zmaewCgwC0lqFpLUAkamVYyiqQXFuem5yQWGesWJucWleel6yfm5mxjBoaoVtINx2fq/
 eocYmTgYDzFKcDArifAeNnVIFeJNSaysSi3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2a
 WpBaBJNl4uCUamAq/7FjUfjr8L0RrA+7D7z7sm796nPHS35nneM6cMv8X2mbfOsZJvVjxZ2T
 vBqezc1o7+bc3qT0rdZFm3faPz2DJSs5TisW6zxQrRS4v69gPXfVs6cC3g++znkoxNAe+mNy
 4sGOaRs+5JmxbFG6HDHn492X+capVmwy3itjZZWD3v9+cvGX7VLZn6ofKzv17/hHTVyyQW3e
 5ujPy2b4BCcZuLz5vbm2bmLL+l1P79Vx9jcpPFic4O+/2zKTdTNf1weB5Wt1X757uK8y7qjj
 oXqt1NWOfnMPNUYdmX5/4doVRqkCZ6qvMf9LlNgyRz5M88+30+8uyOxWEDU4cynp2dwFx/r1
 1V3fTzArPrrIhynunBJLcUaioRZzUXEiABTNrYzEAgAA
X-CMS-MailID: 20231031085623epcas2p2db84ad3e0578fc0014b109edea4462b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031085623epcas2p2db84ad3e0578fc0014b109edea4462b7
References: <20231031085600.992544-1-chanho61.park@samsung.com>
 <CGME20231031085623epcas2p2db84ad3e0578fc0014b109edea4462b7@epcas2p2.samsung.com>
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

JTAG pins are mapped as below. To access the JTAG pins, we need to
control the GPIO pins from SPL which seems to be the earliest stage for
JTAG.

- JTAG nTRST:	GPIO36 / Input
- JTAG TDI:	GPIO61 / Input
- JTAG TMS:	GPIO63 / Input
- JTAG TCK:	GPIO60 / Input
- JTAG TDO:	GPIO44 / Output

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 board/starfive/visionfive2/spl.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index ad5f71a20180..336f0cdfc90f 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -6,6 +6,7 @@
 
 #include <common.h>
 #include <asm/arch/eeprom.h>
+#include <asm/arch/gpio.h>
 #include <asm/arch/regs.h>
 #include <asm/arch/spl.h>
 #include <asm/io.h>
@@ -172,10 +173,32 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
 	/* Update the memory size which read form eeprom or DT */
 	fdt_fixup_memory(spl_image->fdt_addr, 0x40000000, gd->ram_size);
 }
+
+static void jh7110_jtag_init(void)
+{
+	/* nTRST: GPIO36 */
+	SYS_IOMUX_DOEN(36, HIGH);
+	SYS_IOMUX_DIN(36, 4);
+	/* TDI: GPIO61 */
+	SYS_IOMUX_DOEN(61, HIGH);
+	SYS_IOMUX_DIN(61, 19);
+	/* TMS: GPIO63 */
+	SYS_IOMUX_DOEN(63, HIGH);
+	SYS_IOMUX_DIN(63, 20);
+	/* TCK: GPIO60 */
+	SYS_IOMUX_DOEN(60, HIGH);
+	SYS_IOMUX_DIN(60, 29);
+	/* TDO: GPIO44 */
+	SYS_IOMUX_DOEN(44, 8);
+	SYS_IOMUX_DOUT(44, 22);
+}
+
 int spl_board_init_f(void)
 {
 	int ret;
 
+	jh7110_jtag_init();
+
 	ret = spl_soc_init();
 	if (ret) {
 		debug("JH7110 SPL init failed: %d\n", ret);
-- 
2.39.2

