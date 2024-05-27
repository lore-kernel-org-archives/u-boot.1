Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7D4C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 15:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECCBE8803E;
	Mon, 27 May 2024 17:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rIayP0Su";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F066888256; Mon, 27 May 2024 17:23:30 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D08F487CDB
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 17:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6ab9db33f0dso20305256d6.2
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716823408; x=1717428208; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ndg50RWM1bEtye9D6uEv4ntwYhULFc72VW+0iLv85Lk=;
 b=rIayP0Suv92kzO8WiAnTAd6n/t0vD/DTFpJorOFnc3zcHWZ5V5n576OVAoVA61QYIn
 VWcQIWMlObAFp8ogU3BsDwYeT9ud+55AizGN4nnTY64TOqsVYWEvctDyiGUZWR/HZHqv
 F87Oo3etGR55kHOg/eUA7d8HInSziqLIbPj8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716823408; x=1717428208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ndg50RWM1bEtye9D6uEv4ntwYhULFc72VW+0iLv85Lk=;
 b=kDwX+Bomid4857wubUEO9ftCMBiXdUZNgwnM0dxQGNbu/U0IR5VBWTWisVExkwXNvL
 LtHk9XlFzIOuNsY4glbgla22Tme2oXgTRJN0vqW0izKyD1yw49XnXCS6sTLiclEijPoV
 XPT5DfJXelyuxC1i28vV+kdBki/wNfx1FhCacCB3OYY2XP+nIgXyfwHxn3IQhd17BCGO
 dxYCBbr4/mybTkgWLwmPMxCvdwQ2Ocjb0x/qJ522lI7vJ1WTYuRtWXDG3mb5xj8gif2D
 fmezo6BsESPVvBUExupQ7uRe7RinZxfLkfGYvl6RrNP4eoBzng6GjKNMT3FQjOrUipZ8
 aToQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzexQOXY9WABsgo8jWq4VeHm2MolSZTH3pOm1T2AZNU5iZ2tKmbHlfn77hQMcML2xqFXKU8gjcXwd2sfIsDwcCKy/0RQ==
X-Gm-Message-State: AOJu0YzP760HWKz2k64vEN8Ff1TDJN1LpWaLXI77R+K2NeOInpArDeqk
 7k2sV1TzOUdR4AdRWj9LmQaOLhWNHpHvlKKKCw+YvLLxPHOL2f0MPQEP3u6CT20=
X-Google-Smtp-Source: AGHT+IHwwaxh2vA55c/fSHgtr6gOj8ja3FJe9BJiBVl9MlD0kXM91U8pHGQfp/LYXQ5yR7g2FA902A==
X-Received: by 2002:a05:6214:4604:b0:6a0:c339:1ede with SMTP id
 6a1803df08f44-6abcd0b54efmr120396856d6.40.1716823407684; 
 Mon, 27 May 2024 08:23:27 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ac17fc5079sm35177696d6.137.2024.05.27.08.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 08:23:27 -0700 (PDT)
Date: Mon, 27 May 2024 09:23:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jagan Teki <jagan@edgeble.ai>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tianling Shen <cnsztl@gmail.com>, Weizhao Ouyang <weizhao.ouyang@arm.com>
Subject: Re: [PATCH v2] board: rockchip: add ArmSoM Sige7 Rk3588 board
Message-ID: <20240527152322.GG2568172@bill-the-cat>
References: <20240522165801.1871915-1-liujianfeng1994@gmail.com>
 <7e603c4d-bf76-4b38-894c-30d2cf128217@cherry.de>
 <CAFA6WYNZh4BH6y_h_BkkVgHi3rNvsWd++mC2BDwqOF-NB8eHtQ@mail.gmail.com>
 <CACQ+3oZs6xt5d3aFCBB3vesMqj3ebOoAqxkg=26Z3JMX5dU-vg@mail.gmail.com>
 <54c87774-9caa-446f-bf8c-46f23b6a2422@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M6Lj5+ulF1A3rf3l"
Content-Disposition: inline
In-Reply-To: <54c87774-9caa-446f-bf8c-46f23b6a2422@cherry.de>
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


--M6Lj5+ulF1A3rf3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 11:15:09AM +0200, Quentin Schulz wrote:
> Hi Jianfeng,
>=20
> On 5/27/24 10:57 AM, Jianfeng Liu wrote:
> > Hi all,
> > > However... it seems we'll likely need to also cherry-pick patches for
> > > the GPU (should probably be straightforward as nothing would be using
> > > the GPU anyway in U-Boot) and the USBDP PHY... but this one we would
> > > need to update all -u-boot.dtsi for rk3588(s) boards that have it
> > > already to make it use the new label/DT, make sure that the driver st=
ill
> > > works... etc. Maybe not a small feat, but someone will have to do it =
at
> > > some point anyway :)
> > Kernel v6.10-rc1 is released and now u-boot is not synced to v6.9.
>=20
> It is, please use the "next" branch.
>=20
> > What about syncing with this procedure:
> > 1, Sync upstream dts to v6.9 with command update-dts-subtree.sh pull.
> > 2, Cherrypick all commits of rk3588s.dtsi from v6.10-rc1.
> > 3, Cherrypick all commits of rk3588*.dts* from v6.10-rc1, which will
> > include dts of new board armsom-sige7.
> > 4, Add armsom-sige7 to u-boot.
> >=20
>=20
> You should be able to do 2,3,4 yourself now I believe?

And I am very much interested in the feedback on how 2,3,4 go as this
will be the first real use of those steps.

--=20
Tom

--M6Lj5+ulF1A3rf3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZUpWcACgkQFHw5/5Y0
tyzOZAv+Jwi3JOzHW8My3AHiK90pROovdgDbcqRbig7keAVGDI7BA45e1WEEn/MN
fV2fWdLMc0x5ySXsA1tD5IMCkCEVz99XC/5V1u/+PVqPPE7i9HFfsl1GpssQHmk0
+K8HwTxxpjM0i9Pjgm4Jb/d37FzT6qwJMUXLkQlu2dJuaQL38fBZtfT51FnY5xqR
C65GkLgz0sUV0z6KUoVZvMHILcUikv6trX75lIPI/DTUe1JN2P8bY03SyjIljjZL
q1uWMWDOO5lRrjNHMUuuv3PlDmhGhWTJWosFQhud2Hl8CwpBt8WSZxoPGcdg82KJ
ht3QAiqjrt51h83RAl2wPKI0ttk8RJbF5F2CEL/CnwmBo1jAYk2+YmHbm/+a8pzq
xzOhSwcIzrFqXNV0jNe1iDcg0bpzVmYReIhnKTEmwSq7N7h9AOi7LrdfhLtAJFD/
cttguK33oqcxbcbnHB36T6J69yCmNireotIn9njN8PJnfoWfxV1mBVrSWH20IHL9
vMsD7wij
=xHFJ
-----END PGP SIGNATURE-----

--M6Lj5+ulF1A3rf3l--
