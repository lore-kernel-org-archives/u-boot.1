Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A31C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 05:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85967841F2;
	Mon, 29 Jun 2026 07:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M1lRbCoI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F4229843B6; Mon, 29 Jun 2026 07:45:22 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0998A84105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 07:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6983f8b0aebso1762855a12.1
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 22:45:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782711919; cv=none;
 d=google.com; s=arc-20260327;
 b=bhPIg2ddkVU6n+Let0R+CnyGeOaFjoIuGYB3hZLxgtvabfIcBZkAZoZPOxQA4uq4si
 QiYOSN0aLNDss3u1J7JOhhWnj13j6n5nIFOV1i1CfFosGfkG8OgItq6/+DSyBEsHxG9b
 XugMQMBtpLkpmit0uEwEpMS/Higmi71oZG86SpEMiVbKOhm34r6JOTa27VzRS+P0MeZl
 NMEMf5qEQEmWFEkYhd3Eeyd4CiJKB5VhAC01IGkq+z4u1uDL/rrs2rgPywfleCRuP0fB
 wwiuBhka7pKdPH1h0fNK7xGXPI6GAN/2E/gA/8GBWI3wKn3zfA8Zbpe18mvv21fH10AK
 r/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A/oWZrzIfyG9zF8RWoBwUk8HU03ZvbWeNScEbhjzTpA=;
 fh=0lzyNZIEmgyvrScoYL9ICH5xZm4uuUgAewGKFx0f5mg=;
 b=okUfI32Hfz2vs2YGyguz1O8hXBbX+8lWMzxjwu08cz5VEikdVypjZYgeJix2fSNp3Z
 b1Z8GCcwCeva+G+IUF3G9jTX8nP49PjWDAcs/AH1R/mPRxKa0fyyji2Ia7FiYbKz5CJT
 rEF1nkT1JnZFuBsQGR6rRTgyel1BcVtVjfd9gGx/U5e2MtbCrldWWBcc73aSzvKgTa/i
 uPPB0ltL9zx8mDSN9VgqVFnoish/m4gibxwX5UXhxYIgZ0b2uCy0WA2GKbggGbxn97ys
 GWMPYehFDndBoNxaDARTJM/i7t8JoaG25WnVrO+lb4QohQQz3DvpzKMJsHkdDPAqwK/F
 LCrA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782711919; x=1783316719; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/oWZrzIfyG9zF8RWoBwUk8HU03ZvbWeNScEbhjzTpA=;
 b=M1lRbCoIc8DcVG0G44/kPB1E978L9uZFVK0zLRaQdgZLS+WnJEakfjLwg1aX40QaA/
 B/L1Ilq7dtNwdcJvUGTjI24y/QYvwTmhFU8ctbeBIIr++GeitC8OLjjBRVIjPB+CV4KS
 ufJGzRcCWFC95eEpQzazIrJukM3xSBuhh7wAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782711919; x=1783316719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A/oWZrzIfyG9zF8RWoBwUk8HU03ZvbWeNScEbhjzTpA=;
 b=LVdYRiflb33WQogIAooUhC4Vem0EE1c/QoGX3cBH0iKkyjOCDkTpZeqObK9TaXX+49
 mUpY/rcoFrhYckvkVdwOcGtoYWW8KeBJnBwsZOw4ejmqsq1XtwUEOKOQs1eJhIwDpZqB
 MIBhsNVKVBfpB1tU747qhz8Mjf1W3EWru91k5gqPMHttZWetbPqEiyouWXL+O7Hi9CxY
 6VrEwKSMpmMUwUAVGrUZ7dEwh1k4+NhEa+fPIwj80qwUI/0xA/f6LV24f3nuP6+ksdb5
 kPzscVeQoOVUdUbOvdApB1OS6Q8/dgsM6sWrnMnJW5/awHZp7+OZ3fbZMQ4WXXomBfoA
 7Q3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZzJBOXhsWJQRzJOMfC/tDQGhMF2H4ulG/gC2w8JC6cNDL2nTmuSq/SrhAw15Hpf+zsg1VCbQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwhAvkX2fG/EMQWAuaFAGpzld+lWbTuNoAA2szP9NIY6SOzKt7c
 BUiJQ4G2xDE60rhpIfYUXOL3ESFclXc5xC0zE8H9nDBjTySQr6GYd+Orln62nQ9wrZaDm/2vZN5
 Q8vA8bWWoRaw9JFWtSnVkZ/2WxjmDhraoiCPUo34Y
X-Gm-Gg: AfdE7clueaEtlqixVZXsdktFelCXCYWZ6cQB4UOmIPPNaEJ/R2Nq9I5+VYgwX96NB8E
 y20ujDAIhrZ091PAUAiKUi6QcXW29LSvu2WY1L1fwLiozbpDEbroZvZVLFjXXnxYv7sR1Vwd1y5
 yrW0eVAJ0sdYghibT6Sar3N5osiYbXJ/YFXT9nOHlp586bXhsIr87S3YFQywFfN0Lhwnke2QI5W
 Yh+hXMmbrXMMXPXcT3TYWoDv5Oabm02p5uX+Ht1LrNiuuHGIq3r4BiD7Gw2mVgLUPIdA8BADA==
X-Received: by 2002:a05:6402:2691:b0:698:3927:1c39 with SMTP id
 4fb4d7f45d1cf-69839271db8mr4059175a12.5.1782711919271; Sun, 28 Jun 2026
 22:45:19 -0700 (PDT)
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
 <CAFLszTiS3GXAj9XoqfMb-Lf4kbyYJNopDv_yApRoiChqO-8J3A@mail.gmail.com>
 <20260626134701.GX382693@bill-the-cat>
In-Reply-To: <20260626134701.GX382693@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jun 2026 06:45:07 +0100
X-Gm-Features: AVVi8CcsbPAAwN_D1gKy6FJycPteTwfgX8QKwM2Nqvs1sO7m-20FpcKnABH0UEY
Message-ID: <CAFLszTgB1r_n=GZPTL9C8e6SGOL8ipXhuDCM0OkiTea64V2diw@mail.gmail.com>
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

On Fri, 26 Jun 2026 at 14:47, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jun 26, 2026 at 11:45:22AM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 25 Jun 2026 at 18:33, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jun 25, 2026 at 06:29:18PM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 25 Jun 2026 at 18:24, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Jun 25, 2026 at 08:57:13PM +0400, Alexey Charkov wrote:
> > > > > > On Thu, Jun 25, 2026 at 8:24=E2=80=AFPM Simon Glass <sjg@chromi=
um.org> wrote:
> > > > > > >
> > > > > > > Hi Alexey,
> > > > > > >
> > > > > > > On Thu, 25 Jun 2026 at 16:52, Alexey Charkov <alchark@flipper=
.net> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > On Thu, Jun 25, 2026 at 7:28=E2=80=AFPM Simon Glass <sjg@ch=
romium.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Alexey,
> > > > > > > > >
> > > > > > > > > On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.n=
et> wrote:
> > > > > > > > > > boot: add a minimal bootmeth for the Boot Loader Specif=
ication
> > > > > > > > > >
> > > > > > > > > > Add a bootmeth that finds and boots Boot Loader Specifi=
cation (BLS)
> > > > > > > > > > type #1 entry files [1]. On each block-device partition=
 it scans, the
> > > > > > > > > > bootmeth looks for files matching '<prefix>loader/entri=
es/*.conf'
> > > > > > > > > > (where <prefix> comes from bootstd_get_prefixes(), typi=
cally '/' and
> > > > > > > > > > '/boot/'), picks the highest-sorting filename, parses i=
t, and exposes
> > > > > > > > > > it as a bootflow.
> > > > > > > > > >
> > > > > > > > > > Implementation reuses the existing pxelinux infrastruct=
ure.
> > > > > > > > > >
> > > > > > > > > > For now the entry chosen on a partition is purely the l=
exicographic
> > > > > > > > > > maximum of *.conf filenames; sort-key / version field h=
andling
> > > > > > > > > > (spec-mandated tiebreakers) and boot-counting (the '+TR=
IES_LEFT'
> > > > > > > > > > filename suffix) are left as TODOs. Likewise, only the =
top-sorted entry
> > > > > > > > > > is surfaced because the bootstd framework currently all=
ows one bootflow
> > > > > > > > > > per (bootmeth, partition); exposing every discovered en=
try will require
> > > > > > > > > > a framework extension.
> > > > > > > > > >
> > > > > > > > > > Type #2 BLS (drop-in directory of EFI binaries) is out =
of scope here;
> > > > > > > > > > [...]
> > > > > > > > > >
> > > > > > > > > > boot/Kconfig        |  17 +++
> > > > > > > > > >  boot/Makefile       |   1 +
> > > > > > > > > >  boot/bootmeth_bls.c | 333 ++++++++++++++++++++++++++++=
++++++++++++++++++++++++
> > > > > > > > > >  3 files changed, 351 insertions(+)
> > > > > > > > >
> > > > > > > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > > > > > @@ -649,6 +649,23 @@ config BOOTMETH_EXTLINUX_PXE
> > > > > > > > > > +config BOOTMETH_BLS
> > > > > > > > > > +     bool "Bootdev support for Boot Loader Specificati=
on entries"
> > > > > > > > > > +     select PXE_UTILS
> > > > > > > > > > +     default y
> > > > > > > > >
> > > > > > > > > Wherever the 'default y' discussion lands, this will be e=
nabled on
> > > > > > > > > sandbox, so the 'bootmeth list' tests in test/boot/bootme=
th.c will
> > > > > > > > > fail since they check the exact list and count. Please ca=
n you run the
> > > > > > > > > sandbox tests and update them as needed?
> > > > > > > > >
> > > > > > > > > Since you are adding a new bootmeth you also need a sandb=
ox test that
> > > > > > > > > exercises it (see the extlinux tests in test/boot/bootflo=
w.c, with a
> > > > > > > > > fixture disk image) and a documentation page, e.g.
> > > > > > > > > doc/develop/bootstd/bls.rst with an entry in the index th=
ere.
> > > > > > > >
> > > > > > > > Will do, thanks!
> > > > > > > >
> > > > > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > > > > @@ -0,0 +1,333 @@
> > > > > > > > > > +static int bls_getfile(struct pxe_context *ctx, const =
char *file_path,
> > > > > > > > > > +                    char *file_addr, enum bootflow_img=
_t type, ulong *sizep)
> > > > > > > > >
> > > > > > > > > This is a verbatim copy of extlinux_getfile() - please ca=
n you export
> > > > > > > > > that, or move it into a shared helper?
> > > > > > > >
> > > > > > > > Ack
> > > > > > > >
> > > > > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > > > > @@ -0,0 +1,333 @@
> > > > > > > > > > +     ret =3D bootmeth_alloc_file(bflow, SZ_64K, 1, BFI=
_EXTLINUX_CFG);
> > > > > > > > >
> > > > > > > > > The extlinux bootmeth passes ARCH_DMA_MINALIGN here, sinc=
e the buffer
> > > > > > > > > is filled by a block-device read which may use DMA on som=
e platforms.
> > > > > > > > > An alignment of 1 risks cache-line corruption there, so p=
lease use
> > > > > > > > > ARCH_DMA_MINALIGN.
> > > > > > > >
> > > > > > > > Ack
> > > > > > > >
> > > > > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > > > > @@ -0,0 +1,333 @@
> > > > > > > > > > +     bflow->bootmeth_priv =3D label;
> > > > > > > > > > +     free(fpath);
> > > > > > > > >
> > > > > > > > > This leaks memory: bootflow_free() releases bootmeth_priv=
 with a plain
> > > > > > > > > free(), so the label's string members (name, menu, kernel=
, append,
> > > > > > > > > initrd, etc.) are never freed - for every bootflow discar=
ded after a
> > > > > > > > > scan, not just on error paths.
> > > > > > > > >
> > > > > > > > > Since get_string() copies tokens out of the buffer rather=
 than
> > > > > > > > > modifying it in place, you could follow the extlinux appr=
oach: keep
> > > > > > > > > only bflow->buf across the scan (already populated by
> > > > > > > > > bootmeth_alloc_file() and freed by the framework), use a =
temporary
> > > > > > > > > label in bls_read_bootflow() just to extract the title, d=
estroy it
> > > > > > > > > with label_destroy(), and re-parse the buffer in bls_boot=
(). Then
> > > > > > > > > bootmeth_priv is not needed at all. What do you think?
> > > > > > > >
> > > > > > > > Will address the leak, thanks for pointing it out!
> > > > > > > >
> > > > > > > > The bls_priv structure is needed for my follow-up extension=
 which
> > > > > > > > allows multiple boot entries to be returned by each (bootde=
v,
> > > > > > > > bootmeth, partition) tuple, and I wanted to minimize churn =
between
> > > > > > > > those two. I haven't sent that follow-up for review yet, as=
 I wanted
> > > > > > > > to confirm this simpler version is acceptable first.
> > > > > > >
> > > > > > > We should implement this using an generic index rather than s=
omething
> > > > > > > bls-specific...please see some commits at:
> > > > > > >
> > > > > > > https://concept.deinde.dev/u-boot/u-boot/-/merge_requests/782
> > > > > >
> > > > > > Oh, there's already BLS in your tree :-D
> > > > > >
> > > > > > Would you like to merge that instead? Your version looks much m=
ore
> > > > > > full-fledged. If you happen to have one rebased on master or ne=
xt I'd
> > > > > > be happy to test!
> > > > >
> > > > > Unfortunately Simon's work here is AI-generated and so not partic=
ularly
> > > > > welcome, among other problems right now.
> > > >
> > > > No, not AI-generated, but certainly AI-assisted (perhaps that is wh=
at
> > > > you meant?)
> > >
> > > I didn't dig back super far to see what all AI-generated (such as you=
r
> > > dlmalloc upgrade) vs "AI-assisted" (commit from just a few months ago=
)
> > > and try and guess based on the quality if it's "generated" or
> > > "assisted". But it doesn't really matter in the AI context. And it
> > > certainly doesn't matter until you've donated u-boot.org to the proje=
ct.
> >
> > Yes the dlmalloc upgrade was a lot of work and brings a lot of
> > benefits to U-Boot. There is also a backtrace feature which is really
> > handlyfor tracking down memory leaks and hangs. I found a ton of
> > leaks, some of them very large (e.g. SCMI). There was certainly a lot
> > of manual work involved, along with AI assistance. I believe AI is
> > particularly effective when used by someone who knows the project and
> > codebase well.
>
> OK, but did you review that dlmalloc upgrade? Did you think Claude did a
> good and appropriate job there?

It's a while ago, but I remember being about 3 bugs deep at the time
(crashes in CI which turned out to be memory leaks) so I am sure it
could be better. If you are interested in it for mainline I could take
another look.

Regards,
Simon
