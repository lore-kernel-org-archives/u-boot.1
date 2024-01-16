Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE59C3DA79
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 00:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF20C876FA;
	Tue, 16 Jan 2024 01:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qycil+Oh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C82BA874B1; Tue, 16 Jan 2024 01:46:32 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B1F2878EC
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 01:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-783182d4a09so1149874885a.2
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 16:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705365981; x=1705970781; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uuxAuAV25xsfqYMFyU0BwcfiZU/FwKZwLYRnz7IeLnY=;
 b=qycil+Ohpim2K4TPmdnj5WMjKqup6BVHikmWaNMwhgH+sonmCB8zSuHCIOclvRft6b
 oemNUDxQbAOkl/io2hiLLW6Nq3s0vPZnx9UyYpdGoZYtEPtMvXNQ7YQYojwIjv+nZhCU
 Sev5YVwWKQwexpoKX+QGgRHh8+D+dVnROfXEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705365981; x=1705970781;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuxAuAV25xsfqYMFyU0BwcfiZU/FwKZwLYRnz7IeLnY=;
 b=XqBCasHMZjHHsqvWDktku9X5j/bB6TTxXNAtRMbNJHL0FjNttPV9ODschHtZWTNojv
 CwyZoHhcfWvlf28iQfOvWoOkgb3psR62GyvYmUl5iwosE6Rpjee+V5ReoGWzSd0t6G8A
 r8HEzVInSpUMTQGx6oyW2Cl/CidkWKVJ3RFdcLPR/0jklduGbiXPt8dBfR0Fpl/5My5n
 FvSmG5xatgtesgPBrFL/Evv+MH4LhCl47ONinybCjaxfPFxD3SwXEelwQN3nvq6GYfuP
 H0i2vQbiREmTXfy3zsF4cqXuBAOTs+dx4pytpNio3myGL5R2Cy1BgX8SueNzWri1VpJe
 SzIg==
X-Gm-Message-State: AOJu0YzhU1I0Yb1SonhgCY0iWtQDex3578LsCyXYTg6ekeu++BandFRY
 wvt6TGae2P6lJl7Fy0nYbzGcUNx4Q9jb2g==
X-Google-Smtp-Source: AGHT+IFC8hGVN87AxJ21GueXkWSi0/wU/H1wvvSwwNWP08DncuPW9O2SzhZGFomXsWfwsHAGp2XFaQ==
X-Received: by 2002:ac8:580c:0:b0:429:f511:14e3 with SMTP id
 g12-20020ac8580c000000b00429f51114e3mr2748756qtg.36.1705365981325; 
 Mon, 15 Jan 2024 16:46:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 f11-20020ac840cb000000b00429ca20f6e3sm3832886qtm.78.2024.01.15.16.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 16:46:20 -0800 (PST)
Date: Mon, 15 Jan 2024 19:46:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v13 00/24] Modernize U-Boot shell
Message-ID: <20240116004618.GA12635@bill-the-cat>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
 <170379713946.899302.2054678070497875668.b4-ty@konsulko.com>
 <5740853.DvuYhMxLoT@pwmachine> <20240111170418.GA7220@francesco-nb>
 <ce968882-f30b-4f49-85cf-c38f78bb6ff8@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="InGr6/g2cTXTz1WO"
Content-Disposition: inline
In-Reply-To: <ce968882-f30b-4f49-85cf-c38f78bb6ff8@foss.st.com>
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


--InGr6/g2cTXTz1WO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 06:34:24PM +0100, Patrice CHOTARD wrote:
>=20
>=20
> On 1/11/24 18:04, Francesco Dolcini wrote:
> > Hello Tom, Francis
> >=20
> > On Fri, Dec 29, 2023 at 07:55:37PM +0100, Francis Laniel wrote:
> >> Le jeudi 28 d=E9cembre 2023, 21:58:59 CET Tom Rini a =E9crit :
> >>> On Fri, 22 Dec 2023 22:02:20 +0100, Francis Laniel wrote:
> >>>> During 2021 summer, Sean Anderson wrote a contribution to add a new =
shell,
> >>>> based on LIL, to U-Boot [1, 2].
> >>>> While one of the goals of this contribution was to address the fact =
actual
> >>>> U-Boot shell, which is based on Busybox hush, is old there was a
> >>>> discussion
> >>>> about adding a new shell versus updating the actual one [3, 4].
> >>>>
> >>>> So, in this series, with Harald Seiler, we updated the actual U-Boot=
 shell
> >>>> to reflect what is currently in Busybox source code.
> >>>> Basically, this contribution is about taking a snapshot of Busybox
> >>>> shell/hush.c file (as it exists in commit 37460f5da) and adapt it to=
 suit
> >>>> U-Boot needs.
> >>>>
> >>>> [...]
> >>>
> >>> Applied to u-boot/next, thanks!
> >>
> >> Thank you for the merge!
> >> If there is any problem, do not hesitate to mail me and I will take ca=
re of=20
> >> it!
> >=20
> > This change, specifically setting the modern hush shell as default, is
> > breaking our boot script, just noticed since the current U-Boot master
> > has a regression for us.
> >=20
> > We still need to figure out the exact details, here [1] you can find the
> > boot script (that has some placeholder that is replaced during build).
> >=20
> > and the error is something like:
> >=20
> > ```
> > ## Executing script at 90280000
> > Loading DeviceTree: k3-am625-verdin-nonwifi-dev.dtb
> > 69025 bytes read in 11 ms (6 MiB/s)
> > 82 bytes read in 9 ms (8.8 KiB/s)
> > Working FDT set to 90200000
> > syntax error at 'done'HUSH died!
> > resetting ...
> > ```
> >=20
> > that I _assume_ comes from this line
> >=20
> >     env set set_apply_overlays 'env set apply_overlays "for overlay_fil=
e in \\${fdt_overlays}; do echo Applying Overlay: \\${overlay_file} && ${lo=
ad_cmd} \\${loadaddr} \\${overlays_prefix}\\${overlay_file} && fdt apply \\=
${loadaddr}; env set overlay_file; done; true"'
> >=20
> > [1] https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recip=
es-bsp/u-boot/u-boot-distro-boot/boot.cmd.in
> >=20
> > Francesco
> >=20
>=20
>=20
> Hi all
>=20
> I observed a similar issue with STM32MP157c-DK2 board.
> Since commit 78912cfde281 ("cmd: Set modern hush as default shell") U-Boo=
t crashes :

I wonder if:
https://patchwork.ozlabs.org/project/uboot/patch/20240115134656.50917-1-hei=
nrich.schuchardt@canonical.com/
is relevant to this problem or not.

--=20
Tom

--InGr6/g2cTXTz1WO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWl0dYACgkQFHw5/5Y0
tyxLSwv/frh7Fv22ES6sIZKymAxg1WHD2sHvmQ6A5/vflDIndVrV8TTx0jK1u33Y
TMU0sO/qFjG82MN17icv2BA9lN2viUZVvpMhwl6GsSO+VVB+oVTD8Rp3WGda7DIW
ysKts+4I5drU9Y8nUXSPkOLmhqNsY4bFvocBRfcds4RAtmoeesUnD10RcHX9wk18
rHpD+5sIA+NMcYMXYzD/utFAW0GOOedyP5mDN5byx9BKZ3pYv8b/d65A5A+G+m3B
veyfBhUArHsoyLpA+EnI20EWEVknLZtJ/l443u3eqXklqeNMJX29aWQ/9ogrqkTQ
1xhGA2zyh7ukaVWN+j/xcfEyy0vbaBIbIlFhu0ejRBBqSqAwZQdm7W6ckTTKFWfl
sMx44JB3a8rJHoppkAK+Qd0r/LPBXprnauMSllrb1Dm69ovj7W8fv1LAoeOyKTPp
YdQtwt11zjj8E+HrbgBAjNa8sckwSSby+g+cbX6d+QAXXZT8zZ/QZD66Z2LOk489
JVNp6vty
=i0HA
-----END PGP SIGNATURE-----

--InGr6/g2cTXTz1WO--
