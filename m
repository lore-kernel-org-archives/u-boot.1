Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670A0CDD0FF
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 22:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2C0A890AE;
	Wed, 23 Oct 2024 00:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="VYytDqQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B642C88FF6; Wed, 23 Oct 2024 00:50:02 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662CA8908D
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 00:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241022224949epoutp04462fd290ec6e9926047c08131ad41847~A6AqlMC4l1000210002epoutp04e
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 22:49:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241022224949epoutp04462fd290ec6e9926047c08131ad41847~A6AqlMC4l1000210002epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1729637389;
 bh=0uwminqxiavMAd7HetknIQCVUbbkjH3PSKVeVQAWEks=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=VYytDqQCrddUKr+9vp8M20skKQLsU7Vj9c7Tsydb74oigh56zrcb4/lhDjeRR2krL
 3QW1LlW70o0SZ7k3lGaXy2PB2qx3uOYXOeUuBg+lfOwPXnIPR3asxGwZcDzLj90wV6
 /Q68xsBoCUjjfiRS+sAdq5QHGPIBQFkbV3GtMS3E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241022224948epcas1p26030bb03dc96c4190ae6e35e29d5ae69~A6AqQFuhr0346103461epcas1p2i;
 Tue, 22 Oct 2024 22:49:48 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.144]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4XY6nS07dgz4x9Ps; Tue, 22 Oct
 2024 22:49:48 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 85.9B.09435.B0C28176; Wed, 23 Oct 2024 07:49:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20241022224947epcas1p305c94059e04f67adbd6e114b2199cc7c~A6Aotarqs1385613856epcas1p3p;
 Tue, 22 Oct 2024 22:49:47 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241022224947epsmtrp13ef3726c4448d3bbb5a1021321f836ea~A6Aosun-s3117431174epsmtrp1M;
 Tue, 22 Oct 2024 22:49:47 +0000 (GMT)
X-AuditID: b6c32a36-ac7ff700000024db-e5-67182c0b24c2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 07.55.07371.B0C28176; Wed, 23 Oct 2024 07:49:47 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241022224947epsmtip10881fbf8db4118ff45a56115aa5d3c62~A6Aob_hbV2431024310epsmtip1c;
 Tue, 22 Oct 2024 22:49:47 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Neil Armstrong'" <neil.armstrong@linaro.org>, "'Caleb Connolly'"
 <caleb.connolly@linaro.org>, "'Sumit Garg'" <sumit.garg@linaro.org>, "'Peng
 Fan'" <peng.fan@nxp.com>, "'Tom Rini'" <trini@konsulko.com>
Cc: <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
In-Reply-To: <20241016-topic-sm8x50-mmc-vqmmc-v1-1-767af5351d37@linaro.org>
Subject: RE: [PATCH] mmc: msm_sdhci: enable vqmmc at probe if available
Date: Wed, 23 Oct 2024 07:49:46 +0900
Message-ID: <0a4a01db24d4$b1aea100$150be300$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJ/1vp/16iCOgnNruFQSyhJKCMlsAHL170HsTuckrA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmvi63jkS6wdctphanWrYxWbzfeYvR
 4seqL6wW6/b1sVlMnbSZ3aJpyyxWi7d7O9kd2D3md35n8nh1YBW7x51re9g8zt7Zweix8d0O
 pgDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKA7
 lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFpgV6xYm5xaV56Xp5qSVWhgYGRqZA
 hQnZGStXnGUr+CBY8aRnBmMD43m+LkZODgkBE4lT/bNYuhi5OIQEdjBKvDp5ngnC+cQo8eHv
 JVYI5xujxOcn99lhWlZfXMwMYgsJ7GWU2DG/FqLoJaPEss+/wRJsAnoS/xctZAZJiAhcYpT4
 +bGJBSTBLGAs8fvlLTCbU8Bbor/zKliDsIC7xO+HL5hAbBYBVYl/szoYuxg5OHgFLCUWv5aE
 WKwg8fPpMlaIMSISszvbwFpFBKwk9nefYwTZJSHwkl3iw8EFUJe6SLy9+5IJwhaWeHV8C1Rc
 SuJlfxs7REMzo8TSJQdZIZweRol/DdfZIKqMJfYvncwEcgWzgKbE+l36EJv5JN597WEFCUsI
 8Ep0tAlBVKtIXHoNs0tK4u6T/6wQtofEhuknWSGhNY9RYv9lowmM8rOQ/DALYcECRqZVjGKp
 BcW56anFhgVG8KhMzs/dxAhOgFpmOxgnvf2gd4iRiYPxEKMEB7OSCK9SiWi6EG9KYmVValF+
 fFFpTmrxIUZTYEBOZJYSTc4HpuC8knhDE0sDEzMjYxMLQzNDJXHeM1fKUoUE0hNLUrNTUwtS
 i2D6mDg4pRqYMjZtTdL/5J5duH5+dszOQyF+Lqz/TnHfF//+X6Hj+7cvKxlWxN/inPOtbP66
 AyXVhS8+bBSVTste+fGN1ZdlH2TFC1+1Gx5mvlztcHbKr4QzEhN0mg6uqPB+4nDw6Y+/Obv2
 Vxm//WG5YhH7xWtaYZXK5bt9mHoOvUm8dWKpX0iF6+upzXNmTj3Wnc+jV8Pg3rL+ltpCN2f+
 8BJmK/sJsc1n3xhv9N7SyHE4cLE4swCb536pVfKtATUT3ydN8H39wfzWphkOj/LNm/+6llzY
 co6FO1nHr/Pi9K/BiTFTmTfv4Dvp+yI6i3HhzU2WQtNumm+wz2db02tQfSz37ikH+Sv/Vsur
 pDIvSOBp8e4+q8RSnJFoqMVcVJwIAKSVgdAJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnC63jkS6wfw13BanWrYxWbzfeYvR
 4seqL6wW6/b1sVlMnbSZ3aJpyyxWi7d7O9kd2D3md35n8nh1YBW7x51re9g8zt7Zweix8d0O
 pgDWKC6blNSczLLUIn27BK6MlSvOshV8EKx40jODsYHxPF8XIyeHhICJxOqLi5m7GLk4hAR2
 M0rcezaZFSIhJfH56VS2LkYOIFtY4vDhYoia54wSNxo/g9WwCehJ/F+0EKxZROAao8TmQ08Y
 QRLMAqYSM/9vY4XomMMosX5BB1iCU8Bbor/zKjOILSzgLvH74QsmEJtFQFXi3yyQGg4OXgFL
 icWvJSGOUJD4+XQZK8RMEYnZnW1grSICVhL7u88xTmAUmIUktYCRcRWjZGpBcW56brJhgWFe
 arlecWJucWleul5yfu4mRnAAa2nsYLw3/5/eIUYmDsZDjBIczEoivEoloulCvCmJlVWpRfnx
 RaU5qcWHGKU5WJTEeQ1nzE4REkhPLEnNTk0tSC2CyTJxcEo1MKk/cLCIKUp7pGWzkOd/Q9Vz
 m3lOBXo6t/ieff12NFWTdc7atOx8yTottnUiHt9tZlXZ5Z/bIuy0XL9TlsWllUPl0ZpvKbME
 lmobbm7bEqt9/d/60+vdAyXu3Q0oCGOR2eC1Y2/RxO5Ph2XMKi88nKUl/uPTFpHy6xa1h8rX
 7imVyNu//5s847ON4RtMFpzdO3tr6HL5V0GPJrnlJTrst/zKclLd/bPxkeDFKRLu02Ptt7YY
 P3oy7f3EnSHW7M2rjn/Z0mQXr6wjrSF2LdZo2T27+e288xp3CdibRMjyHTIMSv19aGVatrH/
 9sVyRxXyJTR3v318IJ/xBOv7bcXle13+dRhNYdTr+vLD4+DPMiWW4oxEQy3mouJEAG3hzxLP
 AgAA
X-CMS-MailID: 20241022224947epcas1p305c94059e04f67adbd6e114b2199cc7c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016091723epcas1p39976665cca3306904fe4f3727c3360e1
References: <CGME20241016091723epcas1p39976665cca3306904fe4f3727c3360e1@epcas1p3.samsung.com>
 <20241016-topic-sm8x50-mmc-vqmmc-v1-1-767af5351d37@linaro.org>
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
> From: Neil Armstrong <neil.armstrong@linaro.org>
> Sent: Wednesday, October 16, 2024 6:17 PM
> To: Caleb Connolly <caleb.connolly@linaro.org>; Sumit Garg <sumit.garg@linaro.org>; Peng Fan
> <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>
> Cc: u-boot-qcom@groups.io; u-boot@lists.denx.de; Neil Armstrong <neil.armstrong@linaro.org>
> Subject: [PATCH] mmc: msm_sdhci: enable vqmmc at probe if available
>
> On earlier platforms, the vqmmc regulator was enabled by the
> previous bootloader, but on the newest (SM8650) it's not
> and we need vqmmc to be enabled in order to have the card
> to respond.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/msm_sdhci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 4e5c932c071..27bb7052fca 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -15,6 +15,7 @@
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> +#include <power/regulator.h>
>
>  /* Non-standard registers needed for SDHCI startup */
>  #define SDCC_MCI_POWER   0x0
> @@ -43,6 +44,7 @@ struct msm_sdhc {
>  	struct sdhci_host host;
>  	void *base;
>  	struct clk_bulk clks;
> +	struct udevice *vqmmc;
>  };
>
>  struct msm_sdhc_variant_info {
> @@ -163,6 +165,16 @@ static int msm_sdc_probe(struct udevice *dev)
>  	if (ret)
>  		return ret;
>
> +	/* Get the vqmmc regulator and enable it if available */
> +	device_get_supply_regulator(dev, "vqmmc-supply", &prv->vqmmc);
> +	if (prv->vqmmc) {
> +		ret = regulator_set_enable_if_allowed(prv->vqmmc, true);
> +		if (ret) {
> +			printf("Failed to enable the VQMMC regulator\n");
> +			return ret;
> +		}
> +	}
> +
>  	var_info = (void *)dev_get_driver_data(dev);
>  	if (!var_info->mci_removed) {
>  		ret = msm_sdc_mci_init(prv);
>
> ---
> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
> change-id: 20241016-topic-sm8x50-mmc-vqmmc-b7cf8176ec51
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>



