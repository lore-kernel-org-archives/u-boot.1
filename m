Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EC5C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 08:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 530E08648E;
	Mon, 28 Aug 2023 10:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JeswxcNI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE1DA864A7; Mon, 28 Aug 2023 10:46:57 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB29086458
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.115] (unknown [176.236.51.75])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id B56AE660719F;
 Mon, 28 Aug 2023 09:46:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1693212414;
 bh=K64TD2jBRmgZmm2SXlMwTZ4LFw/8tmJnelzKd2gHMYE=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
 b=JeswxcNIoLJmE3EBiSgatJ8PwYXM2+1vS/xI536tlF5n4wek0VKFzAF1LcwPZ+1eL
 vk3aU1WM9cuIGY2QgXPfYWWQ2cJR1Rsk2Lq6MwIvlDu4R6dJLNo92hF1JfnRjewQIS
 PcSMvYFLHfkgFBAd7nEdSlXMGAy0vZj6fpsON+QP/s6ux8uWBtzrBfoaIGIggchVNf
 UagBT20wpTYfrC9SpptikQVMy73+HCYM53oXhd5u7yixuz4VAihqoOme9hfQbwJ2rw
 yrYQNruSTuZYFrh5zkCmyg8FdTtP5ij2c7lNUlgCXL6VkIg8S+KDSsw4D+CBIZtjUl
 hoPw8xvbPFdqA==
Message-ID: <7d288a5d-2d8e-39fa-2b18-327452a4cdbd@collabora.com>
Date: Mon, 28 Aug 2023 11:46:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fpga: define dummy fpga_load function for debug build
To: Chanho Park <chanho61.park@samsung.com>,
 'Michal Simek' <michal.simek@amd.com>, u-boot@lists.denx.de
References: <CGME20230816065448epcas2p3bf66892f15a6dc8e082a5f296b307bec@epcas2p3.samsung.com>
 <20230816065437.836392-1-chanho61.park@samsung.com>
 <c0e49c05-a5f8-2759-33b5-946bf2283b34@amd.com>
 <000001d9d945$95ebf520$c1c3df60$@samsung.com>
Content-Language: en-US
Cc: Simon Glass <sjg@chromium.org>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <000001d9d945$95ebf520$c1c3df60$@samsung.com>
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

On 8/28/23 03:21, Chanho Park wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Michal Simek <michal.simek@amd.com>
>> Sent: Friday, August 25, 2023 4:23 PM
>> To: Chanho Park <chanho61.park@samsung.com>; u-boot@lists.denx.de
>> Subject: Re: [PATCH] fpga: define dummy fpga_load function for debug build
>>
>> Hi,
>>
>> On 8/16/23 08:54, Chanho Park wrote:
>>> This fixes below build error when CC_OPTIMIZE_FOR_DEBUG is enabled and
>>> CONFIG_SPL_FPGA is not enabled.
>>>
>>> ../common/spl/spl_fit.c:591: undefined reference to `fpga_load'
>>> collect2: error: ld returned 1 exit status
>>>
>>> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
>>> ---
>>>    include/fpga.h | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/include/fpga.h b/include/fpga.h index
>>> ed688cc0fa3b..44f2755a3f10 100644
>>> --- a/include/fpga.h
>>> +++ b/include/fpga.h
>>> @@ -60,8 +60,16 @@ int fpga_add(fpga_type devtype, void *desc);
>>>    int fpga_count(void);
>>>    const fpga_desc *const fpga_get_desc(int devnum);
>>>    int fpga_is_partial_data(int devnum, size_t img_len);
>>> +#if CONFIG_IS_ENABLED(FPGA)
>>>    int fpga_load(int devnum, const void *buf, size_t bsize,
>>>    	      bitstream_type bstype, int flags);
>>> +#else
>>> +static inline int fpga_load(int devnum, const void *buf, size_t bsize,
>>> +	      bitstream_type bstype, int flags) {
>>> +	return FPGA_FAIL;
>>> +}
>>> +#endif
>>>    int fpga_fsload(int devnum, const void *buf, size_t size,
>>>    		fpga_fs_info *fpga_fsinfo);
>>>    int fpga_loads(int devnum, const void *buf, size_t size,
>>
>> There is another patch targeting the same code.
>> Please take a look at
>> https://lore.kernel.org/r/20230808102227.34233-1-
>> eugen.hristev@collabora.com
> 
> I wasn't aware that there was an attempt to fix the issue. If I knew it, I would reply the patch...
> 
>>
>> and work together to come up with the patch which covers both cases.
> 
> Yes. I also tried to make the patch with CONFIG_CC_OPTIMIZE_FOR_DEBUG guard but I couldn't find any codes that uses the guard.
> And I was also worried about the CC_OPTIMIZE_FOR_DEBUG's behavior. It could be related with the optimization level of the compiler.
> That's why I put the guard with #if CONFIG_IS_ENABLED(FPGA).
> 
> Best Regards,
> Chanho Park
> 


Hi Chanho,

Simon suggested to use CONFIG_CC_OPTIMIZE_FOR_DEBUG in this case here:

https://patchwork.ozlabs.org/project/uboot/patch/20230619102839.277902-1-eugen.hristev@collabora.com/

As I told Michal, basically your patch and my patch do the same thing.
I suggested him to pick the one that he thinks it's best. (or even 
suggest another way)

Eugen
