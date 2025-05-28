Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F83C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 15:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A4FC832C0;
	Wed, 28 May 2025 17:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p6tiL+k0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B6A832E6; Wed, 28 May 2025 17:05:37 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A064983216
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 17:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6060167af73so2714388eaf.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748444733; x=1749049533; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cdG0yXgQirfp/FexmkwHi7VKVnEsHnj8vg15CVThgp8=;
 b=p6tiL+k0BiHLhjgv2jkmKlRoFq+fjWmaodtqUIQerDVLrxJfRP/p8fpDIJPC1MBGHE
 HM9kLNR61sY5+VT3361yuKVuHAEUQQhaXDgqYi9NYQDQQxvBvndQDZSCP+MB0znL+LN9
 amvRNL8xHfIepAto623qb89Oyu4nZ57xjpnBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748444733; x=1749049533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdG0yXgQirfp/FexmkwHi7VKVnEsHnj8vg15CVThgp8=;
 b=tCwzriiI1BnTcDvRCJmqHhVsI7BpU+/jkmBXp+p9rKVEsOTKEEoztaOF5I0MhXslS3
 ivg5QJrEHyfScAsGwaOZ6SrpHY/3qg8WDGnqztl+6fECKmE3qqH2iTSfCVX2izlChUPK
 PEfusD2vbSSYcNV6SX/loeHcozP5A30n+5KHzwfrWBlLjpcRc8D9ERP/J1wHYvm3oVHL
 blpsS3DJBvT6F/tl0qXZGwkkuTZMr6R3ioBxo46PquSZgSwd2sfA8GGq8byya3b6MJ2w
 I3zXC7fEHJKeTH6N3pXY5g0ehZt5hQFUKOuY58eQe/kqrljE8TfHmC0PmCsCcAC7izkC
 D0TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvlhdMWUPKW+w3Abl57bBnFH7YWS4wzmOrAZEO395o10HRTnW9U4tLcLe79jbHHfnLj/jIHOU=@lists.denx.de
X-Gm-Message-State: AOJu0YzA+tTUou1Q9mXll7xOeAuzCv4dgyUQZ2qAk1E/BYM3Zki6vZ3K
 k0L46xtv/+4DhSBsjSBMUc/LlZTnfXIa5o5CNKhY/3bP7PSE/pfBCwLVjYMZhKH3vMg=
X-Gm-Gg: ASbGncsuGo0dwRLNN0tTH2rail86rkaBXyhYZk+o51JjC02zqhXVM5O5mIsXg+GbFvd
 u9L43WyuD3yrteXKOIDGSYgyjNYOvdvYdN1KxQ4d8y2FjCohE5IHIw+5kCMStr8uV/+mICvn+kw
 X2KHhvA19wVbh/IaIjn3nRZUsgvV+WZEI4suX8X8CoQz6U9OfYvuEHFjMzyWQojZlrt5qVj2Sfd
 ZE7qAf2vVFAP7EyPcfk/G60/I86tJKU0dIO57JeryKzBpOdcjKxiPfq5SUaEf0XcGaFTlZ+y5gJ
 xFkJPsDLlFF/G+LYvJFRjtLJaVDDMFrXQTxfEnOmCdnRNCDGjAH8g4XFVeUc4+dpkYLh4qLs7zD
 hWODg6wTzTSlz
X-Google-Smtp-Source: AGHT+IFcm3RSf/c+oCszuI+yxGhnpMkcHZa21u6G8NMXIxmRFhZQ22XvRqQIUuVrY9Q5gDdQJrgD1w==
X-Received: by 2002:a4a:d856:0:b0:60b:a7d2:f993 with SMTP id
 006d021491bc7-60ba7d30363mr6930147eaf.7.1748444733155; 
 Wed, 28 May 2025 08:05:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735a1ba609bsm204021a34.17.2025.05.28.08.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 08:05:32 -0700 (PDT)
Date: Wed, 28 May 2025 09:05:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH 0/3] efi_loader: Move the public cerificate back to the
 devicetree
Message-ID: <20250528150529.GZ100073@bill-the-cat>
References: <20250524120904.684977-1-sjg@chromium.org>
 <CAC_iWj+XfkWPj+R1JUc0ZPFatRtpMso-Lw+uYzcgcbuKPuV3Dw@mail.gmail.com>
 <CAFLszTho++gscP4rUUY354iyVWFyPkZeMCpa-TpX0GaWOQzQvw@mail.gmail.com>
 <CAC_iWjKjZ-Q_hreO1Z64AFBWXOHB_YB_+Au_9psecVO+ATE_Pw@mail.gmail.com>
 <CAFLszTi7M335=whLPav5P4+mhunAvs4eue780_eJZNjEG_+YAg@mail.gmail.com>
 <20250528141249.GS100073@bill-the-cat>
 <CAFLszTgLpJ_LauJDANH43rJthHpMDwYfRDgMi1yW9b-EQ1yz4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JIleh+CO3s8gzHsb"
Content-Disposition: inline
In-Reply-To: <CAFLszTgLpJ_LauJDANH43rJthHpMDwYfRDgMi1yW9b-EQ1yz4A@mail.gmail.com>
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


--JIleh+CO3s8gzHsb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 03:32:08PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 28 May 2025 at 15:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, May 28, 2025 at 08:35:37AM +0100, Simon Glass wrote:
> > > Hi Ilias,
> > >
> > > On Tue, 27 May 2025 at 10:20, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Tue, 27 May 2025 at 11:20, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Sat, 24 May 2025 at 19:13, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Sat, 24 May 2025 at 15:09, Simon Glass <sjg@chromium.org> wr=
ote:
> > > > > > >
> > > > > > > A previously rejected patch to move the EFI public cerificate=
 out of the
> > > > > > > devicetree has recently been applied. This series reverts the=
 change,
> > > > > > > pending further discussion as to why it was accepted.
> > > > > >
> > > > > > I spent a good amount of time, writing the commit message an
> > > > > > explaining why this patch was sent
> > > > >
> > > > > Yes, that is [1] and I did read it carefully before sending my se=
ries.
> > > > >
> > > > > From my POV there are two things wrong there:
> > > > > - The signature is not an internal U-Boot ABI.
> > > >
> > > > It is, as it is for every firmware that builds out there. EDKII does
> > > > the same thing.
> > >
> > > I mean that in U-Boot's case it is a published and documented
> > > interface, or was until a few weeks ago.
> > >
> > > >
> > > > >  It is how U-Boot works,
> > > > > so if a build systems wants to inject a key it should use that
> > > > > mechanism, not add a new mechanism into U-Boot's build system. If=
 it
> > > > > would help to have some documentation somewhere which says this, I
> > > > > would be happy to send a patch to add something
> > > > > - QEMU is blocked from accepting devicetree additions due to anot=
her
> > > > > Linaro employee's refusal to accept a patch[2]
> > > >
> > > > It's not blocked. It has been NAK'ed and IMHO for a very good reaso=
n.
> > > >
> > > > >
> > > > > > (which btw wasn't 'rejected', you
> > > > > > forcefully reverted it back then with no agreements from anyone)
> > > > >
> > > > > The original series [4] was applied (I believe accidentally) agai=
nst
> > > > > my objections. Heinrich pulled the revert [5]. I went ahead and d=
id
> > > > > the QEMU patch, to help with your issue*.
> > > >
> > > > Heinrich applied the patches initially, and you send the revert, th=
at
> > > > none of the patch reviewers ack'ed.
> > > > You reasoning back then is that the RO functionality was moot, beca=
use
> > > > we didn't have it. It's here now.
> > >
> > > That was one aspect of my reasoning, but of course we can copy the
> > > signature into protected memory, make the devicetree readonly, etc. if
> > > desired.
> > >
> > > >
> > > > >
> > > > > > and
> > > > > > why we prefer to do it this way. tl;dr early boot loaders that =
pass as
> > > > > > a DT is a problem now.
> > > > > > If there's a good reason to revert it, please explain it on the=
 commit message
> > > > >
> > > > > The reasoning hasn't changed from the discussion three years ago -
> > > > > please see [4]. There's also lots of discussion on your original
> > > > > series and my revert, e.g the cover letter. A highly relevant par=
t of
> > > > > this is that devicetree is where config should be stored, so the =
build
> > > > > system has control over what is placed there.
> > > > >
> > > > > But in any case, it isn't right to send the series again, under a
> > > > > different name, e.g. not mentioning device tree.
> > > > >
> > > > > [..]
> > > > >
> > > > > Regards,
> > > > > Simon
> > > > >
> > > > > * The QEMU patch is still outstanding after three years. Could you
> > > > > please talk to Peter Maydell and see if you can get this resolved=
? I
> > > > > have sent it twice since, most recently in April [7] but there wa=
s not
> > > > > even a reply.
> > > >
> > > > Because they NAK'ed it a few years ago, and aren't willing to take =
it.
> > > > I don't think there's anything to discuss and for the record I agree
> > > > with the QEMU maintainers on this.
> > >
> > > Yes, I agree that discussion is unlikely to be fruitful. My point
> > > remains though that your series should not have been applied, given
> > > the previous discussion.
> > >
> > > This thread and the links should provide context for the future, if n=
eeded.
> > >
> > > One other thing I forgot for the record is that [8] and [9] are only
> > > needed due to Linaro's refusal to accept the QEMU patch or propose a

^^^^^=20

> > > convenient alternative.
> > >
> > > For now I've applied this series to my tree.
> >
> > You can do whatever you like in your downstream tree, but please stop
> > implying that "Linaro" is in charge of QEMU. They very much are not and
> > I don't want other communities to think that you and your attitude
> > represent the U-Boot project.
>=20
> That wasn't my intention at all. Where are you reading that?
>=20
> I am just pointing out that Linaro rejected [2]. Ilias (also at
> Linaro) has stated that he agreed with the decision. Do you agree with
> my analysis here?

And then your analysis here are where it sure sounds like you blame
Linaro for what the QEMU project is doing. I am 100% certain that if
Ilias and Peter left Linaro today, tomorrow they would still reject your
changes on technical, not implicitly nefarious business, grounds.

> > > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/202504011127=
29.2181793-1-ilias.apalodimas@linaro.org/
> > > > > [2] https://patchwork.kernel.org/project/qemu-devel/patch/2021092=
6183410.256484-1-sjg@chromium.org/#24481799
> > > > > [3] https://lore.kernel.org/u-boot/CAPnjgZ2uM=3Dn8Qo-a=3DDUkx5VW5=
Bzp5Xy8=3DWgmrw8ESqUBK00YJQ@mail.gmail.com/
> > > > > [4] https://patchwork.ozlabs.org/project/uboot/list/?series=3D253=
693&state=3D*&archive=3Dboth
> > > > > [5] https://patchwork.ozlabs.org/project/uboot/cover/202108021444=
31.2396678-1-sjg@chromium.org/
> > > > > [6] https://patchwork.kernel.org/project/qemu-devel/patch/2025040=
5191352.2597585-1-sjg@chromium.org/
> > > > > [7] https://patchwork.kernel.org/project/qemu-devel/patch/2025040=
5191352.2597585-1-sjg@chromium.org/
> > > [8] https://lore.kernel.org/u-boot/20250510134253.1581164-2-sjg@chrom=
ium.org/
> > > [9] https://docs.u-boot.org/en/latest/develop/devicetree/dt_qemu.html
> >
> > --
> > Tom

--=20
Tom

--JIleh+CO3s8gzHsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3JjkACgkQFHw5/5Y0
tyxt5Qv9HPXhdf0KAKzkBtTjZXDIphkLImaE4M1U9UWOLhi6Sc7hWQR0h+/fwMnS
6Rfi1CR25M0fK096hulRUBwxFYOyBerbMjMlVw+ld6M9Z2NYbnINGiXzWEiHvgRj
9MD3GcoJh5vL5zm7aYlfLFGJsbgQGGtRMy9DhU3ASV0ER99yaMU890+JUHW3/7hp
Fz0Rqd7JvJg1daSRIj1mlgy9f7SLKs4AXwGKnJsFU5rEPVNWJEcGRkne7QOELCdl
0mnr7rP0T7aqt7yQNX1sGPxb4a2tEEoMZHGPyO4KhXbiHhuIlTLeLhl9hYQAWlWl
aJ9f1LoX0axfMd9cGI20uerJxfbHoTJx4KN9iw2oW/7s+t+1PfMbRPKYfnDRjW3B
MlH8ynf2heHqOEix2Hy5HDR3Xp+SYc/JX/yLGfnt3WH/BfEBJmTrJXHYB+C5k/Ex
SIXObOY7pXsOaCtjNddGV+X2Dfcu+OykN4JgZ4+pFp6nhpVDJ4J13wx9dm+cAkTB
3x6eGaBU
=oqcM
-----END PGP SIGNATURE-----

--JIleh+CO3s8gzHsb--
