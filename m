Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14856CD98DD
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 20:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 773F984053;
	Thu, 13 Nov 2025 21:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SiZfJJL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 738F184054; Thu, 13 Nov 2025 21:37:01 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 253128404D
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 21:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c6e9538945so1240396a34.1
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763066218; x=1763671018; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9Tz0f/7+SqV2LnN0f6DuXuaoNrLSwpakS1H+82sTJuA=;
 b=SiZfJJL3HmAO3KgnYyndPe65fUmTMCnbA/F2bxLPLRbQpA8V0X/ICduBlocVtJ97Tk
 JHpwoQtDflFAtbGUphfiNF9B6D7Wv9kCVuffENlD8bAVn+fxJOyKZpej4u8BhjgdzyQR
 cQUfQFVlGET3mgiNLdBDa1tsn8uqDog6pHO1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763066218; x=1763671018;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Tz0f/7+SqV2LnN0f6DuXuaoNrLSwpakS1H+82sTJuA=;
 b=VN91/WtyR0A798MPT+uh9HxF7iuyuOo3Yv0FnO1JgGUqIrQFGR5uxbfI0Kpe5BLFuM
 yL8g7NfWJWsG6qsa46ux33MpuWR+bJfGe6OQ+bO3w8qmfHg7n0JkflBuWWchEbgNZPOR
 yNdEgRuQzLpOYFO+6zAjt6thEhGeBJg7R9PKZxD88snP6BXyeIL8EETHP7P0VDrUSOG3
 PeAWpd1pPnV6GSXVMgN8YaTTWK2/kOSPhs1P0cqcx0s+xyPavmDYRPFokeTRkH/B0YKg
 hWz25bgKOEyi05e8HrG35l9IpP5/f/hsK/Jcz9hkXRyz8HiXSNryv0xpNJid/avqQsRS
 Ijlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW4Yco4BIOKfUtRq2zfjZxvsFklE9Yg7KtukVBiQkyGKsKDf4olge62zESk0pbuF8UsRM4XU8=@lists.denx.de
X-Gm-Message-State: AOJu0YwvZTPtm5wKG85y70CDOCY+b2xN0UrZTQOx2aMj9b4cPNF5HRxk
 rKuBnNOA1wMeIoGJ+Gi3fJnyy/ajvyIxC1Bp7xqIqirnCakVBJCk1aKEX/p1prHT2Pw=
X-Gm-Gg: ASbGnctAc10l+D5+sSSYuZ1BS4dhd5/XWNq6s93AHygNHhGO4+tv9NNDsmPbKr9HPFk
 PY5bsMyThTtJitCGhQNYwJA92m0hZ4Sig/I6eBW88OR7JbaqEkarygQI0Z1QfFE+D98byyauO9x
 acTzHAZXGxxGRAbfWUnMcLpNMDOuE06BXqjJ2R3y1VojnXG+pqiGIvZIiKoO9Sg4Tyzu/ggzHAl
 6WPcGP+lLE5+44HHZlUy7oupj+LCd7xkTdNczTmqLpmdUqs3hwZ2J1Pel1m1mowH8BzU5KyDQmL
 7j2sZ91kO4Tq4NH52pxcLIHB3Ay29lk/zFU74e31cTuKq6xfSA1HvD760ewpo9BKo3B5pfBvfv4
 yFbCJnhsyGWqC/T+ndqC/Adg02Z7RmJh3+RLTTTSV96RC/AJCcY9Wtkop5TcAJpnfQNxbGxqgBC
 rkFYg0c9Yxzn1abNsGCwEMhFTgjWL1OdEU+fhhlIQ=
X-Google-Smtp-Source: AGHT+IF83Q84ra3hEMg7tu0Ne9po57A1ZOnvZLb5XWWITkAcFA87R7F+bPo+tqfBiVDTHAsjx/uFew==
X-Received: by 2002:a05:6808:181e:b0:44d:9f05:7159 with SMTP id
 5614622812f47-4508671d58dmr2322316b6e.29.1763066217789; 
 Thu, 13 Nov 2025 12:36:57 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65724cfa261sm1460528eaf.5.2025.11.13.12.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 12:36:57 -0800 (PST)
Date: Thu, 13 Nov 2025 14:36:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
Message-ID: <20251113203654.GR6688@bill-the-cat>
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
 <20251113193816.GP6688@bill-the-cat>
 <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
 <20251113200527.GQ6688@bill-the-cat>
 <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vZHOjonj9aJ0A68A"
Content-Disposition: inline
In-Reply-To: <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
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


--vZHOjonj9aJ0A68A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 01:28:56PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 13 Nov 2025 at 13:05, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Nov 13, 2025 at 12:57:30PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 13 Nov 2025 at 12:38, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Nov 13, 2025 at 12:33:24PM -0700, Simon Glass wrote:
> > > > > Hi Marek,
> > > > >
> > > > > On Tue, 11 Nov 2025 at 18:17, Marek Vasut
> > > > > <marek.vasut+renesas@mailbox.org> wrote:
> > > > > >
> > > > > > Newer versions of libfdt strictly check whether the FDT blob
> > > > > > passed to them is at 8-byte aligned offset, if it is not, then
> > > > > > the library fails checks with -FDT_ERR_ALIGNMENT . Currently,
> > > > > > android_image_print_dtb_contents() passed FDT directly mapped
> > > > > > from abootimg to libfdt, and this FDT is not always aligned to
> > > > > > 8-byte offset. Specifically, the FDTs are somewhat packed in
> > > > > > the abootimg, therefore if the first FDT blob is e.g. 0xfd bytes
> > > > > > long, then the next FDT blob ends up at 0xfd offset, which is
> > > > > > not 8-byte aligned.
> > > > > >
> > > > > > Fix this by first extracting the header into 8-byte aligned buf=
fer,
> > > > > > checking only the header for validity, and then by copying the
> > > > > > entire FDT into newly allocated 8-byte aligned buffer. While th=
is
> > > > > > is not efficient, it is the correct way to handle DTs, which mu=
st
> > > > > > be at 8-byte aligned offsets. Mitigate the inefficiency for the
> > > > > > common case by checking whether the DT might be 8-byte aligned =
and
> > > > > > if it is, map it directly.
> > > > > >
> > > > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > > > ---
> > > > > > Cc: Aaron Kling <webgeek1234@gmail.com>
> > > > > > Cc: Eddie Kovsky <ekovsky@redhat.com>
> > > > > > Cc: George Chan <gchan9527@gmail.com>
> > > > > > Cc: Julien Masson <jmasson@baylibre.com>
> > > > > > Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> > > > > > Cc: Nicolas Belin <nbelin@baylibre.com>
> > > > > > Cc: Sam Day <me@samcday.com>
> > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > Cc: u-boot@lists.denx.de
> > > > > > ---
> > > > > >  boot/image-android.c | 46 +++++++++++++++++++++++++++++++++---=
--------
> > > > > >  1 file changed, 35 insertions(+), 11 deletions(-)
> > > > > >
> > > > >
> > > > > OK, we need to adjust mkimage etc. to handle this. Until then I t=
hink
> > > > > we should have a way to disable the 8-byte-alignment check as it =
seems
> > > > > to have an enormous blast radius :-)
> > > >
> > > > We can't. We really can't. Passing misaligned device trees results =
in,
> > > > and has already resulted in for years:
> > > > - Silent Linux crashes
> > > > - When Linux doesn't crash so many of the read functions go wrong t=
he
> > > >   result is incomprehensible.
> > > >
> > > > It's something that has and continues to waste untold engineering t=
ime.
> > > > The only reason it's not worse is that we've killed off *most* of t=
he
> > > > platforms that disabled device tree relocation and that's how
> > > > misalignment happens downstream most often.
> > >
> > > That's fine, but making the devicetree aligned for Linux is pretty
> > > simple. We generally relocate it before booting anyway.
> > >
> > > But that's not what I'm seeing here. It seems to be updating U-Boot to
> > > deal with a libfdt change. That is also a worthy goal, but we need to
> > > consider code size and where best in the stack the changes should be
> > > made. Doing a memalign() at the last minute is just not a good idea.
> >
> > Yes, the device tree specification, not the OS, says that it must be 8
> > byte aligned. We've needed to do that for ages. Not doing that is not a
> > good thing, for U-Boot, internally. The same APIs that blow up in Linux
> > (or anything else) with misaligned device trees will blow up in us too.
> > We need to make sure we pass ourselves something aligned correctly.
>=20
> Yes, agreed. It has been sort-of half done for a while.

Right.

> > Which is different from disagreeing with your specific feedback about
> > how we get there, to be clear.

And again, since your feedback to this patch was "Don't?", I'm saying we
need to. But the rest of your feedback was structural on moving towards
resolving it and so I assume Marek will respond.

--=20
Tom

--vZHOjonj9aJ0A68A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRZBXwAKCRAr4qD1Cr/k
Cu/1APwNeVrQjRfYO5OjX2pj8cSdwvQkwpQVEI4MStqPfyXWZgD9G6h+YRvjptPK
oGkWnU7Nb582jQGnf9jduQ6RjV1vRgQ=
=l7oD
-----END PGP SIGNATURE-----

--vZHOjonj9aJ0A68A--
