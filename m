Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ACCD15D87
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 12:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B76188DB5;
	Mon, 21 Oct 2024 14:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TzUAR7nD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59C8888E35; Mon, 21 Oct 2024 14:33:59 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F6788DB5
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 14:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0397DA42950;
 Mon, 21 Oct 2024 12:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D60C4CEE5;
 Mon, 21 Oct 2024 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729514035;
 bh=olM3+ZywFQWrsICsygKZtdjBqlahU1+NkCRwf2K3Hcg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TzUAR7nDfR5HQGnfjAIp1vWejmi1jBZE3GpzdFxvAOhovN0Wudlk85tS26zzLb3U3
 inXW5VJ6lWuRIyTJ1y2dcJiz6Pa4dg84pahnN4BN5wR+zK2Xs+pIIXl9WL3q+P7/lp
 I/31NUrq5hKGxeOqTFI3LNeh48UCk58bsI+X0j6HInCrY4VsB1NYvzpObyjrBU9Og8
 /WOGKAzmmjt2aj4MF1s10z9NIWtKNMTHxA6wvEEn/yiJFjI71sdkxUV0WMD6EfvvRB
 V47UmMmblVKzZ8mIJoVm/U1QOCx2F1ZNKgxogKx2cd7Xc3+pwK8B0nIIQBELIQvvmL
 Cx9KhUTuIpCCw==
Date: Mon, 21 Oct 2024 13:33:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Cyril Jean <cyril.jean@microchip.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v1 3/3] riscv: dts: mpfs: migrate to OF_UPSTREAM
Message-ID: <20241021-implant-crawfish-33a92aa8d253@spud>
References: <20241018145444.1660219-1-conor@kernel.org>
 <20241018145444.1660219-4-conor@kernel.org>
 <CAFA6WYMgE-qmKwaDx=88eL-HmHCYdG-Sevp=p8tH4ZDPgR=P9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ftCrmg6NSM1Xe+DT"
Content-Disposition: inline
In-Reply-To: <CAFA6WYMgE-qmKwaDx=88eL-HmHCYdG-Sevp=p8tH4ZDPgR=P9A@mail.gmail.com>
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


--ftCrmg6NSM1Xe+DT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 05:34:16PM +0530, Sumit Garg wrote:
> On Fri, 18 Oct 2024 at 20:25, Conor Dooley <conor@kernel.org> wrote:

> > diff --git a/dts/upstream/src/riscv/Makefile b/dts/upstream/src/riscv/M=
akefile
> > new file mode 100644
> > index 00000000000..dd2ed0bdfbd
> > --- /dev/null
> > +++ b/dts/upstream/src/riscv/Makefile
> > @@ -0,0 +1,13 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +
> > +include $(srctree)/scripts/Makefile.dts
> > +
> > +targets +=3D $(dtb-y)
> > +
> > +DTC_FLAGS +=3D -R 4 -p 0x1000
> > +
> > +PHONY +=3D dtbs
> > +dtbs: $(addprefix $(obj)/, $(dtb-y))
> > +       @:
> > +
> > +clean-files :=3D */*.dtb */*.dtbo
>=20
> Many of the common Makefile bits were moved by patch [1] to
> =E2=80=8Escripts/Makefile.dts. So you should rebase to the latest master
> branch. Apart from that, changes look good to me.
>=20
> [1] https://github.com/u-boot/u-boot/commit/d2061828a4c1b60b44cd2307b6a78=
2ac2efbffbe

Heh, I had actually rebased to the latest next a few days before sending
these, but I guess that didn't include that match. next or master make
little difference here I think as a base, so I'll do that, thanks.

--ftCrmg6NSM1Xe+DT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxZKLwAKCRB4tDGHoIJi
0uzhAQDRkuZpIlalubdPnUQ0eH0Y/kLhwWjp1KAB1qXTjr340QD+PyDlPj9DSM2c
4fgHIF+yPHoYfSRPXR0jXjR9nAXUww8=
=uQ3l
-----END PGP SIGNATURE-----

--ftCrmg6NSM1Xe+DT--
