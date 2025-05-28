Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C90BC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 15:10:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B183832E6;
	Wed, 28 May 2025 17:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b4SDu1Mb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC169832E6; Wed, 28 May 2025 17:10:03 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366AD8329C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 17:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-605f7d3215cso1955305eaf.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 08:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748445000; x=1749049800; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ItutELRCvnxYP1lE6WvurEhitRjbmD0AuJ5xZRvV1vg=;
 b=b4SDu1MbspbXCIfI+5TVT5jveH0h5E4RhhqW9VeuLvgLym8NIcQPIiYQ0kT3H8MhGD
 WL73xAG/jVuiif6EOg6p8Wf6t4x9jQkDupSFfMq6gjm1Fyd7yOLz/J877Qb4vIdns4qQ
 VqUy6jlXsbWFYyhUsf1MhdeDttArWYevIwz1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748445000; x=1749049800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ItutELRCvnxYP1lE6WvurEhitRjbmD0AuJ5xZRvV1vg=;
 b=i0TCXwAsE/nFSnzlOpFWXoVEpDDgWD18RG3gCQwci0OXmhYi9d5Bk+arhWJbP+db1U
 w9sdK5qz4pPCUzsJRzAA6YTCafkd/lbsgTQMAu2U7Z1BbE70MGT5UaZgkN4yGq9pAi4q
 8/pbM5GL2jy3HaHpFIMRD3I7JC5KfBc2dr5QcRoWIz9OFner5fgiOmWsjRCOdTJK+xBL
 qcyefDTU5QogZ8JHNYA4999nKJ0WSOX+nPPdyv3nt63zCoTXtKoNANRtGz//drKlvqPW
 XC8FSxqKnkVYLRujC1HYRn/c3Liz7oP/i3c41hCgQlL3dn67gB7MIGgWhsmu8v77HweK
 UOhg==
X-Gm-Message-State: AOJu0YxfpiIk2M23MHzh0TbBT3MVmB0Hd6iL+KPQt73kLryG/sI62LA/
 zQfjV4YnlCCVkls/lkKrfQlU6CuGqiB7LwKyUj//eXgjt8xEEEtK4+3UxiDz+b8NrHM=
X-Gm-Gg: ASbGncuh3E3XlEdFbR1u+NBOHxMbCmQiehKDygB+uAKRFHw6RmVmtZJluZ4jcZnry3v
 w24JR4CU7PFJV5/ZdbaQrqCw3chKw0vgyeEc2phsI3cKTCkipl+AUcUIx65jOe0vFLMea36o0pj
 u+AA+H+0NSz7Pbmin/8mtyR+puPYBDULrJKeYxRHaDZ5BdY43Z7isUbXYg7SanyB9PleAhJIhTE
 Nx7FstKEo+7Hi63Ts0Rw6gNZeViRQWMKL32YhWrLdulw80XycnyikV7dxT7amWkT4Ui54MbvPde
 q6yea0kE4nSpShwpPEqbsU7oH/FIYpNRwYn79A8GaW4VnhKvZTS/VSJMub5gCfn145m2k/2bKbN
 /Eftn9LooqMfk
X-Google-Smtp-Source: AGHT+IFVgyv7yNTUQ5szcyOWpjTNstxyEynyrdd3VmTYPfuXquieQbLm5bDNd9Z3fm80iEpvy1WDEA==
X-Received: by 2002:a05:6820:1e18:b0:602:7078:df55 with SMTP id
 006d021491bc7-60b9fb1d5d7mr9057272eaf.5.1748444999814; 
 Wed, 28 May 2025 08:09:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60bd9d24a92sm206359eaf.39.2025.05.28.08.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 08:09:59 -0700 (PDT)
Date: Wed, 28 May 2025 09:09:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Huan Wang <alison.wang@nxp.com>, Janne Grunau <j@jannau.net>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rick Chen <rick@andestech.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Thomas Chou <thomas@wytron.com.tw>, uboot-snps-arc@synopsys.com
Subject: Re: [PATCH 1/2] bootm: Shorten BOOTM_STATE_
Message-ID: <20250528150956.GA100073@bill-the-cat>
References: <20250527124038.3633270-1-sjg@chromium.org>
 <20250527133249.GH100073@bill-the-cat>
 <CAFLszTjjoxc+THgdrWEam2XQKNPp5zeYXF2o2u=MyibNOYT6oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a8kVu500kELXRLM8"
Content-Disposition: inline
In-Reply-To: <CAFLszTjjoxc+THgdrWEam2XQKNPp5zeYXF2o2u=MyibNOYT6oA@mail.gmail.com>
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


--a8kVu500kELXRLM8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 03:32:48PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 27 May 2025 at 14:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, May 27, 2025 at 06:40:34AM -0600, Simon Glass wrote:
> >
> > > This is quite long at present. Rename it so that fixes better with the
> > > bootstd naming.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > First of all, sigh, this doesn't apply to mainline. After the last few
> > days, that starts to feel like bad faith on your part. Second, I feel
> > like this reduces code clarity. I'm not rejecting the concept, but
> > shorten + document doesn't feel as useful as "document". Finally, what
> > "bootstd naming" does this better fit with?
>=20
> Firstly, the conflicts are trivial to resolve, if you would like to
> take this patch, since the conflicting code is not in your tree. This
> relates to the booti and bootz features, since you wanted it done a
> different way, reverting an entire series ("Precursor series for
> supporting read_all() in extlinux / PXE") rather than accept a bugfix.
> I'm happy to send a PR once I get to the point where you are happy
> with my bootz/booti fixes, but I do want to work on that
> incrementally.

There should be zero conflicts. You keep posting things based on top of
your growing mountain of incompatible changes and expecting others to
deal with your problem. Stop that.

> The bootstd naming just means that flags start with a BOOTxx prefix. I
> am trying to be consistent with this, as is done in other boot*.h
> header files. This variable relates to bootm, so I'd like it to have a
> BOOTM prefix.

BOOTM_STATE has a BOOTM prefix. BOOTMS seems needlessly short and less
not more clear about what it is. We do not live in a world where byte
count of source code matters nor where everything must wrap in 80 x 24.
A few characters over or a few more lines to provide clarity is very
much worth it.

--=20
Tom

--a8kVu500kELXRLM8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3J0QACgkQFHw5/5Y0
tyydZgv/fehSrXIoWyKm311b3e3ZrfuYxWw4ACBLm1wd4hxnwqYCL2tuzbsSmBhO
9nI5B/l2VfG+agrqSrCIDoXNoMFOR1N0e0Y3Zos9FokX83RIubKZmflwb65XqR3k
NPnnqSee4260zVwIGhgrPapz8Kg3QKFed8WT+sD3NBd1oDi6T9jTU3OWvwLSgxE4
gYdAyi7TDKYw9WtLPxKkfqsGlc4+1B2cqUzt7PARrwt29G1G9FARqwNt/nsG/1+G
3pgLImGMm7UeJ+j4HHs1Jr8JgfJbOSlPT/K8bx2aCy47gddBDE3YxIxHBKrsA1LH
rWVa3FoOYDdXw52/SDlCmeJSOOUfBLRoD2+tY08suqhj4sw1SJkDdKRkx31ZfWbs
sbSz5OSf8FtYkWZ2txZLTpK1wQw4lWWCM9oi/rKNI8dEN921Toe+Vk7yJoPoqfA0
RoK5dWqPfv5vHVIIY9XkH9Ew/RDF/Iox2Zks/DfI7f8hZXtKF46khqIwNOCaOpyx
MyUE8Fbf
=dDYk
-----END PGP SIGNATURE-----

--a8kVu500kELXRLM8--
