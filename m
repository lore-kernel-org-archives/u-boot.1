Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7E3CF64B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 04:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B10ED84042;
	Thu, 20 Nov 2025 05:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="baoUlqko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 760EF83EA6; Thu, 20 Nov 2025 04:06:04 +0100 (CET)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B42383E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 04:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kernel@airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1763607946;
 bh=+UkTFVSqvyLVDTur+ZqtajqeROo3NRfypFF7PO/zI5M=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=baoUlqkoDpcaxJjd+Q1L8JBfnsQOuFPPjQAeWCYAFgkHKbi/3P0SN+bYvSZQi00Ql
 QIQCJO9PGYjxryNI72qjvkClYP/44pQO2PmdSeL9qR1VeMOB6rv5+HWeV4mWESZbLB
 YGYr42UM+1P4rpXYDo46iXpaiBA53kJeS0WG4zXw=
X-QQ-mid: esmtpgz10t1763607939t6979a7a2
X-QQ-Originating-IP: SzzUGoYxXenUJ7gOSYY1b7++oaLrmoQY4+tC5EyJrUE=
Received: from [172.16.12.51] ( [58.22.7.114]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 20 Nov 2025 11:05:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13977321387859848623
Message-ID: <D96403B0FC16D47C+4bbc5700-a093-4192-80ac-0661bdb2b005@airkyi.com>
Date: Thu, 20 Nov 2025 11:05:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: Enable RK806 PMIC on rk3588-evb
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20251119015554.153-1-kernel@airkyi.com>
 <bae11d52-65cf-4d8f-a51e-115a90a7444c@cherry.de>
 <208fb48c-a4b6-4b5d-a8a3-9587fd447ab9@rock-chips.com>
 <bec215b1-02c6-4380-97f1-f8626b2ddab0@cherry.de>
Content-Language: en-US
From: Chaoyi Chen <kernel@airkyi.com>
In-Reply-To: <bec215b1-02c6-4380-97f1-f8626b2ddab0@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MHu5q+4GrKKGhU1R0BbUsF5JChKF7I0rYClxlsrgl8KsU2k54d2W6m/X
 IcSjRnMew1yT36bRIT9XqLZhTbWU/cG09EosnZZf63lnA11q6WSHSfwytBbNF0DQMsZcYHL
 z5uyV1gNvuYlZu64AGKQoaU9PJpgnSXN2xGecwHWXQUjt7+SwvjAdEGF7ydyL123mkKgETV
 101PeZ/8x99kGFIny4Zz2NC+7hWT+6gkOEHR85BZFo3tG8JveChvYf0cPLPWKRoEEBdY+PA
 BpuhuncLeWGuGU5IVSvNCg2dF5DUUHWla0qg/LqBY3tn8mem0Rvfd582Agu1elL3lLn2d9O
 ev+ygpkhxjDEOAgLDjVcXDjPDPRJQxXD/iMNCwUs4aOBqDJzsuPAhMcudTexbs23RgFgaBw
 ZyZ7PZSgkuPtpTZAdBGofaO0Kcy64rLK5KXi2Op6TEklIWdNGwI+oeyd91o3OMio0nE1C+U
 nN32+bNeWwZP0DEfKmDSphAUiC99ZPHCupWzzQi4WK0BEGzeyWsv9RvvBET02E5zEDIxsn8
 PkX9xLYSU6vu80ZQ9JnkWDXf1qbEGI1w5CJXsQqXzaVLuZAH4OJChTKnQJ1s5XQ/uG8ihZW
 skEH1xC+okDKYEShXAmsORWFRP9zDabMKzlkWb4RxHr8rU7J2ralNDcVOw05c/p+LY57HoP
 APysGAzjRzgCa2i3Q9kDHQO7dVQpwAkFRaJtAmHckMotXvX2BymMzjE/uhuWkOFSKPUXwpe
 H5v0YReFbyyVn7/p3XnpZjXkeENQcjfRal8WAN8nKlez0v8KduPCpn31Q5ZE6TPjhN5yFUV
 muYn/hZxZn1cNBo+sPrsEKifujV9guWf80ajejAoq6B9S6MjFzLtttmUMum3t7YFRIHSij1
 swqydYwR0EPoKM59DR6YISTOSSb+VgYjSjn/fAZLKguIOw61uyoYcHQB/fDIdtMz+vlXvm/
 0KwY3UWzCn3E72nlsLL4jK2Hm1EIEK1Xe8Uegdn7Hl3W7vfW019X2PvdlzLkLjPiy5XJLJV
 vCpZQsAz3cVRUCEVjT
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Thu, 20 Nov 2025 05:42:31 +0100
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

On 11/19/2025 6:45 PM, Quentin Schulz wrote:

> On 11/19/25 11:09 AM, Chaoyi Chen wrote:
>> Hi Quentin,
>>
>> On 11/19/2025 5:52 PM, Quentin Schulz wrote:
>>> Hi Chaoyi Chen,
>>>
>>> On 11/19/25 2:55 AM, Chaoyi Chen wrote:
>>>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>>
>>>> Some pmdomains rely on RK806 PMIC for power supply. If we don't
>>>> enable them in U-Boot, random panic may occur during the Kernel
>>>> boot process.
>>>>
>>>
>>> The kernel shouldn't rely on U-Boot doing something to work, so please fix this with upstream Linux kernel.
>>>
>>> Can you tell us what's the issue?
>>>
>>> The issue with this patch here is that we probably would need **all** RK3588 boards to have the PMIC enabled, and all the appropriate regulators brought up before booting into the kernel. It'd be *much* better this is fixed in Linux (and depending on what we're talking about, it may need another fix in U-Boot so that whatever depends on the PM domain works as well).
>>>
>>> Also, why the PMIC in SPL but not the regulators?
>>
>> It make sense, but I haven't thought of a specific solution for Kernel yet.
>>
>> To be specific, I'm trying to get RKVENC to work. It uses an independent power domain. If RK806 is not enabled in U-Boot, the first power-up attempt for the pmdomain corresponding to RKVENC will fail in the Kernel.
>>
>
> I assume you tried to add
>
> domain-supply = <&vdd_vdenc_s0>;
>
> to power-domain@RK3588_PD_VCODEC node to model what the HW is expecting?
>
> Doing something similar to the NPU essentially, which has a similar issue as far as I remember (I am not too involved in kernel development nowadays so I only get snippets of info here and there).

Yes, that's exactly what I did, but I still get the same error.
I'm not sure if it has anything to do with the Kernel version. I'm currently testing on 6.15, and I'll try it again on 6.17.


>
>> And essentially, the operations of pmdomains in the Kernel are dependent on regulators. But it seems that pmdomains driver haven't dealt with this. I have seen some cases, but it seems that the dependency issue has not been fully resolved [0].
>>
>
> The problem with working around the issue by applying bandage fixes in U-Boot is that nobody will actually work on fixing the actual issue. We've seen that with SoCs with IO domains which are still not properly supported by the kernel but since IO domains are now initialized by U-Boot, the issue doesn't show anymore, c.f. https://lore.kernel.org/linux-rockchip/20230904115816.1237684-1-s.hauer@pengutronix.de/.
>
I agree with your point of view. This problem requires more time to investigate.

-- 
Best,
Chaoyi


