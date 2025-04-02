Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB5FC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 15:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED02C8035B;
	Wed,  2 Apr 2025 17:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SMiI8pBW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6474D81703; Wed,  2 Apr 2025 17:31:13 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B3C98006D
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 17:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72bb9725de1so1830954a34.2
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743607869; x=1744212669; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CjTLR92p9agQJd0SKg+EscPhEx+WKnLQ7W2gP9PLjgE=;
 b=SMiI8pBW4BWWR4OZ/DheAmIM/U+y4HDJW2unhwMFwLEPBFZvBKuhZn32QrTeHf3HoB
 c+fuSRkEWYGFV2/fW9FQboFc36lV80Eh48+qQ+0vvYZCu/To+DuHiYA2qkQIX+BoYx3e
 O9T/6w/aKeaeasVyM6UjuM6lSJrTpDuruj/5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743607869; x=1744212669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjTLR92p9agQJd0SKg+EscPhEx+WKnLQ7W2gP9PLjgE=;
 b=vDdeTfJFYWJQ8ERqvgmmI7UpBpPa1sXhNk0OUShKUf/wdsuKRuW+EqD9WJvUxbS9l1
 CAKlpQyZKVn0hNAMgIgPLNpFKRrpkd/e/1JyYinpNr1ygWS6h0gCKZJ40d78jUq6hCwQ
 KrPvAkLsKqrIANd/2+zlZXp6rOEI5u8beXMX2Z6/dl15yvHEv9ntcpEYXf2J8eQqgXS5
 vfUzoF7jj3ze9bywvmmZDjTAkLkTIOln7yT+jd1jfpUC5e4EW51KQK1iVoimwaM8Iihd
 xEBnI2Zter/TrsDaFXngSmO3BHPg7mnJDV2FcLA9HID1uTdsAnlqZ2fZbYh42svqDU9Q
 lkWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMAnAEoNyro+hW7TroBy5JDixHpsexyaaeZsfOXZiHbwSV2TV3CErU8wXuQkFCs0FEVmXYIHY=@lists.denx.de
X-Gm-Message-State: AOJu0YyF+OuPtFnZK8Mz4B6OVaRdNq+UX3QJ3gQHPiD0lxji5z8Uaw8a
 wf+zcyuqKxU5/rGF5N+zk2l7JEGYQc9LiIOy42aVusM2C2EVuxxqHQV1tpinfck=
X-Gm-Gg: ASbGnctWIMnTegwC/DViINF1407Yxb4iVasAh6A5IUE0x026Jub/KNKRDu29P0A3WcL
 QNjiIO+BAN50+pJ6/UwphfmZNWgcxFlQcV9zu8XTaBRMP6/iOBijS4JptqKZ3E+vxMI+5HSy6Ny
 qZZ6RmPoXAW3IybF7CfXPX/3hHmTd8Or6xD45j+RAkw6g+iobdplsJJwoP4n+Q/m4IGBy2tIBRJ
 avT3Sokn5plv0zJthKAY4d1xG1kobRnMqkM2l4wc8pdpnmk4Y6/GyBHH6fcVlJRLfIr9bzpG4vW
 eYBZTJUqC/qzSenP3Ui22OyYp6ehPSBE3OCHp/NM1IZkbQE6opXrkThCkVrcSnWbr0w67QmqX7g
 9FlZ8Lg==
X-Google-Smtp-Source: AGHT+IEpBNwXt0zFQuTUzHSZVG3t1AKxjgstxws4q4tSSrfe/U/4DIjJJa1NXLxxvRiSJX35TJoygw==
X-Received: by 2002:a05:6830:3c05:b0:72b:943f:dda8 with SMTP id
 46e09a7af769-72c6384d65amr12497272a34.26.1743607869571; 
 Wed, 02 Apr 2025 08:31:09 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58267b6esm2318480a34.53.2025.04.02.08.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 08:31:08 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:31:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Bruce Suen <bruce_suen@163.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 02/14] net: airoha: Add Airoha Ethernet driver
Message-ID: <20250402153104.GZ5495@bill-the-cat>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
 <20250401225156.25790-3-ansuelsmth@gmail.com>
 <20250402151951.GY5495@bill-the-cat>
 <67ed5610.050a0220.1c650.ac73@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CnLLSXH77Dbhicom"
Content-Disposition: inline
In-Reply-To: <67ed5610.050a0220.1c650.ac73@mx.google.com>
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


--CnLLSXH77Dbhicom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 05:21:49PM +0200, Christian Marangi wrote:
> On Wed, Apr 02, 2025 at 09:19:51AM -0600, Tom Rini wrote:
> > On Wed, Apr 02, 2025 at 12:51:34AM +0200, Christian Marangi wrote:
> >=20
> > > Add airoha Ethernet driver for Airoha AN7581 SoC. This is a majorly
> > > rewritten and simplified version of the Linux airoha_eth.c driver.
> > >=20
> > > It's has been modified to support a single RX/TX ring to reflect U-Bo=
ot
> > > implementation with recv and send API.
> > >=20
> > > The struct and the define are kept as similar as possible to upstream
> > > one to not diverge too much.
> > >=20
> > > The AN7581 SoC include an Ethernet Switch based on the Mediatek MT753x
> > > but doesn't require any modification aside from setting the CPU port =
and
> > > applying the Flood configuration hence it can be handled entirely in =
the
> > > Ethernet driver.
> > >=20
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/net/Kconfig      |    8 +
> > >  drivers/net/Makefile     |    1 +
> > >  drivers/net/airoha_eth.c | 1448 ++++++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 1457 insertions(+)
> > >  create mode 100644 drivers/net/airoha_eth.c
> >=20
> > checkpatch.pl has some macro warnings and it looks like some
> > inconsistent spacing around '#define FOO' vs '#define<tab>FOO' ? And are
> > all of those defines needed?
> >=20
>=20
> No they are not all needed, I defined them for consistency with the
> original driver. Should I drop them?
>=20
> For the checkpatch check, also comes from the original driver.

I guess if it will make long term re-syncs easier, we can ignore them.
But the macro thing should likely be addressed upstream too?

--=20
Tom

--CnLLSXH77Dbhicom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftWDEACgkQFHw5/5Y0
tyzvdwv/V81tgPXotvStViLomht9dBrfNigaCTpiwn/gG+d99/b3DD1WCFOb3c/o
lssXZi2Df5vS63OtvK0PS2sJGknQC5AZHi1OiSjOIVbDS2UqDkmyj0mceOFogiC6
llZ+cOCFg5C9IFaiuLpYG9DBur8QW2lOGrpUoxy1cVtA3WaaQaAILFngIVROKBBB
3IUHQ7WoZGOPCu2bW9X4P5irkpfL+P9xGmjKIFlcPFRtgXw84AdbgSrP5THhYXio
ErcSJpO0jqBD375+VSVDJBciLSho2orDJNXTB9FO0Z/pnnUdz2rUx8ETrmtZjpO5
vEO9yjXWUE3QsCcoaUGZkNBsDR9QC4zxl0w382W5EMOluEV6zE35VwygN5zUdQvY
VnQPZTXlEyHrGlmdLKiVE3LPEclFqk6MAMMQIS1plSMF9C0nfItN9Ztb3xy+P90G
E1cJ0ZPE0IXdRugM+/zjZlkNbuH1BzNOfuijCy9sH/+1zf0x3SwEu9cv5FH5WbLD
X36hKV7C
=hPo6
-----END PGP SIGNATURE-----

--CnLLSXH77Dbhicom--
