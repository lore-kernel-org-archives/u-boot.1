Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6393D0BB4F
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 03:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B1E88E77;
	Thu, 24 Oct 2024 05:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="L3WrdGS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0418E88C7B; Thu, 24 Oct 2024 05:14:52 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 990B588E77
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 05:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241024031433epoutp04d465cb524f36706db2cfd51111d60b1f~BRRGPfaLb0702207022epoutp04Z
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 03:14:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241024031433epoutp04d465cb524f36706db2cfd51111d60b1f~BRRGPfaLb0702207022epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1729739673;
 bh=4A7t4wY4g8JdHoX+mOqquSVaVL9KhycL8z1IonG2Phc=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=L3WrdGS16ISqt7SYNdq8AiHkBQ3OfEq/k6BGyk+nRRc+2nZc5u/W//kJbJL+mf9Y4
 W/adqP+Ph1RUcOl7GsD7jnhNcxedv2jYGb1BBZSayyi6mPsZyMf7idSye9zH46t99w
 lEGEvZY5IlVckqjjhMmFiFmAY01ocD96B4S/ZWEY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241024031433epcas1p29f3c2ec762dcf9d0fb280bd09611f8e5~BRRF-9BE71961619616epcas1p2K;
 Thu, 24 Oct 2024 03:14:33 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.134]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4XYrcR5KBtz4x9Q1; Thu, 24 Oct
 2024 03:14:31 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 3D.4A.09951.79BB9176; Thu, 24 Oct 2024 12:14:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241024031431epcas1p2b3b5e06f95768605dae1ea5eacaefe61~BRREQdjl40949509495epcas1p2Y;
 Thu, 24 Oct 2024 03:14:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241024031431epsmtrp1cdcf13a1e18e2038f0b2ac31bf6c0a42~BRREPvqsd2747327473epsmtrp1J;
 Thu, 24 Oct 2024 03:14:31 +0000 (GMT)
X-AuditID: b6c32a38-b3fff700000026df-d3-6719bb974bb9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 26.80.08229.79BB9176; Thu, 24 Oct 2024 12:14:31 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241024031431epsmtip1f88613f8317bc08bcb95475d1c4ede41~BRREDWXur1889118891epsmtip11;
 Thu, 24 Oct 2024 03:14:31 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Tim Harvey'" <tharvey@gateworks.com>, "'Heiko Schocher'" <hs@denx.de>,
 "'Tom Rini'" <trini@konsulko.com>, "'Peng Fan'" <peng.fan@nxp.com>,
 <u-boot@lists.denx.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20241023202855.1571188-2-tharvey@gateworks.com>
Subject: RE: [PATCH 2/4] imx: power-domain: Convert to use livetree API for
 fdt access
Date: Thu, 24 Oct 2024 12:14:31 +0900
Message-ID: <0c5801db25c2$d7d2c840$877858c0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQI9tlBLkulT+iAYa8f+rqP6Oy1iRAKQ6qIIAYd1P1exr1XwAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmru703ZLpBvOPaVrsuHOf2eLyrjls
 Fj9WfWG1uHjiE7PF1Emb2S3e7u1kd2DzmDfrBIvHuZ67bB6vDqxi9zh7Zwejx8Z3O5g8Pm+S
 C2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpD
 SaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWqBXnJhbXJqXrpeXWmJlaGBgZApU
 mJCd8fjZQ6aCM2IVMz7sYG1gPCbUxcjJISFgInHn/XzWLkYuDiGBHYwS/2etZ4RwPjFKHJ/f
 yQZSJSTwjVHi67tamI5rr/+yQxTtZZQ4unghG4TzklHi0rfDYB1sAnoS/xctZAZJiAisZpRY
 +XgS0BIODmYBJYmrp+RAajgFbCXOfZ7LBGILC0RIvGiawgxiswioShw5OI8FxOYVsJRofXaT
 EWKzgsTPp8tYQWxmARGJ2Z1tzCAjRQScJBpmloKskhB4yS7x+cw1qHoXidYzS9ghbGGJV8e3
 QNlSEi/729ghGpoZJZYuOcgK4fQwSvxruM4GUWUssX/pZCaIozUl1u/Sh1jMJ/Huaw/YLxIC
 vBIdbdBwVJG49PolE8z8u0/+s0LYHhIv125mhgTQYUaJXT//ME1glJ+F5IdZCBsWMDKtYhRL
 LSjOTU8tNiwwgUdlcn7uJkZw+tOy2ME49+0HvUOMTByMhxglOJiVRHgvZkimC/GmJFZWpRbl
 xxeV5qQWH2I0BYbkRGYp0eR8YALOK4k3NLE0MDEzMjaxMDQzVBLnPXOlLFVIID2xJDU7NbUg
 tQimj4mDU6qBqWgb556XOQ3PVPknv/+9aYrDa6HptrdFN5c+09Fa7vrfTulO52cdyUtbKrpv
 1SiLyabrOLCoB7yPnKBzPj7g/dT2G5JcAnaixV0ae9Lu1v2/N621ieX+oof/9vs4naneyzBD
 hd+uau81IbM/mjGBr7Xn/19tuvShOvfvSTfYDiuuu+bUUKeUsXni1vIjh54vbhU8+LtZcIPM
 ZLezBvUpGj48OQvNP68w+VTnumJhUfC1Y1ZNfD1XpgWqSJxfnOG13SjyVLGOavmW9Zvj6kI+
 W0Urec1ePfm/uS5T9PoDAiJTXR1XOLLlfv13mlvAYkbl2j+9U6YWmXSwbtE98NJteZDm5SX5
 mQrfLLYn2V3bpMRSnJFoqMVcVJwIACut5UIIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnO703ZLpBpcPiVvsuHOf2eLyrjls
 Fj9WfWG1uHjiE7PF1Emb2S3e7u1kd2DzmDfrBIvHuZ67bB6vDqxi9zh7Zwejx8Z3O5g8Pm+S
 C2CL4rJJSc3JLEst0rdL4Mp4/OwhU8EZsYoZH3awNjAeE+pi5OSQEDCRuPb6L3sXIxeHkMBu
 Rok/tw8yQiSkJD4/ncrWxcgBZAtLHD5cDFHznFFix+5rYDVsAnoS/xctZAZJiAisZ5SY3rGJ
 EaSBWUBJ4uopOYiG/YwS7S/7mEEaOAVsJc59nssEUiMsECZxpF8LJMwioCpx5OA8FhCbV8BS
 ovXZTagbFCR+Pl3GCmIzC4hIzO5sYwZpFRFwkmiYWTqBUWAWkswCRsZVjJKpBcW56bnFhgWG
 eanlesWJucWleel6yfm5mxjBoauluYNx+6oPeocYmTgYDzFKcDArifBezJBMF+JNSaysSi3K
 jy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cA0I/J10fsJOy5WH69l+t/a
 P09keqNsZy7jtL5PIaqrS+TSM01U1hx66bvjVNXRWGPjO1EMTm/v3Ve/rhuWOG3xN3Nn57KI
 DpVVsiZhW1QiUh7x/5MunpY7pWQP40EHzeqTNsLLnazK7vJ/vWp1nPkcc8CPu1pfP6002H27
 9pnthZdrLRa9V/PxE8rJuF6g6vUidCuLSoT3qd2Tfk9o3eK3sU6Rge3+tJ2e8U5Wj6a2bBW3
 Y59zPfVIjxnP+uIIFubKuDf5S1guJ9fpnws+1+ESd9TaK+OcpsHTcyEZP3QtaxT5jFI3mFX8
 X3vukFMhm3zxjg86vOf41zxKjgyetd/BRlhKpuVQ06Qf8eIbgpVYijMSDbWYi4oTAYy6MB3M
 AgAA
X-CMS-MailID: 20241024031431epcas1p2b3b5e06f95768605dae1ea5eacaefe61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241023202955epcas1p2ec95a2a3fdf8e84e065b86e3570c9509
References: <20241023202855.1571188-1-tharvey@gateworks.com>
 <CGME20241023202955epcas1p2ec95a2a3fdf8e84e065b86e3570c9509@epcas1p2.samsung.com>
 <20241023202855.1571188-2-tharvey@gateworks.com>
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
> From: Tim Harvey <tharvey@gateworks.com>
> Sent: Thursday, October 24, 2024 5:29 AM
> To: Heiko Schocher <hs@denx.de>; Tom Rini <trini@konsulko.com>; Peng Fan <peng.fan@nxp.com>; Jaehoon
> Chung <jh80.chung@samsung.com>; u-boot@lists.denx.de
> Cc: linux-kernel@vger.kernel.org; Tim Harvey <tharvey@gateworks.com>
> Subject: [PATCH 2/4] imx: power-domain: Convert to use livetree API for fdt access
>
> Convert to using livetree API functions.
>
> Without this if livetree is enabled (OF_LIVE) the imx8m-power-domain
> driver will (silently) fail to probe its children leaving you with
> no power domain support causing issues with certain devices.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/domain/imx8m-power-domain.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
> index 8b6870c86463..c22fbe60675e 100644
> --- a/drivers/power/domain/imx8m-power-domain.c
> +++ b/drivers/power/domain/imx8m-power-domain.c
> @@ -456,25 +456,22 @@ static int imx8m_power_domain_of_xlate(struct power_domain *power_domain,
>
>  static int imx8m_power_domain_bind(struct udevice *dev)
>  {
> -	int offset;
> +	ofnode subnode;
>  	const char *name;
>  	int ret = 0;
>
> -	offset = dev_of_offset(dev);
> -	for (offset = fdt_first_subnode(gd->fdt_blob, offset); offset > 0;
> -	     offset = fdt_next_subnode(gd->fdt_blob, offset)) {
> +	ofnode_for_each_subnode(subnode, dev_ofnode(dev)) {
>  		/* Bind the subnode to this driver */
> -		name = fdt_get_name(gd->fdt_blob, offset, NULL);
> +		name = ofnode_get_name(subnode);
>
>  		/* Descend into 'pgc' subnode */
>  		if (!strstr(name, "power-domain")) {
> -			offset = fdt_first_subnode(gd->fdt_blob, offset);
> -			name = fdt_get_name(gd->fdt_blob, offset, NULL);
> +			subnode = ofnode_first_subnode(subnode);
> +			name = ofnode_get_name(subnode);
>  		}
> -
>  		ret = device_bind_with_driver_data(dev, dev->driver, name,
>  						   dev->driver_data,
> -						   offset_to_ofnode(offset),
> +						   subnode,
>  						   NULL);
>
>  		if (ret == -ENODEV)
> @@ -514,8 +511,7 @@ static int imx8m_power_domain_of_to_plat(struct udevice *dev)
>  	struct imx_pgc_domain_data *domain_data =
>  		(struct imx_pgc_domain_data *)dev_get_driver_data(dev);
>
> -	pdata->resource_id = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
> -					    "reg", -1);
> +	pdata->resource_id = ofnode_read_u32_default(dev_ofnode(dev), "reg", -1);
>  	pdata->domain = &domain_data->domains[pdata->resource_id];
>  	pdata->regs = domain_data->pgc_regs;
>  	pdata->base = dev_read_addr_ptr(dev->parent);
> --
> 2.25.1
>



