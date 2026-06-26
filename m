Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFD1CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199A284A0B;
	Fri, 26 Jun 2026 12:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LB8uqdlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F3784A0B; Fri, 26 Jun 2026 12:45:37 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEEC8460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-697edb1bf6eso1177303a12.1
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782470734; cv=none;
 d=google.com; s=arc-20260327;
 b=s4K0L06axBYfzhq7ic2Cv6l9Sft07toJZXmDM5iHWR0fs1DypD5iiBfFomVq/kQpan
 8YP5wIXV/VJc5KIPY3ecvVj4LCxJ5y8/zSaAVJwhXG/c5n8a/o8+J6tdoSuy4DGXriza
 +65Px45PWCMwErP/ca7D0R9lnM6G8pHbm9sIuWtwPavZy4xPMgOpdyymjGq3tAgd1Cfe
 ezFm2H9r9x5PeyrRiul2w0s3ffX6hGUv6twO3AHIzmFe7EirPdPlvwL1p7G36LvJbBv+
 G6U8DS3RBInAgLH+uVGlVCQEQ/DH+cZ66Q2uZXecnfVhCpImxEDTLwcx++wAQPLVBU4V
 4W1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rW/njLnhFWbW1sD+Q7lPZyG69hUjJp7r1lrXyKDvjJM=;
 fh=MUiURPTF0TI3kDfczXaTSSlxY+LFcXyxx40+it65jKs=;
 b=IJreU86a6EuksurU81FT2EBeZLESortbSJrElxx69F5/rvEGhuvlEzkq3MOlTTkj28
 zzmWpFfD2B4JNRj1msa74ln4fqPlNv+/I++q+6jDMJ0zDbEhAjBRFfv+I/dFv/L2ye2g
 vK1UyZjqqWZmuNWR5SljXXpV/eNCZPvc6vs1eR3PGh9KeUMesvbyI9picQmgsB8RaKAA
 XhYc8H/1OMEQvtZeGixxRBf24ktq5PDgWF479fyI9fFGcR4LXSEIJ/m5pNKOFb33Wsq6
 bcVYEkL/mIMG0mwkqVP3CuZooc3f423+MAEuelSh4UIy8xC1nyIfIV5ahlsZOBSwL8ZV
 UBAw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782470734; x=1783075534; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rW/njLnhFWbW1sD+Q7lPZyG69hUjJp7r1lrXyKDvjJM=;
 b=LB8uqdlfpuWcEPSHJtp7D8Et8z31dTWpxhZc+H0X3zvNBYTakgnqZmlBxzs5d6c++g
 YLIFq8gdDADpmEc3O7Du4zpZ6t6VCiWcTfzW5WcjkOjDH+aA7VJY1TOk9euRV0V9AIPP
 w0eF/nU9YOlmNWKqegvGBtPe0UMFsDtNOtyOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782470734; x=1783075534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rW/njLnhFWbW1sD+Q7lPZyG69hUjJp7r1lrXyKDvjJM=;
 b=kEvHz1ZvExvZHZmBujMTrZGjmWVP86KIp87PFc4FL9zVRWW57X5YoW+w9riZnsog9S
 Z2XGHmm1uukDznPz+p+caQZ+aabF18IJbGhHt4dZgItUDWvkJp2OWvkrpweqci2yBY3r
 LopO8JhomsP/1S3v4InjrG69qdJB/b6D1M1LKdj+wR+1bbVfF0WajOTgE8RrqPgU5t0e
 mZWfOiVPIik+gidcM1iMTd13vtlU1XvQVKMd7YiWX+umrVOnHZVqKjd/1JT6MRCJJBSa
 Uls+msLWWfH32YzAsXg+u1neVrDojme7Vj5Owt6sd7k6xjrzIMfGCxltiKimiAPlOcp9
 Y0Iw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwjSfHjy62CTOclXQ7YBCgcX5yXIwXraW5RNuXKayPPFuWuyrKkioDRSTxzmUIL9fANB/5lfQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxwulDlUs7sQWb6YVmOxCDlb7PIh4jJ+YdACPZ8iGLyfVRUiy+y
 +ye7Eh6+FNh6Ufj+//yQyvdAA9dJaqk6TgwsyhJnI3uD8OEd84sV7Ty+zKihua+LXiWinAk7+2Z
 33Va/lKlJHHc5zaEyTB91g2j5FWZFbhdzI65ck1wg
X-Gm-Gg: AfdE7cm2t6HylbKfMWnz0Yo8tAxWWo6DM/KHItv5rMpznT0fOH0IRk/lp0EBtlI4Da0
 Y0fvojvL9aUIh3jvxR2zjhJskudG0x3xqyr4ML9dZkcdvDCfiArwMkqCWObqEln4vQChajXbPUP
 4u5QTMcz4aQa6026PKIt5WwAcEqmue9uOMwOzx3EiOj4Yzm0qMYfM6aOZG9nstlhtaQxJmUrm5x
 r063NwCvR4awlpFP0tcEN4EPctFW9FgqGg2F0fnK18TsH7c+9VsT1KFBwYmMSvUOSDn02nBmg==
X-Received: by 2002:a05:6402:321b:b0:697:e97b:777d with SMTP id
 4fb4d7f45d1cf-69810aea680mr1930214a12.17.1782470733968; Fri, 26 Jun 2026
 03:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604-bls-v1-7-4ce6d1ee4711@flipper.net>
 <CAFLszTikihqsUmOGdmb8Q9WypiEHb0nq-a7vXH5XrXNxRVeNjg@mail.gmail.com>
 <CAKTNdwEkt+YMq-SG=PVTGzGztyeujVr=fEje74NnSbBbiswd7w@mail.gmail.com>
 <CAFLszTg7DJW4b0JhuPgCQe2TdMEdUagdGqRu7UG_j__S=4MjMQ@mail.gmail.com>
 <CAKTNdwEJuQ_6ROpKb+b_anFH7GbaT8NA2dvmxWmS_m8RSUYxTw@mail.gmail.com>
 <20260625172422.GU382693@bill-the-cat>
 <CAFLszTg5sBQiVw_guWhNjg8PQ2d+KyVXw0=Q0igjxSeuxerqsQ@mail.gmail.com>
 <20260625173258.GV382693@bill-the-cat>
In-Reply-To: <20260625173258.GV382693@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jun 2026 11:45:22 +0100
X-Gm-Features: AVVi8Cdc17HJpwm4EWJo1NeAfxFkRKFR5tm6P-IgNai_WknzAMnrj_7ahERpe40
Message-ID: <CAFLszTiS3GXAj9XoqfMb-Lf4kbyYJNopDv_yApRoiChqO-8J3A@mail.gmail.com>
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

On Thu, 25 Jun 2026 at 18:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jun 25, 2026 at 06:29:18PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 25 Jun 2026 at 18:24, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jun 25, 2026 at 08:57:13PM +0400, Alexey Charkov wrote:
> > > > On Thu, Jun 25, 2026 at 8:24=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi Alexey,
> > > > >
> > > > > On Thu, 25 Jun 2026 at 16:52, Alexey Charkov <alchark@flipper.net=
> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Thu, Jun 25, 2026 at 7:28=E2=80=AFPM Simon Glass <sjg@chromi=
um.org> wrote:
> > > > > > >
> > > > > > > Hi Alexey,
> > > > > > >
> > > > > > > On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net> =
wrote:
> > > > > > > > boot: add a minimal bootmeth for the Boot Loader Specificat=
ion
> > > > > > > >
> > > > > > > > Add a bootmeth that finds and boots Boot Loader Specificati=
on (BLS)
> > > > > > > > type #1 entry files [1]. On each block-device partition it =
scans, the
> > > > > > > > bootmeth looks for files matching '<prefix>loader/entries/*=
.conf'
> > > > > > > > (where <prefix> comes from bootstd_get_prefixes(), typicall=
y '/' and
> > > > > > > > '/boot/'), picks the highest-sorting filename, parses it, a=
nd exposes
> > > > > > > > it as a bootflow.
> > > > > > > >
> > > > > > > > Implementation reuses the existing pxelinux infrastructure.
> > > > > > > >
> > > > > > > > For now the entry chosen on a partition is purely the lexic=
ographic
> > > > > > > > maximum of *.conf filenames; sort-key / version field handl=
ing
> > > > > > > > (spec-mandated tiebreakers) and boot-counting (the '+TRIES_=
LEFT'
> > > > > > > > filename suffix) are left as TODOs. Likewise, only the top-=
sorted entry
> > > > > > > > is surfaced because the bootstd framework currently allows =
one bootflow
> > > > > > > > per (bootmeth, partition); exposing every discovered entry =
will require
> > > > > > > > a framework extension.
> > > > > > > >
> > > > > > > > Type #2 BLS (drop-in directory of EFI binaries) is out of s=
cope here;
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > boot/Kconfig        |  17 +++
> > > > > > > >  boot/Makefile       |   1 +
> > > > > > > >  boot/bootmeth_bls.c | 333 ++++++++++++++++++++++++++++++++=
++++++++++++++++++++
> > > > > > > >  3 files changed, 351 insertions(+)
> > > > > > >
> > > > > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > > > @@ -649,6 +649,23 @@ config BOOTMETH_EXTLINUX_PXE
> > > > > > > > +config BOOTMETH_BLS
> > > > > > > > +     bool "Bootdev support for Boot Loader Specification e=
ntries"
> > > > > > > > +     select PXE_UTILS
> > > > > > > > +     default y
> > > > > > >
> > > > > > > Wherever the 'default y' discussion lands, this will be enabl=
ed on
> > > > > > > sandbox, so the 'bootmeth list' tests in test/boot/bootmeth.c=
 will
> > > > > > > fail since they check the exact list and count. Please can yo=
u run the
> > > > > > > sandbox tests and update them as needed?
> > > > > > >
> > > > > > > Since you are adding a new bootmeth you also need a sandbox t=
est that
> > > > > > > exercises it (see the extlinux tests in test/boot/bootflow.c,=
 with a
> > > > > > > fixture disk image) and a documentation page, e.g.
> > > > > > > doc/develop/bootstd/bls.rst with an entry in the index there.
> > > > > >
> > > > > > Will do, thanks!
> > > > > >
> > > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > > @@ -0,0 +1,333 @@
> > > > > > > > +static int bls_getfile(struct pxe_context *ctx, const char=
 *file_path,
> > > > > > > > +                    char *file_addr, enum bootflow_img_t t=
ype, ulong *sizep)
> > > > > > >
> > > > > > > This is a verbatim copy of extlinux_getfile() - please can yo=
u export
> > > > > > > that, or move it into a shared helper?
> > > > > >
> > > > > > Ack
> > > > > >
> > > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > > @@ -0,0 +1,333 @@
> > > > > > > > +     ret =3D bootmeth_alloc_file(bflow, SZ_64K, 1, BFI_EXT=
LINUX_CFG);
> > > > > > >
> > > > > > > The extlinux bootmeth passes ARCH_DMA_MINALIGN here, since th=
e buffer
> > > > > > > is filled by a block-device read which may use DMA on some pl=
atforms.
> > > > > > > An alignment of 1 risks cache-line corruption there, so pleas=
e use
> > > > > > > ARCH_DMA_MINALIGN.
> > > > > >
> > > > > > Ack
> > > > > >
> > > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > > @@ -0,0 +1,333 @@
> > > > > > > > +     bflow->bootmeth_priv =3D label;
> > > > > > > > +     free(fpath);
> > > > > > >
> > > > > > > This leaks memory: bootflow_free() releases bootmeth_priv wit=
h a plain
> > > > > > > free(), so the label's string members (name, menu, kernel, ap=
pend,
> > > > > > > initrd, etc.) are never freed - for every bootflow discarded =
after a
> > > > > > > scan, not just on error paths.
> > > > > > >
> > > > > > > Since get_string() copies tokens out of the buffer rather tha=
n
> > > > > > > modifying it in place, you could follow the extlinux approach=
: keep
> > > > > > > only bflow->buf across the scan (already populated by
> > > > > > > bootmeth_alloc_file() and freed by the framework), use a temp=
orary
> > > > > > > label in bls_read_bootflow() just to extract the title, destr=
oy it
> > > > > > > with label_destroy(), and re-parse the buffer in bls_boot(). =
Then
> > > > > > > bootmeth_priv is not needed at all. What do you think?
> > > > > >
> > > > > > Will address the leak, thanks for pointing it out!
> > > > > >
> > > > > > The bls_priv structure is needed for my follow-up extension whi=
ch
> > > > > > allows multiple boot entries to be returned by each (bootdev,
> > > > > > bootmeth, partition) tuple, and I wanted to minimize churn betw=
een
> > > > > > those two. I haven't sent that follow-up for review yet, as I w=
anted
> > > > > > to confirm this simpler version is acceptable first.
> > > > >
> > > > > We should implement this using an generic index rather than somet=
hing
> > > > > bls-specific...please see some commits at:
> > > > >
> > > > > https://concept.deinde.dev/u-boot/u-boot/-/merge_requests/782
> > > >
> > > > Oh, there's already BLS in your tree :-D
> > > >
> > > > Would you like to merge that instead? Your version looks much more
> > > > full-fledged. If you happen to have one rebased on master or next I=
'd
> > > > be happy to test!
> > >
> > > Unfortunately Simon's work here is AI-generated and so not particular=
ly
> > > welcome, among other problems right now.
> >
> > No, not AI-generated, but certainly AI-assisted (perhaps that is what
> > you meant?)
>
> I didn't dig back super far to see what all AI-generated (such as your
> dlmalloc upgrade) vs "AI-assisted" (commit from just a few months ago)
> and try and guess based on the quality if it's "generated" or
> "assisted". But it doesn't really matter in the AI context. And it
> certainly doesn't matter until you've donated u-boot.org to the project.

Yes the dlmalloc upgrade was a lot of work and brings a lot of
benefits to U-Boot. There is also a backtrace feature which is really
handlyfor tracking down memory leaks and hangs. I found a ton of
leaks, some of them very large (e.g. SCMI). There was certainly a lot
of manual work involved, along with AI assistance. I believe AI is
particularly effective when used by someone who knows the project and
codebase well.

Regards,
Simon
