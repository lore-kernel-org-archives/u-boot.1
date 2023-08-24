Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DBFC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 12:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A91F3864E7;
	Thu, 24 Aug 2023 14:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="m8h6nhH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F1C86542; Thu, 24 Aug 2023 08:10:45 +0200 (CEST)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3278D864B4
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 08:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.stelmach@samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230824061041euoutp02bda981acc82cbccb1d6512e3d63c7093~_PN_iRMZH1545715457euoutp02l
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 06:10:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230824061041euoutp02bda981acc82cbccb1d6512e3d63c7093~_PN_iRMZH1545715457euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1692857441;
 bh=QVzSrOCga2/2r8wuiUo1FSG1qpVGnwxzQY8SnMlxRV4=;
 h=From:To:Cc:Subject:Date:References:From;
 b=m8h6nhH60kQ83nuT4t0+3YP3EgVhMam5jxfDBH1bCqFH5MW4i27LegjokC7te9BgT
 rn9WuUAi30Tfun4Fk3819+tbmv8PB9AeVJuPYn6aMX2d/6ra8IXbtGnSGc1MJh7scj
 IjN7ieah9MsJI2ZKK+ppoME6slvXafN3Bz5bzaXA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230824061040eucas1p1e9d5ce1888c02ebcd620a2099342dc71~_PN_U24p_2275622756eucas1p1Y;
 Thu, 24 Aug 2023 06:10:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 5F.FA.37758.064F6E46; Thu, 24
 Aug 2023 07:10:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230824061040eucas1p1a8c8b4bb5cd362d73806ac8d40613a9d~_PN96F4to0050900509eucas1p1I;
 Thu, 24 Aug 2023 06:10:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230824061040eusmtrp2039e0c93c664d78c77f11905e2aaa30f~_PN95p8f-2185121851eusmtrp21;
 Thu, 24 Aug 2023 06:10:40 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-6f-64e6f4603f4f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 54.22.14344.064F6E46; Thu, 24
 Aug 2023 07:10:40 +0100 (BST)
Received: from localhost (unknown [106.120.51.111]) by eusmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20230824061040eusmtip2b99ffe3959350588de3dc63d34c44837~_PN9xSXuy0479204792eusmtip2i;
 Thu, 24 Aug 2023 06:10:40 +0000 (GMT)
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To: u-boot@lists.denx.de
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] setexpr: Silence some diagnostic messages
Date: Thu, 24 Aug 2023 08:10:25 +0200
Message-Id: <20230824061025.664682-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7djP87oJX56lGLzZamBx89AKRou1R+6y
 W7zd28nuwOxx9s4ORo++LasYA5iiuGxSUnMyy1KL9O0SuDLuvuhjK+hkr7i04ThTA+MR1i5G
 Dg4JAROJBy+Luxi5OIQEVjBKvLp7kBHC+cIoMefcH3YI5zOjxJkz/1m6GDnBOu5u38EEYgsJ
 LGeUuP0wGMJ+wShx80MdiM0m4CjRv/QEK4gtIiAh8av/KiOIzSyQJ7Fn7nmwXmEBK4lHjzrB
 algEVCW2H/jBDGLzCthINE14wA5xnbzE4gcSEGFBiZMzn4CdwC+gJbGm6ToLxEh5ieats5lB
 7pQQ6OSQuLL/KNSdLhK3/v1gh7CFJV4d3wJly0j83zmfCaKhnVGi6cpCVghnAqPE544mJogq
 a4k7536xgVzBLKApsX6XPkTYUeLK8qPQoOOTuPFWEOIIPolJ26YzQ4R5JTrahCCqVSTW9e+B
 OkdKovfVCkYI20NiQd8+xgmMirOQvDYLyTuzEPYuYGRexSieWlqcm55abJyXWq5XnJhbXJqX
 rpecn7uJEZgiTv87/nUH44pXH/UOMTJxMB5ilOBgVhLh/eLzLEWINyWxsiq1KD++qDQntfgQ
 ozQHi5I4r7btyWQhgfTEktTs1NSC1CKYLBMHp1QDU8D/5QfvSm0uizo0LSL038dLm++sPx4T
 tc2nhu9dUMzp//knDd/aBmdKpT5//3dC5umrTpyr6r5W/11+qOjSsz1ZvMtyTvNGSCh3ioU/
 /7Ujc2tyXOJBeee1LxV8j/mZbvx8+7FSr0L6i41zxAXViopU3b6xncpMePgp64tLBXOf0L4T
 ixc2L7krV+jwam/jnsbsDplPtfZv14Z4JPpuFI+YOin4Z4p3/c/p9U869r4IOpSdKdm+vmm6
 94acM7kLY09OUC/58Htq4P6rC4Q7PF4kh547NO/47MOLT3I4p69wfP1X9veLzteNXY+TBFeb
 /rHYrBujeWVVU9yH9NCG16zrzQ+8PvJfhmf3hRVfk7OVWIozEg21mIuKEwFBaz+IgAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t/xe7oJX56lGCw5I2lx89AKRou1R+6y
 W7zd28nuwOxx9s4ORo++LasYA5ii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62M
 TJX07WxSUnMyy1KL9O0S9DLuvuhjK+hkr7i04ThTA+MR1i5GTg4JAROJu9t3MHUxcnEICSxl
 lPjwp525i5EDKCElsXJuOkSNsMSfa11sEDXPGCUebu1hBEmwCThK9C89ATZIREBC4lf/VbA4
 s0CexJ6555lAbGEBK4lHjzrBalgEVCW2H/jBDGLzCthINE14wA6xS15i8QMJiLCgxMmZT1hA
 wswC6hLr5wmBhPkFtCTWNF1ngZguL9G8dTbzBEaBWUg6ZiF0zEJStYCReRWjSGppcW56brGR
 XnFibnFpXrpecn7uJkZggG879nPLDsaVrz7qHWJk4mA8xCjBwawkwvvF51mKEG9KYmVValF+
 fFFpTmrxIUZToAcmMkuJJucDYyyvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1
 CKaPiYNTqoGpK0f3bW9+4fp2v6TJ3b9zC9s/5Cxx9J61L7b2/QdXA4u1ex/X/jq9TijpllxX
 YmGf5fQupuXcHV+39x012BZ37Ogju6jH0Ye/aDOvsDmvGOxrnsFfynip8Lxp/iJv3S3GElLf
 pnFN3swj9zdyyvsHsjMe3JDpqXswrUpD2yj4l4pQyTnGkG1tzXP42qbYveHiZuzgClZKiBU8
 cPiljXSyHC8Xv9K+6BXty+WrV8owMPyvNpcUcDcSuuh5eMLX0rDJL9/1ZRzIaz6w87Xr80NL
 jT6qqM+2e6L380kG05KlDnx/ooyXaeur3ROZ/YJvivDBtbFrv+cd87GsMO7/nySqzSY58e/n
 H6XPKvKM05VYijMSDbWYi4oTAV5tN3T5AgAA
X-CMS-MailID: 20230824061040eucas1p1a8c8b4bb5cd362d73806ac8d40613a9d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230824061040eucas1p1a8c8b4bb5cd362d73806ac8d40613a9d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230824061040eucas1p1a8c8b4bb5cd362d73806ac8d40613a9d
References: <CGME20230824061040eucas1p1a8c8b4bb5cd362d73806ac8d40613a9d@eucas1p1.samsung.com>
X-Mailman-Approved-At: Thu, 24 Aug 2023 14:51:11 +0200
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

Neither successful match nor lack thereof should be considered an
extraordinary situation. Thus, neither require printing a message.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 cmd/setexpr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/setexpr.c b/cmd/setexpr.c
index 4d671e7ef1..233471f6cb 100644
--- a/cmd/setexpr.c
+++ b/cmd/setexpr.c
@@ -215,7 +215,7 @@ int setexpr_regex_sub(char *data, uint data_size, char *nbuf, uint nbuf_size,
 
 		if (res == 0) {
 			if (loop == 0) {
-				printf("%s: No match\n", data);
+				debug("%s: No match\n", data);
 				return 1;
 			} else {
 				break;
@@ -359,7 +359,7 @@ static int regex_sub_var(const char *name, const char *r, const char *s,
 	if (ret)
 		return 1;
 
-	printf("%s=%s\n", name, data);
+	debug("%s=%s\n", name, data);
 
 	return env_set(name, data);
 }
-- 
2.39.2

