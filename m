Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7B5CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD1B5847C8;
	Thu, 25 Jun 2026 17:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="q6fuiTB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01348495B; Thu, 25 Jun 2026 17:52:10 +0200 (CEST)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com
 [IPv6:2607:f8b0:4864:20::1330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0D084704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-30bbe98c3f0so90176eec.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782402727; cv=none;
 d=google.com; s=arc-20260327;
 b=HIp69bxIgDo5NBKZruc/MDbVXRT0L1SK6mgevnIgffHdH1Y5TZ5VuQ/U/6fsuoS0Az
 2gmPlBhuys8y9oUsYSZ7u6s3O2J4JO7DLxM8T6Eo+yYHdOrpo6QbILNGyFSxrYNpTUdo
 xoJYLL2+sqgPvbqMgF7eexBqCCl1ljUvRvDQ//LbLpR0ccUNoOj5MR+/zCAEHs8Ipc2t
 aAuzIOKHhkC+5ba0sP/yIToD+UeZWy7qUHkWeMEbxVE0HR/RsMVTSHVV2+KGjVEIUusH
 A0vvb9YyohqbMOECiSUyRChe7iGcl43sJ1v76KbiltEbANR+nNqwSeuodc7FD76U5a7f
 gxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cQavkKZn/RlXBbQ1X3EUcWdQzbkLkK4KGWSY0KZTJ8A=;
 fh=8OafM7syIYD4I3cfYAEnZ4Jif8pOP9EXMhdaii9d4Ro=;
 b=Wr4wNgIApae9VinKTJtpDEHzeQ7q15xcVTCe9iwo+KfnHPgYCtH1lj6UMkCrEfVDnP
 m/1Rq54VAnQ//RAOh1m7w+ymAzTvIoV3WGa79NiDqhYbLS6BRxkM4djvx3RSWFP2cYV3
 u3piQJtz5f3DmTEhe5iTI1H7xSs1DauiKGzOg7OM59Noez59q7Coma1qNCVcJr+BnUSy
 wgN6loQwy9ImEd2nfyQSEeMqe8+lag6yCLiBRoSKs/p41YEZEVR7pXLHbJmgbRduBqvV
 aYSLVKZR5bBmk5dbrgmWPom3jZ5Y0x9k55FWCFVsefsAiRNq3omDxRirQJJIE61ka1Ff
 uANg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782402727; x=1783007527; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQavkKZn/RlXBbQ1X3EUcWdQzbkLkK4KGWSY0KZTJ8A=;
 b=q6fuiTB8+r5rK8be+c3lfRwvV7jUEjfD0MMpok1pqb7tZDDLm1LM2vXPrtvsjGDYHJ
 Nww4cFimXK8jn9w1sVwPeEwAnR0o4pzuR+LrxFcnLT67L/0CBalvx5PHdM8vl7G8mkB/
 da9JS0Hc/y27a/oBrYpWmCt8yeNx6t3oY0LpcJN/X2XMRiBGVQCvE8UQQMNMeSJ7CbAI
 TGudHUa4Lg6ZItQX0YB+fzmi/24y48YUi6IwaUcZXPhbGLJd7DpZW2jSnOmvWRBHjutY
 /EX/5Oy3dj1Fs0wsl8ak2/cKF2LsEOWql/0181mjasVhCrAuFk/5KCFqxHoBfkkSrMz+
 xCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782402727; x=1783007527;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cQavkKZn/RlXBbQ1X3EUcWdQzbkLkK4KGWSY0KZTJ8A=;
 b=bmGwE7PsuWIgY91BD9p5es1Z4wF5AKjC4R3x4gfjX7gxfqjp4oZaMOx+k6rYaSFoKc
 CZAD6h1/VmlIYoNz3T5jwUGhBc0OxcDnUMvqwjKu6HFUAXPPsvRSa71MIfInVeTfUgg6
 sAW/rbv3pvH2L4H4ax7WMri4SW/1yDKqdVCpHXRTductkrUciDhO9oCL6L6szi9e2qmF
 vTPLret9RhDKnRt3E6TRPhvHlYNUnHMGrrTR+eORGG8mE2J03rnFLu/2n+Eo3oDF8WwQ
 bEWpmvTFplHAR7r3aeEip+hG1DiidfAHuhgPUFb7CHhzr2qkXdfd+mEtwKaEq4BWNIvJ
 Vs0Q==
X-Gm-Message-State: AOJu0Yz+9oznIWpMVaRg/ThFEyFDl4x0CztA+VKJqHQaL/da14VBhQU2
 tiacwcgEKR2VXgzMNtGkSImIQjaAwFIknOiVFlM3HrdLtlUQu2bv8Vtl0RlArIU8pPNm32Ci0Qw
 vDhOMs2mJ/Tobr0ssoQH/3PZxBMtxfh0XoAsHkBxVGQ==
X-Gm-Gg: AfdE7clYr9dzwfiBhYnU83kJbWpLRpsgEIsb2l2FrdL0h95ynxTcRhXuXOJbc0hz8Nt
 QJ9vbB8pBJMNtAO9cLmrD9OXNfKshEgzmHrwob+noA/9zGuGptirvxl5ZmaomFVyOesnC2oUL0C
 idB9yBJUbd3yqwAXg9vogc7tsH45zOkjYjmshJxSVFVAe7bDIWwQvZMfA9/Rt+pRmvdgdn4p4lE
 8lt5t1Rk2NXw/pQv8fOS7RkEVD82+lVUDbtctll/8nnFSnpQV88nrrKU65/cVZPh9NlMIJw1JZ3
 cKt+afPsLEQAEDnDcbevGBWxfcb/dQ==
X-Received: by 2002:a05:7300:80ce:b0:30c:b2:eceb with SMTP id
 5a478bee46e88-30c84d6c33amr3790989eec.23.1782402726645; Thu, 25 Jun 2026
 08:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-7-4ce6d1ee4711@flipper.net>
 <CAFLszTikihqsUmOGdmb8Q9WypiEHb0nq-a7vXH5XrXNxRVeNjg@mail.gmail.com>
In-Reply-To: <CAFLszTikihqsUmOGdmb8Q9WypiEHb0nq-a7vXH5XrXNxRVeNjg@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 25 Jun 2026 19:51:54 +0400
X-Gm-Features: AVVi8CfTnywUg-wG5Ek9Ya3X6_LAsBsU1ijo1rRKYewovUEzwp8uvk9ZfdjL1ZA
Message-ID: <CAKTNdwEkt+YMq-SG=PVTGzGztyeujVr=fEje74NnSbBbiswd7w@mail.gmail.com>
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

Hi Simon,

On Thu, Jun 25, 2026 at 7:28=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Alexey,
>
> On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net> wrote:
> > boot: add a minimal bootmeth for the Boot Loader Specification
> >
> > Add a bootmeth that finds and boots Boot Loader Specification (BLS)
> > type #1 entry files [1]. On each block-device partition it scans, the
> > bootmeth looks for files matching '<prefix>loader/entries/*.conf'
> > (where <prefix> comes from bootstd_get_prefixes(), typically '/' and
> > '/boot/'), picks the highest-sorting filename, parses it, and exposes
> > it as a bootflow.
> >
> > Implementation reuses the existing pxelinux infrastructure.
> >
> > For now the entry chosen on a partition is purely the lexicographic
> > maximum of *.conf filenames; sort-key / version field handling
> > (spec-mandated tiebreakers) and boot-counting (the '+TRIES_LEFT'
> > filename suffix) are left as TODOs. Likewise, only the top-sorted entry
> > is surfaced because the bootstd framework currently allows one bootflow
> > per (bootmeth, partition); exposing every discovered entry will require
> > a framework extension.
> >
> > Type #2 BLS (drop-in directory of EFI binaries) is out of scope here;
> > [...]
> >
> > boot/Kconfig        |  17 +++
> >  boot/Makefile       |   1 +
> >  boot/bootmeth_bls.c | 333 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 351 insertions(+)
>
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > @@ -649,6 +649,23 @@ config BOOTMETH_EXTLINUX_PXE
> > +config BOOTMETH_BLS
> > +     bool "Bootdev support for Boot Loader Specification entries"
> > +     select PXE_UTILS
> > +     default y
>
> Wherever the 'default y' discussion lands, this will be enabled on
> sandbox, so the 'bootmeth list' tests in test/boot/bootmeth.c will
> fail since they check the exact list and count. Please can you run the
> sandbox tests and update them as needed?
>
> Since you are adding a new bootmeth you also need a sandbox test that
> exercises it (see the extlinux tests in test/boot/bootflow.c, with a
> fixture disk image) and a documentation page, e.g.
> doc/develop/bootstd/bls.rst with an entry in the index there.

Will do, thanks!

> > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > @@ -0,0 +1,333 @@
> > +static int bls_getfile(struct pxe_context *ctx, const char *file_path,
> > +                    char *file_addr, enum bootflow_img_t type, ulong *=
sizep)
>
> This is a verbatim copy of extlinux_getfile() - please can you export
> that, or move it into a shared helper?

Ack

> > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > @@ -0,0 +1,333 @@
> > +     ret =3D bootmeth_alloc_file(bflow, SZ_64K, 1, BFI_EXTLINUX_CFG);
>
> The extlinux bootmeth passes ARCH_DMA_MINALIGN here, since the buffer
> is filled by a block-device read which may use DMA on some platforms.
> An alignment of 1 risks cache-line corruption there, so please use
> ARCH_DMA_MINALIGN.

Ack

> > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > @@ -0,0 +1,333 @@
> > +     bflow->bootmeth_priv =3D label;
> > +     free(fpath);
>
> This leaks memory: bootflow_free() releases bootmeth_priv with a plain
> free(), so the label's string members (name, menu, kernel, append,
> initrd, etc.) are never freed - for every bootflow discarded after a
> scan, not just on error paths.
>
> Since get_string() copies tokens out of the buffer rather than
> modifying it in place, you could follow the extlinux approach: keep
> only bflow->buf across the scan (already populated by
> bootmeth_alloc_file() and freed by the framework), use a temporary
> label in bls_read_bootflow() just to extract the title, destroy it
> with label_destroy(), and re-parse the buffer in bls_boot(). Then
> bootmeth_priv is not needed at all. What do you think?

Will address the leak, thanks for pointing it out!

The bls_priv structure is needed for my follow-up extension which
allows multiple boot entries to be returned by each (bootdev,
bootmeth, partition) tuple, and I wanted to minimize churn between
those two. I haven't sent that follow-up for review yet, as I wanted
to confirm this simpler version is acceptable first.

> > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > @@ -0,0 +1,333 @@
> > +     ret =3D pxe_setup_ctx(&ctx, &cmdtp, bls_getfile, &info, true,
> > +                         NULL, false, false);
>
> Just to check, how does this behave when the entry is found under a
> non-empty prefix? bls_pick_entry() searches every bootstd prefix, but
> the prefix the winning entry came from is not recorded. The spec says
> paths in an entry are relative to the root of $BOOT, so for an entry
> under '/boot/loader/entries/' the kernel must be fetched from
> '/boot/...', yet with allow_abs_path set and a NULL bootfile,
> get_relfile() uses the absolute path from the partition root and the
> lookup will miss. I suspect you need to remember the discovered prefix
> (bflow->subdir is a natural place, and is freed automatically) and
> prepend it when fetching files.

Hmm, I am booting it with a non-empty prefix and it works as-is (I use
a single ext4 partition for the root fs, and my entries are under
/boot, i.e. there is this "boot/" prefix from the root of the
partition to get to "loader/entries").

My loader entries use full absolute paths including the "/boot"
component, which is the way systemd's 90-loaderentry.install creates
them in this setup. Or did you mean that this behavior is not
spec-compliant? Not sure if prefixes are spec-compliant anyway, but
definitely useful as an extension.

> > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > @@ -0,0 +1,333 @@
> > +U_BOOT_DRIVER(bootmeth_2bls) =3D {
>
> The number prefix sets the default bootmeth ordering, so this places
> BLS after extlinux but ahead of script, efi_mgr and efi on every board
> - and '2' is already used by bootmeth_2script, making the relative
> order of those two non-obvious. Please can you add a comment like the
> one in bootmeth_extlinux.c explaining the choice, and say in the
> commit message why this position is the right one?

It should perhaps just lose the number, as there is no legacy to
consider here the way there was one for extlinux. Will adjust in v2.

Thank you for your review!

Best regards,
Alexey
