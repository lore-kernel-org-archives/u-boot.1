Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA2EC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 19:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62C080BA4;
	Fri, 24 Jan 2025 20:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V1kLYXn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 701EF80BA6; Fri, 24 Jan 2025 20:30:04 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A2680ADC
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 20:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-467838e75ffso33689331cf.3
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 11:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737747000; x=1738351800; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tuMBcnT+RRdw0gDYCVVd+e7Cjpd+MvhkZ21aaHaoPQ0=;
 b=V1kLYXn/VVAnw+vH+cMBEv0CqYuGWRehPrdWvlqPt7FV4hCI/5C/xQRTKQD8K8L7SV
 j3Jl7yzA0qmE+6NMBls8U/NjKyOQr8o6JvMRNz5FppcrEUvgMeHU31BM5WiwOimxqd2Y
 WCzyHEBYkxngCBex8bH2u9wdbBBANBdwWSSSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737747000; x=1738351800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tuMBcnT+RRdw0gDYCVVd+e7Cjpd+MvhkZ21aaHaoPQ0=;
 b=fDtlXOa113WkxQiykYMWvO6LQI8ejwMNith2RuvxKDcy+D+TVEEKEIqnR6HoDo7AMz
 LTElIBpBBOQXEHkb7xnDJofnQ7rBH+nzR4O8NhUMZjMZOGt8lALH0v7Mgx1au4sQ6mV0
 1ivZNJSlugsn+r4hAUhUmobiTVchMe+9ZW+4NonIKz6DvrwNHks5gpR+e8R3wPzkVOi/
 POuuptYNj9wSfSsjSRk3x2HYtkOIhXnX/xqth+0InrZDWk3kPXsnVBI/u7laGwF/geIu
 Qn1QFoi0TKz9oMdJjo0/o3HMohFCPLhFZLH2sEHd0j/2m5thI1OUzk50f5/xR7oLN2ph
 xpow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmnpuZqmVJC1k/YEhR+jX6Saacy6uBJsN4oV6gIqh47Bl3orB297VTrBDLse8n7LERlXvCxkQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9A6b0uB1j4Otj6kb+mkr9fC8Lp+xqU+2rGBgyduQkvkD4Viwt
 4MfnGY6dWcncG/a4oMRo1BVBu0EwRJMiEkOVq80WGgeaxiJ+yqgF61tuPBYU6kE=
X-Gm-Gg: ASbGncs5W3moOJyjF6LmfBifY5ayEKPEZP2SOI4lEGXUqgxfLP5ZkiA9VLKGW8fpsVL
 2ZmtoY7dy2gf8tHvIEB7DDlOIWSygqFM7lWdvSXxIFG9wkztuNz+xpmcIVTSfqH5QsJKnET2Wy0
 lOYUUqZGUGXwoRsM+sWRrR2BWfPGT/HJRC1u6IaH+MSC2XhnG6LqgGaXhjC8CsspYbwcj6jg1xX
 GvT8CBFyZ3s2a5YOO3kyjXJaXYDj3B4Vd4M9gIJcCmry0fCkE+wO+DSSTBmpiherolFvXa2g08G
 kau8
X-Google-Smtp-Source: AGHT+IE+AEi8EcCMnlIKvHesHuTN6j8RXTDqZrrV0HdNnlNMC+1teMIYVDYEUCIQl64vyIkD5bElJw==
X-Received: by 2002:a05:6214:2261:b0:6d8:8667:c6c2 with SMTP id
 6a1803df08f44-6e1b217e01dmr530335976d6.18.1737747000297; 
 Fri, 24 Jan 2025 11:30:00 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c2164sm11283886d6.99.2025.01.24.11.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 11:29:59 -0800 (PST)
Date: Fri, 24 Jan 2025 13:29:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: sjg@chromium.org, angus@akkea.ca, u-boot@lists.denx.de, vigneshr@ti.com,
 kamlesh@ti.com, d-gole@ti.com, k-malarvizhi@ti.com,
 a-parmar1@ti.com, khasim@ti.com
Subject: Re: [EXTERNAL] Re: Proposal for a New Command to U-Boot Fuse
 Programming
Message-ID: <20250124192956.GV60249@bill-the-cat>
References: <1c2153bc-485f-a0f4-ac0d-fdc29065e235@ti.com>
 <20250106222314.GF3476@bill-the-cat>
 <5e166f95-681a-8a96-0d8c-033c36d47d5a@ti.com>
 <20250122172209.GN3476@bill-the-cat>
 <9cf9590b-e9ba-6d46-dd4d-80a71765e062@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2dn9TeKLjkrrTxDF"
Content-Disposition: inline
In-Reply-To: <9cf9590b-e9ba-6d46-dd4d-80a71765e062@ti.com>
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


--2dn9TeKLjkrrTxDF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 02:31:15PM +0530, Harsha Vardhan V M wrote:
>=20
>=20
> On 22/01/25 22:52, Tom Rini wrote:
> > On Fri, Jan 10, 2025 at 11:12:47AM +0530, Harsha Vardhan V M wrote:
> > >=20
> > >=20
> > > On 07/01/25 03:53, Tom Rini wrote:
> > > > On Mon, Jan 06, 2025 at 12:06:25PM +0530, Harsha Vardhan V M wrote:
> > > >=20
> > > > > I would like to propose a new command for U-Boot's fuse programmi=
ng
> > > > > functionality to address the challenges posed by the current impl=
ementation.
> > > > > While the existing fuse prog command works well for programming i=
ndividual
> > > > > fuse values, it becomes cumbersome especially when dealing with l=
arge-scale
> > > > > programming requirements.
> > > > >=20
> > > > > Current Command: fuse prog [-y] <bank> <word> <hexval> [<hexval>.=
=2E.]
> > > > >=20
> > > > > This command programs one or more fuse words starting from a spec=
ific <bank>
> > > > > and <word> with the hex values given as input.
> > > > >=20
> > > > > While functional, it lacks the efficiency and robustness needed f=
or
> > > > > programming a significant number of fuses or handling structured =
fuse
> > > > > configuration data. Repeatedly specifying values for each fuse ba=
nk and word
> > > > > is not only time-consuming but also prone to errors during manual=
 input or
> > > > > scripting. This approach does not leverage the ability to process
> > > > > pre-structured data in memory. For users with complex programming=
 needs, the
> > > > > current method becomes an obstacle rather than a tool.
> > > > >=20
> > > > > Proposed Command: fuse writebuff
> > > >=20
> > > > It would be good to provide some documentation links to the fuses t=
hat
> > > > you're wanting to deal with. What we have now works on a number of
> > > > diverse SoCs, even if for some cases it might be best to write a
> > > > script that's run rather than copy/paste things live. Any sort of n=
ew
> > > > mechanism needs to get feedback from users at other semiconductor
> > > > vendors to make sure it's generic enough for everyones needs. Thank=
s.
> > > >=20
> > >=20
> > > Hi Tom and Simon,
> > >=20
> > > The buffer is not a text file. It is a structure in memory. The buffe=
r is
> > > structured to contain all necessary information for the fuse programm=
ing
> > > process. This can include metadata, fuse programming data etc. The ex=
act
> > > structure of the buffer can determined by the command_id, which provi=
des
> > > flexibility for supporting different use cases. The memory buffer is
> > > typically prepared in user-space code or a script and loaded in memory
> > > before invoking the fuse writebuff command. It is not stored as a tex=
t file
> > > or any other file format, as the command operates directly on memory
> > > addresses.
> > >=20
> > > Example of a buffer:
> > >=20
> > > struct fuse_buffer {
> > >      struct fuse_mpkh smpkh;
> > >      struct fuse_msv msv;
> > >      struct fuse_key_cnt key_cnt;
> > >      u8 buffer_hash[64];
> > > };
> > >=20
> > > This fuse_buffer struct will be loaded in memory containing all the
> > > necessary information for fuse programming.
> > >=20
> > > struct fuse_mpkh {
> > >      u8 mpkh[64]; // public key hash
> > >      u8 bch[8];
> > >      u32 attributes; // read-protect, write-protect, override, active=
 flag
> > >      u32 reserved[2];
> > > };
> > > struct fuse_msv {
> > >      u32 msv_with_bch; //model specific value
> > >      u32 attributes;
> > >      u32 reserved[2];
> > > };
> > > struct fuse_key_cnt {
> > >      u32 key_cnt; //key count
> > >      u32 attributes;
> > >      u32 reserved[2];
> > > };
> > >=20
> > > -> eFUSE layout is abstract and isn't public as its programming and l=
ayout
> > > itself is security sensitive (it has authentication and decryption ke=
ys
> > > etc). So, fuse prog doesn't work as there is no "banks/offset" here.
> > > -> Platform Security Core running Secure SW exposes APIs through whic=
h these
> > > Keys and its attributes can be programmed. Whole content maybe encryp=
ted for
> > > enhanced security on unsecure factory floor.
> > > -> There is a definite order in which these fields needs to be progra=
mmed.
> > >=20
> > > Its possible to break the struct into 32bit values and send them acro=
ss but
> > > we would end up with ~30 odd fuse prog cmds which is inefficient and =
error
> > > prone.
> > > It would be hard on secure core to also ensure correctness of operati=
ons
> > > against all sorts of silly errors (such of accidentally skipping a wo=
rd or
> > > mess up ordering) which can render Silicon unusable.
> > >=20
> > > So passing a opaque pointer with a command_id to Secure core is all t=
hat
> > > fuse cmd needs to do which is what writebuff supports.
> > >=20
> > > This can be extended to any vendor; It's just an opaque pointer hando=
ff. I
> > > see at least one other vendor do it in custom way:
> > > arch/arm/mach-imx/cmd_dek.c which could benefit from this new cmd fuse
> > > writebuff.
> > >=20
> > > Here=E2=80=99s how the fuse writebuff command works in a typical flow:
> > > 1. Buffer Preparation: Vendors or developers create a complete buffer=
 (e.g.,
> > > key.bin) containing all fuse programming data using vendor-specific s=
cripts
> > > or tools and copied to SD card.
> > > 2. The buffer is loaded into memory using commands like:
> > > fatload mmc 1 0x80000000 key.bin
> > > 3. The fuse writebuff command passes the memory address (0x80000000) =
and
> > > command_id to the secure core:
> > > fuse writebuff <command_id> 0x80000000
> > > 4. The secure core receives the memory address as a pointer and valid=
ates,
> > > interprets it based on the command_id and then programs the fuses.
> >=20
> > To summarize what we talked about on a call, I would like to see either:
> > 1) Work with arch/arm/mach-imx/cmd_dek.c and use that as the base of
> > some new generic command that deals with SoC-specific fuse
> > configurations that are handled via security processor.
> Hi Tom,
>=20
> 1) I have looked at arch/arm/mach-imx/cmd_dek.c. The underlying
> implementation data structure is very specific to the vendor and how iMX
> devices are configured. The other vendors would also differ in their
> structures and SoC-specific fuse configurations, so I don't see a way to =
use
> this cmd_dek.c as the base and then abstract, create a new command out of
> it.
>=20
> > OR
> > 2) Create a new command (that should be in cmd/ti/) for handling the K3
> > fuses, if we cannot make something abstract enough to handle this
> > concept on multiple vendors while having any sort of useful code re-use.
>=20
> 2) In this case, I would like to add the fuse writebuff command for TI=E2=
=80=99s K3
> architecture in cmd/ti/k3_fuse.c. And the command will look like
>=20
> fuse writebuff <command_id> <addr>
>=20
> However, I would still like to place the fuse writebuff command in
> cmd/fuse.c as a generic interface because the parameters command_id and an
> opaque pointer handoff provides a mechanism for the secure core to interp=
ret
> buffers differently based on vendor or use case.

This I guess is my confusion. If we can't abstract cmd_dek.c and the
underlying i.MX specific parts to be supported in "fuse writebuff ..."
what is the non-K3 (or better still, non-TI) abstraction for what you're
proposing?

--=20
Tom

--2dn9TeKLjkrrTxDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeT6jQACgkQFHw5/5Y0
tywQDQv+K0Fv2nF60EX+5oCPW954Fe/KHJpIwZ28kcWnvRUZmq13KjTsTg9PJTPs
Q3vw4sm3rFuRRSH+zxNW8JvAoKaqNj6sMJyLoR1mEe7iz71jmMfamSIuSN3wuOas
Xvkwl2sB0E6krYx7ZR2AZtf9fNguMid+ifLrQ3U+y3a74NcYCn1GrX8ddDc2UkHz
JhGlxsdrKWD5h5HaiJQm9PDTYJ+ul5YcHs1kjHU0Mbb5Tb/nBwSGUeH+YoPsDUHu
hvayYb4n5UGNn/gcNnHw5geMEdHP/bajv1mH3h4xV847ajUA3Qpq1+HdZUrqJi7N
MOsCYjZduYz+o5LoTTNkkYb+umCeoidYN4mxkbvDLtyG7D2RHeD4hGp+Pw7xjfm7
YwTeZw/cthvfwR6GP14GMAUjZWwfDyCeUJbt064DU5IwMns/i3+CbhLKZV9lxizo
S8Tp0TlzRqM16MJoegEWs71jepIansoI+eCk1Ja5kvLvDdbneSGP7vjQWxFX19oI
b2dfppgU
=9mzD
-----END PGP SIGNATURE-----

--2dn9TeKLjkrrTxDF--
