Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081D4C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 06:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8624C88BEE;
	Fri, 26 Apr 2024 08:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="FAbZvVTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FC4787F70; Fri, 26 Apr 2024 08:35:43 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE842890EB
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240426063534epoutp049d87f2b9fa6198625896d3df7e164341~JwP8OpNn91482314823epoutp04B
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 06:35:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240426063534epoutp049d87f2b9fa6198625896d3df7e164341~JwP8OpNn91482314823epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1714113334;
 bh=FZGnUse09+aJ/i2ewW47cvTSNs2l7rljTWzHcsKhgIA=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=FAbZvVTG6gudJbplCt7fuHlsDiIeAdnRai1fMWoogObeBo9EQqBhQwFw+Ib6aKpmd
 VEvNCO+e7Ha6ggk8qilFS782g03QWfiRECTvahljJ1QurAZk40+TrGEj4n4Cl2ivdS
 9vOQ2jjgS2WWOLZglcln1907kcqPhq0f3GPUIdgU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240426063534epcas1p2f77f8a565e1bc80565514b8894053b76~JwP7_Li581085510855epcas1p2T;
 Fri, 26 Apr 2024 06:35:34 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.145]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4VQjdx2MtCz4x9QC; Fri, 26 Apr
 2024 06:35:33 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 82.88.19431.53B4B266; Fri, 26 Apr 2024 15:35:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240426063533epcas1p4f145c8a53b72e7d6eae235a3fed8f3aa~JwP6gjEwI0670806708epcas1p4N;
 Fri, 26 Apr 2024 06:35:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240426063533epsmtrp1cbe8f746be67c3925bee0269c1bfcb08~JwP6fzZ8h1417314173epsmtrp1-;
 Fri, 26 Apr 2024 06:35:33 +0000 (GMT)
X-AuditID: b6c32a4c-1d1ff70000004be7-5b-662b4b35776c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 40.E3.08390.43B4B266; Fri, 26 Apr 2024 15:35:32 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240426063532epsmtip11585d68c23cfd706cc52b65471dad615~JwP6Pt4sJ3193731937epsmtip1s;
 Fri, 26 Apr 2024 06:35:32 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Udit Kumar'" <u-kumar1@ti.com>, <n-francis@ti.com>, <j-keerthy@ti.com>
Cc: <nm@ti.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <u-boot@lists.denx.de>
In-Reply-To: <20240419060016.493713-1-u-kumar1@ti.com>
Subject: RE: [PATCH] power: pmic: tps65941: Update compatible to aling with
 kernel DT
Date: Fri, 26 Apr 2024 15:35:32 +0900
Message-ID: <000201da97a3$f04fdc80$d0ef9580$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHRFhElnceukcVumdfoMa1fPmvJOQC2wLKysYdlkgA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmnq6pt3aaQeshAYtT25uYLE7eaGW3
 ePPjLJPFty3bGC2mTtrMbvF2bye7xbS9M5gd2D1mN1xk8Xh1YBW7x9k7Oxg9jt/YzhTAEpVt
 k5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0gpJCWWJO
 KVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLRArzgxt7g0L10vL7XEytDAwMgUqDAhO+Po
 tX+sBQt4KrbO7GJpYGzg6mLk5JAQMJFYsHI9axcjF4eQwB5GiRlnFjJBOJ8YJR58W8AC4Xxj
 lNi/dR0zTMvZ7o3MEIm9jBIP/0xmg3BeMkp0931iBKliE9CT+L9oIViHiICPxJmOLnYQm1kg
 WOJnzzSwOKeAmcSKBT9ZQWxhgXCJQxefg/WyCKhKHJxwhwnE5hWwlHg3Zx0rxGYFiZ9Pl7FC
 zLSSuP/zMtRMEYnZnW1gF0kIPGKX+PvnFNBF7ECOi8RjSYhWYYlXx7ewQ9hSEi/729ghypsZ
 JZYuOcgK4fQwSvxruM4GUWUssX/pZKAjOIAWaEqs36UPsYtP4t3XHlaQsIQAr0RHmxBEtYrE
 pdcvmWDm333yH+pkD4npByaxQ8KnExhY6y+wTmCUn4Xk7FkIGxYwMq1ilEotKM5NT002LDDU
 zUsth0dncn7uJkZw+tPy2cH4ff1fvUOMTByMhxglOJiVRHhvftRIE+JNSaysSi3Kjy8qzUkt
 PsRoCgzMicxSosn5wAScVxJvaGJpYGJmZGxiYWhmqCTOe+ZKWaqQQHpiSWp2ampBahFMHxMH
 p1QD09zeS6fnZd387MvFUzT5/tSt1RYszxxvfZ58X9K1Muf3SYWfitXHJt+RsRU/IMz05IJw
 HPPdv13bF0V8W6zL5lHKuCleyHPbo8AZcyvSt0Q9af++yn/t7UVLrzcodrwuZ/jdXazaWswl
 MelUaa3o1E6jp35uOvNs9Fpm/I5deK5AS731x9Y9i1OEMsXY7bz3ZjQ6cObMfG+928F67aUl
 Qry6IdPUlydHHp8q0GB63+9+9t+fyWvZYh22xZ4t4Fwu5pTH9eMM6+wjD9b3m/nP/mnZIlsx
 N00v9No734+7EyQ852z6oWZXOmlG/vGXBjuOyJzdEtby7Fh7gVt6+U+vk4Yfzr0tr13Db56k
 F7qGR4mlOCPRUIu5qDgRAKc2F7sIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnK6Jt3aaQfcBM4tT25uYLE7eaGW3
 ePPjLJPFty3bGC2mTtrMbvF2bye7xbS9M5gd2D1mN1xk8Xh1YBW7x9k7Oxg9jt/YzhTAEsVl
 k5Kak1mWWqRvl8CVcfTaP9aCBTwVW2d2sTQwNnB1MXJySAiYSJzt3sjcxcjFISSwm1Fi+/2H
 jBAJKYnPT6eydTFyANnCEocPF0PUPGeU2NP3lhWkhk1AT+L/ooXMILaIQIDE874jLCA2s0C4
 xM21r8DmCAm0M0ocaBUDsTkFzCRWLPjJCjJTWCBUYsXpEJAwi4CqxMEJd5hAbF4BS4l3c9ax
 QpygIPHz6TJWiPFWEvd/XmaHGC8iMbuzjXkCo8AsJO4CRsZVjJKpBcW56bnFhgVGeanlesWJ
 ucWleel6yfm5mxjBIaultYNxz6oPeocYmTgYDzFKcDArifDe/KiRJsSbklhZlVqUH19UmpNa
 fIhRmoNFSZz32+veFCGB9MSS1OzU1ILUIpgsEwenVAOT1u+Gu9E/rBst1jzqzGtXZpjrG6qx
 NPLdHJFelmkv76WxdnG9nMwb53dtdXzeRNErOzhsWBI6O7eo9R4Pf2RcXj+TfeMt503nfwgt
 uXvSoTH++M8jU6/Mu7SiWo/ToTfyrnDB97L9xwsNeX7ufL38tLie91KN6h7TU7mPG/WvsZTH
 ufyZz9S4tf7GjNDpK2atlMk7xOF7UGP+3fef12SIFX7s29Z/bsbhtSV+MT+S7ji6RB/duE0s
 vV3lZar/wuR8/2kZjJfOv2BQl/52/n+SzIp1S56sXTxnrfOeiMN9L9g6d1ieirY6t90pfdui
 Uqs5/z+v/u5zP6J2mjZDTvCWeM3MpfssKmVCRE6u6WYTU2Ipzkg01GIuKk4EAAEQaBnIAgAA
X-CMS-MailID: 20240426063533epcas1p4f145c8a53b72e7d6eae235a3fed8f3aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240419060036epcas1p35c443d2d2bb75149343916cabe7da8af
References: <CGME20240419060036epcas1p35c443d2d2bb75149343916cabe7da8af@epcas1p3.samsung.com>
 <20240419060016.493713-1-u-kumar1@ti.com>
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



> -----Original Message-----
> From: Udit Kumar <u-kumar1@ti.com>
> Sent: Friday, April 19, 2024 3:00 PM
> To: n-francis@ti.com; jh80.chung@samsung.com; j-keerthy@ti.com
> Cc: nm@ti.com; trini@konsulko.com; sjg@chromium.org; u-boot@lists.denx.de; Udit Kumar <u-
> kumar1@ti.com>
> Subject: [PATCH] power: pmic: tps65941: Update compatible to aling with kernel DT
>
> Linux kernel driver drivers/mfd/tps6594-i2c.c is using different
> name for compatible for tps6594 family PMIC.
> After sync of Linux kernel DT to u-boot for TI platforms
> J7200, J721S2 and J784S4 PMIC is no longer getting probed.
>
> So updating compatible field to align with Linux driver and DT.
>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/pmic/tps65941.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/power/pmic/tps65941.c b/drivers/power/pmic/tps65941.c
> index 727b42747a..bf762deb29 100644
> --- a/drivers/power/pmic/tps65941.c
> +++ b/drivers/power/pmic/tps65941.c
> @@ -75,6 +75,9 @@ static const struct udevice_id tps65941_ids[] = {
>  	{ .compatible = "ti,tps659412", .data = TPS659411 },
>  	{ .compatible = "ti,tps659413", .data = TPS659413 },
>  	{ .compatible = "ti,lp876441",  .data =  LP876441 },
> +	{ .compatible = "ti,tps6594-q1", .data =  TPS659411 },
> +	{ .compatible = "ti,tps6593-q1", .data =  TPS659413 },
> +	{ .compatible = "ti,lp8764-q1",  .data =  LP876441 },
>  	{ }
>  };
>
> --
> 2.34.1



