Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D1DE92706
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 14:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B55E86D34;
	Thu,  5 Oct 2023 16:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y1lk3Tl5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB8D86D4B; Thu,  5 Oct 2023 16:52:31 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A36A586CEF
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 16:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59e77e4f707so12889327b3.0
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 07:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696517546; x=1697122346; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FeORwscMPwae30eTUBFTEbw8MaR65wP1TUU6UaXuTfU=;
 b=Y1lk3Tl5KcGnNyh0itAX3tGhmU3GsKYz+lU2WE31AEuupj/xIxSz7IO0s1alNelMkX
 hxTvWaPI1l6DISzW3ysLU394kvmHIw5l+qtyH6jjevBCLL8QK+Z5lz+//cJ7rPvvGyAS
 CzCIiphlATzcRH5ai+JTen8YAV+xjaYMSHDGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696517546; x=1697122346;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FeORwscMPwae30eTUBFTEbw8MaR65wP1TUU6UaXuTfU=;
 b=PSnA7XlsE74BoWJe4vIe3mOHbY2EXEGQ4+Fr5SfziJ4XyxlF+gmyUuhGVL6Zz0PgfI
 LhOg3OfQiQhS4+8kmw5ZLxPm5UTIKhRm4A9/JGtwj1LYLrmYAkPYwxApkqRtGYhjWxwU
 hLzQQ4HGaB7g5vRlZj4dOCsPSTnUJTXB9rr84UaCSozb1u4XwJ6bAfJ50cfaAz1THh41
 KW6QBo4Ibd5sXXalar8tsbQ97RHH7O64RVpndSpcwZv/sABYQ8WKMs0eFsEsK/AM7fL5
 ILNE4BM0Z/2w/rRb2oNtMa2yCmpxh6MjIW898iUSsrTK1zQjbGmrtgFgiTiSi930uf7I
 hLPA==
X-Gm-Message-State: AOJu0YybgUaCZ8oJtDcVfFAXCAlS2Ay/dkMSp+ZEkMgfTsf4VdSEWM/K
 T0jARRd4s///sIL18dtY9NdaqQ==
X-Google-Smtp-Source: AGHT+IF6Ngi45RSHeZ9eghmfcDG6W0AnsXka4lCDkxLDNo+cJA55CnQiDOZcj5xXtAeqLEl6EWh04Q==
X-Received: by 2002:a81:4811:0:b0:583:51de:e219 with SMTP id
 v17-20020a814811000000b0058351dee219mr5845427ywa.17.1696517546338; 
 Thu, 05 Oct 2023 07:52:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f1fa-53fc-3572-fce8.res6.spectrum.com.
 [2603:6081:7b00:6400:f1fa:53fc:3572:fce8])
 by smtp.gmail.com with ESMTPSA id
 i184-20020a816dc1000000b0057d24f8278bsm545219ywc.104.2023.10.05.07.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 07:52:25 -0700 (PDT)
Date: Thu, 5 Oct 2023 10:52:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@kernel.org>,
 vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org,
 jonas@kwiboo.se, srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH] arm: dts: k3-am625-beagleplay: Fix boot
Message-ID: <20231005145223.GP8465@bill-the-cat>
References: <20230929134646.214781-1-rogerq@kernel.org>
 <c430c549-6c6d-4d32-a51b-e2bfa597bd4a@siemens.com>
 <20231004121546.uvvqcbewyt5s6kdx@extrude>
 <2f55c3f5-7867-4db1-a0cb-7bc6f78ba044@siemens.com>
 <20231005144919.GL8465@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yamVG0/GApAj1FjI"
Content-Disposition: inline
In-Reply-To: <20231005144919.GL8465@bill-the-cat>
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


--yamVG0/GApAj1FjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 10:49:19AM -0400, Tom Rini wrote:
> On Thu, Oct 05, 2023 at 06:18:08AM +0200, Jan Kiszka wrote:
> > On 04.10.23 14:15, Nishanth Menon wrote:
> > > On 22:26-20231003, Jan Kiszka wrote:
> > >> From: Jan Kiszka <jan.kiszka@siemens.com>
> > >>
> > >> Since commit [1] A53 u-boot proper is broken. This is because nodes
> > >> marked as 'bootph-pre-ram' are not available at u-boot proper before
> > >> relocation.
> > >>
> > >> To fix this we mark all nodes as 'bootph-all'.
> > >>
> > >> [1] 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre=
-reloc after relocation")
> > >>
> > >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > >> ---
> > >>
> > >> This may overshoot, but at least the board boots again. Could it be =
that=20
> > >> [1] broke even more boards?
> > >=20
> > > Jan: https://lore.kernel.org/all/b1c62a7d-a90e-4212-8972-9b622e147975=
@kernel.org/
> > >=20
> > > I got boot without r5-beagleplay.dts modified. and it is in line with
> > > the changes in linux-next commit 944adefc7f88 ("arm64: dts: ti:
> > > k3-am625-beagleplay: Add boot phase tags marking")
> > >=20
> >=20
> > Yeah, no problem, missed that.
> >=20
> > Meanwhile, I can fix our IOT2050 because I was unfortunatenly right:
> > more havoc in sight. Did anyone tried to look at the fallouts
> > systematically already? Is it only affecting the TI family?
>=20
> Well, I'm pretty confused right now.  The visible breakage has been
> traced back to a commit that was in -next and is fine on my J721E EVM
> and is fine on my AM65x EVM.  I can't figure out where my Beagleplay
> ended up, so I can't check that one as easily.  But given how the
> breakage is described, mine too should be failing.  But they aren't.  In
> both cases, I have the GP versions of the chips, and am booting the
> unsigned files.

OK, I think I might have solved my own unexpected success here in that
it seems like I had the wrong files being copied to the device and so
that somehow ended up working.  I have replicated failure finally.

>=20
> --=20
> Tom



--=20
Tom

--yamVG0/GApAj1FjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUezacACgkQFHw5/5Y0
tywEIgv9EsgeEjcRoJ5NOvWhjL8/bqACZ3hrdVVDbvTFvdNZCzWlQbXfKCmt4Z7H
ZuIJHsNNHs3V/TQseL8rL29G2YlBWNGbhPqIfqVO/NVADlzko1nDqrx8YBtmride
a6Sw84d4vTf5JGtUOyaV/9UySEca46wcoOndLqv40o+tvuPddPDT90ZNuL6lBLvH
8Msj+EWXh5BLBfTqI+eBm2dks8HHRdnqn0bpO69fhmLFSI9nmRw/inKqPyG8Vjr5
hWdE1SWJfRyMfY6lDdwRn42mgXkQVXo1jI2wbZsBCyoBo15OxEFH2vMBGmIvtKKP
kNZfbWUGo4C3TgBxwDBgwKGyfvjrHeF/m44TSqajXhZJ/C1amx2G0VHubFFdrPQA
GlnUCt8PsZwiHGbtJ3ht0CCQyOJd1vL7PuW9GyEYdobTY4PqXf0IPJIf8/OmX0eJ
TeGh7LkNzSZjLCQBujoyBVJcf/uGF8LCzG5EWSFKDRHuMfRvpwVoHLN7uzaDMRQV
TNoS3Dfs
=7BRD
-----END PGP SIGNATURE-----

--yamVG0/GApAj1FjI--
