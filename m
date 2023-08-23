Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F43BEE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 08:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D3B86470;
	Wed, 23 Aug 2023 10:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tZojbxdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB79864BA; Wed, 23 Aug 2023 10:14:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FA7E8645F
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D8262620BA;
 Wed, 23 Aug 2023 08:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CD7C433C8;
 Wed, 23 Aug 2023 08:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692778462;
 bh=rRO2KTTs+Dvej1J85lvpEZ1j2tC2frT0Db+efNKqUv8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tZojbxdmCfK7BKPU21w7XTtOlnmHHnYRaDk3I1t6FjxPh2qzIemLi3XVgtEjWVx6L
 F6d0pGMbtVIU3hVZCK11wcbf9eig9GmjLbwH5Uy7dY9qtfvTciJG0oxMBlBHbQ4aSi
 VjKmxIXo0OyROOpyW4Y/i3R8UQRUils4HaONO+vZYaCfU0VEPB9H5Tp/HnHRqSh26y
 QjaalX5jl1pCeBJl3Chcg4HGJmJORUlcCVGRkoOLLyfR1QCN1xy7m/8HGIJZdK1rzF
 FsOXnXnixQJc23GLBRu5pF32spakk137XbQbJzhXc3S36nHOE4NLA3d/v3o2JyeNas
 ncJAI2tDVpdYg==
Message-ID: <8b48a7a0-575d-83dc-877b-d134f85e6077@kernel.org>
Date: Wed, 23 Aug 2023 11:14:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] net: ti: am65-cpsw-nuss: Workaround for buggy
 PHY/Board
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, nm@ti.com, joe.hershberger@ni.com,
 robertcnelson@gmail.com, jkridner@beagleboard.org, r-gunasekaran@ti.com,
 srk@ti.com, trini@konsulko.com, Ramon Fried <rfried.dev@gmail.com>
References: <20230822121350.51324-1-rogerq@kernel.org>
 <20230822121350.51324-2-rogerq@kernel.org>
 <0348ec9c-a50e-1e03-2f7d-c7b82fefc1ed@ti.com>
 <de614af1-28b1-a6c9-e0e0-454646d0aba6@kernel.org>
 <040137da-f0bb-3aee-6dcd-4474bc2f4171@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <040137da-f0bb-3aee-6dcd-4474bc2f4171@ti.com>
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



On 23/08/2023 11:02, Siddharth Vadapalli wrote:
> 
> 
> On 23/08/23 13:22, Roger Quadros wrote:
>> Hi Siddharth,
>>
>> On 23/08/2023 07:35, Siddharth Vadapalli wrote:
>>> Roger,
>>>
>>> On 22/08/23 17:43, Roger Quadros wrote:
>>>> Beagleplay has a buggy Ethernet PHY implementation for the Gigabit
>>>> PHY in the sense that it is non responsive over MDIO immediately
>>>> after power-up/reset.
>>>>
>>>> We need to either try multiple times or wait sufficiently long enough
>>>> (couple of 10s of ms?) before the PHY begins to respond correctly.
>>>
>>> Based on the datasheet at:
>>> https://datasheet.lcsc.com/lcsc/1912111437_Realtek-Semicon-RTL8211F-CG_C187932.pdf
>>> in the section 7.17. PHY Reset (Hardware Reset), it is stated that
>>> software has to wait for at least 50 ms before accessing the PHY
>>> registers. Is this why the for-loop in the code below tries for at most
>>> 5 times with a delay of 10 ms before the next try? If yes, then isn't it
>>
>> Good catch. This might be the reason why PHY is not responding in the first
>> few attempts.
>>
>>> better to move the delay into the realtek PHY driver at
>>> drivers/net/phy/realtek.c
>>
>> We are currently at the MDIO bus driver where we don't even know what PHY
>> is on the bus. So this delay cannot come at the realtec PHY driver.
>> It has to come at the MDIO bus driver level.
> 
> Thank you for clarifying.
> 

Looking closer, this is already being addressed by drivers/net/eth-phy-uclass.c
in eth_phy_pre_probe()

linux/Documentation/devicetree/bindings/net/ethernet-phy.yaml

  reset-assert-us:
    description:
      Delay after the reset was asserted in microseconds. If this
      property is missing the delay will be skipped.

  reset-deassert-us:
    description:
      Delay after the reset was deasserted in microseconds. If
      this property is missing the delay will be skipped.

So we can drop this patch once we implement proper uclass driver for cpsw-mdio.

>>
>>> Shouldn't it be the PHY driver which ensures that any reads/writes to the PHY
>>> registers are valid? It can ensure this by having a one time 50ms delay for the
>>> very first access to the PHY registers.> 
> 
> ...
> 
>>>
>>
> 

-- 
cheers,
-roger
