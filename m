Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDF4C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 00:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4671388514;
	Thu, 18 Apr 2024 02:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="t91+06MS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F288A88508; Thu, 18 Apr 2024 02:12:25 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B4568850D
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 02:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240418001215epoutp037f1f717ade05391697c6408ae64efd3a~HN2_ZZKPL0828408284epoutp03z
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 00:12:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240418001215epoutp037f1f717ade05391697c6408ae64efd3a~HN2_ZZKPL0828408284epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713399135;
 bh=gnlHKtrOmnUsuzOyNYEq7ufbhlnQ2+rfiC7vEqFKp/g=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=t91+06MS8v0txsTIguoaaJYqpcRUMdUSdNWwz/veP6r2aSAxG+Q0Ru1fWOQY1Vrih
 5RAhsI0lyAzIauZL4ZN8fzo7XLdxZk+qgT8MU6oJoXrzhRMbkLhpA7muodA39A9c8+
 McHejtpPf0wnSpkgwuibxoL3LZ3o4+MusTKFGqP4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240418001215epcas1p3f1244ee675d814cb0cb1b8fb40bec79d~HN298_Mjp2926529265epcas1p3r;
 Thu, 18 Apr 2024 00:12:15 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.145]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4VKdWK6DPrz4x9QB; Thu, 18 Apr
 2024 00:12:13 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 09.B4.10158.D5560266; Thu, 18 Apr 2024 09:12:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240418001213epcas1p394d571face6ac24de99a5bc556f2cac5~HN28XPD3J2926529265epcas1p3Y;
 Thu, 18 Apr 2024 00:12:13 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240418001213epsmtrp1dbfaa5d80906c04790e9942e89b22ce9~HN28WLkkC0689406894epsmtrp1F;
 Thu, 18 Apr 2024 00:12:13 +0000 (GMT)
X-AuditID: b6c32a38-8e1ff700000027ae-ff-6620655dc6cb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 94.80.08390.D5560266; Thu, 18 Apr 2024 09:12:13 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240418001213epsmtip143e46ae513eb5ed61541e0868dcdd432~HN28KJAvP2505925059epsmtip1i;
 Thu, 18 Apr 2024 00:12:13 +0000 (GMT)
Message-ID: <2da5ec7c-90c8-4350-8ccf-cf1f282c5971@samsung.com>
Date: Thu, 18 Apr 2024 09:12:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 2/5] power: pmic: tps65941: Add TI TPS65224 PMIC
To: Bhargav Raviprakash <bhargav.r@ltts.com>, u-boot@lists.denx.de
Cc: d-gole@ti.com, dan.carpenter@linaro.org, m.nirmaladevi@ltts.com,
 sjg@chromium.org, trini@konsulko.com
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240318094925.374959-3-bhargav.r@ltts.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmnm5sqkKawaRXhhab5x9ktmhZ62Hx
 YV4ru8XH7e/ZLb5t2cZoMXXSZnaLt3s72R3YPWY3XGTxeHVgFbvHnWt72DzO3tnB6PF10yZW
 j+M3tjMFsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
 ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAt0CtOzC0uzUvXy0stsTI0
 MDAyBSpMyM548KuVtWAle8X0Z7PZGhh/snYxcnJICJhIbO64DmRzcQgJ7GCUuHRnBxuE84lR
 4t2JdSwgVUIC3xglNt1Ih+mYOWM7I0TRXkaJ10c2s0IUvWeUeL8yC8TmFbCTOHGhkRHEZhFQ
 lfg2aTEbRFxQ4uTMJ2BDRQXkJe7fmsEOYgsLBEjsuXQbrF5EwEni68lWsDizQLbExPm3mSBs
 cYlbT+aD2WwCOhLbvx0HszkFLCX6+vcwQtTIS2x/O4cZ4tCJHBIL5yl3MXIA2S4Si16mQYSF
 JV4d38IOYUtJvOxvYwf5RUKgmVFi6ZKDrBBOD6PEv4brbBBVxhL7l05mAhnELKApsX6XPsQu
 Pol3X3tYIebzSnS0CUFUq0hcev2SCWb+3Sf/oSHtIdH9Zi803HYzSly9fZJ5AqPCLKRgmYXk
 zVlI3pmFsHkBI8sqRrHUguLc9NRiwwITeGQn5+duYgQnUy2LHYxz337QO8TIxMF4iFGCg1lJ
 hLdFWDZNiDclsbIqtSg/vqg0J7X4EKMpMHImMkuJJucD03leSbyhiaWBiZmRsYmFoZmhkjjv
 mStlqUIC6YklqdmpqQWpRTB9TBycUg1M6eKzryxqqThxNlS2WvxtReLS/wG8apvn8VzXizAS
 Xi3wwdUv3zhE8+D9mfb9HFe/6C5y5p19zMYrdb++ry4rX3m1Y96Ly+f8jZdOEZs8wfcTX+tk
 qeO7zNdcvjr/0cGz0pIKHGe+R3xdfuJTwrkp0rUPWyzPyWrKVH+f49Y3a8MbAZV8rYeaj866
 3TtR+Ejpel37yUMbTSd//9VxJH1z4DVZcZk/6bUCD4ulWzpcdHe/uL9C6KOtnuRxiX3azvzP
 J9zu+OOjudFk9q1yLdZr8/60BWcVGZ/iXjV/7uma5avdeXmO7o3f7614+WzhkslHm20uHk56
 +mDVX3emY2+EJi6InTqXtya7RpBDvVdzoRJLcUaioRZzUXEiAKkjJL8vBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnG5sqkKawc1bkhab5x9ktmhZ62Hx
 YV4ru8XH7e/ZLb5t2cZoMXXSZnaLt3s72R3YPWY3XGTxeHVgFbvHnWt72DzO3tnB6PF10yZW
 j+M3tjMFsEVx2aSk5mSWpRbp2yVwZTz41cpasJK9Yvqz2WwNjD9Zuxg5OSQETCRmztjO2MXI
 xSEksJtRYtHlpVAJKYnPT6eydTFyANnCEocPF0PUvGWUeLB1BTNIDa+AncSJC42MIDaLgKrE
 t0mL2SDighInZz5hAbFFBeQl7t+awQ5iCwv4SazcsxPMFhFwkvh6spUdZD6zQLbEpeZEkLCQ
 QLrEkVnvwFqZBcQlbj2ZzwRiswnoSGz/dhzM5hSwlOjr38MI0aousX6eEES5vMT2t3OYJzAK
 zUJyxCwkk2YhdMxC0rGAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZw5Ghp7WDc
 s+qD3iFGJg7GQ4wSHMxKIrwtwrJpQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NAXonsSQ1
 OzW1ILUIJsvEwSnVwLRUYa9HyscjVbNuv4zLtwvSOSPCIH5m8WLWd4skk61LPnuueaw3d6mt
 iI3W5nyJaoasX3eaJ5h5yKZMnbRDYOPH5KsWh75/POwSrqWgO+H/6ma1rxrpsfbFd7w27+Uz
 WLhsnW2eAKNjwVlRZ01BRRcFsQNOv1fYa155+n7G1ZM7kuTunDdd9jlr1cGN/PsTpqX1yc8x
 9P7LFyfX3iIgN8WZy+qayjapNafOJnR0xPe+KHDttzut/GBx6Lv3B+Yw1l946ZGbsdCxQXb7
 /CQVi9/W9xn4dE++cPFTS+vVrdMW0+Wo//HdbN7TXWzVz7r5ONNXLO0r22FgdlrC/ODeR4r/
 VlwxO3XiTvGZy0p6f5VYijMSDbWYi4oTAT51owULAwAA
X-CMS-MailID: 20240418001213epcas1p394d571face6ac24de99a5bc556f2cac5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240418001213epcas1p394d571face6ac24de99a5bc556f2cac5
References: <20240318094925.374959-1-bhargav.r@ltts.com>
 <20240318094925.374959-3-bhargav.r@ltts.com>
 <CGME20240418001213epcas1p394d571face6ac24de99a5bc556f2cac5@epcas1p3.samsung.com>
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

On 3/18/24 18:49, Bhargav Raviprakash wrote:
> Adds compatible and data field values of TPS65224 driver in
> TPS65941 PMIC driver.
> 
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/pmic/tps65941.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/pmic/tps65941.c b/drivers/power/pmic/tps65941.c
> index 727b42747a..ef63eb733a 100644
> --- a/drivers/power/pmic/tps65941.c
> +++ b/drivers/power/pmic/tps65941.c
> @@ -75,6 +75,7 @@ static const struct udevice_id tps65941_ids[] = {
>  	{ .compatible = "ti,tps659412", .data = TPS659411 },
>  	{ .compatible = "ti,tps659413", .data = TPS659413 },
>  	{ .compatible = "ti,lp876441",  .data =  LP876441 },
> +	{ .compatible = "ti,tps65224",  .data =  TPS65224 },
>  	{ }
>  };
>  

