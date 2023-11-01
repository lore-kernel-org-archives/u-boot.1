Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48343C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 12:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A09D87C3A;
	Wed,  1 Nov 2023 13:17:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="OvzmNPmu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A139287BC7; Wed,  1 Nov 2023 13:17:26 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C888787B35
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 13:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231101121717epoutp0193ea30ffb940e7f1eb4dac1e7ec11300~Tfuw-cXPi1980719807epoutp01R
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:17:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231101121717epoutp0193ea30ffb940e7f1eb4dac1e7ec11300~Tfuw-cXPi1980719807epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698841037;
 bh=Oh2UtrU7DRmsJziSyin0/+2lQoJgzhCNQwFDUucV1c4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OvzmNPmuxLFiz7FcUEjOwlzBORyEiIjF9ga3du8P1xWfaOwEzmvrSllYrVTzh9tsg
 LktCy9X5AeZeMj27Pfe2s04t3zhErWTKmwlbF3pWHoC/cRwqNtnXrqPsMtpnl0yQiF
 7bxJ6yv9PrSe4qZs9nFed5LDPLptAwZqJ6j89Klo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20231101121717epcas2p21e496371a382687f08d3fd0107c2dcb9~TfuwlgHn30689906899epcas2p2B;
 Wed,  1 Nov 2023 12:17:17 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.98]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SL5bw65HXz4x9Pv; Wed,  1 Nov
 2023 12:17:16 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 1A.04.08648.CC142456; Wed,  1 Nov 2023 21:17:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231101121716epcas2p108b1506ffd6a2b31bdc36b810dda15a6~Tfuv1oVcI0608606086epcas2p1s;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101121716epsmtrp24a91ec6318ad4e68ff6a542b1ba3351c~Tfuv04uHD2433224332epsmtrp23;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
X-AuditID: b6c32a43-721fd700000021c8-fa-654241ccaf8d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 2F.68.08755.CC142456; Wed,  1 Nov 2023 21:17:16 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101121716epsmtip1566e4be650c9dc8341d99b7e95bf1d2d~TfuvnmMle0809708097epsmtip1J;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v4 4/5] riscv: dts: jh7110: Add rng device tree node
Date: Wed,  1 Nov 2023 21:16:51 +0900
Message-Id: <20231101121652.1865516-5-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101121652.1865516-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTQveMo1OqwexvBhaX92tb3PjVxmrx
 9sVZRot71+Qs3u7tZLc4PPUDo8XjQ6+ZHNg99pyexezx4WOcx51re9g8zt7ZwejRt2UVYwBr
 VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
 iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTs
 jOMXm9kL3rNVvNt1ga2B8ThrFyMnh4SAicTFeavBbCGBHYwSxw5zQtifGCV+nkvtYuQCsr8x
 Slzds4gZpmHb8cNMEIm9jBLX+3awQzjTmCT+N7xiAaliE9CV2PL8FSNIQkTgKqPE+1lvwNqZ
 BbQlOj9PYQexhQVcJK4vesMIYrMIqEo8fLgX7A5eAQeJ1mOPgVZwAK2Tl1j8QAIkzCngKHG1
 eT0zRImgxMmZT1ggRspLNG+dzQyyS0LgJbvE7S0foE51kbg2uZsRwhaWeHV8CzuELSXx+d1e
 Noj55RI7liVB9LYwSjS37YHqtZf4cXMKK0gNs4CmxPpd+hDlyhJHbkGt5ZPoOPyXHSLMK9HR
 JgTRqC5xYPt0FghbVqJ7zmdoQHtInLq3mRkSVFMYJSau28QygVFhFpJvZiH5ZhbC4gWMzKsY
 xVILinPTU5ONCgzh8Zucn7uJEZwktZx3MF6Z/0/vECMTB+MhRgkOZiUR3sOmDqlCvCmJlVWp
 RfnxRaU5qcWHGE2BQT2RWUo0OR+YpvNK4g1NLA1MzMwMzY1MDcyVxHnvtc5NERJITyxJzU5N
 LUgtgulj4uCUamCas6tK95vIiYezZSNrn52xUWbgUVfoftiRw7SY46jreValGTN39HaGs9fJ
 +vwP3bzKimflfw+dh0ybc04oLzV/ovm7MKvL5dBnEbNXds0Kx2cofVjf7s7enST2ck1mx6zV
 D9dt/ulx7xd7EOPU7IdXrT80sVfuMBIXs5qt89vWsfB8KIdYvuaaz7urbaIC3s+6YtoV8/Gc
 98QuJZ2Z+zZOzli17qkE07aCGX9FVOIeSX/4+T79WbN66mnlpb23+4PqVIweGE/a9kXUsO5B
 gvaysspz3j782UV6ib6sRUHfctKtDY5Xzt5gJ6z4auO+RN/+yeum97stCi8Vm8b59kvfw7I7
 j54v+Ceztnz7iuVKLMUZiYZazEXFiQBqWmHSGwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnO4ZR6dUgz3bBC0u79e2uPGrjdXi
 7YuzjBb3rslZvN3byW5xeOoHRovHh14zObB77Dk9i9njw8c4jzvX9rB5nL2zg9Gjb8sqxgDW
 KC6blNSczLLUIn27BK6M4xeb2Qves1W823WBrYHxOGsXIyeHhICJxLbjh5m6GLk4hAR2M0pc
 atgOlZCVePZuBzuELSxxv+UIK0TRJCaJX/v3MoMk2AR0JbY8f8UIkhARuMkosXDOVxaQBLOA
 tkTn5ylg3cICLhLXF71hBLFZBFQlHj7cC7aBV8BBovXYY6DVHEAb5CUWP5AACXMKOEpcbV4P
 Nl8IqOTdkvdsEOWCEidnPoEaLy/RvHU28wRGgVlIUrOQpBYwMq1ilEwtKM5Nzy02LDDMSy3X
 K07MLS7NS9dLzs/dxAgOaS3NHYzbV33QO8TIxMF4iFGCg1lJhPewqUOqEG9KYmVValF+fFFp
 TmrxIUZpDhYlcV7xF70pQgLpiSWp2ampBalFMFkmDk6pBqaSX+KrnqyrZNF2UFTsWvWVx/Wg
 yHvJNR/qFto6p+2acWKZOke0XPyr034PxbZs9nDO8rhjsSj58+Tazf2J3iuXiK1QWPXtYwSz
 9UQZvrpckxAPx6MfpZNdFma+OG9VtePI3yV6x090eLp4Vey8qHZg97QJ4cVyauV3bGTdVOZW
 338bdqB/yl079gRnu+9BPv6XZ3oWe84sK2/7tuL/6eaXCieXZz2R80q8U3j0n87bLHU2y+XS
 Wtu9thZ5crz+FPPA7GnYG51Vf1+GH09q2B/tL3303qnEKud3Yq9WvKrZc+DXv7nNceYlE3Qq
 95to2OSVPHqw6o9eAK+cqYGNvoOUbOND6Tf8XO4veh2svymxFGckGmoxFxUnAgDWkydy2AIA
 AA==
X-CMS-MailID: 20231101121716epcas2p108b1506ffd6a2b31bdc36b810dda15a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101121716epcas2p108b1506ffd6a2b31bdc36b810dda15a6
References: <20231101121652.1865516-1-chanho61.park@samsung.com>
 <CGME20231101121716epcas2p108b1506ffd6a2b31bdc36b810dda15a6@epcas2p1.samsung.com>
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

