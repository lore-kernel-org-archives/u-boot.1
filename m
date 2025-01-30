Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C9FC0218F
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 17:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AD5D80EC1;
	Thu, 30 Jan 2025 18:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QDqc21S5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9AF6820F6; Thu, 30 Jan 2025 18:01:40 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64682807A8
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 18:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3eb98ad8caaso619830b6e.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738256497; x=1738861297; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oX6Pp2sEkvBjnr4iFjJdl1F6X964eUClC5lQCVB1l/w=;
 b=QDqc21S59ENNjKUWRzl0IZTtWY5hQqKQJN64aga8bGs0wli/JToqgDQn980I8nR5qV
 UheqcbOksAq4wIoMkAR+x/YCsnhn8T1rWThzD3w4GvgUWWOSzqAsNzfRMyVZ+ZsS6J+4
 YtcmLfPDUouilX8ZndJ2nQgim+sHnCCEaE2B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738256497; x=1738861297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oX6Pp2sEkvBjnr4iFjJdl1F6X964eUClC5lQCVB1l/w=;
 b=cEc29uxmhEtTFLVUie9bQgsd4gjxhsttq1XPIr4EbAdigdBz894CJezWpsU1CwbalJ
 H540EW27keseJ8IMTrzr0T9swDmHxmZGZiOj6r86FSfh6ASjRs53vVdqNusxbYb1CFnD
 +yTrip9v21q2nYkhCvnZ5gpuAWkVgh80QK7GBxqQff9vdtj+8OXkMlI7WYFqH8MJQe52
 n3j8QHdNQOGUBj6WxWlo5Zjb/bYm25t0mh1MQzziQXSJbg0ivY0KFkEoRWtAVH3BdqrA
 2UxGY6k6z6FF+AHwBnixkvOsH98LpwxX5T3ZfcmaM2sWTAXYE87xJIeLGU226wf41m2K
 aW7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD0n8vY84TslyfzHVZXb4KTDT/IvOfsfKuBqRBjK8VJCh7l+AhpWV5Dk1hXaDhCiHviXdR9oM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7TOQsTBLHs9RxsBjku0bf4fGwavFrIpXeJHvk9PE2MdbEW3+l
 dqVO2J8bBkTsbdHIwazwcMyBFuS+xh2+eNW3LA/Ct3fZtvBMMHq1BYmHLVihQmM=
X-Gm-Gg: ASbGncv2tK23p/s8fEEG82xYpEgrBi45WkIkSWlZBs5l7UI/BJPEYn6GEnT/4Y1Xtql
 9l+oc67lFjB9hkyiIrv10MmbhxG5nnwPiOe6M5tmHdePAKiOT2vFyDnBzmoBbJK/G+nbIxSkAf0
 abwd1ADMUNuid4bQiYvqM592SYpyzxdqkUSQZJ35EjSZz/H+PgBtoLnatNqUDiU3mbadn6tQ9n1
 BfeJDXfNCNou7TuZ8f6PlFaap3eTR0PlSVO7z+qA8kuD7P+CWM2CNPibYQR7DX9YvCOcVOLYeNL
 6hVMCcCCzgyhpDs=
X-Google-Smtp-Source: AGHT+IH+zMYTi6nV6OOr/Njw/ggMHbeE7E5FWsAG9uHofYjWV0QPr02nLYU+uiMnVwkwJQJycIgG4Q==
X-Received: by 2002:a05:6808:3c44:b0:3eb:5160:f855 with SMTP id
 5614622812f47-3f3239ecc70mr4975807b6e.5.1738256497005; 
 Thu, 30 Jan 2025 09:01:37 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f33365bf31sm327885b6e.34.2025.01.30.09.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 09:01:35 -0800 (PST)
Date: Thu, 30 Jan 2025 11:01:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: sjg@chromium.org, angus@akkea.ca, u-boot@lists.denx.de, vigneshr@ti.com,
 kamlesh@ti.com, d-gole@ti.com, k-malarvizhi@ti.com,
 a-parmar1@ti.com, khasim@ti.com
Subject: Re: [EXTERNAL] Re: Proposal for a New Command to U-Boot Fuse
 Programming
Message-ID: <20250130170133.GE1233568@bill-the-cat>
References: <1c2153bc-485f-a0f4-ac0d-fdc29065e235@ti.com>
 <20250106222314.GF3476@bill-the-cat>
 <5e166f95-681a-8a96-0d8c-033c36d47d5a@ti.com>
 <20250122172209.GN3476@bill-the-cat>
 <9cf9590b-e9ba-6d46-dd4d-80a71765e062@ti.com>
 <20250124192956.GV60249@bill-the-cat>
 <7be0605f-b986-ca34-4b83-7338329afac4@ti.com>
 <20250128222232.GS1233568@bill-the-cat>
 <147c0bcc-e025-461d-88d8-59a39832ff90@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JFuHKRkYQxKRip4e"
Content-Disposition: inline
In-Reply-To: <147c0bcc-e025-461d-88d8-59a39832ff90@ti.com>
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


--JFuHKRkYQxKRip4e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 02:06:07PM +0530, Harsha Vardhan V M wrote:
>=20
>=20
> On 29/01/25 03:52, Tom Rini wrote:
> > On Mon, Jan 27, 2025 at 04:22:36PM +0530, Harsha Vardhan V M wrote:
> > >=20
> > >=20
> > > On 25/01/25 00:59, Tom Rini wrote:
> > > > On Fri, Jan 24, 2025 at 02:31:15PM +0530, Harsha Vardhan V M wrote:
> > > > >=20
> > > > >=20
> > > > > On 22/01/25 22:52, Tom Rini wrote:
> > > > > > On Fri, Jan 10, 2025 at 11:12:47AM +0530, Harsha Vardhan V M wr=
ote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > On 07/01/25 03:53, Tom Rini wrote:
> > > > > > > > On Mon, Jan 06, 2025 at 12:06:25PM +0530, Harsha Vardhan V =
M wrote:
> > > > > > > >=20
> > > > > > > > > I would like to propose a new command for U-Boot's fuse p=
rogramming
> > > > > > > > > functionality to address the challenges posed by the curr=
ent implementation.
> > > > > > > > > While the existing fuse prog command works well for progr=
amming individual
> > > > > > > > > fuse values, it becomes cumbersome especially when dealin=
g with large-scale
> > > > > > > > > programming requirements.
> > > > > > > > >=20
> > > > > > > > > Current Command: fuse prog [-y] <bank> <word> <hexval> [<=
hexval>...]
> > > > > > > > >=20
> > > > > > > > > This command programs one or more fuse words starting fro=
m a specific <bank>
> > > > > > > > > and <word> with the hex values given as input.
> > > > > > > > >=20
> > > > > > > > > While functional, it lacks the efficiency and robustness =
needed for
> > > > > > > > > programming a significant number of fuses or handling str=
uctured fuse
> > > > > > > > > configuration data. Repeatedly specifying values for each=
 fuse bank and word
> > > > > > > > > is not only time-consuming but also prone to errors durin=
g manual input or
> > > > > > > > > scripting. This approach does not leverage the ability to=
 process
> > > > > > > > > pre-structured data in memory. For users with complex pro=
gramming needs, the
> > > > > > > > > current method becomes an obstacle rather than a tool.
> > > > > > > > >=20
> > > > > > > > > Proposed Command: fuse writebuff
> > > > > > > >=20
> > > > > > > > It would be good to provide some documentation links to the=
 fuses that
> > > > > > > > you're wanting to deal with. What we have now works on a nu=
mber of
> > > > > > > > diverse SoCs, even if for some cases it might be best to wr=
ite a
> > > > > > > > script that's run rather than copy/paste things live. Any s=
ort of new
> > > > > > > > mechanism needs to get feedback from users at other semicon=
ductor
> > > > > > > > vendors to make sure it's generic enough for everyones need=
s. Thanks.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Hi Tom and Simon,
> > > > > > >=20
> > > > > > > The buffer is not a text file. It is a structure in memory. T=
he buffer is
> > > > > > > structured to contain all necessary information for the fuse =
programming
> > > > > > > process. This can include metadata, fuse programming data etc=
=2E The exact
> > > > > > > structure of the buffer can determined by the command_id, whi=
ch provides
> > > > > > > flexibility for supporting different use cases. The memory bu=
ffer is
> > > > > > > typically prepared in user-space code or a script and loaded =
in memory
> > > > > > > before invoking the fuse writebuff command. It is not stored =
as a text file
> > > > > > > or any other file format, as the command operates directly on=
 memory
> > > > > > > addresses.
> > > > > > >=20
> > > > > > > Example of a buffer:
> > > > > > >=20
> > > > > > > struct fuse_buffer {
> > > > > > >        struct fuse_mpkh smpkh;
> > > > > > >        struct fuse_msv msv;
> > > > > > >        struct fuse_key_cnt key_cnt;
> > > > > > >        u8 buffer_hash[64];
> > > > > > > };
> > > > > > >=20
> > > > > > > This fuse_buffer struct will be loaded in memory containing a=
ll the
> > > > > > > necessary information for fuse programming.
> > > > > > >=20
> > > > > > > struct fuse_mpkh {
> > > > > > >        u8 mpkh[64]; // public key hash
> > > > > > >        u8 bch[8];
> > > > > > >        u32 attributes; // read-protect, write-protect, overri=
de, active flag
> > > > > > >        u32 reserved[2];
> > > > > > > };
> > > > > > > struct fuse_msv {
> > > > > > >        u32 msv_with_bch; //model specific value
> > > > > > >        u32 attributes;
> > > > > > >        u32 reserved[2];
> > > > > > > };
> > > > > > > struct fuse_key_cnt {
> > > > > > >        u32 key_cnt; //key count
> > > > > > >        u32 attributes;
> > > > > > >        u32 reserved[2];
> > > > > > > };
> > > > > > >=20
> > > > > > > -> eFUSE layout is abstract and isn't public as its programmi=
ng and layout
> > > > > > > itself is security sensitive (it has authentication and decry=
ption keys
> > > > > > > etc). So, fuse prog doesn't work as there is no "banks/offset=
" here.
> > > > > > > -> Platform Security Core running Secure SW exposes APIs thro=
ugh which these
> > > > > > > Keys and its attributes can be programmed. Whole content mayb=
e encrypted for
> > > > > > > enhanced security on unsecure factory floor.
> > > > > > > -> There is a definite order in which these fields needs to b=
e programmed.
> > > > > > >=20
> > > > > > > Its possible to break the struct into 32bit values and send t=
hem across but
> > > > > > > we would end up with ~30 odd fuse prog cmds which is ineffici=
ent and error
> > > > > > > prone.
> > > > > > > It would be hard on secure core to also ensure correctness of=
 operations
> > > > > > > against all sorts of silly errors (such of accidentally skipp=
ing a word or
> > > > > > > mess up ordering) which can render Silicon unusable.
> > > > > > >=20
> > > > > > > So passing a opaque pointer with a command_id to Secure core =
is all that
> > > > > > > fuse cmd needs to do which is what writebuff supports.
> > > > > > >=20
> > > > > > > This can be extended to any vendor; It's just an opaque point=
er handoff. I
> > > > > > > see at least one other vendor do it in custom way:
> > > > > > > arch/arm/mach-imx/cmd_dek.c which could benefit from this new=
 cmd fuse
> > > > > > > writebuff.
> > > > > > >=20
> > > > > > > Here=E2=80=99s how the fuse writebuff command works in a typi=
cal flow:
> > > > > > > 1. Buffer Preparation: Vendors or developers create a complet=
e buffer (e.g.,
> > > > > > > key.bin) containing all fuse programming data using vendor-sp=
ecific scripts
> > > > > > > or tools and copied to SD card.
> > > > > > > 2. The buffer is loaded into memory using commands like:
> > > > > > > fatload mmc 1 0x80000000 key.bin
> > > > > > > 3. The fuse writebuff command passes the memory address (0x80=
000000) and
> > > > > > > command_id to the secure core:
> > > > > > > fuse writebuff <command_id> 0x80000000
> > > > > > > 4. The secure core receives the memory address as a pointer a=
nd validates,
> > > > > > > interprets it based on the command_id and then programs the f=
uses.
> > > > > >=20
> > > > > > To summarize what we talked about on a call, I would like to se=
e either:
> > > > > > 1) Work with arch/arm/mach-imx/cmd_dek.c and use that as the ba=
se of
> > > > > > some new generic command that deals with SoC-specific fuse
> > > > > > configurations that are handled via security processor.
> > > > > Hi Tom,
> > > > >=20
> > > > > 1) I have looked at arch/arm/mach-imx/cmd_dek.c. The underlying
> > > > > implementation data structure is very specific to the vendor and =
how iMX
> > > > > devices are configured. The other vendors would also differ in th=
eir
> > > > > structures and SoC-specific fuse configurations, so I don't see a=
 way to use
> > > > > this cmd_dek.c as the base and then abstract, create a new comman=
d out of
> > > > > it.
> > > > >=20
> > > > > > OR
> > > > > > 2) Create a new command (that should be in cmd/ti/) for handlin=
g the K3
> > > > > > fuses, if we cannot make something abstract enough to handle th=
is
> > > > > > concept on multiple vendors while having any sort of useful cod=
e re-use.
> > > > >=20
> > > > > 2) In this case, I would like to add the fuse writebuff command f=
or TI=E2=80=99s K3
> > > > > architecture in cmd/ti/k3_fuse.c. And the command will look like
> > > > >=20
> > > > > fuse writebuff <command_id> <addr>
> > > > >=20
> > > > > However, I would still like to place the fuse writebuff command in
> > > > > cmd/fuse.c as a generic interface because the parameters command_=
id and an
> > > > > opaque pointer handoff provides a mechanism for the secure core t=
o interpret
> > > > > buffers differently based on vendor or use case.
> > > >=20
> > > > This I guess is my confusion. If we can't abstract cmd_dek.c and the
> > > > underlying i.MX specific parts to be supported in "fuse writebuff .=
=2E."
> > > > what is the non-K3 (or better still, non-TI) abstraction for what y=
ou're
> > > > proposing?
> > > >=20
> > > Hi Tom,
> > > There are two types of fuse programming flows;
> > > a) Where the fuse layout is known to U-Boot -> fuse cmd options suppo=
rt this
> > > flow today
> > > b) Where fuse cmd is abstracted from U-Boot -> needs a co-processor t=
o proxy
> > > the programming
> > >=20
> > > For b) the fuse layout is virtualized via a "vendor-specific" structu=
re
> > > which is generated offline (typically with GUI tools) and then loaded=
 to
> > > memory from a file on SD card . This pointer would then be relayed to=
 Co
> > > processor as a IPC call...
> > >=20
> > > So, whats common b/w cmd_dek.c and TI's fuse cmd -> loading opaque st=
ruct to
> > > memory and then passing it to Secure co-processor along with one or m=
ore
> > > command identifiers which will serve as hint for such secure co-proce=
ssor.
> > > "fuse writebuff" tries to abstract essentially this: take a cmd_id an=
d file
> > > pointer from fuse cmd and pass to it Vendor specific backend. I know =
its not
> > > a lot but frontend tools used to flash the devices can still make the=
 most
> > > of it with simple vendor neutral abstractions than needing to know cu=
stom
> > > command for each vendor.
> > >=20
> > > What cannot be abstracted is:
> > > a) struct of the file,
> > > b) common definition of command Id
> > > c) IPC mechanisms
> > >=20
> > > Unfortunately all the above 3 are tightly coupled to co-processor on =
the
> > > other end which most likely is immutable for most SoCs...
> >=20
> > So what I'm missing is why we can't have "fusebuf" as the top level
> > command, or "fuse writebuf <vendor> <address>" and then yes, leave the
> > vendor specific parts to each vendor to implement?
> >=20
>=20
> Hi Tom,
>=20
> The "fuse writebuff <vendor> <address>" option sounds good to me. I'd like
> to understand how you are envisioning the <vendor> parameter to be used in
> this context and how the backend should handle it. Would appreciate your
> thoughts on this.

Probably <vendor> should be a string, and based on that call the
appropriate SoC handler.

--=20
Tom

--JFuHKRkYQxKRip4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebsG0ACgkQFHw5/5Y0
tyzVxwwAiksLeXbasCRS41WUYg5yR/FlSu4z0O+TdMT4fR0s5f7DJzTifD/y17VR
DWzZ76TZv+qOHTPVNfXw7K0zrnRzTkF8qNKPWNf+aWgYCF3sWnd/kyAy9jORVCsF
D5qc+htP+C7+CGyP8cyBqqy9HqgwDWqfVTB/iMDo50MJ5v/RqB48cfo0U66nUpP5
e1WTpGSC4Yw9UvCgnO6r4PLwJ3/X+sqMvG9ERKsOexU+DW71z22/vatrQWEjcF35
F4OYYCpNrSutCQCe/J1wU+n+vtPEa3LosXb7PkuMJo4YC/oqCn6cHplEVaKgzUcq
PffmeckZVzDqjLMCjIgRst0hxicXyQJkkE6fFjbw6kVufzjzRd0gwz9uQj38ed/z
nEbmaq2yJGfK7vhQvdmigJao4ZLUuNguWYo9ZnjqibsHLNWIxjWpgr49hWq77SUT
LAbXdq8CBD6477zVmF5ukknOg/cDyR2x/ZqX9XsI8akCYTIdD/HeoFYDcaMsH/wV
pc0+sLau
=vSVn
-----END PGP SIGNATURE-----

--JFuHKRkYQxKRip4e--
