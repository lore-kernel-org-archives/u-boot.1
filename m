Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5F6C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 07:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FBF987916;
	Mon, 15 Apr 2024 09:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="oFJJD3/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FD488134; Mon, 15 Apr 2024 09:57:01 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C78FD8644E
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240415075654epoutp045225b44ddc6e140afc051c44741f85bc~GZQzhhwU52009920099epoutp04F
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 07:56:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240415075654epoutp045225b44ddc6e140afc051c44741f85bc~GZQzhhwU52009920099epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713167814;
 bh=tPJSjEl3Nr83i3MfGVt17AfXYFcTwN5cl4kkGXL0J0E=;
 h=From:To:Cc:Subject:Date:References:From;
 b=oFJJD3/5FG/jwHrw3jb/07dYRhwZDDh5nWZ1p1dh6QBOyY72sZuU2gp6qdCSlBPf4
 EgHUCohgTkfRZjHkP7yYWEawzgkQd/7WXWQHiuK+mfWppnAXMPP7V1lhz22qLAQy+s
 w3Ao1S40ags+yZ+NRizeHbGlOKXX7t8UGwSbRAHM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240415075653epcas1p367455e365df24df5a00d4f79eb39de60~GZQzQrALt1434314343epcas1p3K;
 Mon, 15 Apr 2024 07:56:53 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.231]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4VHzys30Cgz4x9Pv; Mon, 15 Apr
 2024 07:56:53 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 74.51.10158.5CDDC166; Mon, 15 Apr 2024 16:56:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240415075652epcas1p215ca1c7b29656c5f75685daf6e20f197~GZQyRA4_J1223512235epcas1p2t;
 Mon, 15 Apr 2024 07:56:52 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240415075652epsmtrp1bbb4790963249687d1db485b0c3a7c9c~GZQyQUpMQ1652016520epsmtrp1M;
 Mon, 15 Apr 2024 07:56:52 +0000 (GMT)
X-AuditID: b6c32a38-8e1ff700000027ae-e9-661cddc5fa2a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 3A.90.19234.4CDDC166; Mon, 15 Apr 2024 16:56:52 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240415075652epsmtip2b471f87c2f7136131c29e9e0e28a16e8~GZQyCz1Hv0916009160epsmtip2H;
 Mon, 15 Apr 2024 07:56:52 +0000 (GMT)
From: Jaehoon Chung <jh80.chung@samsung.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ycliang@andestech.com, Jaehoon Chung
 <jh80.chung@samsung.com>
Subject: [PATCH] mmc: cv1800b_sdhci: Remove the unused argument
Date: Mon, 15 Apr 2024 16:56:50 +0900
Message-Id: <20240415075650.22442-1-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmvu7RuzJpBt/fC1rc+NXGajF10mZ2
 i7d7O9ktHh96zeTA4rHn9Cxmj1cHVrF7nL2zg9Gjb8sqxgCWqGybjNTElNQihdS85PyUzLx0
 WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCdSgpliTmlQKGAxOJiJX07m6L80pJU
 hYz84hJbpdSClJwC0wK94sTc4tK8dL281BIrQwMDI1OgwoTsjE1zTrAULGarWHAnooFxFmsX
 IweHhICJxOdXdl2MXBxCAjsYJT5+e84E4XxilFh5/h4bnNP1vA3I4QTrOPLzFCtEYiejxOaN
 58ESQgJfGCVubcoFsdkEdCS2fzvOBGKLCEhI/Oq/yghiMwuES9x5+pwVxBYWsJfYfe4MM4jN
 IqAqsffVDhYQm1fAWmLjtffMEMvkJWZe+s4OEReUODnzCQvEHHmJ5q2zmUGOkBBYxS7RvOMS
 I8Q/LhKdM6UheoUlXh3fwg5hS0m87G9jh6hvZpRYuuQgK4TTwyjxr+E61GvGEvuXTmYCGcQs
 oCmxfpc+xDI+iXdfe6DhxSvR0SYEUa0icen1SyaY+Xef/GeFsD0kVjxYwQQJk1iJ3e29TBMY
 5WYheWEWkhdmISxbwMi8ilEstaA4Nz212LDABB6Pyfm5mxjBKU3LYgfj3Lcf9A4xMnEwHmKU
 4GBWEuG9JieZJsSbklhZlVqUH19UmpNafIjRFBioE5mlRJPzgUk1ryTe0MTSwMTMyNjEwtDM
 UEmc98yVslQhgfTEktTs1NSC1CKYPiYOTqkGJoFTipP8+jVPRjs7vtji1nJrXe3ldp0tuvXB
 6+s7T4ayLfps+LpE0PNi/TyHNe9YPiTFlwWGuJk1xL/L3RTaF3Enynw1T/Ez5pWXlso0cek9
 ksrNWMCazagcx/7V7J7d5ADXkmpxzgalOpbXq/6tbr4z4/LOhukWmfP8RZ5NXr9wflsvY9jC
 L00Ke5p/b+C7fNq6MLBuz2yH+vU+P9YatkdefstRuO3hBI4sg6OyHNsf+XHEzGQ7o7j5+aXm
 i4JSzL5Wvn4NgRPKWWPv7WTcXxbjZdfR83nCHN2TK7+djtgjqRmj5bf7AufDl2WTyhYnv67d
 s1hgklqzYWX45z8apVcbc7XkXj+/r/usfMZcJZbijERDLeai4kQAc1Hj4/IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWy7bCSvO6RuzJpButmGlrc+NXGajF10mZ2
 i7d7O9ktHh96zeTA4rHn9Cxmj1cHVrF7nL2zg9Gjb8sqxgCWKC6blNSczLLUIn27BK6MTXNO
 sBQsZqtYcCeigXEWaxcjJ4eEgInEkZ+ngGwuDiGB7YwSKy78YIZISEl8fjqVrYuRA8gWljh8
 uBii5hOjRMOnFrBmNgEdie3fjjOB2CICEhK/+q8ygtjMApESr9e+AosLC9hL7D53Bmwmi4Cq
 xN5XO1hAbF4Ba4mN195D7ZKXmHnpOztEXFDi5MwnLBBz5CWat85mnsDINwtJahaS1AJGplWM
 oqkFxbnpuckFhnrFibnFpXnpesn5uZsYwUGnFbSDcdn6v3qHGJk4GA8xSnAwK4nwXpOTTBPi
 TUmsrEotyo8vKs1JLT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpgagtgSXpV3Hyk
 7usk638s3aHXczYXiHyOD0oT096SMV2euXHy1VkrmcSdc5OiPkmYXT7azL+b5e8Xa6eTdre3
 3Au7ZcKxu/fXXFlpKW0Jib6UG3WLKtLmu1VKLL39NSYv8obOaocXZ+5Id3ZVfJ6Tu/auxUrb
 R7rrxfxTL5qs+vr1quUF3v9ymd7e3Mcl9mZ45ZSvLfhZ8MV8cZqukMKnDwrix6IX37lpE2Kp
 dKnI95PBrWV5B/o1C67Jb1va57V92aXfRtnvwr++ZGNc9M/sjN11zT3CN5+b/73iXpmxwpnt
 4uomt0yt391T7Bb/umH7SJtPPbavP3KpHIPHruz9krqsBw+oBHwLE8wN1JNXYinOSDTUYi4q
 TgQAdJdq3qkCAAA=
X-CMS-MailID: 20240415075652epcas1p215ca1c7b29656c5f75685daf6e20f197
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240415075652epcas1p215ca1c7b29656c5f75685daf6e20f197
References: <CGME20240415075652epcas1p215ca1c7b29656c5f75685daf6e20f197@epcas1p2.samsung.com>
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

Remove the unused argument about cmd_error.

Fixes: a3b2786651c7 ("mmc: Drop unused mmc_send_tuning() cmd_error parameter")

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
1
---
 drivers/mmc/cv1800b_sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
index 2275c5377723..9af6b9719844 100644
--- a/drivers/mmc/cv1800b_sdhci.c
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -42,7 +42,7 @@ static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
 	for (tap = 0; tap < TUNE_MAX_PHCODE; tap++) {
 		cv1800b_set_tap_delay(host, tap);
 
-		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
+		if (mmc_send_tuning(host->mmc, opcode)) {
 			current_size = 0;
 		} else {
 			current_size++;
-- 
2.25.1

