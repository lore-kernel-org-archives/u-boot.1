Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B10D3EE6B
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 14:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 141AE8397D;
	Thu, 22 Jan 2026 15:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gvg1H4Ll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD14883A6A; Thu, 22 Jan 2026 15:25:52 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF638341A
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 15:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45c83c49213so694118b6e.3
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 06:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769091949; x=1769696749; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vf+CiFhrsck/crRzHV5719faIPKV7H4XqNYfhY2EpbA=;
 b=Gvg1H4LlEwbpeYrgVSKJaPlleO3RYK3YZ96DnLo8ly3i9krT/iqEZs+42wZSWjqZ8m
 QxckgBS/E+lyyT16+xD73Gzh8c4OVphIiPIXYrTvisGmkO6Wc1vLWFbHllZEvePdMCBp
 qUU0gmdy+qlgdNx1/3snFr4pKnVYHAWZonMr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769091949; x=1769696749;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vf+CiFhrsck/crRzHV5719faIPKV7H4XqNYfhY2EpbA=;
 b=HiyZGpvdNlXWn1afFRvyRfgp7JhMFB7E3TF/1sm05Dt4/954NGvhihL6nrjqjoPZ4k
 DFfOKK9OU/n2oF/7x4SuXzIBU8v2UNjNDI1AwyXF/F1g7QtqkWjSM4xqvyovngsSKMxP
 vFhfeL77fGACsmlMcCeYRoSBw/ywZIL8Ew7dpjp//fZlCXCilepLsQzQw7UmlVgWt6AH
 mxftSgZi39bhj8Q27gFHCFZ0cISqhaK8uuE7a25HZwAMzC4F+WdqBWsCmouw0mwycqmy
 LJ0E69ZyfeeoARX/szlmUMBtiTsd2UgXDhMXpARF0bQWga33tLIzh4mWeOufXgDrnqUD
 YQtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpyYj7949v+R0HPriW7rqMl0GSkqCOSD90L/0vivickScu1JwwadPmjWnmdOU6fJ/1toX3cD8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp01QRsBuRgMxEFHKPzCetp/+/VejSVEWGNvVPvIdKT3h2r0++
 32Sa6Y7I8V3I4kyZT8iWHEWHjjeOijb6okbZWBkRuqW7M0qZkONAbDMBp1gWk4PDoaQ=
X-Gm-Gg: AZuq6aKvfYoQfUK4pcb6UD8bbzCB44JAacfDbWtS0YaTFHH0CUi20UWqFbcTkjQ5RN6
 D+lf0S9nHA0YqirOoa9wo7OAk75jsgvCY4cUgRBCrqFe083tPNynw+ZMdVcSt66VRrjYYs8C2a/
 YPeJwHx8bmrNjifrU2u0rIERD5N35ijC46s2QFWb6rYEBYfRp8DQBS4JnXDZjZp5hHuQU76Fk4X
 r3JyWH9u1mWFL+hxw6uFOZx3KN/fLr1TM+9rmF5bW6kFBkUdy9ZA9+9U81GvbhJqDJ++3EBgvwf
 8CDZtljMnKjsDnu8UGpGjvcMK4Kifx+PDeHWvXzeLuSTiOXStqtfMi1U/IEpCA2g3ReLSeH8Ol0
 O9RhV7Jwq5SbnGzGRow+KldwSDq4fIw8BxcddqqrYolJzIvyimZULplO8JVY8PAB2J8msGGgRBm
 iqjUk4I+F2DHX1wka3geaCOvoo8yLgKq15/PQ5l1KicrJHVsLOWQ68HjTCYnL/EsdGaBHa3RAHA
 4L0Le3ghnGkCFphb2kKPMDLK7z2P91w8021JirDTMDf2faNVw==
X-Received: by 2002:a05:6808:4f07:b0:45e:84be:b3a4 with SMTP id
 5614622812f47-45e84beb3f2mr5428919b6e.17.1769091949158; 
 Thu, 22 Jan 2026 06:25:49 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9dff95a2sm10253378b6e.11.2026.01.22.06.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 06:25:48 -0800 (PST)
Date: Thu, 22 Jan 2026 08:25:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <20260122142545.GY3416603@bill-the-cat>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V+NOYZp8DsNtjKoL"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
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


--V+NOYZp8DsNtjKoL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 12:08:04AM -0300, Fabio Estevam wrote:
> Hi Tom,
>=20
> On Thu, Jan 15, 2026 at 7:28=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> > v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> > device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> > Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> > that we must have ALIGN(x) statements inside of a section to ensure that
> > padding is included and not simply that the linker address counter is
> > incremented. To that end, this patch:
> > - Expands some linker sections to be more readable when adding a second
> >   statement to the section.
> > - Aligns the final section before _end (for U-Boot) or
> >   _image_binary_end or __bss_end (for xPL phases) by 8-bytes by adding
> >   '. =3D ALIGN(8);' to the final section before the symbol.
> > - Ensure that we do have alignment by adding an ASSERT so that when not
> >   aligned we fail to link (and explain why).
> > - Remove now-spurious  '. =3D ALIGN(x);' statements that were intended =
to
> >   provide the above alignments.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > The only part of this I am only mostly rather than fully confident in is
> > having caught all cases of having SPL_SEPARATE_BSS being false. I
> > believe I have as the generic ARM SPL linker script enforces the BSS
> > ending with 8-byte alignment, and the point of the ASSERTs here is to
> > catch the case where the section we're adding the ALIGN to ends up being
> > empty and so that ALIGN would become useless.
>=20
> I'm working on bringing up Rockchip RV1103 (ARMv7 SoC, no custom .lds fil=
e)
>=20
> After this patch is applied, the board does not boot anymore:
>=20
> Missing DTB
> spl_early_init() failed: -2
> ### ERROR ### Please RESET the board ###
>=20
> If I force "imply SPL_SEPARATE_BSS" in the SoC Kconfig, the board boots a=
gain.
>=20
> In this case, the build shows some warnings:
>=20
>   LD      spl/u-boot-spl
> /usr/bin/arm-linux-gnueabihf-ld: invalid length for memory region .sram
> /usr/bin/arm-linux-gnueabihf-ld: invalid origin for memory region .sdram
> /usr/bin/arm-linux-gnueabihf-ld: invalid length for memory region .sdram
>   OBJCOPY spl/u-boot-spl-nodtb.bin
>   SYM     spl/u-boot-spl.sym
>   CAT     spl/u-boot-spl-dtb.bin
>   COPY    spl/u-boot-spl.bin
>   BINMAN  .binman_stamp
>   OFCHK   .config
>=20
> RV1108 is also an ARMv7 without SPL_SEPARATE_BSS, so I believe it is
> also affected by this change.
>=20
> What do you suggest?

Where are those memory regions coming from? They aren't specified in
arch/arm/cpu/u-boot-spl.lds

--=20
Tom

--V+NOYZp8DsNtjKoL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXIzaQAKCRAr4qD1Cr/k
CqtaAQDSu1bSoLtVLOHbXznjUj+IlFF2UFK3FNlu80ttkAG4wAEAo+tc5vWwdKr2
Q9qTW6CXz+xT/745I5LC4wPxda+gfQw=
=xdrS
-----END PGP SIGNATURE-----

--V+NOYZp8DsNtjKoL--
