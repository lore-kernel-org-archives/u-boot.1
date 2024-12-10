Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E6FE77182
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 22:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7BDC800AD;
	Tue, 10 Dec 2024 23:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="DF6PwMQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46DBC800AB; Tue, 10 Dec 2024 23:36:12 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0054E80212
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 23:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20241210223604epoutp02c0d8cb9da1466b060508bf680b8c13bd~P8bpMAzPH1542215422epoutp02Z
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 22:36:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20241210223604epoutp02c0d8cb9da1466b060508bf680b8c13bd~P8bpMAzPH1542215422epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733870164;
 bh=TVqp1L0TRMtAUWtik9K6F+vFpgjhRvgxXv+I7bgfCpU=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=DF6PwMQ2V6ofVLhmJFMZ/hIG/0bpvp18V6Qn9Qy1ChiNJH4Ssg9HFU2SHuds/smSR
 bfCWZiP4kP/u8wswIHmZpwV+kZ1l2k1ATTjXMQYbfL30jlIGwD9yoR+Yjx/WPc2SIu
 1EIOa/XoN3VrcDGoR3l4X3JMkE0s9K72c8f2F50Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20241210223603epcas1p193c07e612b8dba85131933a436028bd7~P8boggLqr1704817048epcas1p1T;
 Tue, 10 Dec 2024 22:36:03 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.237]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4Y7D8x5SNrz4x9Pw; Tue, 10 Dec
 2024 22:36:01 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 D7.6F.23869.152C8576; Wed, 11 Dec 2024 07:36:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241210223601epcas1p29700f0a9bd234a67e99cced5e9f7d59b~P8bmxi88f2290122901epcas1p2p;
 Tue, 10 Dec 2024 22:36:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241210223601epsmtrp29c07a465ffccc0c01c881213ac812047~P8bmwz_1T0216102161epsmtrp2G;
 Tue, 10 Dec 2024 22:36:01 +0000 (GMT)
X-AuditID: b6c32a36-6f5e970000005d3d-24-6758c251d917
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 15.A9.18949.152C8576; Wed, 11 Dec 2024 07:36:01 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241210223601epsmtip21bbf159d3ff797b05f0ebed912a88717~P8bmiw4WE1533915339epsmtip2k;
 Tue, 10 Dec 2024 22:36:01 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Svyatoslav Ryhel'" <clamor95@gmail.com>, "'Tom Rini'"
 <trini@konsulko.com>, "'Simon Glass'" <sjg@chromium.org>, "'Peter	Robinson'"
 <pbrobinson@gmail.com>, "'Heiko Schocher'" <hs@denx.de>, "'Jonas Karlman'"
 <jonas@kwiboo.se>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <20241209161434.6563-4-clamor95@gmail.com>
Subject: RE: [PATCH v1 3/3] pmic: palmas: bind sysreset to parent node
Date: Wed, 11 Dec 2024 07:36:00 +0900
Message-ID: <0bf201db4b53$e3a287d0$aae79770$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHwBcTaW7dMJxSGs0Uxb68V/PRZywGudpzmAi2XiiCyl7uxgA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmnm7goYh0gyd7tC0O9PcyWuy4c5/Z
 4uSbqywW61atYbP4tmUbo8XUSZvZLd7u7WR3YPeY3XCRxWPerBMsHjtn3WX3eHVgFbvHiQmX
 mDzO3tnBGMAWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg
 65aZA3SMkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAtECvODG3uDQvXS8vtcTK
 0MDAyBSoMCE74/Hk3SwFlzgqjt2ZyNjA+JWti5GTQ0LARGLJ81nsXYxcHEICOxgllh6exgLh
 fGKUaGzZyAThfGOU+Na7mR2m5frDuVAtexklGm6fgXJeMkp8/38OrIpNQE/i/6KFzCAJEYHX
 jBIbZnaygiSYBaQkmk7uYgSxOQXMJR4cmccMYgsLuEn09D8Ci7MIqEpsnbEcyObg4BWwlNh1
 ygdis4LEz6fLwMaICDhJvOs5xQ4xUkRidmcb2C4JgbfsEt0rl0N95yLxdu1aKFtY4tXxLVAv
 SEl8freXDaKhGejrJQdZIZweRol/DdehOowl9i+dzARyBbOApsT6XfoQ2/gk3n3tYQUJSwjw
 SnS0CUFUq0hcev2SCWb+3Sf/WSFsD4nXS9ZDQ2g7o8TW3ycZJzDKz0Jy+CyEDQsYmVYxiqUW
 FOempxYbFhjBIzM5P3cTIzgdapntYJz09oPeIUYmDsZDjBIczEoivBzeoelCvCmJlVWpRfnx
 RaU5qcWHGE2BITmRWUo0OR+YkPNK4g1NLA1MzIyMTSwMzQyVxHnPXClLFRJITyxJzU5NLUgt
 gulj4uCUamBqN1ASmb/6umXeKeGvEcv+bH32d4twx54SwRe6D33Np5l6HX1zwSN4Q6eTI/vb
 NPslyxQeqrtX2m7yiV7MuPKiMBNTQsyB5z7PJPdOeFnuW3GaPzFB4RJ7d7aCxr/qDx8ivOVc
 FPp/128NUOY5FsTeUMQv97u86kLDafY+9aqGKaf2xUys2mbW1BokLfRkmucq02z90Au/9bLn
 +6y6OEGV48wim9h3zMFFpiKJ/xkUPy/YbbZb6dSbudYPBdbc/fnrqcTjJZpb45sNBZSnXIqX
 Exe4fdSgWT3y22pXn66T13Lc9rv+iY2c8eG37pSjx9/vVprP2CEY+OZAe0D1ot9m3O855r7b
 L1R+sij/dIUSS3FGoqEWc1FxIgBt1I2nEAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSvG7goYh0g6UdghYH+nsZLXbcuc9s
 cfLNVRaLdavWsFl827KN0WLqpM3sFm/3drI7sHvMbrjI4jFv1gkWj52z7rJ7vDqwit3jxIRL
 TB5n7+xgDGCL4rJJSc3JLEst0rdL4Mp4PHk3S8EljopjdyYyNjB+Zeti5OSQEDCRuP5wLjuI
 LSSwm1Hi00FZiLiUxOenU4FqOIBsYYnDh4u7GLmASp4zSrxsuc4IUsMmoCfxf9FCZhBbROA9
 o8T2a/ogNjNQb9PJXYwQDZsZJZov3gRbxilgLvHgyDywBmEBN4me/kdgg1gEVCW2zljOCLKM
 V8BSYtcpH4gbFCR+Pl3GCjHfSeJdzyl2iPkiErM725gnMArMQuIuYGRcxSiZWlCcm55bbFhg
 lJdarlecmFtcmpeul5yfu4kRHMZaWjsY96z6oHeIkYmD8RCjBAezkggvh3douhBvSmJlVWpR
 fnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2CyTBycUg1M/k9q/y29YH0++fPVOEaT
 xb9vhf+b/dOJd03+LaE5W1d/UmS0WyO1eO6zBQUTFzPHmEW8/H3Z/JtsxPZ7Hw//zNDlmKg5
 5ULo8tCAO59vnHFcKySiFJw1ef/e4xcWh6an/Grj/n3mx1nnBbJ3tqZEFvT12dWkyygbm/00
 c+jc5++k5XK9p4pNuP7coiRh2b2boi/WmoXlzJVI0borEXqrbYkg565Zm0umMTncFNU/+XZN
 1QPu8OVrXwabl9W6lL51nHdM3G+F/q5zqk9PTg3h/R6TPef1mV2mWd4fF/g9TRPeeuLw/hkd
 0pe3/Oq+rP9t5oYr55MrFksIZh459/C+cF+Yr0JEo++bLqm7x6VbHJRYijMSDbWYi4oTAdD/
 tobSAgAA
X-CMS-MailID: 20241210223601epcas1p29700f0a9bd234a67e99cced5e9f7d59b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241209161507epcas1p42abfc4ea0439fce1f9ed20b21c20e637
References: <20241209161434.6563-1-clamor95@gmail.com>
 <CGME20241209161507epcas1p42abfc4ea0439fce1f9ed20b21c20e637@epcas1p4.samsung.com>
 <20241209161434.6563-4-clamor95@gmail.com>
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
> From: Svyatoslav Ryhel <clamor95@gmail.com>
> Sent: Tuesday, December 10, 2024 1:15 AM
> Bind SYSRESET child to parent node since it does not have
> its own node in the device tree.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>


Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,

> ---
>  drivers/power/pmic/palmas.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
> index f676bf64169..37d4190fabe 100644
> --- a/drivers/power/pmic/palmas.c
> +++ b/drivers/power/pmic/palmas.c
> @@ -49,8 +49,9 @@ static int palmas_bind(struct udevice *dev)
>  	int children, ret;
>
>  	if (IS_ENABLED(CONFIG_SYSRESET_PALMAS)) {
> -		ret = device_bind_driver(dev, PALMAS_RST_DRIVER,
> -					 "sysreset", NULL);
> +		ret = device_bind_driver_to_node(dev, PALMAS_RST_DRIVER,
> +						 "sysreset", dev_ofnode(dev),
> +						 NULL);
>  		if (ret) {
>  			log_err("cannot bind SYSRESET (ret = %d)\n", ret);
>  			return ret;
> --
> 2.43.0



