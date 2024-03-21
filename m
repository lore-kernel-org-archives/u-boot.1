Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3880C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 15:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 050088785E;
	Thu, 21 Mar 2024 16:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="YjNJS9vm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E61048809A; Thu, 21 Mar 2024 16:13:27 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C2268785E
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 16:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dcc6fc978ddso951615276.0
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1711034004; x=1711638804;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H7X2hfy3ofWBS/bsrAFWs06k8LcQOmX3i6timUkDkpY=;
 b=YjNJS9vman4BaF/soXl8w9H6AhTgmWvdeEhYQ6Jf72Hi0WYvMq3X4/TJeLFDQ29ibh
 N+h9mXS6WqPGrCsDjaI/b/+7fVo8eCGvZUXIbDvjM0WvS5E2pL2RUr+2K4zjDG4zMaMR
 rC/EfhWGXkzDeNru+rxBLoEi/twa8gcxmkO4bL0xHpaU7++J7op8FaZzhBiyy+dsEHQn
 duJ1ZXmhTk+Ec7meUP9Et0ags0wnzmj2Ax3HDBAsA9jUizR9bdIMnPkuc0zudRv06Esk
 +PVbQP9/yK6wDvqCnYl9eVpIUuJb0nZ4xe/vKzzvp8k87YMe8gKFDBJqVE7waJG06QjY
 cVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711034004; x=1711638804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H7X2hfy3ofWBS/bsrAFWs06k8LcQOmX3i6timUkDkpY=;
 b=KXs2e1djm66CdPourwt7J0WP0/NZlCYi87xtLD8IJM2muT0Z0EaLN9FTeQ+OUL1jZ4
 192EK3kzlAN03PuEJ0ZXn+bX/QRjpUdLgWcZ0rFP2/jKUVI9E5XPo3Mk7XwwicLyYB1B
 nTuoWPISrygwUYoahIVnmx3qCckpI3v5v4UXKeBlzGPJQYGBl9cJugNW/PsIXGe0Qyus
 SG8hZuU9TM9b1xZRFtZHSgml1WsLFTAOMJLdtjXhtNEG1QZrO4ls1UfocZYhpj89HH/S
 hi6mWeHIM7AVn0kmDage8uq48fy0uNsV3wK01/0ytBaqV5xKUuNm5mCn1fR4f1tQ+Z4b
 jA1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNUMrBaauvCR9NqpaKkYgnI/H4Wv+2UVXoeWCTMlwum8HGwc5YJVQ5QlFHAjbvz4QiFJbdDJYR+/7hmdOGHGWGuJ7HyQ==
X-Gm-Message-State: AOJu0YxsvzG7ZQpEW9QHjX2U2u+26eWmMARNFa83iWUZXSIR8dO6gnSd
 2Ae7fcoBSSf03Hdzg8z0G+X7WPw+iIznT3PQEFjqaIMcSxECvBshRVrlEwphsDGioLzbfNAWS+0
 aFDbfaxyACflIzBWp7yPJx4ixpzLATiWQdUlE
X-Google-Smtp-Source: AGHT+IHF604mPwH5mALGl0G6R/yKQk5j6THYD4eNrYWcNy4spnFISx2Jx2BCNPjninWYkTbZKuE6cE3EuRoAOVO4D2Q=
X-Received: by 2002:a25:c844:0:b0:dc6:c670:c957 with SMTP id
 y65-20020a25c844000000b00dc6c670c957mr1976750ybf.32.1711034003726; Thu, 21
 Mar 2024 08:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240320131928.1836386-1-lukas.funke-oss@weidmueller.com>
 <20240320131928.1836386-2-lukas.funke-oss@weidmueller.com>
 <20240320143048.GU3442575@bill-the-cat>
 <3866627e-de73-dbc7-fd8c-bb2b0d11b5cc@ti.com>
 <20240320153316.GW3442575@bill-the-cat>
 <20240320154952.4ee9052f@donnerap.manchester.arm.com>
 <f4d3d1b0-d7f2-42cc-9d70-4da1da14ea81@weidmueller.com>
In-Reply-To: <f4d3d1b0-d7f2-42cc-9d70-4da1da14ea81@weidmueller.com>
From: Michal Simek <monstr@monstr.eu>
Date: Thu, 21 Mar 2024 16:13:12 +0100
Message-ID: <CAHTX3dKAquWezSxsNYFB3e7ban4iBsCUrO2f8NdzjwKi0u7-Fg@mail.gmail.com>
Subject: Re: [PATCH 1/2] spl: Introduce architecture specific init function
To: Lukas Funke <lukas.funke-oss@weidmueller.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Devarsh Thakkar <devarsht@ti.com>, u-boot@lists.denx.de, 
 Lukas Funke <lukas.funke@weidmueller.com>, Bin Meng <bmeng@tinylab.org>, 
 Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=C4=8Dt 21. 3. 2024 v 8:55 odes=C3=ADlatel Lukas Funke <
lukas.funke-oss@weidmueller.com> napsal:

> On 20.03.2024 16:49, Andre Przywara wrote:
> > On Wed, 20 Mar 2024 11:33:16 -0400
> > Tom Rini <trini@konsulko.com> wrote:
> >
> > Hi,
> >
> >> On Wed, Mar 20, 2024 at 08:52:30PM +0530, Devarsh Thakkar wrote:
> >>> Hi Tom, Lukas,
> >>>
> >>> Thanks for the patch Lukas.
> >>>
> >>> On 20/03/24 20:00, Tom Rini wrote:
> >>>> On Wed, Mar 20, 2024 at 02:19:26PM +0100,
> lukas.funke-oss@weidmueller.com wrote:
> >>>>
> >>>>> From: Lukas Funke <lukas.funke@weidmueller.com>
> >>>>>
> >>>>> Some architectures use spl_board_init() in their architecture
> specific
> >>>>> implementation. Board developers should be able to add board specif=
ic
> >>>>> implementation via spl_board_init(). Hence, introduce a
> spl_arch_init()
> >>>>> method which is called right before spl_board_init() for architectu=
re
> >>>>> specific implementation.
> >>>>>
> >>>>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> >>>>
> >>>> I think this could allow for other SoCs to clean up their existing
> >>>
> >>> Does it make more sense to make this SoC specific then instead of arc=
h
> >>> specific to allow broader range of code?
> >>
> >> "soc" and "arch" are somewhat interchangeable at times, so I think we
> >
> > Isn't "arch" ambiguous anyway? I connect that with CPU architecture, as
> in
> > x86, ARM, RISC-V. And we have that in the top level directories:
> arch/arm,
> > etc.
> > But here it's one level below, isn't it? Where "platform" (or "plat")
> > would be a more suiting term to describe a SoC family, like xilinx or
> > sunxi?
> > So the hierarchy would be really: arch -> plat -> soc -> board?
> >
> > Or am I confused here?
>
> No. But in some cases the 'platform' level is missing: for xilinx it's
> "arch->arm->mach-zynq-><impl>", for rockchip it's
> "arch->arm->plat->soc", i.e. "arch->arm->mach-rockchip->rk3399-><impl>".
> If we follow your proposed rule it should be:
> arch->arm->mach-xilinx->zynq-><impl>. Maybe this is an idea for the next
> cleanup round?
>
> Regarding the patch:
>
> I'd agree that the init code is not (cpu)architecture dependent. Some
> vendors init the console, some init the ddr, some init the leds and so
> on. Thus, we should go one level upwards and change it to
> "spl_soc_init()" if everyone is okay with it?
>
>
In our case soc and plat are the same.
Arch is clear that's armv7/v8,
socs/platform are zynq/zynqmp/versal/versal-net
And boards are generic/kria or antminer, syzygy, topic, etc.

And agree that we should do some cleanup in this.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
