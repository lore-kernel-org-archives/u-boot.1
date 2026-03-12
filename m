Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43606106ACF3
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 22:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 920F684166;
	Thu, 12 Mar 2026 23:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CSMNz+oB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE1C984167; Thu, 12 Mar 2026 23:58:26 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0CC84150
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 23:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-467161c4a1cso636760b6e.3
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773356303; x=1773961103; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x7YFaxpbkkF35mI/XvGl8bslHqzmAXDtwcQWoGBKbVM=;
 b=CSMNz+oBF4qPaL8vvAqxkV/7oIu1NAQH+4/ZN9P6hww8AUBu6zr7s85JaFdU/Edngt
 hYIDGS5KkAODQ9FYt7fymMOWUvRmJg3BMx393H51Eh7iHHloL63Ap3nKht/PUG/MrqVh
 NVSo018TcWd/FMhsIIm17kbbT0WLcalWYLeAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773356303; x=1773961103;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7YFaxpbkkF35mI/XvGl8bslHqzmAXDtwcQWoGBKbVM=;
 b=PTEEmqlAnkcj/8Hdip2ExV2/uictF1nsX223gDr+5H/C1q0v0K5skzxPnsT+V19ClX
 GEJj5v1XWWZSdkdiLXJqkR8EIyGdEYEvTBmx21/SDVQQeYDjocf2oP64dsYrC4gYw1eF
 4KuSOEAOwWAOczu8BUNL7dY8er5ZhkZwBoQEekPBo9cbXN9fjEwM07xQe3qCD3rU7JHS
 /iuE/Hm/jF/p62ub54zU/pDnFkZbJF0dmZd3dSweepnsc53byl3Yh4FZ6lZBoPSdpMJF
 n9Sv0huJj4cY+N2RLWWjS1tyYnsoxyKk/t5t78PZ8XqD2+bHtdasBmIKDENIDzERhl4g
 SiGg==
X-Gm-Message-State: AOJu0YxaGMo9mrtIGK/Nus8AKoisEWn6juy/6w44pikEPmINvtyxetQ5
 VPmYqlzqr7zulsCloblyB78Iqw96ZRLhuvsRY8qmhqZisvRCG6WwFhNiPjCSha9fwkU=
X-Gm-Gg: ATEYQzwkz8qXShMgl+OvAQw9oYw5aRom3ZO+CcO686LTH3bi1O9yQBqOCoY1zHaWiEr
 eeOHyL9NW1+s7TiaYHN3dHUHgX8X4OS7aWEu26q1SG/hIbgxwo4kFPHMEZpBiAcJeVqbmzWEoMx
 DNBdYDVV6dMHYq9JwH5wbh603YOr5BaNI60kUisON/TK4MjCEh7unxzfXd2dLW4S2+qdBnY6ZEL
 8tKVnYvZ5gnh6IQDFLgo9/Fdj9hqOuSrcHAArjxrMzfxmcUYO13ZkZvcvRq/HY+edFVY1q3rFju
 zG1Bw2dLcIkroI6S5EgoJL+FOUdjwnG8jM+xq8G/AH5LsFw3Oqi0esTR9gKPCZ4/HiftPHrq+w6
 VsF7XfJFgPdQrPnnlULxbTcfpVQnkkzeTEbmd3Asy/YWVuFrI/G3wcQww7brxD0f+aSyGUP2yUX
 VIwUA+VbD8EB8u/FUFUHc/kEesyQRdWwtZ5vwdA2Kd0U/hSKoZqe0iwPqaAAnyiTISlNfBoVy2N
 g+iYXdIs2nJ/goLb5syZw71FIBbU6YJxd4a8LGFSvUNWu26
X-Received: by 2002:a05:6871:ca:b0:417:6237:cf82 with SMTP id
 586e51a60fabf-417b923e031mr679485fac.23.1773356303290; 
 Thu, 12 Mar 2026 15:58:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e268f37sm5880159fac.6.2026.03.12.15.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:58:22 -0700 (PDT)
Date: Thu, 12 Mar 2026 16:58:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] dfu: Make the DFU_WRITE_ALT symbol available outside of
 DFU
Message-ID: <20260312225819.GC502704@bill-the-cat>
References: <20260310162621.1163932-1-trini@konsulko.com>
 <875x71mn0x.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nh1oMIdfVX0aMQGb"
Content-Disposition: inline
In-Reply-To: <875x71mn0x.fsf@kernel.org>
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


--Nh1oMIdfVX0aMQGb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 10:10:06AM +0100, Mattijs Korpershoek wrote:
> Hi Tom,
>=20
> Thank you for the patch.
>=20
> On Tue, Mar 10, 2026 at 10:26, Tom Rini <trini@konsulko.com> wrote:
>=20
> > The DFU_WRITE_ALT symbol is used both directly and indirectly (via
> > UPDATE_COMMON) for EFI capsule updates (FIT or raw), but does not depend
> > on DFU itself. Move this symbol outside of "if DFU" to remove a Kconfig
> > dependency problem.
>=20
> Looking at drivers/dfu/dfu_alt.c both dfu_write_by_name() and
> dfu_write_by_alt() seem to rely on functions from drivers/dfu/dfu.c such
> as dfu_init_env_entities(), dfu_get_entity() and more.
>=20
> Looking at UPDATE_COMMON, I see:
> config UPDATE_COMMON
> 	bool
> 	select DFU_WRITE_ALT
> 	imply CMD_TFTPBOOT
>=20
> And if we check the code in common/update.c, we can see that
> dfu_write_by_name() is called.
>=20
> So fit_update() calls
>    dfu_write_by_name() which calls
>        dfu_init_env_entities() which might no longer be defined when
>                                applying this patch.
>=20
> I'm not sure how is this supposed to work. Do we have to stub
> dfu_init_env_entities() ?

So, to me the challenge is that DFU_TFTP, UPDATE_FIT and UPDATE_TFTP all
are the three users of UPDATE_COMMON and so DFU_WRITE_ALT. The first two
depend on DFU, but the latter does not. And there's nothing in-tree
using it, either (but it does compile I believe, or allyesconfig would
have failed).

--=20
Tom

--Nh1oMIdfVX0aMQGb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabNFCAAKCRAr4qD1Cr/k
CqhoAQCmG0k68PCDXqtbFmxbkhk8pp/aAXAaneFJ96myB4azPwD/U7+GsFasmV2p
yKSCjJ5/ez83nRuFMBLcbiphqerZmgQ=
=87n0
-----END PGP SIGNATURE-----

--Nh1oMIdfVX0aMQGb--
