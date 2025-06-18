Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE04C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 22:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC94B82C2F;
	Thu, 19 Jun 2025 00:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B/FDsNxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A13BF82C55; Thu, 19 Jun 2025 00:03:44 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7703C82B20
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 00:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72bd5f25ea6so62436a34.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750284219; x=1750889019; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5kepr0G2QXJibHSjc2r85olOVwDH23Ru+KdmmyvT8u4=;
 b=B/FDsNxLEnxhFjPh8zpW/PbNOrcDCe2fOikMPRaSgmiafBXBmtUPSjAnSSpPuHDkA/
 sfAU7dmLJmrP8RKM+yS9KxvRlAWV3qWWayGo1S+uEwit/DlQLbUnz6jCcQYB7iYvBZZk
 im/YGWaX3so5bFAuzafkQWioN+Tsb9FvIxkJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750284219; x=1750889019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kepr0G2QXJibHSjc2r85olOVwDH23Ru+KdmmyvT8u4=;
 b=vfC1KkvveB/16SbuhGZCYQlTAopiJgVEPUk/Y7mBZJRKJsgqlw5JTqfex+zjB6U8+e
 3hjU38TfDatQf8UrG7gQqkQPmq0ptHmvE6NYnfKO1PomtUAEV6REqpJPyCJyKnoLE9Zx
 QSVXZRP187Jn9UZYbOUQ1c9DNCx7i75Rub7w2wBuwPvtMgBn52/KpvEyVwp4piz+Zv0V
 1b/uVL6b/FzSml+2n1kJlLDSieEdHrDYWEthMdrpOJAu9PQ1Eii235E+VpHB38P+Arp9
 EKiXBlLwUz8roXpQ+ndoYHmJBVq/LxjAFOIT6VLllOFbC/DIHQRDKzeYAr1udwqHruBO
 Sz4g==
X-Gm-Message-State: AOJu0YyT1El8tgozvPfypi1/77AMlOEdYQIn+h8VifBmK/HnQHp/A5Zm
 9HjHO4FbmKHjs/qXoC0RPW2hWUIHxLeDstBVTV5BkZiyhZJLJ1FgJO63HJX0dJW0uvw=
X-Gm-Gg: ASbGnctcsLoahzgLWDkZ6xs43x3subyForfvdiuJBsTTy1BRPFzNVUQM+vw0Ae2Yahc
 BS66E5y5MxZb5TiTlefGt03dizKj7B2efMVg4OpMWnygfcfH7mpeN+DPEsSD4TeyH90H7IP8pc5
 lfN71lzwsY8JE0lyrBU7PqsMQf1lqn4E8VJGNgu8QK6m/PwgLsL6XXxGbwD8pIWUGgzU5/polnM
 llUv6h/Ad2vz0vtG3D918CBOC8O09MiKT1iiVW2IVD0LoXdybzsGmwI+bjbekRWftwOh2qw9xcD
 Aogo4QhLZaGAfG/SrOOaOMwR31VcMEsat7TGx+eajN3WrgB14FzfsWGZyIA1CHz2eSTVrNHvhS4
 dbttGdUYkmg2uNDs6M9AvsAM=
X-Google-Smtp-Source: AGHT+IEKTI9ujiqT28t9lpN1uwC14Hoe/w1l5rSSCTxxBGFueChdfdcfK7w8sP3VPWPkszsDr8k27A==
X-Received: by 2002:a05:6830:8009:b0:72b:a61c:cbb2 with SMTP id
 46e09a7af769-73a3629556emr11532551a34.10.1750284219126; 
 Wed, 18 Jun 2025 15:03:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a28402827sm2103029a34.17.2025.06.18.15.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 15:03:38 -0700 (PDT)
Date: Wed, 18 Jun 2025 16:03:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>, Harrison Mutai <harrison.mutai@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 4/6] bloblist: expose 'expand_by' as an output argument
Message-ID: <20250618220335.GJ6521@bill-the-cat>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
 <20250618145930.2652304-5-raymond.mao@linaro.org>
 <20250618174011.GI6521@bill-the-cat>
 <CAEfUkUJnUf2m_Dv=4HM79qqDzQRnhsUU4mKFiprp8cRqHoJogQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5Hjywb+ajZVLeqkj"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJnUf2m_Dv=4HM79qqDzQRnhsUU4mKFiprp8cRqHoJogQ@mail.gmail.com>
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


--5Hjywb+ajZVLeqkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 04:01:02PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Wed, 18 Jun 2025 at 13:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jun 18, 2025 at 07:59:26AM -0700, Raymond Mao wrote:
> >
> > > Some advanced usecases of bloblist needs to know the actual bytes
> > > expanded or shrunk after blob resizing.
> > > For example, to support applying DT overlay from bloblist, firstly
> > > the FDT blob needs to be resized for potential size increasing after
> > > applying overlay. If the DT overlay blob is one of the following blobs
> > > of the FDT, its address will be shifted after FDT blob resizing.
> > > Thus, returning 'expand_by' helps the caller to get the shifted data
> > > pointer when it comes to get the overlay for applying.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > [snip]
> > > @@ -337,6 +338,7 @@ void *bloblist_ensure(uint tag, int size);
> > >   */
> > >  int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp);
> > >
> > > +#if CONFIG_IS_ENABLED(BLOBLIST)
> > >  /**
> > >   * bloblist_resize() - resize a blob
> > >   *
> > > @@ -345,10 +347,17 @@ int bloblist_ensure_size_ret(uint tag, int *siz=
ep, void **blobp);
> > >   *
> > >   * @tag:     Tag to add (enum bloblist_tag_t)
> > >   * @new_size:        New size of the blob (>0 to expand, <0 to contr=
act)
> > > + * @expand_by:       Number of bytes actually expanded by (-ve to co=
ntract)
> > >   * Return: 0 if OK, -ENOSPC if the bloblist does not have enough spa=
ce, -ENOENT
> > >   * if the tag is not found
> > >   */
> > > -int bloblist_resize(uint tag, int new_size);
> > > +int bloblist_resize(uint tag, int new_size, int *expand_by);
> > > +#else
> > > +static inline int bloblist_resize(uint tag, int new_size, int *expan=
d_by)
> > > +{
> > > +     return -EPERM;
> > > +}
> > > +#endif
> >
> > Do we really need to be doing this if/else in the header? What's failing
> > otherwise, and can we not guard that with:
> > if (IS_ENABLED(CONFIG_BLOBLIST)) {
> >   ..
> > }
> > in the code?
> >
> This function is needed to be called in fdtdec, if it is not guarded
> in the header file, we have to guard it from all its callers to avoid
> linker error when BLOBLIST is not selected (In the future, there might
> be more than one caller).

Yeah, I think I'd like to add the if/else later if we need it rather
than preemptively.

--=20
Tom

--5Hjywb+ajZVLeqkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhTN7QACgkQFHw5/5Y0
tyxVLgv/Q/VuiYvlNDZsCXku6Ztk1H0fm0Myeezm1a5Z/V8Xsd/ElVaPn5qAnyQm
W3PP/YQaLz/E4lx6jf+/Y4h1q8eRw50V+8L1R/kKLAkZy7APR+Cs/oC/BOgp/ozQ
rpSmRUM9Ztq7HeM83D8nG/WkTUYJcRCVyMRc7G7NRDN+Tpnm7+dRlEtWf+ZrRwE9
Uh6I9DwhZu4Egcu0ZL+bjT08L/5sdruxMjOOvClIqAs8l4Hu2MFDQeT+dG9yZghW
8g/LyD7nJdngqYHkXuVM9f7p0n+S5W17DhfXy/Fz8etpoyExS+ENFW1tSKCgqs8d
qhwO2yi8QkiaPwWzgIoFz2KsPJfslLgHVco1jWBkGLOPBWXmMKf98rb6Rx8rmK6X
mx4cI7et/BMNN6SpW41CelZ3SjIbprRycAaPQUfiq5rWazwwvbBGohV8vmHACzrH
/yJwzDlBIUPSSw5yw+UuQauoh1gSczGHU1qaysSbLEoajvvz/h/QoQJilMz3QnnE
6QM5afZi
=BMdN
-----END PGP SIGNATURE-----

--5Hjywb+ajZVLeqkj--
