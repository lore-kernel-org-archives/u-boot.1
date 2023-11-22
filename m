Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A381C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 13:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7398D875C7;
	Wed, 22 Nov 2023 14:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nxOthfKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E901875C7; Wed, 22 Nov 2023 14:54:43 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B138E86FB5
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5ca11922cedso38089217b3.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700661279; x=1701266079; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4lL/n2ssIIiuC7BSpAoO/ozSFVbAkVGtFKC35KmzyCU=;
 b=nxOthfKXcOoiA9KjCwqWXSlHYN5QBT7EXoNEGD4rNKFZj+O72RTEoxNCyZemSe6Y4H
 xC4CWxsRhUisO5QJ7sw556XDpPHG++rmUknldpFq27+yV2V7alYqP3Os/eBVYKhhQI8u
 efPLPlDtpDSF6uht68vbVuM7veEV1PxPhNKZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700661279; x=1701266079;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4lL/n2ssIIiuC7BSpAoO/ozSFVbAkVGtFKC35KmzyCU=;
 b=eo4bU1FCYAfrBIC+mz1spVswUT5geurCNqcQwpZDDhWG73/x3IkjLoUXymgMUBn+TC
 UYTWP3gMfZfK+6BU9yw+FwS6mlGXRHB0HzDFgUiBelLgAWHQiHsnnytLy+TWcHdvlI7A
 X8V1PqrkpSIuyq+eiEBpc8nmSv6g/Xjmp0h38vIa9GI9mFmO04Rw7xkLVQnWfykXT9vD
 Dwir5tyPeK/WZklkHOZ1ftGpeWCsvQzk5J6bc9Pb0uGDhtJWBrJyiAl+/v+JtnSVQVbj
 4yuqGVApQ/bVQOwZtNWUOnksaqKKGPNxaBpXa/2E99EJ5X9A7zMwor2IM6mcxgxWV3ud
 mcOw==
X-Gm-Message-State: AOJu0YzrG0eV+qgkpWm5GU2+nSzmUXhShe6CDaDXhB2GopV1tbVMQ+y2
 dD8H0nByvWyGK7+Jdh69Ip6kNg==
X-Google-Smtp-Source: AGHT+IF8f/6sS+ckzjN0nEsXETewlfhxTL50RUstawvfTnaYrzXScMlsiXoL566L7K5wwCuyKfpX8w==
X-Received: by 2002:a0d:fc86:0:b0:5af:66e7:e382 with SMTP id
 m128-20020a0dfc86000000b005af66e7e382mr2500077ywf.34.1700661279371; 
 Wed, 22 Nov 2023 05:54:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 x83-20020a814a56000000b005bf57ef572dsm3659614ywa.140.2023.11.22.05.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 05:54:38 -0800 (PST)
Date: Wed, 22 Nov 2023 08:54:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Dmitry Malkin <dmitry@bedrocksystems.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com
Subject: Re: [PATCH v2 1/3] rpi5: initial support
Message-ID: <20231122135437.GS2513409@bill-the-cat>
References: <CAKRNjQ3nt3huy9Pt9eesxrKcirBR8aQH5Y8SKsGSbaXmny=_vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VjNiBuuiyvBXMyPg"
Content-Disposition: inline
In-Reply-To: <CAKRNjQ3nt3huy9Pt9eesxrKcirBR8aQH5Y8SKsGSbaXmny=_vA@mail.gmail.com>
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


--VjNiBuuiyvBXMyPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:54:24PM +0100, Dmitry Malkin wrote:

> rpi5: add initial memory map for bcm2712
>=20
> includes:
> * 1GB of RAM (from 4GB or 8GB total)
> * VPU memory interface
> * SOC range (main peripherals)
>=20
> Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>

I'm curious if the memory map portion of:
https://patchwork.ozlabs.org/project/uboot/patch/20231121-b4-qcom-common-ta=
rget-v1-13-9492198e0c15@linaro.org/
could be used as inspiration here too?

--=20
Tom

--VjNiBuuiyvBXMyPg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeCB0ACgkQFHw5/5Y0
tyza1AwAq+KkQGCCz0Io72JQmhGwYqsF9igNPyb65W4KQ95sExarwtfMo8vp/UJt
SfG3Hxpvq+b1uX8zbscKrJ7xW7rqUdD2V7TeD7RNm8Q61DIqa/sFK5JGN5HV7fUL
LRqFTaRq7p32dAP3zRRDYOulUwZ8fSFjB6GW7Spb+LA7D0e2xNaA+cRCeqX33ZlW
aOz5qIC3LyDrpXsogpyT3bLBD4bzaOuzizwFtPYZV18uwvd+XZy9yQdebo5KHu3D
pHbHBcMQ0jr2mpoT+7unOYiohJdpnQF9AU5lKBCkUJwOPgbC8L+48vckYlG0yCdp
s7mVih5u2DfLP4PIziIs7SrrMd1LLvIVKhD6revvzwUYHySTTOEF+H1SxluIrMlu
hCLcxbeMQM1TpTZ3UMbnbG2XVnEU33A9wJDQUy+EEzMBNUxr5i1prU+MOY769ovj
z/TRIYxOtdKLXHn1rsOdNhEHCjwS2oVKLyE6K9unI1SYMuUDh1pw+tIXgZcYIow7
PH52ID27
=lQrC
-----END PGP SIGNATURE-----

--VjNiBuuiyvBXMyPg--
