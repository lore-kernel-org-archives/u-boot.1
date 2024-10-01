Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D839CE7D19
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 12:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9FF4891C1;
	Tue,  1 Oct 2024 14:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727784810;
	bh=fCCZ7dARBFU7XWDfqsCpha4LUylyBwIKT4OVKr5SGzc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e2cuGAwe/1Nw3Q+OXMTB3IXGGAjuophtZ29YJDEOct24pzJMtleXCXNG0N2V5hIaw
	 y+XjCSMgrGIUI5tbcVD2cdIEbDV8nfh3FJchtpLkzTI/dj1zW8vGUr6N9NcqRABuOV
	 nZ5HG9BWBUow9szuAE+E6GXzPMtSuWEbT+K7pymDwH4HIIu5BYJ5aNpLgMAbXbyxlh
	 DAdsSa7M3uwVlE8IzqXRv2lW/MHZjnhrkIQ2tOBq5X4senXxTKWIB9iEpYePA+xVWa
	 4TDziZMVj6V+SUDXStE1W/wQcVN6STCKiiu4gMoyQf7r60cOttrPgwnytvbUW6bCi8
	 JBO1tN7MKihaQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1347F891A7;
 Tue,  1 Oct 2024 14:13:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727784808;
 bh=fCCZ7dARBFU7XWDfqsCpha4LUylyBwIKT4OVKr5SGzc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ohzWpNbnMdzimqXxLETK2C8v6Kp3WXJZ22pIDMVQeDl487x+2vRgj6md5O7ZmdUsg
 gd1oomOkHuG8YbTKGfCcFXRBnS/bePg2dRYJFhxcyKVotcDzsUNH0Dm/HTaQItBFZk
 9tXBJQimiqI6i2XnMydCGkMygfo/SUQ8SRObEYAy47Ihkp2V/ERfqCEutePR5NwAnc
 D/76POPF2l6CO1asF+9/7ijqHlY1dT4TrzWiC9gzyXkvScayHoZLFiAfyN5N3wXkmC
 /9a0+v7EYqxSaCjJn9O1bu+mjNrTJ5EO/pp9EcENlLk+u1ueeLK/62Cakd5QrXS3tm
 DM9tKOTzDF5dQ==
Message-ID: <98b7166d-48da-4643-9479-93a5577978e1@denx.de>
Date: Tue, 1 Oct 2024 14:07:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "fabrice.gasnier@foss.st.com" <fabrice.gasnier@foss.st.com>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
 <20240927070137.21816-6-venkatesh.abbarapu@amd.com>
 <1bba9e4b-621c-4b94-befe-a3eb468a8b3d@denx.de>
 <SA1PR12MB8697F80C18E42BB7140AFE4098772@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SA1PR12MB8697F80C18E42BB7140AFE4098772@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/1/24 7:20 AM, Abbarapu, Venkatesh wrote:
> Hi Marek,
> 
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Saturday, September 28, 2024 2:12 AM
>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.de
>> Cc: Simek, Michal <michal.simek@amd.com>; fabrice.gasnier@foss.st.com; git
>> (AMD-Xilinx) <git@amd.com>
>> Subject: Re: [PATCH v2 5/7] usb: onboard-hub: Bail out if peer hub is already probed
>>
>> On 9/27/24 9:01 AM, Venkatesh Yadav Abbarapu wrote:
>>> The .bind function is implemented to bind the correct "half" of the
>>> hub that the driver wants to bind, and returning -ENODEV for the other
>>> "half".
>>>
>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>> ---
>>>    common/usb_onboard_hub.c | 20 ++++++++++++++++++++
>>>    1 file changed, 20 insertions(+)
>>>
>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c index
>>> 00808ed45e..9c50ca09c9 100644
>>> --- a/common/usb_onboard_hub.c
>>> +++ b/common/usb_onboard_hub.c
>>> @@ -162,6 +162,25 @@ err:
>>>    	return ret;
>>>    }
>>>
>>> +static int usb_onboard_hub_bind(struct udevice *dev) {
>>> +	struct ofnode_phandle_args phandle;
>>> +	const void *fdt = gd->fdt_blob;
>>> +	int ret, off;
>>> +
>>> +	if (dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0,
>>> +&phandle)) {
>>
>> Return the error code:
>>
>> ret = dev_read_phandle_with_args()
>> if (ret) {
>> ...
>> return ret;
>> }
>>
>>> +		dev_err(dev, "peer-hub not specified\n");
>>> +		return -ENOENT;
>>> +	}
>>> +
>>> +	off = ofnode_to_offset(phandle.node);
>>> +	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
>>
>> return fdt_node_check_compatible(...);
> The return value of fdt_node_check_compatible is "0" in success case and "1" in failure.

There is more:

scripts/dtc/libfdt/libfdt.h

  982  * returns:
  983  *      0, if the node has a 'compatible' property listing the 
given string
  984  *      1, if the node has a 'compatible' property, but it does 
not list
  985  *              the given string
  986  *      -FDT_ERR_NOTFOUND, if the given node has no 'compatible' 
property
  987  *      -FDT_ERR_BADOFFSET, if nodeoffset does not refer to a 
BEGIN_NODE tag
  988  *      -FDT_ERR_BADMAGIC,
  989  *      -FDT_ERR_BADVERSION,
  990  *      -FDT_ERR_BADSTATE,
  991  *      -FDT_ERR_BADSTRUCTURE, standard meanings

> I can't return fdt_node_check_compatible() directly as need to return -ENODEV for other half of the hub.
OK
