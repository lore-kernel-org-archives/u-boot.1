Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED20C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 06:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1E6F87D64;
	Fri,  1 Mar 2024 07:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s7NnwM9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9747E87D57; Fri,  1 Mar 2024 07:02:51 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B08987D65
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 07:02:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7d6024b181bso844365241.2
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 22:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709272965; x=1709877765; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJklpmd6ESUBnpgZFzpt4eUwrV2+dvk7bFbt3qaDZ2k=;
 b=s7NnwM9wYTry+I7uJ9siVaSpp6dcKhDokBWJ1db3RVIKq7eY15dQRYEVRvu+b6+e7L
 pkP7phR+vjYkNi5ysRCjjVVX7sdZJPEC5GjiZw+IPaGCtaPCTQmtKjLn8P5pVWesYx++
 58d8L8PiM0qsXAk53wTQ1WXIkjWNcVhSd9pAyYwXFpcv24r1gGy2JHziTP1cLyFNQF8Q
 Wzqwab+SUXs05ZwNtX1DLVtPqFkesHUXhBEo5tj/O8+L16uGDAWOYCKs3l0l4e+vwPSJ
 XhoQNWSHNsYVRzWFQWnbksYQbXykwIjpDdCJZSMabHOYpuBKCpZALU1tL4ZJAJdaFSkB
 EUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709272965; x=1709877765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJklpmd6ESUBnpgZFzpt4eUwrV2+dvk7bFbt3qaDZ2k=;
 b=l6k9C57jejmktCs4kCJvyj58p4vdD8XFNncnJwnX3F8JiJaGTkal7GkG8RThSNvtBm
 ZLQjkAuU9zrXgEI7DNPq83jWIeVZ/wlKlJgX0Vqgt/5+6WAhS8DsNSZv4ZJrERisX3+p
 JCkScshQB4SMLyn89qMXVqY4pcernNDWTyMAgi6W37wL/Gao2RYs/snXGIJVl0q1nrwb
 4GCcUl0xPCh2r4XSz6Mri/77+mt56ytM1rn2lyf0UdO711BBDY0E+9I/M6L7JBierO7w
 zudDy0JOk0PU/DxcdfuVuO5WZEO2vGzi0hkCUo03sMs7tMnCGX/mOUHyNywZewrlsGTS
 PPUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc30TO8cpzsT8H6H1uIBtzc6uw0WdoeyYZsfRcJzqLzeVn1v2WhXnbi5BOakayCECoDYgCsfp4NJdq5P41D1WlI7ZI8A==
X-Gm-Message-State: AOJu0YyosvXzQLiY80BFOjx34wVE2Sai2H7r2lLiNfRivb+cTQGZj6w1
 VpESKGQODahQh7y26fnbUFNRofA6ejC5ThDR4LrTicslri0KFZAR1wZ75L3hTyds8CyaemrbkBp
 iVLAXFN1qHUX4zbQ4r3CsONVXx+uq9oXQTLlSDA==
X-Google-Smtp-Source: AGHT+IHRooEn8Xq6Nf79ml99e43lrQZIvNNfCyQbtXWLROy5T9P4IZ2DbQTpkB3U3h319H5eoM5JYV24cC/Gt/nygLQ=
X-Received: by 2002:a05:6102:3a4c:b0:470:5cbc:4f46 with SMTP id
 c12-20020a0561023a4c00b004705cbc4f46mr478940vsu.9.1709272965194; Thu, 29 Feb
 2024 22:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
 <47c12ca3-ea7c-4097-90b5-0333c74b05aa@moroto.mountain>
 <20240228131029.GM3040305@bill-the-cat>
 <CAFA6WYN4sCk9Q66i_n+aXxRkGEbh66dh+Sr_C5SbioQ_s5BBbQ@mail.gmail.com>
 <20240228152034.GN3040305@bill-the-cat>
 <CAFA6WYMkdjE6Vrd2_fV_6Rzj8MOiPhO4EJ4kkik1_9vQnhzMqQ@mail.gmail.com>
 <20240229134242.GR3040305@bill-the-cat>
 <20240229140140.GS3040305@bill-the-cat>
In-Reply-To: <20240229140140.GS3040305@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 1 Mar 2024 11:32:33 +0530
Message-ID: <CAFA6WYPkSd=roYiZrK-9oKOse+zTsbtBj8mrgV=HHFVHtCwHGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
To: Tom Rini <trini@konsulko.com>, shawnguo@kernel.org, 
 Fabio Estevam <festevam@gmail.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Rob Herring <robh@kernel.org>,
 u-boot@lists.denx.de, 
 Stefano Babic <sbabic@denx.de>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
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

On Thu, 29 Feb 2024 at 19:31, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 29, 2024 at 08:42:42AM -0500, Tom Rini wrote:
> > On Thu, Feb 29, 2024 at 11:17:28AM +0530, Sumit Garg wrote:
> > > On Wed, 28 Feb 2024 at 20:50, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Feb 28, 2024 at 07:44:42PM +0530, Sumit Garg wrote:
> > > > > + Shawn, Krzysztof, Conor
> > > > >
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 28 Feb 2024 at 18:40, Tom Rini <trini@konsulko.com> wrote=
:
> > > > > >
> > > > > > On Wed, Feb 28, 2024 at 10:09:13AM +0300, Dan Carpenter wrote:
> > > > > > > On Tue, Feb 27, 2024 at 04:40:01PM +0100, S=C3=A9bastien Szym=
anski wrote:
> > > > > > > > Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise device tr=
ees with
> > > > > > > > linux") removed the display timings from the board device t=
ree whereas
> > > > > > > > they are still needed by the mxsfb driver.
> > > > > > > > Add the timings back (the correct ones) in the
> > > > > > > > imx6ul-opos6uldev-u-boot.dtsi file and remove them from the
> > > > > > > > opos6uldev.env file.
> > > > > > > >
> > > > > > > > Update the opos6uldev_defconfig file so that the LCD turns =
on at boot.
> > > > > > > >
> > > > > > > > Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise device tr=
ees with linux")
> > > > > > > > Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymansk=
i@armadeus.com>
> > > > > > >
> > > > > > > Huh.  This is the commit that did that upstream.
> > > > > > >
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3Dd9aa4d4fca67823838fe9861456201430c545e69
> > > > > > >
> > > > > > > It's interesting how the timings in linux were always slightl=
y different
> > > > > > > from in u-boot.
> > > > > >
> > > > > > Thanks for tracking that down, Dan. I'm adding in Sumit and Rob=
 here
> > > > > > because this is a recent (rather than ancient) example of one o=
f the
> > > > > > concerns about OF_UPSTREAM.
> > > > >
> > > > > I rather think about this as an opportunity to improve with
> > > > > OF_UPSTREAM. We can feed these kinds of DT ABI breakages to
> > > > > corresponding Linux kernel sub-arch maintainers. Especially once =
we
> > > > > move to OF_UPSTREAM and a sub-arch maintainer profile in Linux ke=
rnel
> > > > > to keep them aware that U-Boot should be considered too.
> > > >
> > > > Yes, a more extensive check around when removing information from d=
ts
> > > > files would be good.
> > > >
> > > > > > I think the commit in question can be
> > > > > > summarized as "remove a bunch of explicit HW information becaus=
e there's
> > > > > > now a Linux Kernel driver that determines that dynamically". Wh=
at do we
> > > > > > do next? The old information is in a presumably valid binding s=
till, can
> > > > > > we just put it back and comment that consumers outside of Linux=
 use this
> > > > > > still so it's not removed again later? Or am I just missing whe=
re we can
> > > > > > instead get this information from the DT still and not need to =
come up
> > > > > > with a new driver and subsystems?
> > > > >
> > > > > I can see following two paths forward:
> > > > >
> > > > > 1) Partially revert the Linux kernel commit to add back the displ=
ay
> > > > > timings in DT.
> > > > > 2) Extend drivers/video/simple_panel.c in U-Boot to add support f=
or
> > > > > compatible: "armadeus,st0700-adapt".
> > > > >
> > > > > If possible then I would be in favour of (2) rather than the curr=
ent
> > > > > patch to do this properly.
> > > >
> > > > Well, looking at the kernel drivers/gpu/drm/panel/panel-simple.c dr=
iver
> > > > and then our drivers/video/simple_panel.c it sure would be nice if =
it's
> > > > just a matter of adding a compatible but I wouldn't be surprised if=
 it
> > > > ends up needing more information being passed along too?
> > >
> > > Although I am not a LCD panel expert but looking at the kernel driver
> > > code [1], the display timings are rather taken from a static data
> > > structure matching the compatible "armadeus,st0700-adapt".
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/gpu/drm/panel/panel-simple.c#n901
> >
> > Yes. My point is that it seems like the situation changed from "device
> > tree provides timings for the platform" to "driver has timing
> > information for N displays" and so we'll need to do something clever to
> > avoid including the structs for 5 panels when we'll only ever
> > (likely...) see one. And that also yes, we'll probably need to add data
> > for this panel rather than re-use the PANASONIC_VVX10F004B00 data.
> >
> > > > And I'm going
> > > > assume there's good reasons for the design change in how the driver=
s
> > > > work in Linux now and note that it might make things more challengi=
ng
> > > > for us when we do care about space.
> > >
> > > I agree it is always going to be challenging to use DT during SPL
> > > stage which is mostly constrained by limited on-chip RAM.
> >
> > Well, no. The DT way handled this more efficiently, I think I wasn't
> > clear enough in my reply.
>
> And it's not just SPL, full U-Boot needs to stay small and within flash
> partition considerations and I become cranky and question people when
> non-generic changes impact platforms that don't need the change.
>

Okay I can see your point. I suppose this leads us to option (1) to
partially revert the Linux kernel commit [1] to add back the display
timings in DT. Ironically all the folks (developer, U-Boot and Linux
kernel iMX maintainers) were involved in the upstream process for the
Linux kernel commit [1] under question. So I will let them chime in
too.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dd9aa4d4fca67823838fe9861456201430c545e69

-Sumit

> --
> Tom
