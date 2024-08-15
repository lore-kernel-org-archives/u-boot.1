Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A467BC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 03:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C067F88A11;
	Thu, 15 Aug 2024 05:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mKjdI5DB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3C5889FF; Thu, 15 Aug 2024 05:15:07 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94093889F8
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 05:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47F3F3UB109755;
 Wed, 14 Aug 2024 22:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723691703;
 bh=uEdeHcZGWYTPybDagl3//5nFYGE7D8gFMmhM0D9rPwY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=mKjdI5DBVHF7WjLrFQ389nMVfhhK9eGFge1CodecHPNO0Adkyfl4xTc6S0c4pf7NS
 jzzm/d4qBSpQ5ivmSa/s0qAVjFWXBm4oMIlDoq2kvEqZ8tbPu/cLTDlL1Tmbxdrg+C
 9t0kyl7dF/M7jQDEaIEsUPN0rlF3dLceU7ccJ8D0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47F3F29w083806
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Aug 2024 22:15:03 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 22:15:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 22:15:02 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47F3Eu6A041900;
 Wed, 14 Aug 2024 22:14:57 -0500
Message-ID: <32099394-56f3-4eeb-b4f1-f9c8786c84a6@ti.com>
Date: Thu, 15 Aug 2024 08:44:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] drivers: misc: k3_avs: Extract MPU clk and dev ID
 from DT
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>, Nishanth Menon <nm@ti.com>, <u-kumar1@ti.com>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
 <20240813-b4-upstream-j721s2-avs-v3-4-5115d93cdeb2@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240813-b4-upstream-j721s2-avs-v3-4-5115d93cdeb2@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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


On 8/13/2024 11:40 AM, Manorit Chawdhry wrote:
> Different devices have different MPU clk and dev ID. Currently it had
> been hardcoded. Move it to DT based extraction.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   drivers/misc/k3_avs.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>
> diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
> index 568cf5b20d51..f94eee5b1c64 100644
> --- a/drivers/misc/k3_avs.c
> +++ b/drivers/misc/k3_avs.c
> @@ -352,6 +352,9 @@ static int k3_avs_probe(struct udevice *dev)
>   	struct k3_avs_privdata *priv;
>   	struct vd_data *vd;
>   	int ret;
> +	ofnode node;
> +	struct ofnode_phandle_args phandle_args;
> +	int i = 0;
>   
>   	priv = dev_get_priv(dev);
>   	priv->dev = dev;
> @@ -367,6 +370,34 @@ static int k3_avs_probe(struct udevice *dev)
>   		return -ENODEV;
>   
>   	for (vd = priv->vd_config->vds; vd->id >= 0; vd++) {
> +		/* Get the clock and dev id for Jacinto platforms */
> +		if (vd->id == J721E_VDD_MPU) {
> +			node = ofnode_get_aliases_node("remoteproc1");

My suggestion will be to search node based upon compatible name am654-rproc


> +			if (!ofnode_valid(node))
> +				return -ENODEV;
> +
> +			i = ofnode_stringlist_search(node, "clock-names", "core");
> +			if (i < 0)
> +				return -ENODEV;
> +
> +			debug("%s: i: %d\n", __func__, i);

I assume this was for your debug only, Please see if you can remove this


> +
> +			ret = ofnode_parse_phandle_with_args(node, "clocks",
> +							     "#clock-cells",
> +							     0, i,
> +							     &phandle_args);
> +			if (ret) {
> +				printf("Couldn't get the clock node\n");
> +				return ret;
> +			}
> +
> +			vd->dev_id = phandle_args.args[0];
> +			vd->clk_id = phandle_args.args[1];
> +
> +			debug("%s: MPU dev_id: %d, clk_id: %d", __func__,
> +			      vd->dev_id, vd->clk_id);
> +		}
> +
>   		if (!(readl(AM6_VTM_DEVINFO(vd->id)) &
>   		      AM6_VTM_AVS0_SUPPORTED)) {
>   			dev_warn(dev, "AVS-class 0 not supported for VD%d\n",
> @@ -463,6 +494,12 @@ static struct vd_data j721e_vd_data[] = {
>   	{
>   		.id = J721E_VDD_MPU,
>   		.opp = AM6_OPP_NOM,
> +		/*
> +		 * XXX: DEPRECATION WARNING: Around 2 u-boot versions
> +		 *
> +		 * These values will be picked up from DT, kept for backward
> +		 * compatibility
> +		 */
>   		.dev_id = 202, /* J721E_DEV_A72SS0_CORE0 */
>   		.clk_id = 2, /* ARM clock */
>   		.opps = {
>
