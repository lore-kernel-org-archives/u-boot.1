Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40434D2C57C
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 23:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C315A88FF6;
	Wed, 23 Oct 2024 01:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="qJ5P5mRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF1489049; Wed, 23 Oct 2024 01:20:24 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A42488FD6
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 01:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20241022232016epoutp03c6ad03e5f910ea0d2abc7f93d5662ad7~A6bQoOfKK1479314793epoutp03t
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 23:20:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20241022232016epoutp03c6ad03e5f910ea0d2abc7f93d5662ad7~A6bQoOfKK1479314793epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1729639216;
 bh=8FCxiIhfmiPS2SghX/JUdjTfRIGkjmIUgpcAj9wTiRw=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=qJ5P5mRWdlqxA9r9nW5gXqKI+KLoK5ess9QnMc+eis9/DRDzz20vIBEr8O3C43loc
 aLY27W6Ex8+fUXA75xwJrLyaVSMw3xr2WS8SVM5dzK4n3wmDM7AXgBcmO5/LqiiyIg
 MHv11t4T9vyHhnrawTFp/6OBNuNtBWJ0F3z2C4hc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241022232016epcas1p2919fa7e44296156577954c11d0d7ada0~A6bQUHiIn2538425384epcas1p2X;
 Tue, 22 Oct 2024 23:20:16 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.134]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4XY7Sb2476z4x9Pt; Tue, 22 Oct
 2024 23:20:15 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 7E.FE.08588.F2338176; Wed, 23 Oct 2024 08:20:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241022232015epcas1p220bd969ddf1a2bd604df1ff7b29a6629~A6bO35Yh32538425384epcas1p2O;
 Tue, 22 Oct 2024 23:20:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241022232014epsmtrp276e65dc3907d9d0a2acef9a2771832da~A6bO290Jq2889228892epsmtrp2O;
 Tue, 22 Oct 2024 23:20:14 +0000 (GMT)
X-AuditID: b6c32a33-a57ff7000000218c-aa-6718332f4e05
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BF.A2.08229.E2338176; Wed, 23 Oct 2024 08:20:14 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241022232014epsmtip22002fa573d944f185671bf5dd6175b10~A6bOj57-Q0396003960epsmtip2o;
 Tue, 22 Oct 2024 23:20:14 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Manorit Chawdhry'" <m-chawdhry@ti.com>
Cc: <u-boot@lists.denx.de>, "'Neha Malcom Francis'" <n-francis@ti.com>,
 "'Keerthy	J'" <j-keerthy@ti.com>, "'Udit Kumar'" <u-kumar1@ti.com>, "'Aniket
 Limaye'" <a-limaye@ti.com>, "'Tom Rini'" <trini@konsulko.com>, "'Vignesh
 Raghavendra'" <vigneshr@ti.com>, "'Andrew Davis'" <afd@ti.com>, "'Nishanth
 Menon'" <nm@ti.com>, "'Simon Glass'" <sjg@chromium.org>
In-Reply-To: <20241015-b4-upstream-j721s2-avs-v5-1-5c8087387dc5@ti.com>
Subject: RE: [PATCH v5 1/7] power: pmic: tps65941: Add DM_PMIC dependency
Date: Wed, 23 Oct 2024 08:20:14 +0900
Message-ID: <0a5e01db24d8$f30ccd80$d9266880$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQFZ+uHwsA/FFz51NiRmymUl/hNhTgHw2MbOARHAdLizfadOwA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTX1ffWCLdoO8Pt8WtlXYW709NZLc4
 tb2JyeLSg1SLkzda2S3e/DjLZPFtyzZGi6mTNrNbvN3byW4xbe8MZov/Zz+wO3B7zG64yOLx
 6sAqdo+zd3Ywehy/sZ0pgCUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEv
 MTfVVsnFJ0DXLTMH6CglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFpgV5xYm5x
 aV66Xl5qiZWhgYGRKVBhQnbGkf33WAse8lS077vJ2sB4lquLkZNDQsBEomPjJZYuRi4OIYEd
 jBJ7N65khXA+MUo8PPqNEcL5xijRvfEkUBkHWMvZR44Q8b2MEge/PGSGcF4ySvyc2sMGMpdN
 QE/i/6KFzCC2iICOxJ9DrWA7mAVeMElc7d8HVsQp4C7xa/I1MFtYwFPi34QXbCAbWARUJV5t
 9QYJ8wpYSkz8eY4R4lYFiZ9Pl7GC2MwCIhKzO9ug5jtJzNx7Amy+hMBXdoklH1tYIRpcJBb+
 nsMMYQtLvDq+hR3ClpL4/G4vG0RDM6PE0iUHWSGcHkaJfw3X2SCqjCX2L53MBHIRs4CmxPpd
 +hCb+STefe1hhQQFr0RHmxBEtYrEpdcvmWDm333yH+oGD4nlO3vZISF0nVFixvuFTBMY5Wch
 eWIWwoYFjEyrGMVSC4pz01OTDQsM4XGZnJ+7iRGcHLWMdzBenv9P7xAjEwfjIUYJDmYlEV6l
 EtF0Id6UxMqq1KL8+KLSnNTiQ4ymwJCcyCwlmpwPTM95JfGGJpYGJmZGxiYWhmaGSuK8Z66U
 pQoJpCeWpGanphakFsH0MXFwSjUwlW6++KdC/Pg869SCd017U1e69B/8+a+3zyLduLb7esrN
 fK2cpS8WmNa8s5zF8pLl5lTd0OMZX/hOxaxN9Xuz5GAZ15Zp18OseFpvdq5d8Eg5fiaDw83A
 I96HzWfWFuV9vJEVttDjv2XOiiDniaGNVzvnKL749sO8aH9rNaO+Vxvrzg2ifnf+zMli2c95
 +8M5pnLedlcHBpYXNWv+1+8K4LTqv/9mF9Oj4pgUmacF87IyF6k/nm7hbe69TC35Hsv84/G2
 /8+tkjkRVq157co15Ynh7VLPTOTNn8TN3cLypZk777eD6LaUMxFuzuI3A+t/mteIsvd88jXo
 ZVp9cM+dVsamDQvuxyWU6+gE1V5XYinOSDTUYi4qTgQANdxOkRcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSvK6esUS6wbLnRha3VtpZvD81kd3i
 1PYmJotLD1ItTt5oZbd48+Msk8W3LdsYLaZO2sxu8XZvJ7vFtL0zmC3+n/3A7sDtMbvhIovH
 qwOr2D3O3tnB6HH8xnamAJYoLpuU1JzMstQifbsErowj+++xFjzkqWjfd5O1gfEsVxcjB4eE
 gInE2UeOXYxcHEICuxkl2g6uY+5i5ASKS0l8fjqVDaJGWOLw4WKImueMEqe/PWMDqWET0JP4
 v2ghWL2IgI7En0OtLCA2s8AnJom5v4IhGi4zSixdvxWsiFPAXeLX5GtgzcICnhL/JrwAW8Ai
 oCrxaqs3SJhXwFJi4s9zjBA3KEj8fLqMFWKmiMTszjaoXU4SM/eeYJnAKDALSWoBI+MqRsnU
 guLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgsNbS3MG4fdUHvUOMTByMhxglOJiVRHiVSkTT
 hXhTEiurUovy44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBKNTAJefgIHS59
 faL7y6vszOS0F9pmTy5eYKxv+vLjzmnRr2osLS3OMu2fp20ybw16Gz7V5fDvxJa9XbMMeQ/W
 3vx0dTWj8FFTe2t1rVDlk9bHur0vOXC1Gd65s4Dl1xPdOS3B1s7ckze+VEub0HmjTPmGtfmy
 TrUFUeqrIzo9WxZ+t110p/bnTCGlm8Z3T5U2l+Q51Oz+L/lgsvfXWTzpOd0tlrnKIUft7i1w
 vpPszVIzh/uG4ZMjV//2T8wU85lYdq/sQeHxaCUl2clHXlo3xnXsMNybVpi0dFd/5CTnTyX+
 3iwfY224rvocedl8S7KKQZ2TZeW2QLe5mzq1THXunbTjWiZmH/re2en/7y8Oy5RYijMSDbWY
 i4oTAUYovwzaAgAA
X-CMS-MailID: 20241022232015epcas1p220bd969ddf1a2bd604df1ff7b29a6629
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241015105233epcas1p1bf750c216a3cbe2190cd3f6af8254784
References: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
 <CGME20241015105233epcas1p1bf750c216a3cbe2190cd3f6af8254784@epcas1p1.samsung.com>
 <20241015-b4-upstream-j721s2-avs-v5-1-5c8087387dc5@ti.com>
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
> From: Manorit Chawdhry <m-chawdhry@ti.com>
> Sent: Tuesday, October 15, 2024 7:52 PM
> To: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: u-boot@lists.denx.de; Neha Malcom Francis <n-francis@ti.com>; Keerthy J <j-keerthy@ti.com>; Udit
> Kumar <u-kumar1@ti.com>; Aniket Limaye <a-limaye@ti.com>; Tom Rini <trini@konsulko.com>; Vignesh
> Raghavendra <vigneshr@ti.com>; Andrew Davis <afd@ti.com>; Nishanth Menon <nm@ti.com>; Simon Glass
> <sjg@chromium.org>; Manorit Chawdhry <m-chawdhry@ti.com>
> Subject: [PATCH v5 1/7] power: pmic: tps65941: Add DM_PMIC dependency
>
> This Kconfig depends on DM_PMIC but hadn't be explicitly stated which
> could cause config related issues.
>
> Adds the dependency in Kconfig for tps65941.
>
> Fixes: 6b86dd0c1ead ("power: pmic: tps65941: Add support for tps65941 family of PMICs")
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>


Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/pmic/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
> index 562c1a3b122a..bbcbcee4c355 100644
> --- a/drivers/power/pmic/Kconfig
> +++ b/drivers/power/pmic/Kconfig
> @@ -394,6 +394,7 @@ config SPL_PMIC_LP87565
>
>  config PMIC_TPS65941
>  	bool "Enable driver for Texas Instruments TPS65941 PMIC"
> +	depends on DM_PMIC
>  	help
>  	The TPS65941 is a PMIC containing a bunch of SMPS & LDOs.
>  	This driver binds the pmic children.
>
> --
> 2.46.0



