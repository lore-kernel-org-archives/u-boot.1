Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF1DC54E51
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 13:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE8087FBF;
	Tue, 27 Feb 2024 14:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709039565;
	bh=fXEv76m2IYxeaKNB49FiT81DQdpYMh0GurOb78tk6Oc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kLaXfCe+yrol/Z39rK0T8SVuNB/pJK+rjJKtKYJFuWpKJaaQKOBN53sjI1piQ53tN
	 BMwTtAy58MsMLQ31xF/BsK9pJ5nxADU1zEI0H4+ZiU9VVios8WhLjqDEuTrN8zuBeF
	 n9C8v7mHWgWAJiVGIV06AkzWji89ErtNLWA4pGVQ0+J4XGTMNcq7LrS0X2lhnwiFJf
	 yAGRGIMBEEB2hxC3n3w+kQv/jcnKH0BGyU/We/TsWdzbN+Rr6kiBYKfZKs01EKKDO+
	 kvTcjd3QP1eBLiTH2bdudUnl80uUGPnDSyPFyoP0T9+CKTi3GFGsuxh7cGSsIgFl7D
	 /Kqcqn++JbGXg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A46DF87F7B;
 Tue, 27 Feb 2024 14:12:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709039563;
 bh=fXEv76m2IYxeaKNB49FiT81DQdpYMh0GurOb78tk6Oc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Yy9xz6UdYcLXz4DTM7gh/fWU1Cr3MmJWS7qRG4GA+OV23BSU154ApvjBsLRpaMdhx
 A+EX8afGX/d/3PL1lUtbksCDesWS8JS2EWdBNxHRSI+KLnVy9d2YOijDNj11rYBm6n
 zadcnqRslbH13Td6RqVy8eranLESeMwbNn+2uOAQe6hihOv5d2NP4DS3slvN8k44EG
 UGeWVMIyQ06OW6puqABUVQ2f6UiTHhnyjXa3Yvx303DT4+0EqIpQMqEBbxjxSVH2xC
 CwfiHDjwzkLFG0/Bz7alIx2XqV5pFehYxPY0JOtk3650m/2GORPX4Kn8385bNjewdA
 7dmwUprMlIyhA==
Message-ID: <71ab8e0f-eda5-42e1-b0f9-1bd958b68397@denx.de>
Date: Tue, 27 Feb 2024 13:02:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] usb: xhci: Set up endpoints for the first 2 interfaces
Content-Language: en-US
To: Janne Grunau <j@jannau.net>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
 <20240221-asahi-keyboards-v1-2-814b2e741790@jannau.net>
 <9cb3370e-770a-40e6-b890-ae9b5a15bd44@denx.de>
 <b0c41f38-abf0-4713-a80a-c78f074b7b4d@app.fastmail.com>
 <52b99ba9-3772-4074-8b64-e01dde80f6a4@denx.de>
 <0ec5ded2-f3f7-4e79-afbd-f6f560ab0627@app.fastmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <0ec5ded2-f3f7-4e79-afbd-f6f560ab0627@app.fastmail.com>
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

On 2/27/24 8:38 AM, Janne Grunau wrote:
> Hej,
> 
> On Sun, Feb 25, 2024, at 22:47, Marek Vasut wrote:
>> On 2/25/24 4:28 PM, Janne Grunau wrote:
>>>
>>>
>>> On Wed, Feb 21, 2024, at 13:39, Marek Vasut wrote:
>>>> On 2/21/24 08:25, Janne Grunau via B4 Relay wrote:
>>>>> From: Janne Grunau <j@jannau.net>
>>>>>
>>>>> Apple USB keyboards carry the HID keyboard boot protocol on the second
>>>>> interface. Using the second interface in the USB keyboard driver does
>>>>> not work since the xhci has not allocated a transfer ring.
>>>>
>>>> So, what does this patch do ? That is not clear from the commit message.
>>>
>>> rewritten for v2:
>>> | usb: xhci: Set up endpoints for the first 2 interfaces
>>> |
>>> | The xhci driver currently only does the necessary initialization for
>>> | endpoints found in the first interface descriptor. Apple USB keyboards
>>> | (released 2021) use the second interface descriptor for the HID keyboard
>>> | boot protocol. To allow USB drivers to use endpoints from other
>>> | interface descriptors the xhci driver needs to ensure these endpoints
>>> | are initialized as well.
>>> | Use USB_MAX_ACTIVE_INTERFACES to control how many interface descriptors
>>> | are initialized and useable. Currently defined to 2 as that is enough to
>>> | make the Apple keyboard usable.
>>
>> Would it make sense to make this a tunable Kconfig option ?
> 
> I thought about that but I don't think it's worth it. We would have to default it to 2 (at least when the USB keyboard driver is enabled) since we can't predict which devices will be connected.
> Why would anyone chose a different value than the fixed value? I can't think of convincing reasons.

All right

Reviewed-by: Marek Vasut <marex@denx.de>
