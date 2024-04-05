Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2ACC67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 16:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 861B188465;
	Fri,  5 Apr 2024 18:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="YULnrLc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CF1988469; Fri,  5 Apr 2024 18:16:44 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A1308845D
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 18:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=482502c049=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 435EZbx0030619; Fri, 5 Apr 2024 18:16:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=ld332YC
 OaCBFkcO37QfO0KXWTfHnAU9fFlo7oW1yIgA=; b=YULnrLc5P2C2eaCUY8XjSnS
 I6oMHOUrkZPNQ0Qs2eoXRv7Ryo0inmWsAi5paRJIR0UnJOsW6BxcR9sOCLveOUuR
 vVt8h1GHSEpnh1XYeFglVmmQBuU5PvSlFigcctSZ/d+UgeemuwtXvM0by/wURf91
 IMY8Oub7gVg+kzfWZ0mPX+ALAn2Gd13KMdSDnabsTY+dpSbe/GGFm43V5Za3OyKV
 JFn/jtWI8k+OHqbSYHI8sqAMz0XSJgrArVadxYyFV6CaHsE4tnLd3l7sxh/8fWvD
 tBsJoOgMnbHP0Iu44ojG03a7l2EVhkEXokakn9uyUIXCIf9mzuoiRloKVvVv7ug=
 =
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x9emv8jty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Apr 2024 18:16:36 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 164A84002D;
 Fri,  5 Apr 2024 18:16:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C1CE821684D;
 Fri,  5 Apr 2024 18:15:32 +0200 (CEST)
Received: from localhost (10.252.29.225) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 5 Apr
 2024 18:15:32 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Elmar Psilog <epsi@gmx.de>, Joe
 Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Ley Foon Tan
 <leyfoon.tan@starfivetech.com>, Ramon Fried <rfried.dev@gmail.com>, Sean
 Anderson <seanga2@gmail.com>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH] net: dwc_eth_qos: Fix compilation warning in eqos_free_pkt()
Date: Fri, 5 Apr 2024 18:15:29 +0200
Message-ID: <20240405161529.1419902-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.29.225]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_17,2024-04-05_01,2023-05-22_02
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

Fix compilation warning:

../arch/arm/include/asm/io.h: In function 'eqos_free_pkt':
../arch/arm/include/asm/io.h:103:32: warning: 'rx_desc' may be used uninitialized [-Wmaybe-uninitialized]
  103 | #define writel(v,c)     ({ u32 __v = v; __iowmb(); __arch_putl(__v,c); __v; })
      |                                ^~~
../drivers/net/dwc_eth_qos.c:1220:27: note: 'rx_desc' was declared here
 1220 |         struct eqos_desc *rx_desc;
      |                           ^~~~~~~

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 drivers/net/dwc_eth_qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 9b3bce1dc87..9df3dde14f1 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1217,7 +1217,7 @@ static int eqos_free_pkt(struct udevice *dev, uchar *packet, int length)
 	struct eqos_priv *eqos = dev_get_priv(dev);
 	u32 idx, idx_mask = eqos->desc_per_cacheline - 1;
 	uchar *packet_expected;
-	struct eqos_desc *rx_desc;
+	struct eqos_desc *rx_desc = NULL;
 
 	debug("%s(packet=%p, length=%d)\n", __func__, packet, length);
 
-- 
2.25.1

