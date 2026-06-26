Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075EFC43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 13:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A29584704;
	Fri, 26 Jun 2026 15:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mRuKPRza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C8B88495B; Fri, 26 Jun 2026 15:47:09 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532378460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 15:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-44841e9f651so276631fac.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 06:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782481625; x=1783086425; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fYxwnfskk0vDIoudnRa/X34RueE0lgreotok6dEHGms=;
 b=mRuKPRzacWAQlKLsGVJhoBoEpXuaeTiiSoV02T8ntzsCJcJitcdGFPzhShzxF0XXkW
 rraUXuRuxeCoB0dJwKa53wvDKGSFf/+vDQAc3UOT2ml3X8rz2QZNOB2EpWq22bJXIQsd
 WPf+I1QCED7YkC5QdtDUNdbjb3z/C6UXK02Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782481625; x=1783086425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYxwnfskk0vDIoudnRa/X34RueE0lgreotok6dEHGms=;
 b=o+9vjL5EdoNZH2OutZo38ABe7/4Ei6BaN2FfyiryD07Tz6zKZNp6nP004OVYeXcHUf
 ZvMmZkJRxtYsJcpwes48wmJ49zg36CnIoc/1dIly9+clZ2+sxVqg/zv6Z+2e6HXqhn8T
 U8fFTaQtrDUytb4H+O1HFIkueYuor/4QdQbf3aVVULKReLUqK+nrUtL+cji4KNaMF84n
 sq9Ns0NXc1QUX6R1wqmN2d+5xY99cM+euZCO9CfuN51fF6L41sYiUftIDMq6IPeyaOOl
 J7kQdeOMYP5MihiPQNKjHK5LDELsxVUBBWqTNCiDOhxNVRG1WT+L2T8Ykr4yG0NO+jUa
 MDnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6uUHIXNLEXEiNBOovbjp4HpzC8Mv/jVN60qXzR003g1X5a2mPQWcgSVo7Q57brm/+2I+ZXdI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxkm9/Fd3fXqlmFzwgUXbNNYGEwCUp5h+cyoh7XlD6oR2Gwuz4/
 yD7n/6RuktBi3CkmVmRmU6ealCKsDIA+y17DSJC8WsJDufYI0wPDJ93ES/zXjzPn13M=
X-Gm-Gg: AfdE7cn8EvStFIyfyTHIeKfWf3GOmUMcu21NSg8flu9QRra9ga/g7FE3S78GjgQQBz7
 0yVCerInqWgZXt2wsJqFvuZoQ+CP1dcybS6C2gqFy/4HAVx6pkVOuAm+bY1NHiNUCmwxO26dV5i
 X1jEOhy9sP5Sop45xNBV5Jiy2kVUm+dUcwbNwQ8FIBLG2nC7SiXQgKLlGa1rRMEo1MMuD/7LDie
 F6TG/sC1/w/F0HQX2OvcCidXVyFSD5JDgS+5wqAZezDkb9MJ0fi5e0rOw0opFYdnoHI4EY1oqiO
 SUbM58btJ/6pJsEBDCmhl5lmNTkKstBCfE9sEMpWux1uj5fkFnstr6TkL4icz5PdhZQURoEHc2+
 iVeIPUjDtrRzMtNkeNa3v9FIjYTwVldACStBsXDOKo6q7KSKhuqClkoLnCTcXajczxSbAaWRp8e
 iaZwwULNE/EElCyENfZxZt7rKZJW1GZiTaca08sGmA3KKmI9azTCxTAfSEitd2/x0OJ1FOP5uOV
 yKIES7bYIZKLt72VRx9+/Am3JUvp2EBpOHRnRcP
X-Received: by 2002:a05:6871:d105:b0:447:4bc9:4b05 with SMTP id
 586e51a60fabf-448117a483dmr5386144fac.4.1782481624742; 
 Fri, 26 Jun 2026 06:47:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472eccfa68sm13881636fac.5.2026.06.26.06.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 06:47:03 -0700 (PDT)
Date: Fri, 26 Jun 2026 07:47:01 -0600
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
Message-ID: <20260626134701.GX382693@bill-the-cat>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4rpUjkHGJFHksey/"
Content-Disposition: inline
In-Reply-To: <CAFLszTiS3GXAj9XoqfMb-Lf4kbyYJNopDv_yApRoiChqO-8J3A@mail.gmail.com>
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


--4rpUjkHGJFHksey/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 11:45:22AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 25 Jun 2026 at 18:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jun 25, 2026 at 06:29:18PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 25 Jun 2026 at 18:24, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jun 25, 2026 at 08:57:13PM +0400, Alexey Charkov wrote:
> > > > > On Thu, Jun 25, 2026 at 8:24=E2=80=AFPM Simon Glass <sjg@chromium=
=2Eorg> wrote:
> > > > > >
> > > > > > Hi Alexey,
> > > > > >
> > > > > > On Thu, 25 Jun 2026 at 16:52, Alexey Charkov <alchark@flipper.n=
et> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Thu, Jun 25, 2026 at 7:28=E2=80=AFPM Simon Glass <sjg@chro=
mium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Alexey,
> > > > > > > >
> > > > > > > > On 2026-06-04T15:31:05, Alexey Charkov <alchark@flipper.net=
> wrote:
> > > > > > > > > boot: add a minimal bootmeth for the Boot Loader Specific=
ation
> > > > > > > > >
> > > > > > > > > Add a bootmeth that finds and boots Boot Loader Specifica=
tion (BLS)
> > > > > > > > > type #1 entry files [1]. On each block-device partition i=
t scans, the
> > > > > > > > > bootmeth looks for files matching '<prefix>loader/entries=
/*.conf'
> > > > > > > > > (where <prefix> comes from bootstd_get_prefixes(), typica=
lly '/' and
> > > > > > > > > '/boot/'), picks the highest-sorting filename, parses it,=
 and exposes
> > > > > > > > > it as a bootflow.
> > > > > > > > >
> > > > > > > > > Implementation reuses the existing pxelinux infrastructur=
e.
> > > > > > > > >
> > > > > > > > > For now the entry chosen on a partition is purely the lex=
icographic
> > > > > > > > > maximum of *.conf filenames; sort-key / version field han=
dling
> > > > > > > > > (spec-mandated tiebreakers) and boot-counting (the '+TRIE=
S_LEFT'
> > > > > > > > > filename suffix) are left as TODOs. Likewise, only the to=
p-sorted entry
> > > > > > > > > is surfaced because the bootstd framework currently allow=
s one bootflow
> > > > > > > > > per (bootmeth, partition); exposing every discovered entr=
y will require
> > > > > > > > > a framework extension.
> > > > > > > > >
> > > > > > > > > Type #2 BLS (drop-in directory of EFI binaries) is out of=
 scope here;
> > > > > > > > > [...]
> > > > > > > > >
> > > > > > > > > boot/Kconfig        |  17 +++
> > > > > > > > >  boot/Makefile       |   1 +
> > > > > > > > >  boot/bootmeth_bls.c | 333 ++++++++++++++++++++++++++++++=
++++++++++++++++++++++
> > > > > > > > >  3 files changed, 351 insertions(+)
> > > > > > > >
> > > > > > > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > > > > @@ -649,6 +649,23 @@ config BOOTMETH_EXTLINUX_PXE
> > > > > > > > > +config BOOTMETH_BLS
> > > > > > > > > +     bool "Bootdev support for Boot Loader Specification=
 entries"
> > > > > > > > > +     select PXE_UTILS
> > > > > > > > > +     default y
> > > > > > > >
> > > > > > > > Wherever the 'default y' discussion lands, this will be ena=
bled on
> > > > > > > > sandbox, so the 'bootmeth list' tests in test/boot/bootmeth=
=2Ec will
> > > > > > > > fail since they check the exact list and count. Please can =
you run the
> > > > > > > > sandbox tests and update them as needed?
> > > > > > > >
> > > > > > > > Since you are adding a new bootmeth you also need a sandbox=
 test that
> > > > > > > > exercises it (see the extlinux tests in test/boot/bootflow.=
c, with a
> > > > > > > > fixture disk image) and a documentation page, e.g.
> > > > > > > > doc/develop/bootstd/bls.rst with an entry in the index ther=
e.
> > > > > > >
> > > > > > > Will do, thanks!
> > > > > > >
> > > > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > > > @@ -0,0 +1,333 @@
> > > > > > > > > +static int bls_getfile(struct pxe_context *ctx, const ch=
ar *file_path,
> > > > > > > > > +                    char *file_addr, enum bootflow_img_t=
 type, ulong *sizep)
> > > > > > > >
> > > > > > > > This is a verbatim copy of extlinux_getfile() - please can =
you export
> > > > > > > > that, or move it into a shared helper?
> > > > > > >
> > > > > > > Ack
> > > > > > >
> > > > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > > > @@ -0,0 +1,333 @@
> > > > > > > > > +     ret =3D bootmeth_alloc_file(bflow, SZ_64K, 1, BFI_E=
XTLINUX_CFG);
> > > > > > > >
> > > > > > > > The extlinux bootmeth passes ARCH_DMA_MINALIGN here, since =
the buffer
> > > > > > > > is filled by a block-device read which may use DMA on some =
platforms.
> > > > > > > > An alignment of 1 risks cache-line corruption there, so ple=
ase use
> > > > > > > > ARCH_DMA_MINALIGN.
> > > > > > >
> > > > > > > Ack
> > > > > > >
> > > > > > > > > diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
> > > > > > > > > @@ -0,0 +1,333 @@
> > > > > > > > > +     bflow->bootmeth_priv =3D label;
> > > > > > > > > +     free(fpath);
> > > > > > > >
> > > > > > > > This leaks memory: bootflow_free() releases bootmeth_priv w=
ith a plain
> > > > > > > > free(), so the label's string members (name, menu, kernel, =
append,
> > > > > > > > initrd, etc.) are never freed - for every bootflow discarde=
d after a
> > > > > > > > scan, not just on error paths.
> > > > > > > >
> > > > > > > > Since get_string() copies tokens out of the buffer rather t=
han
> > > > > > > > modifying it in place, you could follow the extlinux approa=
ch: keep
> > > > > > > > only bflow->buf across the scan (already populated by
> > > > > > > > bootmeth_alloc_file() and freed by the framework), use a te=
mporary
> > > > > > > > label in bls_read_bootflow() just to extract the title, des=
troy it
> > > > > > > > with label_destroy(), and re-parse the buffer in bls_boot()=
=2E Then
> > > > > > > > bootmeth_priv is not needed at all. What do you think?
> > > > > > >
> > > > > > > Will address the leak, thanks for pointing it out!
> > > > > > >
> > > > > > > The bls_priv structure is needed for my follow-up extension w=
hich
> > > > > > > allows multiple boot entries to be returned by each (bootdev,
> > > > > > > bootmeth, partition) tuple, and I wanted to minimize churn be=
tween
> > > > > > > those two. I haven't sent that follow-up for review yet, as I=
 wanted
> > > > > > > to confirm this simpler version is acceptable first.
> > > > > >
> > > > > > We should implement this using an generic index rather than som=
ething
> > > > > > bls-specific...please see some commits at:
> > > > > >
> > > > > > https://concept.deinde.dev/u-boot/u-boot/-/merge_requests/782
> > > > >
> > > > > Oh, there's already BLS in your tree :-D
> > > > >
> > > > > Would you like to merge that instead? Your version looks much more
> > > > > full-fledged. If you happen to have one rebased on master or next=
 I'd
> > > > > be happy to test!
> > > >
> > > > Unfortunately Simon's work here is AI-generated and so not particul=
arly
> > > > welcome, among other problems right now.
> > >
> > > No, not AI-generated, but certainly AI-assisted (perhaps that is what
> > > you meant?)
> >
> > I didn't dig back super far to see what all AI-generated (such as your
> > dlmalloc upgrade) vs "AI-assisted" (commit from just a few months ago)
> > and try and guess based on the quality if it's "generated" or
> > "assisted". But it doesn't really matter in the AI context. And it
> > certainly doesn't matter until you've donated u-boot.org to the project.
>=20
> Yes the dlmalloc upgrade was a lot of work and brings a lot of
> benefits to U-Boot. There is also a backtrace feature which is really
> handlyfor tracking down memory leaks and hangs. I found a ton of
> leaks, some of them very large (e.g. SCMI). There was certainly a lot
> of manual work involved, along with AI assistance. I believe AI is
> particularly effective when used by someone who knows the project and
> codebase well.

OK, but did you review that dlmalloc upgrade? Did you think Claude did a
good and appropriate job there?

--=20
Tom

--4rpUjkHGJFHksey/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaj6C0QAKCRAr4qD1Cr/k
CnEpAP9pc0bL4IbKYzb4J+VpIpJgJT4zp11U6mIUd0p0GjUCKAD9EJBIpjx0pLT5
DlDMGYjHyykIjCBoAnf+G8wjT2PwFww=
=Lvsg
-----END PGP SIGNATURE-----

--4rpUjkHGJFHksey/--
