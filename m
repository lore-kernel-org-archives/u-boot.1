Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5025C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 00:20:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BF2580EF6;
	Fri,  7 Feb 2025 01:20:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iMjME08m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A4580F16; Fri,  7 Feb 2025 01:20:14 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F3A280BAB
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 01:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2163dc5155fso30842245ad.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 16:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738887610; x=1739492410; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c5L8iv3uICf6fngDl1Ekr4slltkwhgUSqicppy3BknE=;
 b=iMjME08mmobmMMeSfHE9/7qckIgGHboUO4D71NiIEzCBLcyAXYBQ6RLa8pO1La8OWI
 n60am5/DmZ+mDSjwat0TlA2nMbLv4rzEZVx9qA2moiBmeF1OuKsjNsR6SLjIraUMUoOC
 8S5OIfwdpEhFwHiLVZEDT1Ii753a7hUQciA4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738887610; x=1739492410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5L8iv3uICf6fngDl1Ekr4slltkwhgUSqicppy3BknE=;
 b=UyzAKYWg8eXh7ELTtXnBWJdIGHM7ixFLqu/uMLAQMQnYy7TepexwSqU9xuLiY640Us
 0n4XMaNai9UsHq6kP97fD30u8AS45Oj4+lKANmVtadDNoTqZuPXUdZDW/O6U6LHFfcov
 qRL4QxvvGag2LfIlfW1sx4Id5EQ3TayOAUkPRMY7H0dkSVTuiEI3UBXN2cHZLLeSRAVo
 LqWkkKfMP+Q0nbm3U3ZhMkYbPxTdCMHIwwrFL7E2J4Ssg3FViZ36Pvg4Aq2QTd1AGzdB
 X8V5Mc5Q+2eNLKO0bVzfUVYsU5jm+fjIY79UpvhuZIhMpSghXtNfpzaA8Wk71iwd/2sc
 iacA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPy8nfZBYh+iLbu3lbEWIzRRQNOrwM+Ku/2P7vCRaooIiSJFYXIUsYHyvw+xFmRd70F3RtuP4=@lists.denx.de
X-Gm-Message-State: AOJu0YzETxqx03HQOhfDo+mztfAgZI/LS8wOgXD9mVxWt85sf+8E4jQV
 OTOJoZ73qZdIZLKKHRxKJpcFLIlyNH2/sSOHjgb/39zDWvnZsnj2dxC9jsoJEj0=
X-Gm-Gg: ASbGncvyL5FpJYtlu4WQ2XGg/z2h9/Bt0UPN2m5Au3VECGh+cJnjpqRmprRMqVzyTZJ
 X8aapFFqgPcyKFunOGIP5MOelpH9EqZL7PfGAbbbo0EZCoJZhUCGoskelzYNgervtnLA9yXDRUV
 piaDH2JKk/E8Xfx0gVo7AJRWHefK/8lD+/OqiIvQTRmvgLRwO3Wk9iTUDmRwNzInpxJJ8lwPuJf
 SjJLp1KPXaUsfsMdMa2wlyiqOPl+VWS0G+eNpr6KjbYMeuJgd0o6Sbwl9LWdYc4ZzIObPpT2ihX
 o6ukk6TpZjJV22Y=
X-Google-Smtp-Source: AGHT+IHTNKnFOYhuyvK2k097+7GLpj0k8oBJHM193jLYxED0AEjstM5qY5QzFTMGlicQBKvLXod7OQ==
X-Received: by 2002:a17:902:da86:b0:216:1cfa:2bbf with SMTP id
 d9443c01a7336-21f4e7465f9mr18825055ad.35.1738887609685; 
 Thu, 06 Feb 2025 16:20:09 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368da40asm18803585ad.257.2025.02.06.16.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 16:20:09 -0800 (PST)
Date: Thu, 6 Feb 2025 18:20:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 28/29] Revert "bloblist: Load the bloblist from the
 previous loader"
Message-ID: <20250207002006.GT1233568@bill-the-cat>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
 <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
 <CAFLszTg=UDJUdjCPsyMBjZ3r_r9dNyWYiXNrmhm8mxgEbQoaOg@mail.gmail.com>
 <CAEfUkUL7H5twRqZZBcfEHuExwtHFUrT9h7NV-3T0jx0c0SBEbw@mail.gmail.com>
 <CAFLszThvDjXTDdm7FiGZSBbtDv0px509x2jjn5WX++5Ck4PtOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Llkt9mZAZKWVlYfm"
Content-Disposition: inline
In-Reply-To: <CAFLszThvDjXTDdm7FiGZSBbtDv0px509x2jjn5WX++5Ck4PtOQ@mail.gmail.com>
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


--Llkt9mZAZKWVlYfm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 05:09:41PM -0700, Simon Glass wrote:
> Hi Raymond,
>=20
> On Thu, 6 Feb 2025 at 15:35, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 6 Feb 2025 at 10:41, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Wed, 5 Feb 2025 at 08:25, Raymond Mao <raymond.mao@linaro.org> wro=
te:
> > > >
> > > > +CC Ilias,
> > > >
> > > > Hi Simon,
> > > >
> > > > On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > The logic of this has become too confusing.
> > > > >
> > > > > The primary issue with the patch is that U-Boot needs to set up a
> > > > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > > > phases can then use that bloblist.
> > > > >
> > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > >
> > > > > Reverting this commit seems like a better starting point for gett=
ing
> > > > > things working for all use-cases.
> > > > >
> > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > > >
> > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKXNniOfV_-vFry=
q1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > >
> > > > If my understanding is correct, you want to add some logic to contr=
ol
> > > > when the U-Boot should or should not get the bloblist from the
> > > > existing register argument.
> > > > But xferlist_from_boot_arg() should be called when a valid register
> > > > argument is there, I didn't see this in your patch.
> > > > Maybe you plan to do this with other patch series, but simply
> > > > reverting this results in a breaking of handoff policy and the
> > > > firmware handoff won't work.
> > >
> > > Yes, I certainly did not want to revert it, but the current code is
> > > too hard to understand and I did not look at it at the time it went
> > > in. I've had three tries at working with what you have here, but each
> > > turns to spaghetti.
> > >
> >
> > Still not very clear on what concerns you have and what is the way you
> > want to go.
> > The logic is straight forward, when U-Boot has a previous loader and
> > the registers pass in valid arguments - It indicates handoff should be
> > done using the transfer list.
> > Other kconfig options decide whether to use the passed in address
> > directly or copy to a predefined address.
> > But in either way, xferlist_from_boot_arg() is doing the right thing
> > to get the transfer list from the register if it exists and is valid.
> > I don't see a reason for removing it.
>=20
> Here is the initial code:
> >>>>
> bool from_addr =3D fixed && !xpl_is_first_phase();
> /*
> * If U-Boot is in the first phase that an arch custom routine should
> * install the bloblist passed from previous loader to this fixed
> * address.
> */
> bool from_boot_arg =3D fixed && xpl_is_first_phase();
>=20
> if (xpl_prev_phase() =3D=3D PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
>    from_addr =3D false;
> <<<<
>=20
> and by the way, that is my tree. In -next it is even worse:
> >>>>
> /*
> * If U-Boot is not in the first phase, an existing bloblist must be
> * at a fixed address.
> */
> bool from_addr =3D fixed && !xpl_is_first_phase();
> /*
> * If U-Boot is in the first phase that an arch custom routine should
> * install the bloblist passed from previous loader to this fixed
> * address.
> */
> bool from_boot_arg =3D fixed && xpl_is_first_phase();
>=20
> if (xpl_prev_phase() =3D=3D PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> from_addr =3D false;
> if (fixed)
> addr =3D IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
>       CONFIG_BLOBLIST_ADDR);
> size =3D CONFIG_BLOBLIST_SIZE;
>=20
> if (from_boot_arg)
> ret =3D xferlist_from_boot_arg(addr, size);
> else if (from_addr)
> ret =3D bloblist_check(addr, size);
> <<<<
>=20
> I want to update it so that TPL creates a bloblist and passes it
> through the following phases, ending up at U-Boot.
>=20
> To my mind, if CONFIG_IS_ENABLED(BLOBLIST), then we should check the
> registers and always accept standard passage. If not, we should
> either:
> - create a bloblist (if this *is* the first phase with
> CONFIG_IS_ENABLED(BLOBLIST))
> - use an existing bloblistl, which must exist (if not)
>=20
> I just don't think the existing logic is a good starting point as it
> is too confusing.
>=20
> Perhaps, putting it another way, what do you like about the current
> code (either version)?

We need to untie the check for and create logic. And we need to add code
so that U-Boot can pass from one phase to the next without a fixed
address. That should help simplify this logic and move towards being
able to just drop the fixed case entirely.

--=20
Tom

--Llkt9mZAZKWVlYfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmelUa0ACgkQFHw5/5Y0
tyz5CgwAmtGR+sXG1yPQ13Y1jNOhgU+9CI01S4/IQTujw4EIASh1VlZq+k9pCLcy
v4eerTgvhD+2JAezeFoTFaeWhXDi18udiTY18St3tWfBR5DK9XG/uTaXQLgsOGto
qZsB1+9Qpfu3ZQHU6X4ATtjjClE34CPZyStY84JJvwOPwl7JjTISpP5gTbWqQZ+2
gDyxMZ2GDC/riKvNQnBskm4MEHC+8rlujn8lS2LM4u9kHRIviTbk+DhXODlDXxbb
JeFqVKpJWqu7IFKs+Y3LzOyKrbzgs/AAflhouJbiqKKHMHXEBN+aSkrJZeS7HZi8
/q3LhqwOI+1HqSWrRDWGBAzQGv+gclrZqwKP1S3vGrX4gtwnpeqnLSahtDReidkD
LtISJ5a0uPtduWUj0F33RS/66yGnLsaUJkCd1nE/oUSYQbovGbnbx/vnnfFmtyhk
Sl9JFUQMh5ANa6QRB1+bH9Y3piBL7Ij7AUq4ODKWXBFC/NsC4EvBjZRIYQYbB631
X03nFh01
=5uIj
-----END PGP SIGNATURE-----

--Llkt9mZAZKWVlYfm--
