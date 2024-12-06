Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DD0E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 23:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5074289100;
	Sat,  7 Dec 2024 00:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TL+P4L14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D2C88918B; Sat,  7 Dec 2024 00:41:52 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B22B89100
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 00:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa560a65fd6so460645966b.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 15:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733528509; x=1734133309; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m7/8rWXvrtpp4bV5UazZ69ZkcqjyDQasCAtJ4x8LSdU=;
 b=TL+P4L14OsFM0YaFRhUhuaHIIqfT++tvqbx5JIyI/6MnUu0nPaclmeAmXYlPr7CNlk
 PF6EdF5OdO1id6znEDRb30gC9VK2DkudsjY3HMD7HrfzBaYBxvrRoMa5DeA3wKLAh6hH
 ZZclkxkKqcYGwrFbia1aiJjsTQ5fVmNbYe3mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733528509; x=1734133309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m7/8rWXvrtpp4bV5UazZ69ZkcqjyDQasCAtJ4x8LSdU=;
 b=H0xfT0glPUalAmrzsJzgJ2auXUA0R2N1t27xATvzuLWTajOzpMVDDHiq2InMLtjiFW
 ZOMp6SyEdU6ZvKJ+Ta+tP8Pv6HDAoi2eiZcOq2GFwfkvx9myZ+13zSH03KK9sfifkXc3
 k8+f7ky7RpOtD+3k/ITHUdrCarCyuQHQKK7W5aFxQuvbM2PXmndHVqzm86Vq3j9o5vgH
 q1wBA8BQVvqvTGYFvqY4wHNyxGhaH0tuxJcdc1IVnYzlw7XMcu4vh/nRLH7w3GF3mB48
 InvcLaefbVNkiFv0ZUjX2Tdja9cJuYDy6jbHSYJx/KfF7ewty+drEgsfzWeVdKQzkaAi
 6fwg==
X-Gm-Message-State: AOJu0Yw+J8iLcX2OIFPFPDTQjr3epZgUwkC1MC1+kG96vYFxiEvMDBJd
 bkZK8BhRQgEjGyE/81dg6qO5MnP2apIF1V4WVxSeM9QiP6g4hjpGgv6bTFKT2VgYQvg8sjqT/kL
 amuiGKW7NjsqImLDfTap8YmfevnbFrLpERjhA
X-Gm-Gg: ASbGncuYT0Q0+D7nfmfiLGvwGV1ZEdyy2P05vPdPJoZ5j8YcwovNj0RXM5UDK7Sfzwe
 R8oC5M39EAIbfK2B2/E7FDw2EzBpccxxR
X-Google-Smtp-Source: AGHT+IHJIjfXZJJq70WPdITzSujILtZ7FlqCrq/3QiaQ+QHLHAKEJl9uQxt6avkz8BE4514/pM5g8t1JbbOR6ekj9rU=
X-Received: by 2002:a17:907:c28:b0:aa5:b4e1:ab6d with SMTP id
 a640c23a62f3a-aa621aadb05mr874419566b.29.1733528508863; Fri, 06 Dec 2024
 15:41:48 -0800 (PST)
MIME-Version: 1.0
References: <20241206131113.2865416-1-sjg@chromium.org>
 <20241206140852.GO2457179@bill-the-cat>
 <CAFLszTizXjXnc_P3RHpxbKj5qoEfW_Swrc6V6v6dS7kFUqH9CA@mail.gmail.com>
 <20241206194130.GX2457179@bill-the-cat>
In-Reply-To: <20241206194130.GX2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 16:41:37 -0700
Message-ID: <CAFLszTjQchtBH+K5rRPdiOGgb1bYq3LFWH8BP7jw+noXEaC0GA@mail.gmail.com>
Subject: Re: [PATCH 0/3] rpi: Tidy up booting
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Matthias Brugger <mbrugger@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Sumit Garg <sumit.garg@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>
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

On Fri, 6 Dec 2024 at 12:41, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 06, 2024 at 12:17:49PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 6 Dec 2024 at 07:08, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Dec 06, 2024 at 06:11:10AM -0700, Simon Glass wrote:
> > >
> > > > This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
> > > > ramdisk, by expanding the available space.
> > > >
> > > > It also tidies up some strange behaviour with the provided FDT, where a
> > > > separate pointer is maintained to it, even though U-Boot has copied it
> > > > and placed it in its own space. This avoids strange bugs where it
> > > > accidentally gets overwritten when loading a file into memory.
> > > >
> > > >
> > > > Simon Glass (3):
> > > >   rpi: Update environment to support booti and large initrd
> > > >   fdt: Allow expanding the devicetree during relocation
> > > >   rpi: Use the U-Boot control FDT for fdt_addr
> > > >
> > > >  board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
> > > >  board/raspberrypi/rpi/rpi.env | 10 ++++++----
> > > >  common/board_f.c              |  6 ++++--
> > > >  dts/Kconfig                   | 11 +++++++++++
> > > >  4 files changed, 29 insertions(+), 18 deletions(-)
> > >
> > > My feedback here is the same feedback I gave the last person that wanted
> > > to update the Pi addresses, and I forget if they came back and did that
> > > (and it's in Peter / Matthias' queue) or not. Disabling device tree
> > > relocation is a bug and must be removed.
> > >
> > > After that, given the range of memory sizes available on Pi platforms,
> > > allocating the kernel / initrd / kernel decompression buffer at run
> > > time, ala mach-apple would make life easier in the long run.
> >
> > Yes, of course, but for now, this resolves the problem and I don't
> > believe it creates any other problem.
>
> Yes. I think you missed that:
> https://patchwork.ozlabs.org/project/uboot/patch/20240723193430.3050251-1-walter.lozano@collabora.com/
> is also outstanding and should solve the problem.

No, it doesn't support decompression, although I have to wonder why
that patch was never applied.

>
> > The solution should not be board-specific though. Once I have the
> > bootstd files stuff is finished, I believe that bootstd will be able
> > to do this and I plan to do this. Then the variables will be unused
> > for rpi and we can just drop them for any bootstd boards.
> >
> > As of now, we have 390 boards using bootstd and 381 using distro
> > scripts, so it is progress!
>
> Yes, it will be interesting to see what the future holds, and any of the
> solutions handle some of the trickier corner cases that lead to the
> current situation. Or perhaps the best outcome is that in current times,
> those corner cases don't really appear anymore (with 512MiB DDR being
> the lower bound for example on all the Pi families).

Well rpi is a bit unusual...

Regards,
Simon
