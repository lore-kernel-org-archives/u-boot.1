Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401CECF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1CC389251;
	Thu, 19 Sep 2024 16:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BLUpV3M0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A1128924E; Thu, 19 Sep 2024 16:13:20 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 226428923E
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d8b68bddeaso806529a91.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755196; x=1727359996; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MkfVL9C4HAZtTrbx5LymSikN+qbV8S0g/8AxneGnbMY=;
 b=BLUpV3M01djTHSfzq2PwCZbhfISl+Qylo+qC75WH/Mb3rp9F730zHxm9DO5oYJQNRC
 5KerS57RFgcw+C0Be8AvrO4xZx3tZgYeZZ7Md75hOWeOewRtYIDieWnTAQZFUI7tUBdv
 c1r/YlY8UjLk9eEabm8iR8UDNzC7z/ma0YrUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755196; x=1727359996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MkfVL9C4HAZtTrbx5LymSikN+qbV8S0g/8AxneGnbMY=;
 b=LyOOVWF3cY9tbPU/NkERaQ/wmiOrCBy1R409r8XzL2VG6ys7ntHrbGE41IqfAxR8sG
 HboEIbFQ4UPu6lBugN96sLtyvxfR4+oSmAEFZo1FsuGoBqoFy4Q071m9cbMwuSY8G509
 DRKzMkPDAbrr/ixQX0UDj5XEVyVefxKnZdlSADFq2wPZUz4IX+YRPal0+i00ZxFYO/6v
 X3/ihsVNxeMNtF3xdyVo6Pmx4Ji7X135TUhFQl63Ue4iFd6cwQ3xB8/MWHGTLqo7KPYR
 6KEQLRcpenJqxd1CXajHS79L+kuocv1yWQ5IXD4BNOL3Duou8+STN4SivlOerBhlmZGB
 XnIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHj7P3dqap9i952CQI2XDNycZtAD4VQczkU2E51vmPo3uOEBndLQNB5rrNv8VdwrihgsIJyiU=@lists.denx.de
X-Gm-Message-State: AOJu0YxCFco0CnsizZug3RwZ62qi5Ee5A9TJz48V75L8B/m/d8j154tz
 GxR7ICU7wpRxt3ZS1M0ZWtXCLJtGTLC8b4usFRAxJZI0RpVEiPcEj1ET4pXPcb8pcTTW/5Pnn6M
 oWkkXO68jq8QkS2v9+Z7B4RVcKLqn5Auej+l7
X-Google-Smtp-Source: AGHT+IHzY/dc+5FWOo8kYhei3KEgMW1U3rLKC4LdPqCPc+S7EsaAGJg0Lq1RVzWedEwooiB29lLM/G1JQVgmPwIAplc=
X-Received: by 2002:a17:90b:80c:b0:2dd:4d3f:45ad with SMTP id
 98e67ed59e1d1-2dd4d3f4744mr11052648a91.38.1726755195658; Thu, 19 Sep 2024
 07:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
 <ffeb90f8-4f3b-4455-83db-d7b03b872c84@linaro.org>
 <CAFLszTg8gM53pcbHGj-LoA9GDSU-X294_q6ZRnP_QjYFppG0sw@mail.gmail.com>
 <20240826182345.GJ2479150@bill-the-cat>
 <CAFLszTiD4A2eCMfnnKvrbm__urLu+vdi_L1T1iiwU-qOY-yYJQ@mail.gmail.com>
 <20240826195924.GM2479150@bill-the-cat>
 <93c2ab53-aa9a-4403-80da-7bd6d8872b3c@gmx.de>
 <20240915182831.GD4252@bill-the-cat>
In-Reply-To: <20240915182831.GD4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:13:02 +0200
Message-ID: <CAFLszTiVwOMHPPZV3iHyW4cdz7cr5vPZj=-6_VwCWXnix=Kg7Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] SMBIOS improvements
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Stefan Roese <sr@denx.de>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>, 
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
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

Hi,

On Sun, 15 Sept 2024 at 20:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 15, 2024 at 07:57:19PM +0200, Heinrich Schuchardt wrote:
> > On 8/26/24 21:59, Tom Rini wrote:
> > > On Mon, Aug 26, 2024 at 01:12:16PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 26 Aug 2024 at 12:23, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Aug 26, 2024 at 11:58:54AM -0600, Simon Glass wrote:
> > > > > > Hi Caleb,
> > > > > >
> > > > > > On Mon, 19 Aug 2024 at 17:03, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > > As a general comment, this is adding a load of code which is used by a
> > > > > > > > lot of platforms. As more and more aarch64 platforms are created, this
> > > > > > > > data grows. Why not use the devicetree for this hardware information?
> > > > > > > > That is what it is for.
> > > > > > >
> > > > > > > This data does not belong in devicetree, the various system registers
> > > > > > > exist to describe this information... Putting it in DT would be
> > > > > > > duplicating it.
> > > > > >
> > > > > > I am not wanting to duplicate info which can be read from system registers.
> > > > > >
> > > > > > >
> > > > > > > Using DT for this would additionally require having bindings accepted
> > > > > > > upstream and for all SoCs to add them. To what end?
> > > > > >
> > > > > > To get the correct information in there. How are boards supposed to
> > > > > > add SMBIOS info? Do we end up creating a whole infra in U-Boot just
> > > > > > for the driver to read it out? It just doesn't make any sense to me...
> > > > > >
> > > > > > Let's put hardware info in the DT where it belongs.
> > > > >
> > > > > I'm a little confused here because of some older threads on this overall
> > > > > topic. Part of the issue here is that in user space, "everyone" has
> > > > > SMBIOS-based tooling today, and wants to have that work, rather than
> > > > > inventing new tooling or modify existing tooling. And you were concerned
> > > > > I thought that we had tied SMBIOS too much to EFI being present when
> > > > > indeed it should be possible to pass the location along to the OS
> > > > > without EFI, but at the time Linux at least only supported that notion
> > > > > on MIPS I think?
> > > >
> > > > That is a whole other concern I have, that we are perpetuating this
> > > > legacy format which is a real pain to work with, when we already have
> > > > devicetree. Let's leave that issue aside as I have not detected any
> > > > interest in solving that problem, or even any agreement that it is a
> > > > problem.
> > >
> > > OK, yes, lets set that aside.
> > >
> > > > But for this particular series, I am just wanting to get the correct
> > > > info in there. Having the CPU-detection code provide an opinion about
> > > > what type of chassis is in use (just to take an example, the patch
> > > > pieces I highlighted have been dropped from the email I am replying
> > > > to) just seems a bit daft to me. Only the board vendor would know that
> > > > info.
> > >
> > > Yes, I agree the detection should be reworked a good bit as some
> > > information will be board design specific while others SoC specific. And
> > > we should avoid adding many unused at run time strings to all platforms
> > > that enable this too (looking at all the CPU vendor related stuff).
> > >
> >
> > I doubt on productive machines there will be much use of U-Boot's smbios
> > command use. It is more a developer tool.

Many commands fall into that category.

> >
> > For reading all the details we currently have
> > lib/efi_loader/smbiosdump.efi which can dump the SMBIOS table to a file
> > that dmidecode can read.
> >
> > Maybe instead of adding more and more decoding logic into the U-Boot
> > smbios command we should add an smbios sub-command to dump to a file.
> > This would be less of a hassle than running an EFI program for the same
> > purpose.
>
> Sounds like a good idea to me.

I would like to see this series land in U-Boot as I believe it is very
helpful for seeing what the table looks like. Dumping to a file which
then needs to be decoded is not as convenient. We may also find it
easier to add tests for SMBIOS.

Regards,
Simon
