Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D13E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 23:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E671989078;
	Sat,  7 Dec 2024 00:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ll2QgZiY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C3B88D9B; Sat,  7 Dec 2024 00:56:46 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55DDE89078
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 00:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa5f1909d6fso510285666b.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 15:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733529403; x=1734134203; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cr0AdOF2fD4v9ZYs488UlCOT3B9aWEhEJ1ENdWFCcns=;
 b=Ll2QgZiYg8lFBOBYCW75xXniqLAY89OmJvjG4irs30yklkW2pjKIF/A9VcVkfL/0db
 b0uJOOZPAC6fhCOB9a2ScCbuUowquMoOp175+Ss6Z+X9d5F8eI4X0zk/ANTbNWUu6OnU
 lr4s3DnoI8v0gyL+TkNsnY0q6XF5DzJjYJe3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733529403; x=1734134203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cr0AdOF2fD4v9ZYs488UlCOT3B9aWEhEJ1ENdWFCcns=;
 b=vkDZRi8hoX7+0r8VUezXqji+zs2aZrWSlYwtf6AlUKr2NbhfjlwS7a1R2e5M+WJr6X
 N2NMggNSNVczU80Z2biHn9k/qdobNVcpQw97JQ1eEYnMJcwvKPorZgNT4WgfvkMwqy3Y
 KYG7UGPnI3HKYI7DE1tIMTzkwsYh7rbi/b05//CkcpghZHpXuxuXjCrSc2gUjoSReXi5
 1wznjAMZaep9Xr1AZEDUCTvmZTxuvmdnceW3uLsQBMUiTQyz4noxt/xDDS096FqcvfBG
 XPzaEHzUNfBZv0PlnMBtpnZTqCEfScVTfGS76Ih9RjXAn4MDnIgSfY5lbaih+IIp2VTd
 u6Zw==
X-Gm-Message-State: AOJu0Yz2oQpRx87xWdDXnZ2fzEWbkIA4Q1FQ7bAm0GqNsNiI1HZAqmU2
 rrJ546KNOvQa4iTPiJKomx7+DSrFSZ28SGxdyoNHPn1iA5EzXC3C5o1dTmXM9e9hn6VneX+m7Uz
 XLbzE8ni4P9zAQuwVv9HpzLZEAC0sUZOYPYfP
X-Gm-Gg: ASbGnctUiPpxR9MAc8paiiH3bV2Sv2jUUewkprmqZe8W1neNL0iwNs3e0tqJwID1FsG
 lV4ZV03E22/hrzNfiM4qboTfBnStwodmp
X-Google-Smtp-Source: AGHT+IEAoYKDB1knr3lasEP9f+O/aamG8PFUCg6MbFdH9Lvogaxm6XqJD4tg5gbbHEr5uvu4GI68rfIZEIv0xV49/GY=
X-Received: by 2002:a17:907:2918:b0:aa6:4731:5c27 with SMTP id
 a640c23a62f3a-aa647315d05mr211946666b.30.1733529402690; Fri, 06 Dec 2024
 15:56:42 -0800 (PST)
MIME-Version: 1.0
References: <20241206131113.2865416-1-sjg@chromium.org>
 <20241206140852.GO2457179@bill-the-cat>
 <CAFLszTizXjXnc_P3RHpxbKj5qoEfW_Swrc6V6v6dS7kFUqH9CA@mail.gmail.com>
 <20241206194130.GX2457179@bill-the-cat>
 <CAFLszTjQchtBH+K5rRPdiOGgb1bYq3LFWH8BP7jw+noXEaC0GA@mail.gmail.com>
 <20241206235233.GB2457179@bill-the-cat>
In-Reply-To: <20241206235233.GB2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 16:56:31 -0700
Message-ID: <CAFLszThCR3KG+AVCN_ZeVVmKXverd6g+qNnKrt5YbdTy6jEayg@mail.gmail.com>
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

On Fri, 6 Dec 2024 at 16:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 06, 2024 at 04:41:37PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 6 Dec 2024 at 12:41, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Dec 06, 2024 at 12:17:49PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 6 Dec 2024 at 07:08, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Dec 06, 2024 at 06:11:10AM -0700, Simon Glass wrote:
> > > > >
> > > > > > This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
> > > > > > ramdisk, by expanding the available space.
> > > > > >
> > > > > > It also tidies up some strange behaviour with the provided FDT, where a
> > > > > > separate pointer is maintained to it, even though U-Boot has copied it
> > > > > > and placed it in its own space. This avoids strange bugs where it
> > > > > > accidentally gets overwritten when loading a file into memory.
> > > > > >
> > > > > >
> > > > > > Simon Glass (3):
> > > > > >   rpi: Update environment to support booti and large initrd
> > > > > >   fdt: Allow expanding the devicetree during relocation
> > > > > >   rpi: Use the U-Boot control FDT for fdt_addr
> > > > > >
> > > > > >  board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
> > > > > >  board/raspberrypi/rpi/rpi.env | 10 ++++++----
> > > > > >  common/board_f.c              |  6 ++++--
> > > > > >  dts/Kconfig                   | 11 +++++++++++
> > > > > >  4 files changed, 29 insertions(+), 18 deletions(-)
> > > > >
> > > > > My feedback here is the same feedback I gave the last person that wanted
> > > > > to update the Pi addresses, and I forget if they came back and did that
> > > > > (and it's in Peter / Matthias' queue) or not. Disabling device tree
> > > > > relocation is a bug and must be removed.
> > > > >
> > > > > After that, given the range of memory sizes available on Pi platforms,
> > > > > allocating the kernel / initrd / kernel decompression buffer at run
> > > > > time, ala mach-apple would make life easier in the long run.
> > > >
> > > > Yes, of course, but for now, this resolves the problem and I don't
> > > > believe it creates any other problem.
> > >
> > > Yes. I think you missed that:
> > > https://patchwork.ozlabs.org/project/uboot/patch/20240723193430.3050251-1-walter.lozano@collabora.com/
> > > is also outstanding and should solve the problem.
> >
> > No, it doesn't support decompression, although I have to wonder why
> > that patch was never applied.
>
> See Peter's response elsewhere about having a lot of things to do and
> not a lot of time. I know he's intended to pick up and post a Pi PR for
> a while.

OK, but let's drop that patch since it doesn't support decompression, right?

>
> > > > The solution should not be board-specific though. Once I have the
> > > > bootstd files stuff is finished, I believe that bootstd will be able
> > > > to do this and I plan to do this. Then the variables will be unused
> > > > for rpi and we can just drop them for any bootstd boards.
> > > >
> > > > As of now, we have 390 boards using bootstd and 381 using distro
> > > > scripts, so it is progress!
> > >
> > > Yes, it will be interesting to see what the future holds, and any of the
> > > solutions handle some of the trickier corner cases that lead to the
> > > current situation. Or perhaps the best outcome is that in current times,
> > > those corner cases don't really appear anymore (with 512MiB DDR being
> > > the lower bound for example on all the Pi families).
> >
> > Well rpi is a bit unusual...
>
> Sure, but not in this case? Lots of examples of multiple models with
> different memory sizes, and especially with 32bit platforms smaller (by
> current standards) overall DDR.

I mean in the sense that it puts the devicetree in the middle of RAM.

Regards,
Simon
