Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D710C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 21:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 706A080F91;
	Sat, 22 Feb 2025 22:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BBDxlJVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D42C6808B6; Sat, 22 Feb 2025 22:37:56 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9BCC80F7B
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 22:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so5177173a91.0
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 13:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740260272; x=1740865072; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Mm2jhriCdcZBDHVcCWYzH26qjspYY/NYFvZ7EvUhk7A=;
 b=BBDxlJVftqCpFfWtVhVpfvZmb7UPUwfq6xGLDD+sXFWYVLPjfDwAUOqrnpBtevesAD
 VfA9ZnRIgXCG3TBAnuUJNQekz/OhpsDTo3bvWGsrZQ0T8yQAERXa1PzbPD60IEfUb8nT
 ND+hdjOrqD4hPf+OmK/9j2j3V2JFHG2Q7GL7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740260272; x=1740865072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mm2jhriCdcZBDHVcCWYzH26qjspYY/NYFvZ7EvUhk7A=;
 b=XFLp0zXIq8PLfdMYXMMzUW4vmW71S26v4bmEDzEPWUbCmTfq9EQuUWa2gMW3mqH2hR
 c//o1DVqcuPGLcztmtpSjAbZfcUHKBee0umtIw1UmJ5wAn8WBvcphDBpa1u77tAG4XYr
 kAZ2PJUFhTcki5R6XJFohcCAbBGm0X9M6tZoUoan8axe/Y8qCJ6YU67/G7uyB0wEax3+
 X+lmG1ZvfF6kR2RVlobJoR2wv0Mslr981SkVrCw1dXoe56pm98pwGvWAQ9nSljnNWYXo
 ljwhJvFCYFT2FCQMsK/BuF+yaWXyCDUYRl0W031YRaNun+w/v/FD8kEYUYVSQJNv42t5
 GxVw==
X-Gm-Message-State: AOJu0Yzd5/NP9KBprfhCSlBT51UTYpNGLQp8SMibVxyiGI1RKcOc14Fd
 tr5+D3ZzF7xA7yUXrQGClpQSnjPs2OT/15rVmwrZmJWVDSN/xCGnu4+YKzvHXrNPSNUk3NHQUpN
 g0Tc=
X-Gm-Gg: ASbGncuBPcj+31fS6zhpeUK+oijjXjOvrpbetWSSrQxBMmHY1zpanuC7JP/aWZciWoZ
 pmsfz+vmCo6yRlTHNXzmWwrcFqLUpFufhRwv6WChs6iOTUWFUYfIJVXErbxfCr9I9CRZwoytHfb
 IsiXaY8Ll64d+tZ+TjcdcZtY+ZcuuQ8ehdft2XwYl/nDAfOF/iGWT65p1dExpgw4HkXwxbP/lFj
 oY8BKVKfAI8uX3i4+E9nnoR14j7guTamURz3GGJdPsjUYuSYZGrEhyhg2Uk7bWpbt7U1Rif9nzl
 L7/qNm2UpZ22FmyIG1HDSaEv
X-Google-Smtp-Source: AGHT+IEhrKt62vbYYN1NJqXIeY4lvek/B9WJrTEcFwUoqvlnXiVhd2r19TnwsmukdxBct8dkyJLQBw==
X-Received: by 2002:a05:6a21:33a8:b0:1ee:d317:48e6 with SMTP id
 adf61e73a8af0-1eef3c588f9mr15012881637.7.1740260272260; 
 Sat, 22 Feb 2025 13:37:52 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327590ff12sm12391901b3a.115.2025.02.22.13.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 13:37:51 -0800 (PST)
Date: Sat, 22 Feb 2025 15:37:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250222213748.GB1233568@bill-the-cat>
References: <20250215181227.GT1233568@bill-the-cat>
 <CAFLszThJ11Ph-8zaNV_D0u7-UD18XtULm0kwhgQmMAj5xFgHtA@mail.gmail.com>
 <20250216160744.GA1233568@bill-the-cat>
 <CAFLszTiihyuqFBcdacu+2wfd3ivDzjf4nVqfU0BgKUc0u1s6=Q@mail.gmail.com>
 <20250216215230.GE1233568@bill-the-cat>
 <CAFLszTiydBJ8BseNHNJO+tf21QwPSJ-Od1Jnp6QWUTsPOmgFdg@mail.gmail.com>
 <20250217141409.GJ1233568@bill-the-cat>
 <CAFLszTij+suCqQ+c0bmTEsHEu6+xUWWCMEG-gJ5DYbjhv0oJGg@mail.gmail.com>
 <20250222000819.GX1233568@bill-the-cat>
 <CAFLszThLjxyMPty=tvrE9nQMNOtcF1H-njBb0Tep_ccXee3waw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5exQlsG3xVImw1kc"
Content-Disposition: inline
In-Reply-To: <CAFLszThLjxyMPty=tvrE9nQMNOtcF1H-njBb0Tep_ccXee3waw@mail.gmail.com>
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


--5exQlsG3xVImw1kc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 10:23:59AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 21 Feb 2025 at 17:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 04:42:09PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 17 Feb 2025 at 07:14, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Feb 17, 2025 at 06:14:06AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sun, 16 Feb 2025 at 14:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Feb 16, 2025 at 12:39:34PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This is a global default, so put it under 'de=
fault' like the tags.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Please make v4 include the way you redid the se=
cond patch and be on top
> > > > > > > > > > > > > > of mainline, thanks.
> > > > > > > > > > > > >
> > > > > > > > > > > > > That's enough versions for me, so I'll let you do=
 that, if you'd like.
> > > > > > > > > > > > > It probably doesn't affect your tree as not as mu=
ch is done in
> > > > > > > > > > > > > parallel.
> > > > > > > > > > > >
> > > > > > > > > > > > I am disappointed.
> > > > > > > > > > >
> > > > > > > > > > > I'm sorry to disappoint you.
> > > > > > > > > > >
> > > > > > > > > > > The background is that I looked at the difference bet=
ween our trees
> > > > > > > > > > > and the gitlab files are quite different. My CI runs =
take about 35
> > > > > > > > > > > mins and it seems that yours is around 90 mins. I wou=
ld like to reduce
> > > > > > > > > > > / remove the delta (for time and patch diff), but I'm=
 not sure how.
> > > > > > > > > > >
> > > > > > > > > > > My goal is to get CI runs to below 20 minutes, best c=
ase.
> > > > > > > > > >
> > > > > > > > > > I'm sure CI could be quicker still with a number of fas=
ter runners. But
> > > > > > > > > > if you can't be bothered to make changes against mainli=
ne, what is the
> > > > > > > > > > point?
> > > > > > > > >
> > > > > > > > > If you recall, I was working with your tree and had vario=
us ideas to
> > > > > > > > > speed things up, but you didn't like it. So I've had to d=
o it in my
> > > > > > > > > tree. This is not about more runners (although I might ha=
ve another
> > > > > > > > > one soon). It is about running jobs in parallel.
> > > > > > > >
> > > > > > > > And I wasn't sure more runners in parallel would help (as i=
t would slow
> > > > > > > > down the fast runner which is what keeps the long jobs from=
 being even
> > > > > > > > longer) as much as adding more regular runners would (which=
 we've done)
> > > > > > > > and noted that in the end it's a configuration on the runne=
r side so to
> > > > > > > > go ahead. And I reviewed and ack'd the patches here which e=
xposed the
> > > > > > > > issues your path revealed. I just can't apply them because =
they need to
> > > > > > > > be rebased (and squashed).
> > > > > > >
> > > > > > > You have already added tags for things, but (IIUC) they are a=
round the
> > > > > > > other way from what I have added.
> > > > > > >
> > > > > > > I have a tag called 'single' which means that the machine is =
only
> > > > > > > allowed to one of those jobs. The world-build jobs are marked=
 with
> > > > > > > 'single'.
> > > > > > >
> > > > > > > For other jobs, I allow the runners to pick up some in parall=
el
> > > > > > > depending on their performance (for moa and tui that is 10).
> > > > > > >
> > > > > > > So at most, there is a 'world build' and 10 test.py jobs runn=
ing on
> > > > > > > the same machine. It seems to work fine in practice, although=
 I would
> > > > > > > rather be able to make these two types of jobs mutually exclu=
sive, so
> > > > > > > that a runner is either running 10 parallel jobs or 1 'single=
' job,
> > > > > > > but not both. I'm not sure how to do that.
> > > > > >
> > > > > > So unless I'm missing something, in both cases the bottleneck i=
s that
> > > > > > for world build jobs you don't want anything else going on with=
 the
> > > > > > underlying build host. You could register 10 "all" runners and =
1 "fast
> > > > > > amd64" runner (and something similar but smaller for alexandra)=
=2E If you
> > > > > > update the registrations on source.denx.de can you then shut do=
wn your
> > > > > > gitlab instance?
> > > > >
> > > > > I've put a tag of 'single' on things that should run on the singl=
e-job
> > > > > runner. Everything else can run concurrently, e.g. up to 10 jobs.=
 So I
> > > > > have two runners on the same host. E.g. tui-single has 'limit =3D=
 1',
> > > > > but 'tui' has no limit and is just governed by the 'concurrent =
=3D 10'
> > > > > at the top of the file.
> > > >
> > > > Yes. And you could move those runners to the mainline gitlab. There=
 is
> > > > no "single" tag, that would be the "all" tag. And "tui-single" woul=
d be
> > > > "fast amd64".
> > >
> > > They are still attached to the Denx gitlab. Nothing has changed on my
> > > side. I'm not sure that your new tags are working though. I have a
> > > feeling something broke along the way when you made all your tag
> > > changes. One of my servers makes a bit of noise and I haven't heard it
> > > in quite a while.
> >
> > There's a few of your runners that are "stale" and haven't contacted
> > gitlab in a long time. I'll double check the tags tho.
> >
> > > If Denx would like to give me access to their gitlab instances, I'd be
> > > happy to play around and figure out how to get it going as fast as my
> > > tree does, and send a patch.
> >
> > I'm not sure what you mean by that? The instance itself?
>=20
> Yes. I can fiddle with tags on my runners and try to figure it out.

I'm not sure what you're getting at here. If you mean "tags" in
/etc/gitlab-runner/config.toml those aren't relevant here I believe.

> > > I also have another runner to add.
> >
> > I'll contact you off-list with the token.
> >
> > > > > From my side, I have found it helpful and refreshing to have a gi=
tlab
> > > > > instance which I can control, e.g. it runs in half the time and i=
f my
> > > > > patches are completely blocked by Linaro, etc., I have an escape
> > > > > valve.
> > > >
> > > > Yes, and I have no idea what any of that has to do with anything ot=
her
> > > > than leading to confusion about what tree is or is not mainline. Si=
nce
> > > > you own u-boot.org and ci.u-boot.org is your gitlab and
> > > > https://ci.u-boot.org/u-boot/u-boot/ is your personal tree.
> > >
> > > For now I am working with my tree, so that I am not blocked by Linaro,
> > > etc. but as you have seen I can rebase series for your tree as needed.
> >
> > And you're not addressing my point about using the project domain for
> > your personal tree. That's my big huge "are you forking the project or
> > what" problem.
>=20
> I'm just making sure that my work is not blocked or lost, as that has
> happened too many times in the past few years.

Again, are you intending to fork the project? Putting your personal tree
in as "https://ci.u-boot.org/u-boot/u-boot.git" is not OK. I keep asking
you to stop it.

> BTW weka is too slow so I took it off.

I'll remove it.

> tui is running but seems to be renamed 'tui-redux' now. I don't see it
> getting jobs though.

It's been getting jobs. Is it something sufficiently fast that it should
be doing big jobs?

--=20
Tom

--5exQlsG3xVImw1kc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme6Q6kACgkQFHw5/5Y0
tyz7aAv/VtMW3xpaCFXbHdRxlVg1uexfI5wIuricmBix+TLfnw/Pnav7rQACSNf+
0eivjHNpeyYVp85leLvhFulQmWJaXLlJA78k2u/7fTUK8QT22gzDo+8jVpDWwKZJ
xhmTxxDJFi9kuiYJqVnHb//Sniea2veyn7ZBXZjj9/77MHQQY3k+MC8fqlk4u/3k
odY5IdOZClEQVVB9k4ARdsV6ldQjiU3KbC5XUVzpeAZwRC8tb2+z6vdMoojN9ap3
8lRBDQ/P05SRunjb1zymD3o6jJDG5oAIB2l9z6l4XbyCzSaUK2+ISDPqx7pzg96u
PS0Sky/Yw7BNB43pBZZNIHZkpprYbT3BJpyYdabREcO06TWkb/VUDqf2yZGSE3g+
vYLDYHmI+am9heSITzrvJo2EABIoxZzkOH/7ChvmkUv5L8L1YaonnK0LsF5hvIth
bLYbl0SPRiplc3pbmK5XqgaG9ZzFVx95ua9nhvdQ0hoJoid4gTqvuaVZv7gtfQ4r
itjz5ON/
=vNjv
-----END PGP SIGNATURE-----

--5exQlsG3xVImw1kc--
