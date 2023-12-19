Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8499EC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:43:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A5EC87755;
	Tue, 19 Dec 2023 12:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Z+0fPXdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BBD887646; Tue, 19 Dec 2023 12:40:10 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B46876B4
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 12:40:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231219114001epoutp018cdd8634eb1defd41390ea42cd11d1e4~iOL7Jn6aa0510705107epoutp01w
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:40:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231219114001epoutp018cdd8634eb1defd41390ea42cd11d1e4~iOL7Jn6aa0510705107epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1702986001;
 bh=EiGknHQLRkmU9S8Mwf1xT07HR4ZO460P1TtpUYxDkFI=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=Z+0fPXdz49d7p2s0lwWy40vlwgx2kkO3Drxq3nqW9+tEWqrvzSrlixtDMWCG4ng8i
 63UoEbUCVR2owsjeKwtE183IgY10Rhq3rQdKcG8LuzkOgYv48JpKuXzn3Esv5oi1ka
 jRoGaVfasZwVtcVmlKCxw8vetI0tmKiTwvCLypKI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20231219114000epcas2p21c3099331cfbff8677e009d1875baac8~iOL6V-hcr1866618666epcas2p2v;
 Tue, 19 Dec 2023 11:40:00 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.89]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SvZVl5Y6vz4x9Px; Tue, 19 Dec
 2023 11:39:59 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 73.30.09622.F0181856; Tue, 19 Dec 2023 20:39:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20231219113958epcas2p4db54f4b985a584e662be0d45cd308575~iOL4sCC5_1598815988epcas2p44;
 Tue, 19 Dec 2023 11:39:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231219113958epsmtrp237be8821ce12309a255805a47d7e90ec~iOL4q3QUa2201622016epsmtrp2i;
 Tue, 19 Dec 2023 11:39:58 +0000 (GMT)
X-AuditID: b6c32a46-fcdfd70000002596-01-6581810fa6dd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 0A.D6.08817.E0181856; Tue, 19 Dec 2023 20:39:58 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231219113958epsmtip21790ffbbf1c361e3937d5a350b448b79~iOL4YsJky3217432174epsmtip2V;
 Tue, 19 Dec 2023 11:39:58 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Sam Protsenko'" <semen.protsenko@linaro.org>, "'Minkyu Kang'"
 <mk7.kang@samsung.com>, "'Tom Rini'" <trini@konsulko.com>, "'Lukasz
 Majewski'" <lukma@denx.de>, "'Sean Anderson'" <seanga2@gmail.com>
Cc: "'Simon Glass'" <sjg@chromium.org>, "'Heinrich Schuchardt'"
 <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
In-Reply-To: <20231213031646.28828-6-semen.protsenko@linaro.org>
Subject: RE: [PATCH 05/13] soc: samsung: Add Exynos PMU driver
Date: Tue, 19 Dec 2023 20:39:58 +0900
Message-ID: <006f01da3270$181dc0e0$485942a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
X-Drm-Type: PERSONAL
X-Msg-Type: PERSONAL
Thread-Index: AQJxF1WUQWvk8XWc6dZlUfJtoqni1wExP7BgAhYV+UGvaHa/QA==
x-delete-securityphrase: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmhS5/Y2OqwbkmTYvn7y4zWXQcaWG0
 2HpvApPF8759TBbftmxjtJg6aTO7xdu9newWh6d+YHTg8JjdcJHFY96sEyweO2fdZff48DHO
 49WBVewed67tYfM4e2cHo0ffllWMARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqG
 lhbmSgp5ibmptkouPgG6bpk5QKcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrM
 C/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz2s6sYCtYxFkx53ozYwPjLfYuRg4OCQETifeTM7sY
 uTiEBHYwSkx8uJ4dwvnEKHF2yxUo5xujRPfpG4wwHd//1ELE9zJK3FvUBVX0glHi/LEZTF2M
 nBxsAvoSLzu2sYIkRATOMkqcuXWKHSTBLJAnMWP/DDCbU8BB4svM42ANwgJ2Erde7WQDsVkE
 VCVOXHjACmLzClhKPL87lxHCFpQ4OfMJC8QceYntb+cwg9gSAgoSP58uY4WIi0u8PHqEHSIu
 IvFw9Uc4u/XeWWaQD0QEnCQmNetAhKUkZr9+CfaAhMAXDomba2+yQSRcJOZe/MIKYQtLvDq+
 hR2m4fO7vVA1xRJdbZdYIJobGCVOt1+BKrKX+HFzCivIMmYBTYn1u/QhbuOT6Dj8FxruvBId
 bUITGFVmIflsFpLPZiH5ZhbCoAWMLKsYxVILinPTU4uNCozgkZ2cn7uJEZxqtdx2ME55+0Hv
 ECMTB+MhRgkOZiURXpdF9alCvCmJlVWpRfnxRaU5qcWHGE2BYT2RWUo0OR+Y7PNK4g1NLA1M
 zMwMzY1MDcyVxHnvtc5NERJITyxJzU5NLUgtgulj4uCUamDi+asn27V5su37+NmvN7ZUpZht
 3DbxN6+eh0HaxJtunLNijh3jYYzex/n26nPBzzfcSwIZjtmkHol/a37UXr97QaZCzNX3h908
 +tcdDvX9uJxprWmTTaHya6VNDGu41UWan2Ra+zFdtcvqFWD/uTaV+5dvr9TTnjc9W/+vcLr4
 OMY5/fBBmd0NvJ+nxmo4iSzZVnVe/vvanR8+3LUVf2ua6vDmRkVw4ewdgle/95xubFCJZDY6
 L+3T9iC0OeYyZ0apZrHuCb2uJZacYcwO2+wY8iqnrn7desL4bcD0kzUq9o5nf0bsaGStnvX1
 1DKDDWFrnlb8ijqZseXhdYHNkV/U/5y00qiSjKluUUz9fl+JpTgj0VCLuag4EQCXDus9PgQA
 AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCSvC5fY2OqwYoFohbP311msug40sJo
 sfXeBCaL5337mCy+bdnGaDF10mZ2i7d7O9ktDk/9wOjA4TG74SKLx7xZJ1g8ds66y+7x4WOc
 x6sDq9g97lzbw+Zx9s4ORo++LasYAziiuGxSUnMyy1KL9O0SuDLazqxgK1jEWTHnejNjA+Mt
 9i5GDg4JAROJ739quxg5OYQEdjNKzJyZB2JLCMhKPHu3gx3CFpa433KEtYuRC6jmGaPE7FMf
 mUASbAL6Ei87toElRAQuMkqsadjJCJJgFiiQuDj/GhtEx1FGidvTbzGDJDgFHCS+zDwO1i0s
 YCdx69VONhCbRUBV4sSFB6wgNq+ApcTzu3MZIWxBiZMzn7CAXMosoCfRthFqvrzE9rdzmCGu
 U5D4+XQZK8zVf47OZYOoEZd4efQI1AciEg9Xf4T75tXxLXDx1ntnmUHGiwg4SUxq1oEIi0nM
 nHYZaryUxOzXL9knMErOQnLQLISDZiE5aBaSxQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfm
 pesl5+duYgQnAC2tHYx7Vn3QO8TIxMF4iFGCg1lJhNdlUX2qEG9KYmVValF+fFFpTmrxIUZp
 DhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxSDUzTZT72PjjxWf1UqyBzzoddrAf0eqYv2DBj
 icTKpQw1Lw3jzvTOOhSZ2DEhqWZ17d75/7+nPl1Zw28j8//Af6td3Uv2uHA2adeVHmeS5dg1
 adPq8C9/Xlzgz7z48PGNEy/k1/2ZxX6+xfS9bdsXV+WJ7odY/5ny2/Te/n5XjTHli9ik3lnS
 2zTTpHaL6t4rvPZw772Va8xvmTpMnr5T+ON7PSfvumzRczN6Q0/yf3wn3Bfx4cmfjZlTsk7M
 vF019XDsk71s7yTuMm9j8Xtau8e5Ket44bIjHd6/cjtn87re3Xw7o+znJ6V0/8+bPtqkdU9e
 Xv0mcErTVMlDTgGnM44m293s98pNnZHF3WjJz3T3mRJLcUaioRZzUXEiAO847PpvAwAA
X-CMS-MailID: 20231219113958epcas2p4db54f4b985a584e662be0d45cd308575
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213031743epcas2p1496913693ef306a996f48d706217a33b
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
 <CGME20231213031743epcas2p1496913693ef306a996f48d706217a33b@epcas2p1.samsung.com>
 <20231213031646.28828-6-semen.protsenko@linaro.org>
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
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Sam Protsenko
> Sent: Wednesday, December 13, 2023 12:17 PM
> To: Minkyu Kang <mk7.kang@samsung.com>; Tom Rini <trini@konsulko.com>;
> Lukasz Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>; Heinrich Schuchardt
> <xypron.glpk@gmx.de>; u-boot@lists.denx.de
> Subject: [PATCH 05/13] soc: samsung: Add Exynos PMU driver
> 
> Add basic Power Management Unit (PMU) driver for Exynos SoCs. For now
> it's only capable of changing UART path in PMU, which is needed for
> E850-96 board. The driver's structure resembles the exynos-pmu driver
> from Linux kernel, and although it's very basic and slim at the moment,
> it can be easily extended in future if the need arises.
> 
> UCLASS_NOP is used, as there are no benefits in using more elaborate
> classes like UCLASS_MISC in this case. The DM_FLAG_PROBE_AFTER_BIND flag
> is added in bind function, as the probe function must be always called
> for this driver.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

