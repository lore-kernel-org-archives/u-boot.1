Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BFBC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 13:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E0018164E;
	Mon, 10 Mar 2025 14:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UoHmI2ZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB6181668; Mon, 10 Mar 2025 14:55:52 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 710938141D
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 14:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22409077c06so7487855ad.1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741614948; x=1742219748; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GcRxHqQTPb1rNlZcQXw7GIIXK6kOyWERd/pwaOow+f0=;
 b=UoHmI2ZYrYU+UycWJFjyQh6ma4Zvdto8N3BfpMlE/BGPWTpa4t22bAPv3+hRZpvAI3
 U/+qokXlq744s82+nNlecPQFXG0Gub4hMREG51J5j/b7thpa4EeDZ/qdCgwwXz1W8jMD
 cRnDOj+2uSfdAYQqov0Bqztx97rEhF6if0XKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741614948; x=1742219748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GcRxHqQTPb1rNlZcQXw7GIIXK6kOyWERd/pwaOow+f0=;
 b=FtqPmzDiQDt4g64vgnWwjM60zwKgxBTfsn+evrg12coAUHRzIUxBSAWlQXAODay811
 EiVVR4YbCfIFly5V+vVEzzWUW1hfSTSEvWvKXEwfobLUWuccsdos54huPfbVVBxYIOfk
 fOB+Lncr7CTJwRnIuCbw89p/0gwKY10yLMjNsyZ//+85pfv2QRsYn5E5taBMJQWqagoR
 f0ShYMOJFbdX5S7sM9FqVd3WWLLxnOUK0v9Gn0Sw3q/lBTScKefQ0cRo0kpINVXB62TS
 imYGM9mUmVQOXUETorx/U4VY0zvC8pg5bS9cIe51WOiRNGyHZgTh9sHBawBrU+JTiqJg
 gKhQ==
X-Gm-Message-State: AOJu0YwKk5FToz/joqms0uRWSKFWwJgSKPECzEpSol1Imlckj+eWWOvk
 shNTY9reRXOV8cVLHP0RBOPnnnK31gQoJOF10bBgBt9MkGTD9bNsnVAS3k1Lhjc=
X-Gm-Gg: ASbGncuFOxOlLRxFNLlhloYB/EC2jYV2s4liv97W4caOPJCyefTiWscjk6kbxvjl6xe
 S18jRBJVaQKvpgZdZ13wVHzsmZZ00x8WvPp/8DxWc2E/CPqE3OgUiBAju+M1HzU5BgdjoI/wSbA
 785iIl/E2hE1cXnyFVQM+hZTSbqwj+c8uWg09CEAOOC9x0ZdxJ4VHGQsbnuiO/FVncA6+vhWwG8
 ++3ZI0UMUec4VlbgIkrHE8vaOe/rgJ1lH2ReUgqazIMXH3cCpq2/Jt9HeT3g0fN2mSEEiAgHjbc
 3s23yuBdFs0OaRDHLXCEILm1TiRfm3ugzjr/DK80hCFdsw==
X-Google-Smtp-Source: AGHT+IH7Pe9ACXg+pPHdDy1eKBGDS8brPcC3G2I5c27EmMqMsGIgK1pVwMvM+rshPy9+ihaHyPzFNg==
X-Received: by 2002:a05:6a00:2451:b0:736:728b:5f1f with SMTP id
 d2e1a72fcca58-736aaadf590mr22226268b3a.19.1741614947900; 
 Mon, 10 Mar 2025 06:55:47 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736aee9bdeesm6555010b3a.69.2025.03.10.06.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 06:55:47 -0700 (PDT)
Date: Mon, 10 Mar 2025 07:55:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com
Subject: Re: [PATCH 02/10] cmd: Kconfig: enable CMD_BOOTI for ARCH_K3
Message-ID: <20250310135544.GV2640854@bill-the-cat>
References: <20250307075541.2571104-1-anshuld@ti.com>
 <20250307075541.2571104-3-anshuld@ti.com>
 <20250307155055.GP2640854@bill-the-cat>
 <D8A60PFV4FQL.5AHV0A4WLX0T@ti.com>
 <20250307162042.GS2640854@bill-the-cat>
 <D8CBZ74BIHYX.1BJH0J37N5VZY@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K/wtO4PHL11vmdnw"
Content-Disposition: inline
In-Reply-To: <D8CBZ74BIHYX.1BJH0J37N5VZY@ti.com>
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


--K/wtO4PHL11vmdnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 10:48:47AM +0530, Anshul Dalal wrote:
> On Fri Mar 7, 2025 at 9:50 PM IST, Tom Rini wrote:
> > On Fri, Mar 07, 2025 at 09:43:19PM +0530, Anshul Dalal wrote:
> > > On Fri Mar 7, 2025 at 9:20 PM IST, Tom Rini wrote:
> > > > On Fri, Mar 07, 2025 at 01:25:30PM +0530, Anshul Dalal wrote:
> > > >
> > > > > This allows us to load the kernel image to memory on 32-bit R5 SP=
L.
> > > > >=20
> > > > > Signed-off-by: Anshul Dalal <anshuld@ti.com>
> > > > > ---
> > > > >  cmd/Kconfig | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > > > index a04fcaa0e08..66145a001b8 100644
> > > > > --- a/cmd/Kconfig
> > > > > +++ b/cmd/Kconfig
> > > > > @@ -357,7 +357,7 @@ config CMD_BOOTZ
> > > > > =20
> > > > >  config CMD_BOOTI
> > > > >  	bool "booti"
> > > > > -	depends on ARM64 || RISCV || SANDBOX
> > > > > +	depends on ARM64 || RISCV || SANDBOX || ARCH_K3
> > > >
> > > > How are you using "booti" on the R5 part of K3? This shouldn't be
> > > > useful...
> > >=20
> > > This is necessary to allow us to call booti_setup [the code path
> > > responsible for parsing uncompressed kernel image] from
> > > spl_parse_image_header at common/spl/spl.c:338 when loading the Image.
> >
> > OK, so please update arch/arm/lib/Makefile with something like:
> > ifdef CONFIG_ARCH_K3
> > obj-$(CONFIG_SPL_OS_BOOT) +=3D booti.o
> > endif
>=20
> We would still have to have CMD_BOOTI enabled even with this change
> because of the check at common/spl/spl.c:338. I suggest we proceed with
> my original set of changes instead.

No, things need to be reworked more then as it doesn't make logical
sense to enable a command in SPL (where there are no commands). It's odd
enough that we need to enable support for image formats that don't exist
on 32bit arm, on 32bit arm. What's there in common/spl/spl.c:338 (and
the next check) is a short-hand.

--=20
Tom

--K/wtO4PHL11vmdnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfO71wACgkQFHw5/5Y0
tyzFbgwAmcxSCPkca8gMghqpczy66JTgRnow6JnLyNVzTEbkOINO6+iW6b7id/Kg
ClubK2cNJn03zr80Bt2FzWG6ohXaUVf8vZ3x3lWUClDOpw04yQsYGh8HVsUfMX6G
M5P7mH88loqgsSbN3Z5QJWGcLjg7qe2TUHRVwGHXwg/mGx/NfrIhgB5EyszoSf30
gTNPLXZavOF6Hkuq3OKRVCv7OCvEc2ahbqnqVQO92GrK/Kb8WmydFyiP4ZPQEaeS
Ya3QSdk/cot5E++cfNzGtomzR4T6uiABbgk/FoOpJhj0tDOIcj5C0z+B6mH5cZN0
JtDMh0bX8UDPMYYL/xm1Wycd3129V/DTa10Q4NmvQRLxIh3Uw3co/8nLeNybe91R
eg5HnSw553ODQ+93y33H5C51Emwb4qcza4Fl8dj0GXLK+2j37HAkemkUVJSiYkkz
PFWBdkgb4RKfqt5DoYt02CjkdFSHOxNLs3riwjUushZQwBRqAE0bdUbAzVu11zw+
eLk3dVlT
=7CWQ
-----END PGP SIGNATURE-----

--K/wtO4PHL11vmdnw--
