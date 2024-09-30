Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC19CE835D
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89BB88900E;
	Mon, 30 Sep 2024 19:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727717708;
	bh=wodmrb4f0XlPuXC38UvmawtUYwE43SI6+f6H3StxQAY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uuwp9T8JgEoDZnpdPj2w5zBJyLKly+D2upZ7DOkzZW5Wc7VlpPBwuy033jbUTBSHN
	 sf7xVF8Ak+3qJRxU9Vpwym6d4qIHu2aWQZNps8pPvlBEPF8GXGn7unU1r5qUaOEAWf
	 3RfMW3em/8kak29GUkyQbAXK726RvaZfCRavs8hptsLXvfpConEz/5vSmQNhSKPKR3
	 290IpgRz9kBcsqJsFp1Ab0UUYx+l3CT2XeHfAp8jzUXgE6IGQgoNBDvLwiyhJjsbOT
	 cQC5gcY1mppg5Pok/I5DC5I7597caO5c7SVcJN5fFJ6Vg5QKxE2IIejGw6Gd/ytuMd
	 GrCjhKZ/4/oYA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5FD6988F94;
 Mon, 30 Sep 2024 19:35:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727717706;
 bh=wodmrb4f0XlPuXC38UvmawtUYwE43SI6+f6H3StxQAY=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=PsFVPFySAtKtFLC8jhnNFZMXZnZ4kJjGWhxRVc62qDqk2A49vGEsk3i7f5/Jsj5Ok
 5JWojxLxPqrkOYPYA4vPwVKh2tf0i0K87wsRL8K3KDlrLttD6DHBTHcRYL8j/V96qc
 3rUwQBtyboXlbw5WYvd26zpEHYC+cqG0L9b0CsSkwKi3/DJ0HozpH+Mb7EYz4WCvTJ
 kFWHRyUa3xbnqnvJI60WCIMo/iYyY+AgHyFUys4HqE/L2AutLtxNVNljNlP3ArgX+u
 uWVRzDdbFvoa3Bjy8uiUjsY2FWkY/DFwqieAFbCuqxkGJ5e6CspgqbXHvQ7vSWY/6t
 H6gfgdp6Gj0ZA==
Message-ID: <d4592568-472c-4dcd-97c9-bc5e7a60625f@denx.de>
Date: Mon, 30 Sep 2024 19:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 2/3] dts: Add ability to build DTOs only from
 arch/$(ARCH)/dts
To: Jan Kiszka <jan.kiszka@siemens.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20240927214955.394224-1-marex@denx.de>
 <20240927214955.394224-2-marex@denx.de>
 <CAFA6WYPPXDJC4kSiBAR=jL-Z0v3a8+=_=+hLx+Ug0+yu407y3Q@mail.gmail.com>
 <67761100-c52d-4949-8da3-8783782c44da@siemens.com>
Content-Language: en-US
In-Reply-To: <67761100-c52d-4949-8da3-8783782c44da@siemens.com>
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

On 9/30/24 8:10 AM, Jan Kiszka wrote:
> On 30.09.24 08:02, Sumit Garg wrote:
>> + Jan
>>
>> Hi Marek,
>>
>> On Sat, 28 Sept 2024 at 03:20, Marek Vasut <marex@denx.de> wrote:
>>>
>>> Currently the enablement of OF_UPSTREAM results on the build system
>>> searching for DTs only in dts/upstream/ . There are platforms which
>>> use U-Boot specific DTBOs applied on top of U-Boot control DT during
>>> SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.
>>
>> I would like to understand the need to maintain DTBOs separately from
>> DTBs. Why aren't we pushing DTBOs to Linux kernel sources as we do for
>> DTBs? Jan recently pushed those so-called U-Boot specific DTBOs for a
>> TI platform which were accepted in the Linux kernel upstream. This
>> patch will just deny the ability to build those DTBOs from dts
>> upstream tree. IMHO, this takes a step backwards on the whole notion
>> of OF_UPSTREAM.
> 
> Exactly - I was sent the other direction (get DTSOs upstream), and I'm
> now only waiting for 6.12-rc1-dts so that the first round to make use of
> that can be integrated into U-Boot [1]. Anything that would prevent that
> here is not welcome anymore.

I will only re-iterate what I wrote on my previous email, this commit 
does not prevent building DTBOs from dts/upstream/ , they are preferred. 
This only adds fallback to U-Boot local DTOs if the upstream DTOs are 
not upstream yet.

>> If we really want a middle ground solution to allow migration to
>> OF_UPSTREAM easier then we need to find a way to build DTBOs from both
>> directories (local and upstream dts). I would imagine that will likely
>> complicate building and packaging DTBOs.
> 
> I tried that, and I got the clear signal that it is not desired.

Is there a link to a discussion ?
