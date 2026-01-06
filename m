Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0100CE9D7D
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 16:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2224D83F98;
	Tue,  6 Jan 2026 17:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k5hshtru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD2383FA3; Tue,  6 Jan 2026 17:58:11 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE3983F66
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 17:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-4558f9682efso768469b6e.3
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 08:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767718688; x=1768323488; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r/1HM1LptObVfzecwqEPv9QMmJwU5uZYjkPvGBRfkKk=;
 b=k5hshtruIyYDQmphIY/qgp5uCFjhgTALML1ehtwwHFshj5I0KJh93zJxNqVuoZq1Qw
 IDM+UL7mgQWhzxbW193u57AnLcAAA33HPJKSHAMQ4Oh2nRHrAY+n7rgyWLUc0uR6W/Dv
 i/XfXoJCavhOn3wJNmhnpfE2ZzJAK8s1pR084=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767718688; x=1768323488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/1HM1LptObVfzecwqEPv9QMmJwU5uZYjkPvGBRfkKk=;
 b=d84Or0mvHJ+CcRkfytJEM9p+25cBH1HrZ81TxoFnZIoUGsK+Q5VaK7KKXkXyyra1Aq
 XES7Z/IzClRRKRZlVnh7szFruMA7Tw9mvKlxIPfthOR7qsbP9oq9O0Z+fJpUlZh5l9l+
 VZTStgXiS10xXXCME8oNWdYX25cCIYHKrDt63k6df07/0ukbG8YBfQKvIcIvBhA093VK
 49Cj1k87B+l5+E6VXCXC7vqB3/yNRB+Xyp0LP90dLn4bFuYy+i7nAFDswxy5cg/PQQ60
 uygXMAst5CnpVCCN57luJGLJHcVK9pRi57iJKDAsJdNnrOolh+RXIQI6/TMJ0S0YtGMh
 QN6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9RcD2CAgvpOYkX+kge4M0geRF1tXL03vkIuX/C6XmMEL87bjEREhDZgLrvDpsXI153ilhPto=@lists.denx.de
X-Gm-Message-State: AOJu0Ywal+Ehpx65bOjnqsPny7AiCGWBN53cXszrrK7sJx71F/8vccxc
 grxkVyfk3vaEXeoQqycl6ELDW4MxAaejUNKrlx5Psw2+zBnA+saIC5r+LU8WgbXaxc4=
X-Gm-Gg: AY/fxX6r0gBh0qNIQGZ+vV1LZFrlQMXrrMxIyYGdYyTM1CA+43wWdQlrTdck/LLFJIh
 1zbhQRqCDSItpeT002isHtnEvTjskPD2DWtpnJjXF4Ph0ZvK/pKbXktl1unbGvlaZ2c+/5Ux25i
 vReaFBjS9sKJLQjNkX+0FkorQJimEpgX+gcaAtCxddC7daEZxd28gGPnd6qtLEFWAqgCTdlIRlP
 jKEi6lpvIk2TWM2Erc0vJDffWgDezgGmX4yf4HUTguwdfQLVytMg10VvTiITf8+A5ek2mHmExOc
 p4BJ08M19PnexHwsXK0TqvW4BtZhp5Tm1dhwqar8B5N7afEDE8oBeB333wlzuH9ryFM5kDYWv9S
 BjmOB8ks/4F+vWHVOnkYwPS3I65lWqX3dPhwbNQRxjKObJfGEZIjWugPHFgeq9t4wecji4UqsvL
 feBunIS8S7CSW4KjqXxdtIuEUTvnGDy/j05Ia3UUpViN5WJhtogpO6vKbHDH2kGTHFFQFXWZMqm
 xE6gS/1wEuhsEeonpD8TFcnN9ws8TPVzvodG5roQ8473PX7TQ==
X-Google-Smtp-Source: AGHT+IHniUVZscTxljkXvknpSs63UyBYDjNIyVUvgMSWtrMl5yxNNdrPulwhULnVPEPrPLZAf9b+OQ==
X-Received: by 2002:a05:6808:2216:b0:43d:1eec:aea7 with SMTP id
 5614622812f47-45a5b11f9d8mr2396102b6e.45.1767718687666; 
 Tue, 06 Jan 2026 08:58:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e183ac3sm1158449b6e.4.2026.01.06.08.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 08:58:07 -0800 (PST)
Date: Tue, 6 Jan 2026 10:58:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, alison.wang@nxp.com,
 angelo@kernel-space.org, me@ziyao.cc, daniel@0x0f.com,
 heinrich.schuchardt@canonical.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 3/7] rtc: goldfish: Support platform data for non-DT
 probing
Message-ID: <20260106165804.GG3416603@bill-the-cat>
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-4-visitorckw@gmail.com>
 <CAFLszTiMZLXoXEk=JL3siZURVD2YdnmQ7HXy=Viw8uUFbrL6qg@mail.gmail.com>
 <20260105234725.GA3416603@bill-the-cat>
 <CAFLszTjW=wwSh-+MowTCaNLJQ_O6HninAJXrd_MQuuUEKd5Zyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="917Pyt42S0zfjiFj"
Content-Disposition: inline
In-Reply-To: <CAFLszTjW=wwSh-+MowTCaNLJQ_O6HninAJXrd_MQuuUEKd5Zyg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--917Pyt42S0zfjiFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2026 at 09:22:01AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 5 Jan 2026 at 16:47, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jan 05, 2026 at 04:30:26PM -0700, Simon Glass wrote:
> > > Hi Kuan-Wei,
> > >
> > > On Mon, 5 Jan 2026 at 11:20, Kuan-Wei Chiu <visitorckw@gmail.com> wro=
te:
> > > >
> > > > Currently, the Goldfish RTC driver exclusively relies on device tree
> > > > to retrieve the base address, failing immediately if dev_read_addr()
> > > > returns FDT_ADDR_T_NONE. This restriction prevents the driver from
> > > > being used on platforms that instantiate devices via U_BOOT_DRVINFO=
()
> > > > instead of device tree, such as the QEMU m68k virt machine.
> > > >
> > > > Add support for platform data to address this limitation. Update the
> > > > probe function to fall back to retrieving the base address from
> > > > struct goldfish_rtc_plat if the device tree address is unavailable.
> > > > Introduce a new header file include/goldfish_rtc.h to define the
> > > > platform data structure.
> > > >
> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > ---
> > > > Changes in v5:
> > > > - Rebase on u-boot/next branch.
> > > >
> > > >  drivers/rtc/goldfish_rtc.c | 13 ++++++++++---
> > > >  include/goldfish_rtc.h     | 15 +++++++++++++++
> > > >  2 files changed, 25 insertions(+), 3 deletions(-)
> > > >  create mode 100644 include/goldfish_rtc.h
> > > >
> > >
> > > You can package your own devicetree in the U-Boot source, to handle
> > > what you need.
> >
> > That's not helpful feedback here, the correct path is to use the machine
> > as QEMU provides it and not start yet another pointless argument with
> > QEMU. And this probably applies to some of your other feedback as well,
> > thanks.
>=20
> From what I understand, QEMU does not use DT for m68k. If it did, then
> we would not be using platdata. Am I missing something here?

Yes, we don't want to add something here in U-Boot that won't be
generally useful. Since it sounds like Daniel has a plan to move
forward, that's the direction to head.

> Regards,
> Simon
>=20
> PS: The QEMU thing was certainly not pointless, even if the 'argument'
> resolved nothing. We still have this work-around in the docs, 4 years
> and counting:
>=20
> https://docs.u-boot.org/en/latest/develop/devicetree/dt_qemu.html#merging=
-in-u-boot-nodes-properties

I've not un-documented your specific workaround for your use-case, that
is true. I also don't know of anyone else using that.

--=20
Tom

--917Pyt42S0zfjiFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV0/GQAKCRAr4qD1Cr/k
CthvAP9Ay17gXhYFaAvERNvs0yheW15kHzjTCemEXAoGIY7uCwD/Z9VSlwmJFukn
dgMxwSgqytqk9qwfi4QnhP0IWYc/PA0=
=6pzk
-----END PGP SIGNATURE-----

--917Pyt42S0zfjiFj--
