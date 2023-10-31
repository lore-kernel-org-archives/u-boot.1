Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F73C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF7587ABF;
	Tue, 31 Oct 2023 07:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="mB1DrsCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C8AB87AC6; Tue, 31 Oct 2023 07:09:10 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCDDD86EE5
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231031060903epoutp01d729ee90fa4aaee458ea0b2f177df565~THD_Qy3Vg2343523435epoutp01T
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:09:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231031060903epoutp01d729ee90fa4aaee458ea0b2f177df565~THD_Qy3Vg2343523435epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698732543;
 bh=jr+2WnwQ+96sEg8Y5AUyyRg1hxY/0s2DZU6MvLxPlUs=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=mB1DrsCFSSs+r8F89CvUj2RYD6sKPvtRGsiZLQ7fnWvVuNC4aOJnyW+BkwcPBrEoQ
 wXHevI6nkCr9WNJsNj9kh01WJmIyE6WyQTjSGzd2PH4/ldbD4UsYnai+uy4mX6rylC
 vaa7YJsGZW5bCaeJTUB3EypDG4oGNyp/1PCmJj6k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20231031060903epcas1p46cc87efe08cefe89b2e2ce4047929ab0~THD_GIE1E0368803688epcas1p4O;
 Tue, 31 Oct 2023 06:09:03 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.231]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SKKTV30VZz4x9Q2; Tue, 31 Oct
 2023 06:09:02 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 1C.57.19104.DF990456; Tue, 31 Oct 2023 15:09:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20231031060900epcas1p166ee69d14c52c948df7a9e8c298be45b~THD7nRuM31267712677epcas1p1z;
 Tue, 31 Oct 2023 06:09:00 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031060900epsmtrp1e8c6d3d3ef76f349e94317f085af14c9~THD7mJbKH2873228732epsmtrp1L;
 Tue, 31 Oct 2023 06:09:00 +0000 (GMT)
X-AuditID: b6c32a4c-e146fa8000004aa0-2d-654099fdfee7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 D0.BB.18939.CF990456; Tue, 31 Oct 2023 15:09:00 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20231031060900epsmtip2aaddde4d7fcb9cd315824a6db39775a1~THD7Ya6KV2111521115epsmtip2T;
 Tue, 31 Oct 2023 06:09:00 +0000 (GMT)
Message-ID: <4b928129-d4d8-4cda-a5e3-7bf97547f366@samsung.com>
Date: Tue, 31 Oct 2023 15:09:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: pci: Drop the superfluous cast
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20231011110052.2958231-1-bmeng@tinylab.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTV/fvTIdUg20XuSzOT5zOavFj1RdW
 i7d7O9kdmD3O3tnB6LHx3Q4mjz29p1kDmKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
 dQ0tLcyVFPISc1NtlVx8AnTdMnOANikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
 CkwL9IoTc4tL89L18lJLrAwNDIxMgQoTsjN2v+hiLnjJUdHSuoWpgXEGexcjJ4eEgInEmcVL
 mLoYuTiEBPYwSuz6dZwVwvnEKDF91zN2OGf31emMMC039i9kgUjsZJS4seItI4TznlGi6c51
 sCpeATuJKTOOM4PYLAKqEsd/LWWDiAtKnJz5hAXEFhWQl7h/C+IQYQELiSVnP7GC2MwC4hK3
 nsxnArFFBGwl/s9bxQQRl5BYcug+WA2bgI7E9m/HweKcApYSk5+dY4eokZfY/nYOM8hBEgK3
 2CWmPXrECnG2i8SzzqssELawxKvjW6AhICXxsr+NHaKhmVFi6ZKDrBBOD6PEv4brbBBVxhL7
 l04GWscBtEJTYv0ufYiwosTO33MZITbzSbz72sMKUiIhwCvR0SYEUaIicen1SyaYXXef/Icq
 8ZA4/5x1AqPiLKRgmYXk/VlI3pmFsHcBI8sqRqnUguLc9NRkwwJD3bzUcniUJ+fnbmIEJ0Ut
 nx2M39f/1TvEyMTBeIhRgoNZSYT3sKlDqhBvSmJlVWpRfnxRaU5q8SFGU2AETWSWEk3OB6bl
 vJJ4QxNLAxMzI2MTC0MzQyVx3phP7SlCAumJJanZqakFqUUwfUwcnFINTLn/t34R6J2qP+01
 7zYrvac3T2W+95E1LfE6flZhonHAWpZ7oWsmXN16wb8+Z6dYI5eeVNnjJf2PW48c5/G9vXmv
 YuW/9OjT5V8nn1NO5V+cb7vGuFv41JQ9YjzB6rOT5k9Wm8FVnHe/hr3c4N7/eTObdhUrP96Z
 1j+nUSbN9PwvnTvdmT6Hbsqu3teVwV/9ffvrlS525ownXE/Wptz8dWH5x8ufV/+MOnHlktWN
 y82m7K/PiRTlcv04q3/koPC5aN8rZYrvBa07lJPq+3+8vLpb97VYhNklRsuzbNnMf///z51c
 cKTz4Kkr05lEd+Vtrq0MXyN+/mZbweSZ01g9+v6cCOy/62aw++Zyjb0T/SWUWIozEg21mIuK
 EwEeFQRGEwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSvO6fmQ6pBr23jCzOT5zOavFj1RdW
 i7d7O9kdmD3O3tnB6LHx3Q4mjz29p1kDmKO4bFJSczLLUov07RK4Mna/6GIueMlR0dK6hamB
 cQZ7FyMnh4SAicSN/QtZuhi5OIQEtjNKPLn2hwUiISXx+elUti5GDiBbWOLw4WKImreMEs8X
 3QKr4RWwk5gy4zgziM0ioCpx/NdSNoi4oMTJmU/AakQF5CXu34JYJixgIbHk7CdWEJtZQFzi
 1pP5TCC2iICtxP95q5gg4hISSw7dB6sRAqp/suQ2WC+bgI7E9m/HwWo4BSwlJj87xw5yG7OA
 usT6eUIQrfIS29/OYZ7AKDQLyRWzkGybhdAxC0nHAkaWVYyiqQXFuem5yQWGesWJucWleel6
 yfm5mxjB4a4VtINx2fq/eocYmTgYDzFKcDArifAeNnVIFeJNSaysSi3Kjy8qzUktPsQozcGi
 JM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamCKnagofThij6HJl7NL72rdmxD2Y3FQpWr3ZBGR
 rZwcN8omaMyasrxYaU9z09rpH0x0ry002t58494T9/lF6dpn2v2PJC94fu3nShvlyw1XGuLO
 73LgWPBjb8USCb2PLxgPnevm1VjfLcIkYxm3+IXKsXlrE189Uc65VnlvQtuP50x3rVmnNBW9
 P6nw5Xz+puyNQmHBIbFmvrNT7sX3bn/bG8jn42Z5a3XJuo3sibFK5f+9TA+ay7A7bKx0YvKU
 v3BscaB6e9hyeQ19A+b5ikc0AhfcPmS78WxQQFYpM/PqDB25d0d4RA4+m3DNS0n4+dmbeS++
 mymsmnbsvJXlwo6MBxtFvRSjUqVO9mqs3bVaiaU4I9FQi7moOBEA/D4NbeYCAAA=
X-CMS-MailID: 20231031060900epcas1p166ee69d14c52c948df7a9e8c298be45b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031060900epcas1p166ee69d14c52c948df7a9e8c298be45b
References: <20231011110052.2958231-1-bmeng@tinylab.org>
 <CGME20231031060900epcas1p166ee69d14c52c948df7a9e8c298be45b@epcas1p1.samsung.com>
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

On 10/11/23 20:00, Bin Meng wrote:
> dm_pci_map_bar() return a value of (void *) already, hence no need
> to cast it again before assigning to host->ioaddr.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> 
>  drivers/mmc/pci_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/pci_mmc.c b/drivers/mmc/pci_mmc.c
> index 9fb7044029..4d163ccba0 100644
> --- a/drivers/mmc/pci_mmc.c
> +++ b/drivers/mmc/pci_mmc.c
> @@ -50,8 +50,8 @@ static int pci_mmc_probe(struct udevice *dev)
>  	desc = mmc_get_blk_desc(&plat->mmc);
>  	desc->removable = !(plat->cfg.host_caps & MMC_CAP_NONREMOVABLE);
>  
> -	host->ioaddr = (void *)dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0, PCI_REGION_TYPE,
> -					      PCI_REGION_MEM);
> +	host->ioaddr = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0,
> +				      PCI_REGION_TYPE, PCI_REGION_MEM);
>  	host->name = dev->name;
>  	host->cd_gpio = priv->cd_gpio;
>  	host->mmc = &plat->mmc;

