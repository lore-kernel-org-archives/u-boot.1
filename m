Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE61C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 14:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 910FC84942;
	Mon, 29 Jun 2026 16:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GEl8PM/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC7818496E; Mon, 29 Jun 2026 16:24:28 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 280F584931
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 16:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e9c7174e98so657109a34.2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 07:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782743065; x=1783347865; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Amw6CGqyZQ1cqHSmoSPV2Pfs+NH7xG6SFhBukg4ydTY=;
 b=GEl8PM/80tA6C7lvm5n5nJ3ke5ApX8e0i/AykEpewzPjxu5TDhD40iq4xe18jsDuPl
 Krf2kGMJNf9IjZpu81TQCn8Om89q79BmRtp3a1OzPr0paKLjy8yiHXI8RMDaKrCjljEu
 7WHcyeHQWTqjC10KMhm2ReldkqY/jSUtk5Q9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782743065; x=1783347865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Amw6CGqyZQ1cqHSmoSPV2Pfs+NH7xG6SFhBukg4ydTY=;
 b=eLcYsJbyff6m/YWL4KZNllD6d29cUPyLaiaMBuIr3LU7bC6EwI0tqMcNd7pJY/YeiU
 FFeRHZVguXkI2QGbuzaOwKQiHxsyPdMp1adJQr7LxcSOyMahQL7bjbKiiuTu+5oibXzQ
 Bf0o48OGiDgP4GdiqtFLdjWYy9WfHje88per1OloQmfZdZlwnqA+8s92I1btDK9fBFt7
 dX7zAksYg1xqhcpipTQa19qaarM/ZwUuVrOqDZm0rpMi8ztTpXlj6KR8J+eJ4Dp3UrJr
 K9lTWkrDpDYGmC7Xa7SZ8c4uUd2ZMM7YS/Evk3V8aNwdFSYeGp3uCmsH7ZJxrTmptuAs
 aqRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Uvm+UOEPSUUPlDh0mWfziaL3ZPSm47IBcciFfkh7Bd2rkoGCI3JRnhDurpN0VBltTXp2+e9o=@lists.denx.de
X-Gm-Message-State: AOJu0YzyaKfIAPL+srRzzpSIiyCWBbj9K9v4aze7i4w0bQcdJdbwk5XF
 UshOxe5MR9KgHN1JvxU7FA81qQ5nrvuha9eOU3yl6h1rrmW8cP3HTT8tcGbivqGsbgo=
X-Gm-Gg: AfdE7cloNSvUPDR/8oX5x3kQc/4NjIYJKThghM8BiLKAs3v0zbgU18QTZ1OJPuxAEKf
 IAoDr+8ZRAvZfqOj4mk6uMEkN+TIqKkwtO+cuagEwHc0/XhFXhxUYrzBxaerJtIEtDBoqwzXZ3x
 0OY6sAGfnqUjVsAAHkqx7X6MVk+vkKapAwU1YISkJsUur2Itdk8k/PMBwzK71Zs/M2nphPS7ITM
 LPTNLzQvl2+C5LL27esU4hkHZfmnseHK14QbqWtTYXt5lfycSFV97htcPGrf2itSHF3MXVhOl5f
 XD0coyZZQzE2Y9RnwpcPamAKpMB3stAlIPQ51PqQWkCDOvvOTyp8nzEsxuxIuLs+iEAQlgKbqdx
 gkqt/PigR4AJlmtupg1NNHpEcl87v0jOey77PSX7ls4e77hv5hxjsTb9PS14kbtxkooWTjbd60x
 a+Akj++7Lc4nvrXuMXiw9QbarfJmXaj0xcbgT9ypAKfs30B+Ckb4Jkg6nGVYyrmO1pKw8ifhwTg
 I+0CxToX6LniRoazga4RRXxerhADlu7X3X1GfSH
X-Received: by 2002:a05:6830:6d10:b0:7d8:b269:e99b with SMTP id
 46e09a7af769-7e99c225406mr13577022a34.17.1782743064533; 
 Mon, 29 Jun 2026 07:24:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e9e8228746sm666826a34.20.2026.06.29.07.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:24:23 -0700 (PDT)
Date: Mon, 29 Jun 2026 08:24:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH 7/7] boot: add a minimal bootmeth for the Boot Loader
 Specification
Message-ID: <20260629142421.GD382693@bill-the-cat>
References: <CAFLszTikihqsUmOGdmb8Q9WypiEHb0nq-a7vXH5XrXNxRVeNjg@mail.gmail.com>
 <CAKTNdwEkt+YMq-SG=PVTGzGztyeujVr=fEje74NnSbBbiswd7w@mail.gmail.com>
 <CAFLszTg7DJW4b0JhuPgCQe2TdMEdUagdGqRu7UG_j__S=4MjMQ@mail.gmail.com>
 <CAKTNdwEJuQ_6ROpKb+b_anFH7GbaT8NA2dvmxWmS_m8RSUYxTw@mail.gmail.com>
 <20260625172422.GU382693@bill-the-cat>
 <CAFLszTg5sBQiVw_guWhNjg8PQ2d+KyVXw0=Q0igjxSeuxerqsQ@mail.gmail.com>
 <20260625173258.GV382693@bill-the-cat>
 <CAFLszTiS3GXAj9XoqfMb-Lf4kbyYJNopDv_yApRoiChqO-8J3A@mail.gmail.com>
 <20260626134701.GX382693@bill-the-cat>
 <CAFLszTgB1r_n=GZPTL9C8e6SGOL8ipXhuDCM0OkiTea64V2diw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pNEfAyNEsrxVbYXN"
Content-Disposition: inline
In-Reply-To: <CAFLszTgB1r_n=GZPTL9C8e6SGOL8ipXhuDCM0OkiTea64V2diw@mail.gmail.com>
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


--pNEfAyNEsrxVbYXN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 06:45:07AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 26 Jun 2026 at 14:47, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jun 26, 2026 at 11:45:22AM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 25 Jun 2026 at 18:33, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jun 25, 2026 at 06:29:18PM +0100, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 25 Jun 2026 at 18:24, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 25, 2026 at 08:57:13PM +0400, Alexey Charkov wrote:
> > > > > > > On Thu, Jun 25, 2026 at 8:24=E2=80=AFPM Simon Glass <sjg@chro=
mium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Alexey,
> > > > > > > >
> > > > > > > > On Thu, 25 Jun 2026 at 16:52, Alexey Charkov <alchark@flipp=
er.net> wrote:
> > > > > > > > >
> > > > > > > > > Hi Simon,
> > > > > > > > >
> > > > > > > > > On Thu, Jun 25, 2026 at 7:28=E2=80=AFPM Simon Glass <sjg@=
chromium.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Alexey,
> > > > > > > > > >
> > > > > > > > > > On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper=
=2Enet> wrote:
> > > > > > > > > > > boot: add a minimal bootmeth for the Boot Loader Spec=
ification
> > > > > > > > > > >
> > > > > > > > > > > Add a bootmeth that finds and boots Boot Loader Speci=
fication (BLS)
> > > > > > > > > > > type #1 entry files [1]. On each block-device partiti=
on it scans, the
> > > > > > > > > > > bootmeth looks for files matching '<prefix>loader/ent=
ries/*.conf'
> > > > > > > > > > > (where <prefix> comes from bootstd_get_prefixes(), ty=
pically '/' and
> > > > > > > > > > > '/boot/'), picks the highest-sorting filename, parses=
 it, and exposes
> > > > > > > > > > > it as a bootflow.
> > > > > > > > > > >
> > > > > > > > > > > Implementation reuses the existing pxelinux infrastru=
cture.
> > > > > > > > > > >
> > > > > > > > > > > For now the entry chosen on a partition is purely the=
 lexicographic
> > > > > > > > > > > maximum of *.conf filenames; sort-key / version field=
 handling
> > > > > > > > > > > (spec-mandated tiebreakers) and boot-counting (the '+=
TRIES_LEFT'
> > > > > > > > > > > filename suffix) are left as TODOs. Likewise, only th=
e top-sorted entry
> > > > > > > > > > > is surfaced because the bootstd framework currently a=
llows one bootflow
> > > > > > > > > > > per (bootmeth, partition); exposing every discovered =
entry will require
> > > > > > > > > > > a framework extension.
> > > > > > > > > > >
> > > > > > > > > > > Type #2 BLS (drop-in directory of EFI binaries) is ou=
t of scope here;
> > > > > > > > > > > [...]
> > > > > > > > > > >
> > > > > > > > > > > boot/Kconfig        |  17 +++
> > > > > > > > > > >  boot/Makefile       |   1 +
> > > > > > > > > > >  boot/bootmeth_bls.c | 333 ++++++++++++++++++++++++++=
++++++++++++++++++++++++++
> > > > > > > > > > >  3 files changed, 351 insertions(+)
> > > > > > > > > >
> > > > > > > > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > > > > > > @@ -649,6 +649,23 @@ config BOOTMETH_EXTLINUX_PXE
> > > > > > > > > > > +config BOOTMETH_BLS
> > > > > > > > > > > +     bool "Bootdev support for Boot Loader Specifica=
tion entries"
> > > > > > > > > > > +     select PXE_UTILS
> > > > > > > > > > > +     default y
> > > > > > > > > >
> > > > > > > > > > Wherever the 'default y' discussion lands, this will be=
 enabled on
> > > > > > > > > > sandbox, so the 'bootmeth list' tests in test/boot/boot=
meth.c will
> > > > > > > > > > fail since they check the exact list and count. Please =
can you run the
> > > > > > > > > > sandbox tests and update them as needed?
> > > > > > > > > >
> > > > > > > > > > Since you are adding a new bootmeth you also need a san=
dbox test that
> > > > > > > > > > exercises it (see the extlinux tests in test/boot/bootf=
low.c, with a
> > > > > > > > > > fixture disk image) and a documentation page, e.g.
> > > > > > > > > > doc/develop/bootstd/bls.rst with an entry in the index =
there.
> > > > > > > > >
> > > > > > > > > Will do, thanks!
> > > > > > > > >
> > > > > > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > > > > > @@ -0,0 +1,333 @@
> > > > > > > > > > > +static int bls_getfile(struct pxe_context *ctx, cons=
t char *file_path,
> > > > > > > > > > > +                    char *file_addr, enum bootflow_i=
mg_t type, ulong *sizep)
> > > > > > > > > >
> > > > > > > > > > This is a verbatim copy of extlinux_getfile() - please =
can you export
> > > > > > > > > > that, or move it into a shared helper?
> > > > > > > > >
> > > > > > > > > Ack
> > > > > > > > >
> > > > > > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > > > > > @@ -0,0 +1,333 @@
> > > > > > > > > > > +     ret =3D bootmeth_alloc_file(bflow, SZ_64K, 1, B=
FI_EXTLINUX_CFG);
> > > > > > > > > >
> > > > > > > > > > The extlinux bootmeth passes ARCH_DMA_MINALIGN here, si=
nce the buffer
> > > > > > > > > > is filled by a block-device read which may use DMA on s=
ome platforms.
> > > > > > > > > > An alignment of 1 risks cache-line corruption there, so=
 please use
> > > > > > > > > > ARCH_DMA_MINALIGN.
> > > > > > > > >
> > > > > > > > > Ack
> > > > > > > > >
> > > > > > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > > > > > @@ -0,0 +1,333 @@
> > > > > > > > > > > +     bflow->bootmeth_priv =3D label;
> > > > > > > > > > > +     free(fpath);
> > > > > > > > > >
> > > > > > > > > > This leaks memory: bootflow_free() releases bootmeth_pr=
iv with a plain
> > > > > > > > > > free(), so the label's string members (name, menu, kern=
el, append,
> > > > > > > > > > initrd, etc.) are never freed - for every bootflow disc=
arded after a
> > > > > > > > > > scan, not just on error paths.
> > > > > > > > > >
> > > > > > > > > > Since get_string() copies tokens out of the buffer rath=
er than
> > > > > > > > > > modifying it in place, you could follow the extlinux ap=
proach: keep
> > > > > > > > > > only bflow->buf across the scan (already populated by
> > > > > > > > > > bootmeth_alloc_file() and freed by the framework), use =
a temporary
> > > > > > > > > > label in bls_read_bootflow() just to extract the title,=
 destroy it
> > > > > > > > > > with label_destroy(), and re-parse the buffer in bls_bo=
ot(). Then
> > > > > > > > > > bootmeth_priv is not needed at all. What do you think?
> > > > > > > > >
> > > > > > > > > Will address the leak, thanks for pointing it out!
> > > > > > > > >
> > > > > > > > > The bls_priv structure is needed for my follow-up extensi=
on which
> > > > > > > > > allows multiple boot entries to be returned by each (boot=
dev,
> > > > > > > > > bootmeth, partition) tuple, and I wanted to minimize chur=
n between
> > > > > > > > > those two. I haven't sent that follow-up for review yet, =
as I wanted
> > > > > > > > > to confirm this simpler version is acceptable first.
> > > > > > > >
> > > > > > > > We should implement this using an generic index rather than=
 something
> > > > > > > > bls-specific...please see some commits at:
> > > > > > > >
> > > > > > > > https://concept.deinde.dev/u-boot/u-boot/-/merge_requests/7=
82
> > > > > > >
> > > > > > > Oh, there's already BLS in your tree :-D
> > > > > > >
> > > > > > > Would you like to merge that instead? Your version looks much=
 more
> > > > > > > full-fledged. If you happen to have one rebased on master or =
next I'd
> > > > > > > be happy to test!
> > > > > >
> > > > > > Unfortunately Simon's work here is AI-generated and so not part=
icularly
> > > > > > welcome, among other problems right now.
> > > > >
> > > > > No, not AI-generated, but certainly AI-assisted (perhaps that is =
what
> > > > > you meant?)
> > > >
> > > > I didn't dig back super far to see what all AI-generated (such as y=
our
> > > > dlmalloc upgrade) vs "AI-assisted" (commit from just a few months a=
go)
> > > > and try and guess based on the quality if it's "generated" or
> > > > "assisted". But it doesn't really matter in the AI context. And it
> > > > certainly doesn't matter until you've donated u-boot.org to the pro=
ject.
> > >
> > > Yes the dlmalloc upgrade was a lot of work and brings a lot of
> > > benefits to U-Boot. There is also a backtrace feature which is really
> > > handlyfor tracking down memory leaks and hangs. I found a ton of
> > > leaks, some of them very large (e.g. SCMI). There was certainly a lot
> > > of manual work involved, along with AI assistance. I believe AI is
> > > particularly effective when used by someone who knows the project and
> > > codebase well.
> >
> > OK, but did you review that dlmalloc upgrade? Did you think Claude did a
> > good and appropriate job there?
>=20
> It's a while ago, but I remember being about 3 bugs deep at the time
> (crashes in CI which turned out to be memory leaks) so I am sure it
> could be better. If you are interested in it for mainline I could take
> another look.

Really, I think that just adds to the list of reasons why these "tools"
are so terrible. The series itself is disrespectful to the community, as
it kept the commit messages *and* review tags of the actual humans that
originally did work while the changes being done almost never[1] had any
clear relationship to what was originally done. And as a "cherry on
top", tracking down what one of the original commits even is was not
easy as Claude rewrote the last third or so of the git hash.

So no, it would not be "take another look", it would be "throw it out
and do it correctly".

[1]: Of what I was cc'd one, which was a reasonable number, in only one
case was the original change, and the new change doing the same thing as
before in a clear manner that the commit message was still certainly
correct, and the remaining change was the same as before, so if a human
did it, it would have been considered reasonable to do with an
explanation below the "---".

--=20
Tom

--pNEfAyNEsrxVbYXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakKAEQAKCRAr4qD1Cr/k
ClHzAP43TOyCPEVr7O2Ef/Lah1HTUD7TdHkZrHde6zl3sq82HwD9Fc9x+q16if0p
YAPX8hSYMt/XOboTsZdh3/C8SyAVNwA=
=m6Nz
-----END PGP SIGNATURE-----

--pNEfAyNEsrxVbYXN--
