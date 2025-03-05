Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBF7C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 07:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA991807D9;
	Wed,  5 Mar 2025 08:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PFlXZjkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 766C8808A2; Wed,  5 Mar 2025 08:40:46 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C143800C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 08:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bbd711eedso27630035e9.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 23:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741160444; x=1741765244; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=H9aln0htc8fJTsxqeDX8msMOT4AD86ZMDcaSfZedYww=;
 b=PFlXZjkI4oUFoWHOuKUDu9WAHInK4Pg0MjsWm2Hzp9ArwerT8s0tseF5fjVkdUtI/o
 uEjxXG8UMHjITMicY1kTGYP+isg6hFAmNzbppM7mHHE4wT67jC5ebl/nqEK3ICD6b5V+
 YVic0wc3OWnluMscTramz6mirwJ/QkJSjaHw2fcZCvWWugRO6GlaMFyiOOL65p8xFxQr
 S3SsmK7wE6Vl6CnYhkY9z58+NJbIsZZ+TPPNw5N3Ao3jAmyx777Z7I25FP7xWGWObUJz
 oLt7/NR3HybVhvvLsfm3nwBSvuESvYbwtcgVYS3r3RhF2kIwyCrcJZ+gXId2mLnZ1Wxs
 3O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741160444; x=1741765244;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=H9aln0htc8fJTsxqeDX8msMOT4AD86ZMDcaSfZedYww=;
 b=nzMgMrkug188bIRC8ICqxRdtHbYhPQpsxdqC+Bbh8+25VlyMMxelagKq4Nyb1Gsqyz
 iWIyNyY0/Y78094qoiXdj29myb3Lt+LDQic1Matixx9hZFTNJajVbSTTOST2JqWY1NX1
 3kd1IsDXfuH1/JY/souDqfIqo/1QqBuGzFPVAvVqfkDCricyJ/EGVYbQlmSI/XYcrEfd
 2SrWNkV4FoFjg+WVoShGsllkLXl6/vo1xqxSKkIrCrJrgWiopHOml/LxPFJ4x7oRdIB+
 505qNHjmtHYpDVix57h4Ugp/sYQych0UMbi0pb+c//viqWavfihILiq/IvbmVwzhqrnG
 27MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULlzU1JQMwguXdKRhzp1A6FhenMuctC6RFgApaoFfazbxRpoPH1NQE6vsBeaE7VkDx3/wBWiE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3wG+ZqG8qpXR4LctYA9ltkQQMTBJEx8EULL0cCnYa9HWbPkGV
 9ukCXkQO7HMJJfFLenhNiM+Zkv4qkVpJ1ZE4KNZTZCDHEjLYXLvJVOO6VumMB8A=
X-Gm-Gg: ASbGncuzC6nQokSAU/mZ/4+hY0xB+kCZ6qLQedT5vG5Pp83rsnyg9ON1XQQ04kfRHL+
 xc76dw17Gg7UJDzV9i0OYpvja6hXJgo9I1dY+sZG5V2v6kYuS78At09IbynK4Sixb42S4HtMstN
 mq+mSQdafLaqztY2BNdKmNHhoxteHs7ECrTHFApIHyj52Uwfo+YtDKBbCK3LKK1ySZ7XgZzD08K
 dgZnZDuvLJwz2XakGDHclqnmmJSORnN7dfQcqMAlMgN0dvnbXegAoepNTZ1l+BTULkl9ZQtSDcs
 GFBLfqVnw7BHwBwtQpnxwbsCg4kEgCYyGWFzR4mdAQ4glTIDZOLuzYVPQjSVJpRxsvlZVRkG11w
 2+5uYx9zTl7lQzUXll7A=
X-Google-Smtp-Source: AGHT+IFfqOvua+JfscyiTtHNvf8OrTVSxQuj96H23h76E0aNFzo/QJMQFQGGQEAjMHqFIM0g6lnh8g==
X-Received: by 2002:a05:600c:35ca:b0:439:9496:17df with SMTP id
 5b1f17b1804b1-43bd298a6a8mr11820095e9.13.1741160443612; 
 Tue, 04 Mar 2025 23:40:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:80fe:f5c:3d29:e407?
 ([2a01:e0a:982:cbb0:80fe:f5c:3d29:e407])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4310539sm8957355e9.35.2025.03.04.23.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 23:40:43 -0800 (PST)
Message-ID: <3ac80dba-8d1a-45ac-b299-96d03f9276d8@linaro.org>
Date: Wed, 5 Mar 2025 08:40:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>
Subject: Re: [RFC PATCH] UFS: Remove the timeout while send command
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
References: <20250227060428.2070765-1-venkatesh.abbarapu@amd.com>
 <42964c7a-a544-4139-9e5b-9097b9e29159@linaro.org>
 <SA1PR12MB869721ED6126696822D6083898C82@SA1PR12MB8697.namprd12.prod.outlook.com>
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
In-Reply-To: <SA1PR12MB869721ED6126696822D6083898C82@SA1PR12MB8697.namprd12.prod.outlook.com>
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

Hi,

On 04/03/2025 06:15, Abbarapu, Venkatesh wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Neil,
> 
>> -----Original Message-----
>> From: neil.armstrong@linaro.org <neil.armstrong@linaro.org>
>> Sent: Friday, February 28, 2025 8:55 PM
>> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.de
>> Cc: Simek, Michal <michal.simek@amd.com>; bhupesh.linux@gmail.com; n-
>> francis@ti.com; git (AMD-Xilinx) <git@amd.com>
>> Subject: Re: [RFC PATCH] UFS: Remove the timeout while send command
>>
>> Hi,
>>
>> On 27/02/2025 07:04, Venkatesh Yadav Abbarapu wrote:
>>> Based on the UFS speed mode(HS or PWM) the timeout might vary and can
>>> result timeouts.
>>
>> Can't you bump the QUERY_REQ_TIMEOUT to the PWM timeout delay ?
> 
> Is there any way we can get the PWM timeout delay?
> I think it also depends on the data size we are going to transfer right?
> Any generic way to find the timeouts for PWM or HS modes.

I don't have access to the UFS spec, but perhaps Linux does the calculation here ?

Neil

> 
> Thanks
> Venkatesh
>>
>> Neil
>>
>>>
>>> ufs-versal2-pltfm ufs@f10b0000: Timedout waiting for UTP response
>>> ufs-versal2-pltfm ufs@f10b0000: OCS error from controller = f
>>>
>>> It's a temporary workaround to solve the timeout issue.
>>>
>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>> ---
>>>    drivers/ufs/ufs.c | 9 ---------
>>>    1 file changed, 9 deletions(-)
>>>
>>> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c index
>>> f7d8c40c448..c3acbd709e7 100644
>>> --- a/drivers/ufs/ufs.c
>>> +++ b/drivers/ufs/ufs.c
>>> @@ -858,7 +858,6 @@ static int ufshcd_comp_devman_upiu(struct ufs_hba
>>> *hba,
>>>
>>>    static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>>>    {
>>> -   unsigned long start;
>>>      u32 intr_status;
>>>      u32 enabled_intr_status;
>>>
>>> @@ -867,19 +866,11 @@ static int ufshcd_send_command(struct ufs_hba *hba,
>> unsigned int task_tag)
>>>      /* Make sure doorbell reg is updated before reading interrupt status */
>>>      wmb();
>>>
>>> -   start = get_timer(0);
>>>      do {
>>>              intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
>>>              enabled_intr_status = intr_status & hba->intr_mask;
>>>              ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
>>>
>>> -           if (get_timer(start) > QUERY_REQ_TIMEOUT) {
>>> -                   dev_err(hba->dev,
>>> -                           "Timedout waiting for UTP response\n");
>>> -
>>> -                   return -ETIMEDOUT;
>>> -           }
>>> -
>>>              if (enabled_intr_status & UFSHCD_ERROR_MASK) {
>>>                      dev_err(hba->dev, "Error in status:%08x\n",
>>>                              enabled_intr_status);
> 

