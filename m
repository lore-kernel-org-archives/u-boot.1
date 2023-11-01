Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99F7C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 12:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF619874F7;
	Wed,  1 Nov 2023 13:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="m7dHkwXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADA187649; Wed,  1 Nov 2023 13:17:31 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C871F87702
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 13:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231101121717epoutp02166470b3dcb8ce2ab9e4feae0e73067a~Tfuwjq42g1177511775epoutp02z
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:17:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231101121717epoutp02166470b3dcb8ce2ab9e4feae0e73067a~Tfuwjq42g1177511775epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698841037;
 bh=kU3bcniLBykrhz2Gcd46oTDCmOzkHV9G3b8LfQDR4Zs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m7dHkwXyM0iauiLGoPmmwlOpFZuPOsYaO4yYPTy7etyuV3hELIpoYzRv0OlP26ZeT
 Zm9NA7UauPoJTgParA2adwog8QnmPAEJ7Cx4p2lgsZpf5xcBpCIIVDQmmEegQSSpjR
 +MVPdeMUfAwAxaVA8FEQ04Zd5lLP1Zi2gCiUODtA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231101121716epcas2p1211d9b68b51f5c7dc5ca83d00e69bb7b~TfuwRlptj1771317713epcas2p17;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.98]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SL5bw3hk3z4x9Pw; Wed,  1 Nov
 2023 12:17:16 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 FE.F8.18994.CC142456; Wed,  1 Nov 2023 21:17:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20231101121716epcas2p33092739b0c4129df204ecf265faf6aee~TfuvuALLm2435424354epcas2p3Y;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231101121716epsmtrp1575a08f115d5160537329f3ca043e0dc~TfuvswquW0181001810epsmtrp15;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-11-654241cc34cd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 75.13.18939.CC142456; Wed,  1 Nov 2023 21:17:16 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101121715epsmtip1b39963a27f8910e65764f69fdbdb437a~Tfuva8XYY0849508495epsmtip1B;
 Wed,  1 Nov 2023 12:17:15 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v4 2/5] clk: starfive: jh7110: Add security clocks
Date: Wed,  1 Nov 2023 21:16:49 +0900
Message-Id: <20231101121652.1865516-3-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101121652.1865516-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdljTVPeMo1Oqwcdb0haX92tb3PjVxmrx
 9sVZRot71+Qs3u7tZLc4PPUDo8XjQ6+ZHNg99pyexezx4WOcx51re9g8zt7ZwejRt2UVYwBr
 VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
 iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTs
 jEW3elgKHrJXNP79wdrAuJ+ti5GTQ0LAROLS7DZmEFtIYA+jxP9VShD2J0aJxWc8uhi5IOyT
 D7+ywzQ8ff+bGSKxk1Fi6pZF7BDONCaJphurwEaxCehKbHn+ihEkISJwlVHi/aw3YAlmAW2J
 zs9TwEYJCzhJLDr2A8xmEVCV2P3jIQuIzSvgIPFx0V7WLkYOoHXyEosfSICEOQUcJa42r2eG
 KBGUODnzCQvESHmJ5q2zwS6SELjFLtE+5zsrxKkuEt/23mOCsIUlXh3fAvWClMTL/jZ2iPnl
 EjuWJUH0tjBKNLftYYaosZf4cXMK2A3MApoS63fpQ5QrSxy5BbWWT6Lj8F+oKbwSHW1CEI3q
 Ege2T2eBsGUluud8hjrGQ+LW43ZWSFBNYZS4fmA5ywRGhVlIvpmF5JtZCIsXMDKvYpRKLSjO
 TU9NNiow1M1LLYfHcXJ+7iZGcLLU8t3B+Hr9X71DjEwcjIcYJTiYlUR4D5s6pArxpiRWVqUW
 5ccXleakFh9iNAUG90RmKdHkfGC6ziuJNzSxNDAxMzM0NzI1MFcS573XOjdFSCA9sSQ1OzW1
 ILUIpo+Jg1OqgWn2+oY3N1JLN3VHXWn1/KLR+CC3IPC3psJWuW1h+4RFbsUyXbmodKP9t8qd
 va09ijPOX5Phn9zclaIy2SRMdJJi4+6zVu5Xct6FNxtOvcHCncI0c8/MpGPdt6Rfiz7peZHt
 afRd5JyW6ZuFx9pOagvtEXX4VGMYtrnmzT4LRuFjHw5Y/hX38u7c+yyWtVZKdeKFdft/6HY/
 +/nzS1tRxJnqBc1vz3F90jD/NflbQ/sGZ9sZm/q32Dw/WnDT6q97d9zCSw7+dfvmy3F/OPfg
 7n9xJ/tmcyeXdM4b725uTH966bfb+1On9Z/25S5nDfry46hcj+d+08faO+qLZF+quGx8WL7D
 Nv2x2A//mcb2ujOUWIozEg21mIuKEwFAr4HnHwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnO4ZR6dUg/2/mC0u79e2uPGrjdXi
 7YuzjBb3rslZvN3byW5xeOoHRovHh14zObB77Dk9i9njw8c4jzvX9rB5nL2zg9Gjb8sqxgDW
 KC6blNSczLLUIn27BK6MRbd6WAoeslc0/v3B2sC4n62LkZNDQsBE4un738wgtpDAdkaJt09c
 IOKyEs/e7WCHsIUl7rccYe1i5AKqmcQk0dbyhhUkwSagK7Hl+StGkISIwE1GiYVzvrKAJJgF
 tCU6P08B6xYWcJJYdOwHmM0ioCqx+8dDsBpeAQeJj4v2Ag3iANogL7H4gQRImFPAUeJq83qo
 gxwk3i15zwZRLihxcuYTqPHyEs1bZzNPYBSYhSQ1C0lqASPTKkbR1ILi3PTc5AJDveLE3OLS
 vHS95PzcTYzgQNYK2sG4bP1fvUOMTByMhxglOJiVRHgPmzqkCvGmJFZWpRblxxeV5qQWH2KU
 5mBREudVzulMERJITyxJzU5NLUgtgskycXBKNTAlN/T5XdF+slT0qVRQocODCeqZtY6y95as
 4rExbS1JCD+1tTG87J+5TOCk2+yv1m+98PTxv61FxlGbhdzTNx838flru9zhmf/qCP8ChhDd
 aJcHv22vRjb4subJ6fzL6Txu0NRTIsbvOelWWNrVpcarV99ye2Pec+7NJ2tj1t+dzTPLstdN
 MPGT3MA1p19NmPHTpnzjCQuqVsSvlJpkEv+jTKrnlO6PHZJ15oU2HMYvFT+1P6oVZk3dfada
 M13meD2zR67d1LKbfB2a2yx8o2Y7zbvzz2/fdgcmuyfPTvreU/687MlT/XP3+O/pXzy4/+SZ
 vuJcwbUlXMXRfo9VOJkE5ZWkX7lbHq+aGBYcpcRSnJFoqMVcVJwIACKB+O3TAgAA
X-CMS-MailID: 20231101121716epcas2p33092739b0c4129df204ecf265faf6aee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101121716epcas2p33092739b0c4129df204ecf265faf6aee
References: <20231101121652.1865516-1-chanho61.park@samsung.com>
 <CGME20231101121716epcas2p33092739b0c4129df204ecf265faf6aee@epcas2p3.samsung.com>
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

