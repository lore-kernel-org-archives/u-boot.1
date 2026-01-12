Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E00DD25041
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 16:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9B683693;
	Mon, 12 Jan 2026 17:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ViLRc4Gx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E8183759; Mon, 12 Jan 2026 17:35:47 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B9B835FD
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 17:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-64d02c01865so11317543a12.1
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 08:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768235745; x=1768840545; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tprqadmj00IGm62dT8sU/lJ9eDDiNoimqorNI09EpG0=;
 b=ViLRc4Gxb0law1qOx0IccvYedWAvVo3VxEM+2rZ2/K3rYnDvnJ8TXW63KD20wVln+/
 fb4x7H+fssEcxunCGDMXMG4H0tzlwIX1ql81GYJ6x9d/dd7+8JrR90MbLuI48rn9lvmk
 X/IttqqkQL7paptNhsXAwIwjqsHha/mrV2sWhJiZEyHNsYTxcyjruwL2nNHmrA8yOD3O
 +FQfBDWuvEt/q/C0trahZNYVy+byBmPrp9Cw8c7j+iwqLOzIGBWDDLf5cyGlKjefRaos
 apui2Tim5TxajZwRFOG5EDjDij0Lhe8r2wYAhLV4mPYgLAy38v6SCnmsRC54fe13wrqc
 tWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768235745; x=1768840545;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tprqadmj00IGm62dT8sU/lJ9eDDiNoimqorNI09EpG0=;
 b=E0w8pzlgd7DCNuRWnc3Vx3of6wJWfb/UzTp34kPrjlGwwgL0OhkewsmsEA6ejwT9PC
 ZKp290inPRzDSVQ9I487aoHULmWoOpsHTrj9Xz8bsM9XBmC5mtTT8goPmVK+6rT3nHqr
 WfP5sBGYYVliyFbgmyEz5ouwP9AJFOrmOeIWJQXEh+CMiRpyPEPIHFLFgyTAiTyydQvb
 wsc4xE1A2XXPSXOxqghEg763fHLGaZa9AmUsCyOTQ1JHASIGWJ8TxNHSvrxFyLRUj5JZ
 GR+DKyRp77hVggqeRYp1BqDp8rjnhunM919IM+roZWf4n/rqAihU6ualH7cp0ixFPg2i
 fP0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9/LJlAkiUjvzj2fcZoQQdFsZJ0RwpIot7wUSs/Mpx6t6rRaZlEPYUGrqaEd3rdEtx4K0foy8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5T7O/ADSczD/Nezs1OKEQGgrpov5uya+FUJEuU+XuEWd9/Tpp
 Im9KDaxDcluotMLTVRYik4Ltvz3PSYZJmR9/hobJF1iF3FM4lV5bAHN5Fr5hX0smQ+U=
X-Gm-Gg: AY/fxX6r8nx3TGOw/h1jpypa3InWzNX+DhQbBdrM/MlBdMD1du+Q6jfZz/DVeiS/Hsl
 8j3LP+BAKmPz+jJLhBU6WSACd0mffUX31av0oW/XE1wthKLOoB219SAW8lOLaBbtQqwnCZV58aF
 EUHUh35h8I719+3HJDX5BAVUZlF74iT9X2cdtRBCvgh1Hvd/BDH2rW1kjWYSmc6GxwezQ6YHTgT
 cHPcdsz8iG8sgQHj0n9t5MPA+aFiZ5bspDs4970lnvj4UTXrMccSU/bW8+hk467/NqSa0iW61Ud
 ns/WU7FWOVJYo93itMO6nWpyJzsJg2CYMQdvh/lkzruI93kYUVZEETJuOVz1oTsi7xuROHQkN4q
 /FFf/c5LWdGv5qEPW0nPyZO2zwgG54nH3pLAlYB4v7q7YjJYsX559oJtZ3sVRzGvOz38Q5+GGCw
 KuUDoXLsS+Pc9PTjlCwMlGgYasRu9MzDKbrN24ZoliPXOd/4u8IfOqvpV1SHebeQ==
X-Google-Smtp-Source: AGHT+IFJAH9ITg0ztlHTAhC6fzXGbWy7zBPRPo8LTnyMDnDRoc3NRhuyyWsZjqSuMnKdQF3FmWZBXA==
X-Received: by 2002:a17:907:1b05:b0:b80:fa9:674 with SMTP id
 a640c23a62f3a-b84451f39c6mr2074731566b.54.1768235744800; 
 Mon, 12 Jan 2026 08:35:44 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a56c552sm1978139666b.68.2026.01.12.08.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 08:35:44 -0800 (PST)
Message-ID: <8c36d979-a793-422d-ae29-427f2377d708@linaro.org>
Date: Mon, 12 Jan 2026 17:35:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] smem: msm: Fix memory-region lookup, direct <reg>
 mapping and update SMEM host count
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20251112165851.1561418-1-aswin.murugan@oss.qualcomm.com>
 <aU5onLOBb3f62VVB@sumit-xelite>
 <55ebb69a-b9a9-4140-bf28-eb3788f7ac9c@linaro.org>
In-Reply-To: <55ebb69a-b9a9-4140-bf28-eb3788f7ac9c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 08/01/2026 21:41, Casey Connolly wrote:
> 
> 
> On 26/12/2025 11:51, Sumit Garg wrote:
>> On Wed, Nov 12, 2025 at 10:28:51PM +0530, Aswin Murugan wrote:
>>> The SMEM driver was failing to resolve memory regions on some boards
>>> because `dev_of_offset()` + `fdtdec_lookup_phandle()` did not yield a
>>> valid DT node. Modernize the code to use driver-model/ofnode accessors
>>> and make the probe robust for both DT styles (direct `reg` vs
>>> `memory-region` phandle).
>>>
>>> - qcom_smem_map_memory():
>>>   * Drop fdtdec path; use dev_read_phandle_with_args() +
>>>     ofnode_read_resource().
>>>   * Use dev_read_phandle_with_args() +
>>>     fnode_read_resource().
>>>
>>> - qcom_smem_probe():
>>>   * Try dev_read_addr_size() first (map via <reg>), else fall back to
>>>     qcom_smem_map_memory() with "memory-region".
>>>   * Check "qcom,rpm-msg-ram" presence to add second region.
>>>
>>> - Additionally, SMEM_HOST_COUNT is increased to support newer SMEM
>>>   versions that include more remote processors. This avoids failures
>>>   during processor ID checks.
>>>
>>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>>> ---
>>>  drivers/smem/msm_smem.c | 56 +++++++++++++++++++++++++++++------------
>>>  1 file changed, 40 insertions(+), 16 deletions(-)
>>
>> There was an earlier effort from Casey to import SMEM driver here [1]
>> from Linux kernel. But unfortunately that patch-set didn't got reworked
>> to make into U-Boot mainline.

I'll pick this fix up for now, but hopefully we can drop this old crummy
driver soon :D

Thanks,

>>
>> Casey, do you have any plans to respin the patch-set? Or it's fine for
>> others to take over that patch-set?
> 
> If any of you guys would be willing to take it over that would be a huge
> help! I'm not sure when I'd get around to it myself. I'm very much
> looking forward to getting the memory map from smem at long last :D
> 
> I'd appreciate it if you could fixup the authorship/sob on my old
> patches if you do resend them.
> 
> Thanks and kind regards,
>>
>> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=433987&state=*
>>
>> -Sumit
>>
>>>
>>> diff --git a/drivers/smem/msm_smem.c b/drivers/smem/msm_smem.c
>>> index ccd145f9afb..b6b92d3530d 100644
>>> --- a/drivers/smem/msm_smem.c
>>> +++ b/drivers/smem/msm_smem.c
>>> @@ -88,7 +88,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>>  #define SMEM_GLOBAL_HOST	0xfffe
>>>  
>>>  /* Max number of processors/hosts in a system */
>>> -#define SMEM_HOST_COUNT		10
>>> +#define SMEM_HOST_COUNT		25
>>>  
>>>  /**
>>>   * struct smem_proc_comm - proc_comm communication struct (legacy)
>>> @@ -821,23 +821,34 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
>>>  static int qcom_smem_map_memory(struct qcom_smem *smem, struct udevice *dev,
>>>  				const char *name, int i)
>>>  {
>>> -	struct fdt_resource r;
>>>  	int ret;
>>> -	int node = dev_of_offset(dev);
>>> +	struct ofnode_phandle_args args;
>>> +	struct resource r;
>>>  
>>> -	ret = fdtdec_lookup_phandle(gd->fdt_blob, node, name);
>>> -	if (ret < 0) {
>>> -		dev_err(dev, "No %s specified\n", name);
>>> +	if (!dev_read_prop(dev, name, NULL)) {
>>> +		dev_err(dev, "%s prop not found\n", name);
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> -	ret = fdt_get_resource(gd->fdt_blob, ret, "reg", 0, &r);
>>> -	if (ret)
>>> -		return ret;
>>> +	ret = dev_read_phandle_with_args(dev, name, NULL, 0, 0, &args);
>>> +	if (ret) {
>>> +		dev_err(dev, "%s phandle read failed\n", name);
>>> +		return -EINVAL;
>>> +	}
>>>  
>>> +	if (!ofnode_valid(args.node)) {
>>> +		dev_err(dev, "Invalid node from phandle args\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ret = ofnode_read_resource(args.node, 0, &r);
>>> +	if (ret) {
>>> +		dev_err(dev, "Can't get mmap base address(%d)\n", ret);
>>> +		return ret;
>>> +	}
>>>  	smem->regions[i].aux_base = (u32)r.start;
>>> -	smem->regions[i].size = fdt_resource_size(&r);
>>> -	smem->regions[i].virt_base = devm_ioremap(dev, r.start, fdt_resource_size(&r));
>>> +	smem->regions[i].size = resource_size(&r);
>>> +	smem->regions[i].virt_base = devm_ioremap(dev, r.start, resource_size(&r));
>>>  	if (!smem->regions[i].virt_base)
>>>  		return -ENOMEM;
>>>  
>>> @@ -852,10 +863,14 @@ static int qcom_smem_probe(struct udevice *dev)
>>>  	int num_regions;
>>>  	u32 version;
>>>  	int ret;
>>> -	int node = dev_of_offset(dev);
>>> +	fdt_addr_t addr;
>>> +	fdt_size_t size;
>>> +
>>> +	if (__smem)
>>> +		return 0;
>>>  
>>>  	num_regions = 1;
>>> -	if (fdtdec_lookup_phandle(gd->fdt_blob, node, "qcomrpm-msg-ram") >= 0)
>>> +	if (dev_read_prop(dev, "qcom,rpm-msg-ram", NULL))
>>>  		num_regions++;
>>>  
>>>  	array_size = num_regions * sizeof(struct smem_region);
>>> @@ -866,9 +881,18 @@ static int qcom_smem_probe(struct udevice *dev)
>>>  	smem->dev = dev;
>>>  	smem->num_regions = num_regions;
>>>  
>>> -	ret = qcom_smem_map_memory(smem, dev, "memory-region", 0);
>>> -	if (ret)
>>> -		return ret;
>>> +	addr = dev_read_addr_size(dev, &size);
>>> +	if (addr == FDT_ADDR_T_NONE) {
>>> +		ret = qcom_smem_map_memory(smem, dev, "memory-region", 0);
>>> +		if (ret)
>>> +			return ret;
>>> +	} else {
>>> +		smem->regions[0].aux_base = (u32)addr;
>>> +		smem->regions[0].size = size;
>>> +		smem->regions[0].virt_base = devm_ioremap(dev, addr, size);
>>> +		if (!smem->regions[0].virt_base)
>>> +			return -ENOMEM;
>>> +	}
>>>  
>>>  	if (num_regions > 1) {
>>>  		ret = qcom_smem_map_memory(smem, dev,
>>> -- 
>>> 2.34.1
>>>
> 

-- 
// Casey (she/her)

