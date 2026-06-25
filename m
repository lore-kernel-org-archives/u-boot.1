Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF1FCDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 16:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DE7B84704;
	Thu, 25 Jun 2026 18:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="ahj0felw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64C59847C8; Thu, 25 Jun 2026 18:57:28 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F7DB8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 18:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-697e93b0d9bso2528393a12.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 09:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782406645; cv=none;
 d=google.com; s=arc-20260327;
 b=l5MGRvDNk+LX5C1BSKe9U8tqXhjp5YX79TDX5WA4n18B1L5JyF5H9cFLrDfenfwsAx
 SJtoJMUj1Elbs+W1N7v8IRubnJXaJm+Jz2AC6hyQSvnlTjiNkifNgM7BovvzU3ieg6NU
 UjjckT2Iv3R7KjYZbsrCXfdIwgrXw737r4SZS4Cc+tnEEcFLEcUnv1WbLppm9SApryFA
 gByxPad1abgmRQFAVoJlmYGATCn3xPl+EBBY1BlVkjWejSifrW54zo8rykB8K6nMan7Z
 WyBtbmmmGxMs30OamvxdtS+OedSo1BzoDP2p3/3vzgBz88WNoCc2FYo/l0gRhfYdMt03
 M8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2rHg8asvG15So52meFTm0mCCMVw8tl6BzH2KUB2Cmew=;
 fh=8OafM7syIYD4I3cfYAEnZ4Jif8pOP9EXMhdaii9d4Ro=;
 b=ig6+cicZb0jdXr5E50V1UpBKowO4H3+cySb8IOHVGrMvgbZaAuspfRJarUq1CJqG5B
 32ng7aXeSoZZYGFyLAelJnE5CXJ/ZQT70b237FGjsVRDOs01clEA9UmR79FszTU21In+
 byivu7p6d7R2fOi4MifRjTvfw1aZeJhTMoRLuLZMSPapB40zcUGOHWbL05pBMznDMVm/
 +jNMngzJQAbjXq3unmkMMikd8S0RPtv50428nLCENaJcCxGZ/+yR1wkGjfBWDfZOVpBc
 ETE2AC0GuBZ4nkoBEgDkUeUGntjsd+O0Hxaqt9Mg82YAFSk1+HWKYSuH5WqfnLXdLgIq
 ekEQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782406645; x=1783011445; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2rHg8asvG15So52meFTm0mCCMVw8tl6BzH2KUB2Cmew=;
 b=ahj0felw9SAs5+5Xd5Qqj4Cwc8NfLeOKtWFskw0KyzkDyG6CfpArkv3zObKQ8p8+n4
 V16FAF3hirHRb2+COMlFZ/ipT3ywO0/RisZYsufbrJZuhvteE3TRRaav8pygysR5gY8c
 RU6N7yyagCiJYmEHnGQHWlk4Utw0rIl3Gw7nUrsGJLFtnxh2Rct396IT5Li8s593CXTp
 GMq2Ek04rVeXsJ2Y6kqFr3BePShStwxDZH6WwhH3jkQ4yhm7HPJ5vLihIENHMjjzaqbp
 NH3RbUkiFCPEn9sx6wNT/A2Q8qv/pa9DqY8QjBPqH/IyQQbT781AndGh+5y036bhhOf7
 x14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782406645; x=1783011445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2rHg8asvG15So52meFTm0mCCMVw8tl6BzH2KUB2Cmew=;
 b=tTeAtjKzwbFNnREwnE5xXNsvQvDSaW1d4eTMsifEyPc2UzduzrpiTnFtkK0/DnANeQ
 rd8GK9cXh65XI70cuLKvqCVW1m6po5/gpBZPOSlLg77rM+KG8xJxkcYEpDoF97fZiZTX
 Ytvw0+JwlEQKGEj5RU3Jtb4o8P0tIAayPKIE4/KsFqOLa322Y2IydG8i9t4N+HPkfjIB
 S6Y7an3bT99vERHzh0zS3SAWz9/NAOX+bx6xXhUiOpT5u4EQpufNTF+TwC8OB/YQkjvl
 UYmQZBBvypM43QcmhvDa/a8+kTQcGP33BAlmfJKNmzICC3x9GcNfE9PJC8418sfXCEbq
 Iu4w==
X-Gm-Message-State: AOJu0Yyo209XwgVLiSn/3edBQDPfaK1xo/hqEn5elCcVItx7giylampK
 LSLUxrs4bSZkhb42O7kx+O1B1WEFjtNSLW9fq/ALiD7soo4RhJwm6N18QS8+7AZzLE+vSqAYJjv
 Og1hoTmgHvrFK+Qtr1Jh5ywkH5AC4YN5jYRdkyDc5hQ==
X-Gm-Gg: AfdE7ck6j6VNyJQCqmHXxXTpsKSot2dkGD3Ci0ah2WTbtYTLlk/tBXRZW7L8EQAqRQE
 Bq5dY6H20q3iLgLDxTw4nuK/HYkOvqm1kPdB47NejPnculSI+YEzzLG/KTKwWhCbxPFL59Flqd9
 114ewPVElWmWzeIy9S7BO1wEAOPTY4pa7hA37tcIUBeGog22SRpQmbTDku7k81B0o5Nk/FuNpw/
 AassogjlTbFePElMphpIH7gPMx48nJH+p1yxC0Kf+ocmpWbtsQcHFAXJQQL/VbTehc4PDg2ei/0
 rRdJXERUL+HnCxT6XHUh7Y80hWEYXA==
X-Received: by 2002:a17:907:9808:b0:c12:432:1239 with SMTP id
 a640c23a62f3a-c1205e78bdcmr271315566b.19.1782406644578; Thu, 25 Jun 2026
 09:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-7-4ce6d1ee4711@flipper.net>
 <CAFLszTikihqsUmOGdmb8Q9WypiEHb0nq-a7vXH5XrXNxRVeNjg@mail.gmail.com>
 <CAKTNdwEkt+YMq-SG=PVTGzGztyeujVr=fEje74NnSbBbiswd7w@mail.gmail.com>
 <CAFLszTg7DJW4b0JhuPgCQe2TdMEdUagdGqRu7UG_j__S=4MjMQ@mail.gmail.com>
In-Reply-To: <CAFLszTg7DJW4b0JhuPgCQe2TdMEdUagdGqRu7UG_j__S=4MjMQ@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 25 Jun 2026 20:57:13 +0400
X-Gm-Features: AVVi8CcYbYsBhsmC0dtUHBXZ6uFwqYbhHe7oaG4LfFNEx8OY187Sk0AsCM0r14M
Message-ID: <CAKTNdwEJuQ_6ROpKb+b_anFH7GbaT8NA2dvmxWmS_m8RSUYxTw@mail.gmail.com>
Subject: Re: [PATCH 7/7] boot: add a minimal bootmeth for the Boot Loader
 Specification
To: Simon Glass <sjg@chromium.org>
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

On Thu, Jun 25, 2026 at 8:24=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Alexey,
>
> On Thu, 25 Jun 2026 at 16:52, Alexey Charkov <alchark@flipper.net> wrote:
> >
> > Hi Simon,
> >
> > On Thu, Jun 25, 2026 at 7:28=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Alexey,
> > >
> > > On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net> wrote:
> > > > boot: add a minimal bootmeth for the Boot Loader Specification
> > > >
> > > > Add a bootmeth that finds and boots Boot Loader Specification (BLS)
> > > > type #1 entry files [1]. On each block-device partition it scans, t=
he
> > > > bootmeth looks for files matching '<prefix>loader/entries/*.conf'
> > > > (where <prefix> comes from bootstd_get_prefixes(), typically '/' an=
d
> > > > '/boot/'), picks the highest-sorting filename, parses it, and expos=
es
> > > > it as a bootflow.
> > > >
> > > > Implementation reuses the existing pxelinux infrastructure.
> > > >
> > > > For now the entry chosen on a partition is purely the lexicographic
> > > > maximum of *.conf filenames; sort-key / version field handling
> > > > (spec-mandated tiebreakers) and boot-counting (the '+TRIES_LEFT'
> > > > filename suffix) are left as TODOs. Likewise, only the top-sorted e=
ntry
> > > > is surfaced because the bootstd framework currently allows one boot=
flow
> > > > per (bootmeth, partition); exposing every discovered entry will req=
uire
> > > > a framework extension.
> > > >
> > > > Type #2 BLS (drop-in directory of EFI binaries) is out of scope her=
e;
> > > > [...]
> > > >
> > > > boot/Kconfig        |  17 +++
> > > >  boot/Makefile       |   1 +
> > > >  boot/bootmeth_bls.c | 333 ++++++++++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  3 files changed, 351 insertions(+)
> > >
> > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > @@ -649,6 +649,23 @@ config BOOTMETH_EXTLINUX_PXE
> > > > +config BOOTMETH_BLS
> > > > +     bool "Bootdev support for Boot Loader Specification entries"
> > > > +     select PXE_UTILS
> > > > +     default y
> > >
> > > Wherever the 'default y' discussion lands, this will be enabled on
> > > sandbox, so the 'bootmeth list' tests in test/boot/bootmeth.c will
> > > fail since they check the exact list and count. Please can you run th=
e
> > > sandbox tests and update them as needed?
> > >
> > > Since you are adding a new bootmeth you also need a sandbox test that
> > > exercises it (see the extlinux tests in test/boot/bootflow.c, with a
> > > fixture disk image) and a documentation page, e.g.
> > > doc/develop/bootstd/bls.rst with an entry in the index there.
> >
> > Will do, thanks!
> >
> > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > @@ -0,0 +1,333 @@
> > > > +static int bls_getfile(struct pxe_context *ctx, const char *file_p=
ath,
> > > > +                    char *file_addr, enum bootflow_img_t type, ulo=
ng *sizep)
> > >
> > > This is a verbatim copy of extlinux_getfile() - please can you export
> > > that, or move it into a shared helper?
> >
> > Ack
> >
> > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > @@ -0,0 +1,333 @@
> > > > +     ret =3D bootmeth_alloc_file(bflow, SZ_64K, 1, BFI_EXTLINUX_CF=
G);
> > >
> > > The extlinux bootmeth passes ARCH_DMA_MINALIGN here, since the buffer
> > > is filled by a block-device read which may use DMA on some platforms.
> > > An alignment of 1 risks cache-line corruption there, so please use
> > > ARCH_DMA_MINALIGN.
> >
> > Ack
> >
> > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > @@ -0,0 +1,333 @@
> > > > +     bflow->bootmeth_priv =3D label;
> > > > +     free(fpath);
> > >
> > > This leaks memory: bootflow_free() releases bootmeth_priv with a plai=
n
> > > free(), so the label's string members (name, menu, kernel, append,
> > > initrd, etc.) are never freed - for every bootflow discarded after a
> > > scan, not just on error paths.
> > >
> > > Since get_string() copies tokens out of the buffer rather than
> > > modifying it in place, you could follow the extlinux approach: keep
> > > only bflow->buf across the scan (already populated by
> > > bootmeth_alloc_file() and freed by the framework), use a temporary
> > > label in bls_read_bootflow() just to extract the title, destroy it
> > > with label_destroy(), and re-parse the buffer in bls_boot(). Then
> > > bootmeth_priv is not needed at all. What do you think?
> >
> > Will address the leak, thanks for pointing it out!
> >
> > The bls_priv structure is needed for my follow-up extension which
> > allows multiple boot entries to be returned by each (bootdev,
> > bootmeth, partition) tuple, and I wanted to minimize churn between
> > those two. I haven't sent that follow-up for review yet, as I wanted
> > to confirm this simpler version is acceptable first.
>
> We should implement this using an generic index rather than something
> bls-specific...please see some commits at:
>
> https://concept.deinde.dev/u-boot/u-boot/-/merge_requests/782

Oh, there's already BLS in your tree :-D

Would you like to merge that instead? Your version looks much more
full-fledged. If you happen to have one rebased on master or next I'd
be happy to test!

In my attempt at multi-bootflows I just pass an extra 'seq' parameter
to each bootmeth. If all bootflows on a partition are exhausted, or if
the bootmeth in question doesn't support multiple bootflows per
partition (and seq > 0 is passed) they return -ENOENT, so that the
caller can proceed to the next (bootdev, bootmeth, partition) tuple.
Otherwise the caller repeats with the same tuple until it gets
-ENOENT. So no extra flag to indicate the multi-bootflow capability as
in your version.

For BLS, I store an alist caching all discovered entries per partition
inside the `priv` structure to avoid needlessly repeating directory
operations.

> > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > @@ -0,0 +1,333 @@
> > > > +     ret =3D pxe_setup_ctx(&ctx, &cmdtp, bls_getfile, &info, true,
> > > > +                         NULL, false, false);
> > >
> > > Just to check, how does this behave when the entry is found under a
> > > non-empty prefix? bls_pick_entry() searches every bootstd prefix, but
> > > the prefix the winning entry came from is not recorded. The spec says
> > > paths in an entry are relative to the root of $BOOT, so for an entry
> > > under '/boot/loader/entries/' the kernel must be fetched from
> > > '/boot/...', yet with allow_abs_path set and a NULL bootfile,
> > > get_relfile() uses the absolute path from the partition root and the
> > > lookup will miss. I suspect you need to remember the discovered prefi=
x
> > > (bflow->subdir is a natural place, and is freed automatically) and
> > > prepend it when fetching files.
> >
> > Hmm, I am booting it with a non-empty prefix and it works as-is (I use
> > a single ext4 partition for the root fs, and my entries are under
> > /boot, i.e. there is this "boot/" prefix from the root of the
> > partition to get to "loader/entries").
> >
> > My loader entries use full absolute paths including the "/boot"
> > component, which is the way systemd's 90-loaderentry.install creates
> > them in this setup. Or did you mean that this behavior is not
> > spec-compliant? Not sure if prefixes are spec-compliant anyway, but
> > definitely useful as an extension.
>
> Ah OK. I was thinking of extlinux - but what happens if you don't use
> full absolute paths? There is the case where the boot partition is a
> separate filesystem and the OS files are there, so the running system
> sees the file as e.g. /boot/vmlinux (since the boot partition is
> mounted at /boot) but U-Boot sees it as /vmlinux (since it does not
> have a VFS).

I will recheck with a separate partition and paths stemming from its
root (i.e. /vmlinuz or /[entry-key]/[entry-id]/linux), thank you!

Best regards,
Alexey
