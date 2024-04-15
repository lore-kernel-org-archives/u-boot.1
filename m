Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA1EC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FAF487DDF;
	Mon, 15 Apr 2024 13:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="lN45+N8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18CC687CB7; Mon, 15 Apr 2024 13:01:59 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D3287DDF
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240415110150epoutp0180ae051f8ef20b703b552cad93f10070~GbyRtdSx00853408534epoutp01z
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:01:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240415110150epoutp0180ae051f8ef20b703b552cad93f10070~GbyRtdSx00853408534epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713178910;
 bh=ZfFtZ5jjP+STWBjVhOMxYpI2vgZ13VIYA4EuYatLLRw=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=lN45+N8rEuaVINhVGkuSWOFc+gr1DK2gJyWDwmS2WMkOGHXYCF/3GZkiTTh1JX1Yl
 aKH4NPsELtkZfisN6fYrGHTJJwkcidOuCaklq6JBj10nNJP2QwLi00zeFyNQ4UeXzn
 Xe4AP08qCdVFqWE4lT7iamEuN76NxS3xOH0lRS5E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240415110149epcas1p316377d7c8f059780574fea1ab388ba47~GbyRPBQXv0755107551epcas1p3M;
 Mon, 15 Apr 2024 11:01:49 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.145]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4VJ44D5DBTz4x9Pp; Mon, 15 Apr
 2024 11:01:48 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 4E.D8.09663.C190D166; Mon, 15 Apr 2024 20:01:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240415110148epcas1p37498061aaf33b160525f5c3861abc15a~GbyPz8FtV0288002880epcas1p3x;
 Mon, 15 Apr 2024 11:01:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240415110148epsmtrp2a17f5f0727e11c2546e269b9e7a6fc99~GbyPzWha60279002790epsmtrp2G;
 Mon, 15 Apr 2024 11:01:48 +0000 (GMT)
X-AuditID: b6c32a37-2f9ff700000025bf-ab-661d091c2648
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A8.66.08924.C190D166; Mon, 15 Apr 2024 20:01:48 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240415110148epsmtip27a8e92798a7e9c776f86f0bf966009c2~GbyPk0rkS3156431564epsmtip2T;
 Mon, 15 Apr 2024 11:01:48 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: <cmax@mailbox.org>, <u-boot@lists.denx.de>
Cc: "'Maximilian Brune'" <maximilian.brune@9elements.com>, "'Peng Fan'"
 <peng.fan@nxp.com>
In-Reply-To: <20240415095324.28469-1-cmax@mailbox.org>
Subject: RE: [PATCH v2] mmc: arm_pl180: Limit data transfer to U16_MAX
Date: Mon, 15 Apr 2024 20:01:48 +0900
Message-ID: <007901da8f24$4fdd0390$ef970ab0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQLPlTIcv4jGDfEyxksLUN1+0irjygLAnPoQAmi3Pj+vVdMngA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTT1eGUzbN4Nd7dYtFz94yWvy8f47F
 4seqL6wWb/d2sjuweFyfZudx9s4ORo+ds/cxeWx8t4MpgCUq2yYjNTEltUghNS85PyUzL91W
 yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
 I7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj6KLlrAWbhSv69k5kbGB8zt/F
 yMkhIWAi8XP6HrYuRi4OIYEdjBLrLh1nh3A+MUo8fnaOEcL5xihx5OlyRpiWp+t6oVr2Mkq8
 6J8FVfWSUWLLi9VgVWwCehL/Fy1kBrFFgOzNh7+wgtjMAjESvd8gJnEKmEkc/tPDDmILC7hJ
 rOl/zQJiswioSpxdsYUJxOYVsJQ4cfY8C4QtKHFy5hMWiDnyEtvfzmGGuEhB4ufTZVDzRSRm
 d7ZB7XWS6F74jQXkOAmBr+wSbSd2sUM0uEg8OfWeBcIWlnh1fAtUXEri87u9bBANzYwSS5cc
 ZIVwehgl/jVcZ4OoMpbYv3Qy0HkcQOs0Jdbv0ofYzCfx7msPK0hYQoBXoqNNCKJaReLS65dM
 MPPvPvnPCmF7SCz7MIltAqPiLCS/zULy2ywk/8xCWLaAkWUVo1hqQXFuemqxYYExPL6T83M3
 MYITpJb5DsZpbz/oHWJk4mA8xCjBwawkwntNTjJNiDclsbIqtSg/vqg0J7X4EKMpMLQnMkuJ
 JucDU3ReSbyhiaWBiZmRsYmFoZmhkjjvmStlqUIC6YklqdmpqQWpRTB9TBycUg1MEsl2D/yM
 OA3jLvo31WdM32oxtVXrcffEmEnLjjz2f9/a/VRt+9lD14TYswtel5wV2OKd/3Tn9Ri/03yH
 guRt3TOmzNMLeVEgte34pcd1U9d++nlErCOm+03tJVbFv0Uz6xIOPc8SSPK4VjDj3nPD9Pld
 k5h3M984afPH4qvZIX2BZYcVEyOyxBWtl7Dt5+P/uJu7Yw+LPEOJQeoU7qrI4o5Lv4UDN384
 Kvrc7XzPtw8scjnbgybuLGBMTnVf03huyoUFdWqsdnc2Teu9furEW4+eValSqxbo3FnpduNd
 0LHC19LZN9g+L5/NIH3sTXnNkQ+nhOezclzjL9rgkxAVeV7W9MmvBZd4Fp8IW/3+hxJLcUai
 oRZzUXEiAAN98BcZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvK4Mp2yawcVpIhaLnr1ltPh5/xyL
 xY9VX1gt3u7tZHdg8bg+zc7j7J0djB47Z+9j8tj4bgdTAEsUl01Kak5mWWqRvl0CV8bRRctZ
 CzYLV/TtncjYwPicv4uRk0NCwETi6bpeti5GLg4hgd2MEl/OTWKFSEhJfH46FSjBAWQLSxw+
 XAxR85xRYt7H0+wgNWwCehL/Fy1kBrFFBAwkGhZOZwGxmQViJNYufsUK0bCRUWL64R6woZwC
 ZhKH//SANQsLuEms6X8N1sAioCpxdsUWJhCbV8BS4sTZ8ywQtqDEyZlPoIZqS/Q+bGWEsOUl
 tr+dwwxxqILEz6fLWCHiIhKzO9ugDnKS6F74jWUCo/AsJKNmIRk1C8moWUjaFzCyrGKUTC0o
 zk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4TLc0djNtXfdA7xMjEwXiIUYKDWUmE95qcZJoQ
 b0piZVVqUX58UWlOavEhRmkOFiVxXvEXvSlCAumJJanZqakFqUUwWSYOTqkGJg3jEPb/fAGT
 zjzdOj9d9cv+J2VJntm3uHd7XjFMn3u9rPZkw1tjz3zjaMup1TMnhs8q/fHf/YalQ23ZatUf
 F5zXhMSuP/PtrcGTBu6Ec1M0XdtXMm3kfBnUERqpLdTCVHyX5ceDr3rf5QJW6B07d8iH4+FW
 c7fe+5UZ2R4uXudYutY1egh1FJjlf5l5YI5AMtO2zv1Gt5+uYUlavLMgatG62I7Zqxb+vPTq
 V0DTpv98UsqiURpTmlXn797vcV4laqLLXKlzFaqS+1oFuU254403Pj5tv1nBsGmd1+6L7CGS
 K/nyWYMt/pbMdda5ckhWumRD1W+BJCfGsxs8LyozLEsPmCWtkBxu7rwqxOm6EktxRqKhFnNR
 cSIAFA2eSwIDAAA=
X-CMS-MailID: 20240415110148epcas1p37498061aaf33b160525f5c3861abc15a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240415095409epcas1p29cd47b1e2b63aa5e0446ebc9abedb955
References: <20240227201857.25814-1-cmax@mailbox.org>
 <CGME20240415095409epcas1p29cd47b1e2b63aa5e0446ebc9abedb955@epcas1p2.samsung.com>
 <20240415095324.28469-1-cmax@mailbox.org>
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
> From: cmax@mailbox.org <cmax@mailbox.org>
> Sent: Monday, April 15, 2024 6:53 PM
> To: u-boot@lists.denx.de
> Cc: Maximilian Brune <maximilian.brune@9elements.com>; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung
> <jh80.chung@samsung.com>
> Subject: [PATCH v2] mmc: arm_pl180: Limit data transfer to U16_MAX
> 
> From: Maximilian Brune <maximilian.brune@9elements.com>
> 
> Currently fetching files bigger that cause a data transfer greater than
> U16_MAX fails.
> 
> The reason is that the specification defines the datalength register
> as a 16 bit wide register, but in u-boot it is used as if it is an
> 32 bit register. Therefore values greater than U16_MAX cause an
> infinite loop inside u-boot. U-boot expects to get more data from
> interface/hardware then it will ever get and therefore inifintely waits
> for more data that will never come.
> 
> Signed-off-by: Maximilian Brune <maximilian.brune@9elements.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/arm_pl180_mmci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
> index 2666b65362..cecc7ad783 100644
> --- a/drivers/mmc/arm_pl180_mmci.c
> +++ b/drivers/mmc/arm_pl180_mmci.c
> @@ -229,6 +229,7 @@ static int do_data_transfer(struct mmc *dev,
>  	u32 blksz = 0;
>  	u32 data_ctrl = 0;
>  	u32 data_len = (u32) (data->blocks * data->blocksize);
> +	assert(data_len < U16_MAX); /* should be ensured by arm_pl180_get_b_max */
> 
>  	if (!host->version2) {
>  		blksz = (ffs(data->blocksize) - 1);
> @@ -356,6 +357,14 @@ static int  host_set_ios(struct mmc *dev)
>  	return 0;
>  }
> 
> +static int arm_pl180_get_b_max(struct udevice *dev, void *dst, lbaint_t blkcnt)
> +{
> +	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
> +	struct mmc *mmc = upriv->mmc;
> +
> +	return U16_MAX / mmc->read_bl_len;
> +}
> +
>  static void arm_pl180_mmc_init(struct pl180_mmc_host *host)
>  {
>  	u32 sdi_u32;
> @@ -470,6 +479,7 @@ static const struct dm_mmc_ops arm_pl180_dm_mmc_ops = {
>  	.send_cmd = dm_host_request,
>  	.set_ios = dm_host_set_ios,
>  	.get_cd = dm_mmc_getcd,
> +	.get_b_max = arm_pl180_get_b_max,
>  };
> 
>  static int arm_pl180_mmc_of_to_plat(struct udevice *dev)
> --
> 2.44.0


