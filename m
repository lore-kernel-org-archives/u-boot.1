Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAA3C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 07:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA83879EF;
	Mon, 30 Oct 2023 08:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="PzAM87aL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FA21879EF; Mon, 30 Oct 2023 08:32:36 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8827E879D9
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 08:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231030073230epoutp0113f031a4509309f2022ab7a075ed4f0a~S0jjOeYCE2164421644epoutp01B
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 07:32:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231030073230epoutp0113f031a4509309f2022ab7a075ed4f0a~S0jjOeYCE2164421644epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698651150;
 bh=kU3bcniLBykrhz2Gcd46oTDCmOzkHV9G3b8LfQDR4Zs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PzAM87aLvIu9sv9ypOMaRz7X3YsJvuCqH01YYooG4jxMS+LWQ082KBOuughLRKexK
 gfnV1mHu/1JsmpVuAXOHKFFQpi5etZgkBYIC8qedoICBPrYlS17H0OggTmMThBODPj
 cNteeBJ9EJWVIp69JOH7T3zF+Dz46wwmEbMWLvkg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231030073230epcas2p4a3e808a61e2f1ffaad6893971cd4e830~S0jiaBKPh2578825788epcas2p4s;
 Mon, 30 Oct 2023 07:32:30 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.97]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SJlNF4p0fz4x9QL; Mon, 30 Oct
 2023 07:32:29 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 18.11.09607.D0C5F356; Mon, 30 Oct 2023 16:32:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20231030073229epcas2p3b273993804c74fe5be1fad0a140ba9e2~S0jhwYcv80946009460epcas2p3p;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231030073229epsmtrp2830ceeb5d73bbd147c492a32f41fc554~S0jhvyWFF2856128561epsmtrp2q;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-89-653f5c0dd59a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 62.26.08755.D0C5F356; Mon, 30 Oct 2023 16:32:29 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231030073229epsmtip1545c95896598202693ed5e089ca665ae~S0jhiYhqp0714507145epsmtip1g;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 2/5] clk: starfive: jh7110: Add security clocks
Date: Mon, 30 Oct 2023 16:32:01 +0900
Message-Id: <20231030073204.150030-3-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030073204.150030-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTXJc3xj7V4NchZYvL+7Ut3r44y2hx
 75qcxdu9newWh6d+YLR4fOg1kwObx57Ts5g9PnyM87hzbQ+bx9k7Oxg9+rasYgxgjcq2yUhN
 TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHar6RQlphTChQK
 SCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzlh0q4el
 4CF7RePfH6wNjPvZuhg5OSQETCSW/j3N2sXIxSEksINR4mBTHyOE84lRouXORqjMN0aJHc/n
 M8K0TOltZIJI7GWUeDP3MQuEM41J4snxiUwgVWwCuhJbnr8CmyUisJpRYtv+ZnaQBLOAtkTn
 5ylgtrCAvcSXo5uZQWwWAVWJ38c/AtkcHLxA8WMz9UFMCQF5icUPJEAqOAUcJJZM+Q82nldA
 UOLkzCcsEBPlJZq3zmYGWSUhcI9dYn1TCyNEr4vE3YvpEEcLS7w6voUdwpaS+PxuLxtESbnE
 jmVJEK0tjBLNbXuYIWrsJX7cnMIKUsMsoCmxfhfUNcoSR25BbeWT6Dj8lx0izCvR0SYE0agu
 cWD7dBYIW1aie85nVgjbQ2L9153skICazChxc88btgmMCrOQPDMLyTOzEBYvYGRexSiWWlCc
 m55abFRgAo/f5PzcTYzg1KjlsYNx9tsPeocYmTgYDzFKcDArifAyO9qkCvGmJFZWpRblxxeV
 5qQWH2I0BQb0RGYp0eR8YHLOK4k3NLE0MDEzMzQ3MjUwVxLnvdc6N0VIID2xJDU7NbUgtQim
 j4mDU6qB6aTHZxF/sQf6/rP3X6vYs2u2zaL1f+eeS6yd5nvC2FNUbkJD2vodKcLtaxRKGcxc
 GA9c+OOoMLMqLiaAfcr6y1fKrNmuv/677fP0DVcdj/s62j3bOqvkl7KmXV/s7vnHXXqU2QxX
 xvpJMd/4Zhn3KiQri/XLpN7+LUlh9bc+FHNy3p469+gp6ztmR95PumXPfEOqxKdG2H+RyiXT
 7HtMsYHnzsfOCvpsmCiyjtdro7pF03lmgTULpeMOBHoxlh05dPPXGc83+xRaLCXnigYuOSL2
 5mKWJO+UWZJ32EpmxTEY3pl7WqaGY+1VjbMr1l9hdU8XNz65Zr/f6/Ktk7K3r1kZeSPTWmrO
 o8fzXuzSvqTEUpyRaKjFXFScCAAXkHcoFgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSnC5vjH2qwe4jfBaX92tbvH1xltHi
 3jU5i7d7O9ktDk/9wGjx+NBrJgc2jz2nZzF7fPgY53Hn2h42j7N3djB69G1ZxRjAGsVlk5Ka
 k1mWWqRvl8CVsehWD0vBQ/aKxr8/WBsY97N1MXJySAiYSEzpbWTqYuTiEBLYzSjRdeQIC0RC
 VuLZux3sELawxP2WI6wQRZOYJGad28gIkmAT0JXY8vwVI0hCRGA9o8SP5e9ZQRLMAtoSnZ+n
 gHULC9hLfDm6mRnEZhFQlfh9/COQzcHBCxQ/NlMfxJQQkJdY/EACpIJTwEFiyZT/TCC2EFDF
 4zefwCbyCghKnJz5hAViurxE89bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfYsMAwL7Vcrzgx
 t7g0L10vOT93EyM4jLU0dzBuX/VB7xAjEwfjIUYJDmYlEV5mR5tUId6UxMqq1KL8+KLSnNTi
 Q4zSHCxK4rziL3pThATSE0tSs1NTC1KLYLJMHJxSDUzbPzSv2Krgbvt5q1cyq+4DI9atDfd9
 E47IBjBb8YgV++WZLrpjqKPj1aQpvzJ+jfCWEyveM23Ratqs9eWP/4mpJT/cL+jP/G/robBh
 0oSgg6VVYrsfNXRdv257b8PcyKXLSrjf2xgG8on3uYiGS2y7sv5xhuqhx1sabTrNH1gb6cRd
 ZjQVjrv/TOIgz0umP5H6S+9Xm5ulhWpemsDwVfjyJvunrXzBrqvrDlR9D93/8JBU47H7bq93
 equydPmVqJQeNmmsfXDIdA53xiPBnvnLbVqFzZZMc/TSfSnBG1KSL/v8lY/UzOMqjFu2XXgv
 vfjiz0+3825s/CQt+6q5u/3HUlOf1ErrjPDsXnmDC0osxRmJhlrMRcWJANOxVbbSAgAA
X-CMS-MailID: 20231030073229epcas2p3b273993804c74fe5be1fad0a140ba9e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231030073229epcas2p3b273993804c74fe5be1fad0a140ba9e2
References: <20231030073204.150030-1-chanho61.park@samsung.com>
 <CGME20231030073229epcas2p3b273993804c74fe5be1fad0a140ba9e2@epcas2p3.samsung.com>
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

