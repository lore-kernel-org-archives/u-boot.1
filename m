Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25CBC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 23:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0003387B9F;
	Wed,  1 Nov 2023 00:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="uFds8mAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4196A879E2; Wed,  1 Nov 2023 00:56:05 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57FB187ACA
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 00:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231031235554epoutp04c5fddb60f676b9b0b41a0bce8dace59e~TVncu6mYs1062510625epoutp04U
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 23:55:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231031235554epoutp04c5fddb60f676b9b0b41a0bce8dace59e~TVncu6mYs1062510625epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698796554;
 bh=kU3bcniLBykrhz2Gcd46oTDCmOzkHV9G3b8LfQDR4Zs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uFds8mAr4YsfxjwO+9uKFskerLuEXsAxDeB9lsg/qLkYUtLw1JSeMqc27wrYyo/t7
 mgk5WEctdYwFAweNiKtCcPDSUSbIpCgx2SRwGj+AN/nNPnmy1HY7icrqJqpGKHiFCY
 CUy8q9grLc1Y6BGYLyZyvpSUrIHe0iM6weYwnGRE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231031235553epcas2p4006a4215e733219f14e20e00186812a0~TVncZUb1I0985109851epcas2p4h;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SKn8T4jhYz4x9Pv; Tue, 31 Oct
 2023 23:55:53 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 5E.B8.09622.90491456; Wed,  1 Nov 2023 08:55:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20231031235553epcas2p3b61666e3169f4b9a8260beb9073c10a1~TVnbwicpJ0155801558epcas2p3O;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231031235553epsmtrp251a06b433d0281a630ddd3db020d5adb~TVnbwAGLq0628406284epsmtrp28;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
X-AuditID: b6c32a46-d61ff70000002596-a3-654194098ad4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 44.C7.08817.90491456; Wed,  1 Nov 2023 08:55:53 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031235553epsmtip16d48fb7119753a6389d333317f16d18a~TVnbiaeki0185301853epsmtip1B;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 2/5] clk: starfive: jh7110: Add security clocks
Date: Wed,  1 Nov 2023 08:55:27 +0900
Message-Id: <20231031235530.1500393-3-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031235530.1500393-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTTJdzimOqwdSZShaX92tbvH1xltHi
 3jU5i7d7O9ktDk/9wGjx+NBrJgc2jz2nZzF7fPgY53Hn2h42j7N3djB69G1ZxRjAGpVtk5Ga
 mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
 kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnbHoVg9L
 wUP2isa/P1gbGPezdTFyckgImEgsb3sJZHNxCAnsYJRYcmMiC4TziVHi/K+JjBDON0aJGW8/
 MMG0TO37wghiCwnsZZRYuSMEomgak8Sx7gMsIAk2AV2JLc9fgXWLCKxmlNi2v5kdJMEsoC3R
 +XkKmC0s4CTR+Wce2CQWAVWJgw86WEFsXgEHiQsT5gDVcABtk5dY/EACJMwp4Chx6uw7NogS
 QYmTM5+wQIyUl2jeOpsZZJeEwDV2iWcrDkBd6iIx6VozK4QtLPHq+BZ2CFtK4vO7vWwQ88sl
 dixLguhtYZRobtvDDFFjL/Hj5hRWkBpmAU2J9bv0IcqVJY7cglrLJ9Fx+C/UlbwSHW1CEI3q
 Ege2T2eBsGUluud8hjrAQ+Jr2xJoSE9hlJi37gDLBEaFWUi+mYXkm1kIixcwMq9iFEstKM5N
 Ty02KjCCR3Byfu4mRnBy1HLbwTjl7Qe9Q4xMHIyHGCU4mJVEeA+bOqQK8aYkVlalFuXHF5Xm
 pBYfYjQFBvVEZinR5Hxges4riTc0sTQwMTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaP
 iYNTqoEpeYF2ZNcRvoAvJjkuX/RkXXrNUq4VL9vH3ekyRYjved7k17Hi/wWLPy58ptr572ui
 UtfuuIjJB4r05J+uPMHT1qbRrO+luKAvn+mC5tqWGVbh+6YJHkv8fOf36rf5dtUxCtoy69VV
 rI4eWyfdVZBov222tfiUm93/7go494jNaDi9fG7H4vsut9X/8Lz8dfL0/wbvN0bNZnvz8vS5
 YjRffakyOaqfNnvKhOtvC0JtUk/I3/r2qegT990LPWem7CpaIGp22UlcKb1aUqZZ3erixMfH
 njvWhp5Yq6685dL1ueXVH5+Wda6OnSWl6SaTsrD11nWVHT8+c25ca3pNOuG6Tvuj13+YNjlH
 JAU3rWZUYinOSDTUYi4qTgQA6Cj1khcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSnC7nFMdUg1NNvBaX92tbvH1xltHi
 3jU5i7d7O9ktDk/9wGjx+NBrJgc2jz2nZzF7fPgY53Hn2h42j7N3djB69G1ZxRjAGsVlk5Ka
 k1mWWqRvl8CVsehWD0vBQ/aKxr8/WBsY97N1MXJySAiYSEzt+8IIYgsJ7GaUWHepFCIuK/Hs
 3Q52CFtY4n7LEVaImklMEh3XbUFsNgFdiS3PXwH1cnGICKxnlPix/D1YEbOAtkTn5ylgzcIC
 ThKdf+aBLWARUJU4+KADrIZXwEHiwoQ5QDUcQAvkJRY/kAAJcwo4Spw6+44NYpeDxIeJk9gh
 ygUlTs58wgIxXl6ieets5gmMArOQpGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66X
 nJ+7iREcxFpaOxj3rPqgd4iRiYPxEKMEB7OSCO9hU4dUId6UxMqq1KL8+KLSnNTiQ4zSHCxK
 4rzfXvemCAmkJ5akZqemFqQWwWSZODilGpiMqlwzJoisbbtyNi2FaeOJbmc/52MX9EXtv/7Y
 rDWPy7ylKifaQuWcp82EiOLcCmHbtwrnt/4W1557qTLha8BjTjanHMfLRc8eFKUs8Ovo2H/l
 2wcx81u+2b/4n1/Ls0t8w7R3u5DHG5eAaxfiQ6pX2EYu3LGl9XA204zom/t6jna+PvW31alW
 h3tCdcWLjIerf+dOnvz6adftNVsWt5/cbb6rRFXbW3z/q1u7DVcWOsn7zCv8IKp6NMjP3dNP
 98Dmojau4wrJpqIK38OiHBSLPnzc8EPL9UB96flodyal7P7C5Qx13rPPVknU7JL5Gxw8VzWg
 W7HT+3WFSPi8Z7rLKnxndZ5l83nM5swqq8RSnJFoqMVcVJwIAJaLKKHRAgAA
X-CMS-MailID: 20231031235553epcas2p3b61666e3169f4b9a8260beb9073c10a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031235553epcas2p3b61666e3169f4b9a8260beb9073c10a1
References: <20231031235530.1500393-1-chanho61.park@samsung.com>
 <CGME20231031235553epcas2p3b61666e3169f4b9a8260beb9073c10a1@epcas2p3.samsung.com>
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

Add STGCLK_SEC_HCLK and STGCLK_SEC_MISCAHB clocks for JH7110 TRNG
device.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/clk/starfive/clk-jh7110.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/starfive/clk-jh7110.c b/drivers/clk/starfive/clk-jh7110.c
index 31aaf3340f94..a835541e48e9 100644
--- a/drivers/clk/starfive/clk-jh7110.c
+++ b/drivers/clk/starfive/clk-jh7110.c
@@ -539,6 +539,16 @@ static int jh7110_stgcrg_init(struct udevice *dev)
 				 "pcie1_tl", "stg_axiahb",
 				 OFFSET(JH7110_STGCLK_PCIE1_TL)));
 
+	/* Security clocks */
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_SEC_HCLK),
+	       starfive_clk_gate(priv->reg,
+				 "sec_ahb", "stg_axiahb",
+				 OFFSET(JH7110_STGCLK_SEC_HCLK)));
+	clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_SEC_MISCAHB),
+	       starfive_clk_gate(priv->reg,
+				 "sec_misc_ahb", "stg_axiahb",
+				 OFFSET(JH7110_STGCLK_SEC_MISCAHB)));
+
 	return 0;
 }
 
-- 
2.39.2

