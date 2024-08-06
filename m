Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCCCC52D70
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 15:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3149D88ABF;
	Tue,  6 Aug 2024 17:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NOB6Dw6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B3C88AB4; Tue,  6 Aug 2024 17:36:03 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7251488A1E
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 17:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-70938328a0aso395728a34.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 08:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722958552; x=1723563352; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/HbpJKBNEGymHE8zzHclTr31Hfm3oN/es2vYJuRl5jg=;
 b=NOB6Dw6G2PR6HV/ASjiHVwXBBs3iVeEHMo+HqpOWmtheswCPvoXLrZ+WqG6l89WlQr
 9uulBnoJeswEo1aPy8wcImrUeJJOA6xzr4dwbFQARjHoAypYN4Z/fr8GbqAQOCTGLH8E
 6KbDPvW4sgfF4np07gnwWO13661os20Q49vao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722958552; x=1723563352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HbpJKBNEGymHE8zzHclTr31Hfm3oN/es2vYJuRl5jg=;
 b=i5u6fBOyBz2ioJQqYrxSCljHiH6/1Nm7l1F629LRd32L7fj5VlTZ1toEgZNmvKGs44
 hChwYkq2VIoDYFC0bpL01loEeeRAwjoZPq2ikN7XrRtvAT/ilyAMcdlCCu3dg+ZGYX8B
 c3VLXXZy1/lZm6F/7WDTgv8VLGB125IIBaBS69qZRWKZbj2lIRwphgPi96OnFeOrpKHA
 m0+A+a9glrP1wavZ7vQT5ISc141omn7sfIXvFpK/+ATuHCqociP5EBlD++8lBx3KsA/Y
 huZWyAZU0JEJ5LHKbuY2767LTagdTwzBMrtAEt7Sio5xDILf+m6jatGPK3t20a4UGihb
 saRQ==
X-Gm-Message-State: AOJu0YwtcwlGjq8VTUMgWr6h/Vjt5Lg4lGZc5Nzdq4STKIue4twnv65g
 ckIJ1Z8EwF9TulILz0MYrmAA+bKhdzzGS5IQsQ9YAlAT+KH5fOQuWltbbjyBHZY=
X-Google-Smtp-Source: AGHT+IEShfWMQXLGHsGA59Ce6/X4nZ9X9j7kL0ujspzjNOQehvHdJkMLNnAWb+Fd6NyTAELpJnTrvQ==
X-Received: by 2002:a05:6830:3707:b0:708:b344:fed8 with SMTP id
 46e09a7af769-709b99791aemr16097088a34.33.1722958552446; 
 Tue, 06 Aug 2024 08:35:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31ec3713sm4017615a34.44.2024.08.06.08.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 08:35:51 -0700 (PDT)
Date: Tue, 6 Aug 2024 09:35:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2024.07-rc3
Message-ID: <20240806153548.GA1626301@bill-the-cat>
References: <a28e06df-b7c5-47d2-95de-aad4558d8f23@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xFJhhSZbB7fYBF4J"
Content-Disposition: inline
In-Reply-To: <a28e06df-b7c5-47d2-95de-aad4558d8f23@monstr.eu>
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


--xFJhhSZbB7fYBF4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 08:02:37AM +0200, Michal Simek wrote:

> Hi Tom,
>=20
> please pull these patches to your tree. I created tag yesterday and push =
it
> to gitlab to see issues and rc2 has been created that's why apologize that
> my tag is using rc2. There are new mini defconfigs but they can't break
> anything.
>=20
> I am aware about one issue which is in the tree for a while. Please take =
a look at
> https://lore.kernel.org/all/CAHTX3d+qAMKgL9T5Fo6y=3DrvXDiMS_mCiCEGazHt07e=
iVN32Fgw@mail.gmail.com/#t
> but I didn't get any reaction from Simon about it yet.

If Simon doesn't have any further feedback, fix it how you see fit.

>=20
> Thanks,
> Michal
>=20
> The following changes since commit 6becf9ba1ab82af6f4fcf9f4d0da38f9c75212=
d2:
>=20
>   Merge tag 'u-boot-imx-master-20240802' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-08-02 14:40:59
> -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2024.10-rc2
>=20
> for you to fetch changes up to 81b28310628fdfde5e4cbee7a947dad0fc717eb8:
>=20
>   soc: zynqmp: Add support for zu1eg_lr device (2024-08-05 16:14:10 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--xFJhhSZbB7fYBF4J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmayQs0ACgkQFHw5/5Y0
tyzpFAwAs8ObmZUzeHmuJ2kkf54mxRZ5sZmh0AHj0+oSVOml4kwANbo0qMeICskT
9ABgdxTxmRKtHQGgaZpMuz53XYxPmcDRgKBMW/VDl0ypX1QJ1X83GISZFAyprqOC
/8YapTMXsyeziwDXOTCL7PlzyrEbhgq0TexgqvYc2CsWUmp0hY+i+BrqR/F+BCAy
zDCEyLRGjp6odLmdLrZ/jo0S0cknkkbr5kqcXFJbKhX40e8RUganOPN4Kdx3dwBI
uh+d/6w6yistaVLK4g2Gfx7Fwjt2UitwtC6HaKrppDPla3zBeLzm0NAy7McAQGuU
H/whYugdpiNc96mXdNW6cRURRSvxcKVDlaqHHlVSDcSRP2WU7sUHL3ewLDkgftvP
ZlUKIhEyUg+LWvUComcb9S+Nvab1LwTpGH0h2F2Vk5BsiybcH9zpIR9jAYOAm7D2
6j2csvF2J73Nme7OTSGz1p9MEFOCcCkN3rz9ukIGwFdmmWrRM7rjo+O4FmLeZ8+k
iQoJ9GTm
=4XVQ
-----END PGP SIGNATURE-----

--xFJhhSZbB7fYBF4J--
