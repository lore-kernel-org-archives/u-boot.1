Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7798CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 12:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A0B3868B1;
	Fri,  1 Sep 2023 14:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="6KxeLcRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0B8F86886; Fri,  1 Sep 2023 14:05:08 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EBEF868BB
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 14:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76082d487b=fabrice.gasnier@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 381Bocia005077; Fri, 1 Sep 2023 14:05:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=+v99ALnlUe6ZYUQKOD3Ng50z461MtT4A61BM9WVUAUQ=; b=6K
 xeLcRnvoRx2S2IG/DuhNPesuVGSWe59PZWyhRGW11wYFnk7yQSWDXSy20HwvETa9
 XbMthwdhgCMx5CtCW8zhy/zvf266wwtUK75vH3amfSson782YLsUvdLA/4eYDVg7
 JXeUXNp6+Ncgt7Q401FGA0HvkR4ROBOuLyRCxvolxm3lSr+JRngj2pmQ/S5G9wQg
 5Q4Y33R45emQVEccMhicupX/zowTh4RhU7tcjKIef3+3ajNcbgDfwyeoZstLWG6r
 3h1NDFsN+mp9LVJTPyV7Mo9GHpDBe/rccI+tsvQzskK6FDTW4o5XPYk4K510wy3C
 DVjR3baYqdDsEB8GasnQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sqvbhradf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 14:05:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CBC0D100058;
 Fri,  1 Sep 2023 14:05:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A250D2291BB;
 Fri,  1 Sep 2023 14:05:04 +0200 (CEST)
Received: from [10.201.22.39] (10.201.22.39) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 1 Sep
 2023 14:05:04 +0200
Message-ID: <2e1cf0cd-1d98-16fe-97e8-96604bbb009c@foss.st.com>
Date: Fri, 1 Sep 2023 14:05:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: host: ohci-generic: Make usage of clock/reset bulk()
 API
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>
References: <20230830080150.473374-1-fabrice.gasnier@foss.st.com>
 <84041468-abf2-9b68-6701-6605f4948bf5@denx.de>
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <84041468-abf2-9b68-6701-6605f4948bf5@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.22.39]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_10,2023-08-31_01,2023-05-22_02
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

On 8/30/23 17:18, Marek Vasut wrote:
> On 8/30/23 10:01, Fabrice Gasnier wrote:
>> Make usage of clock and reset bulk API in order to simplify the code
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>>
>>   drivers/usb/host/ohci-generic.c | 92 +++++++++++----------------------
>>   1 file changed, 29 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/usb/host/ohci-generic.c
>> b/drivers/usb/host/ohci-generic.c
>> index 2d8d38ce9a40..95aa608d8c19 100644
>> --- a/drivers/usb/host/ohci-generic.c
>> +++ b/drivers/usb/host/ohci-generic.c
>> @@ -16,75 +16,41 @@
>>     struct generic_ohci {
>>       ohci_t ohci;
>> -    struct clk *clocks;    /* clock list */
>> -    struct reset_ctl *resets; /* reset list */
>> +    struct clk_bulk clocks;    /* clock list */
>> +    struct reset_ctl_bulk resets; /* reset list */
>>       struct phy phy;
>> -    int clock_count;    /* number of clock in clock list */
>> -    int reset_count;    /* number of reset in reset list */
>>   };
>>     static int ohci_usb_probe(struct udevice *dev)
>>   {
>>       struct ohci_regs *regs = dev_read_addr_ptr(dev);
>>       struct generic_ohci *priv = dev_get_priv(dev);
>> -    int i, err, ret, clock_nb, reset_nb;
>> -
>> -    err = 0;
>> -    priv->clock_count = 0;
>> -    clock_nb = dev_count_phandle_with_args(dev, "clocks",
>> "#clock-cells",
>> -                           0);
>> -    if (clock_nb > 0) {
>> -        priv->clocks = devm_kcalloc(dev, clock_nb, sizeof(struct clk),
>> -                        GFP_KERNEL);
>> -        if (!priv->clocks)
>> -            return -ENOMEM;
>> -
>> -        for (i = 0; i < clock_nb; i++) {
>> -            err = clk_get_by_index(dev, i, &priv->clocks[i]);
>> -            if (err < 0)
>> -                break;
>> -
>> -            err = clk_enable(&priv->clocks[i]);
>> -            if (err && err != -ENOSYS) {
>> -                dev_err(dev, "failed to enable clock %d\n", i);
>> -                clk_free(&priv->clocks[i]);
>> -                goto clk_err;
>> -            }
>> -            priv->clock_count++;
>> -        }
>> -    } else if (clock_nb != -ENOENT) {
>> -        dev_err(dev, "failed to get clock phandle(%d)\n", clock_nb);
>> -        return clock_nb;
>> +    int err, ret;
>> +
>> +    ret = clk_get_bulk(dev, &priv->clocks);
>> +    if (ret && ret != -ENOENT) {
>> +        dev_err(dev, "Failed to get clocks (ret=%d)\n", ret);
> 
> Plural of 'clock' is still 'clock' , please fix just the text, keep the
> variable name .

Hi Marek,

Are you sure ? Taking a closer look on the web, also in Linux or u-boot,
I can see plural of clock is clocks. Documentation also deals with
multiple clocks too.

> 
>> +        return ret;
>> +    }
>> +
>> +    err = clk_enable_bulk(&priv->clocks);
>> +    if (err) {
>> +        dev_err(dev, "Failed to enable clocks (err=%d)\n", err);
> 
> DTTO here
> 
>> +        goto clk_err;
>>       }
>>   -    priv->reset_count = 0;
>> -    reset_nb = dev_count_phandle_with_args(dev, "resets",
>> "#reset-cells",
>> -                           0);
>> -    if (reset_nb > 0) {
>> -        priv->resets = devm_kcalloc(dev, reset_nb,
>> -                        sizeof(struct reset_ctl),
>> -                        GFP_KERNEL);
>> -        if (!priv->resets)
>> -            return -ENOMEM;
>> -
>> -        for (i = 0; i < reset_nb; i++) {
>> -            err = reset_get_by_index(dev, i, &priv->resets[i]);
>> -            if (err < 0)
>> -                break;
>> -
>> -            err = reset_deassert(&priv->resets[i]);
>> -            if (err) {
>> -                dev_err(dev, "failed to deassert reset %d\n", i);
>> -                reset_free(&priv->resets[i]);
>> -                goto reset_err;
>> -            }
>> -            priv->reset_count++;
>> -        }
>> -    } else if (reset_nb != -ENOENT) {
>> -        dev_err(dev, "failed to get reset phandle(%d)\n", reset_nb);
>> +    err = reset_get_bulk(dev, &priv->resets);
>> +    if (err && err != -ENOENT) {
>> +        dev_err(dev, "failed to get resets (err=%d)\n", err);
>>           goto clk_err;
>>       }
>>   +    err = reset_deassert_bulk(&priv->resets);
>> +    if (err) {
>> +        dev_err(dev, "failed to get deassert resets (err=%d)\n", err);
> 
> Drop the 'get' from the text here, I think it's copy-paste error.

ack, will update in v2

> 
>> +        goto reset_err;
>> +    }
>> +
>>       err = generic_setup_phy(dev, &priv->phy, 0);
>>       if (err)
>>           goto reset_err;
> 
> With that fixed:
> 
> Reviewed-by: Marek Vasut <marex@denx.de>

Thanks, will add in v2.
BR,
Fabrice

> 
> Nice cleanup, thanks !
