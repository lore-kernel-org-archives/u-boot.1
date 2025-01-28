Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F52C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 22:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 215A080EEF;
	Tue, 28 Jan 2025 23:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c7Aqe8gp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D71C812BB; Tue, 28 Jan 2025 23:22:40 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B7E807B3
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 23:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7bcf32a6582so560089985a.1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 14:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738102956; x=1738707756; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Eieay1SafOse+2EOhPCJN+DUUkSmT3VV/EN7kuu86g8=;
 b=c7Aqe8gp1K1ggDXuYmMXl4RWgSrPGvT9jfmFxnhx3sqCoyPGDcdKsLsM0E4YKsqQ/n
 YsolmFr1B5T/wfDNnoP6zCnC27tC/dIuTZGpZgdf0rX57k3OQYQL+3gen9lw7i29MSAg
 9XfGr7HfS8C6N8Yms0Z6NifcNJ/hxbBqRJ/fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738102956; x=1738707756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eieay1SafOse+2EOhPCJN+DUUkSmT3VV/EN7kuu86g8=;
 b=VRuAKTv3Kt8XG/C/RIT33l1jfu988L7FTbm0iKfKIjPTvFn+oQdz2Am3Pzvz2vvOvD
 HCuKyDEHnzF5OapCDKP50K0n3tn9yov4j+Fo3hr9NBEojvNh53C1Rv9UKgpN/NgzAAcz
 lx0/tU3tCVh7Wja/+vdPbGaALwHrDfShgPA/s9zGMnqMTCJm1IzFQzfNnVxU+Iowv2d4
 LsJ+FH6AQ+CANEqFjnAJMSkrXoDyO8/6FC/nsaZfFQy0Hsc+Ea7Io+JD4qe3/MRWLqTc
 mK8vbbX+4HH1q+NcGKVV6XLlDsb3HCZ4Lpv9F5pS8P+XRIDgCrcc7OA/mWdZf8iaWpGg
 r12A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa1XHgalRs3OCQbHcF+WwUf69wmgxmoPtNoxH/LlkRJ5PC5U0UeahpRY3xMLpWUaQJDTsIVRk=@lists.denx.de
X-Gm-Message-State: AOJu0YxTxx9swWyw0knhmOo6XJk3zPmsDrnr/u/CBmRFY1saPA5kREFx
 OOtj+sTNZ0fJX7jglTgUuLw6RftPjPuZY9vWfmVEL5WALVhVX7ekxGucxvovKb8=
X-Gm-Gg: ASbGncs0EpNCKl7Rv+beL5OZPuWWk+VQ5jJs7OFRPwyXfY8Q9Gos35uVNz2zp4YXRNF
 xytumK8YLTBkisuK3xNQbk4b53CXcK3307uQ5ylRD71a+yFoB04imBY4bfbqT6N8eFGzTbQqDpR
 /1gRZSP+Jxyhc1rE+SR0aE/VlOIReCr3a8c0F5+IObymVC+O9/TnjZFwrQIdrkt1V9iwWKVtEh9
 fUcEEMW/Z/Qn4yFtvPgILVdMbjrTTX5eM1D9vC5MVGbSQV8iqiQNzjZIR+leF7m6HaYg1s4nGMI
 Agn301G0mzRPHno=
X-Google-Smtp-Source: AGHT+IGG1y7ZuI53pky5wsCGVzhy9tGn3k1VWKeM3QJvDzgf/NfFNrgrYHp/f9cGIZkkl/SGV8HSiw==
X-Received: by 2002:a05:620a:3190:b0:7b6:d6cb:8b99 with SMTP id
 af79cd13be357-7bffcc3ce05mr88494285a.0.1738102956461; 
 Tue, 28 Jan 2025 14:22:36 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae7ece0sm562169685a.8.2025.01.28.14.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 14:22:35 -0800 (PST)
Date: Tue, 28 Jan 2025 16:22:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: sjg@chromium.org, angus@akkea.ca, u-boot@lists.denx.de, vigneshr@ti.com,
 kamlesh@ti.com, d-gole@ti.com, k-malarvizhi@ti.com,
 a-parmar1@ti.com, khasim@ti.com
Subject: Re: [EXTERNAL] Re: Proposal for a New Command to U-Boot Fuse
 Programming
Message-ID: <20250128222232.GS1233568@bill-the-cat>
References: <1c2153bc-485f-a0f4-ac0d-fdc29065e235@ti.com>
 <20250106222314.GF3476@bill-the-cat>
 <5e166f95-681a-8a96-0d8c-033c36d47d5a@ti.com>
 <20250122172209.GN3476@bill-the-cat>
 <9cf9590b-e9ba-6d46-dd4d-80a71765e062@ti.com>
 <20250124192956.GV60249@bill-the-cat>
 <7be0605f-b986-ca34-4b83-7338329afac4@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0efruAi/E/giCnp9"
Content-Disposition: inline
In-Reply-To: <7be0605f-b986-ca34-4b83-7338329afac4@ti.com>
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


--0efruAi/E/giCnp9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 04:22:36PM +0530, Harsha Vardhan V M wrote:
>=20
>=20
> On 25/01/25 00:59, Tom Rini wrote:
> > On Fri, Jan 24, 2025 at 02:31:15PM +0530, Harsha Vardhan V M wrote:
> > >=20
> > >=20
> > > On 22/01/25 22:52, Tom Rini wrote:
> > > > On Fri, Jan 10, 2025 at 11:12:47AM +0530, Harsha Vardhan V M wrote:
> > > > >=20
> > > > >=20
> > > > > On 07/01/25 03:53, Tom Rini wrote:
> > > > > > On Mon, Jan 06, 2025 at 12:06:25PM +0530, Harsha Vardhan V M wr=
ote:
> > > > > >=20
> > > > > > > I would like to propose a new command for U-Boot's fuse progr=
amming
> > > > > > > functionality to address the challenges posed by the current =
implementation.
> > > > > > > While the existing fuse prog command works well for programmi=
ng individual
> > > > > > > fuse values, it becomes cumbersome especially when dealing wi=
th large-scale
> > > > > > > programming requirements.
> > > > > > >=20
> > > > > > > Current Command: fuse prog [-y] <bank> <word> <hexval> [<hexv=
al>...]
> > > > > > >=20
> > > > > > > This command programs one or more fuse words starting from a =
specific <bank>
> > > > > > > and <word> with the hex values given as input.
> > > > > > >=20
> > > > > > > While functional, it lacks the efficiency and robustness need=
ed for
> > > > > > > programming a significant number of fuses or handling structu=
red fuse
> > > > > > > configuration data. Repeatedly specifying values for each fus=
e bank and word
> > > > > > > is not only time-consuming but also prone to errors during ma=
nual input or
> > > > > > > scripting. This approach does not leverage the ability to pro=
cess
> > > > > > > pre-structured data in memory. For users with complex program=
ming needs, the
> > > > > > > current method becomes an obstacle rather than a tool.
> > > > > > >=20
> > > > > > > Proposed Command: fuse writebuff
> > > > > >=20
> > > > > > It would be good to provide some documentation links to the fus=
es that
> > > > > > you're wanting to deal with. What we have now works on a number=
 of
> > > > > > diverse SoCs, even if for some cases it might be best to write a
> > > > > > script that's run rather than copy/paste things live. Any sort =
of new
> > > > > > mechanism needs to get feedback from users at other semiconduct=
or
> > > > > > vendors to make sure it's generic enough for everyones needs. T=
hanks.
> > > > > >=20
> > > > >=20
> > > > > Hi Tom and Simon,
> > > > >=20
> > > > > The buffer is not a text file. It is a structure in memory. The b=
uffer is
> > > > > structured to contain all necessary information for the fuse prog=
ramming
> > > > > process. This can include metadata, fuse programming data etc. Th=
e exact
> > > > > structure of the buffer can determined by the command_id, which p=
rovides
> > > > > flexibility for supporting different use cases. The memory buffer=
 is
> > > > > typically prepared in user-space code or a script and loaded in m=
emory
> > > > > before invoking the fuse writebuff command. It is not stored as a=
 text file
> > > > > or any other file format, as the command operates directly on mem=
ory
> > > > > addresses.
> > > > >=20
> > > > > Example of a buffer:
> > > > >=20
> > > > > struct fuse_buffer {
> > > > >       struct fuse_mpkh smpkh;
> > > > >       struct fuse_msv msv;
> > > > >       struct fuse_key_cnt key_cnt;
> > > > >       u8 buffer_hash[64];
> > > > > };
> > > > >=20
> > > > > This fuse_buffer struct will be loaded in memory containing all t=
he
> > > > > necessary information for fuse programming.
> > > > >=20
> > > > > struct fuse_mpkh {
> > > > >       u8 mpkh[64]; // public key hash
> > > > >       u8 bch[8];
> > > > >       u32 attributes; // read-protect, write-protect, override, a=
ctive flag
> > > > >       u32 reserved[2];
> > > > > };
> > > > > struct fuse_msv {
> > > > >       u32 msv_with_bch; //model specific value
> > > > >       u32 attributes;
> > > > >       u32 reserved[2];
> > > > > };
> > > > > struct fuse_key_cnt {
> > > > >       u32 key_cnt; //key count
> > > > >       u32 attributes;
> > > > >       u32 reserved[2];
> > > > > };
> > > > >=20
> > > > > -> eFUSE layout is abstract and isn't public as its programming a=
nd layout
> > > > > itself is security sensitive (it has authentication and decryptio=
n keys
> > > > > etc). So, fuse prog doesn't work as there is no "banks/offset" he=
re.
> > > > > -> Platform Security Core running Secure SW exposes APIs through =
which these
> > > > > Keys and its attributes can be programmed. Whole content maybe en=
crypted for
> > > > > enhanced security on unsecure factory floor.
> > > > > -> There is a definite order in which these fields needs to be pr=
ogrammed.
> > > > >=20
> > > > > Its possible to break the struct into 32bit values and send them =
across but
> > > > > we would end up with ~30 odd fuse prog cmds which is inefficient =
and error
> > > > > prone.
> > > > > It would be hard on secure core to also ensure correctness of ope=
rations
> > > > > against all sorts of silly errors (such of accidentally skipping =
a word or
> > > > > mess up ordering) which can render Silicon unusable.
> > > > >=20
> > > > > So passing a opaque pointer with a command_id to Secure core is a=
ll that
> > > > > fuse cmd needs to do which is what writebuff supports.
> > > > >=20
> > > > > This can be extended to any vendor; It's just an opaque pointer h=
andoff. I
> > > > > see at least one other vendor do it in custom way:
> > > > > arch/arm/mach-imx/cmd_dek.c which could benefit from this new cmd=
 fuse
> > > > > writebuff.
> > > > >=20
> > > > > Here=E2=80=99s how the fuse writebuff command works in a typical =
flow:
> > > > > 1. Buffer Preparation: Vendors or developers create a complete bu=
ffer (e.g.,
> > > > > key.bin) containing all fuse programming data using vendor-specif=
ic scripts
> > > > > or tools and copied to SD card.
> > > > > 2. The buffer is loaded into memory using commands like:
> > > > > fatload mmc 1 0x80000000 key.bin
> > > > > 3. The fuse writebuff command passes the memory address (0x800000=
00) and
> > > > > command_id to the secure core:
> > > > > fuse writebuff <command_id> 0x80000000
> > > > > 4. The secure core receives the memory address as a pointer and v=
alidates,
> > > > > interprets it based on the command_id and then programs the fuses.
> > > >=20
> > > > To summarize what we talked about on a call, I would like to see ei=
ther:
> > > > 1) Work with arch/arm/mach-imx/cmd_dek.c and use that as the base of
> > > > some new generic command that deals with SoC-specific fuse
> > > > configurations that are handled via security processor.
> > > Hi Tom,
> > >=20
> > > 1) I have looked at arch/arm/mach-imx/cmd_dek.c. The underlying
> > > implementation data structure is very specific to the vendor and how =
iMX
> > > devices are configured. The other vendors would also differ in their
> > > structures and SoC-specific fuse configurations, so I don't see a way=
 to use
> > > this cmd_dek.c as the base and then abstract, create a new command ou=
t of
> > > it.
> > >=20
> > > > OR
> > > > 2) Create a new command (that should be in cmd/ti/) for handling th=
e K3
> > > > fuses, if we cannot make something abstract enough to handle this
> > > > concept on multiple vendors while having any sort of useful code re=
-use.
> > >=20
> > > 2) In this case, I would like to add the fuse writebuff command for T=
I=E2=80=99s K3
> > > architecture in cmd/ti/k3_fuse.c. And the command will look like
> > >=20
> > > fuse writebuff <command_id> <addr>
> > >=20
> > > However, I would still like to place the fuse writebuff command in
> > > cmd/fuse.c as a generic interface because the parameters command_id a=
nd an
> > > opaque pointer handoff provides a mechanism for the secure core to in=
terpret
> > > buffers differently based on vendor or use case.
> >=20
> > This I guess is my confusion. If we can't abstract cmd_dek.c and the
> > underlying i.MX specific parts to be supported in "fuse writebuff ..."
> > what is the non-K3 (or better still, non-TI) abstraction for what you're
> > proposing?
> >=20
> Hi Tom,
> There are two types of fuse programming flows;
> a) Where the fuse layout is known to U-Boot -> fuse cmd options support t=
his
> flow today
> b) Where fuse cmd is abstracted from U-Boot -> needs a co-processor to pr=
oxy
> the programming
>=20
> For b) the fuse layout is virtualized via a "vendor-specific" structure
> which is generated offline (typically with GUI tools) and then loaded to
> memory from a file on SD card . This pointer would then be relayed to Co
> processor as a IPC call...
>=20
> So, whats common b/w cmd_dek.c and TI's fuse cmd -> loading opaque struct=
 to
> memory and then passing it to Secure co-processor along with one or more
> command identifiers which will serve as hint for such secure co-processor.
> "fuse writebuff" tries to abstract essentially this: take a cmd_id and fi=
le
> pointer from fuse cmd and pass to it Vendor specific backend. I know its =
not
> a lot but frontend tools used to flash the devices can still make the most
> of it with simple vendor neutral abstractions than needing to know custom
> command for each vendor.
>=20
> What cannot be abstracted is:
> a) struct of the file,
> b) common definition of command Id
> c) IPC mechanisms
>=20
> Unfortunately all the above 3 are tightly coupled to co-processor on the
> other end which most likely is immutable for most SoCs...

So what I'm missing is why we can't have "fusebuf" as the top level
command, or "fuse writebuf <vendor> <address>" and then yes, leave the
vendor specific parts to each vendor to implement?=20

--=20
Tom

--0efruAi/E/giCnp9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeZWKgACgkQFHw5/5Y0
tyxqdwv/dbT8CoZA3dC7oOfzNRMYWey4g8+UXgg3dydjCMWLSzRW0IIcIaYC1ru8
ypE/GWjAtK0mqqxYqhvvE9+2gvAA4Z2FRSQ5ijSUlmlEXWbxuewQ+6L1FHogMgm8
hXhzXLJv7k1ilTw3G5tBZVz23YtpK0W/q7+oZSOM8JJJcl6hsRoWPenx+AIgD5BF
DmORZPxW6VQngle4bFL42OZizInLZZX19dIvEKSbLD28QJuXWTyUS6A6LOsP+QH8
vmDLQ0mi0oFeTjt3x/laX0CNZ/8sQMtyVlU4UJUsPaY5tk5Z9vUd7621Cua22wIO
1X8Sp+YRND/dBaJgYBeF0Fm7FsJwcJd+aIZmnKE/74YhCHx9pcgPOFA3oHsD+EG9
FLElOtgp/hY+Mrvsn9jAuvHeqM7g7BdF/xzCc3pPjrkWR5DptRmvmxO0YEiRZyFZ
u8alhErN0trNUldtcthEZxNItTcKPoF4kydBJXX9FSyA70qw9o1IwsiH7VtpgVl9
UmW+CBmY
=kU4D
-----END PGP SIGNATURE-----

--0efruAi/E/giCnp9--
