Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5161CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 17:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F4F8319C;
	Tue,  9 Sep 2025 19:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L9VcE2cb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB1AB831A4; Tue,  9 Sep 2025 19:36:08 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0748830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 19:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-4103fb72537so10303385ab.0
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757439365; x=1758044165; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R/cV8Tp1cBdGovvkb19pCcDrG+lLyeWgtH8m3NXLHJ0=;
 b=L9VcE2cb1Nc0KNrKHwW59Yu3vGFm9glbhq1zwd9PJSMb0d8WSTQqQTXz1yeAXvc5JP
 jbnT1gxEKNFPmgbvZn1HLfTVP0kesvKaeu3BKcPbYf+c9hL4pUAkdpT7rH+DJ61oPq0j
 Wp/jg8Pr+DQXsRq35hDQfECzlwbiStWpOIkzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757439365; x=1758044165;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/cV8Tp1cBdGovvkb19pCcDrG+lLyeWgtH8m3NXLHJ0=;
 b=QBIEPkbU6mrwmaKoGQYz5JpHVwhVXKFczdFyE3a2SiCNtN7pLTN3vDCbeIakmHNlS/
 uKloyhC6YtULXNnutWLZWXruw8dT7xMyeUvCh1otjKPSvtkMcvKLN/DGIYiL3w6Xd04i
 JHlG1Lg9oiVDdtyUC4953V3jERucE7LB9mdC1fDpljk4GeODeAW10oQlAKWlTQgioa34
 Ssq7cUPVqHt4t5n3+Z/NUw0AYrD7FOBJTv5mCqNCZvlq+JMpD0uuEW5sAP9M8ELTmnkc
 fIQq9dx2yHjfGrE9d1truxTaAFYV0Nac0C8XvHgMffLgpTzW2OOQFn1dsdxLSeeF00O1
 pstw==
X-Gm-Message-State: AOJu0YxIhz/M2WGGnFmqOj01VQikvsWyiY0aYtnNMBBwdXBQTqTKaQcx
 ZIGCtBRx1TXrNQ2jIty7xELwwary/EJHx7Po/7g3bO20QE9r6+8YiBFZPXjb+Wr/v6w=
X-Gm-Gg: ASbGncsy42avGmIWg+uaeWLJSZj14Vv2OJGWXvUX3rDxqyxauLFK2NYLnTgn3RSJaoR
 7Aidvnqpql2i1+gVqj3Ld66VDvalYsFWsLLP3KA4budSS2R+GaCbrabz3EnPgMoTRN0qsh8TsmW
 lGo8vAJEpXjOzTepWf/8AzfVxtdigfyFj0HzAfdBVdBvgd6bEDQYanaZnw/7iF1bb6KEZ5yibSG
 LcdZXFUUoMMdNwssXDjqy3wtPN6ue+GLDi2QRTamF86K/MvylIBhJCpDVnoo6f0XvDcep9/aU5j
 21+EIqU+UTWxaV7Z3MFDbA3PD/tInLwP1H834Ewpe5JBbByIE4F+zaFrLGv+1wWGcTa7tprsZFR
 CpLvVPcC0+ATrw9w53iKxJ6NwsI2bTROA0MPFpVut2v90ASZfuvECoQ1xKRZQuoQGFKQ=
X-Google-Smtp-Source: AGHT+IFabooFTPuehwkuvVAgBXMhcRZ7nYVv0nDVyoIprPq9pdut6jrMggPqurBilNXsDGZHu/dR6g==
X-Received: by 2002:a05:6e02:1a87:b0:40f:accc:543b with SMTP id
 e9e14a558f8ab-40faccc54e7mr58309485ab.11.1757439365155; 
 Tue, 09 Sep 2025 10:36:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50d8f3ab9c9sm9362042173.76.2025.09.09.10.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 10:36:04 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:36:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2] tools: Do not generate logo when cross-building
Message-ID: <20250909173602.GB124814@bill-the-cat>
References: <b18a4f45-77dd-4f78-ba6c-2e017abc98b9@siemens.com>
 <2cbe57e3-f7aa-491f-9896-93f85e8a7a41@siemens.com>
 <20250909145919.GX124814@bill-the-cat>
 <ae031005-e9d2-4676-a2e1-3dfe975cf45a@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0UGxNYrSY48VT/DM"
Content-Disposition: inline
In-Reply-To: <ae031005-e9d2-4676-a2e1-3dfe975cf45a@siemens.com>
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


--0UGxNYrSY48VT/DM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 07:25:48PM +0200, Jan Kiszka wrote:
> On 09.09.25 16:59, Tom Rini wrote:
> > On Tue, Sep 09, 2025 at 12:31:47PM +0200, Jan Kiszka wrote:
> >> On 23.08.25 17:21, Jan Kiszka wrote:
> >>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>
> >>> This cannot work (unless qemu-user is registered in binfmt_misc) as t=
he
> >>> tools will be for a different architecture.
> >>>
> >>> Fixes "make cross_tools" in case CONFIG_VIDEO_LOGO is enabled.
> >>>
> >>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>> ---
> >>>
> >>> Changes in v2:
> >>>  - improve commit message
> >>>
> >>>  tools/Makefile | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/tools/Makefile b/tools/Makefile
> >>> index 7eb17f92116..ae6a3052646 100644
> >>> --- a/tools/Makefile
> >>> +++ b/tools/Makefile
> >>> @@ -333,7 +333,9 @@ HOST_EXTRACFLAGS +=3D -include $(srctree)/include=
/compiler.h \
> >>>  		-D__KERNEL_STRICT_NAMES \
> >>>  		-D_GNU_SOURCE
> >>> =20
> >>> +ifeq ($(CROSS_BUILD_TOOLS),)
> >>>  __build:	$(LOGO-y)
> >>> +endif
> >>> =20
> >>>  $(LOGO_H):	$(obj)/bmp_logo $(LOGO_BMP)
> >>>  	$(obj)/bmp_logo --gen-info $(LOGO_BMP) > $@
> >>
> >> Any comments on this build fix? Or should we somehow get the logo
> >> generation out of the tools build?
> >=20
> > I guess, why is this being built for the target, and not for the host?
> > Generation of the logo image on the device doesn't seem useful unless
> > we're actually building U-Boot, and in that case we'd be building for
> > the host...
>=20
> It is currently being built for both. But if you cross-build the tools,
> you are way more interested in things like dumpimage or mkimage than
> bmp_logo because you want to ship the former on the device.

Ah. Sounds like maybe long term we should clean up the Makefile here to
have a better split between build-time tools and external tools.

Reviewed-by: Tom Rini <trini@konsulko.com>

And I'll pull this to -next soon'ish. Thanks!

--=20
Tom

--0UGxNYrSY48VT/DM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMBldQAKCRAr4qD1Cr/k
Cs7kAQD1asOV8C9zpnxf0oWbZu+RTMTpm5nA+R8Q0787Cgw9RAD3Zp8GUCQ76wCS
fmWcMgavHM4rjwuk/DlH90ozsj8jAA==
=dNfJ
-----END PGP SIGNATURE-----

--0UGxNYrSY48VT/DM--
