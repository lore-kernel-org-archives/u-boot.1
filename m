Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E8BCDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 323DC847C8;
	Thu, 25 Jun 2026 19:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ClIm2HTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E629D84942; Thu, 25 Jun 2026 19:29:32 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 770C3846F4
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 19:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c0d6c75c58cso11508366b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:29:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782408570; cv=none;
 d=google.com; s=arc-20260327;
 b=XHSbZCoxAO4XDWYIFS0e4xrVCzQi7gy2UtJZJGI7ZZstOBaJbFryIGTjp8Dwf5+7nG
 5r3MSqOYQaEoxNarUsU90mw/73qS0rwRDSfPJGfdBEt67sywSMPwvnrU4KwOjo4yX6BH
 IkbgYmP3XxnKkM6xxvESAjvHPT2IMc2WhOH9g0A5B7jPCqxqx3pl6W+BHrwoomE2Gsa1
 V2oa0EXz1pSeAFLUMwSl6jhPLDGT024mPFEx4vhzGmyJzl01cg5eBO1OEhNVls/WNc77
 P1as2Cj45OYkJQtHRe/Gx/rHrnRML6uXvgbzzZquldjfpF2aS0/93IdIKkTkImxCqF+F
 kyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f3FzFY5cHZydkLByVxp0BBgVrPgdC9hhEQi37HUm3A4=;
 fh=qGSvnoLRuBd/y+HqgM3FQxtyrVNcAIB0PYb2wpCY7E4=;
 b=At1dqiaFiyVB/l5M/KdTnM3J8mHC31Awkvbgfw/mHhDoxswzcrH7ZStJi07Rodyfcv
 0dWbNwTP1bCAr2gyoR8y+9XPqcCTIkA5/KtOVwLyubeOMlez8TgQRoLjeNuTeOT4ZM7O
 kFDnGl6T32Z4glwuRX/bjfyRUrdLcVHrU/5Ax0F1yY2fB8dyO1jJMBLRIYKgKmt5+lAK
 dYhYq+IEQ8aaqMQqVjRTWj1DVc4wYavPPJgedqZIvI/1J6djqpq8FrbApvZ3k43uOU0t
 kaPHJiY0chXfr4G0U1+W6PsKbSXbYmOiKmXFX30aT0AtQeXxsbGIBDQkSqQwCo7247DA
 c2Ug==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782408570; x=1783013370; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3FzFY5cHZydkLByVxp0BBgVrPgdC9hhEQi37HUm3A4=;
 b=ClIm2HTHaZ2Uzz5au+PI7ib0otT7MgpwosmxJLMTLsxr1vQwQyI4JFAcgDjkVo9gdM
 2cxJZzHg45xF6R337OW+L8sL+ClqhC4FZ/revDJOrNvtQfJriItsvwxAr+9UATgc1Qz2
 n3m+Sb0GW8xy98TNhdZg0oy9xcn6l2wcaV7lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408570; x=1783013370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f3FzFY5cHZydkLByVxp0BBgVrPgdC9hhEQi37HUm3A4=;
 b=aEIcZEMTaQZEEDDb2cCMdlS8NWv1fiv/MlT5ZJDABNxS5ehyrsSn7+rgPEtEqXlTkS
 Bff0MBrDScJsnyB0hiYXUVh0MzBDwIMldsGxJNnlFRfsCNNsOxOCaQWFBdFPaKRuAtaU
 lmCqYBG3OSwChhCdShoyJcqBJtlXTxiXAWRYUQdZJIHFK90QGqyDqd3had2cY2VliqWs
 cNJQjugdQz3Ckgoxeb1MPuBPakuqCDgS2NgFcNjEUZG2RMO9WgdOW4+IlSbcwHS/+DZk
 IXkW1YRG3C2in43KtfldWoY2T3W/PD1ICQPJLl0LL4RMnNeXntqsxpJLtJa/zoyO3ww0
 3SWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RozvJjghjmIHBa8oqK11Dmii0MtlZDW7zFK5CfWYGSrk88BYfW2ZYcvJ7X/ymMA6i8m/XhjRrk=@lists.denx.de
X-Gm-Message-State: AOJu0YxofeAqi+P1L2PCitVbwXRGT/FoXawX5sAmXcq7bk/dpr8JncdL
 aQ3Fd1eLsOm4F0dxFT94r3SreM2ByW+jhrpJ53zQ0fZ/96vBUUBkiluTeKLVql9bQqqlWu5HOqp
 BRRvWZjMMWH6+MdprfdLK9bmMlSeyp/+d3a5ljhS7
X-Gm-Gg: AfdE7ckf8kGPOt3Z5/QY2uYJBKLY/P7LCcmSPo5w3718ehF5AwEkD08C4doI8OBD5ZD
 SVnP/VoCuyhm/sUKj/mRcKJ72c6Uzx5uE+bbXLo+sBHHGVJLZbHBZ4HJd28j5bWcNGaNkvaSxFn
 Rjp3UdsSybqyt+saHkMpJ1ufzIGZNkbWC3E9Nw9EHsx0KbCTmAkjeeIsaLvSAonoIzU0a5pXKym
 3HJdfowCFjdPZQlFKzk7as4hFtyUUMUuzxylQG+5SnycvVj3YZvlsRFb0rCRHXwAaRCXySgyQ==
X-Received: by 2002:a17:906:f5a8:b0:bfb:13b8:2ac4 with SMTP id
 a640c23a62f3a-c1205de8db7mr274119666b.13.1782408569827; Thu, 25 Jun 2026
 10:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-7-4ce6d1ee4711@flipper.net>
 <CAFLszTikihqsUmOGdmb8Q9WypiEHb0nq-a7vXH5XrXNxRVeNjg@mail.gmail.com>
 <CAKTNdwEkt+YMq-SG=PVTGzGztyeujVr=fEje74NnSbBbiswd7w@mail.gmail.com>
 <CAFLszTg7DJW4b0JhuPgCQe2TdMEdUagdGqRu7UG_j__S=4MjMQ@mail.gmail.com>
 <CAKTNdwEJuQ_6ROpKb+b_anFH7GbaT8NA2dvmxWmS_m8RSUYxTw@mail.gmail.com>
 <20260625172422.GU382693@bill-the-cat>
In-Reply-To: <20260625172422.GU382693@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 18:29:18 +0100
X-Gm-Features: AVVi8CdC-QD3XBc-IXA1TyHtMQIt2qduA_tOD4FXPDgnB0SCOHT7XJbKJMxmOi4
Message-ID: <CAFLszTg5sBQiVw_guWhNjg8PQ2d+KyVXw0=Q0igjxSeuxerqsQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] boot: add a minimal bootmeth for the Boot Loader
 Specification
To: Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de, 
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

Hi Tom,

On Thu, 25 Jun 2026 at 18:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jun 25, 2026 at 08:57:13PM +0400, Alexey Charkov wrote:
> > On Thu, Jun 25, 2026 at 8:24=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Alexey,
> > >
> > > On Thu, 25 Jun 2026 at 16:52, Alexey Charkov <alchark@flipper.net> wr=
ote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Thu, Jun 25, 2026 at 7:28=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi Alexey,
> > > > >
> > > > > On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net> wrot=
e:
> > > > > > boot: add a minimal bootmeth for the Boot Loader Specification
> > > > > >
> > > > > > Add a bootmeth that finds and boots Boot Loader Specification (=
BLS)
> > > > > > type #1 entry files [1]. On each block-device partition it scan=
s, the
> > > > > > bootmeth looks for files matching '<prefix>loader/entries/*.con=
f'
> > > > > > (where <prefix> comes from bootstd_get_prefixes(), typically '/=
' and
> > > > > > '/boot/'), picks the highest-sorting filename, parses it, and e=
xposes
> > > > > > it as a bootflow.
> > > > > >
> > > > > > Implementation reuses the existing pxelinux infrastructure.
> > > > > >
> > > > > > For now the entry chosen on a partition is purely the lexicogra=
phic
> > > > > > maximum of *.conf filenames; sort-key / version field handling
> > > > > > (spec-mandated tiebreakers) and boot-counting (the '+TRIES_LEFT=
'
> > > > > > filename suffix) are left as TODOs. Likewise, only the top-sort=
ed entry
> > > > > > is surfaced because the bootstd framework currently allows one =
bootflow
> > > > > > per (bootmeth, partition); exposing every discovered entry will=
 require
> > > > > > a framework extension.
> > > > > >
> > > > > > Type #2 BLS (drop-in directory of EFI binaries) is out of scope=
 here;
> > > > > > [...]
> > > > > >
> > > > > > boot/Kconfig        |  17 +++
> > > > > >  boot/Makefile       |   1 +
> > > > > >  boot/bootmeth_bls.c | 333 ++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> > > > > >  3 files changed, 351 insertions(+)
> > > > >
> > > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > @@ -649,6 +649,23 @@ config BOOTMETH_EXTLINUX_PXE
> > > > > > +config BOOTMETH_BLS
> > > > > > +     bool "Bootdev support for Boot Loader Specification entri=
es"
> > > > > > +     select PXE_UTILS
> > > > > > +     default y
> > > > >
> > > > > Wherever the 'default y' discussion lands, this will be enabled o=
n
> > > > > sandbox, so the 'bootmeth list' tests in test/boot/bootmeth.c wil=
l
> > > > > fail since they check the exact list and count. Please can you ru=
n the
> > > > > sandbox tests and update them as needed?
> > > > >
> > > > > Since you are adding a new bootmeth you also need a sandbox test =
that
> > > > > exercises it (see the extlinux tests in test/boot/bootflow.c, wit=
h a
> > > > > fixture disk image) and a documentation page, e.g.
> > > > > doc/develop/bootstd/bls.rst with an entry in the index there.
> > > >
> > > > Will do, thanks!
> > > >
> > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > @@ -0,0 +1,333 @@
> > > > > > +static int bls_getfile(struct pxe_context *ctx, const char *fi=
le_path,
> > > > > > +                    char *file_addr, enum bootflow_img_t type,=
 ulong *sizep)
> > > > >
> > > > > This is a verbatim copy of extlinux_getfile() - please can you ex=
port
> > > > > that, or move it into a shared helper?
> > > >
> > > > Ack
> > > >
> > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > @@ -0,0 +1,333 @@
> > > > > > +     ret =3D bootmeth_alloc_file(bflow, SZ_64K, 1, BFI_EXTLINU=
X_CFG);
> > > > >
> > > > > The extlinux bootmeth passes ARCH_DMA_MINALIGN here, since the bu=
ffer
> > > > > is filled by a block-device read which may use DMA on some platfo=
rms.
> > > > > An alignment of 1 risks cache-line corruption there, so please us=
e
> > > > > ARCH_DMA_MINALIGN.
> > > >
> > > > Ack
> > > >
> > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > @@ -0,0 +1,333 @@
> > > > > > +     bflow->bootmeth_priv =3D label;
> > > > > > +     free(fpath);
> > > > >
> > > > > This leaks memory: bootflow_free() releases bootmeth_priv with a =
plain
> > > > > free(), so the label's string members (name, menu, kernel, append=
,
> > > > > initrd, etc.) are never freed - for every bootflow discarded afte=
r a
> > > > > scan, not just on error paths.
> > > > >
> > > > > Since get_string() copies tokens out of the buffer rather than
> > > > > modifying it in place, you could follow the extlinux approach: ke=
ep
> > > > > only bflow->buf across the scan (already populated by
> > > > > bootmeth_alloc_file() and freed by the framework), use a temporar=
y
> > > > > label in bls_read_bootflow() just to extract the title, destroy i=
t
> > > > > with label_destroy(), and re-parse the buffer in bls_boot(). Then
> > > > > bootmeth_priv is not needed at all. What do you think?
> > > >
> > > > Will address the leak, thanks for pointing it out!
> > > >
> > > > The bls_priv structure is needed for my follow-up extension which
> > > > allows multiple boot entries to be returned by each (bootdev,
> > > > bootmeth, partition) tuple, and I wanted to minimize churn between
> > > > those two. I haven't sent that follow-up for review yet, as I wante=
d
> > > > to confirm this simpler version is acceptable first.
> > >
> > > We should implement this using an generic index rather than something
> > > bls-specific...please see some commits at:
> > >
> > > https://concept.deinde.dev/u-boot/u-boot/-/merge_requests/782
> >
> > Oh, there's already BLS in your tree :-D
> >
> > Would you like to merge that instead? Your version looks much more
> > full-fledged. If you happen to have one rebased on master or next I'd
> > be happy to test!
>
> Unfortunately Simon's work here is AI-generated and so not particularly
> welcome, among other problems right now.

No, not AI-generated, but certainly AI-assisted (perhaps that is what
you meant?)

Regards,
SImon
