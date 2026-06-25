Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E10CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 140F8846F4;
	Thu, 25 Jun 2026 19:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hUZgM/qQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E4DB84704; Thu, 25 Jun 2026 19:24:30 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 720E48460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 19:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-43d16405b54so30199fac.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782408266; x=1783013066; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CpZq0cHmUnvAk98lonIeWaBq1QrgfVayHRR/GfZuKTc=;
 b=hUZgM/qQNrZy8jIM8owX5wf9G6yUXbccp/8OoMWJ/8L4PqtLYDqGKNFlryEOklQxfa
 YqRBK2LfP+iVFXBPl/YMNpyq1qojM+uCQB/LxtjI1eqvzbW9Lm3NX13c3SAk2hvqyXQq
 avHATsab6/UGJIiaCCk6i+ZX8rtmWgOS1uyC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408266; x=1783013066;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CpZq0cHmUnvAk98lonIeWaBq1QrgfVayHRR/GfZuKTc=;
 b=SygccA/Dcn/C9atPMj+JQ/k6E31tgTBBGd+fopQapQjyCsticA4GPaHKUchemiHos/
 5ANMgmvmE764yvqAKVaGiQa6d74CCLMzxTkKcUu3cSyrREZYpT4cuHS/4C+RVY92e8Xh
 ysXLSeawQDP9Qdqo7js24Jr+zV8v2vDKt3O3VrJjHRO/exRnejUSUKlQlsv461vtKRL0
 C2txu2m0L5DGvyARaM6AoPhtq2MDjJR1FGAyNvBH3oJsRr/iOrrqKdkT7YBoqNzZLoNt
 hSXLsBKtk1K6pxPEQYy6JUXvQLrJ02fZ2kgitGGAmai/peUmNVVUPSo5FbQgkwui/5Wz
 J61g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkRQr0cqekB1O0Pp0G0uEzEIgdU/AkrnLF+MFulttm0UmPURwVmyS45I34Ex3KR6YzBLQVmZY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+yBcKS2u3d1MMl5TVHHRyuEPurEKY0Y0CRjclFXvyZgj+pnII
 aUSfqve4vf64UZlQBfBETqkamDFp9etQSv6VKvbd5i4yK3K9Zksv8/T0/TJNIsr+4CE=
X-Gm-Gg: AfdE7ck2oAA617IctIeEdS2I6MS0BoYUp732Tm/RNynrFfF6EaN0b2PK5FP/Wwc9N8W
 qyo4hZzHpUKMROMctVjbAiDotH1P9ycWtMTaF+S8oSD1Z7uuhgfui81N6CNgj+DjRVg1/glcBWr
 frEuQylgf9/Aaj1R7lDnWs0sFY2Uxo4rnRVGJGktyiHbgCgA96hxaaEFHZ6NsV3f4a+4A0Bo03h
 EhZUzgOSSaxYQlV6epW4gbB14AvRMvzYGygmEVtah01Tpll/qUOzYNjpwr6eD24YffzSGhh4T4G
 pH/BucQmjquR4fQucK5OskuN9RV0DlWU1sS99xp6FXHKKtubAAi7I7FjnazhTpD8Ng4X++GDkpt
 rJRYzarEmG1rfqO1PacVSfwO7YuCiQJR6OP9WqjuW+/IvuL+zevCs/CyTNdlq1J2UtFBI8D0wql
 0PAGgSPMNxy9mlsXttUB0irgDHYV6jilbzhKSJaosgFHYMNN2v1H95Az/VqFO7kTwzwGLqXVoHc
 UjDluYiw0xV01z92mReOxp89qGUzMLUYWeRYwOw
X-Received: by 2002:a05:6870:b0d3:b0:447:261d:fd9d with SMTP id
 586e51a60fabf-448117f1bf8mr2938720fac.4.1782408266107; 
 Thu, 25 Jun 2026 10:24:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-447ec359d9csm3655460fac.12.2026.06.25.10.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:24:25 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:24:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH 7/7] boot: add a minimal bootmeth for the Boot Loader
 Specification
Message-ID: <20260625172422.GU382693@bill-the-cat>
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-7-4ce6d1ee4711@flipper.net>
 <CAFLszTikihqsUmOGdmb8Q9WypiEHb0nq-a7vXH5XrXNxRVeNjg@mail.gmail.com>
 <CAKTNdwEkt+YMq-SG=PVTGzGztyeujVr=fEje74NnSbBbiswd7w@mail.gmail.com>
 <CAFLszTg7DJW4b0JhuPgCQe2TdMEdUagdGqRu7UG_j__S=4MjMQ@mail.gmail.com>
 <CAKTNdwEJuQ_6ROpKb+b_anFH7GbaT8NA2dvmxWmS_m8RSUYxTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GVDzaqHWdDYQUQ/P"
Content-Disposition: inline
In-Reply-To: <CAKTNdwEJuQ_6ROpKb+b_anFH7GbaT8NA2dvmxWmS_m8RSUYxTw@mail.gmail.com>
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


--GVDzaqHWdDYQUQ/P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 08:57:13PM +0400, Alexey Charkov wrote:
> On Thu, Jun 25, 2026 at 8:24=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Alexey,
> >
> > On Thu, 25 Jun 2026 at 16:52, Alexey Charkov <alchark@flipper.net> wrot=
e:
> > >
> > > Hi Simon,
> > >
> > > On Thu, Jun 25, 2026 at 7:28=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Alexey,
> > > >
> > > > On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net> wrote:
> > > > > boot: add a minimal bootmeth for the Boot Loader Specification
> > > > >
> > > > > Add a bootmeth that finds and boots Boot Loader Specification (BL=
S)
> > > > > type #1 entry files [1]. On each block-device partition it scans,=
 the
> > > > > bootmeth looks for files matching '<prefix>loader/entries/*.conf'
> > > > > (where <prefix> comes from bootstd_get_prefixes(), typically '/' =
and
> > > > > '/boot/'), picks the highest-sorting filename, parses it, and exp=
oses
> > > > > it as a bootflow.
> > > > >
> > > > > Implementation reuses the existing pxelinux infrastructure.
> > > > >
> > > > > For now the entry chosen on a partition is purely the lexicograph=
ic
> > > > > maximum of *.conf filenames; sort-key / version field handling
> > > > > (spec-mandated tiebreakers) and boot-counting (the '+TRIES_LEFT'
> > > > > filename suffix) are left as TODOs. Likewise, only the top-sorted=
 entry
> > > > > is surfaced because the bootstd framework currently allows one bo=
otflow
> > > > > per (bootmeth, partition); exposing every discovered entry will r=
equire
> > > > > a framework extension.
> > > > >
> > > > > Type #2 BLS (drop-in directory of EFI binaries) is out of scope h=
ere;
> > > > > [...]
> > > > >
> > > > > boot/Kconfig        |  17 +++
> > > > >  boot/Makefile       |   1 +
> > > > >  boot/bootmeth_bls.c | 333 ++++++++++++++++++++++++++++++++++++++=
++++++++++++++
> > > > >  3 files changed, 351 insertions(+)
> > > >
> > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > @@ -649,6 +649,23 @@ config BOOTMETH_EXTLINUX_PXE
> > > > > +config BOOTMETH_BLS
> > > > > +     bool "Bootdev support for Boot Loader Specification entries"
> > > > > +     select PXE_UTILS
> > > > > +     default y
> > > >
> > > > Wherever the 'default y' discussion lands, this will be enabled on
> > > > sandbox, so the 'bootmeth list' tests in test/boot/bootmeth.c will
> > > > fail since they check the exact list and count. Please can you run =
the
> > > > sandbox tests and update them as needed?
> > > >
> > > > Since you are adding a new bootmeth you also need a sandbox test th=
at
> > > > exercises it (see the extlinux tests in test/boot/bootflow.c, with a
> > > > fixture disk image) and a documentation page, e.g.
> > > > doc/develop/bootstd/bls.rst with an entry in the index there.
> > >
> > > Will do, thanks!
> > >
> > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > @@ -0,0 +1,333 @@
> > > > > +static int bls_getfile(struct pxe_context *ctx, const char *file=
_path,
> > > > > +                    char *file_addr, enum bootflow_img_t type, u=
long *sizep)
> > > >
> > > > This is a verbatim copy of extlinux_getfile() - please can you expo=
rt
> > > > that, or move it into a shared helper?
> > >
> > > Ack
> > >
> > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > @@ -0,0 +1,333 @@
> > > > > +     ret =3D bootmeth_alloc_file(bflow, SZ_64K, 1, BFI_EXTLINUX_=
CFG);
> > > >
> > > > The extlinux bootmeth passes ARCH_DMA_MINALIGN here, since the buff=
er
> > > > is filled by a block-device read which may use DMA on some platform=
s.
> > > > An alignment of 1 risks cache-line corruption there, so please use
> > > > ARCH_DMA_MINALIGN.
> > >
> > > Ack
> > >
> > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > @@ -0,0 +1,333 @@
> > > > > +     bflow->bootmeth_priv =3D label;
> > > > > +     free(fpath);
> > > >
> > > > This leaks memory: bootflow_free() releases bootmeth_priv with a pl=
ain
> > > > free(), so the label's string members (name, menu, kernel, append,
> > > > initrd, etc.) are never freed - for every bootflow discarded after a
> > > > scan, not just on error paths.
> > > >
> > > > Since get_string() copies tokens out of the buffer rather than
> > > > modifying it in place, you could follow the extlinux approach: keep
> > > > only bflow->buf across the scan (already populated by
> > > > bootmeth_alloc_file() and freed by the framework), use a temporary
> > > > label in bls_read_bootflow() just to extract the title, destroy it
> > > > with label_destroy(), and re-parse the buffer in bls_boot(). Then
> > > > bootmeth_priv is not needed at all. What do you think?
> > >
> > > Will address the leak, thanks for pointing it out!
> > >
> > > The bls_priv structure is needed for my follow-up extension which
> > > allows multiple boot entries to be returned by each (bootdev,
> > > bootmeth, partition) tuple, and I wanted to minimize churn between
> > > those two. I haven't sent that follow-up for review yet, as I wanted
> > > to confirm this simpler version is acceptable first.
> >
> > We should implement this using an generic index rather than something
> > bls-specific...please see some commits at:
> >
> > https://concept.deinde.dev/u-boot/u-boot/-/merge_requests/782
>=20
> Oh, there's already BLS in your tree :-D
>=20
> Would you like to merge that instead? Your version looks much more
> full-fledged. If you happen to have one rebased on master or next I'd
> be happy to test!

Unfortunately Simon's work here is AI-generated and so not particularly
welcome, among other problems right now.

--=20
Tom

--GVDzaqHWdDYQUQ/P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaj1kQwAKCRAr4qD1Cr/k
Cv2eAQD+3iKw2Lqh1pUQfvrPHO8xYe7BY+F/7Ke3G+v0TZWrZgD/a/Xp8Ab1M7pi
QWcBxhNBkSc/I0nbHX9jJDmshZM8TgY=
=9YCr
-----END PGP SIGNATURE-----

--GVDzaqHWdDYQUQ/P--
