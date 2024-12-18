Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64058E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 17:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C56F180269;
	Wed, 18 Dec 2024 18:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UCd2ldxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E3A880274; Wed, 18 Dec 2024 18:38:45 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 044EA80241
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b98a2e3b3eso39005185a.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 09:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734543522; x=1735148322; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G1pgKVoASNHCXkkZNcIvdKrYjA0rJjVyMP5yFIYs7Jo=;
 b=UCd2ldxomdPgfp3uxlXiEnLddl13Q6TtTJ9PT0ROG1ETvYIwfGesFNDsDM64O+wO11
 yI2VWZyvn7LPowhjQ12kVxN1k9xWgodyFFjOOzoTvEM25p0vUH1oCYScQ4hNlDE/WGzQ
 mZ75EM9ec7dn66xuhPlOieYWh/0hPv4J8/Kx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734543522; x=1735148322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1pgKVoASNHCXkkZNcIvdKrYjA0rJjVyMP5yFIYs7Jo=;
 b=XNcSb98OwDXdjs8bsf12vdEX5DJbEsjcH0INJoFL9Xao+VxL25e1zF6iEac1dkGVau
 cpFtQG79X/B3KQmLyBZQKPKJNR+DBCZXN/RVJLD+i8WIE6faHmiQKX5/fJ9tRCZMlK7k
 ndrkb34GB0Ls0y7OjILWajjzaaiqwnJh9PIEpHev4inrFgnyZabE+f/uO0hMIeK8mg8q
 xPlnm77YxaBc75Jvb0mmviG3GuBGFy1usREnJMR5wIfvfeRZ8AFxOWfOiLR7SX2OJ5SE
 snc0nhZ3E7t30HpxKj29EerRVYLMBx0PKv8OLUldJhvz/vVE7LG7rYQTX0Jt7XT/L0D5
 T+Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZmzdrsgsMpVJldAPx4eSq2+1g0rdMFso60TeKEztEYCT5uZIbobMh/QKS/9Lo9LgTvqYSsCY=@lists.denx.de
X-Gm-Message-State: AOJu0YwRnqX2nH6FO7HEz2rLZ752BxHisoKnQEJOXUaHIUGEgEvNjmKR
 OVVRqqkvDVzfeh0y6q2aRuV6kiuFYc36JZNGAp13nrcWOKQFJCCD5J5S7Oy35xMkm6mqxNcnrqt
 r
X-Gm-Gg: ASbGncsJcUs3nMhgWtjfqgGs71/gAxeAwdkIpTrMkDj3npZIk7pYOAS2apGaDvJvxP2
 bqFH2Qf2IX7b4C3URnpIQlB7QCKau7m5oc461OPg0wGl4WkXBYFlHcQ6HUJTSuO44zTL248hrzy
 6vU0xaM6rdVWRD8Pj1bZF1YAEtH8XFku9h7ieiFFhqjOKQgL107rAmsJSDSZ/PnGLEfXHBiqIWC
 RXlw2dXXXlSyh9vWxGPrR5oq2YyxtSzva2U/Q9KMCiBzFTqbfbRTy9T
X-Google-Smtp-Source: AGHT+IHrnG7MiWbkLnTKnNVNFVxs2gOdwKrMnTD5GPdFq7TeIGUsIfSgfQuzHVfyoL6PX9EMTqhd8g==
X-Received: by 2002:a05:620a:2a10:b0:7b6:6c46:55b with SMTP id
 af79cd13be357-7b8636e6eb6mr521062785a.7.1734543521838; 
 Wed, 18 Dec 2024 09:38:41 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048c9bc6sm448306485a.97.2024.12.18.09.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:38:41 -0800 (PST)
Date: Wed, 18 Dec 2024 11:38:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] drivers: firmware: ti_sci: Add DM_FLAG_PRE_RELOC to driver
Message-ID: <20241218173837.GJ1505244@bill-the-cat>
References: <20241217-b4-upstream-dm-pre-reloc-v1-1-ccd29165bbb6@ti.com>
 <20241217145300.GN1505244@bill-the-cat>
 <20241218050837.5fppn7j7s5vv5f5m@uda0497581>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yGYofS/WW7MIzoOb"
Content-Disposition: inline
In-Reply-To: <20241218050837.5fppn7j7s5vv5f5m@uda0497581>
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


--yGYofS/WW7MIzoOb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 10:38:37AM +0530, Manorit Chawdhry wrote:
> Hi Tom,
>=20
> On 08:53-20241217, Tom Rini wrote:
> > On Tue, Dec 17, 2024 at 02:24:37PM +0530, Manorit Chawdhry wrote:
> >=20
> > > Currently the driver relies on bootph flag to probe it during PRE_REL=
OC
> > > stage but with the upcoming cleanup of v6.13, we don't have the bootph
> > > property in the parent nodes anymore and ti_sci driver being one of t=
he
> > > parent nodes required during SPL stage would end up hampering the pro=
be
> > > model [0].
> > >=20
> > > Add DM_FLAG_PRE_RELOC to ti_sci driver for mitigating this issue.
> >=20
> >=20
> > Can you please expand on why with v6.13 we don't have the flag anymore?
> > Thanks.
>=20
> So the idea was that following series [0] would help us cleanup all the
> parent node bootph-* tags as putting a bootph-* in child node implies
> that it applies to parent nodes as well, though even if the parent node
> gets packed after the following series, the parent node still don't get
> probed as from my understanding, we need bootph-* tag to probe the
> driver as well but the phase tag doesn't get propagated as such.
>=20
> So while working in Linux, some comments related to this was raised [1]
> and after confirming the behaviour with Simon [2], the cleanup was done
> in Linux and meanwhile this way was found to probe the driver so that
> even after cleaning up the parent bootph-* tags we can continue.
>=20
> I don't think it's a hack also as this driver is required pre-relocation
> and this is another way to probe it pre-relocation but the only thing is
> that since the cleanup is done right now, we would kind of need it to be
> booting in some platforms ( that were fully reliant on Linux DT and
> don't have -u-boot override for this particular node with bootph-* )
> before 6.13 DT gets synced up.
>=20
> [0]: https://lore.kernel.org/u-boot/20231217163627.2339802-1-sjg@chromium=
=2Eorg/
> [1]: https://lore.kernel.org/all/20240709084857.nf7c57mi6miajeau@uda04975=
81/#t
> [2]: https://lore.kernel.org/u-boot/CAFLszTjr7bJFPnyVx7rTdFB3AFBM_2DVAZU8=
FZnLBE7ep5ejXw@mail.gmail.com/

Thanks. Did you end up filing an issue about this? And can you now
perhaps push to make doing the fdtgrep work a priority? There's going to
be a lot of other cases like this to resolve I suspect.

--=20
Tom

--yGYofS/WW7MIzoOb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdjCJ0ACgkQFHw5/5Y0
tyxXMAv+I4WvsQyfZtxOulbHUv0UgPY/5MtlTTUCI0G7pvBYh3J0QNz/vH0QUcdC
vR7U1Eb2TBU9syD1yETbt8BKQRqRggXEUdb9Q3sWGAQnMUzYiaaI8it9sJPqeJSv
mIg8Bz6RfUsjOhLtCxaqx2SekoE/bTbiosOTLgzNcNchALLfmfhQG3FWhu9MGHwe
hsdJHgT9zowcFJSttwtjcEZRpjpdlDrMRdSVTAcuTiR+RopGBxjMZ9TpaKQ/XDV3
guHCi0Ig8S39If6n/XIOQL89dLX48UeSepEWWRxY596zgx3PIWisqn3fFbi8YWRU
ejeVQTF7SGoq4esbpA3ofb42535B3IYuDGKa79ORNIcIz5p+ZlPK0PxJ/TNYTeph
BHjl0UtVL+YS0SnvjwX0TyKbOlCQSPKMDWXxPjMRNqDCfiDyAcJeF8qpSar+wfpq
YjCFG/dnYUx0zQ7XXnIpuKOJxL0f1nK049o8SrKuQpLKoyVip/RXCIMMEDjpOqPx
D4pq8OC/
=dZDU
-----END PGP SIGNATURE-----

--yGYofS/WW7MIzoOb--
