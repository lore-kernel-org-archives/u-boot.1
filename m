Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F95AE81E10
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 15:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7A9486CB8;
	Fri,  6 Oct 2023 17:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PE6Cai4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FD086E22; Fri,  6 Oct 2023 17:48:46 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D2886BDF
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 17:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9A9CA61234;
 Fri,  6 Oct 2023 15:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28289C433C7;
 Fri,  6 Oct 2023 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696607319;
 bh=cs+oj3CzA4HPSvI17JejLWelHx6yrTzkBCV+ZtQuka4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PE6Cai4Hje9k7xEUbEyPJsA4PiAQTRHDwrUyK+aWTKRG5KALImCTauvmCUi0/E8d0
 LbOH1IbkHOkLnOqhp619Lu3J635mD8WptYiVh48llRCCZdQyn2t95WZ6BqVxLrW4Cn
 DPt78F2GYuNA4c6qyGFi+Oc/Wc9e+MsNR/S6aEGtUyRybR5Ljoz1XGi5ICdF2mmy3h
 jr9REcOgU6rGNxfxcTbYv71+Xd+S0IcTnm+wkwXFw8B0nhYyoDrfgA7H2nWbMiOkuZ
 s91/cB3uzViwusBxd/5h4LQpDsRGle1qpyrUkwrv3BbjKwvI5+SfQvPoNkQG9IerLQ
 8QMnkD+Hezgww==
Message-ID: <9332f63f-ad8a-40b1-ab5b-b768ca2824b5@kernel.org>
Date: Fri, 6 Oct 2023 18:48:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] board: ti: am65x: Move to using Extension
 framework
Content-Language: en-US
To: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>
Cc: Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 vigneshr@ti.com, trini@konsulko.com, srk@ti.com, robertcnelson@gmail.com,
 u-boot@lists.denx.de, "Francis, Neha" <n-francis@ti.com>
References: <20230710145026.128481-1-rogerq@kernel.org>
 <20230710145026.128481-3-rogerq@kernel.org>
 <CAPnjgZ1odo6F7RTumJ6A=+kgZ-pm0JnRvxNYB00HX7YpAyrFXg@mail.gmail.com>
 <574c8eb0-4c19-72ef-5920-e506e4be6203@kernel.org>
 <20230713184438.y3ac7c425fwu575b@radiantly>
 <263918be-381e-44b6-899e-321ecaabb2bc@kernel.org>
 <20231006152625.68903ab6@kmaincent-XPS-13-7390>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231006152625.68903ab6@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
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


On 06/10/2023 16:26, Köry Maincent wrote:
> On Wed, 4 Oct 2023 15:39:23 +0300
> Roger Quadros <rogerq@kernel.org> wrote:
> 
> Hello,
> Thanks for adding me in cc. Also it seems I forgot to add myself to MAINTAINERS
> for the extension_board.c file.
> 
>>>>> Before this goes too far I think this should move to using a linker
>>>>> list to declare the driver (or a driver-model driver if you prefer,
>>>>> but that might be overkill).  
>>
>> So I've been working on this on the side and got linker list way working
>> with custom script booting but as soon as I move to standard boot flow
>> it no longer works. This is because there is no code in place to
>> apply the overlay and pass it to next stage e.g. EFI.
>>
>> I see the following note at
>> https://elixir.bootlin.com/u-boot/latest/source/boot/bootmeth_efi.c#L304
>>
>> "
>>                 /*
>>                  * TODO: Apply extension overlay
>>                  *
>>                  * Here we need to load and apply the extension overlay. This
>> is
>>                  * not implemented. See do_extension_apply(). The extension
>>                  * stuff needs an implementation in boot/extension.c so it is
>>                  * separate from the command code. Really the extension stuff
>>                  * should use the device tree and a uclass / driver interface
>>                  * rather than implementing its own list
>>                  */
>> "
> 
> I agreed that the extension implementation should move in boot/extension.c or
> common for general use. I am wondering what the advantage of creating an uclass
> interface?
> I am not an uclass expert but there is no per driver ops and usage. What do you
> dislike about using its own list?

There would be per platform ops for probing the extension cards in a platform
specific way.

I already have a linker list way of doing this but stumbled upon Simon's
comments about using uclass for this.

> 
>> Another note at
>> https://elixir.bootlin.com/u-boot/latest/source/cmd/extension_board.c#L198
>>
>> "/* extensions should have a uclass - for now we use UCLASS_SIMPLE_BUS uclass
>> */"
>>
>> So are we better off implementing a class driver for extension stuff?
> 
> I think the first point should be to move it in common or boot and makes it
> generic for using the extension function everywhere. I will let Simon answer
> about the uclass part.
> 
> Regards,

-- 
cheers,
-roger
