Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0DDC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D45D805C3;
	Tue,  4 Mar 2025 17:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YUMGkABP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA97807EE; Tue,  4 Mar 2025 17:12:28 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 200088004F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e60dfd01557so2040603276.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 08:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741104744; x=1741709544; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IIH8xIHBeqkuKVb5e8o3982hesEAmvHFivqy54qUSfY=;
 b=YUMGkABP+NnkYFTYgsdEnywq8E0q3L8FbU3nzs0J1t299Ru1iCnAdJmyOvllT+QpV5
 8nInuU9AllJ6fxv9Cgr9ixx9hbxRDk++RCcCn+9V8Q5ql57qCQ5gD6PH2Yn22QpXUtMn
 3hna91/y0juhHnW8jTjs1Bc2a1JWPpExG2KV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741104744; x=1741709544;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IIH8xIHBeqkuKVb5e8o3982hesEAmvHFivqy54qUSfY=;
 b=Gp5+P2fTguGqzhKO0bKL1ApIRgx7XSVFtylahb9cnlosNcuwIlHazO3uy5Hp7+0B+H
 nRclzbJyesisf0Vn/u7vQH5Cg8JSo+9SaEC+yBXH+aJHXQflEwkxL01/7m4MMCALAmkt
 tlsN86NSIDIz+4Zma3GlW3qQlJLcEaiyI+ohcqiD1lTu+PByfC+Fwa+762r8cVwwb6NJ
 hHSfdCDsQ5koY+nkjQpAfjwvsiwqO8eYv4Oj0d7inPT4pZnQ4W0LA5Nhu8oN3wKi9rSz
 D9EIIek3Ug7HKWfjXZSbB+1Gmeu8YSJMR7vNzAjSJC4hr+1Mkoahu0JmHAH3zf69aLxj
 9mfQ==
X-Gm-Message-State: AOJu0YyU+S5vSVj/xJ+HJkKo0alUlPkTaGOfElSGcXcZ9JT5GEorC+p+
 7J+TH1NzACY0urDDono0Mu1gaPKa6+//zsaejNFw97WF8MVj+Eu2PD8GIKZPMPLXeArXupr2Fdw
 4
X-Gm-Gg: ASbGncvAGvuFVG/ZVuk8u5MwPw0KC8V4x+P1I8pKw3AUwWc5IblKp3/3XleCtV+mXWl
 HoO18EcqILztE1lMYeCO6KzPe4sVelvLkgwrYnaGeCYMSZgC8gyr9l3HILwZBsnRpEqOIP/v0gt
 6VsddOUE3k1OeqWc3yCTCv+QayjHiS8V0OPUSlNiW1wS/0Xbs3CVAyT+zblEdyVrUfLcpMfViaU
 3jTx6h+qih5lnDGfNF7kueV9aXUd0h+GnJBM12QmSL6kK6FlF1UUJBmT4Hb1GcYYpqELqWPtJhC
 yik6LvaxXViwsB6ACvbhcMNgTI4WiNFz6OFe0kYuuEc=
X-Google-Smtp-Source: AGHT+IGUX+uMcMHwl9dFk+E99RPKndQZd6vX/jHys6I4eC8KcbM5BUuqGZfjEVmX+f/8b4DzJAFomA==
X-Received: by 2002:a05:6902:2ec4:b0:e61:1d35:27fb with SMTP id
 3f1490d57ef6-e611d352e14mr102706276.15.1741104742098; 
 Tue, 04 Mar 2025 08:12:22 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e61123e198csm446452276.53.2025.03.04.08.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 08:12:21 -0800 (PST)
Date: Tue, 4 Mar 2025 10:12:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250304161218.GA2640854@bill-the-cat>
References: <20250217141409.GJ1233568@bill-the-cat>
 <CAFLszTij+suCqQ+c0bmTEsHEu6+xUWWCMEG-gJ5DYbjhv0oJGg@mail.gmail.com>
 <20250222000819.GX1233568@bill-the-cat>
 <CAFLszThLjxyMPty=tvrE9nQMNOtcF1H-njBb0Tep_ccXee3waw@mail.gmail.com>
 <20250222213748.GB1233568@bill-the-cat>
 <CAFLszTj31qtx5TmOVLJAfhpzWHKTc9kcp22JTgJBe2bePSU60A@mail.gmail.com>
 <20250224231455.GI1233568@bill-the-cat>
 <CAFLszTiP+wPijf0QbTL0i9Ywk_0tWFwYP-1S1Lp+mFeqN=8zKg@mail.gmail.com>
 <20250227170352.GZ2640854@bill-the-cat>
 <CAFLszTgDms-RC+Qg=FLxtW253jh22eUb1Y-5OyB2U42EygdZWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7vC7tuResYHEKFht"
Content-Disposition: inline
In-Reply-To: <CAFLszTgDms-RC+Qg=FLxtW253jh22eUb1Y-5OyB2U42EygdZWw@mail.gmail.com>
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


--7vC7tuResYHEKFht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 08:35:56AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 27 Feb 2025 at 10:03, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 27, 2025 at 09:26:10AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 24 Feb 2025 at 16:14, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Feb 22, 2025 at 05:24:05PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 22 Feb 2025 at 14:37, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Feb 22, 2025 at 10:23:59AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 21 Feb 2025 at 17:08, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Feb 21, 2025 at 04:42:09PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 17 Feb 2025 at 07:14, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Feb 17, 2025 at 06:14:06AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Sun, 16 Feb 2025 at 14:52, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Sun, Feb 16, 2025 at 12:39:34PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 10:21:16AM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 04:59:40AM -070=
0, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rin=
i <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Thu, Feb 06, 2025 at 03:38:55PM =
-0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > This is a global default, so put =
it under 'default' like the tags.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@c=
hromium.org>
> > > > > > > > > > > > > > > > > > > > > Suggested-by: Tom Rini <trini@kon=
sulko.com>
> > > > > > > > > > > > > > > > > > > > > Reviewed-by: Tom Rini <trini@kons=
ulko.com>
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Please make v4 include the way you =
redid the second patch and be on top
> > > > > > > > > > > > > > > > > > > > of mainline, thanks.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > That's enough versions for me, so I'l=
l let you do that, if you'd like.
> > > > > > > > > > > > > > > > > > > It probably doesn't affect your tree =
as not as much is done in
> > > > > > > > > > > > > > > > > > > parallel.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I am disappointed.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I'm sorry to disappoint you.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > The background is that I looked at the di=
fference between our trees
> > > > > > > > > > > > > > > > > and the gitlab files are quite different.=
 My CI runs take about 35
> > > > > > > > > > > > > > > > > mins and it seems that yours is around 90=
 mins. I would like to reduce
> > > > > > > > > > > > > > > > > / remove the delta (for time and patch di=
ff), but I'm not sure how.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > My goal is to get CI runs to below 20 min=
utes, best case.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I'm sure CI could be quicker still with a n=
umber of faster runners. But
> > > > > > > > > > > > > > > > if you can't be bothered to make changes ag=
ainst mainline, what is the
> > > > > > > > > > > > > > > > point?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > If you recall, I was working with your tree a=
nd had various ideas to
> > > > > > > > > > > > > > > speed things up, but you didn't like it. So I=
've had to do it in my
> > > > > > > > > > > > > > > tree. This is not about more runners (althoug=
h I might have another
> > > > > > > > > > > > > > > one soon). It is about running jobs in parall=
el.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > And I wasn't sure more runners in parallel woul=
d help (as it would slow
> > > > > > > > > > > > > > down the fast runner which is what keeps the lo=
ng jobs from being even
> > > > > > > > > > > > > > longer) as much as adding more regular runners =
would (which we've done)
> > > > > > > > > > > > > > and noted that in the end it's a configuration =
on the runner side so to
> > > > > > > > > > > > > > go ahead. And I reviewed and ack'd the patches =
here which exposed the
> > > > > > > > > > > > > > issues your path revealed. I just can't apply t=
hem because they need to
> > > > > > > > > > > > > > be rebased (and squashed).
> > > > > > > > > > > > >
> > > > > > > > > > > > > You have already added tags for things, but (IIUC=
) they are around the
> > > > > > > > > > > > > other way from what I have added.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I have a tag called 'single' which means that the=
 machine is only
> > > > > > > > > > > > > allowed to one of those jobs. The world-build job=
s are marked with
> > > > > > > > > > > > > 'single'.
> > > > > > > > > > > > >
> > > > > > > > > > > > > For other jobs, I allow the runners to pick up so=
me in parallel
> > > > > > > > > > > > > depending on their performance (for moa and tui t=
hat is 10).
> > > > > > > > > > > > >
> > > > > > > > > > > > > So at most, there is a 'world build' and 10 test.=
py jobs running on
> > > > > > > > > > > > > the same machine. It seems to work fine in practi=
ce, although I would
> > > > > > > > > > > > > rather be able to make these two types of jobs mu=
tually exclusive, so
> > > > > > > > > > > > > that a runner is either running 10 parallel jobs =
or 1 'single' job,
> > > > > > > > > > > > > but not both. I'm not sure how to do that.
> > > > > > > > > > > >
> > > > > > > > > > > > So unless I'm missing something, in both cases the =
bottleneck is that
> > > > > > > > > > > > for world build jobs you don't want anything else g=
oing on with the
> > > > > > > > > > > > underlying build host. You could register 10 "all" =
runners and 1 "fast
> > > > > > > > > > > > amd64" runner (and something similar but smaller fo=
r alexandra). If you
> > > > > > > > > > > > update the registrations on source.denx.de can you =
then shut down your
> > > > > > > > > > > > gitlab instance?
> > > > > > > > > > >
> > > > > > > > > > > I've put a tag of 'single' on things that should run =
on the single-job
> > > > > > > > > > > runner. Everything else can run concurrently, e.g. up=
 to 10 jobs. So I
> > > > > > > > > > > have two runners on the same host. E.g. tui-single ha=
s 'limit =3D 1',
> > > > > > > > > > > but 'tui' has no limit and is just governed by the 'c=
oncurrent =3D 10'
> > > > > > > > > > > at the top of the file.
> > > > > > > > > >
> > > > > > > > > > Yes. And you could move those runners to the mainline g=
itlab. There is
> > > > > > > > > > no "single" tag, that would be the "all" tag. And "tui-=
single" would be
> > > > > > > > > > "fast amd64".
> > > > > > > > >
> > > > > > > > > They are still attached to the Denx gitlab. Nothing has c=
hanged on my
> > > > > > > > > side. I'm not sure that your new tags are working though.=
 I have a
> > > > > > > > > feeling something broke along the way when you made all y=
our tag
> > > > > > > > > changes. One of my servers makes a bit of noise and I hav=
en't heard it
> > > > > > > > > in quite a while.
> > > > > > > >
> > > > > > > > There's a few of your runners that are "stale" and haven't =
contacted
> > > > > > > > gitlab in a long time. I'll double check the tags tho.
> > > > > > > >
> > > > > > > > > If Denx would like to give me access to their gitlab inst=
ances, I'd be
> > > > > > > > > happy to play around and figure out how to get it going a=
s fast as my
> > > > > > > > > tree does, and send a patch.
> > > > > > > >
> > > > > > > > I'm not sure what you mean by that? The instance itself?
> > > > > > >
> > > > > > > Yes. I can fiddle with tags on my runners and try to figure i=
t out.
> > > > > >
> > > > > > I'm not sure what you're getting at here. If you mean "tags" in
> > > > > > /etc/gitlab-runner/config.toml those aren't relevant here I bel=
ieve.
> > > > >
> > > > > No, I mean the tags in CI. If I fiddle with them I can probably c=
ome
> > > > > up with a way to run your CI much faster. Mine is about 35mins.
> > > >
> > > > I'm not so sure about that. Yours runs faster because it tests less=
=2E Now
> > > > that we've got some of your other fast runners showing up again, th=
is is
> > > > more instructive of current times I think:
> > > > https://source.denx.de/u-boot/u-boot/-/pipelines/24802
> > >
> > > But not this? :
> >
> > You forgot a link. But presumably to some run yesterday which took
> > longer. And because Ilias was tweaking the currently donated arm64
> > runners (that have other jobs to run) and also we had two or three
> > custodians at a time preparing trees, things ran slower.
>=20
> Maybe, but I don't think so.

No need to "think" about it. You can look at the pipeline history and
see what was in queue for how long. And since I needed to be keeping an
eye on two of the 3 arm64 runners, I could see when custodians were
firing off tests. Aside from the number of pull requests I had waiting
that morning.

> > > > If you want to make mainline CI run faster you will need to catch up
> > > > with the missing coverage or argue that some things are redundant.
> > >
> > > Or perhaps I can actually just make it faster without dropping covera=
ge?
> >
> > I mean, I don't know how that's physically possible, outside of adding
> > many more expensive build hosts. We have two-three fast arm64 hosts and
> > that world builds between 30-45 minutes. That's the biggest time
> > bottleneck.
>=20
> Why did you join those builds up? It is better for throughput to have
> a few runners working in parallel.

Because I'm not optimizing for the single developer running CI case (or
the loads of fast runners case). If we had sufficient resources, yes,
the fastest possible way would be 4 "fast arm64" servers and 4 "fast
amd64" servers each running if not 25% of the world build, at least 4
easy to make and maintain groupings.

However, we don't have that many of either. And they also need to be
used for the biggest sandbox test suite jobs so that they run in about 5
minutes, not about 10 minutes. So in order to not entirely block other
custodians we do a single world build. Because make and buildman are
very good about otherwise fully loading the server. Running anything
else while that is going on will slow down the world build (and, the
other job too).

Aside, maintaining groupings is a pain. It was very bad with Travis, and
it's only moderately painful with Azure where at least the end goal is
10 pipelines for maximum concurrency. And with Azure everyone *can* get
their own "project" or whatever the right term is, and utilize 10
runners at once.


> > The next biggest is that unless sandbox tests are run on a fast host,
> > they take upwards of 10 minutes, rather than 5.
>=20
> Yes, they are just getting slower and slower.

Adding more tests takes more time. But the real question is which tests
take wall clock noticeable time, and why, and if we can do anything
about it. My gut feeling is that it's in the disk image related tests
and the user space verification of them.

> > But please, rebase your work to next and see what you can do. There is
> > likely some speed-ups possible if we allow for failures to take longer
> > to happen (and don't gate world builds on all of test.py stage
> > completing, just say sandbox). And if you do the work on source.denx.de
> > (as there is *NOTHING* stopping you from registering more runners to
> > your tree and using whatever tagging scheme you like) you might even see
> > more of the time variability due to load from other custodians.
>=20
> I can't edit the tags on the runners, nor can I adjust them to run
> untagged jobs, nor can I delete runners I don't want, so no, I believe
> I need access to do that.

You can do all of that with runners specific to u-boot-dm, and you can
disable project / group runners yourself too. So yes, you can.

> > > > > > > > > I also have another runner to add.
> > > > > > > >
> > > > > > > > I'll contact you off-list with the token.
> > > > > > > >
> > > > > > > > > > > From my side, I have found it helpful and refreshing =
to have a gitlab
> > > > > > > > > > > instance which I can control, e.g. it runs in half th=
e time and if my
> > > > > > > > > > > patches are completely blocked by Linaro, etc., I hav=
e an escape
> > > > > > > > > > > valve.
> > > > > > > > > >
> > > > > > > > > > Yes, and I have no idea what any of that has to do with=
 anything other
> > > > > > > > > > than leading to confusion about what tree is or is not =
mainline. Since
> > > > > > > > > > you own u-boot.org and ci.u-boot.org is your gitlab and
> > > > > > > > > > https://ci.u-boot.org/u-boot/u-boot/ is your personal t=
ree.
> > > > > > > > >
> > > > > > > > > For now I am working with my tree, so that I am not block=
ed by Linaro,
> > > > > > > > > etc. but as you have seen I can rebase series for your tr=
ee as needed.
> > > > > > > >
> > > > > > > > And you're not addressing my point about using the project =
domain for
> > > > > > > > your personal tree. That's my big huge "are you forking the=
 project or
> > > > > > > > what" problem.
> > > > > > >
> > > > > > > I'm just making sure that my work is not blocked or lost, as =
that has
> > > > > > > happened too many times in the past few years.
> > > > > >
> > > > > > Again, are you intending to fork the project? Putting your pers=
onal tree
> > > > > > in as "https://ci.u-boot.org/u-boot/u-boot.git" is not OK. I ke=
ep asking
> > > > > > you to stop it.
> > > > >
> > > > > No, I'm not intending to fork anything. But I need a tree that I =
can
> > > > > control and push things into.
> > > >
> > > > I don't know how you can call your personal tree being at
> > > > "https://ci.u-boot.org/u-boot/u-boot.git" and saying it's somewhere=
 you
> > > > control and can push to while not also saying it's a fork. If you w=
ant
> > > > to close down your gitlab and CNAME ci.u-boot.org to source.denx.de=
, you
> > > > can still push things to u-boot-dm. Or if that's too constrained of=
 a
> > > > namespace you can also get a contributors/sjg/ namespace. But what
> > > > you're doing today WILL lead to confusion.
> > >
> > > I believe I've answered this question before. It is simply that I
> > > cannot get certain patches (bloblist, EFI, devicetree) into your tree.
> > > There really isn't any other reason.
> >
> > Yes, that's still not an answer to my question.
> >
> > Or is the answer to my question "Yes, I'm trying to confuse people to
> > thinking my tree is mainline."
>=20
> No, it's simply that you are not taking some patches in your tree and
> complaining about the amount of patches.

That's misleading at best. I'm not taking the patches that other
custodians have repeatedly rejected and explained why they're rejecting
them.

> > > At the moment your CI seems to be flaky as well:
> > >
> > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/1038174
> >
> > [aside, I think you meant to link to the pipeline itself, which also
> > passed, but had some retries]
> >
> > Funny story. Ilias needed to tweak the fast arm64 hosts and also wanted
> > to explore "What if we have concurrency higher?" and ran in to the
> > problems you also ran in to with respect to git seeing an existing clone
> > in progress and bailing. Followed by the problem of multiple non-trivial
> > jobs running concurrently.
> >
> > All of which is why I keep trying to tell you that while "single" and
> > concurrent runners work fine for you on a single user instance it will
> > not scale.
>=20
> Yes, but I solved that with the patch I sent and it seems to be 100%
> reliable now.

Yes, you eventually solved it with 3 patches, which I asked you to
rebase and squash to two patches (because #3 just fixes that #2 wasn't
sufficient) and you declined.

--=20
Tom

--7vC7tuResYHEKFht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfHJlsACgkQFHw5/5Y0
tyybnAv+Lz1jTnq8O8d1X9tfIp1SNKPVmRewYtSC5K9OIFRH2JoGTXD/F8lOZy2R
FvtI0zgqjbiZhw6cYU6/dq7jzctlCCh2eh1do46DEu3lHVqBfwK4MIYo6pNKuYhf
VgVnwPhMCkvjRZJHdnGpOaf0qimY1zyGWFdCav4Cbi8Q6dLd6oQqKGlOQuiXQZEc
CmI29nsMru62fDpkbVcjEve4+CV69oIE7+Ma9QOb/hXHS9s1RreLeNnAMQDEB61F
XYl9i7MT95UMag4cT2f2Pph/1TbX71RaL0fxDdXIlIqrOglUZumomxbsU8yZhgnl
0DBtNAjE/zbPoF3jvQ+J9AxIHcP7W2YENT0DqcG4q49mLF2ljTcll6kvANiH8Oda
tK/nDqp41kcTP6Xk7lhONf6zafPt4e40CZLa3nzF+fmh2NVrMTdUbBwITnx1dosu
vja3Zr2U2Pvjdk+X1bACUye8b8VFnmjtQEDr5h+EHvPnAPpd+W+g4Jitd7VALjPB
DqRD+ltE
=5s7N
-----END PGP SIGNATURE-----

--7vC7tuResYHEKFht--
