Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BFFE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 680858913C;
	Fri,  6 Dec 2024 20:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lZzCMFM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A8489082; Fri,  6 Dec 2024 20:41:40 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE71F8913C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d87fffeb13so15803046d6.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733514096; x=1734118896; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Px/pqQHqo/YXyXx8t6YiwZsBJpoIlExHOUp3oqQs2Vk=;
 b=lZzCMFM9lQO3dPY37j72VznGyKWKeJBwWIX0XaQfdWRZ62q789bJnSAoomEwJsjcgF
 P/wBXnuRKSYdWUkk0r6tsmja65Izn6w1sJdnmHGk0U1Acq6BHTXAJIzPJw2/D179/AkV
 RWo98+M7RaEFAbIwfhv8Pt5+jdtVyDCM0Y6aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733514096; x=1734118896;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Px/pqQHqo/YXyXx8t6YiwZsBJpoIlExHOUp3oqQs2Vk=;
 b=d4l7slVCVfi0WJVmKTewqT1fSrBbgB4/ysaR+gEyloUEDN4+yit8Pdz8bziM4BgK7k
 zCxkF+o/AAalyzkGksLbtnBRzMBYcbElQPtmALqumafipjq7b2YnPSNtiv6eKVCMdv6G
 Sw8IqfrYcWF0yO3UsVd13P0ccejrDG1abTAP40HCOZdKGm5SwuVK0R887zRcL+dcm8Ek
 dW8cvlKijEyDsUoNmDXhPWTHpAU9Ci3sJVV9EWAkXUJykyF9USFZMi0pr2n/BQNqRQCA
 C8WMvhlBwh9swb7f3THIyJb0m/2eGbLpJFfToRVnii5lA0gfWyfg0dwXKMWATo/F75YD
 K0SA==
X-Gm-Message-State: AOJu0Yxlt8cdJSXLc+NzyMlL9xNm2Mc+KGJW4D7HEHgDEv1HRJ6EkrRY
 hTcuPj7rFGP+qjBVF5wUh5dRFzAVuOBdeIOHdjmAkow7pxNps24cTMqPI3egR6A=
X-Gm-Gg: ASbGncvnJuegVH63iRKl844qrGjEXJEpXosu+JC3VTrlM5sQJtUKS1QFfKSC15J2PGS
 othgyFY8/x2JUdagi/Z0m5MUwNvQ9vtSg5XN1pMsAoC5//j9FAWwJd6IeZHa50+Gzrg53JIqKUp
 OSQrQas5HEflQ1hjreBo+bbFOIn9cv4T2qEN5u1hMoPKHXUlTagWvq1EOpqGGY8teqv2LS88qM/
 xYNAXb12qkFUuRa2Am6+OfDnHrxvPonTgrdrDxHiyxBTaSWtg==
X-Google-Smtp-Source: AGHT+IE3If1KECt6gfuyOY3Ny9oKT6kYPP8fb7UpPO94b3Mwajp73ELdm0ab41ysEjpNQyKTHRMihw==
X-Received: by 2002:a05:6214:2506:b0:6d8:88fc:c0f4 with SMTP id
 6a1803df08f44-6d8e73c0d71mr63819676d6.33.1733514096390; 
 Fri, 06 Dec 2024 11:41:36 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8edb76ce7sm9262906d6.90.2024.12.06.11.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 11:41:35 -0800 (PST)
Date: Fri, 6 Dec 2024 13:41:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH 0/3] rpi: Tidy up booting
Message-ID: <20241206194130.GX2457179@bill-the-cat>
References: <20241206131113.2865416-1-sjg@chromium.org>
 <20241206140852.GO2457179@bill-the-cat>
 <CAFLszTizXjXnc_P3RHpxbKj5qoEfW_Swrc6V6v6dS7kFUqH9CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="00HQBNTEf1279WQT"
Content-Disposition: inline
In-Reply-To: <CAFLszTizXjXnc_P3RHpxbKj5qoEfW_Swrc6V6v6dS7kFUqH9CA@mail.gmail.com>
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


--00HQBNTEf1279WQT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 12:17:49PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 6 Dec 2024 at 07:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 06, 2024 at 06:11:10AM -0700, Simon Glass wrote:
> >
> > > This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
> > > ramdisk, by expanding the available space.
> > >
> > > It also tidies up some strange behaviour with the provided FDT, where=
 a
> > > separate pointer is maintained to it, even though U-Boot has copied it
> > > and placed it in its own space. This avoids strange bugs where it
> > > accidentally gets overwritten when loading a file into memory.
> > >
> > >
> > > Simon Glass (3):
> > >   rpi: Update environment to support booti and large initrd
> > >   fdt: Allow expanding the devicetree during relocation
> > >   rpi: Use the U-Boot control FDT for fdt_addr
> > >
> > >  board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
> > >  board/raspberrypi/rpi/rpi.env | 10 ++++++----
> > >  common/board_f.c              |  6 ++++--
> > >  dts/Kconfig                   | 11 +++++++++++
> > >  4 files changed, 29 insertions(+), 18 deletions(-)
> >
> > My feedback here is the same feedback I gave the last person that wanted
> > to update the Pi addresses, and I forget if they came back and did that
> > (and it's in Peter / Matthias' queue) or not. Disabling device tree
> > relocation is a bug and must be removed.
> >
> > After that, given the range of memory sizes available on Pi platforms,
> > allocating the kernel / initrd / kernel decompression buffer at run
> > time, ala mach-apple would make life easier in the long run.
>=20
> Yes, of course, but for now, this resolves the problem and I don't
> believe it creates any other problem.

Yes. I think you missed that:
https://patchwork.ozlabs.org/project/uboot/patch/20240723193430.3050251-1-w=
alter.lozano@collabora.com/
is also outstanding and should solve the problem.

> The solution should not be board-specific though. Once I have the
> bootstd files stuff is finished, I believe that bootstd will be able
> to do this and I plan to do this. Then the variables will be unused
> for rpi and we can just drop them for any bootstd boards.
>=20
> As of now, we have 390 boards using bootstd and 381 using distro
> scripts, so it is progress!

Yes, it will be interesting to see what the future holds, and any of the
solutions handle some of the trickier corner cases that lead to the
current situation. Or perhaps the best outcome is that in current times,
those corner cases don't really appear anymore (with 512MiB DDR being
the lower bound for example on all the Pi families).

--=20
Tom

--00HQBNTEf1279WQT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTU2MACgkQFHw5/5Y0
tyx9iAv8DGzaaox5oJcHOAviRbGSVTUQbT4NMMvTGDLCC5L0WJpFyDIPB8YHLDzD
nYmKbTQbowJzZam3xgonwMXkt6+rN4Uf2xcyLAwq+aNiJqPtnrWSO8PCp2uHMl8M
miU6svtWNjlM6rTNHPiUjBslo1PYsYae/wg7vqPuPKjIXTRSQaqaU7SFYShDYahL
H1sJHIn82rgNL/Q6fEGXHHZikLjLBxbEYnjsDTz8pqyjm15LqdJtoCq9xEwDi3po
zq5KUj3ZsOXn6P10bNVUrJBYhko9xys/0PHMmhnSzJMBr99RV4xsI0M35Lky/5Qh
/R+SZEcCngrslgyboM5PDTkcwl5rZu20jWFlPWVi2RQhcDTDK4PAuYRjAUZHqDG7
/BSEGzUOBt+iSKQekhAZPSJJ5s75G0CHqS1wOM76VJbEut+7UwUNMN8HNCtVDMla
1A63Z7PVvR6oGpYsvlrK+pJu/YILigCmOjHLYwydKIcAgO2vHLnjcDXoFx23Va4q
B3lUsKPD
=6Uu8
-----END PGP SIGNATURE-----

--00HQBNTEf1279WQT--
