Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750FCC36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 16:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC6CE82B6C;
	Sun,  6 Apr 2025 18:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jbX6wcRB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1CEA82B77; Sun,  6 Apr 2025 18:02:33 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A5A82B63
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 18:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7272f9b4132so2653743a34.0
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 09:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743955350; x=1744560150; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bDbma/6FeuWXty4Wrp+p5DHLb1+PhCJJA5N20mPs+9w=;
 b=jbX6wcRB3TiraRbB0sJou59vB2l1sTK1jlJ674CzQfHkONqKFKRF/Z8mcWFMTf7HqL
 RfwDZfblQpgLQ9E9oncKcGqDOFod47RQgE+OUQjQTNvJbvIZunJ4XTNIsT94xNY+7KIn
 TZbcEPLyIXV8L7dyPyTcku5nyBc6m6HVmejBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743955350; x=1744560150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDbma/6FeuWXty4Wrp+p5DHLb1+PhCJJA5N20mPs+9w=;
 b=K693FtsvKKGw7x4k1ObJN+GSv1QtszLNY8aIbkazxN3Pg9HjipB1/xN8O3w/Xx6lVI
 r8VGllDjNLWbGOXJ9H0bJu0BESEefZUzuUxgdyhMvKlJpU+09BX46ToBX/SrCqpF61Gx
 B/6AWnM1c/DwR5d+DVDJpMD+tMIycW5jDqaFppjK3lDGTNwDT6Izer0P+QvGA3CZXHYh
 85pLBCiLgxH2YZdH/2rTh6OyzaQgsopWh66W4gV/O8jcdDwPEyoDzwj1IeIG01eICZ3e
 0fmlbiPlhL3KEO9rzU2Eq2DeETfgzlE4ixTWI6bxEFUiTc3yjH1NIeTQjXpi/c2oI4X4
 iUBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjLbHRWtyYczKKC/isyG19JJJgUJ2eN2y1sipO9qRQObG/t2TkInSck3oUjyG5kZdKq3oZB4A=@lists.denx.de
X-Gm-Message-State: AOJu0YwXFf0e5ZPqv+D3ZRIIXyCMU8HxF4pbsU4GHwXK/CCgCkYxXiW1
 rfd4nwVdnzukkoTTNi31v5ljcinhY8G8QnJewPO/f51ikbQDDj6xopX2rdnTFUA=
X-Gm-Gg: ASbGncuRkceyFBa12GgclDVnDW4CORPzdwk7BfJxnJoVLN2IxrMEGuQJVtgjb1HHJFF
 elM7vA/73y7on4B+ir50EqEHmQgOc7lljA6/jK8qvgq1I6+CpUlj2+75KIcj3z1+lz4UN9ZDR4c
 2WwNFlkMa83bIXq75aVNzfDi78rwq/hFBk23UvR+qSrOF1nUYtenld3gCz3TsymOM4uuLPwqh2y
 8OgYdcpfXchQTlMslqJJh8FDEzczPyx79GAjKykuifHiB1qjFTExRuVNsbe6SQHxwIs6JmKMnmq
 THwk2SbNUxmE1U6gDNyF3KYnOH1+A0sG7JZmXW/9W/ZuUUch4b/JKfjAuF46v9JMe1dhcIecDL3
 PiKZ9gg==
X-Google-Smtp-Source: AGHT+IEMub4LwvzN7bFM+TIxP9nVXX0D+fK+OiNeZn60rNldkjW6O6qnPONblcAJn+Ch2bgu9KUehw==
X-Received: by 2002:a05:6830:3c90:b0:72b:9c34:1361 with SMTP id
 46e09a7af769-72e37f7e056mr5426661a34.15.1743955350386; 
 Sun, 06 Apr 2025 09:02:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e305116d2sm1422051a34.27.2025.04.06.09.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 09:02:29 -0700 (PDT)
Date: Sun, 6 Apr 2025 10:02:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 sjg@chromium.org, ilias.apalodimas@linaro.org, mcb30@ipxe.org,
 christian@kohlschutter.com, neil.armstrong@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] efi_loader: stop network in EXIT_BOOT_SERVICES
Message-ID: <20250406160226.GC5495@bill-the-cat>
References: <20250405065812.33027-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgp38yBXnSigfT-mEFU=rqyAKjp0WBQGgHP_N3vRxCq=Q@mail.gmail.com>
 <CAM=mAOnCdLWMUfU1DCdUu0RdM0-PXaW_2XrPT5UaKOCSNU4PaQ@mail.gmail.com>
 <87y0wdwqw2.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="awOo7qiLC2qNMWTc"
Content-Disposition: inline
In-Reply-To: <87y0wdwqw2.fsf@bloch.sibelius.xs4all.nl>
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


--awOo7qiLC2qNMWTc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 06, 2025 at 12:01:01PM +0200, Mark Kettenis wrote:
> > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Date: Sun, 6 Apr 2025 07:14:49 +0200
> >=20
> > Simon Glass <sjg@chromium.org> schrieb am Sa., 5. Apr. 2025, 22:46:
> >=20
> > > Hi,
> > >
> > > On Sat, 5 Apr 2025 at 19:58, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > > >
> > > > It has been reported that memory corruption can occurred because ne=
twork
> > > > packages where received after EXIT_BOOT_SERVICES. See the thread
> > > > starting at [1].
> > > >
> > > > We try to remove all drivers when EXIT_BOOT_SERVICES is called. But
> > > >
> > > > * Some network drivers don't call their own stop method when remove=
d.
> > > > * Some network drivers don't have a remove method.
> > > > * Some devices have CONFIG_DM_DEVICE_REMOVE=3Dn.
> > >
> > > A few points:
> > > 1. Only three boards disable DM_DEVICE_REMOVE and enable EFI_LOADER;
> > > EFI_LOADER must depend on it or select it
> > >
> >=20
> > Why does that option exist at all?
>=20
> Presumably it shaves a few bytes off the final binaries?  And if you
> don't have any drivers that do uncontrolled DMA you don't really need
> to do any driver tear down.

The symbol exists, for SPL, so we can save space. The symbol also exists
for full U-Boot and in turn, a number of Xilinx configurations disable
it. Michal, can you elaborate a bit on this please? Thanks.

--=20
Tom

--awOo7qiLC2qNMWTc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfypYgACgkQFHw5/5Y0
tyxa5gwAhUdff0PB+n/didAfV+60I/I4KTc0qVZua7eCciHRLJsdzNTWqLvKYBPJ
Ld0qp39Dk3kJ3cow0CfTFI70GzCMfzZ2jIskD7p3zMaGMZLzxXOb+rh6fH65WIDh
QwWEHlBTmGZcs8C6xtbC1OjPY9cyGyR6jsTQlkuI/EbFRrHrnJdP9e2f7LrmHPOH
b/yxPkEXXWACESWq+adVYgT1BCAWa4A7Nalpxk/Sx9R/Bu5zLZs6If+X+ex60qNz
VGjwt3Fq2h8Uf7s8v6mGirw9vSASy7xG+kbyxc4sw6R/aIqWNEwU+f4NyoBcqzj3
/0tNyy9EH1n9Tdp9dVyn6C+JzH6SXdmFv80SA5rRfJQNeGKg+6N+XSp40MwhYqKW
t7xnC/3is3+j0D0OeNH2i07KCBmSvFUU9tuffyhkufsoW9TLXQBsw8W4Oc9yeE5n
DpRf4+hSdFgagj4jDIjIZIk/XFa6FhMPbRpDGmPuLx+Wbv9HrOPy0YuEJfUhmsJB
39bNm8jz
=H3gR
-----END PGP SIGNATURE-----

--awOo7qiLC2qNMWTc--
