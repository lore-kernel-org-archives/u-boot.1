Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656CAC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 11:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B6A387AEF;
	Wed,  1 Nov 2023 12:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="GG/drNMu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A1187705; Wed,  1 Nov 2023 12:40:53 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B126876D9
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231101114041epoutp01a7cf26fdcacb2e0b6a856e67fec01b7a~TfOzm_aOU0432704327epoutp01X
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 11:40:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231101114041epoutp01a7cf26fdcacb2e0b6a856e67fec01b7a~TfOzm_aOU0432704327epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698838841;
 bh=kU3bcniLBykrhz2Gcd46oTDCmOzkHV9G3b8LfQDR4Zs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GG/drNMumq41aV7OV9WxhZKdoDhgP2dTQgyL+IbvyrlB1owy7Kj8Q++dgEOkz0twa
 GWRKMY4Tuti0hAUocTl/62sT9pMgOTkmnSGNYxQSbaHcZPlmVne+QVhFxIlHfraCT1
 WZmZdrM5mVQZcKvoZ8gosDAOya1h8d9TtTPgbFI4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231101114040epcas2p45f9c5e1298e660af8c0f8102f1186707~TfOy_qJhU3105431054epcas2p4K;
 Wed,  1 Nov 2023 11:40:40 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.90]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SL4nh2v7sz4x9Pv; Wed,  1 Nov
 2023 11:40:40 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DB.23.18994.83932456; Wed,  1 Nov 2023 20:40:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20231101114039epcas2p2586493c48007dd8c0671cad76663f6f2~TfOySweQ12672126721epcas2p2v;
 Wed,  1 Nov 2023 11:40:39 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231101114039epsmtrp1e0945ea6521c6f292aad7a6512ad0cfe~TfOySGc4_2749427494epsmtrp1F;
 Wed,  1 Nov 2023 11:40:39 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-c5-654239385230
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D8.A5.07368.73932456; Wed,  1 Nov 2023 20:40:39 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101114039epsmtip1a03d5db2ea1e9986e8824b3896e55004~TfOyDm2H01789117891epsmtip1v;
 Wed,  1 Nov 2023 11:40:39 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 2/5] clk: starfive: jh7110: Add security clocks
Date: Wed,  1 Nov 2023 20:40:14 +0900
Message-Id: <20231101114017.1845960-3-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101114017.1845960-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdljTTNfC0inVYOdiAYvL+7UtbvxqY7V4
 ++Iso8W9a3IWb/d2slscnvqB0eLxoddMDuwee07PYvb48DHO4861PWweZ+/sYPTo27KKMYA1
 KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gIJYWy
 xJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2
 xqJbPSwFD9krGv/+YG1g3M/WxcjJISFgIrH9+HtmEFtIYA+jxMe1oV2MXED2J0aJvu0X2CCc
 b4wSR7p2scB0NCydzgiR2Mso0X/7FhOEM41JYs3Cf2Cz2AR0JbY8fwVWJSJwlVHi/aw3YAlm
 AW2Jzs9T2EFsYQEnibt9O8FsFgFViR+314AdxSvgIHH0w0KgqRxA6+QlFj+QAAlzCjhKrGz7
 A1UiKHFy5hMWiJHyEs1bZzOD7JIQeMQuMe3cJCaIU10klrRfYYSwhSVeHd/CDmFLSbzsb2OH
 mF8usWNZEkRvC6NEc9seZogae4kfN6ewgtQwC2hKrN+lD1GuLHHkFtRaPomOw3+hpvBKdLQJ
 QTSqSxzYPh0aVrIS3XM+s0LYHhJnF01mhQTVFGC4PZzMOIFRYRaSb2Yh+WYWwuIFjMyrGKVS
 C4pz01OTjQoMdfNSy+GRnJyfu4kRnC61fHcwvl7/V+8QIxMH4yFGCQ5mJRHew6YOqUK8KYmV
 ValF+fFFpTmpxYcYTYHBPZFZSjQ5H5iw80riDU0sDUzMzAzNjUwNzJXEee+1zk0REkhPLEnN
 Tk0tSC2C6WPi4JRqYGrQOOiemXt1yst565fvfOaz0bBqj5/Erhn7t7YE/j94zelr38qao+tt
 nn6YmcoRvkVY/FzrfTuZKd+v3zfJeHPQ+q+F/vwAk7rO/DJBcXFhu5R5fObOyRNTrViuvy9g
 aP8tE+EkfGLmHa3jS0ru5F4wWPXlpjL/tRMu0/mnfJ52VWBjVFNDLk9/T0xP1YWPM9b5/1Sa
 s5T3hk6iwrRt4pGzOoWUW/+F3hZ7zWSxWCiq+yJD/oS7i+vd/Y5ma25eZbflo8GmnT3rJjzY
 65Iofon/cv3JhoZ3SrHFpUU1QlaTvfIaFizXShK79+zq8QPeovr3X5l5pNT+ObPk1g2d8JWT
 Nqx7GxK/v4ZNe1XGgRdKLMUZiYZazEXFiQD1ZftfIAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnK65pVOqwf2PphaX92tb3PjVxmrx
 9sVZRot71+Qs3u7tZLc4PPUDo8XjQ6+ZHNg99pyexezx4WOcx51re9g8zt7ZwejRt2UVYwBr
 FJdNSmpOZllqkb5dAlfGols9LAUP2Ssa//5gbWDcz9bFyMkhIWAi0bB0OmMXIxeHkMBuRonf
 N6ayQyRkJZ692wFlC0vcbznCClE0iUliwvJVjCAJNgFdiS3PX4F1iwjcZJRYOOcrC0iCWUBb
 ovPzFLBuYQEnibt9O8FsFgFViR+314Ct5hVwkDj6YSFTFyMH0AZ5icUPJEDCnAKOEivb/oCV
 CAGVzL29khWiXFDi5MwnUOPlJZq3zmaewCgwC0lqFpLUAkamVYySqQXFuem5yYYFhnmp5XrF
 ibnFpXnpesn5uZsYwSGtpbGD8d78f3qHGJk4GA8xSnAwK4nwHjZ1SBXiTUmsrEotyo8vKs1J
 LT7EKM3BoiTOazhjdoqQQHpiSWp2ampBahFMlomDU6qBadVD5dlLex9ure2YoH931m27/BVH
 JBl35n4RtNio+vZu/byvOZM322ua9e4OF+cNi7lwf5pka6SHYn2C2EozT2Enk638R9hXHDz3
 L/7au9ZzTWXPZ27467hTwc56jsOTxL3/DxQyqk/Ra81j7q07vEx2ruTr84l//doeNyRw3F3h
 dLH6fYBQSIJm6TUlt1hVS1XJC++2bqzes039/mOHaQWde95O++6Q0xF2SScsK74/f41OoeBd
 j40SNft50+b8+/f9UZWr4Yx05bSd9wolfaMYP4YGbwlVvfvv97zofy8Tqs535r27lHgxuTXx
 0d7JT7J2Hgzeum/NDZ0X8T/cn9Uq6/mlGPCriMatb5vhqcRSnJFoqMVcVJwIANqJAOrYAgAA
X-CMS-MailID: 20231101114039epcas2p2586493c48007dd8c0671cad76663f6f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101114039epcas2p2586493c48007dd8c0671cad76663f6f2
References: <20231101114017.1845960-1-chanho61.park@samsung.com>
 <CGME20231101114039epcas2p2586493c48007dd8c0671cad76663f6f2@epcas2p2.samsung.com>
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

