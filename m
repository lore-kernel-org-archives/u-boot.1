Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97A5C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 17:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BF8D811CE;
	Thu, 27 Feb 2025 18:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cTSs+fkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A49811E0; Thu, 27 Feb 2025 18:04:01 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31DA4811C1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 18:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fe96dd93b4so2958801a91.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740675835; x=1741280635; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m5D9GM2CHA+o0yP5pVCp1Rk/9R60w6oaeUJhXqt8YHs=;
 b=cTSs+fkx7Ehw3JAxoG5/neeFA9CJoL6Ln6Y2h/9+5dST1H7xJtb4SlI5bizdO5GXx+
 Yz/ob1cXnIQWA2phG1/5J2UKlA9NMq1iluQVQixIfc0nHrOEf2H/kGLLsDmo1D7D0hv8
 XRRmhtfs86dWP31ucrNHwLIBTAaWXFfKnlvJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675835; x=1741280635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5D9GM2CHA+o0yP5pVCp1Rk/9R60w6oaeUJhXqt8YHs=;
 b=dxRhmo98yvO7AlPQlvgO9759m9m1LbKluVi8JuMYlUVAmfU4HHZitquVCojL2lSqRX
 pjYBAccRSpioThGiqtnO618XKD150/YMb6d190pWdJCvz5h7MaphYzW6FuG1OnCmCna7
 WB3O9hdg+EntGn6a7Y/2/TDtlQFSmfRR/FC7WuFoZgAtSrySxnqpLX/RPOi8f531PpQm
 +8ZZM1URiFjFNzRir9rxFMtgNe7KUVj17bsNdvK9+IkX3BpJ01wNneU8y/O9Fh7rIwUC
 Ce0yAWbrWalY3lhxscvipzj6ERVCbAhds2PcU8c6tKII+NA5bggPp+EzILw9VGGL2QaK
 NICw==
X-Gm-Message-State: AOJu0YyAYVJt44safjjbKEVR/UCcXXxMZPy5EQNP0Hl+rhPDLru4BFLa
 BddDnqPioxtcaEo4vQuRpYhBvJ0ZZODck8ekOp8B1vDejxbpNqbRHvtjKzDfRSA=
X-Gm-Gg: ASbGncuvV15eQyMlsHK2/YT+YzFkvneTJA5Vbr9pIRZFnFI34x+S4DmInnN47V8CVMi
 vFfkAiY7Mac/OCsRH+lq7e0+3ZSlnHE2PFtLWx1VfIFzrRGU3yexCP3oxnbDXP9i4j6Z+souBQQ
 6UK7P1RCYGyxn15ySua22Y2xZuVA3ZOgF+3tJCfTL+pzxA1M9a1MsafrHEfBfgjCrnKkzkkfMPt
 zTewL9vyQR6sgwFvjtb+k42OQtqt232s5RdYY1UhJuVSqohaAcDDeYXc064rTzU4jhvLPzhVeP7
 v5m++d9y/+0m1zSHKV3o6eff
X-Google-Smtp-Source: AGHT+IF17ms84Z+AYq8VLTfLKwlUCnrEH2a1hdVZWzCsyAt+JK84zoNuob9Az2FWlkJiyyF9pfVYRA==
X-Received: by 2002:a17:90b:3cc6:b0:2fa:9c9:20a3 with SMTP id
 98e67ed59e1d1-2feb9ac1836mr398380a91.0.1740675835340; 
 Thu, 27 Feb 2025 09:03:55 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb461sm4054832a91.16.2025.02.27.09.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:03:54 -0800 (PST)
Date: Thu, 27 Feb 2025 11:03:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250227170352.GZ2640854@bill-the-cat>
References: <20250216215230.GE1233568@bill-the-cat>
 <CAFLszTiydBJ8BseNHNJO+tf21QwPSJ-Od1Jnp6QWUTsPOmgFdg@mail.gmail.com>
 <20250217141409.GJ1233568@bill-the-cat>
 <CAFLszTij+suCqQ+c0bmTEsHEu6+xUWWCMEG-gJ5DYbjhv0oJGg@mail.gmail.com>
 <20250222000819.GX1233568@bill-the-cat>
 <CAFLszThLjxyMPty=tvrE9nQMNOtcF1H-njBb0Tep_ccXee3waw@mail.gmail.com>
 <20250222213748.GB1233568@bill-the-cat>
 <CAFLszTj31qtx5TmOVLJAfhpzWHKTc9kcp22JTgJBe2bePSU60A@mail.gmail.com>
 <20250224231455.GI1233568@bill-the-cat>
 <CAFLszTiP+wPijf0QbTL0i9Ywk_0tWFwYP-1S1Lp+mFeqN=8zKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f5TFPc9ekEk3KMKI"
Content-Disposition: inline
In-Reply-To: <CAFLszTiP+wPijf0QbTL0i9Ywk_0tWFwYP-1S1Lp+mFeqN=8zKg@mail.gmail.com>
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


--f5TFPc9ekEk3KMKI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 09:26:10AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 24 Feb 2025 at 16:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 22, 2025 at 05:24:05PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 22 Feb 2025 at 14:37, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Feb 22, 2025 at 10:23:59AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 21 Feb 2025 at 17:08, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Feb 21, 2025 at 04:42:09PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 17 Feb 2025 at 07:14, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Mon, Feb 17, 2025 at 06:14:06AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Sun, 16 Feb 2025 at 14:52, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sun, Feb 16, 2025 at 12:39:34PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Thu, Feb 06, 2025 at 03:38:55PM -070=
0, Simon Glass wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > This is a global default, so put it u=
nder 'default' like the tags.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chrom=
ium.org>
> > > > > > > > > > > > > > > > > > > Suggested-by: Tom Rini <trini@konsulk=
o.com>
> > > > > > > > > > > > > > > > > > > Reviewed-by: Tom Rini <trini@konsulko=
=2Ecom>
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Please make v4 include the way you redi=
d the second patch and be on top
> > > > > > > > > > > > > > > > > > of mainline, thanks.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > That's enough versions for me, so I'll le=
t you do that, if you'd like.
> > > > > > > > > > > > > > > > > It probably doesn't affect your tree as n=
ot as much is done in
> > > > > > > > > > > > > > > > > parallel.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I am disappointed.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I'm sorry to disappoint you.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > The background is that I looked at the differ=
ence between our trees
> > > > > > > > > > > > > > > and the gitlab files are quite different. My =
CI runs take about 35
> > > > > > > > > > > > > > > mins and it seems that yours is around 90 min=
s. I would like to reduce
> > > > > > > > > > > > > > > / remove the delta (for time and patch diff),=
 but I'm not sure how.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > My goal is to get CI runs to below 20 minutes=
, best case.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'm sure CI could be quicker still with a numbe=
r of faster runners. But
> > > > > > > > > > > > > > if you can't be bothered to make changes agains=
t mainline, what is the
> > > > > > > > > > > > > > point?
> > > > > > > > > > > > >
> > > > > > > > > > > > > If you recall, I was working with your tree and h=
ad various ideas to
> > > > > > > > > > > > > speed things up, but you didn't like it. So I've =
had to do it in my
> > > > > > > > > > > > > tree. This is not about more runners (although I =
might have another
> > > > > > > > > > > > > one soon). It is about running jobs in parallel.
> > > > > > > > > > > >
> > > > > > > > > > > > And I wasn't sure more runners in parallel would he=
lp (as it would slow
> > > > > > > > > > > > down the fast runner which is what keeps the long j=
obs from being even
> > > > > > > > > > > > longer) as much as adding more regular runners woul=
d (which we've done)
> > > > > > > > > > > > and noted that in the end it's a configuration on t=
he runner side so to
> > > > > > > > > > > > go ahead. And I reviewed and ack'd the patches here=
 which exposed the
> > > > > > > > > > > > issues your path revealed. I just can't apply them =
because they need to
> > > > > > > > > > > > be rebased (and squashed).
> > > > > > > > > > >
> > > > > > > > > > > You have already added tags for things, but (IIUC) th=
ey are around the
> > > > > > > > > > > other way from what I have added.
> > > > > > > > > > >
> > > > > > > > > > > I have a tag called 'single' which means that the mac=
hine is only
> > > > > > > > > > > allowed to one of those jobs. The world-build jobs ar=
e marked with
> > > > > > > > > > > 'single'.
> > > > > > > > > > >
> > > > > > > > > > > For other jobs, I allow the runners to pick up some i=
n parallel
> > > > > > > > > > > depending on their performance (for moa and tui that =
is 10).
> > > > > > > > > > >
> > > > > > > > > > > So at most, there is a 'world build' and 10 test.py j=
obs running on
> > > > > > > > > > > the same machine. It seems to work fine in practice, =
although I would
> > > > > > > > > > > rather be able to make these two types of jobs mutual=
ly exclusive, so
> > > > > > > > > > > that a runner is either running 10 parallel jobs or 1=
 'single' job,
> > > > > > > > > > > but not both. I'm not sure how to do that.
> > > > > > > > > >
> > > > > > > > > > So unless I'm missing something, in both cases the bott=
leneck is that
> > > > > > > > > > for world build jobs you don't want anything else going=
 on with the
> > > > > > > > > > underlying build host. You could register 10 "all" runn=
ers and 1 "fast
> > > > > > > > > > amd64" runner (and something similar but smaller for al=
exandra). If you
> > > > > > > > > > update the registrations on source.denx.de can you then=
 shut down your
> > > > > > > > > > gitlab instance?
> > > > > > > > >
> > > > > > > > > I've put a tag of 'single' on things that should run on t=
he single-job
> > > > > > > > > runner. Everything else can run concurrently, e.g. up to =
10 jobs. So I
> > > > > > > > > have two runners on the same host. E.g. tui-single has 'l=
imit =3D 1',
> > > > > > > > > but 'tui' has no limit and is just governed by the 'concu=
rrent =3D 10'
> > > > > > > > > at the top of the file.
> > > > > > > >
> > > > > > > > Yes. And you could move those runners to the mainline gitla=
b. There is
> > > > > > > > no "single" tag, that would be the "all" tag. And "tui-sing=
le" would be
> > > > > > > > "fast amd64".
> > > > > > >
> > > > > > > They are still attached to the Denx gitlab. Nothing has chang=
ed on my
> > > > > > > side. I'm not sure that your new tags are working though. I h=
ave a
> > > > > > > feeling something broke along the way when you made all your =
tag
> > > > > > > changes. One of my servers makes a bit of noise and I haven't=
 heard it
> > > > > > > in quite a while.
> > > > > >
> > > > > > There's a few of your runners that are "stale" and haven't cont=
acted
> > > > > > gitlab in a long time. I'll double check the tags tho.
> > > > > >
> > > > > > > If Denx would like to give me access to their gitlab instance=
s, I'd be
> > > > > > > happy to play around and figure out how to get it going as fa=
st as my
> > > > > > > tree does, and send a patch.
> > > > > >
> > > > > > I'm not sure what you mean by that? The instance itself?
> > > > >
> > > > > Yes. I can fiddle with tags on my runners and try to figure it ou=
t.
> > > >
> > > > I'm not sure what you're getting at here. If you mean "tags" in
> > > > /etc/gitlab-runner/config.toml those aren't relevant here I believe.
> > >
> > > No, I mean the tags in CI. If I fiddle with them I can probably come
> > > up with a way to run your CI much faster. Mine is about 35mins.
> >
> > I'm not so sure about that. Yours runs faster because it tests less. Now
> > that we've got some of your other fast runners showing up again, this is
> > more instructive of current times I think:
> > https://source.denx.de/u-boot/u-boot/-/pipelines/24802
>=20
> But not this? :

You forgot a link. But presumably to some run yesterday which took
longer. And because Ilias was tweaking the currently donated arm64
runners (that have other jobs to run) and also we had two or three
custodians at a time preparing trees, things ran slower.

> > If you want to make mainline CI run faster you will need to catch up
> > with the missing coverage or argue that some things are redundant.
>=20
> Or perhaps I can actually just make it faster without dropping coverage?

I mean, I don't know how that's physically possible, outside of adding
many more expensive build hosts. We have two-three fast arm64 hosts and
that world builds between 30-45 minutes. That's the biggest time
bottleneck.

The next biggest is that unless sandbox tests are run on a fast host,
they take upwards of 10 minutes, rather than 5.

But please, rebase your work to next and see what you can do. There is
likely some speed-ups possible if we allow for failures to take longer
to happen (and don't gate world builds on all of test.py stage
completing, just say sandbox). And if you do the work on source.denx.de
(as there is *NOTHING* stopping you from registering more runners to
your tree and using whatever tagging scheme you like) you might even see
more of the time variability due to load from other custodians.

> > > > > > > I also have another runner to add.
> > > > > >
> > > > > > I'll contact you off-list with the token.
> > > > > >
> > > > > > > > > From my side, I have found it helpful and refreshing to h=
ave a gitlab
> > > > > > > > > instance which I can control, e.g. it runs in half the ti=
me and if my
> > > > > > > > > patches are completely blocked by Linaro, etc., I have an=
 escape
> > > > > > > > > valve.
> > > > > > > >
> > > > > > > > Yes, and I have no idea what any of that has to do with any=
thing other
> > > > > > > > than leading to confusion about what tree is or is not main=
line. Since
> > > > > > > > you own u-boot.org and ci.u-boot.org is your gitlab and
> > > > > > > > https://ci.u-boot.org/u-boot/u-boot/ is your personal tree.
> > > > > > >
> > > > > > > For now I am working with my tree, so that I am not blocked b=
y Linaro,
> > > > > > > etc. but as you have seen I can rebase series for your tree a=
s needed.
> > > > > >
> > > > > > And you're not addressing my point about using the project doma=
in for
> > > > > > your personal tree. That's my big huge "are you forking the pro=
ject or
> > > > > > what" problem.
> > > > >
> > > > > I'm just making sure that my work is not blocked or lost, as that=
 has
> > > > > happened too many times in the past few years.
> > > >
> > > > Again, are you intending to fork the project? Putting your personal=
 tree
> > > > in as "https://ci.u-boot.org/u-boot/u-boot.git" is not OK. I keep a=
sking
> > > > you to stop it.
> > >
> > > No, I'm not intending to fork anything. But I need a tree that I can
> > > control and push things into.
> >
> > I don't know how you can call your personal tree being at
> > "https://ci.u-boot.org/u-boot/u-boot.git" and saying it's somewhere you
> > control and can push to while not also saying it's a fork. If you want
> > to close down your gitlab and CNAME ci.u-boot.org to source.denx.de, you
> > can still push things to u-boot-dm. Or if that's too constrained of a
> > namespace you can also get a contributors/sjg/ namespace. But what
> > you're doing today WILL lead to confusion.
>=20
> I believe I've answered this question before. It is simply that I
> cannot get certain patches (bloblist, EFI, devicetree) into your tree.
> There really isn't any other reason.

Yes, that's still not an answer to my question.

Or is the answer to my question "Yes, I'm trying to confuse people to
thinking my tree is mainline."

> At the moment your CI seems to be flaky as well:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/1038174

[aside, I think you meant to link to the pipeline itself, which also
passed, but had some retries]

Funny story. Ilias needed to tweak the fast arm64 hosts and also wanted
to explore "What if we have concurrency higher?" and ran in to the
problems you also ran in to with respect to git seeing an existing clone
in progress and bailing. Followed by the problem of multiple non-trivial
jobs running concurrently.

All of which is why I keep trying to tell you that while "single" and
concurrent runners work fine for you on a single user instance it will
not scale.

--=20
Tom

--f5TFPc9ekEk3KMKI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAmvQACgkQFHw5/5Y0
tyyo9AwAobR2e9FXnMwqi/Pfu9mYGQ2zc9N6AbbeXbA45nBlbk9QwWNWfsCqKXeE
e1L5hd/LG6scZYSKWiPvlQawdrXmc2/Js2ufq/20x3vvKgKsExfO5Y73rSqMbcIw
N2+m+RVrORIP4Dqns75VC5f7tCJsxXWIL+uQKV5citwp80Z2yjEP/QaaOtVrgZSg
8OXrLjWnBxzHw+oZUSqK1LCQV+yOoOSeXN3ObhqfNzMqrn0EVz/ybAbL7gi1N+Jl
Td4O2jOfZmFSIPRFC8dr08zAfpexegnwbfH0z5zlp/L0zlWBawDQb//Ryr46r7Iz
wl0LcsJ5CknUrNkFsNkE0dZSiSJO6vJnItayXdQiTYddwPIwE16I6/LPSDxrLB5c
Ru4ojrAjv3rq/mheTKi6GqDnx1O9EjLRL8kPcvKs8RGGg6J4RUVVYlW4tHNOKHiT
LkVwHlnTLNu6eRebHF3Jm32u2JowgCDgoJLZQdu3LfYsxK82bCpZ9Rhc+rnkehYH
bH2ixZf1
=1HuQ
-----END PGP SIGNATURE-----

--f5TFPc9ekEk3KMKI--
