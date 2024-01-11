Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF134C47258
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 14:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E80E186EE2;
	Thu, 11 Jan 2024 15:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YS5hIzXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CCF886EE2; Thu, 11 Jan 2024 15:14:40 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A6D487250
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 15:14:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 92234B82052;
 Thu, 11 Jan 2024 14:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5729C43399;
 Thu, 11 Jan 2024 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704982474;
 bh=7dheqGIlZtF4e6A/f5laFnKhEjzU/dvmlNzWzS7emZs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YS5hIzXCH8f3YdS1lB9wHVBFDxsEP+WQb65tXmGP59WnQaEPsuhKV7E7lbAGgZRBe
 0Bmj2Rx1a5P/JSc94urMURKTxUcCKYcRrGUjYMlBi62Qb8h9nttqa5u0LuQFQHK3jn
 bSsKWPHXPUPYlnLQeY058rkbLtj43VVz9jYdYOzTikIitagig5TKCmNblCedcFcDD1
 WM1zYoGtXEpgNjpt3rSg6ERStPPJepENa0YVS58vHIONz4OqjicoLmeAaq4V7nnpCE
 EztPxuJXd8g3U8qTOlJM1Yx3OySqUJxFz5LV6svb3RrsqCRnqPuqti6zSD63iQ2kHM
 HUBl0FLyG7t2Q==
Message-ID: <c9eb7560-354e-4269-b433-269971210036@kernel.org>
Date: Thu, 11 Jan 2024 16:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] board: ti: am65x: Move to using Extension
 framework
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, =?UTF-8?Q?K=C3=B6ry_Maincent?=
 <kory.maincent@bootlin.com>
Cc: Nishanth Menon <nm@ti.com>, vigneshr@ti.com, trini@konsulko.com,
 srk@ti.com, robertcnelson@gmail.com, u-boot@lists.denx.de,
 "Francis, Neha" <n-francis@ti.com>
References: <20230710145026.128481-1-rogerq@kernel.org>
 <20230710145026.128481-3-rogerq@kernel.org>
 <CAPnjgZ1odo6F7RTumJ6A=+kgZ-pm0JnRvxNYB00HX7YpAyrFXg@mail.gmail.com>
 <574c8eb0-4c19-72ef-5920-e506e4be6203@kernel.org>
 <20230713184438.y3ac7c425fwu575b@radiantly>
 <263918be-381e-44b6-899e-321ecaabb2bc@kernel.org>
 <20231006152625.68903ab6@kmaincent-XPS-13-7390>
 <CAPnjgZ1UQ6YxrDcSeC0+XAAG295ZCJFYWF8ojiFSqkvZYYoz7A@mail.gmail.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <CAPnjgZ1UQ6YxrDcSeC0+XAAG295ZCJFYWF8ojiFSqkvZYYoz7A@mail.gmail.com>
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

Hi Köry,

On 06/10/2023 19:47, Simon Glass wrote:
> Hi Köry,
> 
> On Fri, 6 Oct 2023 at 07:26, Köry Maincent <kory.maincent@bootlin.com> wrote:
>>
>> On Wed, 4 Oct 2023 15:39:23 +0300
>> Roger Quadros <rogerq@kernel.org> wrote:
>>
>> Hello,
>> Thanks for adding me in cc. Also it seems I forgot to add myself to MAINTAINERS
>> for the extension_board.c file.
>>
>>>>>> Before this goes too far I think this should move to using a linker
>>>>>> list to declare the driver (or a driver-model driver if you prefer,
>>>>>> but that might be overkill).
>>>
>>> So I've been working on this on the side and got linker list way working
>>> with custom script booting but as soon as I move to standard boot flow
>>> it no longer works. This is because there is no code in place to
>>> apply the overlay and pass it to next stage e.g. EFI.
>>>
>>> I see the following note at
>>> https://elixir.bootlin.com/u-boot/latest/source/boot/bootmeth_efi.c#L304
>>>
>>> "
>>>                 /*
>>>                  * TODO: Apply extension overlay
>>>                  *
>>>                  * Here we need to load and apply the extension overlay. This
>>> is
>>>                  * not implemented. See do_extension_apply(). The extension
>>>                  * stuff needs an implementation in boot/extension.c so it is
>>>                  * separate from the command code. Really the extension stuff
>>>                  * should use the device tree and a uclass / driver interface
>>>                  * rather than implementing its own list
>>>                  */
>>> "
>>
>> I agreed that the extension implementation should move in boot/extension.c or
>> common for general use. I am wondering what the advantage of creating an uclass
>> interface?
>> I am not an uclass expert but there is no per driver ops and usage. What do you
>> dislike about using its own list?
> 
> I looked at this briefly for bootstd and left it alone, partly for this reason.
> 
> The operations I know about are:
> - scan for extension boards to produce a list: needs to happen at
> start of 'bootflow scan' I think)
> - applying relevant overlays: needs to happen in the read_bootflow()
> method perhaps
> - listing available extensions
> 
> I think a uclass makes sense, along with separating out the
> 'extension' command from the actual functionality.

What do you think about this?
OK to move extension card driver to uclass?

> 
>>
>>> Another note at
>>> https://elixir.bootlin.com/u-boot/latest/source/cmd/extension_board.c#L198
>>>
>>> "/* extensions should have a uclass - for now we use UCLASS_SIMPLE_BUS uclass
>>> */"
>>>
>>> So are we better off implementing a class driver for extension stuff?
>>
>> I think the first point should be to move it in common or boot and makes it
>> generic for using the extension function everywhere. I will let Simon answer
>> about the uclass part.
> 
> I believe this relates to boot/
> 
>>
>> Regards,
> 
> Regards,
> Simon

-- 
cheers,
-roger
