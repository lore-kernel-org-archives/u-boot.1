Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9773CFB441
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 14:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2A61888EB;
	Mon,  7 Oct 2024 16:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PDmN3s6I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8FC4886B1; Mon,  7 Oct 2024 16:47:52 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2BC5888EB
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 16:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7e9ff6fb4c6so2433722a12.3
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728312467; x=1728917267; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ilUMhUARfg59J+mZkwaFIFKchq1HrNFdEN7vfzqoc4o=;
 b=PDmN3s6I+iYnbxzYijuk+MGP0qOrVjFjvTg2tiqoUxwWhAnO9yHxX68nSIrXVhFVz1
 kOQpix3oQ7UABH/wy+pTVAE5JyhmFmN5lKNvAB9KXg6iddPwFiKb1qKZsnSZTvghyWUA
 oB/iLR9JhLqrvSLYdhmmn0PFX/jgjYsah54ry+pKvyCLU6PzZiEffrxGrlqfZtx09CCF
 xH78Ff5nGOOZhdQ9/JCI93bUmYVY7ogh0bpiXOoP/lkZ0x8hTuJyu51jCcRiaYS6eb47
 IvzZEepDjoFqWRQGonViBPqPIh8lWGEZwFMEjeWc9J9u/60+2BywnxRUuuXV4UEmy6f+
 wHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728312467; x=1728917267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ilUMhUARfg59J+mZkwaFIFKchq1HrNFdEN7vfzqoc4o=;
 b=Z+BSE6886YzKjUHkJ/xcoCvzMcpLZONRZbsHaUqfDvMEWJhj50f0aeqgQsuHUNKqc0
 PU7a6WAT6GKcg79xLI1yAaNVdUQHkcGJZtwQ1K5sG2MXk58WOT2mz3tgLlTRlTeSY9n4
 pforMC9FjlFmTUt6pNVsRsHHITPSHJd7qtTPk4hzhKR13hYs9cxbZfsXwut7xReMZyUH
 eRsHM3S0bboKGgumM5spd2vCDmHSk4Lzd7+YX6TnI409yWod43/UvQ2hrT1wYCrTVavh
 uZwT4qxH4aT2WQkL/ykECJJoe0I9sx/C9x7sr94o7A6/cDA0DKhVzBRc9dR1+ABTD/12
 QcCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8eVAaQJXvKG9cYvGUY6PXkPla+lZnw1RPwk3kHkdPs2P1fwn7OBl70bbVX8oGGUdjiv40ytA=@lists.denx.de
X-Gm-Message-State: AOJu0YyZdd3XiKvDyc5H+qa0PY+9Oruc4FNxJNat2RyIATNgtfzGiP+8
 YeGtesQdYaQiEm95vYFYvqNRnA92dXGYa8zO44Po8STzXFlmpXZmcxzbXKtdtuEvXdNOdjw1Ecy
 uENC8X5kfZ3Cm+f+H0L+lQdKu2RDUaYWj5fYrJA==
X-Google-Smtp-Source: AGHT+IGbakA86FsmTcb0KeqX+WYmHjhDTq4JJeh+ZhUvuywnrh0uDUMNJPb6uc/q9u5QWz/ixDtHXpqzyd0TQM6cz4s=
X-Received: by 2002:a05:6a21:168d:b0:1cf:506f:9d3a with SMTP id
 adf61e73a8af0-1d6dfae273fmr18081194637.46.1728312467380; Mon, 07 Oct 2024
 07:47:47 -0700 (PDT)
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
 <CAFLszTiVwOMHPPZV3iHyW4cdz7cr5vPZj=-6_VwCWXnix=Kg7Q@mail.gmail.com>
 <20240919174803.GU4252@bill-the-cat>
In-Reply-To: <20240919174803.GU4252@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 7 Oct 2024 10:47:35 -0400
Message-ID: <CAEfUkUK0qfhM0Uq3g=J0hXsZUD6ULEvxiDsd_tn8FGh28XR==g@mail.gmail.com>
Subject: Re: [PATCH 00/10] SMBIOS improvements
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de, 
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

Hi Tom and Heinrich,

On Thu, 19 Sept 2024 at 13:48, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Sep 19, 2024 at 04:13:02PM +0200, Simon Glass wrote:
> > Hi,
> >
> > On Sun, 15 Sept 2024 at 20:28, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Sep 15, 2024 at 07:57:19PM +0200, Heinrich Schuchardt wrote:
> > > > On 8/26/24 21:59, Tom Rini wrote:
> > > > > On Mon, Aug 26, 2024 at 01:12:16PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 26 Aug 2024 at 12:23, Tom Rini <trini@konsulko.com>
> wrote:
> > > > > > >
> > > > > > > On Mon, Aug 26, 2024 at 11:58:54AM -0600, Simon Glass wrote:
> > > > > > > > Hi Caleb,
> > > > > > > >
> > > > > > > > On Mon, 19 Aug 2024 at 17:03, Caleb Connolly <
> caleb.connolly@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Simon,
> > > > > > > > >
> > > > > > > > > > As a general comment, this is adding a load of code
> which is used by a
> > > > > > > > > > lot of platforms. As more and more aarch64 platforms are
> created, this
> > > > > > > > > > data grows. Why not use the devicetree for this hardware
> information?
> > > > > > > > > > That is what it is for.
> > > > > > > > >
> > > > > > > > > This data does not belong in devicetree, the various
> system registers
> > > > > > > > > exist to describe this information... Putting it in DT
> would be
> > > > > > > > > duplicating it.
> > > > > > > >
> > > > > > > > I am not wanting to duplicate info which can be read from
> system registers.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Using DT for this would additionally require having
> bindings accepted
> > > > > > > > > upstream and for all SoCs to add them. To what end?
> > > > > > > >
> > > > > > > > To get the correct information in there. How are boards
> supposed to
> > > > > > > > add SMBIOS info? Do we end up creating a whole infra in
> U-Boot just
> > > > > > > > for the driver to read it out? It just doesn't make any
> sense to me...
> > > > > > > >
> > > > > > > > Let's put hardware info in the DT where it belongs.
> > > > > > >
> > > > > > > I'm a little confused here because of some older threads on
> this overall
> > > > > > > topic. Part of the issue here is that in user space,
> "everyone" has
> > > > > > > SMBIOS-based tooling today, and wants to have that work,
> rather than
> > > > > > > inventing new tooling or modify existing tooling. And you were
> concerned
> > > > > > > I thought that we had tied SMBIOS too much to EFI being
> present when
> > > > > > > indeed it should be possible to pass the location along to the
> OS
> > > > > > > without EFI, but at the time Linux at least only supported
> that notion
> > > > > > > on MIPS I think?
> > > > > >
> > > > > > That is a whole other concern I have, that we are perpetuating
> this
> > > > > > legacy format which is a real pain to work with, when we already
> have
> > > > > > devicetree. Let's leave that issue aside as I have not detected
> any
> > > > > > interest in solving that problem, or even any agreement that it
> is a
> > > > > > problem.
> > > > >
> > > > > OK, yes, lets set that aside.
> > > > >
> > > > > > But for this particular series, I am just wanting to get the
> correct
> > > > > > info in there. Having the CPU-detection code provide an opinion
> about
> > > > > > what type of chassis is in use (just to take an example, the
> patch
> > > > > > pieces I highlighted have been dropped from the email I am
> replying
> > > > > > to) just seems a bit daft to me. Only the board vendor would
> know that
> > > > > > info.
> > > > >
> > > > > Yes, I agree the detection should be reworked a good bit as some
> > > > > information will be board design specific while others SoC
> specific. And
> > > > > we should avoid adding many unused at run time strings to all
> platforms
> > > > > that enable this too (looking at all the CPU vendor related stuff).
> > > > >
> > > >
> > > > I doubt on productive machines there will be much use of U-Boot's
> smbios
> > > > command use. It is more a developer tool.
> >
> > Many commands fall into that category.
>
> Yes, there is a trade-off to be made.
>
> > > > For reading all the details we currently have
> > > > lib/efi_loader/smbiosdump.efi which can dump the SMBIOS table to a
> file
> > > > that dmidecode can read.
> > > >
> > > > Maybe instead of adding more and more decoding logic into the U-Boot
> > > > smbios command we should add an smbios sub-command to dump to a file.
> > > > This would be less of a hassle than running an EFI program for the
> same
> > > > purpose.
> > >
> > > Sounds like a good idea to me.
> >
> > I would like to see this series land in U-Boot as I believe it is very
> > helpful for seeing what the table looks like. Dumping to a file which
> > then needs to be decoded is not as convenient. We may also find it
> > easier to add tests for SMBIOS.
>
> And I don't look forward to the seemingly inevitable parsing bug means
> CVE assigned. If the command is broadly enabled then "everyone" gets to
> worry about it, and if it's narrowly enabled have we really gotten
> better than the options of dump to file, parse elsewhere or load a
> parser and run it?
>
> Currently the code for parsing the SMBIOS tables really helps debugging
before
an external parser is ready for use.
I think we can keep it until a dump tool is in the project, at that time we
can just
simply disable the CMD_SMBIOS config for the concern of code size.

Regards,
Raymond
