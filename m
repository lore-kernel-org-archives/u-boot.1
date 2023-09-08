Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B38EE14C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 03:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE1298643D;
	Fri,  8 Sep 2023 05:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GnKeA7NV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1E1A8477A; Fri,  8 Sep 2023 05:34:39 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7692B8643D
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 05:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3883YWfU002547;
 Thu, 7 Sep 2023 22:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694144072;
 bh=P5iAGNHuBMKrY1ozLgWoKUxviaksfPJl4gOifGBh9yc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=GnKeA7NVgKxBOgIXB2Nmp9MkHmISWeD/dXR8uolfllDpdfxq1ABhDFw3O1y5GwAfo
 P69vnmnpMhd96gxUn4F3TbwoV2hwSHcJyXOiKk2q1mZvSWBCyHi1vRzR2B7Hmhkkjb
 h5kg72KS679IVfoi2SXuvAI4dEzFHmZBRaZQ23uY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3883YWnO076772
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Sep 2023 22:34:32 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 22:34:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 22:34:32 -0500
Received: from [10.24.68.114] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3883YRMd020564;
 Thu, 7 Sep 2023 22:34:28 -0500
Message-ID: <feeb284f-c9dc-1565-8ad6-283fdf02344e@ti.com>
Date: Fri, 8 Sep 2023 09:04:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/7] drivers: firmware: ti_sci: Get SCI revision only
 if TIFS/SYSFW is up
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>
References: <20230907141407.382215-1-n-francis@ti.com>
 <20230907141407.382215-5-n-francis@ti.com>
 <20230907150516.v3tsushxhcucmmsl@undergrad>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230907150516.v3tsushxhcucmmsl@undergrad>
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

Hi Nishanth

On 07/09/23 20:35, Nishanth Menon wrote:
> On 19:44-20230907, Neha Malcom Francis wrote:
>> While setting up necessary dependent clocks and power domains, we end up
>> probing the ti_sci driver before TIFS/SYSFW has been loaded in the case
>> of legacy boot flow devices. This leads to panic when getting the SCI
>> revision. Return the revision only if it is combined boot flow. Also
> 
> Not clear description of the problem.

Hmm okay I will modify this and the earlier commit message to give a clearer 
picture.

> 
>> ensure that after TIFS/SYSFW comes up we run ti_sci_cmd_get_revision
>> again so we print the revision right.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   drivers/firmware/ti_sci.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>> index 72f572d824..6a85d202f2 100644
>> --- a/drivers/firmware/ti_sci.c
>> +++ b/drivers/firmware/ti_sci.c
>> @@ -2703,6 +2703,9 @@ struct ti_sci_handle *ti_sci_get_handle_from_sysfw(struct udevice *sci_dev)
>>   	if (!handle)
>>   		return ERR_PTR(-EINVAL);
>>   
>> +	/* May have been skipped in case TIFS/SYSFW had come up later */
> Very confusing comment.
> 

Understood, will change that.

>> +	ti_sci_cmd_get_revision(handle);
> 
> should this be protected with if (IS_ENABLED(CONFIG_K3_DM_FW) ?
> 
> Since getting the handle is where the entire flow happens, why not do it
> here always?
> 

This is a valid point, I am in the process of making sure there's no other 
consequences to getting the revision this late for platforms with other boot 
devices, if this gets an all clear, I will push it here for the next version, 
else I will explain why I couldn't.

> what if ti_sci_cmd_get_revision fails? there is no error handling here.

Yes that would be a consequence since ti_sci_probe, the logic it was written; 
used reading the version as an "all okay return 0" for the TIFS/SYSFW binary.

But now after moving, ti_sci_get_handle_from_sysfw happens after k3_sysfw_loader 
so we're not checking binary sanity early on in the case of combined boot

I'm hesitant that we are checking version way later after k3_sysfw_loader for 
combined platforms and if that is something we want? But there is an 
advantage(?) that it will run every time someone tries to get a handle for doing 
anything with TISCI and that would be a kind of check (?) if the binary is good? 
Correct me if I'm wrong in thinking that.

>> +
>>   	return handle;
>>   }
>>   
>> @@ -2825,7 +2828,11 @@ static int ti_sci_probe(struct udevice *dev)
>>   	list_add_tail(&info->list, &ti_sci_list);
>>   	ti_sci_setup_ops(info);
>>   
>> -	ret = ti_sci_cmd_get_revision(&info->handle);
>> +	/* Get SCI revision ONLY if we are real */
>> +	if (!IS_ENABLED(CONFIG_K3_DM_FW))
>> +		ret = ti_sci_cmd_get_revision(&info->handle);
>> +	else
>> +		ret = 0;
>>   
>>   	INIT_LIST_HEAD(&info->dev_list);
>>   
>> -- 
>> 2.34.1
>>
> 

-- 
Thanking You
Neha Malcom Francis
