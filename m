Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAA3C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 10:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F1C687D6C;
	Tue, 20 Feb 2024 11:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708426060;
	bh=6PQOubeYSrEsuoJZ+Z/C+WEvdtOGYPHE03mezcO8uRE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aoJy/vLyvFgxSOE+e1ThHT6Kt/xhaHbvt6MxzUt9kttYhrdnkdWCoIV+X06izqnqk
	 Bs07S7vIa93gI7y5CI7jUQSXfKKSyYJ+sbowakC6gBdJ3qp0pz+21H0Fyr6ae+cIRP
	 P+t/Wp8h++0YZoGU853UwDx31O15Ydkaq/7fJe7o0mpvXZYx0es7cRbZSnNovq8v7V
	 7yjj4vIRrMCs9EIeWffbZ7scpB6Xp4N+7kM3uItrLvvlFxq6uNQ965B2Vj7kzDH25I
	 oTa5pZksIdjji/LT9SlxsXK1FKrZHVXGGytKLsLvGHRcgmJzHu12yHAFpf1p1ixlUR
	 RTRshQ6njc66g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B42C287D65;
 Tue, 20 Feb 2024 11:47:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708426059;
 bh=6PQOubeYSrEsuoJZ+Z/C+WEvdtOGYPHE03mezcO8uRE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vD5whbtZIJrU7SZ2SgkI9D5wJvPnYXKxMO2PzARsTxxzrqAGITkDWgRyPbg9up/oG
 HCXlJoPTDGh30iurfB1f0cUS9cP7Fg7lDDB3HKn6czXoGa7dci5Is1oh4i4/ogc9DE
 0W76NGIFFERTzhS/awv3+8AZ+sktAVTXJ+662tFxCFzUOUqWKVFy3a5pJbXv4PZ7kz
 gRISRuISBibCahvXLVULN2+m7KDBtFZhpwdFYnZ+HdABolxmAExIRRWFS8b4P9LvGU
 1p7Lj8Z8MqGHFlPRgjuPiyx+nI03Cl0EglhDbvw46MQCyvUIJ6v69KjT2POK27mXHg
 +NXqBjyB36ZFw==
Message-ID: <24d446a8-a341-4e5e-b67d-ccb643fc9a2a@denx.de>
Date: Tue, 20 Feb 2024 11:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common: usb-hub: Reset USB 3.0 hubs only
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de
Cc: dsimic@manjaro.org, andre.przywara@arm.com,
 Hector Martin <marcan@marcan.st>, Tom Rini <trini@konsulko.com>
References: <20240214095403.53051-1-i@shantur.com>
 <CABEcMwWK8_rKE6xPmqwGznau6aadL7gVsiCktsxg+-u+eb1umQ@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CABEcMwWK8_rKE6xPmqwGznau6aadL7gVsiCktsxg+-u+eb1umQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/19/24 10:49, Shantur Rathore wrote:
> Hi Marek,
> 
> On Wed, Feb 14, 2024 at 9:55 AM Shantur Rathore <i@shantur.com> wrote:
>>
>> Additional testing of the changes introduced in commit 33e06dcbe57a "common:
>> usb-hub: Reset hub port before scanning") revealed that some USB 2.0 and 3.0
>> flash drives didn't work in U-Boot on some Allwinner SoCs that support USB
>> 2.0 interfaces only.  More precisely, some of the tested USB 2.0 and 3.0
>> flash drives failed to be detected and work on an OrangePi Zero 3, based on
>> the Allwinner H616 SoC that supports USB 2.0 only, while the same USB flash
>> drives worked just fine on a Pine64 H64, based on the Allwinner H6 SoC that
>> supports both USB 2.0 and USB 3.0 interfaces.
>>
>> The USB ID of the above-mentioned USB 3.0 flash drive that failed to work is
>> 1f75:0917 (Innostor Technology Corporation IS917 Mass storage), it is 32 GB
>> in size and sold under the PNY brand.  The mentioned USB 2.0 drive is some
>> inexpensive no-name drive with an invalid USB ID.
>>
>> Resetting USB 3.0 hubs only, which this patch introduces to the USB hub
>> resets, has been tested to work as expected, resolving the identified issues
>> on the Allwinner H616, while not introducing any new issues on other tested
>> Allwinner SoCs.  Thus, let's fix it that way.
>>
>> According to the USB 3.0 specification, resetting a USB 3.0 port is required
>> when an attached USB device transitions between different states, such as
>> when it resumes from suspend.  Though, the Linux kernel performs additional
>> USB 3.0 port resets upon initial USB device attachment, as visible in commit
>> 07194ab7be63 ("USB: Reset USB 3.0 devices on (re)discovery") in the kernel
>> source, to ensure proper state of the USB 3.0 hub port and proper USB mode
>> negotiation during the initial USB device attachment and enumeration.
>>
>> These additional types of USB port resets don't exist for USB 2.0 hubs,
>> according the USB 2.0 specification.  The resets seem to be added to the USB
>> 3.0 specification as part of the port and device mode negotiation.
>>
>> The Linux kernel resets USB 3.0 (i.e. SuperSpeed) hubs only, as visible in
>> commit 10d674a82e55 ("USB: When hot reset for USB3 fails, try warm reset.")
>> in the kernel source.  The check for SuperSpeed hubs is performed in a way
>> that also applies to newer SuperSpeed Plus (USB 3.1 or 3.2) hubs as well,
>> which hopefully makes it future proof.

Applied, thanks
