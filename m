Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78C3C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 23:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F1D988414;
	Wed, 17 Apr 2024 01:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="cH4hI1om";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A2D688414; Wed, 17 Apr 2024 01:34:30 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F55A88224
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240416233421epoutp047332da07f8e7eb35e05436cec654b7a6~G5smQdKM41219412194epoutp04I
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 23:34:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240416233421epoutp047332da07f8e7eb35e05436cec654b7a6~G5smQdKM41219412194epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713310461;
 bh=Q7U5IygNZBHJZiHxAUyCuGyZHbE54a503XUmBVHnxMM=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=cH4hI1omBhXdHu3hbSOjwGCR/b/j4nHONsJNTO9XONP4hp8x/+LNJrXJS9D3oYpVC
 s6fCe3V54iTk+ybdJIMwiH06YxvMwaQRk+NF42MfhD3wUoz3am9Q2iAlC6INbUwOGR
 trj+D5nUL77+LhhvqqC/K4ki8pXogHy2Kk6j2KKc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240416233420epcas1p1defff7303db6764c0c74a78592342fd2~G5sleuMlV0258902589epcas1p1b;
 Tue, 16 Apr 2024 23:34:20 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.145]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4VK0k36WLSz4x9Pp; Tue, 16 Apr
 2024 23:34:19 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 85.28.19431.BFA0F166; Wed, 17 Apr 2024 08:34:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240416233419epcas1p2fa5e38c121b3169f4be95ed93036fdd7~G5skU2tqV1913019130epcas1p2Q;
 Tue, 16 Apr 2024 23:34:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240416233419epsmtrp10a13cb84638000541c70842e637ce940~G5skUR0Ma1813218132epsmtrp1W;
 Tue, 16 Apr 2024 23:34:19 +0000 (GMT)
X-AuditID: b6c32a4c-485ff70000004be7-a1-661f0afb57f6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 75.9D.08390.BFA0F166; Wed, 17 Apr 2024 08:34:19 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240416233419epsmtip211fc05db98d3fa115d516e91ef9ed001~G5skIkIBX3116231162epsmtip2T;
 Tue, 16 Apr 2024 23:34:19 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Jonas Karlman'" <jonas@kwiboo.se>, "'Peng Fan'" <peng.fan@nxp.com>,
 "'Tom	Rini'" <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <20240408210619.3749231-2-jonas@kwiboo.se>
Subject: RE: [PATCH 2/2] mmc: Add support for the no-mmc-hs400 prop
Date: Wed, 17 Apr 2024 08:34:19 +0900
Message-ID: <000a01da9056$9a770710$cf651530$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH4WoF6XMPcZuGkh8wOOqd8YokilwJuexB5AeO6+ZaxDWZdkA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTV/c3l3yawaK/xhYn31xlsfix6gur
 xdRJm9kt3u7tZHdg8Xh1YBW7x4kJl5g8zt7Zweix8d0OpgCWqGybjNTElNQihdS85PyUzLx0
 WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCdSgpliTmlQKGAxOJiJX07m6L80pJU
 hYz84hJbpdSClJwC0wK94sTc4tK8dL281BIrQwMDI1OgwoTsjJOrGxgLDnFXPF66l7mB8TBn
 FyMnh4SAicTkvWfZuhi5OIQE9jBKXD/7CMr5xChx/NIhdgjnG6PEvzmvWWFaZrcfY4VI7GWU
 WNHXxQThvGSUOHr4CQtIFZuAnsT/RQuZuxg5OEQEciVu7vMGCTMLSEk0ndzFCGJzCphLTPr8
 C2yosICzRN+vHnYQm0VAVWL73xtgNq+ApcTflpNQtqDEyZkQ45kF5CW2v53DDHGQgsTPp8tY
 IVY5STx+bwJRIiIxu7MNquQnu8TNiRIQtovE9+V3WCBsYYlXx7ewQ9hSEi/728AelhBoZpRY
 uuQgK4TTA/R9w3U2iCpjif1LJzOBLGMW0JRYv0sfYhmfxLuvPWA3SAjwSnS0CUFUq0hcev2S
 CWb+3Sf/oWHoIXHmzQW2CYyKs5B8NgvJZ7OQvDALYdkCRpZVjFKpBcW56anJhgWGunmp5fAI
 T87P3cQITpJaPjsYv6//q3eIkYmD8RCjBAezkghvi7BsmhBvSmJlVWpRfnxRaU5q8SFGU2B4
 T2SWEk3OB6bpvJJ4QxNLAxMzI2MTC0MzQyVx3jNXylKFBNITS1KzU1MLUotg+pg4OKUamDYw
 G7m91JW7xh7MwWrp9pJjDXtgqCv3th6tb59WeBdfeb43179j6kRLKQXNvv76gNPa++9/sX76
 2GKGOG+UurVqcpR6QNUDnwPWx+4V6XgoiHIxvVt7d0XcaavSzo+B3bwfTh6vCRGaWn7/kLS2
 0BaFvRzvGK6vPtZ53HuCnsFxJ6OII0FKC4sfZbWohGxxuHzVWTQm8otfkcWZTXdWl92Y8Lag
 7H/4Fa2HmZdqXGYqL9Wc9q8/0NbsVOq8tVrBuSYmFj5Hbi6/fILl3jzT1S9u8jzrXDjJ6c1E
 XUWT2zkTb8ZdubVyRgKDhnfALp29dvrnbh4yz3i2pH3b3fPhN/8H/HT+rL3mWm/+j9s/lJRY
 ijMSDbWYi4oTAV9dc+YbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvO5vLvk0gynXZCxOvrnKYvFj1RdW
 i6mTNrNbvN3bye7A4vHqwCp2jxMTLjF5nL2zg9Fj47sdTAEsUVw2Kak5mWWpRfp2CVwZJ1c3
 MBYc4q54vHQvcwPjYc4uRk4OCQETidntx1i7GLk4hAR2M0pc+fSEHSIhJfH56VS2LkYOIFtY
 4vDhYoia54wSl0+/YQGpYRPQk/i/aCEziC0ikC9xZ8YesF5moN6mk7sYIRo2M0pceLaICSTB
 KWAuMenzL1YQW1jAWaLvVw9YA4uAqsT2vzfAbF4BS4m/LSehbEGJkzOfsEAM1ZZ4evMplC0v
 sf3tHGaIQxUkfj5dxgpyqIiAk8Tj9yYQJSISszvbmCcwCs9CMmkWkkmzkEyahaRlASPLKkbJ
 1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4DjR0trBuGfVB71DjEwcjIcYJTiYlUR4W4Rl
 04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzfnvdmyIkkJ5YkpqdmlqQWgSTZeLglGpg6t/n21u4
 +gFr+R+BrIM5B11W5Oe7rFNa5bPhYnxrjd+FQhuvA0t6VE6EV5Wpp++MrhA69nXnZ99bUuyF
 kWk//txNnPb0Q92fxxN13GSaDFJMRS33hRxd+fscr81a7wMfYk5GSm3X2vhpUQR7ZdncVf9F
 1kwOvdt2l+GWp6u+yO4Yv2Z+X7e2X32fZGs3FOm9WOy868a2FJ17TEu/unzl0Kl6LmfEsfNa
 HJuLUyaT3w455aa1b9XyV7r+6in7eu7IpVrew7m600LFmA9OXFk86+uW1tRXFTLpFgVBF9hE
 yrb23v38KVVoS//Pj5Orrv86YfuLvax+jm6DzLwpTM5VghueVZnMKxWd7bpisTCzEktxRqKh
 FnNRcSIAXVirKgIDAAA=
X-CMS-MailID: 20240416233419epcas1p2fa5e38c121b3169f4be95ed93036fdd7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240408210639epcas1p1913a0694e543b863110cfcb62c1237dc
References: <20240408210619.3749231-1-jonas@kwiboo.se>
 <CGME20240408210639epcas1p1913a0694e543b863110cfcb62c1237dc@epcas1p1.samsung.com>
 <20240408210619.3749231-2-jonas@kwiboo.se>
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

Hi

> -----Original Message-----
> From: Jonas Karlman <jonas@kwiboo.se>
> Sent: Tuesday, April 9, 2024 6:06 AM
> To: Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>; u-boot@lists.denx.de
> Subject: [PATCH 2/2] mmc: Add support for the no-mmc-hs400 prop
> 
> The linux commit f722e650d965 ("mmc: core: add support for disabling
> HS400 mode via DT") added support for a no-mmc-hs400 prop.
> 
> Add support for the no-mmc-hs400 prop to disable HS400 host caps.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/mmc-uclass.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index 1349da72b102..1b454e8ec758 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -256,6 +256,9 @@ int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg)
>  		cfg->host_caps |= MMC_CAP(MMC_HS_400) | MMC_CAP(MMC_HS_200);
>  	if (dev_read_bool(dev, "mmc-hs400-enhanced-strobe"))
>  		cfg->host_caps |= MMC_CAP(MMC_HS_400_ES);
> +	if (dev_read_bool(dev, "no-mmc-hs400"))
> +		cfg->host_caps &= ~(MMC_CAP(MMC_HS_400) |
> +				    MMC_CAP(MMC_HS_400_ES));
> 
>  	if (dev_read_bool(dev, "non-removable")) {
>  		cfg->host_caps |= MMC_CAP_NONREMOVABLE;
> --
> 2.43.2


