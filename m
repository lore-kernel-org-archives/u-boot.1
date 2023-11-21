Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E92C61D94
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 13:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C5A8745B;
	Tue, 21 Nov 2023 14:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="flOz6Cjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B5C87253; Tue, 21 Nov 2023 14:06:37 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D209875CB
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-677f832d844so17644106d6.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 05:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700571993; x=1701176793; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iqnlzpsmWvlUoUnsaC+Ei0uznI5tnHK3cu7G+LzRUNI=;
 b=flOz6Cjj6Yk/d7cOwJfTDdmM0XhubiibXI55R79WvscOXhKZyu8qVhkcX3Rk8LQEik
 6DiIAAKLiiyYZmZ0vXaM0DD7DrY+kf7SZCQZUx6TGFwjd6I13U4jN4TYGfrrc/pGWn5c
 aYX6PtTgQWJOCR/UoIN1qyhlqfCdO6gFEaQ3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700571993; x=1701176793;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqnlzpsmWvlUoUnsaC+Ei0uznI5tnHK3cu7G+LzRUNI=;
 b=NE9XIgmMAOPlc7jQRw08fKtcW7G5AvAFd6oNWU7zX4cWPpokluydUGemt3lF8OTEmO
 XQZUPwCtB2zjuVnvoZ2hDVIyLDzeixmG0Q8/aW9MxzQIn64lTkKbBehOu+EwQ8fd9KXY
 /KLSVLGYpu7ayT3f4gIVv8VMPyA0hJBk8hlSxTXdX9tWqrEnKzYIHPsz03AfSFF/TA/X
 kzxr14ZxDMBIDNt+kjZ1oYER8YUKztuvivKNI3zcjHFfQXEUqOj1XaFSKlPhTS3l/rjE
 o+Io/k6BpoE2tMucSGT3vddPvxo62HjpPRoR0m8wzM8KFuF8px2TErgduSt3YCtWi/cP
 tAJg==
X-Gm-Message-State: AOJu0Yx2pwWNVSw8BKuYF6CPmFtHXEveVcgVxBFtvGomGhT5+Y0mEWg6
 cp3yUB/Ved2e6i3+9aa/uYuh7g==
X-Google-Smtp-Source: AGHT+IHhNdeaV3NHyq7yEx9C5EKQXiiFdBXT8kTxQavOkDmM4NBVD9HW3MxLBeapP+rE8A6yxfSbsg==
X-Received: by 2002:ad4:5f0f:0:b0:675:66e5:7405 with SMTP id
 fo15-20020ad45f0f000000b0067566e57405mr13531171qvb.35.1700571993040; 
 Tue, 21 Nov 2023 05:06:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 f26-20020ad4559a000000b006710660a548sm3938151qvx.27.2023.11.21.05.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 05:06:32 -0800 (PST)
Date: Tue, 21 Nov 2023 08:06:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: Re: [PATCH v2 1/5] cyclic: Add a symbol for SPL
Message-ID: <20231121130630.GM2513409@bill-the-cat>
References: <20231121020932.733405-1-sjg@chromium.org>
 <20231121020932.733405-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kvpJpqmA5gIxDpmu"
Content-Disposition: inline
In-Reply-To: <20231121020932.733405-2-sjg@chromium.org>
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


--kvpJpqmA5gIxDpmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 07:09:25PM -0700, Simon Glass wrote:

> The cyclic subsystem is currently enabled either in all build phases
> or none. For tools this should not be enabled, but since lib/shc256.c
> and other files include watchdog.h in the host build, we must make
> sure that it is not enabled there.
>=20
> Add an SPL symbol so that there is more control of this.
>=20
> Add an include into cyclic.h so that tools can include this file.
>=20
> Also add the kconfig.h header so that CONFIG_IS_ENABLED() works. We
> could avoid this for now by moving the location of the watchdog.h
> inclusion to outside the USE_HOSTCC area. But at some point the #ifdefs
> from these files will likely be removed, so there is no benefit in
> going that way.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> --- a/include/cyclic.h
> +++ b/include/cyclic.h
> @@ -11,6 +11,7 @@
>  #ifndef __cyclic_h
>  #define __cyclic_h
> =20
> +#include <linux/kconfig.h>
>  #include <linux/list.h>
>  #include <asm/types.h>

As I said, we just need to fix lib/sha*.c so NAK. The only thing that
stopped me from posting that patch last night was that I went and
removed <common.h> from everything in lib/ as a follow-up and that's
taken a few more iterations.

--=20
Tom

--kvpJpqmA5gIxDpmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVcq1MACgkQFHw5/5Y0
tyy5fwv/YeVo0TWi8lCMyw/wU+MrTTsK4VD8QUuwaGUHAUgzzRxoK45968ItUA87
6rvM/LeR5Ltu5eqq/PK+b6huzF/brIWrJVC2J9ts7ny9Tuo4DHH9U02QFF1mkN6u
OV8+B9fZhRHlaFlSnk5/cu//SMX0sG4pRzOnnmax5QqoUG30BxkWg/W2aXIrHaIL
GerXaXoYWBQMDhB1dB68eRTsi/7Nj5yu5lToFE2nowwZZGlT+ikAZJTbF+hXRmdC
Fmjnmc5RtUFVR8QM9tsUIQ1LupUN6BtWGYgjcgOrTefnAUv8KJ02DJbRS4zEUPc7
l3FGQ3p0oJAVPHJdCxZVNaX+mkpHMmdvZlVIzfTF+l5gflaLnKTIIj76b9ivtaH/
sg1/mUMysp/UTkEqHbMqpTMcdj53FsGlRWmK00zl2HVzMMyiZH0o9pcAWu0srpo6
jy5DOpJ3wjov3LVcoNiC8cJcwEvT4DTse+UQ3b5Q3uf9Ad+G2RvfW2QDy1IaxJzW
T/c1kzXo
=uXEX
-----END PGP SIGNATURE-----

--kvpJpqmA5gIxDpmu--
