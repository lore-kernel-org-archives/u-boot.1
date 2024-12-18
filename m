Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6FDE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 22:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F768022B;
	Wed, 18 Dec 2024 23:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="oi1/6cPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BFDD802B4; Wed, 18 Dec 2024 23:44:50 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E81338021D
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 23:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241218224440epoutp04e532b2256faadf5a0ef6901e88f6981d~SZtcCvbns2007420074epoutp04N
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 22:44:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241218224440epoutp04e532b2256faadf5a0ef6901e88f6981d~SZtcCvbns2007420074epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1734561880;
 bh=zgQh1p9yRhxIOVJPR+KOthBE3JTUS7AnUuMJIjiFVww=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=oi1/6cPO4l9azV/56sCKL1JsLhuPBp9qGT85+ejwWIZ/Zcvwd1uRK/f1ZujUBRD7f
 gxjN8bcraiG2V+9lcuuPHfJDwjXrHSrBGnPiD0GIdOQB3KFGBLw+UGp93zRWM8l601
 XdqGpSb47CPPjNCAaACdBrc4NokduRjHFe3XdApA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241218224439epcas1p2b8893e570ced59b0398f67423994a9d8~SZtbtCr8h1856918569epcas1p2c;
 Wed, 18 Dec 2024 22:44:39 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.231]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4YD7zB63nbz4x9Ps; Wed, 18 Dec
 2024 22:44:38 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F2.BC.31735.65053676; Thu, 19 Dec 2024 07:44:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241218224438epcas1p2fee74afbd74ebc3e389b78cb194e5c6a~SZtaa2JpH1857518575epcas1p2D;
 Wed, 18 Dec 2024 22:44:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241218224438epsmtrp2efa7dfc2256b62f7fd818e6f3a32296b~SZtaaDrLZ1148511485epsmtrp2W;
 Wed, 18 Dec 2024 22:44:38 +0000 (GMT)
X-AuditID: b6c32a4c-ad1fe70000007bf7-f3-676350569c47
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 3C.58.18949.65053676; Thu, 19 Dec 2024 07:44:38 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241218224438epsmtip2f72b7862924e760bfa06d3a5a51bf45b~SZtaPCs5q2194921949epsmtip2V;
 Wed, 18 Dec 2024 22:44:38 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Shree Ramamoorthy'" <s-ramamoorthy@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
Cc: <m-leonard@ti.com>, <praneeth@ti.com>
In-Reply-To: <20241218171236.1022565-2-s-ramamoorthy@ti.com>
Subject: RE: [PATCH v1 1/2] power: regulator: replace printf() with pr_err()
Date: Thu, 19 Dec 2024 07:44:37 +0900
Message-ID: <01e301db519e$6b18ed80$414ac880$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQDJjZr8Ya4lM0w/UNXlTz8OpdnKCAJLF2nhAfA6lWu07kZFQA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmvm5YQHK6wbbjBhYPt89jsfjz6CWb
 xa9D65ktpk7azG7xdm8nuwOrx6sDq9g9zt7Zwehx/MZ2pgDmqGybjNTElNQihdS85PyUzLx0
 WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCdSgpliTmlQKGAxOJiJX07m6L80pJU
 hYz84hJbpdSClJwC0wK94sTc4tK8dL281BIrQwMDI1OgwoTsjG+t/5gLlnBX7Fh8gaWBcQZn
 FyMnh4SAicSt7S2sXYxcHEICexglpn/7wg7hfGKU2Ld1AxuE841R4sncqawwLR3/DjBBJPYy
 Stx+B9PyklFiRc9bdpAqNgE9if+LFjKD2CICCRJ/Nt1mArGZBTQl9mzfyAJicwrYSLT1PWEE
 sYUFfCSebX0BVsMioCqx+9kRMJtXwFLi+PtPTBCbFSR+Pl3GCjFHRGJ2ZxvUfCeJY4tWsIAc
 ISFwil3i4vk5bBANLhLz3+xjhrCFJV4d38IOYUtJfH63lw2ioZlRYumSg6wQTg+jxL+G61Dd
 xhL7l04GWs0Bdvb6XfoQm/kk3n3tYQUJSwjwSnS0CUFUq0hcev2SCWb+3Sf/ocHlIbFsby80
 uA4C7eo6xTSBUX4WkidmIWxYwMi0ilEqtaA4Nz012bDAUDcvtRweocn5uZsYwUlOy2cH4/f1
 f/UOMTJxMB5ilOBgVhLhddNMTBfiTUmsrEotyo8vKs1JLT7EaAoMzonMUqLJ+cA0m1cSb2hi
 aWBiZmRsYmFoZqgkznvmSlmqkEB6YklqdmpqQWoRTB8TB6dUA9PKR0b3qlN6LXm2B0xj5Lwj
 53ri10WmY/ZNwmzTF9bMS+Q/P03oSKN14qODVpwzq8//ebnq74bDtrKK7rdYe2Y4TvQovr+F
 +cpC2WabmlmKbLmcKRn9LvWPXtV+j1J5+f2+RfLHl8v/vWJRteno9KjUX7BcM3NG+a6Sx5q6
 Ilm/Fp6s3yWjrrw22Pts0NuZR2YvLH53PnyTzNzy/IvG2zfMe72QrVpyxv2cDrM9LApqV574
 rz0oYhtUKruBQcPP/6Hi28W6j70XLbUS+f8ln3kHf9hrC6eHekUxqmGi7uvW9EkKaX/Yp/Bg
 +fyIxrXPGuzEZt2I6WPepT7h5LR9MVfScpfN99l08sDVn9LbpsgqsRRnJBpqMRcVJwIArg+3
 pvsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWy7bCSvG5YQHK6wcy/QhYPt89jsfjz6CWb
 xa9D65ktpk7azG7xdm8nuwOrx6sDq9g9zt7Zwehx/MZ2pgDmKC6blNSczLLUIn27BK6Mb63/
 mAuWcFfsWHyBpYFxBmcXIyeHhICJRMe/A0xdjFwcQgK7GSW27t3ODpGQkvj8dCpbFyMHkC0s
 cfhwMUTNc0aJP2/ng9WwCehJ/F+0kBmkRkQgSeLE5lqQMLOAtkT3og5GiPq9jBIzrixmAklw
 CthItPU9YQSxhQV8JJ5tfQEWZxFQldj97AiYzStgKXH8/ScmiBsUJH4+XcYKMVREYnZnGzOI
 LSLgJHFs0QqWCYwCs5CkFjAyrmKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA5LLa0d
 jHtWfdA7xMjEwXiIUYKDWUmE100zMV2INyWxsiq1KD++qDQntfgQozQHi5I477fXvSlCAumJ
 JanZqakFqUUwWSYOTqkGJqezWtdez4wIcZm6OEK41Mbj+oe3d+drsKzjEv+8a+4s390z607t
 f/LY+sWkS4ui2+bp3Mxet8WwbTIHS0/+lM0WjreEZbv8ZbhuP4rZ7fnuxxfdfO5Hu/ZcLLpz
 YqrD5ut9Yp8zr8RFHva71KL9K3Z5/OF9R8M61m0xiHt8Qot5C3/egwb/+asr+m/XBArs7n+y
 3S6wISfxqsTt8zYnI6pZwnbtOSbNK9EkKMS83NH+jDfrVbb++fz8pe1V7UnvyvkaM6PmLc1i
 CX1yrvVpevMK9hX2HvnMH95rORpfeT/NxExI7L+knV/b596mm1t0+uoMH3QeLf/Kt4V7VoTQ
 F58mXl1f4cCnMiuVnj7vVWIpzkg01GIuKk4EAFKNCJ+6AgAA
X-CMS-MailID: 20241218224438epcas1p2fee74afbd74ebc3e389b78cb194e5c6a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241218171243epcas1p23ee518764dd0f1c0bb275e474db4ad03
References: <20241218171236.1022565-1-s-ramamoorthy@ti.com>
 <CGME20241218171243epcas1p23ee518764dd0f1c0bb275e474db4ad03@epcas1p2.samsung.com>
 <20241218171236.1022565-2-s-ramamoorthy@ti.com>
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
> From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> Sent: Thursday, December 19, 2024 2:13 AM
>
> Replace printf() with pr_err() because pr_err() has a uniform print format
> and takes into consideration the log levels supported.
>
> Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/regulator/tps65219_regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/regulator/tps65219_regulator.c
> b/drivers/power/regulator/tps65219_regulator.c
> index b7124fed0245..4b0fb205909a 100644
> --- a/drivers/power/regulator/tps65219_regulator.c
> +++ b/drivers/power/regulator/tps65219_regulator.c
> @@ -250,7 +250,7 @@ static int tps65219_ldo_probe(struct udevice *dev)
>  	/* idx must be in 1..TPS65219_LDO_NUM */
>  	idx = dev->driver_data;
>  	if (idx < 1 || idx > TPS65219_LDO_NUM) {
> -		printf("Wrong ID for regulator\n");
> +		pr_err("Wrong ID for regulator\n");
>  		return -EINVAL;
>  	}
>
> @@ -271,7 +271,7 @@ static int tps65219_buck_probe(struct udevice *dev)
>  	/* idx must be in 1..TPS65219_BUCK_NUM */
>  	idx = dev->driver_data;
>  	if (idx < 1 || idx > TPS65219_BUCK_NUM) {
> -		printf("Wrong ID for regulator\n");
> +		pr_err("Wrong ID for regulator\n");
>  		return -EINVAL;
>  	}
>
> --
> 2.34.1



