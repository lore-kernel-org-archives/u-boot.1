Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E952C54798
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 05:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73D1487A80;
	Thu, 29 Feb 2024 06:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jRBgLifs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96858880AA; Thu, 29 Feb 2024 06:47:43 +0100 (CET)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE4187A80
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 06:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4d34144d710so289324e0c.1
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 21:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709185660; x=1709790460; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xr8+zhp/nNpivSjChJvMAo5ErVoIp3CVf93m5oB6fZA=;
 b=jRBgLifsEMLQqSQYmj+F3+W4065qySH8TzR8MPMNXqjwlkUvim6a1h1RNvfJJSBZUg
 qndCRJ1ycJE6z2G7kezbU1wI7g6e0GzzzX/eyRTzhp5IS8qvnA8ge/Zc9ORxZNB03q5Y
 xgdY5YMamzDOviE0uTTTe4cjFMCVN4hG6UL+hpvzxoB2fkcYptt9VkLN3Jw9Se4s6aSc
 UBF6PyG63xkBDs9D3hotC9CNW0p4OwDDWpBrkg9k5SFJB6WlA8eJT+1I1lwBx4gLnCXX
 R435bl/FJWfNK0AzRy07N5wqZrhnzdmAJyr5B6vetbfm3OmNh1pMf/w0bUgP7nalspEw
 MMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709185660; x=1709790460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xr8+zhp/nNpivSjChJvMAo5ErVoIp3CVf93m5oB6fZA=;
 b=JyJU4YToGmIbbIY6HoSWO0v1sbUlOqCRUMDuulmwFkC4dfNi2WSN6mi5Gsz1yga4v7
 lzFZ8LRX72hdRyiDClPQdvvmb7paI9Nk7SQZdrDgel7JFGZSmFqrf6DxGzqqyiglxrmA
 qEOjKeCR/GnbJZ99T7TA2Sepf64kaL5av6Xcjb/bw8qpkaqzD4Q/a6NK7Kx+EB4/tbp2
 Rg+uXcnJP2sWemOb8y2DQzR1bc8KDHeZygGe5fhRKO7XcYc/gMqiEFsB5R8iaU/7+a3F
 Sc2XKM3Jx6lKJvnONbgoKeoLMB7R+MlHmwp5zVRPKEWyb6uLWsFLmV1kDWa8dFaIEKwg
 1Xiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeJvr7qk2GiE53JMRvr/Qpa6r6N+Zt5WU++BJmhw6x78g4i8SNaoWpZOHBTJul9wY5JU95e3z1hxEPBzLn67nCJXz6qg==
X-Gm-Message-State: AOJu0YxEUX5oNtCwxjJJj5GWgZZAzciq3pG4Pnux/SWv35kXYgB93WDZ
 c/BijuD0DeyhUuu/eTz9sDkMbn7TLm6vy0y3OWIg8LgXFID1HhJV4UzkdbGtLQJjWiaCpCBwVUh
 cfB4NsweobOncn/TM2hIIqgugieY8kPnGVJyW1g==
X-Google-Smtp-Source: AGHT+IGBIccP+3ySu7WNL+3SUfOhXdQnG5ZFgC/WWAFdJdoBMQWSaa0KnVsBkTmiIU3mfwkgQfXHv1xWzP9UBZJMH+A=
X-Received: by 2002:a05:6122:1b85:b0:4ce:96b7:c2f6 with SMTP id
 es5-20020a0561221b8500b004ce96b7c2f6mr396280vkb.5.1709185659762; Wed, 28 Feb
 2024 21:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
 <47c12ca3-ea7c-4097-90b5-0333c74b05aa@moroto.mountain>
 <20240228131029.GM3040305@bill-the-cat>
 <CAFA6WYN4sCk9Q66i_n+aXxRkGEbh66dh+Sr_C5SbioQ_s5BBbQ@mail.gmail.com>
 <20240228152034.GN3040305@bill-the-cat>
In-Reply-To: <20240228152034.GN3040305@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 29 Feb 2024 11:17:28 +0530
Message-ID: <CAFA6WYMkdjE6Vrd2_fV_6Rzj8MOiPhO4EJ4kkik1_9vQnhzMqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
To: Tom Rini <trini@konsulko.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, 
 shawnguo@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 28 Feb 2024 at 20:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 28, 2024 at 07:44:42PM +0530, Sumit Garg wrote:
> > + Shawn, Krzysztof, Conor
> >
> > Hi Tom,
> >
> > On Wed, 28 Feb 2024 at 18:40, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Feb 28, 2024 at 10:09:13AM +0300, Dan Carpenter wrote:
> > > > On Tue, Feb 27, 2024 at 04:40:01PM +0100, S=C3=A9bastien Szymanski =
wrote:
> > > > > Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees wi=
th
> > > > > linux") removed the display timings from the board device tree wh=
ereas
> > > > > they are still needed by the mxsfb driver.
> > > > > Add the timings back (the correct ones) in the
> > > > > imx6ul-opos6uldev-u-boot.dtsi file and remove them from the
> > > > > opos6uldev.env file.
> > > > >
> > > > > Update the opos6uldev_defconfig file so that the LCD turns on at =
boot.
> > > > >
> > > > > Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees wi=
th linux")
> > > > > Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@arma=
deus.com>
> > > >
> > > > Huh.  This is the commit that did that upstream.
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Dd9aa4d4fca67823838fe9861456201430c545e69
> > > >
> > > > It's interesting how the timings in linux were always slightly diff=
erent
> > > > from in u-boot.
> > >
> > > Thanks for tracking that down, Dan. I'm adding in Sumit and Rob here
> > > because this is a recent (rather than ancient) example of one of the
> > > concerns about OF_UPSTREAM.
> >
> > I rather think about this as an opportunity to improve with
> > OF_UPSTREAM. We can feed these kinds of DT ABI breakages to
> > corresponding Linux kernel sub-arch maintainers. Especially once we
> > move to OF_UPSTREAM and a sub-arch maintainer profile in Linux kernel
> > to keep them aware that U-Boot should be considered too.
>
> Yes, a more extensive check around when removing information from dts
> files would be good.
>
> > > I think the commit in question can be
> > > summarized as "remove a bunch of explicit HW information because ther=
e's
> > > now a Linux Kernel driver that determines that dynamically". What do =
we
> > > do next? The old information is in a presumably valid binding still, =
can
> > > we just put it back and comment that consumers outside of Linux use t=
his
> > > still so it's not removed again later? Or am I just missing where we =
can
> > > instead get this information from the DT still and not need to come u=
p
> > > with a new driver and subsystems?
> >
> > I can see following two paths forward:
> >
> > 1) Partially revert the Linux kernel commit to add back the display
> > timings in DT.
> > 2) Extend drivers/video/simple_panel.c in U-Boot to add support for
> > compatible: "armadeus,st0700-adapt".
> >
> > If possible then I would be in favour of (2) rather than the current
> > patch to do this properly.
>
> Well, looking at the kernel drivers/gpu/drm/panel/panel-simple.c driver
> and then our drivers/video/simple_panel.c it sure would be nice if it's
> just a matter of adding a compatible but I wouldn't be surprised if it
> ends up needing more information being passed along too?

Although I am not a LCD panel expert but looking at the kernel driver
code [1], the display timings are rather taken from a static data
structure matching the compatible "armadeus,st0700-adapt".

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/gpu/drm/panel/panel-simple.c#n901

> And I'm going
> assume there's good reasons for the design change in how the drivers
> work in Linux now and note that it might make things more challenging
> for us when we do care about space.

I agree it is always going to be challenging to use DT during SPL
stage which is mostly constrained by limited on-chip RAM.

-Sumit

>
> --
> Tom
