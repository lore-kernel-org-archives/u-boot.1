Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A18BC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 16:26:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6FA8855B;
	Thu, 18 Jul 2024 18:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X0ZuDke3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3698886DB; Thu, 18 Jul 2024 16:15:52 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52741882BE
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 16:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-708b273b437so458391a34.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721312149; x=1721916949; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+MqYa+tobyLNPTTT0Yxs/eRWzSS/Sb/jhVyMGcP6Z7E=;
 b=X0ZuDke3bYbS9qy6Rj/lNEkszm6lCnOmC33JZ93E8jrOv7qeAs9CulG3ch9nGnRAMX
 eODVmqjR6IQ1oPiWISD2XOBXzDVaGqI4Gnyv4hVUCSKxju+P/wx32x9nEm2wiH33FNTP
 FiAHYaXmFVBla9xsfRT8MpqcwzbzB1I/1bmrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721312149; x=1721916949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MqYa+tobyLNPTTT0Yxs/eRWzSS/Sb/jhVyMGcP6Z7E=;
 b=DGjXCss/1H0vSO2/ZD0IQvhjirG1WXmF0lFS+0PWgyh9a1TE/HJvcx4pPZOejgtyhd
 aeCJ6beqL0ExU94wKRmU2X3EKC492f2j6iQo0y2SWpxWiA59aM/RF8Ou8505Pg+2DIWY
 lGMHG0oQYfKT8qOUr5/9WrcWAoWzpjI9bvbCDMuKkQBXyVtBSgUH5ih8O9CJbZ0UKM6V
 uKF9Abg4KnTMAhgJ1a5GMhaqprD+2d3YARijhSKv2xspL14dPD5Kn+fQO41WWVNUzrI7
 TgRRLatqI4reFbe2Wcpg+WJ52vl7qRAa5fqvmYmKOMb/5pef5dPehHPp7oRtG74o+Juk
 +gOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc/HKPUCMHu/M2tadcN2rqVhsqy1XzTjZ10NkTPpzQE+g4uSllQdtoqq51S+4G9pkCD+Xl4h3hvMKsXPTj1zIySrs25g==
X-Gm-Message-State: AOJu0YxdX2IU0mO649hkOX/Js0QJ49Xv3ynY54qngqaN94HxPvIENWpV
 AX0prZzaPH5wnwBLa8u5b4905ilnkOjjUmhFqBq/n8BDKXoUOugdNDZTpfqV4ds=
X-Google-Smtp-Source: AGHT+IFPcsJfg2w62Q0R9fMUJhJfbpQm4Nf0ytWKUlDJtTBg7/fdu3Rq2mI59HDAnLadA/G318qOVw==
X-Received: by 2002:a05:6830:1418:b0:703:68c2:3cb6 with SMTP id
 46e09a7af769-708e37ec4c9mr4802661a34.32.1721312148985; 
 Thu, 18 Jul 2024 07:15:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708e78feac1sm452027a34.70.2024.07.18.07.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 07:15:48 -0700 (PDT)
Date: Thu, 18 Jul 2024 08:15:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 u-boot@lists.denx.de, michal.simek@amd.com, seanga2@gmail.com,
 sheng.tan@9elements.com, akashi.tkhro@gmail.com,
 abdellatif.elkhlifi@arm.com, agendin@matrox.com,
 linux.amoon@gmail.com, andre.przywara@arm.com, afd@ti.com,
 artur@conclusive.pl, bmeng.cn@gmail.com, bb@ti.com,
 caleb.connolly@linaro.org, chanho61.park@samsung.com,
 devarsht@ti.com, eajames@linux.ibm.com,
 etienne.carriere@foss.st.com, francis.laniel@amarulasolutions.com,
 ilias.apalodimas@linaro.org, vanbaren@cideas.com,
 mr.bossman075@gmail.com, jonas@kwiboo.se, jpewhacker@gmail.com,
 kever.yang@rock-chips.com, leon@georgemail.eu,
 lukas.funke@weidmueller.com, abbaraju.manojsai@amarulasolutions.com,
 marek.vasut+renesas@mailbox.org, marex@denx.de,
 mkorpershoek@baylibre.com, n-jain1@ti.com, nm@ti.com,
 oleksandr.suvorov@foundries.io, pbrobinson@gmail.com,
 rasmus.villemoes@prevas.dk, raymond.mao@linaro.org,
 semen.protsenko@linaro.org, samuel@sholland.org,
 yangshiji66@outlook.com, sughosh.ganu@linaro.org,
 sumit.garg@linaro.org, sunil@amarulasolutions.com,
 tom@tom-fitzhenry.me.uk, troykiskyboundary@gmail.com
Subject: Re: [PATCH v2 00/21] Universal Payload initial series
Message-ID: <20240718141544.GW561963@bill-the-cat>
References: <20240713070055.2172883-1-sjg@chromium.org>
 <87a5iliubh.fsf@bloch.sibelius.xs4all.nl>
 <09FB197A-06C8-4162-AAB6-3823BA2840B3@gmx.de>
 <20240716190852.GL561963@bill-the-cat>
 <89fa43bd-dbf3-4bc7-b4ba-29c3cc579a9a@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+wmI4nBH2jlF9Zs3"
Content-Disposition: inline
In-Reply-To: <89fa43bd-dbf3-4bc7-b4ba-29c3cc579a9a@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 18 Jul 2024 18:25:59 +0200
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


--+wmI4nBH2jlF9Zs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 10:23:21AM +0200, Heinrich Schuchardt wrote:
> On 16.07.24 21:08, Tom Rini wrote:
> > On Sat, Jul 13, 2024 at 09:40:17PM +0200, Heinrich Schuchardt wrote:
> > >=20
> > >=20
> > > Am 13. Juli 2024 10:12:50 MESZ schrieb Mark Kettenis <mark.kettenis@x=
s4all.nl>:
> > > > > From: Simon Glass <sjg@chromium.org>
> > > > > Date: Sat, 13 Jul 2024 08:00:34 +0100
> > > > >=20
> > > > > Universal Payload (UPL) is an Industry Standard for firmware
> > > > > components[1].
> > > >=20
> > > > I think you have some trouble understanding the concept of industry
> > > > standard ;).  I guess you want this to become an industry standard.
> > > > Firmly https://xkcd.com/927/ territory if you ask me.
> > > >=20
> > > > > UPL is designed to improve interoperability within the
> > > > > firmware industry, allowing mixing and matching of projects with =
less
> > > > > friction and fewer project-specific implementations. UPL is
> > > > > cross-platform, supporting ARM, x86 and RISC-V initially.
> > > > >=20
> > > > > This series provides some initial support for this, targeting 0.9=
=2E1 and
> > > > > sandbox only.
> > > > >=20
> > > > > Features still to come include:
> > > > > - Support for architectures
> > > > > - FIT validation
> > > > > - Handoff validation
> > > > > - Interoperability tests
> > > > >=20
> > > > > This series is available at dm/uplb-working and requires the alist
> > > > > series at dm/alist-working[2]
> > >=20
> > > Why is this series needed?
> >=20
> > Because UPL is a standard, supported by other projects, which requires
> > more than Just Nothing Else on top of what we do today. Please do
> > provide constructive feedback on the changes themselves, but bringing in
> > UPL support proper is something we should (and will) do. Thanks!
> >=20
>=20
> SPL loading a FIT image (e.g. EDK II + OpenSBI) seems to be very close
> to UPL. What is missing?
>=20
> UPL is meant as the interface between two firmware pieces and not
> between firmware and the OS. Why should we let main U-Boot support UPL?
> Isn't SPL support sufficient?
>=20
> Which other projects implement the UPL standard?

coreboot for one, as talked about in the announcement Simon forwarded to
the U-Boot list just before this series.

--=20
Tom

--+wmI4nBH2jlF9Zs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaZI4kACgkQFHw5/5Y0
tyzqdQv/d+cnoT5GfYbOJGQR8S/C64kH+ZA3u9IH1BijDsUpry3QY3aslqwhbOFz
wz2YDO79G8eZBoHnIgyOP3TTGdk2IoXA5KhNGj/22ukSTYfZ2HtJbjG4WHgg1me+
lGiAe/E0uzPEt1HTjqX1D8wGCLBiTdvwpS8UBjEA8f/ORZgMdnpzwUunukYtUzIV
IeiI3cL/h9FsGUCe/OM+73kMPc0+jo/kgyW92nqGPky71WxqHN9qw/a+unRK9tol
kM9aleQYf2Sod1mUGHf5/LFnQZu+f2DjkI1bzRG27apgbPQDwF3FEw2EuDE87l48
zGUHDWKjvGlq+csf5yvj360yea2+bTRRFFJxTI1L3U0kujFWGO3v46qcj0C7en4J
FOc/CdIEXKBJWpZDwdLcEvtqpjUTiAQz/M97GpTm8uEn9BUYMTUzo2Ov0XHRKV3B
i3NvqoLhaogPH301KUc6TXzxAs5ZP4l/LkJWsofQGrx8vhv1CiRUSYCUHGEGEAJw
wEdBSA37
=YicF
-----END PGP SIGNATURE-----

--+wmI4nBH2jlF9Zs3--
