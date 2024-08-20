Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5963DC531DC
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 15:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4BE888D87;
	Tue, 20 Aug 2024 17:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zo4wTQn0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC72888FD; Tue, 20 Aug 2024 17:11:20 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F6FB88D87
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 17:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5d8060662a1so3491015eaf.2
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724166676; x=1724771476; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bVYF0VNQh5f8wrO6v6E7OsnMxR/TFoxOBb5r+jI41Ko=;
 b=Zo4wTQn0sypVlAmVclyIDX7sIXaQ8sADIGuR4bBtAVVcb8YVS0I+79K5kFtyMYzsO8
 yTa0U+qmy8it+3M1p2CRyDhyzHVe64EpHRPlHZmhHExEhCcvuw0SB9Q4UT9nP+sfAl0f
 kTBbCvbKXst0MEIxVoncVoDXdgUdplV4q9QOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724166676; x=1724771476;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVYF0VNQh5f8wrO6v6E7OsnMxR/TFoxOBb5r+jI41Ko=;
 b=PWp0guvyDomvJlEMddFkYvcxOKSxc9LxmaMuDwEQFjVoxNJppF45Y9djwhsiyVYST/
 W4cP0WxPGjpf6D6CKRUBjd8nSOlNLTbOyJhAjsWeDUV92yvLtH03SewyhRQ4bCrs8o1y
 YHceTKmb2X2DBl00XrcLrOjA0UwWGBCFuDY8iHjZkgamg4Z4CkTYbJe8z/NZgD4qiGrT
 UzPuTfsl83oF53CJ3d9tN5QiMfTSe/ZndafkOtx5jPipYqxyAruuTsEUO/nL6ppATwPj
 oz6fgpY7htqWN3P65YPA9JguDWDhaHbR6KpuDhWT6IhqG37r7KsQvmCqHBNvHfhxJtWU
 TZRw==
X-Gm-Message-State: AOJu0YzLCJpJLo3Ya0ibWl5pm7Aha2ubORxAUv7I/aoMFdaErQZouzTY
 LlB7pmrWGPTZ4A1QX7eetFl7MzMxAKPtfER+P8oGiRnuIRgD+OhLgDBtdL0E8/Q=
X-Google-Smtp-Source: AGHT+IEdYED3vRNDatOKEjodN5tCOG+PDRLSJz5N//Uv0VUVgRFi41i7lf3Sz6x/L8NLwJ9N59WSYA==
X-Received: by 2002:a05:6820:614:b0:5da:a2fd:5af5 with SMTP id
 006d021491bc7-5dc91b15b2dmr2976455eaf.1.1724166675774; 
 Tue, 20 Aug 2024 08:11:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5dc93a5be82sm424522eaf.4.2024.08.20.08.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 08:11:15 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:11:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Walle <mwalle@kernel.org>, Zixun LI <admin@hifiphile.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240820
Message-ID: <20240820151112.GM1626301@bill-the-cat>
References: <87zfp7vf43.fsf@baylibre.com>
 <87o75nut6k.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7hpcZC+nx/CYwJDG"
Content-Disposition: inline
In-Reply-To: <87o75nut6k.fsf@baylibre.com>
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


--7hpcZC+nx/CYwJDG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 05:09:55PM +0200, Mattijs Korpershoek wrote:
> Hi Tom,
>=20
> On mar., ao=FBt 20, 2024 at 09:16, Mattijs Korpershoek <mkorpershoek@bayl=
ibre.com> wrote:
>=20
> > Hi Tom,
> >
> > Please find some fixes for master:
> >
> > - Fix crash in BCB on invalid block device (reported by coverity)
> > - Fix booting Android kernel without a ramdisk using fastboot
> > - Delay ethernet gadget driver init to ensure interrupts are available
> > - Fix ux500 gadget driver ops based on CONFIG_USB_MUSB_HOST
> >
> > CI job:
> > - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22057
>=20
> Please hold on before merging this. There seems to be some ongoing
> discussion about
> https://patchwork.ozlabs.org/project/uboot/patch/20240726083102.380719-1-=
admin@hifiphile.com/
> on irc [1]
>=20
> I'd like to sort things out before this gets applied to master.
>=20
> Sorry for the inconvenience.
>=20
> [1] https://libera.irclog.whitequark.org/u-boot/2024-08-20

OK, thanks for following up in email.

--=20
Tom

--7hpcZC+nx/CYwJDG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbEsgYACgkQFHw5/5Y0
tyzrzwv+NJ6iMvMKXcYsOtjVKs+LKLbwhRkBxeARYbEvTEL6rL/BLiLhT3gnrKue
ZeHq86rRjTijIlxgil/L/CzzElHja1G1aKbC+x5XpNfpoVi/1TczANENx+9m4z4X
+LnRcWW6YeySZI1qBlKVORku67L19fHJmuDnSpkbQ4FF+QN/OkacTIWaITiG6/Hu
zBg+mu1m5TJ7oBJ+3JC1yjWPOwtjs0IuCXRBCmURDKMzEj93NbvQFYKYXgnNjAXJ
TVKyhmixTrqbjXqyx0KChBl8fG322H+n61Ek0WGToYOdC0NjRv7I273lEFWQIRSS
Jod6gf4aM650wW09VoqwnWM2a6qZRtrhtC0eVP4JawLogicnMFlRK+TYps2BjHSK
XzNcbxXr99ZeEN4vqsIfJfNIw16G0N/e0tZQQsaxzLLCEE7vSZ5CT//+Qzf7c6YH
kxbzI5RS9thqIpj3PMN+4YsAy3bt8/wJNUKQwi7XvMuuxnZTU7CjkMIMma7TEWwP
8xWk28G+
=IEYy
-----END PGP SIGNATURE-----

--7hpcZC+nx/CYwJDG--
