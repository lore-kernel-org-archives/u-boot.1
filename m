Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92671C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 16:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 245A2807D9;
	Wed,  5 Mar 2025 17:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QbwX/KNH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B737380BAA; Wed,  5 Mar 2025 17:06:39 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D6C80017
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 17:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so4979276276.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 08:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741190795; x=1741795595; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CaJCtVRx/0oQX71UwpCd6CP6vMI8hy8/HDCyODYx9Ig=;
 b=QbwX/KNHmQsKmLf40cgvZAlLqvJ3VUChs173k7SWV9CpGo4SuoPj2s5JOZI8BecFW2
 8KP7WtArtXeOGgoXENXmd3zbLBK9Jv73rxfu7pxJWyvEDr3v4S26gSQ9Gj8MVXehVbfJ
 FoMgky3TpL6qMvc7xQO6JtpqRTwUJBfYNfKso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741190795; x=1741795595;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaJCtVRx/0oQX71UwpCd6CP6vMI8hy8/HDCyODYx9Ig=;
 b=uyBSQ762KvNX5UUTtjnF6XoLlboFISTWBk5B2oZm8hd8auB4gNfMFXDCOtG5tAIPfq
 rSNyQ5Lwil506G25PFgqaYOySZ3JDhnePcsEaCdK+jxc+cnvcyhFWKh0diLWobvQc50n
 OrzTyGhNZEvoyFAtIjfQmkB/qq0MfvfiU8l6QF6FxPT40OotdQO0LvrbnPSwf7JlliFu
 x9Z6/R5c+P+H7xlCz6yf6Fnec1QOYtr1rVqpriJ3Xv5NYmqjBsXNMnt72FBWC4FVe3+r
 kTFkphEpxER2dxIr60o/Vgf3yeLXVnJhZQi0tqMGnA44ubDFK0tsSKSHa6GbCz9vlJN5
 5Zig==
X-Gm-Message-State: AOJu0Yxq+HVbfwQlZ4zKrvf/tB2pxVWuOugZOoz0Nu5SNLGBZ6uQM0Qn
 FTnewrNK/sdech5g1K13UIMePxqPB4xbj/RF/M0vbuhGtsBYxxbTb0FJpr49b40=
X-Gm-Gg: ASbGnctAN8qXDRDC0M8xqYhfdGQYgQwg2cqSH5ZPhcUSUWpuzNFAoBbeFlq+/UltFY1
 qxgVKN4UIj32oxrhoTMYoOu55X28A1ZeqfBqVfnriS4np2QZJHvAPf7HTTVY3+Mo8e0bmtt4bBs
 2lEK1EKVg8TwiJQqspiYZ8zrYRWrLxGMtKrBYeDdLPriUk3SHJnIi3/g7CQJdHJTNjY0HYli+CZ
 IKqSe6cdBQOhfBiKRIwL3yQmlbFAOrmWdAQA+vh/Kw6Y9PmTD1/Fm5c5ugPDatKtE/vMZI0wzEJ
 H2HPo05sNInLqJh+NTjK6R269zvFEec4OZyvTUhJ1MA1yw==
X-Google-Smtp-Source: AGHT+IGpQUSDS3aSCi3Ia5br8UVzqZlG+Wy9geKSEqHWF7boi8rb+cnntMy0W/aERB0/XaQGoxbBxg==
X-Received: by 2002:a05:6902:cca:b0:e5d:ddd2:8acf with SMTP id
 3f1490d57ef6-e611e30699dmr5208922276.38.1741190794926; 
 Wed, 05 Mar 2025 08:06:34 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3a33423sm4467875276.19.2025.03.05.08.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 08:06:34 -0800 (PST)
Date: Wed, 5 Mar 2025 10:06:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250305160631.GS2640854@bill-the-cat>
References: <20250222000819.GX1233568@bill-the-cat>
 <CAFLszThLjxyMPty=tvrE9nQMNOtcF1H-njBb0Tep_ccXee3waw@mail.gmail.com>
 <20250222213748.GB1233568@bill-the-cat>
 <CAFLszTj31qtx5TmOVLJAfhpzWHKTc9kcp22JTgJBe2bePSU60A@mail.gmail.com>
 <20250224231455.GI1233568@bill-the-cat>
 <CAFLszTiP+wPijf0QbTL0i9Ywk_0tWFwYP-1S1Lp+mFeqN=8zKg@mail.gmail.com>
 <20250227170352.GZ2640854@bill-the-cat>
 <CAFLszTgDms-RC+Qg=FLxtW253jh22eUb1Y-5OyB2U42EygdZWw@mail.gmail.com>
 <20250304161218.GA2640854@bill-the-cat>
 <CAFLszTj1hc7esvd_R3oVEqOpSBNFcRga0wmR3hnTsFELXi+m1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yhF3X8bh1btr4SeY"
Content-Disposition: inline
In-Reply-To: <CAFLszTj1hc7esvd_R3oVEqOpSBNFcRga0wmR3hnTsFELXi+m1g@mail.gmail.com>
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


--yhF3X8bh1btr4SeY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 07:18:40AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 4 Mar 2025 at 09:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Mar 04, 2025 at 08:35:56AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 27 Feb 2025 at 10:03, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Feb 27, 2025 at 09:26:10AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 24 Feb 2025 at 16:14, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Feb 22, 2025 at 05:24:05PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Sat, 22 Feb 2025 at 14:37, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Sat, Feb 22, 2025 at 10:23:59AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 21 Feb 2025 at 17:08, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Feb 21, 2025 at 04:42:09PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 17 Feb 2025 at 07:14, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, Feb 17, 2025 at 06:14:06AM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Sun, 16 Feb 2025 at 14:52, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 12:39:34PM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 07:10:12AM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 11:12, Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 10:21:16AM -070=
0, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Sat, 15 Feb 2025 at 07:41, Tom Rin=
i <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 04:59:40AM =
-0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Mon, 10 Feb 2025 at 09:25, Tom=
 Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Thu, Feb 06, 2025 at 03:38:5=
5PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > This is a global default, so =
put it under 'default' like the tags.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > Signed-off-by: Simon Glass <s=
jg@chromium.org>
> > > > > > > > > > > > > > > > > > > > > > > Suggested-by: Tom Rini <trini=
@konsulko.com>
> > > > > > > > > > > > > > > > > > > > > > > Reviewed-by: Tom Rini <trini@=
konsulko.com>
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Please make v4 include the way =
you redid the second patch and be on top
> > > > > > > > > > > > > > > > > > > > > > of mainline, thanks.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > That's enough versions for me, so=
 I'll let you do that, if you'd like.
> > > > > > > > > > > > > > > > > > > > > It probably doesn't affect your t=
ree as not as much is done in
> > > > > > > > > > > > > > > > > > > > > parallel.
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > I am disappointed.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > I'm sorry to disappoint you.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > The background is that I looked at th=
e difference between our trees
> > > > > > > > > > > > > > > > > > > and the gitlab files are quite differ=
ent. My CI runs take about 35
> > > > > > > > > > > > > > > > > > > mins and it seems that yours is aroun=
d 90 mins. I would like to reduce
> > > > > > > > > > > > > > > > > > > / remove the delta (for time and patc=
h diff), but I'm not sure how.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > My goal is to get CI runs to below 20=
 minutes, best case.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I'm sure CI could be quicker still with=
 a number of faster runners. But
> > > > > > > > > > > > > > > > > > if you can't be bothered to make change=
s against mainline, what is the
> > > > > > > > > > > > > > > > > > point?
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > If you recall, I was working with your tr=
ee and had various ideas to
> > > > > > > > > > > > > > > > > speed things up, but you didn't like it. =
So I've had to do it in my
> > > > > > > > > > > > > > > > > tree. This is not about more runners (alt=
hough I might have another
> > > > > > > > > > > > > > > > > one soon). It is about running jobs in pa=
rallel.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > And I wasn't sure more runners in parallel =
would help (as it would slow
> > > > > > > > > > > > > > > > down the fast runner which is what keeps th=
e long jobs from being even
> > > > > > > > > > > > > > > > longer) as much as adding more regular runn=
ers would (which we've done)
> > > > > > > > > > > > > > > > and noted that in the end it's a configurat=
ion on the runner side so to
> > > > > > > > > > > > > > > > go ahead. And I reviewed and ack'd the patc=
hes here which exposed the
> > > > > > > > > > > > > > > > issues your path revealed. I just can't app=
ly them because they need to
> > > > > > > > > > > > > > > > be rebased (and squashed).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > You have already added tags for things, but (=
IIUC) they are around the
> > > > > > > > > > > > > > > other way from what I have added.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I have a tag called 'single' which means that=
 the machine is only
> > > > > > > > > > > > > > > allowed to one of those jobs. The world-build=
 jobs are marked with
> > > > > > > > > > > > > > > 'single'.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > For other jobs, I allow the runners to pick u=
p some in parallel
> > > > > > > > > > > > > > > depending on their performance (for moa and t=
ui that is 10).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > So at most, there is a 'world build' and 10 t=
est.py jobs running on
> > > > > > > > > > > > > > > the same machine. It seems to work fine in pr=
actice, although I would
> > > > > > > > > > > > > > > rather be able to make these two types of job=
s mutually exclusive, so
> > > > > > > > > > > > > > > that a runner is either running 10 parallel j=
obs or 1 'single' job,
> > > > > > > > > > > > > > > but not both. I'm not sure how to do that.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So unless I'm missing something, in both cases =
the bottleneck is that
> > > > > > > > > > > > > > for world build jobs you don't want anything el=
se going on with the
> > > > > > > > > > > > > > underlying build host. You could register 10 "a=
ll" runners and 1 "fast
> > > > > > > > > > > > > > amd64" runner (and something similar but smalle=
r for alexandra). If you
> > > > > > > > > > > > > > update the registrations on source.denx.de can =
you then shut down your
> > > > > > > > > > > > > > gitlab instance?
> > > > > > > > > > > > >
> > > > > > > > > > > > > I've put a tag of 'single' on things that should =
run on the single-job
> > > > > > > > > > > > > runner. Everything else can run concurrently, e.g=
=2E up to 10 jobs. So I
> > > > > > > > > > > > > have two runners on the same host. E.g. tui-singl=
e has 'limit =3D 1',
> > > > > > > > > > > > > but 'tui' has no limit and is just governed by th=
e 'concurrent =3D 10'
> > > > > > > > > > > > > at the top of the file.
> > > > > > > > > > > >
> > > > > > > > > > > > Yes. And you could move those runners to the mainli=
ne gitlab. There is
> > > > > > > > > > > > no "single" tag, that would be the "all" tag. And "=
tui-single" would be
> > > > > > > > > > > > "fast amd64".
> > > > > > > > > > >
> > > > > > > > > > > They are still attached to the Denx gitlab. Nothing h=
as changed on my
> > > > > > > > > > > side. I'm not sure that your new tags are working tho=
ugh. I have a
> > > > > > > > > > > feeling something broke along the way when you made a=
ll your tag
> > > > > > > > > > > changes. One of my servers makes a bit of noise and I=
 haven't heard it
> > > > > > > > > > > in quite a while.
> > > > > > > > > >
> > > > > > > > > > There's a few of your runners that are "stale" and have=
n't contacted
> > > > > > > > > > gitlab in a long time. I'll double check the tags tho.
> > > > > > > > > >
> > > > > > > > > > > If Denx would like to give me access to their gitlab =
instances, I'd be
> > > > > > > > > > > happy to play around and figure out how to get it goi=
ng as fast as my
> > > > > > > > > > > tree does, and send a patch.
> > > > > > > > > >
> > > > > > > > > > I'm not sure what you mean by that? The instance itself?
> > > > > > > > >
> > > > > > > > > Yes. I can fiddle with tags on my runners and try to figu=
re it out.
> > > > > > > >
> > > > > > > > I'm not sure what you're getting at here. If you mean "tags=
" in
> > > > > > > > /etc/gitlab-runner/config.toml those aren't relevant here I=
 believe.
> > > > > > >
> > > > > > > No, I mean the tags in CI. If I fiddle with them I can probab=
ly come
> > > > > > > up with a way to run your CI much faster. Mine is about 35min=
s.
> > > > > >
> > > > > > I'm not so sure about that. Yours runs faster because it tests =
less. Now
> > > > > > that we've got some of your other fast runners showing up again=
, this is
> > > > > > more instructive of current times I think:
> > > > > > https://source.denx.de/u-boot/u-boot/-/pipelines/24802
> > > > >
> > > > > But not this? :
> > > >
> > > > You forgot a link. But presumably to some run yesterday which took
> > > > longer. And because Ilias was tweaking the currently donated arm64
> > > > runners (that have other jobs to run) and also we had two or three
> > > > custodians at a time preparing trees, things ran slower.
> > >
> > > Maybe, but I don't think so.
> >
> > No need to "think" about it. You can look at the pipeline history and
> > see what was in queue for how long. And since I needed to be keeping an
> > eye on two of the 3 arm64 runners, I could see when custodians were
> > firing off tests. Aside from the number of pull requests I had waiting
> > that morning.
>=20
> Your runs are reliably around an hour but mine are reliably just over
> 30 minutes. I only have three runners.
>=20
> https://source.denx.de/u-boot/u-boot/-/pipelines
> https://sjg.u-boot.org/u-boot/u-boot/-/pipelines
>=20
> I know you have added a duplicate build on arm64, but I can still
> speed it up significantly if you'll allow me.

I've never been stopping you.

> > > > > > If you want to make mainline CI run faster you will need to cat=
ch up
> > > > > > with the missing coverage or argue that some things are redunda=
nt.
> > > > >
> > > > > Or perhaps I can actually just make it faster without dropping co=
verage?
> > > >
> > > > I mean, I don't know how that's physically possible, outside of add=
ing
> > > > many more expensive build hosts. We have two-three fast arm64 hosts=
 and
> > > > that world builds between 30-45 minutes. That's the biggest time
> > > > bottleneck.
> > >
> > > Why did you join those builds up? It is better for throughput to have
> > > a few runners working in parallel.
> >
> > Because I'm not optimizing for the single developer running CI case (or
> > the loads of fast runners case). If we had sufficient resources, yes,
> > the fastest possible way would be 4 "fast arm64" servers and 4 "fast
> > amd64" servers each running if not 25% of the world build, at least 4
> > easy to make and maintain groupings.
> >
> > However, we don't have that many of either. And they also need to be
> > used for the biggest sandbox test suite jobs so that they run in about 5
> > minutes, not about 10 minutes. So in order to not entirely block other
> > custodians we do a single world build. Because make and buildman are
> > very good about otherwise fully loading the server. Running anything
> > else while that is going on will slow down the world build (and, the
> > other job too).
>=20
> They're OK (on a fast machine) so long as the 'other' load is not too muc=
h.

Things are OK until they aren't, yes. But just make sure you try out
some of the worst case (ie more than one pipeline at a time running).

> > Aside, maintaining groupings is a pain. It was very bad with Travis, and
> > it's only moderately painful with Azure where at least the end goal is
> > 10 pipelines for maximum concurrency. And with Azure everyone *can* get
> > their own "project" or whatever the right term is, and utilize 10
> > runners at once.
>=20
> Yes, but we can update buildman to handle grouping automatically, as I
> suggested once.

I'm not sure we want make buildman act like distcc as well here. If we
wanted to split the world in two, making it easy to say "arm not armv8"
and "not (arm not armv8)" would be good enough.

> > > > The next biggest is that unless sandbox tests are run on a fast hos=
t,
> > > > they take upwards of 10 minutes, rather than 5.
> > >
> > > Yes, they are just getting slower and slower.
> >
> > Adding more tests takes more time. But the real question is which tests
> > take wall clock noticeable time, and why, and if we can do anything
> > about it. My gut feeling is that it's in the disk image related tests
> > and the user space verification of them.
> >
> > > > But please, rebase your work to next and see what you can do. There=
 is
> > > > likely some speed-ups possible if we allow for failures to take lon=
ger
> > > > to happen (and don't gate world builds on all of test.py stage
> > > > completing, just say sandbox). And if you do the work on source.den=
x.de
> > > > (as there is *NOTHING* stopping you from registering more runners to
> > > > your tree and using whatever tagging scheme you like) you might eve=
n see
> > > > more of the time variability due to load from other custodians.
> > >
> > > I can't edit the tags on the runners, nor can I adjust them to run
> > > untagged jobs, nor can I delete runners I don't want, so no, I believe
> > > I need access to do that.
> >
> > You can do all of that with runners specific to u-boot-dm, and you can
> > disable project / group runners yourself too. So yes, you can.
>=20
> Nope, sorry, I wasn't able to do any of this with the Denx tree as I
> can't adjust tags and can't delete and recreate runners.

You don't have
https://source.denx.de/u-boot/custodians/u-boot-dm/-/settings/ci_cd#js-runn=
ers-settings
visible to you?

> > > > > > > > > > > I also have another runner to add.
> > > > > > > > > >
> > > > > > > > > > I'll contact you off-list with the token.
> > > > > > > > > >
> > > > > > > > > > > > > From my side, I have found it helpful and refresh=
ing to have a gitlab
> > > > > > > > > > > > > instance which I can control, e.g. it runs in hal=
f the time and if my
> > > > > > > > > > > > > patches are completely blocked by Linaro, etc., I=
 have an escape
> > > > > > > > > > > > > valve.
> > > > > > > > > > > >
> > > > > > > > > > > > Yes, and I have no idea what any of that has to do =
with anything other
> > > > > > > > > > > > than leading to confusion about what tree is or is =
not mainline. Since
> > > > > > > > > > > > you own u-boot.org and ci.u-boot.org is your gitlab=
 and
> > > > > > > > > > > > https://ci.u-boot.org/u-boot/u-boot/ is your person=
al tree.
> > > > > > > > > > >
> > > > > > > > > > > For now I am working with my tree, so that I am not b=
locked by Linaro,
> > > > > > > > > > > etc. but as you have seen I can rebase series for you=
r tree as needed.
> > > > > > > > > >
> > > > > > > > > > And you're not addressing my point about using the proj=
ect domain for
> > > > > > > > > > your personal tree. That's my big huge "are you forking=
 the project or
> > > > > > > > > > what" problem.
> > > > > > > > >
> > > > > > > > > I'm just making sure that my work is not blocked or lost,=
 as that has
> > > > > > > > > happened too many times in the past few years.
> > > > > > > >
> > > > > > > > Again, are you intending to fork the project? Putting your =
personal tree
> > > > > > > > in as "https://ci.u-boot.org/u-boot/u-boot.git" is not OK. =
I keep asking
> > > > > > > > you to stop it.
> > > > > > >
> > > > > > > No, I'm not intending to fork anything. But I need a tree tha=
t I can
> > > > > > > control and push things into.
> > > > > >
> > > > > > I don't know how you can call your personal tree being at
> > > > > > "https://ci.u-boot.org/u-boot/u-boot.git" and saying it's somew=
here you
> > > > > > control and can push to while not also saying it's a fork. If y=
ou want
> > > > > > to close down your gitlab and CNAME ci.u-boot.org to source.den=
x.de, you
> > > > > > can still push things to u-boot-dm. Or if that's too constraine=
d of a
> > > > > > namespace you can also get a contributors/sjg/ namespace. But w=
hat
> > > > > > you're doing today WILL lead to confusion.
> > > > >
> > > > > I believe I've answered this question before. It is simply that I
> > > > > cannot get certain patches (bloblist, EFI, devicetree) into your =
tree.
> > > > > There really isn't any other reason.
> > > >
> > > > Yes, that's still not an answer to my question.
> > > >
> > > > Or is the answer to my question "Yes, I'm trying to confuse people =
to
> > > > thinking my tree is mainline."
> > >
> > > No, it's simply that you are not taking some patches in your tree and
> > > complaining about the amount of patches.
> >
> > That's misleading at best. I'm not taking the patches that other
> > custodians have repeatedly rejected and explained why they're rejecting
> > them.
>=20
> Yes and this has affected my ability to move things forward so much
> that I've had to set up my own tree. It has been working very well, to
> have a relief valve.

It's been working pretty terrible for the rest of the project as you
build on top of things that have been rejected and you're collecting in
your own personal downstream fork. Igor's email last night would be the
latest example of "I wanted to look at this but where is it?"

> > > > > At the moment your CI seems to be flaky as well:
> > > > >
> > > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/1038174
> > > >
> > > > [aside, I think you meant to link to the pipeline itself, which also
> > > > passed, but had some retries]
> > > >
> > > > Funny story. Ilias needed to tweak the fast arm64 hosts and also wa=
nted
> > > > to explore "What if we have concurrency higher?" and ran in to the
> > > > problems you also ran in to with respect to git seeing an existing =
clone
> > > > in progress and bailing. Followed by the problem of multiple non-tr=
ivial
> > > > jobs running concurrently.
> > > >
> > > > All of which is why I keep trying to tell you that while "single" a=
nd
> > > > concurrent runners work fine for you on a single user instance it w=
ill
> > > > not scale.
> > >
> > > Yes, but I solved that with the patch I sent and it seems to be 100%
> > > reliable now.
> >
> > Yes, you eventually solved it with 3 patches, which I asked you to
> > rebase and squash to two patches (because #3 just fixes that #2 wasn't
> > sufficient) and you declined.
>=20
> In general, why not just be more open to my ideas, even just try it
> for a year? Given the tools I'm confident I can speed up your CI as
> well.

I've never not been open to applying patches to mainline that are
against mainline. I am not going to rebase your work for you however.
And I think it's terrible for the project as a whole when you post
changes against your tree and people expect to be able to review them
and then can't because it's against your downstream fork.

--=20
Tom

--yhF3X8bh1btr4SeY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfIdn8ACgkQFHw5/5Y0
tyzutgv7BfBAfnijJDybFqj4F/SzqSMByz54vg/NZCLZC1FZWi2LKAkAvNx0slMO
49tsWrHHc6OGnsCFcAm/J4+QEo4Bjv4YonbHDCewAOy26T84rh0MsPiQp8z3xMRp
05kIPItOFLNhJfRIcxeNc8JZehVEE6tyUSfb+c3nP13ixBjiee1Qbsio3/2EGn8/
iXu01QvOdfZKjt0P97ACI6bQtGCKMdL2k9AHcP2j6NO3mr0iW/1A1cLhfBgQy5Wg
2/qRvVGzRa4rCqxZaRiQd06po306jfOypelG69UJhM5eqwoQb4pemVOIfbzh1QBJ
ofnloh5SvsLvccCQOfQCAblfZ/H3P364wtnUzHMz3ufsi005GKAGgweKiB1rZCYZ
g9gDZN//mDee7CZDB2S+SO7GHThk01YgO6x/ZxWN0C3C+2sYw9Xx7gQN95q+FWaj
PEpFQ0eqIV/jwarrSed47bsynHV9H9VX8Bt1JTF5/d6x4s1u7GVrAZ85o9vOF9kb
sw86B8Uq
=0ndO
-----END PGP SIGNATURE-----

--yhF3X8bh1btr4SeY--
