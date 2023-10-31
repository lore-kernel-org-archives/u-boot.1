Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B60C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C63FC87ABA;
	Tue, 31 Oct 2023 06:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="d8l2kHn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D219287ABB; Tue, 31 Oct 2023 06:03:24 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 600188709A
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:03:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231031050319epoutp03fc1bd5dab265a269ed3acae80ba9948e~TGKlB1G9P3094330943epoutp03v
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 05:03:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231031050319epoutp03fc1bd5dab265a269ed3acae80ba9948e~TGKlB1G9P3094330943epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698728599;
 bh=8EOLFCvWh6T/9q9/PFpcTFIinsMa+W2jurWCD+Beyj4=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=d8l2kHn+uqbkVkUWcdwpb4t5fuLQNBtFIS7Y/Dq93I+/6X851toF714xnNTEMgMbk
 vJ5s59jTiMqVASgZeEAvXTzuizeJxNm0mxBsYvhsomki52OJ/RKR9v8R8qPi5mBtV7
 zlRNVuca/kaHcIe5D2xN1jLOd42yswWxmFGlFJLY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20231031050319epcas1p436265956e88ca19e7c983fd7aaa27972~TGKku_-9V2081020810epcas1p46;
 Tue, 31 Oct 2023 05:03:19 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.237]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SKJ1f06Jgz4x9Q8; Tue, 31 Oct
 2023 05:03:18 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 E9.6B.10211.59A80456; Tue, 31 Oct 2023 14:03:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20231031050317epcas1p3355c1c22bb69bd9c6679ff393711a326~TGKjNYUoC1932119321epcas1p3-;
 Tue, 31 Oct 2023 05:03:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031050317epsmtrp1d3900c288840ae0266f6d050ccc25e22~TGKjMtSNt2446624466epsmtrp1e;
 Tue, 31 Oct 2023 05:03:17 +0000 (GMT)
X-AuditID: b6c32a38-463ff700000027e3-cf-65408a956bf2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 42.AC.08755.59A80456; Tue, 31 Oct 2023 14:03:17 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031050317epsmtip1545e0fe6a6b7b2059198142c3ee1f87c~TGKi8SsE41603016030epsmtip1a;
 Tue, 31 Oct 2023 05:03:17 +0000 (GMT)
Message-ID: <71985400-586d-4504-9091-10ee1fd55cfd@samsung.com>
Date: Tue, 31 Oct 2023 14:03:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] power: pmic: fix regulators behaviour
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@lists.denx.de
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20230715183431.5318-3-clamor95@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTX3dql0OqQf9Ea4sD/b2MFpPWX2O3
 +LZlG6PF272d7A4sHrMbLrJ4PO3fyu6xc9Zddo+zd3YwBrBEZdtkpCampBYppOYl56dk5qXb
 KnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1UUihLzCkFCgUkFhcr6dvZFOWXlqQq
 ZOQXl9gqpRak5BSYFugVJ+YWl+al6+WlllgZGhgYmQIVJmRn/Gi8yFhwRbBi5bLsBsZFfF2M
 nBwSAiYS3dPbWLoYuTiEBHYwSrx5dpYZwvnEKPHq/U9GCOcbo8TNzRtYYVqmfdzNBGILCexl
 lLi2qBqi6D2jxPaJ09lBErwCdhKnf39jBrFZBFQlrq17yQYRF5Q4OfMJC4gtKiAvcf/WDLB6
 YQFHiYdPLoENZRYQl7j1ZD6YLSJQI7F9xmUWiLiExJJD98GOYBPQkdj+7ThYDaeAuUTP7CdQ
 NfIS29/OAXtBQuAju8THSQuhrnaRWPH1J5QtLPHq+BZ2CFtK4mV/GztEQzOjxNIlB1khnB5G
 iX8N19kgqowl9i+dDLSOA2iFpsT6XfoQYUWJnb/nMkJs5pN497WHFaREQoBXoqNNCKJEReLS
 65dMMLvuPvkPdYOHxLP1d5gmMCrOQgqXWUj+n4Xkn1kIixcwsqxiFEstKM5NTy02LDCBx3Zy
 fu4mRnB61LLYwTj37Qe9Q4xMHIyHGCU4mJVEeA+bOqQK8aYkVlalFuXHF5XmpBYfYjQFxs5E
 ZinR5Hxggs4riTc0sTQwMTMyNrEwNDNUEuc99qo3RUggPbEkNTs1tSC1CKaPiYNTqoFpgo2o
 nJtKmP0UpR9K7Lb8bslHD23ZNdmp/NTZD7vEpQNZjPQndUbkPot9IyuztIKTseup4cIz11Oi
 01h0FilrHfv9UOxR977lDEYTGLwSD81q3Ohgf2PqO6tJqvEJP/0Uyv72B+94vGTa1cQ6tanN
 E5yXPX7jmcXC8eTz919t1TZ3HQ6kZ3bbXZyac3/qsZfqpxv4aqaF8C99daJqd4FN64Z55mfl
 9h2ISg+fONX8oK2L23zTOYrLbicc2bfcfqKRMOstQdWO/9yuL75kxpv8r9n58uz7uxuEWGqd
 7y1nLHL14WE/+ezHkeA57CVvzT8GTN9/pYB97flrPy7+s7ix98/ZRW3fqgRyxe5k/mXhVWIp
 zkg01GIuKk4EAHu+nu0YBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnO7ULodUg1fnlCwO9PcyWkxaf43d
 4tuWbYwWb/d2sjuweMxuuMji8bR/K7vHzll32T3O3tnBGMASxWWTkpqTWZZapG+XwJXxo/Ei
 Y8EVwYqVy7IbGBfxdTFyckgImEhM+7ibqYuRi0NIYDejxMWZD5ghElISn59OZeti5ACyhSUO
 Hy6GqHnLKLFyzV52kBpeATuJ07+/gdWzCKhKXFv3kg0iLihxcuYTFhBbVEBe4v6tGWD1wgKO
 Eg+fXGICsZkFxCVuPZkPZosI1Eg0zu1mg4hLSCw5dJ8VxBYSSJbYce8gWA2bgI7E9m/HwWxO
 AXOJntkg8zmA6tUl1s8TgmiVl9j+dg7zBEahWUiumIVk2yyEjllIOhYwsqxilEwtKM5Nzy02
 LDDMSy3XK07MLS7NS9dLzs/dxAiOBC3NHYzbV33QO8TIxMF4iFGCg1lJhPewqUOqEG9KYmVV
 alF+fFFpTmrxIUZpDhYlcV7xF70pQgLpiSWp2ampBalFMFkmDk6pBqZdgenPM3K+an9/cC4l
 durHpm+zi4yceXltGzYo6relPMz3LD6h+UGNp/nPBbFzG7kX7l+qvfq3i+XiN9kX5b7mVX49
 zsdoukzIbv2clEedGeWf9PZ6zm5UNSty3JhQfOLBXrkIH809DKY9OxxyFoly2jju3n+p2vnO
 3Gfvzy67NlnxnLfTpwnqbH0TA2pOXr1upmPEMEuqeLqm8PYlgT1TuM1ab9w/JTgh+eei308k
 7E6/2dJ1RDzU+HtM4IeZKjVq6iav1uY8tvs4IWbq5Kfy/MsfsNarPzj9xl6i8tfWj5d39KQK
 8/5h+fjzx8UL9h23PrBMrl9tLrhy3dK5z/4rxImf1tUxYp7ifffFcoEbSizFGYmGWsxFxYkA
 232poPMCAAA=
X-CMS-MailID: 20231031050317epcas1p3355c1c22bb69bd9c6679ff393711a326
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031050317epcas1p3355c1c22bb69bd9c6679ff393711a326
References: <20230715183431.5318-1-clamor95@gmail.com>
 <20230715183431.5318-3-clamor95@gmail.com>
 <CGME20231031050317epcas1p3355c1c22bb69bd9c6679ff393711a326@epcas1p3.samsung.com>
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

On 7/16/23 03:34, Svyatoslav Ryhel wrote:
> Currently device tree entries of regulators are completely
> ignored and regulators are probed only if they are called
> by the device which uses it. This results into two issues:
> regulators which must run under boot-on or always-on mode
> are ignored and not enabled; dts props like voltage are
> not applied to the regulator so the regulator may be enabled
> with random actual voltage, which may have unexpected
> consequences.
> 
> This patch changes this behavior. Post-probe function is
> introduced which performs probing of each pmics child and if
> it is a regulator, regulator_autoset function is called, which
> handles always-on and boot-on regulators, but if none of those
> props are set, the regulator is disabled.
> 
> Later disabled regulators can be re-enabled by devices which
> use them without issues.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/pmic/pmic-uclass.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/power/pmic/pmic-uclass.c b/drivers/power/pmic/pmic-uclass.c
> index 0e2f5e1f41..8a26b519c9 100644
> --- a/drivers/power/pmic/pmic-uclass.c
> +++ b/drivers/power/pmic/pmic-uclass.c
> @@ -16,6 +16,7 @@
>  #include <dm/device-internal.h>
>  #include <dm/uclass-internal.h>
>  #include <power/pmic.h>
> +#include <power/regulator.h>
>  #include <linux/ctype.h>
>  
>  #if CONFIG_IS_ENABLED(PMIC_CHILDREN)
> @@ -198,9 +199,26 @@ static int pmic_pre_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> +static int pmic_post_probe(struct udevice *dev)
> +{
> +	struct udevice *child;
> +	int ret;
> +
> +	device_foreach_child_probe(child, dev) {
> +		if (device_get_uclass_id(child) == UCLASS_REGULATOR) {
> +			ret = regulator_autoset(child);
> +			if (ret == -EMEDIUMTYPE)
> +				regulator_set_enable(child, false);
> +		};
> +	};
> +
> +	return 0;
> +}
> +
>  UCLASS_DRIVER(pmic) = {
>  	.id		= UCLASS_PMIC,
>  	.name		= "pmic",
>  	.pre_probe	= pmic_pre_probe,
> +	.post_probe	= pmic_post_probe,
>  	.per_device_auto	= sizeof(struct uc_pmic_priv),
>  };

