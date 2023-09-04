Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197DAC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 09:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7637E86961;
	Mon,  4 Sep 2023 11:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="yLDqQflI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70EC3868D3; Mon,  4 Sep 2023 11:25:14 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA81786960
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 11:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=761156b540=fabrice.gasnier@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3848NXqe004195; Mon, 4 Sep 2023 11:25:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=N8VGhVZLuTWrzt3Rfa/gNxl6RJYjr4ifDJ9EcB2efJE=; b=yL
 DqQflIvZzyj3plLHpW4SaBS70iwT6+/7lt18zXRoXa5z4L7eZ0HdznjLZIPogyQf
 qadtrS1g5ZGMp8Ec94LdYAZswh4RQVGgUIyfwb5j1c/hnEtGB+Q70zBQRcKGm6VP
 8/Uw3iNAP5C1JBLtt4Oiv9dhLJuCpR97j0YORyM565DDf+5nnxPTuXCFju5gwvxX
 Ig/JaI1wM2oR4srgzZn9gGOYS0pcAx0Bt1jHz5hCb4hISqu6xXpNW34Mqo1bUo0H
 I0FxhK9OxFSZAWzXu2y0rdVJ3sz8eavv8fvNLefWlzi+lOh0Rs8Eve7FBDpPJoUW
 SYWfMiwitYIls2RFaxEA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3suvd0e54t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 11:25:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D7CA100063;
 Mon,  4 Sep 2023 11:25:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D3ED2171E6;
 Mon,  4 Sep 2023 11:25:10 +0200 (CEST)
Received: from [10.201.22.39] (10.201.22.39) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 4 Sep
 2023 11:25:07 +0200
Message-ID: <428ea549-1092-fb39-15e1-10f2284691e8@foss.st.com>
Date: Mon, 4 Sep 2023 11:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: host: ohci-generic: Make usage of clock/reset bulk()
 API
To: Xavier Drudis Ferran <xdrudis@tinet.cat>
CC: <u-boot@lists.denx.de>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice CHOTARD
 <patrice.chotard@foss.st.com>, Marek Vasut <marex@denx.de>
References: <20230830080150.473374-1-fabrice.gasnier@foss.st.com>
 <ZPL7DAQfE3WxCFa+@xdrudis.tinet.cat>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <ZPL7DAQfE3WxCFa+@xdrudis.tinet.cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.39]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
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

On 9/2/23 11:06, Xavier Drudis Ferran wrote:
> Is the change of behaviour intended when a clock or reset is not found ?
> (see below)

Hi Xavier,

I'd say yes, although I haven't seen that... please find my answers below.

> 
> El Wed, Aug 30, 2023 at 10:01:49AM +0200, Fabrice Gasnier deia:
>> Make usage of clock and reset bulk API in order to simplify the code
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>>
>>  drivers/usb/host/ohci-generic.c | 92 +++++++++++----------------------
>>  1 file changed, 29 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
>> index 2d8d38ce9a40..95aa608d8c19 100644
>> --- a/drivers/usb/host/ohci-generic.c
>> +++ b/drivers/usb/host/ohci-generic.c
>> @@ -16,75 +16,41 @@
>>  
>>  struct generic_ohci {
>>  	ohci_t ohci;
>> -	struct clk *clocks;	/* clock list */
>> -	struct reset_ctl *resets; /* reset list */
>> +	struct clk_bulk clocks;	/* clock list */
>> +	struct reset_ctl_bulk resets; /* reset list */
>>  	struct phy phy;
>> -	int clock_count;	/* number of clock in clock list */
>> -	int reset_count;	/* number of reset in reset list */
>>  };
>>  
>>  static int ohci_usb_probe(struct udevice *dev)
>>  {
>>  	struct ohci_regs *regs = dev_read_addr_ptr(dev);
>>  	struct generic_ohci *priv = dev_get_priv(dev);
>> -	int i, err, ret, clock_nb, reset_nb;
>> -
>> -	err = 0;
>> -	priv->clock_count = 0;
>> -	clock_nb = dev_count_phandle_with_args(dev, "clocks", "#clock-cells",
>> -					       0);
>> -	if (clock_nb > 0) {
>> -		priv->clocks = devm_kcalloc(dev, clock_nb, sizeof(struct clk),
>> -					    GFP_KERNEL);
>> -		if (!priv->clocks)
>> -			return -ENOMEM;
>> -
>> -		for (i = 0; i < clock_nb; i++) {
>> -			err = clk_get_by_index(dev, i, &priv->clocks[i]);
>> -			if (err < 0)
>> -				break;
>> -
> 
> Please note the old code was tolerant of not finding some clocks. It
> ignored any clock not found and any other listed after it in the
> "clocks" property and enabled the clocks before it.
> 
> The clk_get_bulk() function instead returns an error when any clock in
> "clocks" is not found and releases (disables again and frees) those
> before it.
> 
> I'm not aware of any case that breaks because of this, but I once saw
> a case of ehci not working and ohci working because one of the listed
> clocks not being found (ehci called clk_get_bulk(),
> clk_enable_blk()).

IMHO, the OHCI should have failed too in this example, instead of
silently ignoring the error. Hopefully it has probed.

The clk_get_bulk() code does a similar job compared to ohci current
code. It counts all clock entries. So, when trying to get them, these
should be found.

Having a clock listed, but it can't be found or taken rather looks like
a real error, that needs to be fixed.
(e.g. missing config for a clk/reset controller ? Or could it be a bug
in such a driver ? Or a miss-configured device-tree ? something else?)
Ignoring such error may be miss-leading (as you pointed out, one was
working).

I hope I don't miss your point. If this is the case, could you point
more precise example, or how it used to fail ?

> In that case, a fix by ignoring the missing clock
> in ehci was rejected, so maybe that criteria applies here as well and
> your patch is deemed correct. I don't know. That case won't break now,
> I think, either with or without your patch, because after another fix,
> that clock will be found.

If I understand correctly, this used to fixed elsewhere (e.g. there used
to be a real bug fixed) ?

> But I don't know if there might be similar
> cases.
> 
> I just wanted to point out the change in behaviour. If the change is
> intended, then all is fine.

IMHO, this should be fine. I hope you agree with this change and the
rationale.

Best Regards,
Fabrice

> 
>> -			err = clk_enable(&priv->clocks[i]);
>> -			if (err && err != -ENOSYS) {
>> -				dev_err(dev, "failed to enable clock %d\n", i);
>> -				clk_free(&priv->clocks[i]);
>> -				goto clk_err;
>> -			}
>> -			priv->clock_count++;
>> -		}
>> -	} else if (clock_nb != -ENOENT) {
>> -		dev_err(dev, "failed to get clock phandle(%d)\n", clock_nb);
>> -		return clock_nb;
>> +	int err, ret;
>> +
>> +	ret = clk_get_bulk(dev, &priv->clocks);
>> +	if (ret && ret != -ENOENT) {
>> +		dev_err(dev, "Failed to get clocks (ret=%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	err = clk_enable_bulk(&priv->clocks);
>> +	if (err) {
>> +		dev_err(dev, "Failed to enable clocks (err=%d)\n", err);
>> +		goto clk_err;
>>  	}
>>  
>> -	priv->reset_count = 0;
>> -	reset_nb = dev_count_phandle_with_args(dev, "resets", "#reset-cells",
>> -					       0);
>> -	if (reset_nb > 0) {
>> -		priv->resets = devm_kcalloc(dev, reset_nb,
>> -					    sizeof(struct reset_ctl),
>> -					    GFP_KERNEL);
>> -		if (!priv->resets)
>> -			return -ENOMEM;
>> -
>> -		for (i = 0; i < reset_nb; i++) {
>> -			err = reset_get_by_index(dev, i, &priv->resets[i]);
>> -			if (err < 0)
>> -				break;
>> -
> 
> Similar here.
> 
>> -			err = reset_deassert(&priv->resets[i]);
>> -			if (err) {
>> -				dev_err(dev, "failed to deassert reset %d\n", i);
>> -				reset_free(&priv->resets[i]);
>> -				goto reset_err;
>> -			}
>> -			priv->reset_count++;
>> -		}
>> -	} else if (reset_nb != -ENOENT) {
>> -		dev_err(dev, "failed to get reset phandle(%d)\n", reset_nb);
>> +	err = reset_get_bulk(dev, &priv->resets);
>> +	if (err && err != -ENOENT) {
>> +		dev_err(dev, "failed to get resets (err=%d)\n", err);
>>  		goto clk_err;
>>  	}
>>  
>> +	err = reset_deassert_bulk(&priv->resets);
>> +	if (err) {
>> +		dev_err(dev, "failed to get deassert resets (err=%d)\n", err);
>> +		goto reset_err;
>> +	}
>> +
>>  	err = generic_setup_phy(dev, &priv->phy, 0);
>>  	if (err)
>>  		goto reset_err;
>> @@ -101,13 +67,13 @@ phy_err:
>>  		dev_err(dev, "failed to shutdown usb phy\n");
>>  
>>  reset_err:
>> -	ret = reset_release_all(priv->resets, priv->reset_count);
>> +	ret = reset_release_bulk(&priv->resets);
>>  	if (ret)
>> -		dev_err(dev, "failed to assert all resets\n");
>> +		dev_err(dev, "failed to release resets (ret=%d)\n", ret);
>>  clk_err:
>> -	ret = clk_release_all(priv->clocks, priv->clock_count);
>> +	ret = clk_release_bulk(&priv->clocks);
>>  	if (ret)
>> -		dev_err(dev, "failed to disable all clocks\n");
>> +		dev_err(dev, "failed to release clocks (ret=%d)\n", ret);
>>  
>>  	return err;
>>  }
>> @@ -125,11 +91,11 @@ static int ohci_usb_remove(struct udevice *dev)
>>  	if (ret)
>>  		return ret;
>>  
>> -	ret = reset_release_all(priv->resets, priv->reset_count);
>> +	ret = reset_release_bulk(&priv->resets);
>>  	if (ret)
>>  		return ret;
>>  
>> -	return clk_release_all(priv->clocks, priv->clock_count);
>> +	return clk_release_bulk(&priv->clocks);
>>  }
>>  
>>  static const struct udevice_id ohci_usb_ids[] = {
>> -- 
>> 2.25.1
>>
