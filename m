Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D484C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D2B87AC6;
	Tue, 31 Oct 2023 06:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="P/2abuOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2784F87AC7; Tue, 31 Oct 2023 06:04:40 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A168709A
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231031050435epoutp0493a8a93cfcc66256be4b6a5f3474145c~TGLr3RxZe1306513065epoutp04k
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 05:04:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231031050435epoutp0493a8a93cfcc66256be4b6a5f3474145c~TGLr3RxZe1306513065epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698728675;
 bh=5Ort7Hs+ReRiDId0fxnvxu+ctqjaDmF43bU5aQ/8s04=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=P/2abuOwgAZySDudIyWsrj6I2fxMqdi3T7EX9EnTnSaTl1PChE0nNfIk67w2MY8iC
 07s8JizWqbQwpzt7AQ0vjhgqA6VLNuBtOAEDyDnrosPDNVtc/qt8NC18Z55pPdPYpa
 GItjkq/ttjHEJASdY0hPNCiK1834IZw4ThrjjvrY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231031050435epcas1p2554470fe6729003b6e9ebe5f7c97c51d~TGLrnuLQ30489904899epcas1p2x;
 Tue, 31 Oct 2023 05:04:35 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.236]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SKJ355xX7z4x9QF; Tue, 31 Oct
 2023 05:04:33 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 29.B0.19104.EDA80456; Tue, 31 Oct 2023 14:04:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20231031050430epcas1p2ce44601cc5a47f0a768ebbfd837798a6~TGLmy5pTv0302203022epcas1p2h;
 Tue, 31 Oct 2023 05:04:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031050430epsmtrp134e5336257d451ce5d7ff583e20c06d4~TGLmyQHf72498724987epsmtrp1F;
 Tue, 31 Oct 2023 05:04:30 +0000 (GMT)
X-AuditID: b6c32a4c-559ff70000004aa0-ef-65408ade7a7c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 6F.88.08817.EDA80456; Tue, 31 Oct 2023 14:04:30 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031050429epsmtip1f981ed40c0d1907108c3b6d3fdeb4b8e~TGLmQHUbG3141331413epsmtip1k;
 Tue, 31 Oct 2023 05:04:29 +0000 (GMT)
Message-ID: <2380e0c0-677e-4b78-82b4-c72d327677d2@samsung.com>
Date: Tue, 31 Oct 2023 14:04:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: mmc: Resolve emmc not load image after switched hw
 partition
Content-Language: en-US
To: Kuan Lim Lee <kuanlim.lee@starfivetech.com>, u-boot@lists.denx.de
Cc: cheehong.ang@starfivetech.com, weiliang.lim@starfivetech.com
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20231003041720.893-1-kuanlim.lee@starfivetech.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmge69LodUg4W3VS329nQyW3Rtes9k
 8XZvJ7vF+z2z2R1YPM7e2cHocfssbwBTVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
 oaWFuZJCXmJuqq2Si0+ArltmDtAiJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
 aYFecWJucWleul5eaomVoYGBkSlQYUJ2xpTGBtaCR+wVe//OZG5gXMbWxcjJISFgIvH+xjqW
 LkYuDiGBPYwS9/dOZQVJCAl8YpT4fdUewv7GKLFhBitMw88ZR9ghGvYySixpvsUGUfSeUWLH
 NFkQm1fATuLcrE6wOIuAqsS9a+/YIOKCEidnPmEBsUUF5CXu35rBDmILC0RITNx9FmwBs4C4
 xK0n85lAbBEBV4kZBxuYIOIOErsvrAXrZRPQkdj+7ThYnBMovmvuLWaIGnmJ7W/nMIMcJyHw
 iF3i2IZ/jBBXu0js7zvCDmELS7w6vgXKlpJ42d/GDtHQzCixdMlBVginh1HiX8N1aCAZS+xf
 OhloHQfQCk2J9bv0IcKKEjt/z2WE2Mwn8e5rDytIiYQAr0RHmxBEiYrEpdcvmWB23X3yHxqK
 HhLv5/xjncCoOAspXGYh+X8Wkn9mISxewMiyilEqtaA4Nz012bDAUDcvtRwe4cn5uZsYwelQ
 y2cH4/f1f/UOMTJxMB5ilOBgVhLhPWzqkCrEm5JYWZValB9fVJqTWnyI0RQYQxOZpUST84EJ
 Oa8k3tDE0sDEzMjYxMLQzFBJnDfmU3uKkEB6YklqdmpqQWoRTB8TB6dUA1PZrnKpUPn4mfbn
 Ut4JTr6waxpvzE4DWaMFP39L71q+bmHdJX8Naf19RoKSEzZVt2++PmuH8eJ5aifi/6r9vicR
 uji+tI8hIqA8YO6ymXbbLl5JZK4X5j+c0x7bvYCdqV73toD6Y33pF6cu7XnBnrLwVp72M2HP
 PU8s3n02dTK7om99acVd85YnE+ZYTJkwkXuO0ffHV/JKSv/vPa8ecqR1ZqfxabOC+xeufSyb
 8cXZo/H5zCWP9bkfx3dxS7XMOJN1e+lMFXeLuJ0ri2rYlx7dW871leHdFk2XmX+FdCuWTH/M
 1smw13jR3D9Mky7srOV8bPYs02NDnPbhab0rNbh/fEsy68tuVnpfc+QSU/FWJZbijERDLeai
 4kQAL22aQxAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSnO69LodUgy//eC329nQyW3Rtes9k
 8XZvJ7vF+z2z2R1YPM7e2cHocfssbwBTFJdNSmpOZllqkb5dAlfGlMYG1oJH7BV7/85kbmBc
 xtbFyMkhIWAi8XPGEfYuRi4OIYHdjBIHXm5lhUhISXx+OhWoiAPIFpY4fLgYouYto8S1DU/A
 angF7CTOzeoEG8QioCpx79o7Noi4oMTJmU9YQGxRAXmJ+7dmsIPYwgIREhN3nwXrZRYQl7j1
 ZD4TiC0i4Cox42ADE0TcQWL3hbVgvUIC9hKvT/0D62UT0JHY/u04WA0nUM2uubeYQW5jFlCX
 WD9PCKJVXmL72znMExiFZiG5YhaSbbMQOmYh6VjAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0
 L10vOT93EyM46LW0djDuWfVB7xAjEwfjIUYJDmYlEd7Dpg6pQrwpiZVVqUX58UWlOanFhxil
 OViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTCpBVRxfmRi/fjV03qB7OMTe5Uaju8o+WjB
 cfnqDfsWpZDtJ6d0P5t21tTp5zLb9llWLMK7PhwV2JhiGah3o//5jXOzwh+u/Hbjybl6g7i5
 7Ut10769vFant3ZBau6BQ3rMS9sat763t+s4z1z8+85eQ6OMtITE3Qee5FbL3H4/y+P+m2c1
 zEvaduzbVbLl3Fo78W+Mpgx9Occ1y4MOTlR76D9RqOhGy+8f+5e2fAr3dN9TWXB7wqTPp6It
 zyw/wjD/93Md7nkvqu6cP/3v4pFiLqX0S+r1FR4WR+2PBlSduulntTRkUZD95T236xuvT7z+
 IjyltjZeZJ3tFBPeP4s/vJgws+/ki6+vX/cllD5Y9lSJpTgj0VCLuag4EQBmnoZf6QIAAA==
X-CMS-MailID: 20231031050430epcas1p2ce44601cc5a47f0a768ebbfd837798a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031050430epcas1p2ce44601cc5a47f0a768ebbfd837798a6
References: <20231003041720.893-1-kuanlim.lee@starfivetech.com>
 <CGME20231031050430epcas1p2ce44601cc5a47f0a768ebbfd837798a6@epcas1p2.samsung.com>
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

On 10/3/23 13:16, Kuan Lim Lee wrote:
> When selecting MMCSD_MODE_EMMCBOOT as boot_mode, emmc do not load U-boot 
> proper image after switched hardware partition.
> 
> Signed-off-by: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
> Reviewed-by: Chee Hong Ang <cheehong.ang@starfivetech.com>
> Reviewed-by: Wei Liang Lim <weiliang.lim@starfivetech.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  common/spl/spl_mmc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 20f687e138..dc8a45222b 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -447,6 +447,9 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>  #endif
>  			return err;
>  		}
> +		err = mmc_load_image_raw_sector(spl_image, bootdev, mmc, 0);
> +		if (!err)
> +			return err;
>  		/* Fall through */
>  	case MMCSD_MODE_RAW:
>  		debug("spl: mmc boot mode: raw\n");

