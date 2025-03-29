Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073DFC28B20
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 00:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EBB480ECC;
	Sat, 29 Mar 2025 01:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eTJA6iRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57450810F4; Sat, 29 Mar 2025 01:02:19 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8BF0809A5
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 01:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c0cf1922bso406437a34.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743206535; x=1743811335; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Am4lhWe29RbJv8HA2jxDpakZosGBZvbB2jU97KS6qxM=;
 b=eTJA6iRT4cxqFvzGGfGqbFD10QSoGHQH8Tky+qlCTGlrfgVa0PRtD/5/N+7qFFBULK
 Pxkrgs7YAmLydcK3tIfS5TCvBXkjThYlxebTu4J4zDbED7DnNQ7G/dgTnRHdC+tQT6KV
 UfrBTCIm08DVCYcvZ1PIN1fmCk0oZEnk3Y+cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743206535; x=1743811335;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Am4lhWe29RbJv8HA2jxDpakZosGBZvbB2jU97KS6qxM=;
 b=SwF0bNbY6glSoh0/cypKM01BtWRMQ9ORl56Xt3Lj3j07w41uJVncKR27fdjLs6GjuK
 03htyMQePoobuM2v/hYTv1w/IAj/8ZZruFISK8DAJpfUM2ZEPVykn9l5U/bPioeqarf2
 OHJTlECMNzxHvKkPJC/g7AWhujRGli+l3kykkv85uv/hQ4o2OC8M/GWKwTx5T6EYUKIz
 MgzIDwk6VNb0PViCxBYGqe0vulSXFu2/MveQG97vfZtOVa4iTRC+SeXAlvrey75KAxG0
 wynkbcC2FK+PHIqmD5t1f8ObV6b4lDvANFcKEEW6ZPhqx0FO9mwzgVvhjIbMOd2x3kNJ
 7fwg==
X-Gm-Message-State: AOJu0Yx0n/9f92aHlnmdRxh2oq8XHcfKBKxY6Un14mVu3+B08HBDxgz7
 Y30YQBTlpF0jpX1AjwJ+9DRTG5+6KoNBNq3FOMsiTD6yuaCQpXaQMvTcQStquBM=
X-Gm-Gg: ASbGncvNFXwDl6387y6ZUc5fOSgkHXoid3sY7tu50pROGkeFQXlYrMu20GmwVW4G3oS
 ov5lt7qsCYwjjARgdh7MbEbKOMsCilwlrwjchiAJE38KfIThX+FXMYa3H8ujH8OcatTZrm9oNyo
 NcOUno5ayoGkhPsQIDLWa6soHY46090QVBiWWTr3zIG0rBbWaPaCsrhFGyaXyyYYJivxVAJ0YPQ
 H8G0cpmvKiDzeAaDyR23K0x/F8uurxZRO8sOHd3xbpWt/CH+itXRZ4PvRtkUGNnc4X+90KBHlYj
 bxI4eJDsl16duimPs9WkcwfPM2qc/4f0kYmok7I2W9Pfwg6fc6RrV8htouTkjiIA+jGMAeBk6pw
 JzPlX3P+gvVc+C+AB
X-Google-Smtp-Source: AGHT+IG9ePm0gMhk1B35L++/KMgss2Q/k1CvgwRw/6yFOReYYFnvWQkoZ9ePpnmDal4H5YVLazevZw==
X-Received: by 2002:a05:6830:391b:b0:72a:4762:d38a with SMTP id
 46e09a7af769-72c63668577mr892638a34.0.1743206535305; 
 Fri, 28 Mar 2025 17:02:15 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580bb530sm561017a34.19.2025.03.28.17.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 17:02:14 -0700 (PDT)
Date: Fri, 28 Mar 2025 18:02:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
Message-ID: <20250329000211.GH93000@bill-the-cat>
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328161845.GB93000@bill-the-cat>
 <CAFLszThKn0xTmLdR7Hs_oKO_paYTtr-Y1xA_eoNY2rcjeuHX9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rPitgUp7fCWI1YNb"
Content-Disposition: inline
In-Reply-To: <CAFLszThKn0xTmLdR7Hs_oKO_paYTtr-Y1xA_eoNY2rcjeuHX9g@mail.gmail.com>
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


--rPitgUp7fCWI1YNb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 11:38:14PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 28 Mar 2025 at 10:18, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:
> >
> > > The bloblist code took what I consider to be a wrong turn a year or so
> > > ago. As discussed with Tom, this series proposes a way to arrange thi=
ngs
> > > so that it is simpler to understand and manage.
> > >
> > > - Unwind some of the nesting in bloblist_init()
> > > - Avoid needing to init the bloblist just to get the FDT
> > > - Create a deterministic OF_BLOBLIST option rather than using guesswo=
rk
> > >
> > > It is to be hoped that we can get a platform which uses OF_BLOBLIST i=
nto
> > > CI at some point. In the meantime, the standard passage series[1] cou=
ld
> > > be resurrected to give some coverage.
> > >
> > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D281465&=
state=3D*
> >
> > Based on how it's documented to be run in
> > doc/board/armltd/vexpress64.rst in the next branch, have you confirmed
> > that platforms using the handoff spec still work?
>=20
> I believe so, yes. I don't have that board to test it though. Raymond
> may be able to test this series on QEMU?

I was pointing you at the docs so that you would have access to testing
it. That's part of the docs, running the emulator.

--=20
Tom

--rPitgUp7fCWI1YNb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfnOIMACgkQFHw5/5Y0
tywQ5QwAn/04SJIbwoAy2qvwsMy4x+zOW8h53yzEK/k8A+B+psliaGeTUksQgAyR
ClOMu1kP8bHL7YFZOOtI6R+s5Nd3r80HK30eK35T/gcXvqg8VueJhJBIxL8pJJsB
CSq2mpL58sqS+rGH0CJiAYAq02RliMzidXNItP0y0Wm8aUvRj/e3jgNOFqiE4/9D
K4tYBUkB2kb8AfpHGaeCbQzXyuORM4H6C5Pmjh4INzk4j7eNtjLadz3/fKZdyfHc
aDLbYLI2qfU2ezYg6j7XOIGsTjHnsogOjdTOFHqxgsueuO8NBn6yMMDDCMnHBi/h
IqeJErs6/wvt2nuFXN6+SoCOgCRpKW92dqTANdG8QR1AADT1n1bVkem5cSiGsHyC
tsCZxN3MAmuHctv48Ocwp8lDCjknH3yHlLkZewpM47VI5HQtLjqQXSrW5WuVCL0r
MZQtgrLwlyNCmNo8l4GjD3tdlidJt7vdT5mjyo4nMVeKcSnO4D6MuhOTz8wpY6EE
MLHgIShU
=QiXx
-----END PGP SIGNATURE-----

--rPitgUp7fCWI1YNb--
