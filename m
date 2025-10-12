Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC9DCCD187
	for <u-boot@archiver.kernel.org>; Sun, 12 Oct 2025 19:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B76283816;
	Sun, 12 Oct 2025 21:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LnK1OmAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870CC83826; Sun, 12 Oct 2025 21:07:20 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E36C83775
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 21:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-79d36a6298dso1331076a34.0
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760296037; x=1760900837; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+xf4Tbd4s0GnSsEcTynUeU6yC10Nv37rXfuHYGnT44=;
 b=LnK1OmAEDKGNkMEYPHg37UlF4cauTlzity5j8jGVPKf8Z7q1s7J/a/q0LO6/qDCsgs
 TnJsG5OzAhOK5QuFtZak1FppynFRtYt8pdFK0gqO+UeIEU3aMI7RxVS7Ln92fJiAF97b
 RHPNy2O4B8cdrw7JJuxHWt6V3OGh6hA3LlirA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760296037; x=1760900837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+xf4Tbd4s0GnSsEcTynUeU6yC10Nv37rXfuHYGnT44=;
 b=vgQJpL53V0viQeQJcThhff8psDNFhgsf3x3tRPXqBZqtSGSfsxpUTL/Q5xMBre7ydr
 EQcpLc8/qFf7uzmp9/bIOy3+GxtlOkDSQaIlbkmLU+yQxmZgsEGFVuleWLD6luIfrazV
 SbDtLXZi+FrK0ne0OkcpRUznyWVk30i3CFwD0rVE0G66Lc8O+2IXDVW9G7fYA+/m7oAj
 qpvapudqenM4tOFXcVHnDmL607ofOmdluZXhYJ7K2dFY/Z1HemvLpJg6fyGbfvMSpLJI
 9/TiHLTzgEmffFCGj8Gtjc6trJkF+rBOBu+P8yIIusPzMgHwA2Isjuz2rXFq9ppOPRPt
 UhpQ==
X-Gm-Message-State: AOJu0YzW6D+xD0enoTK7J8ACLNYA7q9S5eLYJvrRH1wwAm7SG/NqYRZx
 q1zID1RpmxY1BFnUUYlknnFwsLmmO9UdubNYvEsJFeq44Xhy4yaMrs6toWvLoKnN4XvsuuBSywf
 5jG/Kcdc=
X-Gm-Gg: ASbGncstMElrauElEgsYqJQ1erlMzDAGMlP25JMOaI5Uwp9C+tfftCn11qaoS6U+sbA
 JafpU7ykEVI/ftC+icx9KLx+8bAo1M8b8Dd15Ce6vyjdKkvzboL0TgNKw8RyBm+l0zy1SfNvz4L
 q0R838mqkqa0JM/LY1DuZnNnEYFlVoC4ZGSLO4TxDl9qFcp5wyqkqhOyuJvLR9ALLf8sduhhCSZ
 iAZqhtHxFLKZgxwJqcfWmU15CtCOFqyppfznp/NtyBTOTpzPV32VIFCCXLK8yqWfxoqSyH+p2ID
 LR7z10OfEi49mtiO4Lp5muq+zwMzPCJp+xT561+rMuneH2/yTbeCcl6s26B77SSfTbVwI7MaoRI
 j4GfVI0iV6HtHs8hUNzg+cqgDGdoqu7IPAgcGvn/C6nbjzW1MlWLCTx39GFFs+yffFwEkFr1fnJ
 NA0B7DlP0fnwEmkg4=
X-Google-Smtp-Source: AGHT+IHZmhOfFhKEzR+ALuN52JKhJU0lCH5UexCjNjK49beST3/Mu6KG1WN/QgEl9tbciz5dcTjsyA==
X-Received: by 2002:a05:6830:6682:b0:7ab:e6fc:9f0e with SMTP id
 46e09a7af769-7c0df7be3e3mr10806910a34.27.1760296037022; 
 Sun, 12 Oct 2025 12:07:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f911ab1csm2833171a34.28.2025.10.12.12.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Oct 2025 12:07:15 -0700 (PDT)
Date: Sun, 12 Oct 2025 13:07:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20251012190713.GB6113@bill-the-cat>
References: <20251011180636.GM298503@bill-the-cat>
 <ef6da754-8217-42ac-bde4-8752cbd3090d@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VF8fv/mvX+D4+3j/"
Content-Disposition: inline
In-Reply-To: <ef6da754-8217-42ac-bde4-8752cbd3090d@iopsys.eu>
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


--VF8fv/mvX+D4+3j/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 05:22:15PM +0300, Mikhail Kshevetskiy wrote:
>=20
> On 11.10.2025 21:06, Tom Rini wrote:
> > I think unfortunately the report email for when I merged in -next was
> > lost somewhere / wasn't sent. I may be able to get the details out the
> > dashboard.
> >
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Fri, Oct 10, 2025 at 7:08=E2=80=AFPM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >
> >
> > Hi,
> >
> > Please find the latest report on new defect(s) introduced to *Das U-Boo=
t*
> > found with Coverity Scan.
> >
> >    - *New Defects Found:* 1
> >    - *Defects Shown:* Showing 1 of 1 defect(s)
> >
> > Defect Details
> >
> > ** CID 537478:       Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
> > /drivers/spi/spi-mem.c: 528           in spi_mem_calc_op_duration()
> >
> >
> > _______________________________________________________________________=
______________________
> > *** CID 537478:         Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
> > /drivers/spi/spi-mem.c: 528             in spi_mem_calc_op_duration()
> > 522     	ncycles +=3D ((op->addr.nbytes * 8) / op->addr.buswidth) /
> > (op->addr.dtr ? 2 : 1);
> > 523
> > 524     	/* Dummy bytes are optional for some SPI flash memory operatio=
ns */
> > 525     	if (op->dummy.nbytes)
> > 526     		ncycles +=3D ((op->dummy.nbytes * 8) / op->dummy.buswidth) /
> > (op->dummy.dtr ? 2 : 1);
> > 527
> >>>>     CID 537478:         Integer handling issues  (OVERFLOW_BEFORE_WI=
DEN)
> >>>>     Potentially overflowing expression "op->data.nbytes * 8U" with t=
ype "unsigned int" (32 bits, unsigned) is evaluated using 32-bit arithmetic=
, and then used in a context that expects an expression of type "u64" (64 b=
its, unsigned).
> > 528     	ncycles +=3D ((op->data.nbytes * 8) / op->data.buswidth) /
> > (op->data.dtr ? 2 : 1);
>=20
>=20
> op->data.nbytes=C2=A0 comes from file drivers/mtd/nand/spi/core.c, functi=
on
> spinand_select_op_variant().
> According to the code the max value of op->data.nbytes is
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nanddev_per_page_oobsize(nand)=
 + nanddev_page_size(nand)
>=20
> thus it's slightly more than 4Kb (I never seen flashes with page size
> large than 4Kb). According to this estimation the overflow will never
> happen.
>=20
> If it make sense, I can try to do something with it

Yes, please see what you can do about it and thanks for explaining that
it shouldn't be an actual problem.

--=20
Tom

--VF8fv/mvX+D4+3j/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOv8YQAKCRAr4qD1Cr/k
Cr2rAPsHNWL0MdHe6Ty90xi4TctgNhdswemA7NXjhN+cHx0IVQEAwI7VB7sdKjHh
VmMTs9T3d4d/8owWz8vFv5P0cazBQgE=
=kYjh
-----END PGP SIGNATURE-----

--VF8fv/mvX+D4+3j/--
