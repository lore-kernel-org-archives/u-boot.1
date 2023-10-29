Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F92C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 17:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC46D8747E;
	Sun, 29 Oct 2023 18:34:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698600863;
	bh=vtsUQ3UVxzVpzijcPJkTbNBla41I55UWvfWY7VJ2/Pc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wYM435kwQAp6JfHxiRepVXKyvrPXK8LxNjQ1SBK9RRxJktTqJ/t7DnnVR0I44MovL
	 qwoC/s28Uk7tKafRrDrEVeQTTKsPVE8s/xcFAH0Bi78qiJmfRbXwvr1VHZUe/KDznj
	 LocyXDPk79yiKXCUjKSyZsDcjYkouO7LteO10Aawva/OtQhiOsJdR39xqNzi7LB/tH
	 RDXriCRUGRdwwjx2o9Zn0mYHep5oKXg4kmmOP4jc87fU2dyY9d66dRbH7wMhrfqPfB
	 yrDsNCOaeL8yEBC3r2UdY3EcxMrrqaAQwsL2w6vASyGSyNWoS0Jd/5xJ41UeHynPw+
	 uqzae6K2Dbnpg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8FBB987817;
 Sun, 29 Oct 2023 18:34:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698600862;
 bh=vtsUQ3UVxzVpzijcPJkTbNBla41I55UWvfWY7VJ2/Pc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nNNmpwJ82VlP7FaWdpzFfQ5nNDejqxsSwwaABCy9f9bQvBsV7vJiXJ6e29bgwQzo4
 dMXSn2sGPkUH7BSay6xcFA3lzRLxow/wlO1q8xYi8m66Cjk7Gf7XWY9JDNOLW5ucC1
 yRPEGAsOUjSMyntqNSqLq2RER9QVbVjGTpc4o+pDkSEnRtV/ddih7qvIJtbREUfMcm
 QNJrORukSwl/IhRLAl8DH7usqdJ4EZ9dFX2zxd46e4kV548Gy6F0+NRJsQP41s8wyF
 q4TBjN+jy99gRsbiEZq43XWmuTfCuPwJ6ZUiMEGPaKAXQthcc/w4JExcDiFY+wfD4l
 3XotVltb0yEYQ==
Message-ID: <12ee2427-8589-4b9c-b530-37fad068cc85@denx.de>
Date: Sun, 29 Oct 2023 18:33:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] usb: storage: Implement 64-bit LBA support
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-3-v1-0-0153210a7f55@marcan.st>
 <20231029-usb-fixes-3-v1-4-0153210a7f55@marcan.st>
 <c3cfba5e-46cb-4fec-8e0d-b8aa1b9c0098@denx.de>
 <1db9cfab-4e89-2308-e398-8ea283079314@marcan.st>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <1db9cfab-4e89-2308-e398-8ea283079314@marcan.st>
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

On 10/29/23 16:54, Hector Martin wrote:
> On 29/10/2023 21.11, Marek Vasut wrote:
>> On 10/29/23 08:23, Hector Martin wrote:
>>> This makes things work properly on devices with >= 2 TiB
>>> capacity. If u-boot is built without CONFIG_SYS_64BIT_LBA,
>>> the capacity will be clamped at 2^32 - 1 sectors.
>>>
>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>> ---
>>>    common/usb_storage.c | 132 ++++++++++++++++++++++++++++++++++++++++++++-------
>>>    1 file changed, 114 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/common/usb_storage.c b/common/usb_storage.c
>>> index 95507ffbce48..3035f2ee9868 100644
>>> --- a/common/usb_storage.c
>>> +++ b/common/usb_storage.c
>>> @@ -66,7 +66,7 @@
>>>    static const unsigned char us_direction[256/8] = {
>>>    	0x28, 0x81, 0x14, 0x14, 0x20, 0x01, 0x90, 0x77,
>>>    	0x0C, 0x20, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
>>> -	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01,
>>> +	0x00, 0x01, 0x00, 0x40, 0x00, 0x01, 0x00, 0x01,
>>
>> What changed here ?
> 
> This is an incomplete bitmap specifying the data transfer direction for
> every possible SCSI command ID. I'm adding the new commands I'm now using.

Can you please add a code comment here, so others wouldn't ponder about 
this too ?
