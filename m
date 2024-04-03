Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64916C6FD1F
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 01:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C85B5881DA;
	Wed,  3 Apr 2024 03:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="SJ+NlTBR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A8FE881DB; Wed,  3 Apr 2024 03:24:16 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D98B8811A
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 03:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240403012408epoutp0481d27540a87e67899a04dbf20842c0cc~CoKdYFZUz1806718067epoutp044
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 01:24:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240403012408epoutp0481d27540a87e67899a04dbf20842c0cc~CoKdYFZUz1806718067epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712107448;
 bh=gVTlD9/uuEVWJWOkaLvzwv3Zd3fGIp9ZLjParqJyE2w=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=SJ+NlTBR3ZgeAvf+5KVtzZo9F1rdE/ylB434T98se8OgMBBTitF1qaTjlbeSUhu/0
 RDzWz7Uj7Vvrur8AZlejT8ln9vhbXSbr0WAtZuZ1Vs+W4rp0ppcg5CSFLrrQOx7YMg
 rFF6mjeewAsaB16bPWjNs43DYdeYlsNMHRI2Y87g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240403012408epcas1p431edc2a69c5ac7208f79734e48968c53~CoKdEcSEp3217832178epcas1p4X;
 Wed,  3 Apr 2024 01:24:08 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.235]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4V8RqC1TG2z4x9Px; Wed,  3 Apr
 2024 01:24:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 27.E4.09662.7BFAC066; Wed,  3 Apr 2024 10:24:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240403012406epcas1p2c14e01c3092a280bd459ea75bd2b6704~CoKbeO3XV1171111711epcas1p2N;
 Wed,  3 Apr 2024 01:24:06 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240403012406epsmtrp2fb6040758bfaeca0f284b6e1b014a04d~CoKbdsWKw2211922119epsmtrp2N;
 Wed,  3 Apr 2024 01:24:06 +0000 (GMT)
X-AuditID: b6c32a35-2b3fa700000025be-1e-660cafb7629d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 9F.44.19234.6BFAC066; Wed,  3 Apr 2024 10:24:06 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240403012406epsmtip131e844dd9d25896aa8b0e17a0fbf4296~CoKbJVVHo3200032000epsmtip15;
 Wed,  3 Apr 2024 01:24:06 +0000 (GMT)
Message-ID: <a0912ad2-c767-4e9b-ba34-faf4bb28b19b@samsung.com>
Date: Wed, 3 Apr 2024 10:24:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: arm_pl180: Limit data transfer to U16_MAX
To: cmax@mailbox.org, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240227201857.25814-1-cmax@mailbox.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmnu729TxpBkvmc1gsevaW0eLHqi+s
 Fm/3drI7MHucvbOD0WPn7H1MHhvf7WAKYI7KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw
 1DW0tDBXUshLzE21VXLxCdB1y8wB2qSkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
 KTAt0CtOzC0uzUvXy0stsTI0MDAyBSpMyM748n8dU8F54Yo7k+YyNTBe5e9i5OSQEDCROPH3
 OzuILSSwg1HibEtxFyMXkP2JUaL78BwWOGfSnQZGmI4JTStYIRI7GSVWrDwM5bxnlLjQtogJ
 pIpXwE6iYeN5sLksAioSRxf+ZYGIC0qcnPkEzBYVkJe4f2sGWI2wgLPE8blr2EBsEQEtiWOL
 PrGC2MxANdNfrYOyxSVuPZkPNp9NQEdi+7fjYDangJnE7SmHmWDqt7+dwwxykITALXaJY29m
 QZ3tIrHt4lt2CFtY4tXxLVC2lMTnd3vZIBqaGSWWLjnICuH0MEr8a7jOBlFlLLF/6WSgFRxA
 KzQl1u/Sh9jGJ/Huaw8rSFhCgFeio00IolpF4tLrl0ww8+8++c8KYXtI/D/8lgUS2J2MErMW
 uk1gVJiFFC6zkPw5C8k/sxAWL2BkWcUollpQnJueWmxYYAiP7uT83E2M4GSoZbqDceLbD3qH
 GJk4GA8xSnAwK4nw/vTmTBPiTUmsrEotyo8vKs1JLT7EaAqMnYnMUqLJ+cB0nFcSb2hiaWBi
 ZmRsYmFoZqgkznvmSlmqkEB6YklqdmpqQWoRTB8TB6dUA5PAm5uLDqcknuUtntma93vzutMx
 i5bFa3Wm+X+ReXfz4Ilf0y5f/bmQS/D6pYv8oisk1eZt2nc26Nejb+t3TzD0Cw7a2Tw7wF33
 RUulqueG5CsHwuJO694q/Lj/+8VQxdfR/ZZdi9c1fq3ZEHDGSfryyaL+tQLPXPXEmdNMFyyb
 IsAbuzssJ+bm98UPpG/9Z1EQU1iZ8n7i/wodEy6jAzEnQ2sfPn5Ssin68qyew7sSTrSlzQt7
 fyd7XqHf7vZ19++zc2/JmTeh+vGBeBGrP9ZfCg4rPVuRwTgtrHPTPneOlLRVTUr39q07llmy
 pe5VusQHSU/LAL+Gqc9l6wo3Mu1vF77/e2pz3uN3Z9imHtsUqMRSnJFoqMVcVJwIACRX9HsP
 BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSnO629TxpBi09JhaLnr1ltPix6gur
 xdu9newOzB5n7+xg9Ng5ex+Tx8Z3O5gCmKO4bFJSczLLUov07RK4Mr78X8dUcF644s6kuUwN
 jFf5uxg5OSQETCQmNK1g7WLk4hAS2M4o0bZvHjNEQkri89OpbF2MHEC2sMThw8UgYSGBt4wS
 044qgti8AnYSDRvPs4PYLAIqEkcX/mWBiAtKnJz5BMwWFZCXuH9rBliNsICzxPG5a9hAbBEB
 LYljiz6xgtjMQDXTX61jhZhvKvFy6g82iLi4xK0n85lAbDYBHYnt346D2ZwCZhK3pxxmAjmN
 WUBdYv08IZgx29/OYZ7AKDQLyRWzkEyahdAxC0nHAkaWVYyiqQXFuem5yQWGesWJucWleel6
 yfm5mxjBwa4VtINx2fq/eocYmTgYDzFKcDArifD+9OZME+JNSaysSi3Kjy8qzUktPsQozcGi
 JM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamByWSP+5JS7/foV13eV6t1U26tzuOKL79s5mbHO
 wZsyPuckSXa+Z1u7+ECNUb96f6HX05b/Pf8NZuS8Onu6Z+IJ+Tt7jiZZT3l58Gp03vlk6/+3
 GSccctpQ/+b2uhNKVX/Xr/PkvWulO4v5ebjiy5MKG3b6fdOWuXa3U2P2zejXnzbPb1uXpLVo
 ZqXb0rdBNt8X+doVvbvwUPUg84wtU/2Zp064le0k/iCqLtDDW0FX80LcRu3/U2T0fn5fG6Kq
 NW9Wo/23H/85nSrj+QI2hE3+tbfl+e6tOU0ft7MnCUXdV8qqP3Zjlai0ikFzz81lvocOHJ1f
 312r9MhL9Db3lEK3Nb2z+niDd89dNGdqbMUlTiWW4oxEQy3mouJEACCkBgnlAgAA
X-CMS-MailID: 20240403012406epcas1p2c14e01c3092a280bd459ea75bd2b6704
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403012406epcas1p2c14e01c3092a280bd459ea75bd2b6704
References: <20240227201857.25814-1-cmax@mailbox.org>
 <CGME20240403012406epcas1p2c14e01c3092a280bd459ea75bd2b6704@epcas1p2.samsung.com>
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

Hi,

On 2/28/24 05:18, cmax@mailbox.org wrote:
> From: max <cmax@mailbox.org>
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
> Signed-off-by: max <cmax@mailbox.org>

Could you add your full name as Signed-off's tag?

> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/arm_pl180_mmci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
> index 5cf5502ed5..af2f9a5a84 100644
> --- a/drivers/mmc/arm_pl180_mmci.c
> +++ b/drivers/mmc/arm_pl180_mmci.c
> @@ -231,6 +231,7 @@ static int do_data_transfer(struct mmc *dev,
>  	u32 blksz = 0;
>  	u32 data_ctrl = 0;
>  	u32 data_len = (u32) (data->blocks * data->blocksize);
> +	assert(data_len < U16_MAX); // should be ensured by arm_pl180_get_b_max

Add the comment at above with  "/* ... */"

/* Should be ensured by arm_pl180_get_b_max */
assert(data_len < U16_MAX);

Best Regards,
Jaehoon Chung

>  
>  	if (!host->version2) {
>  		blksz = (ffs(data->blocksize) - 1);
> @@ -358,6 +359,14 @@ static int  host_set_ios(struct mmc *dev)
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
>  #ifndef CONFIG_DM_MMC
>  /* MMC uses open drain drivers in the enumeration phase */
>  static int mmc_host_reset(struct mmc *dev)
> @@ -373,6 +382,7 @@ static const struct mmc_ops arm_pl180_mmci_ops = {
>  	.send_cmd = host_request,
>  	.set_ios = host_set_ios,
>  	.init = mmc_host_reset,
> +	.get_b_max = arm_pl180_get_b_max,
>  };
>  
>  /*
> @@ -531,6 +541,7 @@ static const struct dm_mmc_ops arm_pl180_dm_mmc_ops = {
>  	.send_cmd = dm_host_request,
>  	.set_ios = dm_host_set_ios,
>  	.get_cd = dm_mmc_getcd,
> +	.get_b_max = arm_pl180_get_b_max,
>  };
>  
>  static int arm_pl180_mmc_of_to_plat(struct udevice *dev)

