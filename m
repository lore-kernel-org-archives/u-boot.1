Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35C3D1D48A
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2AD842DB;
	Thu,  8 Jan 2026 21:41:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="No3uXmMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A27842E1; Thu,  8 Jan 2026 21:41:39 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C18841DA
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b8010b8f078so578094666b.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 12:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904896; x=1768509696; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ev/tK0Ajjt1DkJM2yaa7ioQCt4rKazJlWoDKU6Ax9Xg=;
 b=No3uXmMZxKhY47gOk6lIsC5lu3lHRSlebYsQ7ffZBSDj0fxQLbgMry+tcGP4XSH42v
 iQAK3vfWkVoEFNCaWkzrXxxeDKmhO1OMH8+QnBRY0hWhqVB1/o7YB+s060arC0wqIjLm
 HUaSg9k8MBObAN9aJs/LCOvyyPWZQF4bwUxEt1CeVA+GeV2z153pNdrttCRe8g/X/vo1
 gmScLy5iuGJur3WHN5gcTuzgTwil24lTos8WhjD6NRkm+Thd3BFBvjg/M3zaGPmkBOBB
 0resL8WTqzjamPo5I1EUimfN0K2g+wMc/0rYGTPqOBLwcf1R/Afgwqkh+iUSLijXTMET
 t7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904896; x=1768509696;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ev/tK0Ajjt1DkJM2yaa7ioQCt4rKazJlWoDKU6Ax9Xg=;
 b=F+o1conizuK1i+pC1GS1gP8+wm/JHzHDfMXuvRNqSTdpMrslLPImArUItM6ZNL6uCG
 oL6lPghloK94gwLHGsi1IiWZUt1kDBJvUf5rr3Z9Tu9RB2Mu9GobarCD7eDyK17DY0Uy
 lemafgnDgGE2q2dqh6XZey8AKebZfM7X+HbaB+8ehRFguGPMwuD8vDRR7FbJTXtYI5MK
 CTJTY5rLLQWw/eQuCQ7p0vBit/weSKsMwajUONFbHhG/9JgO7QBNZrz8EJI3i6ZVQqSM
 ljZdLSqYXfoXMmi+r3vz9E/JCZ5Ds3uAOy56mbjUnDTj19MXi8VAZvZ+fjIOQtuzG+tI
 8KzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAF9aACGwDCR9coseX7UyVfk1grc+9SM+aRt7Y0Cx4pErjoDFIgFDXHdyRxbok8ZknPaStHrE=@lists.denx.de
X-Gm-Message-State: AOJu0YzjGRCL9x6fF8MX5VD9jWCr09LdEqDhuj7ZJTmP9nZKAKlnYCtn
 SX9MYffs1H+EN9k3SGBasUQJAk0BihMXW2x2jtgSZ9fOnpeIW/mGAG9lIQYl3sl6djU=
X-Gm-Gg: AY/fxX61chWZ5B/pHutjkV3DYqAhdx9gpssYq4y4O0wf89zllMSjDinW75UrkP5bgJI
 HnNqEMfCCHKr+ylpomU9N71dQCorof7OJw3sE8lfxUOxRr++Z/RxWm+qfVwx4Ni35ncXR25V2yO
 QVwl1PbnQUKkqI1/i/IMowq7pxc0oEerILQ1EHhci+SAQsOox/Kv+A5idgpFdHpt1suYRbpErZ1
 eNzfnofDGAhuvigM5z0ijuEHpGr887fYi3IAxS7ddGs0pvWmT+3ZQZK9ZmYcpJy0Iit2/o8z09l
 ZdTQS7kE+H/lF3KkRXQCMUkD1ZApBxWoNFwV+3iI+e+HAIUCzkOLtkXPvTlOG91MFxPsc1PPtDv
 GfY6Sr4/iKMkQvudCE6Xk/HreTLFkg/wynbhrb/nd6CEdOeb8saH+yW9B8dgJl/43LgkhEo9WeR
 wHiWpFnY9YvC4f99tPlMR9MGabEy09mGeolkUSlp2L6GBKu62mPZk=
X-Google-Smtp-Source: AGHT+IEsY3bDnX7ARe0Nj7kh8GE04QoxJ5zdCwIx4PRvdmUzKE5WbVHIyOKPapjGkEhKyjWpsv2jYQ==
X-Received: by 2002:a17:907:728f:b0:b72:56ad:c9c0 with SMTP id
 a640c23a62f3a-b8444dc4839mr696131666b.17.1767904895923; 
 Thu, 08 Jan 2026 12:41:35 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4d311esm894015766b.38.2026.01.08.12.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:41:35 -0800 (PST)
Message-ID: <55ebb69a-b9a9-4140-bf28-eb3788f7ac9c@linaro.org>
Date: Thu, 8 Jan 2026 21:41:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] smem: msm: Fix memory-region lookup, direct <reg>
 mapping and update SMEM host count
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20251112165851.1561418-1-aswin.murugan@oss.qualcomm.com>
 <aU5onLOBb3f62VVB@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aU5onLOBb3f62VVB@sumit-xelite>
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



On 26/12/2025 11:51, Sumit Garg wrote:
> On Wed, Nov 12, 2025 at 10:28:51PM +0530, Aswin Murugan wrote:
>> The SMEM driver was failing to resolve memory regions on some boards
>> because `dev_of_offset()` + `fdtdec_lookup_phandle()` did not yield a
>> valid DT node. Modernize the code to use driver-model/ofnode accessors
>> and make the probe robust for both DT styles (direct `reg` vs
>> `memory-region` phandle).
>>
>> - qcom_smem_map_memory():
>>   * Drop fdtdec path; use dev_read_phandle_with_args() +
>>     ofnode_read_resource().
>>   * Use dev_read_phandle_with_args() +
>>     fnode_read_resource().
>>
>> - qcom_smem_probe():
>>   * Try dev_read_addr_size() first (map via <reg>), else fall back to
>>     qcom_smem_map_memory() with "memory-region".
>>   * Check "qcom,rpm-msg-ram" presence to add second region.
>>
>> - Additionally, SMEM_HOST_COUNT is increased to support newer SMEM
>>   versions that include more remote processors. This avoids failures
>>   during processor ID checks.
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>>  drivers/smem/msm_smem.c | 56 +++++++++++++++++++++++++++++------------
>>  1 file changed, 40 insertions(+), 16 deletions(-)
> 
> There was an earlier effort from Casey to import SMEM driver here [1]
> from Linux kernel. But unfortunately that patch-set didn't got reworked
> to make into U-Boot mainline.
> 
> Casey, do you have any plans to respin the patch-set? Or it's fine for
> others to take over that patch-set?

If any of you guys would be willing to take it over that would be a huge
help! I'm not sure when I'd get around to it myself. I'm very much
looking forward to getting the memory map from smem at long last :D

I'd appreciate it if you could fixup the authorship/sob on my old
patches if you do resend them.

Thanks and kind regards,
> 
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=433987&state=*
> 
> -Sumit
> 
>>
>> diff --git a/drivers/smem/msm_smem.c b/drivers/smem/msm_smem.c
>> index ccd145f9afb..b6b92d3530d 100644
>> --- a/drivers/smem/msm_smem.c
>> +++ b/drivers/smem/msm_smem.c
>> @@ -88,7 +88,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>  #define SMEM_GLOBAL_HOST	0xfffe
>>  
>>  /* Max number of processors/hosts in a system */
>> -#define SMEM_HOST_COUNT		10
>> +#define SMEM_HOST_COUNT		25
>>  
>>  /**
>>   * struct smem_proc_comm - proc_comm communication struct (legacy)
>> @@ -821,23 +821,34 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
>>  static int qcom_smem_map_memory(struct qcom_smem *smem, struct udevice *dev,
>>  				const char *name, int i)
>>  {
>> -	struct fdt_resource r;
>>  	int ret;
>> -	int node = dev_of_offset(dev);
>> +	struct ofnode_phandle_args args;
>> +	struct resource r;
>>  
>> -	ret = fdtdec_lookup_phandle(gd->fdt_blob, node, name);
>> -	if (ret < 0) {
>> -		dev_err(dev, "No %s specified\n", name);
>> +	if (!dev_read_prop(dev, name, NULL)) {
>> +		dev_err(dev, "%s prop not found\n", name);
>>  		return -EINVAL;
>>  	}
>>  
>> -	ret = fdt_get_resource(gd->fdt_blob, ret, "reg", 0, &r);
>> -	if (ret)
>> -		return ret;
>> +	ret = dev_read_phandle_with_args(dev, name, NULL, 0, 0, &args);
>> +	if (ret) {
>> +		dev_err(dev, "%s phandle read failed\n", name);
>> +		return -EINVAL;
>> +	}
>>  
>> +	if (!ofnode_valid(args.node)) {
>> +		dev_err(dev, "Invalid node from phandle args\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = ofnode_read_resource(args.node, 0, &r);
>> +	if (ret) {
>> +		dev_err(dev, "Can't get mmap base address(%d)\n", ret);
>> +		return ret;
>> +	}
>>  	smem->regions[i].aux_base = (u32)r.start;
>> -	smem->regions[i].size = fdt_resource_size(&r);
>> -	smem->regions[i].virt_base = devm_ioremap(dev, r.start, fdt_resource_size(&r));
>> +	smem->regions[i].size = resource_size(&r);
>> +	smem->regions[i].virt_base = devm_ioremap(dev, r.start, resource_size(&r));
>>  	if (!smem->regions[i].virt_base)
>>  		return -ENOMEM;
>>  
>> @@ -852,10 +863,14 @@ static int qcom_smem_probe(struct udevice *dev)
>>  	int num_regions;
>>  	u32 version;
>>  	int ret;
>> -	int node = dev_of_offset(dev);
>> +	fdt_addr_t addr;
>> +	fdt_size_t size;
>> +
>> +	if (__smem)
>> +		return 0;
>>  
>>  	num_regions = 1;
>> -	if (fdtdec_lookup_phandle(gd->fdt_blob, node, "qcomrpm-msg-ram") >= 0)
>> +	if (dev_read_prop(dev, "qcom,rpm-msg-ram", NULL))
>>  		num_regions++;
>>  
>>  	array_size = num_regions * sizeof(struct smem_region);
>> @@ -866,9 +881,18 @@ static int qcom_smem_probe(struct udevice *dev)
>>  	smem->dev = dev;
>>  	smem->num_regions = num_regions;
>>  
>> -	ret = qcom_smem_map_memory(smem, dev, "memory-region", 0);
>> -	if (ret)
>> -		return ret;
>> +	addr = dev_read_addr_size(dev, &size);
>> +	if (addr == FDT_ADDR_T_NONE) {
>> +		ret = qcom_smem_map_memory(smem, dev, "memory-region", 0);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		smem->regions[0].aux_base = (u32)addr;
>> +		smem->regions[0].size = size;
>> +		smem->regions[0].virt_base = devm_ioremap(dev, addr, size);
>> +		if (!smem->regions[0].virt_base)
>> +			return -ENOMEM;
>> +	}
>>  
>>  	if (num_regions > 1) {
>>  		ret = qcom_smem_map_memory(smem, dev,
>> -- 
>> 2.34.1
>>

-- 
// Casey (she/her)

