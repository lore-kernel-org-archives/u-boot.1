Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073BDCDE002
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C6A847C8;
	Thu, 25 Jun 2026 19:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e8PUdSHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCA348495B; Thu, 25 Jun 2026 19:33:05 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 118C5846F4
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 19:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-69e46524711so67290eaf.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782408781; x=1783013581; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ynoq8dRBJQwOhv6HOFDbhiPQ7IPfDgzQZ7QBehW0TXg=;
 b=e8PUdSHC/vBFKBRNGZjk4AtNgxP1ZIdNpDbnVf2k8JlM+9hWhN/vAg5wDlZwZn5kDm
 3nFkLtzbbuW+9ee71dBZh8xU2U1EUDNLksJJ1NWubhstBIYQy29V4rLGxvOIuhQdcT/v
 AoUFBELrV8Y6DlvTnWOxd3KUSS7UtUwxJmL8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408781; x=1783013581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ynoq8dRBJQwOhv6HOFDbhiPQ7IPfDgzQZ7QBehW0TXg=;
 b=WWcVN5WbcnJxcWat6hPNmPZaXJ3WCyBEA6/2zTEG8rnOEapypYMZhcIrK2eZck87bN
 pgifZTbz/4L4Ne6DKEVCAZZPztYkb7i31IEuFfi1KygNCSEqdt6OItcJXQzhEytyqd+2
 aUepASuWWaYVfFabyTwaeYKqC62PZdgBWmmF2wbMxUV2e3tPFpcqAq8G6hDgYEzxAT/D
 1ucOLEY6ecuBDkokRvuicHujF+vmMONxq+Kn45cQj/zZYJUBoCbxlaHOzRsGCBmqZFQu
 kQ6xxa+qqh0y6t4pfqx25XoZeMe1Zm9L4059vnDvpbmuoK+EMmgUSXRVKqyHIE3qDljZ
 gGWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Kk7w/Q7pqCjC+yjGvVuIkaZK4vSaFWSJaVqLxgA7uzYZJoCFH+ummr5tXah2ZrpI1pvdQWy4=@lists.denx.de
X-Gm-Message-State: AOJu0YwPepfEEUY8RkGeZa1ScJnQTFH7W9sO/dy/MG+15n5Ue5g0cLZW
 /sFYgYNqHOheJ0gW4196Hcn77a1KTd+meG5X2r/Ftch+gCfxY+1QwsyoR7ajVYlhijp02UPqIre
 JUoa361s=
X-Gm-Gg: AfdE7cnw3+0ZCMx92CfGtXnkI+Mz/rUbh2Flb3ZXcmpUD8+2HvGKZP53VlorGuJkNuQ
 JlABmxjMYt6HuQ6sTdl3Tyd/k0oqsRBoi8ZOcb5fwCCUL/bK2RvK39AzkvaMSogsI6Bjn7wTM+Z
 v4Sove/8/GjbN8sDcXJP0BJMKbexe3m2oPiToSW9X86oXYWgr6GyK6AAvVKdRTlonRPmUuJZizr
 nM5oR4WJP/tauMbFcxQZe3hcsVPAYiNR/EOzTuBAFpCF01BmWJOCRjnUUKH/vAKQwez0kKuAqst
 l5DCElqOiKl8uwAyrxqjj5pxpf/QPdNISrrClWjuHlKPVABl/szRreSIJyUGjXZrp0B7ruihkYQ
 ac39SUc7E0VIorw2qY/dDo/qlxqmvAlSgGwOuNKPu/GBwaVYeC6JF807WN7XOExYe6qrfgERLZd
 de74vP9Q+JFPllD+BnJmfzHnIFwfdIBB/hUHpf8MqRvfmSKyQQjhVijnYpXYngIPCgyx+oppTrU
 /jUcVjco2IixNVQd73IUa9zliG4quYYp89IlRzs
X-Received: by 2002:a05:6820:2d0c:b0:69b:8ded:f933 with SMTP id
 006d021491bc7-6a135244a6bmr3063388eaf.36.1782408781394; 
 Thu, 25 Jun 2026 10:33:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0ea1520e4sm11288931eaf.15.2026.06.25.10.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:33:00 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:32:58 -0600
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
Message-ID: <20260625173258.GV382693@bill-the-cat>
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-7-4ce6d1ee4711@flipper.net>
 <CAFLszTikihqsUmOGdmb8Q9WypiEHb0nq-a7vXH5XrXNxRVeNjg@mail.gmail.com>
 <CAKTNdwEkt+YMq-SG=PVTGzGztyeujVr=fEje74NnSbBbiswd7w@mail.gmail.com>
 <CAFLszTg7DJW4b0JhuPgCQe2TdMEdUagdGqRu7UG_j__S=4MjMQ@mail.gmail.com>
 <CAKTNdwEJuQ_6ROpKb+b_anFH7GbaT8NA2dvmxWmS_m8RSUYxTw@mail.gmail.com>
 <20260625172422.GU382693@bill-the-cat>
 <CAFLszTg5sBQiVw_guWhNjg8PQ2d+KyVXw0=Q0igjxSeuxerqsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v/ztPpGOnaEpTvWS"
Content-Disposition: inline
In-Reply-To: <CAFLszTg5sBQiVw_guWhNjg8PQ2d+KyVXw0=Q0igjxSeuxerqsQ@mail.gmail.com>
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


--v/ztPpGOnaEpTvWS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 06:29:18PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 25 Jun 2026 at 18:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jun 25, 2026 at 08:57:13PM +0400, Alexey Charkov wrote:
> > > On Thu, Jun 25, 2026 at 8:24=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Alexey,
> > > >
> > > > On Thu, 25 Jun 2026 at 16:52, Alexey Charkov <alchark@flipper.net> =
wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Thu, Jun 25, 2026 at 7:28=E2=80=AFPM Simon Glass <sjg@chromium=
=2Eorg> wrote:
> > > > > >
> > > > > > Hi Alexey,
> > > > > >
> > > > > > On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net> wr=
ote:
> > > > > > > boot: add a minimal bootmeth for the Boot Loader Specification
> > > > > > >
> > > > > > > Add a bootmeth that finds and boots Boot Loader Specification=
 (BLS)
> > > > > > > type #1 entry files [1]. On each block-device partition it sc=
ans, the
> > > > > > > bootmeth looks for files matching '<prefix>loader/entries/*.c=
onf'
> > > > > > > (where <prefix> comes from bootstd_get_prefixes(), typically =
'/' and
> > > > > > > '/boot/'), picks the highest-sorting filename, parses it, and=
 exposes
> > > > > > > it as a bootflow.
> > > > > > >
> > > > > > > Implementation reuses the existing pxelinux infrastructure.
> > > > > > >
> > > > > > > For now the entry chosen on a partition is purely the lexicog=
raphic
> > > > > > > maximum of *.conf filenames; sort-key / version field handling
> > > > > > > (spec-mandated tiebreakers) and boot-counting (the '+TRIES_LE=
FT'
> > > > > > > filename suffix) are left as TODOs. Likewise, only the top-so=
rted entry
> > > > > > > is surfaced because the bootstd framework currently allows on=
e bootflow
> > > > > > > per (bootmeth, partition); exposing every discovered entry wi=
ll require
> > > > > > > a framework extension.
> > > > > > >
> > > > > > > Type #2 BLS (drop-in directory of EFI binaries) is out of sco=
pe here;
> > > > > > > [...]
> > > > > > >
> > > > > > > boot/Kconfig        |  17 +++
> > > > > > >  boot/Makefile       |   1 +
> > > > > > >  boot/bootmeth_bls.c | 333 ++++++++++++++++++++++++++++++++++=
++++++++++++++++++
> > > > > > >  3 files changed, 351 insertions(+)
> > > > > >
> > > > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > > @@ -649,6 +649,23 @@ config BOOTMETH_EXTLINUX_PXE
> > > > > > > +config BOOTMETH_BLS
> > > > > > > +     bool "Bootdev support for Boot Loader Specification ent=
ries"
> > > > > > > +     select PXE_UTILS
> > > > > > > +     default y
> > > > > >
> > > > > > Wherever the 'default y' discussion lands, this will be enabled=
 on
> > > > > > sandbox, so the 'bootmeth list' tests in test/boot/bootmeth.c w=
ill
> > > > > > fail since they check the exact list and count. Please can you =
run the
> > > > > > sandbox tests and update them as needed?
> > > > > >
> > > > > > Since you are adding a new bootmeth you also need a sandbox tes=
t that
> > > > > > exercises it (see the extlinux tests in test/boot/bootflow.c, w=
ith a
> > > > > > fixture disk image) and a documentation page, e.g.
> > > > > > doc/develop/bootstd/bls.rst with an entry in the index there.
> > > > >
> > > > > Will do, thanks!
> > > > >
> > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > @@ -0,0 +1,333 @@
> > > > > > > +static int bls_getfile(struct pxe_context *ctx, const char *=
file_path,
> > > > > > > +                    char *file_addr, enum bootflow_img_t typ=
e, ulong *sizep)
> > > > > >
> > > > > > This is a verbatim copy of extlinux_getfile() - please can you =
export
> > > > > > that, or move it into a shared helper?
> > > > >
> > > > > Ack
> > > > >
> > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > @@ -0,0 +1,333 @@
> > > > > > > +     ret =3D bootmeth_alloc_file(bflow, SZ_64K, 1, BFI_EXTLI=
NUX_CFG);
> > > > > >
> > > > > > The extlinux bootmeth passes ARCH_DMA_MINALIGN here, since the =
buffer
> > > > > > is filled by a block-device read which may use DMA on some plat=
forms.
> > > > > > An alignment of 1 risks cache-line corruption there, so please =
use
> > > > > > ARCH_DMA_MINALIGN.
> > > > >
> > > > > Ack
> > > > >
> > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > @@ -0,0 +1,333 @@
> > > > > > > +     bflow->bootmeth_priv =3D label;
> > > > > > > +     free(fpath);
> > > > > >
> > > > > > This leaks memory: bootflow_free() releases bootmeth_priv with =
a plain
> > > > > > free(), so the label's string members (name, menu, kernel, appe=
nd,
> > > > > > initrd, etc.) are never freed - for every bootflow discarded af=
ter a
> > > > > > scan, not just on error paths.
> > > > > >
> > > > > > Since get_string() copies tokens out of the buffer rather than
> > > > > > modifying it in place, you could follow the extlinux approach: =
keep
> > > > > > only bflow->buf across the scan (already populated by
> > > > > > bootmeth_alloc_file() and freed by the framework), use a tempor=
ary
> > > > > > label in bls_read_bootflow() just to extract the title, destroy=
 it
> > > > > > with label_destroy(), and re-parse the buffer in bls_boot(). Th=
en
> > > > > > bootmeth_priv is not needed at all. What do you think?
> > > > >
> > > > > Will address the leak, thanks for pointing it out!
> > > > >
> > > > > The bls_priv structure is needed for my follow-up extension which
> > > > > allows multiple boot entries to be returned by each (bootdev,
> > > > > bootmeth, partition) tuple, and I wanted to minimize churn between
> > > > > those two. I haven't sent that follow-up for review yet, as I wan=
ted
> > > > > to confirm this simpler version is acceptable first.
> > > >
> > > > We should implement this using an generic index rather than somethi=
ng
> > > > bls-specific...please see some commits at:
> > > >
> > > > https://concept.deinde.dev/u-boot/u-boot/-/merge_requests/782
> > >
> > > Oh, there's already BLS in your tree :-D
> > >
> > > Would you like to merge that instead? Your version looks much more
> > > full-fledged. If you happen to have one rebased on master or next I'd
> > > be happy to test!
> >
> > Unfortunately Simon's work here is AI-generated and so not particularly
> > welcome, among other problems right now.
>=20
> No, not AI-generated, but certainly AI-assisted (perhaps that is what
> you meant?)

I didn't dig back super far to see what all AI-generated (such as your
dlmalloc upgrade) vs "AI-assisted" (commit from just a few months ago)
and try and guess based on the quality if it's "generated" or
"assisted". But it doesn't really matter in the AI context. And it
certainly doesn't matter until you've donated u-boot.org to the project.

--=20
Tom

--v/ztPpGOnaEpTvWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaj1mSgAKCRAr4qD1Cr/k
CmGDAQCqqKy1+LRhhn3BUBlonNNZDkhOWG4aLFpwA3DFKdvstgD/UUkegA4uy3J2
Z3KPwigIDL1dEArttz4TnaAywrjKUgE=
=t/2H
-----END PGP SIGNATURE-----

--v/ztPpGOnaEpTvWS--
