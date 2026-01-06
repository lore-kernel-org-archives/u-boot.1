Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B06CD042D
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 01:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A1BE83D9F;
	Tue,  6 Jan 2026 02:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AHzpUJy3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA68283E7F; Tue,  6 Jan 2026 02:49:54 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE62983A57
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 02:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3f4f9ea26aaso399308fac.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 17:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767664186; x=1768268986; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B/o95GQwkqygOEnHzFWTIVnfpLy4LANzv8fHtFVICt0=;
 b=AHzpUJy3/qaXonz9ymXvAHMALA/QsdyO6YmNO5KlduxjUzuHIlACHV5oRNjtwfBqCq
 VrcAIYgL3sIfWg9wy+y1O8dpXUJioJeNjjPo7hZbpAp6EJT268VhaqyJK4EKVBUoD1yA
 bu1Og1Z5H0lL7JNqVprz2TFNzPecb00WfSYNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767664186; x=1768268986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/o95GQwkqygOEnHzFWTIVnfpLy4LANzv8fHtFVICt0=;
 b=ZRs563n7fPaXI9dwohOoEAAH0QKqVgEYUyJ9VpHu2/V5eSjZJVQUe0Bx9EtWAx4HBH
 e21pr2lx2ckKch201PEpQ9YPhOSTc3OeAv0oB6YXOQJVEx9K2qCJRSDQSQLWtjrjePrU
 Teq4tEgpz085te8mZlMaBohiks8Drr6xR/jTW4hP9uTdzF000o6hs5astmeDtIhYiVuD
 Qk7txjK8guorpd1jRlhv6p/14z7DY0r+71OTXp2iKWsfPCJWNjWqOKk+HL0U0oZr7blv
 NcOHr1LLZguFxjymN6hav94B8bBmxHHwEDS5kP19Dsf2AQRnGnENuqAxqA1v+hPgMsBW
 UAJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNbj2VTP42H3tOBXQcdC7aGibt6YK/w5aY4r9y7xkl02uYO3Z3WsSAP+qKVjppyGPaXiyOGlg=@lists.denx.de
X-Gm-Message-State: AOJu0YwBmUXy7aWlGJFj+GNFtG+4YmkrU3StJVdFF6Oy7uIocBPooZFb
 YQqpAMxMbqfY7y1gj/aieVo8hokRxTI7PMzO7M8SiwsSz/uEixZIn0+YleHIci0gb8Y=
X-Gm-Gg: AY/fxX5pBbvDn30ouu1fVzOHXwY5YboU6ctkqhRKOXqfnWAXDigIHpL0CtN4/5YKUlE
 bca4OegfyCfzElbmYlxdIUNye34J8gupnBwqZQrpR70+5fjbRGLvPIYw2dQ35AZ1EzhDbZ39PJC
 FGBcZdNnlfW+3FIT16Tyu13evVnId+nAw8A3BpbZK1AC/xNGIuj9cPb21qqw6bEQtBOIGRKdmxq
 WnbYbXCZFpxaCdeivuoCLmyC8ZR9xmFKpLlXY7FqKpRLippxv9o9y44m8M6MFwlBIg8K0w14pfe
 8ZSDQzvWYftql+vEErW04pk7GhJRkkMK6eV1UVdQuN5WOy3cXqyTpN+tRO+dtH2Fzsd+b2gLKR3
 IU+1oUYlKAz2DKAWqzE0W/5lcZmnfVcBv7uKGLNtZerV1/olSjozGQP15ZG3ox9LOXjQ9xq/l2o
 Xfz7NHfu34dDS6k7qeqy89CJ1THMvchD1urj13wvkj7jezMXhNHB3G7vXDjrZVOmRumaRfmHeae
 zwMLGSMT5dBZ28MUDKQzTPcB9Uy186lVuSn9HM=
X-Google-Smtp-Source: AGHT+IGtGRZzR/DYptd3HdIoUu3LnuOcWiQ444U2PGdcfvzANQ/cVeb+j4565RG51rx55hG1DNRm7g==
X-Received: by 2002:a05:6870:3103:b0:3f5:84e2:1fd5 with SMTP id
 586e51a60fabf-3ffa0d49891mr660231fac.43.1767664186191; 
 Mon, 05 Jan 2026 17:49:46 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa507235fsm468673fac.13.2026.01.05.17.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 17:49:45 -0800 (PST)
Date: Mon, 5 Jan 2026 19:49:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: Simon Glass <sjg@chromium.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 alison.wang@nxp.com, angelo@kernel-space.org, me@ziyao.cc,
 heinrich.schuchardt@canonical.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 3/7] rtc: goldfish: Support platform data for non-DT
 probing
Message-ID: <20260106014943.GD3416603@bill-the-cat>
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-4-visitorckw@gmail.com>
 <CAFLszTiMZLXoXEk=JL3siZURVD2YdnmQ7HXy=Viw8uUFbrL6qg@mail.gmail.com>
 <20260105234725.GA3416603@bill-the-cat>
 <CAFr9PX=S7X0Y5Rg2ySN8H_g7ot1R-Ksu+SZL=Ot4Yx=N2YDW6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7ufLRvSbSx7l3Qj9"
Content-Disposition: inline
In-Reply-To: <CAFr9PX=S7X0Y5Rg2ySN8H_g7ot1R-Ksu+SZL=Ot4Yx=N2YDW6w@mail.gmail.com>
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


--7ufLRvSbSx7l3Qj9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2026 at 09:58:30AM +0900, Daniel Palmer wrote:
> Hi Tom, Simon,
>=20
> On Tue, 6 Jan 2026 at 08:47, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jan 05, 2026 at 04:30:26PM -0700, Simon Glass wrote:
> > > Hi Kuan-Wei,
>=20
> > >
> > > You can package your own devicetree in the U-Boot source, to handle
> > > what you need.
> >
> > That's not helpful feedback here, the correct path is to use the machine
> > as QEMU provides it and not start yet another pointless argument with
> > QEMU. And this probably applies to some of your other feedback as well,
> > thanks.
> >
> > --
> > Tom
>=20
> My version of this converts the bootinfo from QEMU to a devicetree
> inside of u-boot and then u-boot uses that going forward.
> I have suggested to the m68k kernel side that we allow bootinfo to
> pass a devicetree pointer and/or use embedded devicetrees in the
> kernel selected by the machine type in the bootinfo.
>=20
> My plan is once this very basic part is merged I will rebase my stuff
> onto this and then start spamming Kuan-Wei with patches to add in
> devicetree etc. ;)

Getting all of the other parts of the system in agreement and then doing
that sounds like a good plan to me, thanks!

--=20
Tom

--7ufLRvSbSx7l3Qj9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVxqMgAKCRAr4qD1Cr/k
CilFAP9NR1Z0BQCVyfAy1Z/oEpWKyniUSnCkEtntCkRYyFK9xAD/RoQb1dAUs+az
czW+K3a5HwK3UARLXtz5XnjIh2p9Sg4=
=SYsK
-----END PGP SIGNATURE-----

--7ufLRvSbSx7l3Qj9--
