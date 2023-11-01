Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F20C4167B
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 11:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5537876D9;
	Wed,  1 Nov 2023 12:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="bURZYhW0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73B9287BAC; Wed,  1 Nov 2023 12:40:53 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41334876DA
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231101114041epoutp03f738c14d2c6ed3bea9181a76ce4d26b0~TfOzsMdp22310923109epoutp03t
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 11:40:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231101114041epoutp03f738c14d2c6ed3bea9181a76ce4d26b0~TfOzsMdp22310923109epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698838841;
 bh=Oh2UtrU7DRmsJziSyin0/+2lQoJgzhCNQwFDUucV1c4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bURZYhW02hguAfdUC29y6hyqZ3sezClzoiByQAfEwknQcTqmuq+tPn+mo2ZZ8ZRZQ
 j825G92M3WAvwoJQJtedFqsG1ck2s2wvPP0BWNguQ5yFHHAxwoY7PqsNdkxOmb8YQp
 7rMrtLddoHK4SLflahKm03SqzUbkQCl/CEVtbHKc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20231101114040epcas2p279c5c117e5e64f44de673f63e75862cf~TfOzNIiE32671326713epcas2p2C;
 Wed,  1 Nov 2023 11:40:40 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SL4nh4Zqzz4x9Ps; Wed,  1 Nov
 2023 11:40:40 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 1E.B3.10006.83932456; Wed,  1 Nov 2023 20:40:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20231101114040epcas2p380a9fe265bc3ae0bdfb368e8712b34c9~TfOyjQ02R2553425534epcas2p3Z;
 Wed,  1 Nov 2023 11:40:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231101114040epsmtrp1d3638e51f07f0c2c25f679f5a0bcbd3c~TfOyitJME2749427494epsmtrp1G;
 Wed,  1 Nov 2023 11:40:40 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-6f-65423938b406
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 B3.32.18939.83932456; Wed,  1 Nov 2023 20:40:40 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101114039epsmtip1572d5a2a7ef3bcf085b227ed7350c1c2~TfOyQrBY01789117891epsmtip1w;
 Wed,  1 Nov 2023 11:40:39 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 4/5] riscv: dts: jh7110: Add rng device tree node
Date: Wed,  1 Nov 2023 20:40:16 +0900
Message-Id: <20231101114017.1845960-5-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101114017.1845960-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTVNfC0inVYO8HJYvL+7UtbvxqY7V4
 ++Iso8W9a3IWb/d2slscnvqB0eLxoddMDuwee07PYvb48DHO4861PWweZ+/sYPTo27KKMYA1
 KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gIJYWy
 xJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2
 xvGLzewF79kq3u26wNbAeJy1i5GDQ0LARGL+7KouRi4OIYEdjBKzFh9ghHA+MUqs23KQHc7p
 /vEKKMMJ1rG6/wsrRGInUMvkVewgCSGBaUwSx+fwg9hsAroSW56/AhslInCVUeL9rDfMIAlm
 AW2Jzs9TwBqEBVwk5v5dxQpiswioSnS9aQKL8wo4SBzbuYMJ4j55icUPJEDCnAKOEivb/rBB
 lAhKnJz5hAVipLxE89bZzCC7JATusUu0fGpigrjUReLFw+3MELawxKvjW9ghbCmJl/1t7BDz
 yyV2LEuC6G1hlGhu2wNVby/x4+YUcBgxC2hKrN+lD1GuLHHkFtRaPomOw3+hpvBKdLQJQTSq
 SxzYPp0FwpaV6J7zmRXC9pA49v8ZNNimMEo83bSDbQKjwiwk38xC8s0shMULGJlXMYqlFhTn
 pqcWGxUYwuM3OT93EyM4SWq57mCc/PaD3iFGJg7GQ4wSHMxKIryHTR1ShXhTEiurUovy44tK
 c1KLDzGaAoN6IrOUaHI+ME3nlcQbmlgamJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTT
 x8TBKdXAxNniePvgy8ai/aHHVqzdd7bIZ9l/++wv9x3cI2LPs89T/h1sdGfSRqFLFfwTl9Wu
 su7rXaG6Tf2jgvSzKfuj/6qt1N7zlLFUNSHhmLFX2/7HnBq7g2o++ttNiprj1a005/hj5at8
 suunSykZPjI+fnTai0lzN3cpJf4+ydFX6yBx1PuHyHVtve5L+1e27Fur/qE+53Enk7jQ5hs3
 DJ7JT7787njMn0C/wOYlb26s/KW14qiW5PdPHRN09LpEl+z7fGLjwpusiWIWR4OUp007n7X0
 7Z7XcRtutPezZE5/+K/i64x1143sngZsfCwfd+vSC0bHE6Xs9257M4clq/96Ni/ocn9jx6PA
 cwkb20uXbY1VYinOSDTUYi4qTgQADPf7kBsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnK6FpVOqwYJXrBaX92tb3PjVxmrx
 9sVZRot71+Qs3u7tZLc4PPUDo8XjQ6+ZHNg99pyexezx4WOcx51re9g8zt7ZwejRt2UVYwBr
 FJdNSmpOZllqkb5dAlfG8YvN7AXv2Sre7brA1sB4nLWLkZNDQsBEYnX/FzBbSGA7o8SE5TUQ
 cVmJZ+92sEPYwhL3W44A1XAB1Uxikuh/fp0NJMEmoCux5fkrRpCEiMBNRomFc76ygCSYBbQl
 Oj9PAesWFnCRmPt3FdgGFgFVia43TWBxXgEHiWM7dzB1MXIAbZCXWPxAAiTMKeAosbLtDxvE
 QQ4Sc2+vZIUoF5Q4OfMJ1Hh5ieats5knMArMQpKahSS1gJFpFaNoakFxbnpucoGhXnFibnFp
 Xrpecn7uJkZwIGsF7WBctv6v3iFGJg7GQ4wSHMxKIryHTR1ShXhTEiurUovy44tKc1KLDzFK
 c7AoifMq53SmCAmkJ5akZqemFqQWwWSZODilGphcYhqtn3om/Xwcd+sRe+iuVekWPbfmnf0u
 +FUjr3rpNs+3DLfT/DZrfWP4xFWgsjNWr3qpb53BpCusOm2f3P+lJTG/nJpcsefGoTUNy28z
 pzAYp+/+6t8kvkXfdIrTJMOwZzfuGWXd8+78osxq/93qx6Myn+x4AxtV28KUS86PPvbLxRl9
 ebPkZEB6663/z38vYlHpS5c5U6YQueOG4Q0127LEnz/+eZzambB9i6/YcpGt9gUFB1UMX7rq
 HyjL3LPgzqKsNV9FDr9S13qQYdRwbmr1NhmlGT26b086ah1k6hf+LtWwVoZrZZWGzGyZJbEe
 Vxc/r63qmp8z/83TV+G7rl1/8u/ct3CvtrU2fWpKLMUZiYZazEXFiQDoyxN90wIAAA==
X-CMS-MailID: 20231101114040epcas2p380a9fe265bc3ae0bdfb368e8712b34c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101114040epcas2p380a9fe265bc3ae0bdfb368e8712b34c9
References: <20231101114017.1845960-1-chanho61.park@samsung.com>
 <CGME20231101114040epcas2p380a9fe265bc3ae0bdfb368e8712b34c9@epcas2p3.samsung.com>
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

Adds jh7110 trng device tree node.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 arch/riscv/dts/jh7110.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
index ec237a46ffba..13c47f7caa36 100644
--- a/arch/riscv/dts/jh7110.dtsi
+++ b/arch/riscv/dts/jh7110.dtsi
@@ -627,6 +627,16 @@
 			status = "disabled";
 		};
 
+		rng: rng@1600c000 {
+			compatible = "starfive,jh7110-trng";
+			reg = <0x0 0x1600C000 0x0 0x4000>;
+			clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
+				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
+			clock-names = "hclk", "ahb";
+			resets = <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
+			interrupts = <30>;
+		};
+
 		aoncrg: clock-controller@17000000 {
 			compatible = "starfive,jh7110-aoncrg";
 			reg = <0x0 0x17000000 0x0 0x10000>;
-- 
2.39.2

