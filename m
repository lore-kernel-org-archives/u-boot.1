Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D0AC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 14:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F9A780F70;
	Mon, 17 Mar 2025 15:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jt1B6UcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 413FD810F4; Mon, 17 Mar 2025 15:23:30 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01BAD80F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 15:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7c55500d08cso383640585a.0
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742221407; x=1742826207; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NWyy1/aXzQ2ALAq5ZbwLqn2BmGNIxAMucIHdGVRBnW8=;
 b=jt1B6UcUMCNspig1TaVF5nWg9thi4YcrzelHEEmFmW8zsyi01aLursX6bOasaFumXH
 7b6xmsRADg62WjRt5BUKomXlbZKE7ngsPmse8NyThQowl28PNupbbYRxS+6lPBwbQpjm
 kltKm9HrMD+evIw0MKqDGyX/WjFyImqa1e81Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221407; x=1742826207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWyy1/aXzQ2ALAq5ZbwLqn2BmGNIxAMucIHdGVRBnW8=;
 b=DIxALt9czwKgtnoVQ3p4PoXezOmTaGlVrau8w85x1q4cG4RiltxfM7rhYaiPL6VsiB
 9BitzVEtO9QhsM8mdqj2jNVwh5497ruLXzS7mdydeQfoY/a/S0gJcUo8LbpR38WBEjF7
 OhkgVCmdDw6xX+Yw3wDUbxTyB+JzqXubMjA/8/tibAT/1K+OmVMBEskXTBrahhHAURVF
 VLLtZmPZrmhx9FLOQCUmESApJ96sLNEvXvbuvYegVD0/Pyf2g1WssWxd6H/+ViEwleea
 c0kUDtm6DkMbWW/wskVw8I7/Sx+eeT437LC5qE9Nw0Pq/RPL8F0xOsDgRry/rVhO+68c
 RTLw==
X-Gm-Message-State: AOJu0Ywomq/ZyWvpgjiylgpmomyCdaDYUwmwIacwik7cP3IKSLdkJxGi
 Mro/JNUXDWdRxlWFb5iw3LQHI+ALAZll4AjN1djkQN0MVdMdzV/Ift+/WnKiuF8=
X-Gm-Gg: ASbGncvpdaimA0CQUhbAyN1wTK338AjMm6WbIfiyTD+ViAuCDp0aDVgJv6bm+3nAuF+
 pHP4UCaYdy0all6iY8mOUsyvf5ScjCPyHs66gBkPtQcNPBRjwReZ46mS0Nq9bFT85kw9r1Zf3hw
 mjAY+v/3eCjlQXrpCUOUmzbmz/DFCtKVR4BMqlaz6XgNQGwO5BdWnlFjB6JkVbBLgjMenGxlZCu
 aeuR3XVK1O7rqhq7xgxjhU8qz1rj+MpRXa/wzacoWxkacRcMH10ObzPLEDnj3WoP9gFZEjnlF3X
 hZzIzIBOL5xC/0HkKGCDHRNYNHNTk6DEeOo0HLExtN+iHQ==
X-Google-Smtp-Source: AGHT+IFHX1BC6USBxlO3xfSimRl5ca+/TgxDUI7tqunDcCsekZbOtr5NhiKsCvPv6bA4gXEWPwwVdg==
X-Received: by 2002:a05:6214:c47:b0:6e6:5f08:e77d with SMTP id
 6a1803df08f44-6eaeaa64726mr193468926d6.19.1742221406814; 
 Mon, 17 Mar 2025 07:23:26 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eaeeb1370asm37337816d6.82.2025.03.17.07.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:23:26 -0700 (PDT)
Date: Mon, 17 Mar 2025 08:23:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com
Subject: Re: [RFC PATCH 1/4] cmd: fuse: Remove custom string functions
Message-ID: <20250317142323.GO2640854@bill-the-cat>
References: <20250313115517.1181829-1-h-vm@ti.com>
 <20250313115517.1181829-2-h-vm@ti.com>
 <20250313161539.GE2640854@bill-the-cat>
 <768e6b56-b55a-834b-4abc-41b9cee701e1@ti.com>
 <20250314140928.GL2640854@bill-the-cat>
 <f9ae49bc-0bc8-54a9-acaa-e1d80bfbcb45@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ladKdSZnuo3X5xVE"
Content-Disposition: inline
In-Reply-To: <f9ae49bc-0bc8-54a9-acaa-e1d80bfbcb45@ti.com>
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


--ladKdSZnuo3X5xVE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 02:29:39PM +0530, Harsha Vardhan V M wrote:
>=20
>=20
> On 14/03/25 19:39, Tom Rini wrote:
> > On Fri, Mar 14, 2025 at 07:13:19PM +0530, Harsha Vardhan V M wrote:
> > >=20
> > >=20
> > > On 13/03/25 21:45, Tom Rini wrote:
> > > > On Thu, Mar 13, 2025 at 05:25:14PM +0530, Harsha Vardhan V M wrote:
> > > >=20
> > > > > Remove custom string functions and replace them with normal string
> > > > > functions. Remove the custom strtou32 and replace it with str2lon=
g.
> > > > >=20
> > > > > Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
> > > >=20
> > > > Thanks for doing this.
> > > >=20
> > > > > ---
> > > > >    cmd/fuse.c | 27 ++++++++-------------------
> > > > >    1 file changed, 8 insertions(+), 19 deletions(-)
> > > > >=20
> > > > > diff --git a/cmd/fuse.c b/cmd/fuse.c
> > > > > index 598ef496a43..9f489570634 100644
> > > > > --- a/cmd/fuse.c
> > > > > +++ b/cmd/fuse.c
> > > > > @@ -15,17 +15,6 @@
> > > > >    #include <vsprintf.h>
> > > > >    #include <linux/errno.h>
> > > > > -static int strtou32(const char *str, unsigned int base, u32 *res=
ult)
> > > > > -{
> > > > > -	char *ep;
> > > > > -
> > > > > -	*result =3D simple_strtoul(str, &ep, base);
> > > > > -	if (ep =3D=3D str || *ep !=3D '\0')
> > > > > -		return -EINVAL;
> > > > > -
> > > > > -	return 0;
> > > > > -}
> > > > > -
> > > > >    static int confirm_prog(void)
> > > > >    {
> > > > >    	puts("Warning: Programming fuses is an irreversible operation=
!\n"
> > > > > @@ -54,14 +43,14 @@ static int do_fuse(struct cmd_tbl *cmdtp, int=
 flag, int argc,
> > > > >    	argc -=3D 2 + confirmed;
> > > > >    	argv +=3D 2 + confirmed;
> > > > > -	if (argc < 2 || strtou32(argv[0], 0, &bank) ||
> > > > > -			strtou32(argv[1], 0, &word))
> > > > > +	if (argc < 2 || !(str2long(argv[0], (ulong *)&bank)) ||
> > > > > +			!(str2long(argv[1], (ulong *)&word)))
> > > >=20
> > > > I didn't know we had "str2long" which is a differently rarely used
> > > > function. Why not just simple_strtoul inline? Am I missing somethin=
g?
> > > > Thanks.
> > >=20
> > > We cannot use simple_strtoul inline directly because we need proper e=
rror
> > > checking to ensure the simple_strtoul conversion was successful. The
> > > str2long function is a wrapper around simple_strtoul and the necessar=
y error
> > > checks. Hence, using str2long here.
> > > Thanks.
> >=20
> > I'm sorry I'm still not getting it. We virtually never call str2long. I
> > was taking a quick look at why if anything the 4 callers in the entire
> > tree today have more special error checking requirements than every
> > other command which parses user input.
> >=20
>=20
> Hi Tom,
> I tried to retain the error checking done by the custom strtou32 function,
> hence replaced the custom strtou32 function with str2long. I did notice t=
hat
> in some other files in the cmd/ directory, simple_strtoul is used inline
> with NULL as the endp parameter, like this: simple_strtoul(argv[2], NULL,
> 16).
>=20
> Do I proceed with replacing the custom strtou32 function with simple_strt=
oul
> inline by passing NULL as the endp parameter, similar to the example abov=
e?

Yes, that would be good, thanks!

--=20
Tom

--ladKdSZnuo3X5xVE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfYMFcACgkQFHw5/5Y0
tyx0HAv/Q41ygSS65t3o7g3OJD37/aZDoBxgv4bwskGK8dtWN6wIg0+ASWtQUDqd
DbMiY3oKQnyt+HJGc5LvoVAxm+R7nROe4HkIa74BSXuz66S9v7Fhhsd8x09Bvjy0
ir73Fk3bXVjWzjSywrRmtesEAJ+blRKMW8pEQtoS3MbUWMTe4COO9HpbUkZB+RXv
5XsVsNxkxOPNznW7MoxFEpEjWCqoTHri94TJYfYlBryqAbdhWRk6i8F09d2BNOQ1
QM5xw6cCnFArsVttSkIuXus4Ao9dMXeTMW5XqzBafB2d/BxGGL/rTo5TWfpFkb67
nvqc13G4N1jJN/R2OBVFMo695W0j+4BS3q59wkoO8hRH/q9rPYd8vYwVN6fN0jME
Z/Y4zOpo1OzODfTGCxHpM9ireZMMoicPW/7MQfTB/hGVIFY/pC9jZYNvc3/kjwPL
4ZeUgQ5RBozdj2BkRmh4n8rbPvoZkr6pqETvV5g4MP80ADoKfZnpIc8hyNzYIXFT
8VBo+1Z9
=n/4G
-----END PGP SIGNATURE-----

--ladKdSZnuo3X5xVE--
