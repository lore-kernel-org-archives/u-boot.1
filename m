Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43602E7718B
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 02:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D008800D7;
	Thu,  2 Jan 2025 03:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="uXgdQXgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E40DC80107; Thu,  2 Jan 2025 03:08:16 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCE9480087
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 03:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20250102020807epoutp0499609b23527d0c7b0d74478f4f4fa9c7~WvhFBzqtx1095210952epoutp04G
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 02:08:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20250102020807epoutp0499609b23527d0c7b0d74478f4f4fa9c7~WvhFBzqtx1095210952epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1735783687;
 bh=kP+cYOW2oDUjuTPZRIQBczFHe1c4KwbituuB39abCW8=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=uXgdQXgFm7fRI4oKofoea7wgkiD5hvFVe3mTp7XvuGQQT6ZQdt+gkhP1WyXYn6Rgf
 ia5tRvpBDU4+INWorrLTzBabVGSRjeA0vqoo6UYD6a8F39ZAhMVehIiNJuDV44QfAU
 k/YeEHf38QGlWdNC8sVGu9DMcVyQKWfNW2ud37wQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20250102020807epcas1p3f3dc4a829f92bb7034b67ebcf19c09f6~WvhE6OWpY2718127181epcas1p3Q;
 Thu,  2 Jan 2025 02:08:07 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.232]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4YNqqT5Rxvz4x9Q0; Thu,  2 Jan
 2025 02:08:05 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 02.44.23253.405F5776; Thu,  2 Jan 2025 11:08:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20250102020804epcas1p3bba76603de87d5eade74a89260588525~WvhB9lKKQ2232222322epcas1p30;
 Thu,  2 Jan 2025 02:08:04 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250102020804epsmtrp1feb16de20dc1ce2d3ae9c1425763db10~WvhB8r_aE2154421544epsmtrp1Z;
 Thu,  2 Jan 2025 02:08:04 +0000 (GMT)
X-AuditID: b6c32a33-5a18170000005ad5-97-6775f504976d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 45.DD.33707.405F5776; Thu,  2 Jan 2025 11:08:04 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20250102020804epsmtip2131c7bec4d00dbbd710436e45c8676da~WvhBxy8df1179011790epsmtip2H;
 Thu,  2 Jan 2025 02:08:04 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Udit Kumar'" <u-kumar1@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <j-keerthy@ti.com>
Cc: <bhargav.r@ltts.com>, <d-gole@ti.com>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>
In-Reply-To: <20241227173024.2346452-1-u-kumar1@ti.com>
Subject: RE: [PATCH] power: pmic: tps65941: Fix TI TPS65224 PMIC compatiable
Date: Thu, 2 Jan 2025 11:08:03 +0900
Message-ID: <0cd201db5cbb$28496520$78dc2f60$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQGW8ZA1r8srujBEMd6i0awzlWKbgQJjvHP+s3h08rA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmvi7L19J0g3fn1C02zz/IbNGy1sPi
 1PYmJos3P84yWUydtJnd4u3eTnaLaXtnMFv8P/uB3YHD49WBVeweZ+/sYPT4umkTq8fxG9uZ
 Aliism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5Q
 UihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFugVJ+YWl+al6+WlllgZGhgYmQIV
 JmRnPLo0ibngI2fFlO8PmBoYOzi6GDk4JARMJHbcr+pi5OIQEtjBKLH1/n1WCOcTo8SZ/odM
 cM6Dh78Zuxg5wTp+vzzHDGILCexklDjZDdXxklHi14EmsCI2AT2J/4sWghWJCMRK9PzqZAGx
 mQXCJFZfvcEOYnMKmEu0POlmA7GFBXwkbj5fDGazCKhIrLl4kxXE5hWwlJj6fwIzxGIFiZ9P
 l7FCzBGRmN3ZBjXfSuL+5dfMIEdICNxjl7j59j4bRIOLxJMp66FsYYlXx7ewQ9hSEi/729gh
 GpoZJZYuOcgK4fQwSvxruA7VYSyxf+lkJlAoMQtoSqzfpQ+xmU/i3dceVkjg8Up0tAlBVKtI
 XHr9kglm/t0n/1khbA+JRf9XMkJCq4tRYt718gmM8rOQ/DALYcECRqZVjGKpBcW56anJhgWG
 8JhMzs/dxAhOflrGOxgvz/+nd4iRiYPxEKMEB7OSCG9EeEm6EG9KYmVValF+fFFpTmrxIUZT
 YEhOZJYSTc4Hpt+8knhDE0sDEzMjYxMLQzNDJXHeM1fKUoUE0hNLUrNTUwtSi2D6mDg4pRqY
 TOp/Pp5y5Q3fA+mFP+LulZ+352X8c3fSn2mO3IV1j2J3WNptufs5oHH1uUe1164kC+76ztHb
 zzLzE7eO0dsdDmuvxv1MnpyUca+c8+AbPnazPasn+7j5xZ54/O3jlh1SV8oeBM/J4qzZciTy
 tM8GnvVp4o3fFyzt5p1qc+KYKee359LBG6ZfemVXYTxFu/Th5cb7/Id+lqR/O9pZaxpyJlxa
 1yB01RytFUsl7V9xrmBoidwsIf1hp2R7X/WEJ9cj90WdP7x9quehhFXiW0L2meTxmokuynyz
 R/LgZe4JftO3PHzZ++dSRSKT8cODDF2tbhP/LcnX/fF0fgFLnuMunpn8ITMZa89/ezS1elnE
 9xIlluKMREMt5qLiRAAsCqFvBwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSvC7L19J0g6e7xCw2zz/IbNGy1sPi
 1PYmJos3P84yWUydtJnd4u3eTnaLaXtnMFv8P/uB3YHD49WBVeweZ+/sYPT4umkTq8fxG9uZ
 AliiuGxSUnMyy1KL9O0SuDIeXZrEXPCRs2LK9wdMDYwdHF2MnBwSAiYSv1+eY+5i5OIQEtjO
 KHH66QxmiISUxOenU9m6GDmAbGGJw4eLIWqeM0q0ds5kAalhE9CT+L9oIVi9iECixNU1r9lB
 bGaBKIkrHy9ADe1glHjU1AmW4BQwl2h50s0GYgsL+EjcfL4YzGYRUJFYc/EmK4jNK2ApMfX/
 BKgjFCR+Pl3GCjFURGJ2ZxvUMiuJ+5dfM09gFJiFJLWAkXEVo2hqQXFuem5ygaFecWJucWle
 ul5yfu4mRnDYagXtYFy2/q/eIUYmDsZDjBIczEoivBHhJelCvCmJlVWpRfnxRaU5qcWHGKU5
 WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFINTCkK+x/+3nW1u+vj5D3r9Zseb6g17v1vXtFz
 4IbfOYHVj/Pe5jF1xaR6vdr/bttKRbvjIvLHS7/sN6m9WC8WxzzL3GN9nZSInkjbx8fpc3tC
 ROQlBRP8LjjYnJteLjvhzI2/x3S5DUQzNxwUbRO/f8HkYsDtfwZHRf4vX+/3VTP5ZkPco5Nf
 JjK0tMYmiGZ2LZbRsN3tHtj721w6YPZVAZ2nNtfPz9y46/Oke/P3VjSV9+osUZ40a35Qdcgh
 Dc/5sTL19Z07v/W+fm+9NUNoWgNfkcKhq5Z7RAzOnQqXPvW9qlD8w6y8rrqzHQ+3zVjgv+bC
 a9si7v3T9r47fPvS+nM/FzldtUqoalqSGHjtoo4SS3FGoqEWc1FxIgDG/VusygIAAA==
X-CMS-MailID: 20250102020804epcas1p3bba76603de87d5eade74a89260588525
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241227173043epcas1p10efb00e43df7714896a35412df4c4ca1
References: <CGME20241227173043epcas1p10efb00e43df7714896a35412df4c4ca1@epcas1p1.samsung.com>
 <20241227173024.2346452-1-u-kumar1@ti.com>
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
> Sent: Saturday, December 28, 2024 2:30 AM
>
> Fix compatiable name for TPS65224 PMIC as defined in
> dts/upstream/Bindings/mfd/ti,tps6594.yaml bindings.
>
> Fixes: 1468fbba6d55("power: pmic: tps65941: Add TI TPS65224 PMIC")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
>  drivers/power/pmic/tps65941.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/pmic/tps65941.c b/drivers/power/pmic/tps65941.c
> index c3490db2a0..57d470521f 100644
> --- a/drivers/power/pmic/tps65941.c
> +++ b/drivers/power/pmic/tps65941.c
> @@ -74,7 +74,7 @@ static const struct udevice_id tps65941_ids[] = {
>  	{ .compatible = "ti,tps659412", .data = TPS659411 },
>  	{ .compatible = "ti,tps659413", .data = TPS659413 },
>  	{ .compatible = "ti,lp876441",  .data =  LP876441 },
> -	{ .compatible = "ti,tps65224",  .data =  TPS65224 },
> +	{ .compatible = "ti,tps65224-q1",  .data =  TPS65224 },
>  	{ .compatible = "ti,tps6594-q1", .data =  TPS659411 },
>  	{ .compatible = "ti,tps6593-q1", .data =  TPS659413 },
>  	{ .compatible = "ti,lp8764-q1",  .data =  LP876441 },
> --
> 2.34.1



