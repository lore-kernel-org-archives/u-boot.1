Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB880F9D0EF
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 19:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 215548407E;
	Tue, 14 Apr 2026 21:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AxkbQm3A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9E0841CD; Tue, 14 Apr 2026 21:02:32 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0D8A83015
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 21:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-688a8e5fc2eso3624741eaf.0
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776193347; x=1776798147; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BW33fit0+MBCkkrfAztcxpIhmYCqtnXFGBipP/4Kj+c=;
 b=AxkbQm3AwppqdXvxB66JrJTZizvWdyJ4yh9SyS02UgKJ7dqfDY4F5BNVBRaNHJbkgi
 OukwyD6e7jv5TzQxDefmpbpZmbgIZLN1qaNWkDwHV4RnoK7z5n98B7DwRD3sv0o6LfVr
 55U6BpDIW33xN31giqILRxUkAHMhKjQU1y1Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776193347; x=1776798147;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BW33fit0+MBCkkrfAztcxpIhmYCqtnXFGBipP/4Kj+c=;
 b=HFX9lBXUBLJm1NzPADjAxz5MV44JnT5stvY4YgApfF3cowfVYS3gR8AsVwvn2E3K6h
 Mpv7LPlH0MCnMUnf6ZZ5IC2y1FeGj91vBshvAx8p1ZvDPK9OTw3NQBN/+pv+qw1CoaT+
 DBAcB6jQL411MymN5MrKIovSjsSbtThDak6n9l2rkKWJrUfsMt5lxXi6iQxlNndFANdq
 QWP5ye8KgTk1DG+nxR1uwdV5qhAlwZER5zOif8Z8TP4/43tQfVdVlne5sn2IpIHEeiyn
 KhRhQJmfe+XLmto7RlxC+ksOQliPmlarujgfbPi+oz66Hj4xbky15JxJpVH2+5Xnposm
 Mang==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UHh+SMWB4YnC55tVn6BcaRDCpipsfZyrnIHFmKwSRnj6INlS/I1ioZ7QWQL/y21RrgSFiCx8=@lists.denx.de
X-Gm-Message-State: AOJu0YzG7xtU+zwSiNY8rTTy7xVp/IZN1ltQtdlxdEqhpuvU6WzHlkxE
 AAivYJVolODGShP5chPzJ13Pv1ccJP+o1+KKcyyJRuEJkui+wLgQi3IKN18HWcw0124=
X-Gm-Gg: AeBDietjnSjW1qMIoyiZuTJI5wWdizu0FUSbByAim6z0JkDOzbSfP2JlXqKGwOvBsZJ
 ljxRnANU/GsX08TwI59l4jgBFKgShhw3tRucN3mN+WvvbQ/S7U0jRmwL+qEwy6N6RsSmDcs2eee
 qV2jhxybJJyCutAccNL5vexU6to1BL644KmE0wIY/6nqtxJs1Xa4rh9qrqkvKTvBWD4JmkGG9e3
 jj+GiGYSCXVhgs57Vv4hZi2sogXH+97tujBcZTdYvcIfkpO4KPmlK0qsS49sY7LE16Darb04dpA
 kLyjDNIwZXc/yDcjqbrAarB80725R77yZ7yBaR6VvuNHssTaSNjA70nOb/ZLDLH73aWVPl7zcjk
 UjQPrFY6aCfKeNHSq0Ax3ReIF+XVlwn98E1E+CVHvxgq3M6TOWuDWDt2u5n6jy1AQVSEupUOovz
 /74p+S+21YTGvf4gIM4NK47IVpT/nEiVQHgXhdoGrn41O8mCHcP/aAU2XkhsT86pcwYgpkl+01T
 uM+Z/TLuVINW181O602C10yNr4qdF7bbmC/iB8PVuo1Rb7vTsUHe7dm6/TVFA==
X-Received: by 2002:a05:6820:c8d:b0:68d:9ba5:de20 with SMTP id
 006d021491bc7-68d9ba5e256mr6784766eaf.13.1776193346811; 
 Tue, 14 Apr 2026 12:02:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc84e246fsm7980825eaf.6.2026.04.14.12.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 12:02:26 -0700 (PDT)
Date: Tue, 14 Apr 2026 13:02:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Simon Glass <simon.glass@canonical.com>
Subject: Re: [PATCH 1/2] linker_lists: Fix end-marker alignment to prevent
 padding
Message-ID: <20260414190224.GM41863@bill-the-cat>
References: <20260321134626.516665-1-sjg@chromium.org>
 <20260321134626.516665-2-sjg@chromium.org>
 <87jyv2oon5.fsf@prevas.dk>
 <CAFLszTi_U4xS_6kW1VUqaKVUeP+sweOfQvAydXM5F0nQOGSZ+Q@mail.gmail.com>
 <87se8ymuvl.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NFu/ykShWQlsg3LM"
Content-Disposition: inline
In-Reply-To: <87se8ymuvl.fsf@prevas.dk>
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


--NFu/ykShWQlsg3LM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 11:07:58PM +0200, Rasmus Villemoes wrote:
> On Mon, Mar 23 2026, Simon Glass <sjg@chromium.org> wrote:
>=20
> > Hi Rasmus,
> >
> > On Mon, 23 Mar 2026 at 03:56, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >>
> >> On Sat, Mar 21 2026, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> > From: Simon Glass <simon.glass@canonical.com>
> >> >
> >> > Change the alignment of end markers in ll_entry_end() and ll_end_dec=
l()
> >> > from __aligned(4) and __aligned(CONFIG_LINKER_LIST_ALIGN) respective=
ly
> >> > to __aligned(1).
> >> >
> >> > The linker places zero-size end markers at aligned boundaries based =
on
> >> > what follows them. When the next list's start marker has a high alig=
nment
> >> > requirement (e.g., 32 bytes), padding gets inserted before the end
> >> > marker. This causes the byte span (end - start) to not be an exact
> >> > multiple of the struct size.
> >> >
> >> > The compiler optimises pointer subtraction (end - start) using
> >> > magic-number multiplication for division. This optimisation only pro=
duces
> >> > correct results when the byte span is an exact multiple of the struct
> >> > size. With padding, the result is garbage (e.g., -858993444 instead =
of
> >> > 15).
> >> >
> >> > By using __aligned(1), the end marker is placed immediately after the
> >> > last entry with no padding, ensuring (end - start) equals exactly (n=
 *
> >> > sizeof) where n is the number of entries.
> >>
> >> So I'm wondering why that is guaranteed. I mean, the linker is placing
> >> these sections one after another in order
> >>
> >>
> >>   2_foo_2_last_foo   size sizeof(struct foo), alignment max(4, alignof=
(struct foo))
> >>   2_foo_3            size 0, alignment 4 (1 with your patch)
> >>   2_bar_1            size 0, alignment CONFIG_LINKER_LIST_ALIGN
> >>   2_bar_2_first_bar  size sizeof(struct bar), alignment max(4, alignof=
(struct bar))
> >>
> >> So clearly the end of last_foo does have 4-byte alignment, yet it is
> >> observed that the linker sometimes makes 2_foo_3's address coincide wi=
th
> >> 2_bar_1's address?
> >>
> >> What I don't understand is that it seems that the linker could place t=
he
> >> zero-size object 2_foo_3 at any 4-byte aligned address between the end
> >> of 2_foo_2_last_foo and 2_bar_1. And the same seems to be true when one
> >> changes it to have even smaller alignment requirement.
> >>
> >> So why does an align(1) stop the linker from placing that 0-size secti=
on
> >> at the same address as 2_bar_1, or even force it (as we need) to put it
> >> at the first possible address, i.e. immediately after last_foo?
> >
> > My commit message was a bit confusing - alignment of symbol is not
> > based on what follows an item, just on the item itself (despite
> > appearances to the contrary).
> >
> > My understanding of this is that the linker processes input sections
> > sequentially within the SORT(_u_boot_list*) output section, placing
> > each at the first address that satisfies its alignment. So the
> > location counter advances forward only by the minimum needed. But this
> > isn't specific to alignment 1.
> >
> > I've used __aligned(1) in order to make it clear we don't want any
> > alignment. In all current cases, __aligned(4) would be OK too since
> > the structs we use are always 4-byte-aligned. We just want the end
> > marker to go at the current location-counter, i.e. immediately after
> > the last entry. I suppose another way of saying this is that we want
> > the end marker to be a 'multiple of the struct size' higher than the
> > start marker.
> >
> > With ll_end_decl() using __aligned(CONFIG_LINKER_LIST_ALIGN), the
> > result depends on the struct size and the number of items in the list.
> > On sandbox the value is 32. If the last entry ends at, say, 0x103c
> > (4-byte aligned but not 32-byte aligned), the linker must advance to
> > 0x1040 to place the end marker. So then there is a 4-byte gap, i.e.
> > (end - start) not a multiple of sizeof(struct), and the compiler's
> > magic-number division optimisation fails.
>=20
> OK, yes, I agree that the proper thing to use for the end markers is
> aligned(1). But I can't help but feel that this problem is somewhat
> self-inflicted; I still don't understand the rationale for
> CONFIG_LINKER_LIST_ALIGN, even if I've read 0b2fa98aa5 multiple
> times.
>=20
> The ELF format includes an alignment field for sections, so if gcc emits
> a symbol to some section which requires 16 byte alignment, that section
> should get an alignment requirement of 16 bytes. So I guess what I don't
> understand is how gcc can end up emitting a section containing a "struct
> driver" in one TU with an alignment of 16 bytes, while another TU
> contains a section with a "struct driver" that only requires 8 byte
> alignment.
>=20
> So yes, this commit improves things, and you can take my Ack, but I'd
> like to have some very concrete examples of a set of complete TUs (not
> just single lines) and compiler invocations that exhibit some of the
> problems that this is all about. Because I'd really like to look at the
> intermediate .o files and see what's going on.

Agreeing it would be very good to better understand things, after
applying this series I see:
            qemu-arm-sbsa  : rodata -8 text +8
               u-boot: add: 0/0, grow: 2/0 bytes: 8/0 (8)
                 function                                   old     new   d=
elta
                 gic_v3_its_get_gic_addr                    200     204    =
  +4
                 acpi_fill_iort                             264     268    =
  +4


Which is because of patch 2 in the series. There are a few other
examples of gic_lpi_tables_init changing on say
ls1028ardb_tfa_SECURE_BOOT from the same commit.

--=20
Tom

--NFu/ykShWQlsg3LM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad6PPAAKCRAr4qD1Cr/k
Chd+AP9RuQmpqH2Ln3xFUR8Ey/I/uBewFgzA16HnIxpkUaw5gAEAgvPsEwDICm4Y
vj/so7KIWV01yHtJtj/oxpYi71IwbwI=
=zRjc
-----END PGP SIGNATURE-----

--NFu/ykShWQlsg3LM--
