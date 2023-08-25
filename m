Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3517AC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 07:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21A38869AF;
	Fri, 25 Aug 2023 09:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KUYH09OD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CBB1869DD; Fri, 25 Aug 2023 09:52:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA95783F7D
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 09:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EDF3962C92;
 Fri, 25 Aug 2023 07:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B5CC433C7;
 Fri, 25 Aug 2023 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692949954;
 bh=N6e9TU+0AtfIDVnOb0pz/TUSDy7hV5YB+GnFiOMqUww=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KUYH09ODjNyGTFb68q9WxF7Gqb6prvGo+CAUsYF5hoh6m4yX5yeWB3WEc9gg59LoD
 GbCfq8bbFf5L16ssDkLlRHaxXNpyonAKejI/Iy/J1j9vNo4E+6OrxSE3Vu1Z0QyuaV
 vTuN5tg3qnuh1tftTLxY9SZdLJw6wGG5UH/bTsBFqWys4K+5vWJBGgoyKLkUResYwT
 BPvwakq/Y8x3QQ+3r/9DZGWuxF3Vc6nVlcFK0PBf37uHau7iYMnHyqXX8nsIsNVJ41
 VWrQOImrNzvfClD/RQH6N2JRqA/DLfvXxbprAw07wYO8JwMk4BWCYT3I875Zj8FbrS
 zHTy3pHSg5zJg==
Message-ID: <834b6e9b-6bfd-db10-5158-3100569400d7@kernel.org>
Date: Fri, 25 Aug 2023 10:52:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] net: ti: am65-cpsw-nuss: Workaround for buggy
 PHY/Board
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 nm@ti.com, joe.hershberger@ni.com, robertcnelson@gmail.com,
 jkridner@beagleboard.org, r-gunasekaran@ti.com, srk@ti.com,
 u-boot@lists.denx.de
References: <20230822121350.51324-1-rogerq@kernel.org>
 <20230822121350.51324-2-rogerq@kernel.org>
 <12738ca9-ac8c-b587-c0bf-c8abc8fd3f48@ti.com>
 <20230824182431.GE3953269@bill-the-cat>
 <203072fb-c847-b896-a249-eabe3c2631a0@kernel.org>
 <76153dc4-07e7-3c9b-8c2f-4e50d70b1679@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <76153dc4-07e7-3c9b-8c2f-4e50d70b1679@ti.com>
Content-Type: text/plain; charset=UTF-8
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

Siddharth,

On 25/08/2023 08:42, Siddharth Vadapalli wrote:
> Roger,
> 
> On 25/08/23 00:39, Roger Quadros wrote:
>>
>>
>> On 24/08/2023 21:24, Tom Rini wrote:
>>> On Thu, Aug 24, 2023 at 11:34:29PM +0530, Siddharth Vadapalli wrote:
>>>> Hello Roger,
>>>>
>>>> On 22-08-2023 17:43, Roger Quadros wrote:
> 
> ...
> 
>>
>> Even a single "PHY not found" print is not OK. It looks like an
>> error while it should not.
>>
>> The correct solution is to use the MDIO uclass framework and add
>> some generic handling in the class driver. drivers/net/eth-phy-uclass.c
>>
>> We could provide the delay time in the 'reset-deassert-us' property.
>> Although I'm not sure if this is the correct property for this case
>> as there is no RESET GPIO on the board. What we really want is delay
>> from power-on-reset. Which means we might have to introduce a new property
>> and use time from boot to determine if PHY is ready or not?
>>
>> NOTE: PHY ready time is different for hardware reset and power-on-reset.
>> 50ms vs 150ms
> 
> Another alternative could be that of implementing the for-loop within
> phy_connect() along with the delay, by updating the function with a new
> parameter "tries" which indicates the number of retries before finally printing
> "PHY not found" in case of an error. Optionally, another parameter "delay" can
> be added, which indicates the delay within the for-loop.
> 
> This implementation will require updating all drivers in drivers/net which use
> phy_connect(), with the "tries" parameter set to 1 for them. The am65-cpsw-nuss
> driver can set "tries" to 5 as done in the current patch.
> 
> The idea behind moving the for-loop within phy_connect() is that it will help
> solve the issue for other drivers as well, if they potentially encounter such
> buggy PHYs in future boards.
> 

This doesn't sound like a clean solution.
All hardware specific details (like reset ready-time) should come from the
device tree and not passed around in PHY APIs.

Why to do such an intrusive change instead of fixing the am65-cpsw-nuss driver
to properly use the PHY uclass driver model and encode the required delays
in the device tree?

-- 
cheers,
-roger
