Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D435CDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 16:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B71484704;
	Thu, 25 Jun 2026 18:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J2xPiL1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A00F5847C8; Thu, 25 Jun 2026 18:25:00 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFC29805D7
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 18:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6980ae819f4so6935a12.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 09:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782404697; cv=none;
 d=google.com; s=arc-20260327;
 b=SwnYwneB0UKZ3vBXzLksnAmHZFxU6o8OOqXwn/wKuqtubx+2Kt/fljpTwUDLo/dHDv
 C59ZtrByGk6uoVufiWeyRbOmgODP9RE7XhOVykyshuBKexpOOh45scXAwqBHbg9ObeWt
 Ol2lKgBBDiJPufdU3mZOdg97qlyrIL59+eR/red5lsrZOxyi705+WUh0j4Nd8Fv7NsHx
 5J/ocx7+MyA7KUTCj3H5uKgAqYPU6/Qfvwc7mmCNn3242GVf2xNxbp0WhmlQ1szxQ+fP
 0IaEOHCbUWBJ2aBlY1pzZ8hIqG3G2FiklcooJ5l7XVOE9ZKOSc1PpHkI6rcaxrvnoTVv
 LirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/s5ZmGVogIblYYBr7x8UlABtswJrUhiGJDq64odpZwc=;
 fh=1IBpGH+Xd/YdfaKFMxo1vol56mWfSqB2hhB/lOynXBQ=;
 b=n2BNyXW7v1JlrfH4hZBdLzRb/HBfjnzn60FB3f5yoD55cEOwI9YKywOhfJpidTFC6r
 7vZIp4A5n1Ks6yva79H9AJTKHdmc5aXnz/y4T0HctaV7V5pz3jaIXiRNWRSQUoVMcmqe
 JTQVGVuoWcEocGD9XPo0XitJaPpevo4JMH0cdqakSCDBynMiqmcnvwWV2+DSC8EZ74nX
 KbEOX1SUBcQYJ+IO+IoGrbi+HY3t59VOJw8BIFopquV91+pItDydKPbAr47n8WkvwHJv
 wni8w08cd5M9iNBYg9he/rAp9Wd+ugTHNxd0oRdfDjBhpgDQTicatD5eJ/4HxrfW5JEC
 RaWg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782404697; x=1783009497; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/s5ZmGVogIblYYBr7x8UlABtswJrUhiGJDq64odpZwc=;
 b=J2xPiL1h9xC3vJT5LGLhl1nljJ4CPH72csq3LErUn8c2tze6D4W25d5joP50dQISHC
 LDAM3QqBjuuZirEgbEmabhiF4EdWonflThPK5YKhbKLJbxd2HihHkWWaPjUL250/V3Wf
 gxVVk5Zi9Y69yen2xaYPF36seEro9Ubsjm3sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782404697; x=1783009497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/s5ZmGVogIblYYBr7x8UlABtswJrUhiGJDq64odpZwc=;
 b=EVoKtZbopuuqYSrNnZPBHY1ZLwqvHYrs0hNtWIJNOO1Ex2T+BBVWU1BKDROeqqAX4p
 bKmcIIYMJDp8TE7Vk+Gza82+UihII0rpE5sGB9Qhfng/tqMRWmQmEDgCSeqb6l0hnjAF
 3r2hvuCVekWEPwJLm806nKPxekeZn+05E0lk3pMtMbdJPUG1DIub8KMPMdsGNsZodGZj
 9wOaVficbjBkSwEEQbnqtUui2h5TjmQU75Ru3td9BDPIFrq+p+t0M+06d0ZNg2U0c5wd
 kifxloTvaw5G8Y1IhNdh3b2rkSkWHV/M9kakrY1VKc3g89CO3qHCWoQL5xck/JEcK6tF
 wb8w==
X-Gm-Message-State: AOJu0Yw5vhJrZlfRn706jYYJlk6H20R7s3A4kwY7cpusWIpZSIQdSSF1
 sTPVGjwJxzX3WlQHt6Tv3KYMX0BUpbUB6atSrMCvasoWMuRKyVwMs4dTYYsr7I5b6NKSHvI+01Z
 TcGxlVh2feTUpW1kvDEr3UTGBVF0GTgDSokbl34DG
X-Gm-Gg: AfdE7cmxD3yGQD4wNTeGT0Yao+/8ZQx8WCe9MJb6Fhq2wQromhs9zE3g1AI0lAXtKVp
 Un7rzqdikJMbAgf0v4TOaoa2qZldUS9KlCWBEnX02lsLCC6Qdc0xdnb899CMU11P7gT6N9OrNgs
 cRlSowOSBqVObGLnAb979VFT8N3lDmvCub0Vrqq8FI7FM1413INDj6xipEU3/wNjCdZkrJf/hd9
 A9AwgSdEk659T393NgsJBwHA+zqYxnnSugMHGIQA2n4PNFaNYJEJvuaxj8PnUPghZWzQC5mZA==
X-Received: by 2002:a05:6402:a50d:20b0:698:1f55:94f with SMTP id
 4fb4d7f45d1cf-6981f5509d4mr28631a12.10.1782404697084; Thu, 25 Jun 2026
 09:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-7-4ce6d1ee4711@flipper.net>
 <CAFLszTikihqsUmOGdmb8Q9WypiEHb0nq-a7vXH5XrXNxRVeNjg@mail.gmail.com>
 <CAKTNdwEkt+YMq-SG=PVTGzGztyeujVr=fEje74NnSbBbiswd7w@mail.gmail.com>
In-Reply-To: <CAKTNdwEkt+YMq-SG=PVTGzGztyeujVr=fEje74NnSbBbiswd7w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 17:24:44 +0100
X-Gm-Features: AVVi8CeRB4kN-aMIvku2OFXGsEkuWlORpPDLbKcHlY51HLcUGhTuyLrFfPlsc1c
Message-ID: <CAFLszTg7DJW4b0JhuPgCQe2TdMEdUagdGqRu7UG_j__S=4MjMQ@mail.gmail.com>
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

On Thu, 25 Jun 2026 at 16:52, Alexey Charkov <alchark@flipper.net> wrote:
>
> Hi Simon,
>
> On Thu, Jun 25, 2026 at 7:28=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Alexey,
> >
> > On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net> wrote:
> > > boot: add a minimal bootmeth for the Boot Loader Specification
> > >
> > > Add a bootmeth that finds and boots Boot Loader Specification (BLS)
> > > type #1 entry files [1]. On each block-device partition it scans, the
> > > bootmeth looks for files matching '<prefix>loader/entries/*.conf'
> > > (where <prefix> comes from bootstd_get_prefixes(), typically '/' and
> > > '/boot/'), picks the highest-sorting filename, parses it, and exposes
> > > it as a bootflow.
> > >
> > > Implementation reuses the existing pxelinux infrastructure.
> > >
> > > For now the entry chosen on a partition is purely the lexicographic
> > > maximum of *.conf filenames; sort-key / version field handling
> > > (spec-mandated tiebreakers) and boot-counting (the '+TRIES_LEFT'
> > > filename suffix) are left as TODOs. Likewise, only the top-sorted ent=
ry
> > > is surfaced because the bootstd framework currently allows one bootfl=
ow
> > > per (bootmeth, partition); exposing every discovered entry will requi=
re
> > > a framework extension.
> > >
> > > Type #2 BLS (drop-in directory of EFI binaries) is out of scope here;
> > > [...]
> > >
> > > boot/Kconfig        |  17 +++
> > >  boot/Makefile       |   1 +
> > >  boot/bootmeth_bls.c | 333 ++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 351 insertions(+)
> >
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > @@ -649,6 +649,23 @@ config BOOTMETH_EXTLINUX_PXE
> > > +config BOOTMETH_BLS
> > > +     bool "Bootdev support for Boot Loader Specification entries"
> > > +     select PXE_UTILS
> > > +     default y
> >
> > Wherever the 'default y' discussion lands, this will be enabled on
> > sandbox, so the 'bootmeth list' tests in test/boot/bootmeth.c will
> > fail since they check the exact list and count. Please can you run the
> > sandbox tests and update them as needed?
> >
> > Since you are adding a new bootmeth you also need a sandbox test that
> > exercises it (see the extlinux tests in test/boot/bootflow.c, with a
> > fixture disk image) and a documentation page, e.g.
> > doc/develop/bootstd/bls.rst with an entry in the index there.
>
> Will do, thanks!
>
> > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > @@ -0,0 +1,333 @@
> > > +static int bls_getfile(struct pxe_context *ctx, const char *file_pat=
h,
> > > +                    char *file_addr, enum bootflow_img_t type, ulong=
 *sizep)
> >
> > This is a verbatim copy of extlinux_getfile() - please can you export
> > that, or move it into a shared helper?
>
> Ack
>
> > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > @@ -0,0 +1,333 @@
> > > +     ret =3D bootmeth_alloc_file(bflow, SZ_64K, 1, BFI_EXTLINUX_CFG)=
;
> >
> > The extlinux bootmeth passes ARCH_DMA_MINALIGN here, since the buffer
> > is filled by a block-device read which may use DMA on some platforms.
> > An alignment of 1 risks cache-line corruption there, so please use
> > ARCH_DMA_MINALIGN.
>
> Ack
>
> > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > @@ -0,0 +1,333 @@
> > > +     bflow->bootmeth_priv =3D label;
> > > +     free(fpath);
> >
> > This leaks memory: bootflow_free() releases bootmeth_priv with a plain
> > free(), so the label's string members (name, menu, kernel, append,
> > initrd, etc.) are never freed - for every bootflow discarded after a
> > scan, not just on error paths.
> >
> > Since get_string() copies tokens out of the buffer rather than
> > modifying it in place, you could follow the extlinux approach: keep
> > only bflow->buf across the scan (already populated by
> > bootmeth_alloc_file() and freed by the framework), use a temporary
> > label in bls_read_bootflow() just to extract the title, destroy it
> > with label_destroy(), and re-parse the buffer in bls_boot(). Then
> > bootmeth_priv is not needed at all. What do you think?
>
> Will address the leak, thanks for pointing it out!
>
> The bls_priv structure is needed for my follow-up extension which
> allows multiple boot entries to be returned by each (bootdev,
> bootmeth, partition) tuple, and I wanted to minimize churn between
> those two. I haven't sent that follow-up for review yet, as I wanted
> to confirm this simpler version is acceptable first.

We should implement this using an generic index rather than something
bls-specific...please see some commits at:

https://concept.deinde.dev/u-boot/u-boot/-/merge_requests/782

>
> > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > @@ -0,0 +1,333 @@
> > > +     ret =3D pxe_setup_ctx(&ctx, &cmdtp, bls_getfile, &info, true,
> > > +                         NULL, false, false);
> >
> > Just to check, how does this behave when the entry is found under a
> > non-empty prefix? bls_pick_entry() searches every bootstd prefix, but
> > the prefix the winning entry came from is not recorded. The spec says
> > paths in an entry are relative to the root of $BOOT, so for an entry
> > under '/boot/loader/entries/' the kernel must be fetched from
> > '/boot/...', yet with allow_abs_path set and a NULL bootfile,
> > get_relfile() uses the absolute path from the partition root and the
> > lookup will miss. I suspect you need to remember the discovered prefix
> > (bflow->subdir is a natural place, and is freed automatically) and
> > prepend it when fetching files.
>
> Hmm, I am booting it with a non-empty prefix and it works as-is (I use
> a single ext4 partition for the root fs, and my entries are under
> /boot, i.e. there is this "boot/" prefix from the root of the
> partition to get to "loader/entries").
>
> My loader entries use full absolute paths including the "/boot"
> component, which is the way systemd's 90-loaderentry.install creates
> them in this setup. Or did you mean that this behavior is not
> spec-compliant? Not sure if prefixes are spec-compliant anyway, but
> definitely useful as an extension.

Ah OK. I was thinking of extlinux - but what happens if you don't use
full absolute paths? There is the case where the boot partition is a
separate filesystem and the OS files are there, so the running system
sees the file as e.g. /boot/vmlinux (since the boot partition is
mounted at /boot) but U-Boot sees it as /vmlinux (since it does not
have a VFS).

>
> > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > @@ -0,0 +1,333 @@
> > > +U_BOOT_DRIVER(bootmeth_2bls) =3D {
> >
> > The number prefix sets the default bootmeth ordering, so this places
> > BLS after extlinux but ahead of script, efi_mgr and efi on every board
> > - and '2' is already used by bootmeth_2script, making the relative
> > order of those two non-obvious. Please can you add a comment like the
> > one in bootmeth_extlinux.c explaining the choice, and say in the
> > commit message why this position is the right one?
>
> It should perhaps just lose the number, as there is no legacy to
> consider here the way there was one for extlinux. Will adjust in v2.
>
> Thank you for your review!

You're welcome, thanks for your efforts on this!

Regards,
Simon
