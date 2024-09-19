Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC52CE8D78
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 11:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E21688C2E;
	Thu, 19 Sep 2024 13:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sc4GpT0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB25388C3E; Thu, 19 Sep 2024 13:47:52 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF84988966
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 13:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-378e5d4a80eso561922f8f.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726746470; x=1727351270; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=xSDnB2xtGSp1nVFErYcmFvayBtEKMwz/duEeslYzMWo=;
 b=Sc4GpT0GdfhJoAV6y2EMcs8VFB9+LvoDWqSvztKz1dUXkVDrh2mma9CcJ1MmNzb4zW
 5uVvUyjUzjwermnai5/wdyNZEn6nOGSmlJ+BEjGBX4XUb6jtqxoEORRNt2ldf7vXqWuf
 BZSLii7aRAODkymKWDdiAKMAc0EoU0h5j1AUsj7vbdy0KNXjHM0Aoe/2gIaE115VbYLM
 sduxTi/VUbskEH4qRKUYkRO9CCGziWcPA9z8qd2f6Ym8nYkniEkta73kYh8veqcrTN1e
 2jp3nmlR1UPmwuILN+LT2IyCA4EsACbBJ9nqgqWk8ZsKma55XiCAtV6O8+3jlLc3lKiU
 JBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726746470; x=1727351270;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xSDnB2xtGSp1nVFErYcmFvayBtEKMwz/duEeslYzMWo=;
 b=hVR04gio/Y3OCqvneNtfE6K3QP66N1v1mPuPFDODVCPVjCYqNH7z5ib1o7G2KDIbfU
 SsD7G3giCy+JuarzfA4QRdskuyP3Yn5Xo688hx4wDps96+UtDDo27laYE4oZFpYx1950
 R4gmfqQI0UVfd4o4HqF2zFTm7bAudSCYWf18GbteE45pSWk13o0+0Mem471c2EYFRrXU
 pO2K29yipk+iYtdh1gV4Qv7g+Q2fDl7mdOF4YWavM37LMQ8tSkZy8TxHcqdrJY4DMcd9
 0KE+oWpP4NURfJTMe5c7qa4t6X0MchRUX+kyX0Rhk13IpHjRYNLXIns6GQ/c1bKWPp3Z
 8BEA==
X-Gm-Message-State: AOJu0Yy89h2vVD0sOetzDrL+WRSenhw20lGdOsdng/SmUyC3p4anPV3p
 Eay21YdkaDM7Y5AVgl/fr54IrkeVyiIbovsCeUhpKmRhfkHOboZJXUrNtT40kpk=
X-Google-Smtp-Source: AGHT+IGmnLu9E/FOcbRoUTY+UNA4CUoPdsdGo73MYYjfCgVvWQJTuRCD97aY5clA40yTP6e5LE2Eeg==
X-Received: by 2002:a5d:5e0b:0:b0:378:fd4a:b9b1 with SMTP id
 ffacd0b85a97d-378fd4abc36mr5226201f8f.59.1726746470095; 
 Thu, 19 Sep 2024 04:47:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8ea1:6137:3157:6e66?
 ([2a01:e0a:982:cbb0:8ea1:6137:3157:6e66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73f97cbsm14735381f8f.50.2024.09.19.04.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 04:47:49 -0700 (PDT)
Message-ID: <f31970c6-28de-4404-9921-369823294a4e@linaro.org>
Date: Thu, 19 Sep 2024 13:47:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>
Subject: Re: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "Simek, Michal" <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "u-boot-qcom@groups.io" <u-boot-qcom@groups.io>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <bff9ce50-b5a6-45d8-9969-f116d91f75dd@linaro.org>
 <49932fef-c37a-4736-a2ac-829d5c39081d@amd.com>
 <79c51777-fbe0-4a02-9f81-bd468740ac6b@linaro.org>
 <69b3b92d-b263-40b1-8d39-66a5fb445015@amd.com>
 <7b71a9fe-946a-4b1a-bdc8-76050e1d8954@linaro.org>
 <SA1PR12MB869713CA620F99077B75EF0E98632@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <SA1PR12MB869713CA620F99077B75EF0E98632@SA1PR12MB8697.namprd12.prod.outlook.com>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 19/09/2024 11:21, Abbarapu, Venkatesh wrote:
> Hi,
> 
>> -----Original Message-----
>> From: neil.armstrong@linaro.org <neil.armstrong@linaro.org>
>> Sent: Thursday, September 19, 2024 1:22 PM
>> To: Simek, Michal <michal.simek@amd.com>; Marek Vasut
>> <marek.vasut+renesas@mailbox.org>; Neha Malcom Francis <n-francis@ti.com>;
>> Manorit Chawdhry <m-chawdhry@ti.com>; Tom Rini <trini@konsulko.com>;
>> bmeng.cn@gmail.com; Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>
>> Cc: u-boot@lists.denx.de; u-boot-qcom@groups.io; Bhupesh Sharma
>> <bhupesh.linux@gmail.com>
>> Subject: Re: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
>> controllers
>>
>> On 18/09/2024 12:47, Michal Simek wrote:
>>>
>>>
>>> On 9/18/24 12:40, neil.armstrong@linaro.org wrote:
>>>> Hi,
>>>>
>>>> On 18/09/2024 11:03, Michal Simek wrote:
>>>>> Hi Neil,
>>>>>
>>>>> On 9/18/24 10:06, Neil Armstrong wrote:
>>>>>> Hi Marek, Manorit, Tom, Michal,
>>>>>>
>>>>>> On 10/09/2024 11:20, Neil Armstrong wrote:
>>>>>>> This serie regroups all the fixes and base enhancements required
>>>>>>> to support the Qualcomm UFS controllers in U-Boot.
>>>>>>>
>>>>>>> This syncs headers & defines from Linux, and includes 2 set of
>>>>>>> fixes that were sent separately:
>>>>>>> - ufs: core: remove link_startup_again logic
>>>>>>> - ufs: properly fix cache operations
>>>>>>>
>>>>>>> Without those 2 sets, UFS cannot initialize on Qualcomm controlers
>>>>>>> since v5, and a numerous of Cache issues makes any UFS controller
>>>>>>> fail to initialize.
>>>>>>>
>>>>>>> Since UFS core hasn't changed for a while, and since UFS is core
>>>>>>> technology for the Qualcomm SoCs, I volunteer maintaininig the UFS
>>>>>>> subsystem if Bhupesh & Neha Malcom Francis are ok with that.
>>>>>>
>>>>>> Could you run this serie on the r8a779f0_spider, j721s2_evm_a72,
>>>>>> j721e_evm_a72, j7200_evm_a72, amd_versal2_virt and qemu-riscv and
>> check for possible regressions ?
>>>>>>
>>>>>> It seems the only user of UFS_PCI is qemu-riscv, is there other users ?
>>>>>
>>>>>
>>>>> Good timing. We are close to send some updates to UFS which we require to
>> get DWC version to work inside U-Boot.
>>>>>
>>>>> How far are that core changes from Linux? I see 9/13 is sync with Linux but
>> when this is done you should also say which Linux version was used for sync.
>>>>
>>>> I think we are still quite far from Linux, we just took the basic
>>>> required bits and pieces to at least make the Qcom UFS controller
>>>> driver build work, but Linux driver is overly complicated with power management
>> code we do not really need in U-Boot, so it's quite hard to sync honestly.
>>>>
>>>> But the plan is to align as much as possible once we get the basic Qcom UFS
>> mainline.
>>>
>>> That's understandable. But even when you say sync with Linux for some headers,
>> etc it is good to say that it is sync with 6.11 for example.
>>
>> Oh yes exact, I forgot to add this info, I planned to... I'll fix this in a v2.
>>
>> Thanks,
>> Neil
>>
>>>
>>> Thanks,
>>> Michal
>>>
> These changes are verified on AMD platform (amd_versal2_virt_defconfig) and no issues observed with this series.
> Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Great, thx for testing !

Neil

> 
> Thanks
> Venkatesh
> 

