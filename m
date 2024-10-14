Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25F2D1813F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 20:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69EC0890AC;
	Mon, 14 Oct 2024 22:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728936859;
	bh=0X8SFBcLQ54jxjbTl8959k+iz/U27LtuH76E/8Dhweo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K20W1H4ifoSWw7nWRUxiJgmbyMqEGKluGV4f9NtcXH+o9GBFJu47KA/BzDrwy1ZCo
	 Gf+M5gbYGFQjQQCpVyxmw2Kno7C4M7ug+Wcchn5BQV0W3TjAFOYykQ7EMpqvRb/cOm
	 wjoHzPim8gyTyYZd9gMoXqAZwq/z+f49rNvetmH5YzbVc2gQidvUa/Q9zw1B4XMtjN
	 WPYWZy+Na0mRsVm1we0tqF8mXJvA36uTVjntnctN8zhUdu5Dq4A0b4KZIeWFmZRhxS
	 VPTT47k8IkH/OByuqkT5m2KJclHmBbA4YVfSNntsw1ZvKyek+OEARuKVIsGoWa/S5E
	 wP6plox+2zT7w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5F6C48907F;
 Mon, 14 Oct 2024 22:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728936857;
 bh=0X8SFBcLQ54jxjbTl8959k+iz/U27LtuH76E/8Dhweo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=M2XVnBIrL7L4ZIwV1S9i/YE1vBCFhmk8rwFUFsZBTKJGrxM9KOSF8/OtBhgvhdKCm
 N1xzdrnbzqiwOyzDk/Pfg79XFf9qlXcNI4PHqczWFi3b4DEA34H5yEl3LrbYz1lBt1
 xqoe+BQgKMd76UnDjOg7SCOtWb+91Fd1jjT+6ndW4PYpul2m6CQQCOxLPO3hfnHsSh
 Hsz1Kj9zAGVM3vU/i5qMvhz5OldTnwji5WEenNxyM9x7Pk8o/uakvNS9jpsLjIfSVg
 rmnZzbt0HKo9wW6EXLWQhxB3R3NO/iR9tIFYqpcMIzYQDfCkXnPczi2yRTt8vGRFvm
 PbWGcPpHBSGnA==
Message-ID: <ed98b4aa-da95-4ecd-bc89-bb827d799557@denx.de>
Date: Mon, 14 Oct 2024 22:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Dragan Simic <dsimic@manjaro.org>, Alex ThreeD <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241014175338.2675136-1-alexthreed@gmail.com>
 <3f4143078e0dc3409c96ea13be5b8317@manjaro.org>
 <CAF4oh-PM8JCymzEbw3ZtYnaF8_fjckHUPUkqv-xS1fZBh5o2cA@mail.gmail.com>
 <65bd30e10c687ec5bf19bda34da7df27@manjaro.org>
 <CAF4oh-P-6unDx0HVRegos7FNYv9z7FpQoctu4w465CfFfLzFGw@mail.gmail.com>
 <839e5b9f561fa8e6328216618f9a2e38@manjaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <839e5b9f561fa8e6328216618f9a2e38@manjaro.org>
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

On 10/14/24 9:28 PM, Dragan Simic wrote:
> On 2024-10-14 21:17, Alex ThreeD wrote:
>> On Mon, Oct 14, 2024 at 10:00 PM Dragan Simic <dsimic@manjaro.org> wrote:
>>> To sum up the replies from Marek, the lower limit should be 64.
>>
>> 64 by default, warning for custom values less than 32. Right?
>> Since 32 bytes is sufficient for kernels released in the last 2 years.
> 
> I'd keep both the default and the warning threshold at 64.  I think
> it's much safer that way.

Sounds good to me, thanks !
