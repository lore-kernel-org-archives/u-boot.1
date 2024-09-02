Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C117CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 15:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7F5588B49;
	Mon,  2 Sep 2024 17:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Oa3eLg8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3197F88B49; Mon,  2 Sep 2024 17:42:03 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A061886FD
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 17:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7a8049d4a4cso283449385a.0
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725291719; x=1725896519; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5hndqTB/o/BRfRpRmCKYtf641eplIRF20Rwfr5PP3D4=;
 b=Oa3eLg8CFGBD54habMHepaab2gqLvADNJc5qTvbwmv6fJyC3quZv8qb2A3hI39KgWj
 41wQuhVjtt+V3A4BQlFzW6+nqr9eSOYpzJMtqw96G8aBvVPtigJs/lUIafYdek17t3tm
 fNTqhFR/gwtauc/jjnMCT0Rm8/vvW3Xo8jgp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725291719; x=1725896519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hndqTB/o/BRfRpRmCKYtf641eplIRF20Rwfr5PP3D4=;
 b=mfjrBZtTU47PuW56XW17i9+IYOh26soWYxV1h9n0Q1Ap4zp+F/+geHs55zwrLcl9M/
 cGPwh6JSg0vPxnCXFtkoC06GOuiWi/XWPLReUweBRCnEEFKUXufjtjV1L2ZdOcagjnWH
 psfwloJR9u33UK6lyFEZyU5luNfPer96JZqPbfsj/HjCB7l771SQSJfU9w+Wt3tMYbhB
 PoINlaxQ0idKd/+QFSlOUqTm78attR/ruS1HonA3Et8NYaDyHq5Yf/vt87MgLwBKgE+V
 yigmQsEsOAcjoXmte9LCA9rMI0xw0k32I0WoCwnhNKESrbi59wDbSDqXUjUpmEz1AfJ2
 7c3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxWLnHLxJ7jCDPCpIzJeZSVgZL68mkeV3/0/PoryJK7lqLCF9uKkFn54D0eutI9LmkHlMqGog=@lists.denx.de
X-Gm-Message-State: AOJu0YxoaNhefdIPGBWVFpdxGrKq1rVh9Q1gFQ88Zsen/8tv/idZV+O+
 DM0VDSLpsc6rYQtWiOh1KHxed070Rlw+GXZZ1p6z0Q6p6JGFd+vfma6W33CjOds=
X-Google-Smtp-Source: AGHT+IF0e6h5e5unW5Fjn18KuzxBNYkwfhJ9D6SQxmXRuBylv/g+PbcARWisSrdOxR07gqGFKGn1Iw==
X-Received: by 2002:a05:620a:17a5:b0:7a3:78c2:d20c with SMTP id
 af79cd13be357-7a893216e5cmr952133085a.19.1725291719358; 
 Mon, 02 Sep 2024 08:41:59 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806aa8e53sm429952985a.0.2024.09.02.08.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 08:41:58 -0700 (PDT)
Date: Mon, 2 Sep 2024 09:41:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 09/13] net: wget: allow EFI boot
Message-ID: <20240902154155.GA2479150@bill-the-cat>
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <1a6084e845a0612546a1e86d142208af945c8f77.1724846454.git.jerome.forissier@linaro.org>
 <CAC_iWjL9g0c8UHF3L44b8HEG-2=d57XsDXPpSogthWDPgzPcaw@mail.gmail.com>
 <CAFLszTjLmgXO-31CwAOv1qQ9x0aDk4aHGVkScDF1bz-WhfrHGw@mail.gmail.com>
 <CAFLszTgQNatTrhY_PVwN96tbuRvS=PRqawhH93+1TM9y_Mg79Q@mail.gmail.com>
 <CAC_iWjLg5h5uPgK0rO04ajGL1z8bpxYAzv3j048hsXAwz22MzQ@mail.gmail.com>
 <CAFLszTjsTYi_jddj+05i77xjQ7gdvYC115C2hYYauAv7xTEhNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6hQoJjYxpHywS4Kj"
Content-Disposition: inline
In-Reply-To: <CAFLszTjsTYi_jddj+05i77xjQ7gdvYC115C2hYYauAv7xTEhNg@mail.gmail.com>
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


--6hQoJjYxpHywS4Kj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2024 at 02:09:40PM -0600, Simon Glass wrote:
> Hi Ilias,
>=20
> On Fri, 30 Aug 2024 at 08:28, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon
> >
> > On Fri, 30 Aug 2024 at 17:18, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Jerome,
> > >
> > > On Thu, 29 Aug 2024 at 08:04, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > On Thu, 29 Aug 2024 at 01:34, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > On Wed, 28 Aug 2024 at 15:10, Jerome Forissier
> > > > > <jerome.forissier@linaro.org> wrote:
> > > > > >
> > > > > > wget followed by bootefi currently fails as follows:
> > > > > >
> > > > > >  U-Boot> wget 200000 192.168.0.30:helloworld.efi
> > > > > >  Waiting for Ethernet connection... done.
> > > > > >  HTTP/1.0 200 OK
> > > > > >  Packets received 13, Transfer Successful
> > > > > >  Bytes transferred =3D 12720 (31b0 hex)
> > > > > >  U-Boot> bootefi 200000
> > > > > >  No UEFI binary known at 200000
> > > > > >  U-Boot>
> > > > > >
> > > > > > Fix the problem by adding the missing efi_set_bootdev() call.
> > > > > >
> > > > > > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > > > > ---
> > > > > >  net/wget.c | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > >
> > > > OMG the hack never dies. I hope I will someday create a series to t=
idy this up.
> > >
> > > I'm sorry for that remark, not helpful to collaboration.
> >
> > If you've figured out what needs to be done to remove it, I can deal wi=
th it.
> > If not I'll put it on my backlog and have a look
>=20
> Mostly...my idea is to track loads within bootstd, adding a way for
> bootmeths to record files they load, in struct bootflow. Then when
> booting EFI, we just pass that info from distro_efi_boot() to
> efi_binary_run().

I worry about conflating "loaded something" with "need to boot thing
thing". Maybe it's not a problem in the end, but there is not a 1:1
between "loaded something" and "will boot this thing".

--=20
Tom

--6hQoJjYxpHywS4Kj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbV3MMACgkQFHw5/5Y0
tywGkQv/bwe7D7swbkGWaT3GtLpxmila6YZ5V1m4vgNZUnZfmYeQiou+g6o5P3DW
VHtD/gykg1Qqo2WRYVdtel6JgLEp4M+zKbQDbQhPF3N1MTyH1nXuoezSQaXNV8Ua
ocg1hqH4hQFtVCg54eDBUh7KUolEUtNfuo7LxSpe6SSCMdOJuPIQOuOs/QwPinyN
BcNhsK3cL5sVteHf7kVKrxWTCZpD6KHBqS1WPRB8iN6FVLa1wSPE58IUCTTKhWnY
LTqGHxns8k3Shm6eJqA2lhjZaTa9Wrfjr7s+2KDB7R36TnV5bv1urHRY8yixTw/p
dPJzVedTe5ZS2N/Qlh8xWtL5qP473iFzQdEz/Wm9NuFfCxPxW3eFxDMJJjUNOZ8Q
6oOG2Kv+dyrZdhucFMXhXAgz5NFSfWDJEOKqlwNhyusyqgy+vCFUs/Pp7nfp8FJP
c+YYTR005rFEAN7c6AW8vZWkLxswZb9Udy0XpYUotL5NZOu0QTHwdPQSpuygK2Fa
5m6yQMvp
=p/f5
-----END PGP SIGNATURE-----

--6hQoJjYxpHywS4Kj--
