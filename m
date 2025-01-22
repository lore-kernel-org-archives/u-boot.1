Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61002C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA68680A09;
	Wed, 22 Jan 2025 18:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uTYerOH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A7AF80A30; Wed, 22 Jan 2025 18:22:16 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D057809D4
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:22:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d89a727a19so11862926d6.0
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737566533; x=1738171333; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9yKofRoGqdO/nUSXZazXvLQcEbu7UfFrB1jf0TzE3X8=;
 b=uTYerOH2Wri9AgdWwP+6wpH9GlXk2DPXL234hGDWenyvkhOu9aKH5vgcBqBLOrIuFS
 mw/3SeP6IyDKzTDQRAFKt2kuXXD0ZIz0onSZeiJ4lAgDW7mq9rg6ly/zh4NU4nSZ362Y
 kG9Ot6ilroWGGHLNxz/9CKe3RVAbf/u7WDT6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566533; x=1738171333;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yKofRoGqdO/nUSXZazXvLQcEbu7UfFrB1jf0TzE3X8=;
 b=j/Ju6zwp3QC+ognUK8WgAVJn/v9YDbPuDLdfyCZnuFlgv5u3GaA3AC0NNb4/6HhN3L
 JvqsUKV6NdNG/U6kOSS3CjWIBeT4eGfkkud41aZic0swq92TKddWLImcyLeiw4OvvOFV
 c7EuD2NTLq1YfUh+uosEqThKU2ymEUJc2zMeGQPVvyP5n1e+kPOKrGLGft/7C4YatXB3
 9bXPO2s7J3whohf6mu7E66mGmyoY5UILowaEtw+mt2eNqVy85+bBlbTmnUvn67hjjSRd
 v9JHgE1+0MvGUTVUXGgyBwRCwY+pnYUwbouP24OxCLs9B/ej7kjDEdd3713M7V6Kncd7
 Dmrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmHaDOYqqiV6VjRNpar3GHf7jzdYIAFH8zOniQf2HAVZKlgRT9YuZOVxnwaJ2MG+wjSCS4C+w=@lists.denx.de
X-Gm-Message-State: AOJu0YyhH9IFE9WwXcVP1bwamRR99wtl7KUbelm5RX1z4Hz/SdiGmXW3
 nfW9LA02w8RgW6bhyL015WXggBzzDfIIjzw7Q68DUPZ0MI8Ott4X+f4cWBtr6zM=
X-Gm-Gg: ASbGncsijaI0TxBt/XA9i/ZIRAURZlA47IUYirCzNYr2kDxYmVk35eNEIoKeg8GSjtl
 Ys+Y+wOnBxRtDSpLYm8ax7s+7CLyI2mnQyNkkua9/hyzgMCEJ8BvePQnrqZDIgFBlbPB3HeTbc1
 dFbwGsUGyYYydOATeS7doiqKDm12R2MqEDoemw7/dsQ1SeA/bIAdAg7qGmclSa/KTMjIKEd4KJt
 G1PLmYFiDsAyTQCZ0VMuLScS2cOvZFWgalAlRB+ccVwTwcr03rwY9b50cbetEzt39I=
X-Google-Smtp-Source: AGHT+IH5P8suntTs0eipr2FSJxTnCP6r9jYMdMORtUW4SEudTqEelsk3H8OsWnKu9wKEKnAv2V0Tvg==
X-Received: by 2002:ad4:5cc7:0:b0:6d8:99cf:d2d0 with SMTP id
 6a1803df08f44-6e1f9fd7877mr1378946d6.19.1737566533001; 
 Wed, 22 Jan 2025 09:22:13 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf5e2dsm63243336d6.21.2025.01.22.09.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:22:12 -0800 (PST)
Date: Wed, 22 Jan 2025 11:22:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: sjg@chromium.org, angus@akkea.ca, u-boot@lists.denx.de, vigneshr@ti.com,
 kamlesh@ti.com, d-gole@ti.com, k-malarvizhi@ti.com,
 a-parmar1@ti.com, khasim@ti.com
Subject: Re: [EXTERNAL] Re: Proposal for a New Command to U-Boot Fuse
 Programming
Message-ID: <20250122172209.GN3476@bill-the-cat>
References: <1c2153bc-485f-a0f4-ac0d-fdc29065e235@ti.com>
 <20250106222314.GF3476@bill-the-cat>
 <5e166f95-681a-8a96-0d8c-033c36d47d5a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2E08uc5nt12ko5/k"
Content-Disposition: inline
In-Reply-To: <5e166f95-681a-8a96-0d8c-033c36d47d5a@ti.com>
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


--2E08uc5nt12ko5/k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 11:12:47AM +0530, Harsha Vardhan V M wrote:
>=20
>=20
> On 07/01/25 03:53, Tom Rini wrote:
> > On Mon, Jan 06, 2025 at 12:06:25PM +0530, Harsha Vardhan V M wrote:
> >=20
> > > I would like to propose a new command for U-Boot's fuse programming
> > > functionality to address the challenges posed by the current implemen=
tation.
> > > While the existing fuse prog command works well for programming indiv=
idual
> > > fuse values, it becomes cumbersome especially when dealing with large=
-scale
> > > programming requirements.
> > >=20
> > > Current Command: fuse prog [-y] <bank> <word> <hexval> [<hexval>...]
> > >=20
> > > This command programs one or more fuse words starting from a specific=
 <bank>
> > > and <word> with the hex values given as input.
> > >=20
> > > While functional, it lacks the efficiency and robustness needed for
> > > programming a significant number of fuses or handling structured fuse
> > > configuration data. Repeatedly specifying values for each fuse bank a=
nd word
> > > is not only time-consuming but also prone to errors during manual inp=
ut or
> > > scripting. This approach does not leverage the ability to process
> > > pre-structured data in memory. For users with complex programming nee=
ds, the
> > > current method becomes an obstacle rather than a tool.
> > >=20
> > > Proposed Command: fuse writebuff
> >=20
> > It would be good to provide some documentation links to the fuses that
> > you're wanting to deal with. What we have now works on a number of
> > diverse SoCs, even if for some cases it might be best to write a
> > script that's run rather than copy/paste things live. Any sort of new
> > mechanism needs to get feedback from users at other semiconductor
> > vendors to make sure it's generic enough for everyones needs. Thanks.
> >=20
>=20
> Hi Tom and Simon,
>=20
> The buffer is not a text file. It is a structure in memory. The buffer is
> structured to contain all necessary information for the fuse programming
> process. This can include metadata, fuse programming data etc. The exact
> structure of the buffer can determined by the command_id, which provides
> flexibility for supporting different use cases. The memory buffer is
> typically prepared in user-space code or a script and loaded in memory
> before invoking the fuse writebuff command. It is not stored as a text fi=
le
> or any other file format, as the command operates directly on memory
> addresses.
>=20
> Example of a buffer:
>=20
> struct fuse_buffer {
>     struct fuse_mpkh smpkh;
>     struct fuse_msv msv;
>     struct fuse_key_cnt key_cnt;
>     u8 buffer_hash[64];
> };
>=20
> This fuse_buffer struct will be loaded in memory containing all the
> necessary information for fuse programming.
>=20
> struct fuse_mpkh {
>     u8 mpkh[64]; // public key hash
>     u8 bch[8];
>     u32 attributes; // read-protect, write-protect, override, active flag
>     u32 reserved[2];
> };
> struct fuse_msv {
>     u32 msv_with_bch; //model specific value
>     u32 attributes;
>     u32 reserved[2];
> };
> struct fuse_key_cnt {
>     u32 key_cnt; //key count
>     u32 attributes;
>     u32 reserved[2];
> };
>=20
> -> eFUSE layout is abstract and isn't public as its programming and layout
> itself is security sensitive (it has authentication and decryption keys
> etc). So, fuse prog doesn't work as there is no "banks/offset" here.
> -> Platform Security Core running Secure SW exposes APIs through which th=
ese
> Keys and its attributes can be programmed. Whole content maybe encrypted =
for
> enhanced security on unsecure factory floor.
> -> There is a definite order in which these fields needs to be programmed.
>=20
> Its possible to break the struct into 32bit values and send them across b=
ut
> we would end up with ~30 odd fuse prog cmds which is inefficient and error
> prone.
> It would be hard on secure core to also ensure correctness of operations
> against all sorts of silly errors (such of accidentally skipping a word or
> mess up ordering) which can render Silicon unusable.
>=20
> So passing a opaque pointer with a command_id to Secure core is all that
> fuse cmd needs to do which is what writebuff supports.
>=20
> This can be extended to any vendor; It's just an opaque pointer handoff. I
> see at least one other vendor do it in custom way:
> arch/arm/mach-imx/cmd_dek.c which could benefit from this new cmd fuse
> writebuff.
>=20
> Here=E2=80=99s how the fuse writebuff command works in a typical flow:
> 1. Buffer Preparation: Vendors or developers create a complete buffer (e.=
g.,
> key.bin) containing all fuse programming data using vendor-specific scrip=
ts
> or tools and copied to SD card.
> 2. The buffer is loaded into memory using commands like:
> fatload mmc 1 0x80000000 key.bin
> 3. The fuse writebuff command passes the memory address (0x80000000) and
> command_id to the secure core:
> fuse writebuff <command_id> 0x80000000
> 4. The secure core receives the memory address as a pointer and validates,
> interprets it based on the command_id and then programs the fuses.

To summarize what we talked about on a call, I would like to see either:
1) Work with arch/arm/mach-imx/cmd_dek.c and use that as the base of
some new generic command that deals with SoC-specific fuse
configurations that are handled via security processor.
OR
2) Create a new command (that should be in cmd/ti/) for handling the K3
fuses, if we cannot make something abstract enough to handle this
concept on multiple vendors while having any sort of useful code re-use.

Thanks!

--=20
Tom

--2E08uc5nt12ko5/k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeRKUEACgkQFHw5/5Y0
tyyoDwwApqDryqfre0RBdW+EJnDBlBzzP+rqzwX+8a2HvZ5hlhFKUASDij0tIbw6
9AiRR89+JVoe6o+/7GatphXfQ2Xqt/f4lURNVaYVCl03jK7KO2ieFBxTBpPJtCdp
YnHfIxsTTZnTlhAp5b7dST5n6Jt3vXHlBQUCRbZzuqf48KYilUqiNmjkJ7LtiaPT
a9MS0GtEzNA7KEWvcWVVRq5yuiGkqIoaSEEb1Bsr/w10JO1vvnfZ0hgYd/uku3tv
tJ+6QZ8lJ24x+XRrfPMgPhMmyUQKRwwAgw3rhuhwEHsuWX1FSH0hhaVM4tOY93ds
rqlO0rSOz0mzi0lLxOfVaIUOmurA3X/VybsCyfSlXrr5NujZQ690JIT0eZRQg6cY
odueKQcgHtwCAWnsLso3ALBwZqMAWiGPHB89O3ff11R78I1FKnfxKSn7yzrQO+gR
JX/Za3D5SuUj0hWFVN03DID9lRC82E7wSmljmCZqCrI4fQ52XFJGINSALLi35kD5
3WuEdhYm
=+SI+
-----END PGP SIGNATURE-----

--2E08uc5nt12ko5/k--
