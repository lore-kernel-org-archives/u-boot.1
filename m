Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1893BC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 16:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7929082AA7;
	Tue,  3 Jun 2025 18:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K8/W1Pbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEA1582AAA; Tue,  3 Jun 2025 18:22:53 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C7DC82A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 18:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c27166ab3so3994778a34.1
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 09:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748967770; x=1749572570; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jQ7U2mTOLN4wTlHpTORrjyntkqMBJdwEinpd4ZSoFGM=;
 b=K8/W1PbqnkrDAnzRC5tVKK4kNKrMWsJ98TAZyW7SFStfPck+goRPZtAujSutVMB9gM
 dO+TbYjV0a5IV5HmUz1BpFgAvLcEDPn44G2BHcvfeCGiN1E70X1PjMKqq0zM6z8MU0WZ
 NMz5dtYMJwyq33sD47dxfg7/80rGAQPCTR+PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748967770; x=1749572570;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQ7U2mTOLN4wTlHpTORrjyntkqMBJdwEinpd4ZSoFGM=;
 b=geJVceL3TTi6K7MdUXuDsf86grcM6jAET6Yy+I3swHRQDzq9FJM61XP5f9qC7x3ywN
 gGr2XVLd2SybqXcZ4uJqJcgtZEc+MCzpdb7WgzJvBUN0lQLrlMf17x04PPjfq2Gv7Yo6
 p95TjjXzCid8wXQ5kfKF4B/wKI/8teIlmyFADmL/EQwFTfBTpnMHXphHlo/8XW/zoFK6
 bxsH4QYH18O9U4eD3da8+aObJQ6mPsn9DkkVaAhel+W7nM7VR6omobVa4xlfL7r84fp+
 1tcxciLlE3aF0Cax98o4Og5HDkgGff3nwic3mpb/4fFWbiMWkFvP/38RW/9reZ6rdDlq
 0m6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxCrQWELK6rROaZR+vesW9nCmRvsyXfef2/5FdNk88I/Q++xqv+mPta4xTWkL5x0myzP4JcVQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzWhrb5Q9djVx2b7qEicFvLWGfs9ovekc0GaLfwJWglkjfK+FzR
 XRKqMzKdkcir0YGDwqEidlbDGksVyldpr17wd3L2QNyKyd3Wiv58chR10ynJ3A6qyik=
X-Gm-Gg: ASbGncuQM4XkzkjVGV5rHGx/uE69XH/6QKQNB6Nl2LJJNXMLrZi663VbDApyCaXYLCz
 N20XJGd8RRpZZ1aANri1jvNFo/13XhDJIYMw4qTOrUp70WLXBcK3hXvLYokygIN/nLBMwl+y6YI
 Q+AjkPqVfaD23MDrOFUMHuAmmSvSbnIJLNB0mF0g4pPKaRlatZaDbLTFzr752HEtZL78X7dCpvX
 qjaz4TA7geRgclZG8HLtazSd/5ZQXwUeD9dIo4TSg/sojHXmKbDBIEqRNNkUrL80wNohM5c28jc
 3RQxrc4i7kFDpdjiZyvXiZHnqFTtm5wJne3z4YsA62LdzjisWCAGgt2/mV3TAYo/YRcWNt1keGb
 kgangFHf03EPUOCwNhrKuxlo=
X-Google-Smtp-Source: AGHT+IGcy0+iZUwgesLmFkg27VzD3Vw5SnWzhsJl15HNq3RNBAA4woazil15wYkpmB2bbKVhPUS6xw==
X-Received: by 2002:a05:6830:490d:b0:72b:823c:8f66 with SMTP id
 46e09a7af769-736ece095e6mr12568272a34.9.1748967769982; 
 Tue, 03 Jun 2025 09:22:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af852368sm1925255a34.15.2025.06.03.09.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 09:22:48 -0700 (PDT)
Date: Tue, 3 Jun 2025 10:22:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 2/6] lmb: replace the lmb_alloc() and lmb_alloc_base()
 API's
Message-ID: <20250603162246.GJ1382132@bill-the-cat>
References: <20250526091253.400802-1-sughosh.ganu@linaro.org>
 <20250526091253.400802-3-sughosh.ganu@linaro.org>
 <CAC_iWjL+0bwPS9eXfvnFjN8UcAta+zgHz8vfDWz5YvVwoE9tsA@mail.gmail.com>
 <CADg8p96yFhzabfzZEhNzWX+kEwBuOsih0kVL+0d=ZLt=F2JNDQ@mail.gmail.com>
 <CADg8p977sXJRS1CM6Lnmep0_gc3jc9b3yFg1A-qkVn5Gswr_=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DTIhV5Fo7L1or/6z"
Content-Disposition: inline
In-Reply-To: <CADg8p977sXJRS1CM6Lnmep0_gc3jc9b3yFg1A-qkVn5Gswr_=Q@mail.gmail.com>
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


--DTIhV5Fo7L1or/6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 12:14:44PM +0530, Sughosh Ganu wrote:
> On Fri, 30 May 2025 at 15:41, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> > On Fri, 30 May 2025 at 13:17, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > > +static phys_addr_t lmb_alloc(phys_size_t size)
> > > > +{
> > > > +       int ret;
> > > > +       phys_addr_t addr;
> > > > +
> > > > +       /* All memory regions allocated with a 2MiB alignment */
> > > > +       ret =3D lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr, size=
, LMB_NONE);
> > > > +       if (ret)
> > > > +               return 0;
> > > > +
> > > > +       return addr;
> > > > +}
> > > > +
> > >
> > > I think we  need a better naming for these. Right now we have
> > > lmb_alloc() here and in tests, addr_alloc() in snapdragon code.
> > > I'd say either export them as API if you think they would be useful,
> > > or get rid of the wrappers.
> >
> > I kept these functions as is to reduce the amount of change resulting
> > from introducing the API. Also, the newly introduced API has
> > parameters which are common across all the callers, which also was why
> > I kept a wrapper. This is especially true in the tests, where it would
> > be required to change the function names in a bunch of places without
> > much benefit.
> >
> > >
> > > [...]
> > >
> > > > +static phys_addr_t lmb_alloc(phys_size_t size, ulong align)
> > > > +{
> > > > +       int err;
> > > > +       phys_addr_t addr;
> > > > +
> > > > +       err =3D lmb_alloc_mem(LMB_MEM_ALLOC_ANY, align, &addr, size=
, LMB_NONE);
> > > > +       if (err)
> > > > +               return 0;
> > >
> > >
> > > This tends to blow up in random ways. See
> > > commit 67be24906fe. TL;DR 0 is a valid address in some systems.
> >
> > Yes, I see your point. I think the calling function will have to be
> > re-written such that the env variables get stored only when the API
> > returns successfully. Then at least the platform will not have an env
> > variable with some junk value.
>=20
> Thinking about this a bit, I think in these two instances, returning a
> value of 0 might not be an issue if the DRAM memory does not start at
> 0x0. Don't get me wrong, what you are suggesting is definitely
> correct. I am only thinking about increasing code size on these
> platforms if 0x0 is not a valid address, and moreover since the
> platforms were already setting 0x0 in case of an error. If it is okay
> to increase code size on these platforms, I will change the calling
> function, such that the variable does not get set in case of an error.
> Maybe Casey and Mark can comment? Thanks.

Systems where 0x0 is not valid memory are common enough I think, yes.
You can see what the size growth is by checking say j721e_evm_a72
before/after, and if you haven't been using buildman for size
comparisons already, I posted
https://source.denx.de/u-boot/u-boot-extras/-/blob/master/contrib/trini/u-b=
oot-size-test.sh?ref_type=3Dheads
a while back now. Thanks.

--=20
Tom

--DTIhV5Fo7L1or/6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg/IU8ACgkQFHw5/5Y0
tyzYFQwAiRLMJUP+bt5oiDzfLltVPl6ShngY1CUDzDgNOPQkjcoijzxfbI7Vo8c+
79YexUCBX5tKAhuaUyJHuJm3Y4ybXtMEl1C4EYi12sECFaa2Y/I8umcmyR57fcnp
qlG57rH6gHHkkNBA58NWTmTQkx0O+jcwxZTO4riwKaragjBJl7eLhgEWwu0jQgG5
TFkQJgrQbn4gRBNlNacZWNTJ/qHDCJeY+VAXRJhaLXzozbKtMLkllFtUJKg6UOtc
2yCVOY+7S28u+1xoBiQzrzd8dp8ZNiVmaYVHtE/hIUh8bVSJw26GQuGeQCDoklrs
L1c0Wr8vS6kHRsStOEQSvqdn5rRg5VnL5p7hbCN08gkVuSEJ58bAArVGPpGGSSGv
mg+U/yDomtOT9/NfqwdCu7gUWwBRgL46waCkZdLlie1yVu6Hc+YU18I4Q5bb/zbF
Y3fw1VPJ0VjnvO6/1PFrS5xtdOgSXwHBGXn41COVH+WfQ2P5zySSH/MCbdoKJEON
dcOhAiIw
=QL2Z
-----END PGP SIGNATURE-----

--DTIhV5Fo7L1or/6z--
