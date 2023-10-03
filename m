Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFF0E75459
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 18:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12ED687195;
	Tue,  3 Oct 2023 20:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mHOvak8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4EFE8719B; Tue,  3 Oct 2023 20:14:46 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 034F986E2C
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 20:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from [10.7.98.35] (unknown [167.220.24.35])
 by linux.microsoft.com (Postfix) with ESMTPSA id B8C4520B74C0;
 Tue,  3 Oct 2023 11:14:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8C4520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1696356883;
 bh=+2x+/f2F4ah7CjTgiWC62wfe7p6ZQsBjJTlwrxGChoE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mHOvak8WzSJ5lhZnq9cTQ9Km0slgNp22zNijEDA3HLxZma4BGqYe0PKNQsz0ChyM6
 yu9l/Nx4GttF2hzCuCMeB6BKKotY2r5zgvjTkmHEk+Y7pof+4QHEnV2f5Wq8p7giAw
 MqCWTWga5hxfFhRmxYJ1QtYN1yKBFNrGykA7bTm8=
Message-ID: <c23340ce-5704-992b-e9c6-9642b98180b7@linux.microsoft.com>
Date: Tue, 3 Oct 2023 11:14:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] BOOTP/DHCPv4 enhancements
Content-Language: en-GB
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com
References: <20230925202935.118652-1-seanedmond@linux.microsoft.com>
 <CALeDE9OAdJ0cidcKNprH=Ghteafmb1fWksW3m5bc6zw+cocegQ@mail.gmail.com>
From: Sean Edmond <seanedmond@linux.microsoft.com>
In-Reply-To: <CALeDE9OAdJ0cidcKNprH=Ghteafmb1fWksW3m5bc6zw+cocegQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 2023-09-26 9:45 a.m., Peter Robinson wrote:
> Hi Sean,
>
>> In our datacenter application, a single DHCP server is servicing 36000+ clients.
>> Improvements are required to the DHCPv4 retransmission behavior to align with
>> RFC and ensure less pressure is exerted on the server:
>> - retransmission backoff interval maximum is configurable
>>    (environment variable bootpretransmitperiodmax)
>> - initial retransmission backoff interval is configurable
>>    (environment variable bootpretransmitperiodinit)
>> - transaction ID is kept the same for each BOOTP/DHCPv4 request
>>    (not recreated on each retry)
> Might be also worth looking at the series adding LWIP support [1] and
> see what impact that may have on this too.
>
> Peter
>
> [1]https://lists.denx.de/pipermail/u-boot/2023-September/531716.html

I'm aware of the LWIP addition but haven't made any attempt to 
characterize the retransmission behavior.

My understanding is that LWIP doesn't support DHCPv6 or TFTP with IPv6 
yet.  Our preference would be to stick with the u-boot networking stack 
for now until LWIP adds full support for IPv6.

Given the importance of the retransmission behavior is for our use-case 
(36000+ clients pers server), we would have to qualify/validate LWIP 
before transitioning.



>> For our application we'll use:
>> - bootpretransmitperiodmax=16000
>> - bootpretransmitperiodinit=2000
>>
>> A new configuration BOOTP_RANDOM_XID has been added to enable a randomized
>> BOOTP/DHCPv4 transaction ID.
>>
>> Add functionality for DHCPv4 sending/parsing option 209 (PXE config file).
>> Enabled with Kconfig BOOTP_PXE_DHCP_OPTION.  Note, this patch was
>> submitted previously but this latest version has been enhanced to
>> avoid a possible double free().
>>
>> Sean Edmond (3):
>>    net: Get pxe config file from dhcp option 209
>>    net: bootp: BOOTP/DHCPv4 retransmission improvements
>>    net: bootp: add config option BOOTP_RANDOM_XID
>>
>>   cmd/Kconfig | 11 +++++++
>>   cmd/pxe.c   | 10 +++++++
>>   net/bootp.c | 85 +++++++++++++++++++++++++++++++++++++++++++----------
>>   3 files changed, 91 insertions(+), 15 deletions(-)
>>
>> --
>> 2.40.0
>>
