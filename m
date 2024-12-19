Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B0AE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96C3180328;
	Thu, 19 Dec 2024 16:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VY1KPzl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCAF18033A; Thu, 19 Dec 2024 16:08:39 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7696A8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa66e4d1d5aso137230566b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 07:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734620917; x=1735225717; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8YZvAhvXpHv9BarT5YjflyhL6swTAwlXx3wzVkO8oL0=;
 b=VY1KPzl4zR5BbAVmxfKLYCeUYlXUNSxrG1RCBjv1cAvgpuOJHKmXM61B38NWMUcC1U
 H4d7vrv1QE0Gz0Jb0qy4mrWfk3U3ugOGWVhmUS8+4og0ghYOpgjsFGzS5UUP/Ev3HzKS
 VD9GnoiHoMtwb/0QeS9YocuA/OiQ0WdrZMNkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734620917; x=1735225717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8YZvAhvXpHv9BarT5YjflyhL6swTAwlXx3wzVkO8oL0=;
 b=XbJe2nHL3b1rBJapDt4WM15Cvd4mkoJmIVa1xP4m8GM2EUAolXa7PgRjH0I1/rh1GG
 FUkqGH/QkYUD65g/ZtgnEKAdy9CGesjbYLoCpVZCqfjnlswTuXDpO3YIkw9GA5sYEb1i
 sjNIxZrVtjk2wVyHbvMq89Zt73CYzYOjUeq4MVsHRGppGuwrNTuynAeLj98FGwzvygmE
 Auc+05FKSLtiuryhrTjJmlyLA360BJisanWVzQrValwrkOl2clkZOJvxcsiX1FOoMO7c
 2HMM1uS/Yaecqagkf2p8ZuH4866m3Q6nwfGOxdCjPP4AVCw9Y79FGDkV4jYF+av3Eq6z
 N/jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9V6FKn8cnSydRLonxZvMVaZnVkfKbgSNgUSkCBrwLDIKVQj3iRtQnFKZqGR9wM6gJg2zMw/Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzQKdnedhuQeSWqxosXa6I68cysQsZxxbOwrCT5fPBpjEWiYICx
 gezzm7fXs/rzvBW/ofpwyvzVc6v4obFWvoqXJK2FYqr91cfM0axcAU4IfIH4GjhTa7Ev00QQW98
 iBWcmDO3Dt7DsZ4FYwAINkfKXvuDQ1j4LxV3I
X-Gm-Gg: ASbGncsuNwGgmChbFSQnBLY/mP41Wdej2gs53+rKx+wMoTMGz4+gCX4jEWJvBEzzpyN
 djKnz1YJEvJXl63FzyXrwILf2QB2SgC95VBR1l+4=
X-Google-Smtp-Source: AGHT+IFADOqkgvYjAS9OXFNWBQ4RHvhT9LQWq9xRJuHRMwfhN2LqvRgeubbgmIzIM81ceiIjOgRn+o9051XIP0rKU24=
X-Received: by 2002:a17:906:310c:b0:aa6:668b:2733 with SMTP id
 a640c23a62f3a-aac07954ca7mr277669166b.33.1734620916691; Thu, 19 Dec 2024
 07:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20241217-b4-upstream-dm-pre-reloc-v1-1-ccd29165bbb6@ti.com>
 <20241217145300.GN1505244@bill-the-cat>
 <20241218050837.5fppn7j7s5vv5f5m@uda0497581>
 <20241218173837.GJ1505244@bill-the-cat>
In-Reply-To: <20241218173837.GJ1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Dec 2024 08:08:25 -0700
Message-ID: <CAFLszTjCez6yRW1F9HayLPk3deqPEAx-4uwYfpLcaQft=az-+A@mail.gmail.com>
Subject: Re: [PATCH] drivers: firmware: ti_sci: Add DM_FLAG_PRE_RELOC to driver
To: Tom Rini <trini@konsulko.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Wed, 18 Dec 2024 at 10:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 18, 2024 at 10:38:37AM +0530, Manorit Chawdhry wrote:
> > Hi Tom,
> >
> > On 08:53-20241217, Tom Rini wrote:
> > > On Tue, Dec 17, 2024 at 02:24:37PM +0530, Manorit Chawdhry wrote:
> > >
> > > > Currently the driver relies on bootph flag to probe it during PRE_RELOC
> > > > stage but with the upcoming cleanup of v6.13, we don't have the bootph
> > > > property in the parent nodes anymore and ti_sci driver being one of the
> > > > parent nodes required during SPL stage would end up hampering the probe
> > > > model [0].
> > > >
> > > > Add DM_FLAG_PRE_RELOC to ti_sci driver for mitigating this issue.
> > >
> > >
> > > Can you please expand on why with v6.13 we don't have the flag anymore?
> > > Thanks.
> >
> > So the idea was that following series [0] would help us cleanup all the
> > parent node bootph-* tags as putting a bootph-* in child node implies
> > that it applies to parent nodes as well, though even if the parent node
> > gets packed after the following series, the parent node still don't get
> > probed as from my understanding, we need bootph-* tag to probe the
> > driver as well but the phase tag doesn't get propagated as such.
> >
> > So while working in Linux, some comments related to this was raised [1]
> > and after confirming the behaviour with Simon [2], the cleanup was done
> > in Linux and meanwhile this way was found to probe the driver so that
> > even after cleaning up the parent bootph-* tags we can continue.
> >
> > I don't think it's a hack also as this driver is required pre-relocation
> > and this is another way to probe it pre-relocation but the only thing is
> > that since the cleanup is done right now, we would kind of need it to be
> > booting in some platforms ( that were fully reliant on Linux DT and
> > don't have -u-boot override for this particular node with bootph-* )
> > before 6.13 DT gets synced up.
> >
> > [0]: https://lore.kernel.org/u-boot/20231217163627.2339802-1-sjg@chromium.org/
> > [1]: https://lore.kernel.org/all/20240709084857.nf7c57mi6miajeau@uda0497581/#t
> > [2]: https://lore.kernel.org/u-boot/CAFLszTjr7bJFPnyVx7rTdFB3AFBM_2DVAZU8FZnLBE7ep5ejXw@mail.gmail.com/
>
> Thanks. Did you end up filing an issue about this? And can you now
> perhaps push to make doing the fdtgrep work a priority? There's going to
> be a lot of other cases like this to resolve I suspect.

fdtgrep is done, the confusion is that there are two [0] references in
this chain. The one you want is:

https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/21

For SPL and U-Boot proper, all is well. But for pre-relocation, U-Boot
doesn't actually bind parents even if their children have a bootph
property, as I understand it. I believe that is what needs to be
fixed?

Regards,
SImon
