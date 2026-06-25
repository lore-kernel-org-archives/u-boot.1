Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14CCCDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3298D847C8;
	Thu, 25 Jun 2026 19:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mMNtpRNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B966B84894; Thu, 25 Jun 2026 19:25:40 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 088FD846F4
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 19:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-697de335c18so48729a12.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782408337; cv=none;
 d=google.com; s=arc-20260327;
 b=B3kFfc0qIds4Elpa+Bbw9/xGStUaEUW3PMgVNp86tWJEwJc4nh4gerAhwyaC1f/W+e
 o3TyQek53RA5PtgMMNmki+XS5oc3cw6E5X7PPuEOIWjQG/lEuD+Hq+GIaOmzESnpMAxo
 GYzkHCGfur6K4dIxO8nEGL6RzCBUlQfG2ZPt37LYg8boa84Wt1TQk870Aj5nTZDTMKb8
 Wr2n61Y+6TWbngFkBvhfmOGfyXHO26RjaH9laczc+9EFJK0Nwr8nIKwdXyUGmRWF88lf
 vc0QtMfAl2+CXdFBq3zR+/f2vDQEHwjcia34GtUPrWJfYkPnpfFmv4Cdq6X1PJ3vxVR+
 n7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mZoPiTuwDDaSmaQH0WRyg4emX7Og344X0UD/vsQ3POM=;
 fh=1IBpGH+Xd/YdfaKFMxo1vol56mWfSqB2hhB/lOynXBQ=;
 b=Rq699dnJqTQVwP7mB0iR4c/EUI6lBhH2azXpFQmA9k4ZhQV4HZiTWnwg1W3N86dFWf
 ZuT0GeME19bic30YrHHZgUS/a5LIK+PGp1v8jWRbISi8tnXn3s+40vbjOCvrYVlQFnej
 PMScRyJPXUxC0OzmTv28gRdiQmdI6p8/X52b1uWmSgVJhQdaoXyk9Hpf2NpVondSAsdQ
 +N55WMhiDJwxjJQsHNlCqdqkMGLIXSgghU1h+b+yhcNvEmalZdhN6x25te49NwZnLLNr
 H5SsVL8F9sUTvJSOMkpX6jz2WMRonpz888zMSiOT/2eD0lJuJzPpK4cNGf8MmrBvIqQZ
 p+9A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782408337; x=1783013137; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZoPiTuwDDaSmaQH0WRyg4emX7Og344X0UD/vsQ3POM=;
 b=mMNtpRNsi06cyE2vBFqbMiqNvuqjSejfeErR0iHeq4nqz4oAEbTpMzaZhCdslVgjZW
 lfHI58e0yHzSY8kqbNDoEMfPndk/aYi1nguvhNG/KUEOgqnTm4bKbboEFui5Jcfp6YYQ
 gedA31gESQEjlXfdVW6B+5xPjVBm6+BukMrzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408337; x=1783013137;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mZoPiTuwDDaSmaQH0WRyg4emX7Og344X0UD/vsQ3POM=;
 b=dZiFN8ab7WQR/rnMgduzgjyhnePeKSszJ/ATgFFSIRjbEY+UknzMe3MVBUEAgUwhRz
 +3q1/NDl6YgOXNWrrV4YoAegeDLZuwsmQ0lIyURqlqW2vfrUNCGf2nP5k9Q6oiVtFqqT
 Yx7p7ioISnQLWVPZPyi96oQu3rGcDVEiVN1ACqnCph0JDJeN2+RgC9Xz10B/jl/ULSTT
 LcEeOLePOQWOPTMD4Jfs3MXzf22Qa+Ug6iGZGNL99eTzm351gufNq0++RK365w4gTt7M
 Yi1qIPEWoYrjwFmcpNWNTk3YzEYrBdixtUI/r00t1H9xw/J6wdfxKhNUyhYG9mLxxG8f
 7GZw==
X-Gm-Message-State: AOJu0YxV62lileF0Okx5+nYzN7Wb/WH19AmauwlFybrNZZFBtmFBvovl
 L7sncAe+HU8oULDLiQi/8oBCbCpd/8R3vEQgLukupc2+wPakiAOwbFJUJXaMNiZxlRpSAGZYP61
 QBTuQj8olxP4IZCQrygHMzN6fMD0csZ8qFVmxWro+
X-Gm-Gg: AfdE7cnOOV5OjswnwSdD1aEeujKQD5eGoq79+fJmdEVJlEX2pC8nYWU3fat+qkiV3Bw
 b9em1gVMBWWvDTEMBcT0k17jJSLsu4ViXWW5pcDuGJiDjEUjA85MhO+fBExQxmic0zCrg8tpXm6
 3ArAIKjP1LThZL2ReK6G1Y80Zi9w6rcGiWpje9xAEB4DViCehFtiOYUx5B3M6Kg58g7yd8+rOch
 GSnYAiFva69TdDU6hVmGZahaUXINnddqvEsgCYMpV5p+i+BsN5CMWoSnIL+raMwBIcwhnBulQ==
X-Received: by 2002:a05:6402:1473:b0:698:f7d:4e01 with SMTP id
 4fb4d7f45d1cf-69810a457admr207433a12.6.1782408337427; Thu, 25 Jun 2026
 10:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-7-4ce6d1ee4711@flipper.net>
 <CAFLszTikihqsUmOGdmb8Q9WypiEHb0nq-a7vXH5XrXNxRVeNjg@mail.gmail.com>
 <CAKTNdwEkt+YMq-SG=PVTGzGztyeujVr=fEje74NnSbBbiswd7w@mail.gmail.com>
 <CAFLszTg7DJW4b0JhuPgCQe2TdMEdUagdGqRu7UG_j__S=4MjMQ@mail.gmail.com>
 <CAKTNdwEJuQ_6ROpKb+b_anFH7GbaT8NA2dvmxWmS_m8RSUYxTw@mail.gmail.com>
In-Reply-To: <CAKTNdwEJuQ_6ROpKb+b_anFH7GbaT8NA2dvmxWmS_m8RSUYxTw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 18:25:25 +0100
X-Gm-Features: AVVi8Cf457ok4zpQRmBCXjWK35dK5RlDxc4SvUTwnBnNAGj_uDnVY_h2iLFBC00
Message-ID: <CAFLszTghO2OM44ZvPg+L2aufKH9ztBz=cCx9sTjNU-eyeS_8AQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] boot: add a minimal bootmeth for the Boot Loader
 Specification
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Alexey,

On Thu, 25 Jun 2026 at 17:57, Alexey Charkov <alchark@flipper.net> wrote:
>
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
> > > > > +     bool "Bootdev support for Boot Loader Specification entries=
"
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
> > > > exercises it (see the extlinux tests in test/boot/bootflow.c, with =
a
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
> > > > initrd, etc.) are never freed - for every bootflow discarded after =
a
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
>
> Oh, there's already BLS in your tree :-D
>
> Would you like to merge that instead? Your version looks much more
> full-fledged. If you happen to have one rebased on master or next I'd
> be happy to test!

Unfortunately there is a lot of pxe refactoring, because I wanted to
make it possible to fully parse an extlinux file (plus includes)
without actually booting anything. I actually did look at it a few
weeks back.

Your approach is easier. I can easily add my patches on top of yours
once they land.

>
> In my attempt at multi-bootflows I just pass an extra 'seq' parameter
> to each bootmeth. If all bootflows on a partition are exhausted, or if
> the bootmeth in question doesn't support multiple bootflows per
> partition (and seq > 0 is passed) they return -ENOENT, so that the
> caller can proceed to the next (bootdev, bootmeth, partition) tuple.
> Otherwise the caller repeats with the same tuple until it gets
> -ENOENT. So no extra flag to indicate the multi-bootflow capability as
> in your version.

I'm not wedded to the flag - we can update other bootmeths to return
-ENOENT if the seq is non-zero.

>
> For BLS, I store an alist caching all discovered entries per partition
> inside the `priv` structure to avoid needlessly repeating directory
> operations.

So long as you handle clearing that out, that seems fine.

>
> > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > @@ -0,0 +1,333 @@
> > > > > +     ret =3D pxe_setup_ctx(&ctx, &cmdtp, bls_getfile, &info, tru=
e,
> > > > > +                         NULL, false, false);
> > > >
> > > > Just to check, how does this behave when the entry is found under a
> > > > non-empty prefix? bls_pick_entry() searches every bootstd prefix, b=
ut
> > > > the prefix the winning entry came from is not recorded. The spec sa=
ys
> > > > paths in an entry are relative to the root of $BOOT, so for an entr=
y
> > > > under '/boot/loader/entries/' the kernel must be fetched from
> > > > '/boot/...', yet with allow_abs_path set and a NULL bootfile,
> > > > get_relfile() uses the absolute path from the partition root and th=
e
> > > > lookup will miss. I suspect you need to remember the discovered pre=
fix
> > > > (bflow->subdir is a natural place, and is freed automatically) and
> > > > prepend it when fetching files.
> > >
> > > Hmm, I am booting it with a non-empty prefix and it works as-is (I us=
e
> > > a single ext4 partition for the root fs, and my entries are under
> > > /boot, i.e. there is this "boot/" prefix from the root of the
> > > partition to get to "loader/entries").
> > >
> > > My loader entries use full absolute paths including the "/boot"
> > > component, which is the way systemd's 90-loaderentry.install creates
> > > them in this setup. Or did you mean that this behavior is not
> > > spec-compliant? Not sure if prefixes are spec-compliant anyway, but
> > > definitely useful as an extension.
> >
> > Ah OK. I was thinking of extlinux - but what happens if you don't use
> > full absolute paths? There is the case where the boot partition is a
> > separate filesystem and the OS files are there, so the running system
> > sees the file as e.g. /boot/vmlinux (since the boot partition is
> > mounted at /boot) but U-Boot sees it as /vmlinux (since it does not
> > have a VFS).
>
> I will recheck with a separate partition and paths stemming from its
> root (i.e. /vmlinuz or /[entry-key]/[entry-id]/linux), thank you!

Good to have a test :-)

Regards,
Simon
