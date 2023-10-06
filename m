Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFCDE81DFB
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 13:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0D69869A4;
	Fri,  6 Oct 2023 15:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="lr98WlEB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B9FD869F5; Fri,  6 Oct 2023 15:26:30 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF9C88695F
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 15:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6313424000E;
 Fri,  6 Oct 2023 13:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1696598787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rD+feCzcfJkIl8kp+JVJ976uKjcnnLv2NpWqofF+1yY=;
 b=lr98WlEBGPzy4f7lXLZBHTfI6v/ZiefG6yryOZIqwk3CQMVSUDOiI0Nl6mTyc+aVeNuSUT
 a1hGev5ukiXEJNB5pc6zpJ75vBznHVjRJxP9G8xghjg+T0u6sy9zgDexk2/Y4l5BaS/PiW
 mKeHuv1+clqFd3mT7WL1pVVCbUAXH0XngC2CWWmPzPkSjjYGQshSOlGhzcYIOOQ9/WBXXc
 PrpKIJIexmE8QQi8EaCydrAJI3sit2eUZyzENhXnNLRTdtAxo3E4jgKFix8Tn0zjyirCmX
 b4FvJIvZoWN++QpAQOxPZKGic5lOFslbOMci1/IFTBSZyn3v7rxA/1sZSWXtNw==
Date: Fri, 6 Oct 2023 15:26:25 +0200
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 vigneshr@ti.com, trini@konsulko.com, srk@ti.com, robertcnelson@gmail.com,
 u-boot@lists.denx.de, "Francis, Neha" <n-francis@ti.com>
Subject: Re: [RFC PATCH 2/2] board: ti: am65x: Move to using Extension
 framework
Message-ID: <20231006152625.68903ab6@kmaincent-XPS-13-7390>
In-Reply-To: <263918be-381e-44b6-899e-321ecaabb2bc@kernel.org>
References: <20230710145026.128481-1-rogerq@kernel.org>
 <20230710145026.128481-3-rogerq@kernel.org>
 <CAPnjgZ1odo6F7RTumJ6A=+kgZ-pm0JnRvxNYB00HX7YpAyrFXg@mail.gmail.com>
 <574c8eb0-4c19-72ef-5920-e506e4be6203@kernel.org>
 <20230713184438.y3ac7c425fwu575b@radiantly>
 <263918be-381e-44b6-899e-321ecaabb2bc@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: kory.maincent@bootlin.com
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

On Wed, 4 Oct 2023 15:39:23 +0300
Roger Quadros <rogerq@kernel.org> wrote:

Hello,
Thanks for adding me in cc. Also it seems I forgot to add myself to MAINTAINERS
for the extension_board.c file.

> >>> Before this goes too far I think this should move to using a linker
> >>> list to declare the driver (or a driver-model driver if you prefer,
> >>> but that might be overkill).  
> 
> So I've been working on this on the side and got linker list way working
> with custom script booting but as soon as I move to standard boot flow
> it no longer works. This is because there is no code in place to
> apply the overlay and pass it to next stage e.g. EFI.
> 
> I see the following note at
> https://elixir.bootlin.com/u-boot/latest/source/boot/bootmeth_efi.c#L304
> 
> "
>                 /*
>                  * TODO: Apply extension overlay
>                  *
>                  * Here we need to load and apply the extension overlay. This
> is
>                  * not implemented. See do_extension_apply(). The extension
>                  * stuff needs an implementation in boot/extension.c so it is
>                  * separate from the command code. Really the extension stuff
>                  * should use the device tree and a uclass / driver interface
>                  * rather than implementing its own list
>                  */
> "

I agreed that the extension implementation should move in boot/extension.c or
common for general use. I am wondering what the advantage of creating an uclass
interface?
I am not an uclass expert but there is no per driver ops and usage. What do you
dislike about using its own list?

> Another note at
> https://elixir.bootlin.com/u-boot/latest/source/cmd/extension_board.c#L198
> 
> "/* extensions should have a uclass - for now we use UCLASS_SIMPLE_BUS uclass
> */"
> 
> So are we better off implementing a class driver for extension stuff?

I think the first point should be to move it in common or boot and makes it
generic for using the extension function everywhere. I will let Simon answer
about the uclass part.

Regards,
