Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74228C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED98580F56;
	Tue, 25 Feb 2025 00:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A0XoEkOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7945480F91; Tue, 25 Feb 2025 00:15:03 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D4B980EC0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-220bff984a0so105330485ad.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740438899; x=1741043699; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AAsAnaZqOjJq3WL9CNbpg23LaK7vk/hmWH/mva3dENc=;
 b=A0XoEkOOLp/KHvp09iwKG/ypnzvW8xaWx6l81knwgOqLLHIt5WSCJGLhhePloOGHat
 pZLb8sP+Qh42Qzvv1HSzJ8rrTd1dkD6t0moQEBtyy6ONeaXMr4kIqeLZBL7OdKFdAc5E
 HvPv0W08n8btjqM85SFZaxXjLibHD6hYUbc7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438899; x=1741043699;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAsAnaZqOjJq3WL9CNbpg23LaK7vk/hmWH/mva3dENc=;
 b=Fj3THJdaCoRfFdX5N/HNL8obSDzyCa+64X8UIvzIgVmtXtySgVOBGFFzcgmHexIHHt
 1PcZoEbLs8X2C1eCrIa+37TV+sd3TqGL6NrpOz7TB2Rlxi9HaswWeX+mGX3xi6Yh/41Z
 +1VqNltHV+8UTClLd2d5tXtxt82SZ4FNFtLph8COeWKUdn3vaJnpu4eHYYLOiVoa+tmw
 vkOxsvpDJTMUlKPJG4jMti7Czk3RgztEZz1ie1TE4NTEQYAKboIwP0jJtJHhs8nCQ30Z
 PAXSdLdmFUTa7AkdeSMEJlLsWdcsZ3OdMM26ndfKunqLvwPu/X9ZPtviQH6gKXI03RSB
 IW1w==
X-Gm-Message-State: AOJu0YyHDNHmv8spSsuNAOM5Opush0aIpeoc7T3aAxpWqg/2Egu3LRw0
 UjVqgDprHkFDx9qI7AvlEjinwCEbLApekBNwTtBNtR8Nsn8lbebyoF1RFKLZ+SA=
X-Gm-Gg: ASbGnctQTkQP5zHdtL4J1Cma7x3b+M1wgWp5SCeurEGceCERHu63tGfA1MElT2+m5Oq
 CDhCv6GxzscqVx51UmvHPN7TkE99lqA6oC+BZYOE6RBeu9OzbCV/BNaGscUhWYnsZW4VIfd9FIH
 bDdq3wHLCgXT1/FJgouRYa9dwF6tkTyS4UbBCGh2VAx5GxxRfVsTu7LODRwOcMj3/nzCq4fRlDW
 v1Cdng17QVqFSmY6Lp7eYxsAGMQDgJVGh3u+a8PW4pBHHQZCUy66GPJYL8OihcWJxW5p7+LHHpL
 plqiOAsLFbkhnjh6WOXmueO+
X-Google-Smtp-Source: AGHT+IH7eHtYQhUjuGUpEp5Cc4op6rdgA8MuKM/LMetyaQOSGEryEe5n8pFk1PHxX/JSFPNwpRysjg==
X-Received: by 2002:a05:6a21:10e:b0:1ee:d860:61eb with SMTP id
 adf61e73a8af0-1f0fc89a19dmr1534808637.39.1740438898888; 
 Mon, 24 Feb 2025 15:14:58 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a7f9af3sm189603b3a.110.2025.02.24.15.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:14:58 -0800 (PST)
Date: Mon, 24 Feb 2025 17:14:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250224231455.GI1233568@bill-the-cat>
References: <20250216160744.GA1233568@bill-the-cat>
 <CAFLszTiihyuqFBcdacu+2wfd3ivDzjf4nVqfU0BgKUc0u1s6=Q@mail.gmail.com>
 <20250216215230.GE1233568@bill-the-cat>
 <CAFLszTiydBJ8BseNHNJO+tf21QwPSJ-Od1Jnp6QWUTsPOmgFdg@mail.gmail.com>
 <20250217141409.GJ1233568@bill-the-cat>
 <CAFLszTij+suCqQ+c0bmTEsHEu6+xUWWCMEG-gJ5DYbjhv0oJGg@mail.gmail.com>
 <20250222000819.GX1233568@bill-the-cat>
 <CAFLszThLjxyMPty=tvrE9nQMNOtcF1H-njBb0Tep_ccXee3waw@mail.gmail.com>
 <20250222213748.GB1233568@bill-the-cat>
 <CAFLszTj31qtx5TmOVLJAfhpzWHKTc9kcp22JTgJBe2bePSU60A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ol6AcOh+eIlKlVdo"
Content-Disposition: inline
In-Reply-To: <CAFLszTj31qtx5TmOVLJAfhpzWHKTc9kcp22JTgJBe2bePSU60A@mail.gmail.com>
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


--ol6AcOh+eIlKlVdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 05:24:05PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 22 Feb 2025 at 14:37, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 22, 2025 at 10:23:59AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 21 Feb 2025 at 17:08, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Feb 21, 2025 at 04:42:09PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 17 Feb 2025 at 07:14, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 17, 2025 at 06:14:06AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Sun, 16 Feb 2025 at 14:52, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Sun, Feb 16, 2025 at 12:39:34PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > This is a global default, so put it under=
 'default' like the tags.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.=
org>
> > > > > > > > > > > > > > > > > Suggested-by: Tom Rini <trini@konsulko.co=
m>
> > > > > > > > > > > > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Please make v4 include the way you redid th=
e second patch and be on top
> > > > > > > > > > > > > > > > of mainline, thanks.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > That's enough versions for me, so I'll let yo=
u do that, if you'd like.
> > > > > > > > > > > > > > > It probably doesn't affect your tree as not a=
s much is done in
> > > > > > > > > > > > > > > parallel.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I am disappointed.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm sorry to disappoint you.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The background is that I looked at the difference=
 between our trees
> > > > > > > > > > > > > and the gitlab files are quite different. My CI r=
uns take about 35
> > > > > > > > > > > > > mins and it seems that yours is around 90 mins. I=
 would like to reduce
> > > > > > > > > > > > > / remove the delta (for time and patch diff), but=
 I'm not sure how.
> > > > > > > > > > > > >
> > > > > > > > > > > > > My goal is to get CI runs to below 20 minutes, be=
st case.
> > > > > > > > > > > >
> > > > > > > > > > > > I'm sure CI could be quicker still with a number of=
 faster runners. But
> > > > > > > > > > > > if you can't be bothered to make changes against ma=
inline, what is the
> > > > > > > > > > > > point?
> > > > > > > > > > >
> > > > > > > > > > > If you recall, I was working with your tree and had v=
arious ideas to
> > > > > > > > > > > speed things up, but you didn't like it. So I've had =
to do it in my
> > > > > > > > > > > tree. This is not about more runners (although I migh=
t have another
> > > > > > > > > > > one soon). It is about running jobs in parallel.
> > > > > > > > > >
> > > > > > > > > > And I wasn't sure more runners in parallel would help (=
as it would slow
> > > > > > > > > > down the fast runner which is what keeps the long jobs =
=66rom being even
> > > > > > > > > > longer) as much as adding more regular runners would (w=
hich we've done)
> > > > > > > > > > and noted that in the end it's a configuration on the r=
unner side so to
> > > > > > > > > > go ahead. And I reviewed and ack'd the patches here whi=
ch exposed the
> > > > > > > > > > issues your path revealed. I just can't apply them beca=
use they need to
> > > > > > > > > > be rebased (and squashed).
> > > > > > > > >
> > > > > > > > > You have already added tags for things, but (IIUC) they a=
re around the
> > > > > > > > > other way from what I have added.
> > > > > > > > >
> > > > > > > > > I have a tag called 'single' which means that the machine=
 is only
> > > > > > > > > allowed to one of those jobs. The world-build jobs are ma=
rked with
> > > > > > > > > 'single'.
> > > > > > > > >
> > > > > > > > > For other jobs, I allow the runners to pick up some in pa=
rallel
> > > > > > > > > depending on their performance (for moa and tui that is 1=
0).
> > > > > > > > >
> > > > > > > > > So at most, there is a 'world build' and 10 test.py jobs =
running on
> > > > > > > > > the same machine. It seems to work fine in practice, alth=
ough I would
> > > > > > > > > rather be able to make these two types of jobs mutually e=
xclusive, so
> > > > > > > > > that a runner is either running 10 parallel jobs or 1 'si=
ngle' job,
> > > > > > > > > but not both. I'm not sure how to do that.
> > > > > > > >
> > > > > > > > So unless I'm missing something, in both cases the bottlene=
ck is that
> > > > > > > > for world build jobs you don't want anything else going on =
with the
> > > > > > > > underlying build host. You could register 10 "all" runners =
and 1 "fast
> > > > > > > > amd64" runner (and something similar but smaller for alexan=
dra). If you
> > > > > > > > update the registrations on source.denx.de can you then shu=
t down your
> > > > > > > > gitlab instance?
> > > > > > >
> > > > > > > I've put a tag of 'single' on things that should run on the s=
ingle-job
> > > > > > > runner. Everything else can run concurrently, e.g. up to 10 j=
obs. So I
> > > > > > > have two runners on the same host. E.g. tui-single has 'limit=
 =3D 1',
> > > > > > > but 'tui' has no limit and is just governed by the 'concurren=
t =3D 10'
> > > > > > > at the top of the file.
> > > > > >
> > > > > > Yes. And you could move those runners to the mainline gitlab. T=
here is
> > > > > > no "single" tag, that would be the "all" tag. And "tui-single" =
would be
> > > > > > "fast amd64".
> > > > >
> > > > > They are still attached to the Denx gitlab. Nothing has changed o=
n my
> > > > > side. I'm not sure that your new tags are working though. I have a
> > > > > feeling something broke along the way when you made all your tag
> > > > > changes. One of my servers makes a bit of noise and I haven't hea=
rd it
> > > > > in quite a while.
> > > >
> > > > There's a few of your runners that are "stale" and haven't contacted
> > > > gitlab in a long time. I'll double check the tags tho.
> > > >
> > > > > If Denx would like to give me access to their gitlab instances, I=
'd be
> > > > > happy to play around and figure out how to get it going as fast a=
s my
> > > > > tree does, and send a patch.
> > > >
> > > > I'm not sure what you mean by that? The instance itself?
> > >
> > > Yes. I can fiddle with tags on my runners and try to figure it out.
> >
> > I'm not sure what you're getting at here. If you mean "tags" in
> > /etc/gitlab-runner/config.toml those aren't relevant here I believe.
>=20
> No, I mean the tags in CI. If I fiddle with them I can probably come
> up with a way to run your CI much faster. Mine is about 35mins.

I'm not so sure about that. Yours runs faster because it tests less. Now
that we've got some of your other fast runners showing up again, this is
more instructive of current times I think:
https://source.denx.de/u-boot/u-boot/-/pipelines/24802

If you want to make mainline CI run faster you will need to catch up
with the missing coverage or argue that some things are redundant.

> > > > > I also have another runner to add.
> > > >
> > > > I'll contact you off-list with the token.
> > > >
> > > > > > > From my side, I have found it helpful and refreshing to have =
a gitlab
> > > > > > > instance which I can control, e.g. it runs in half the time a=
nd if my
> > > > > > > patches are completely blocked by Linaro, etc., I have an esc=
ape
> > > > > > > valve.
> > > > > >
> > > > > > Yes, and I have no idea what any of that has to do with anythin=
g other
> > > > > > than leading to confusion about what tree is or is not mainline=
=2E Since
> > > > > > you own u-boot.org and ci.u-boot.org is your gitlab and
> > > > > > https://ci.u-boot.org/u-boot/u-boot/ is your personal tree.
> > > > >
> > > > > For now I am working with my tree, so that I am not blocked by Li=
naro,
> > > > > etc. but as you have seen I can rebase series for your tree as ne=
eded.
> > > >
> > > > And you're not addressing my point about using the project domain f=
or
> > > > your personal tree. That's my big huge "are you forking the project=
 or
> > > > what" problem.
> > >
> > > I'm just making sure that my work is not blocked or lost, as that has
> > > happened too many times in the past few years.
> >
> > Again, are you intending to fork the project? Putting your personal tree
> > in as "https://ci.u-boot.org/u-boot/u-boot.git" is not OK. I keep asking
> > you to stop it.
>=20
> No, I'm not intending to fork anything. But I need a tree that I can
> control and push things into.

I don't know how you can call your personal tree being at
"https://ci.u-boot.org/u-boot/u-boot.git" and saying it's somewhere you
control and can push to while not also saying it's a fork. If you want
to close down your gitlab and CNAME ci.u-boot.org to source.denx.de, you
can still push things to u-boot-dm. Or if that's too constrained of a
namespace you can also get a contributors/sjg/ namespace. But what
you're doing today WILL lead to confusion.

> > > BTW weka is too slow so I took it off.
> >
> > I'll remove it.
> >
> > > tui is running but seems to be renamed 'tui-redux' now. I don't see it
> > > getting jobs though.
> >
> > It's been getting jobs. Is it something sufficiently fast that it should
> > be doing big jobs?
>=20
> Yes, tui is the same as moa, pretty fast.

Thanks, I've added the "fast amd64" tag then so it'll get the long
running jobs too.

--=20
Tom

--ol6AcOh+eIlKlVdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme8/WgACgkQFHw5/5Y0
tyxnAwv/bVkdFYTXfY+V8QnOF4GWeJh1j50DoL23cCNnIq3MU2Ctu40HR1dpEjNh
3/5BJdjqjtPEzvcEs7uyCePSAg1M/Ahl79bKJNyrbWC1lN2RG7Pb0OAOgVHbSR4Z
uIzZiaM36D10/vUmunC1R7hE7mHazHcsBmIA4bPwwYHkfJ5xBiq7oG1UWC9R9PYg
VuCXwyEavqW+sGbKwMM8lmsEdvUob2GiRLvVMexy1+/MsAec/oFMlKvJj0xTw43G
Ov0xdTSCSmWVYwuahrXluicO2pzoYAt5PH/asR0QANGTLK8Mxd7zQUBdpU6cP7Zb
REhO1A6SrPzKgCiWm2kRLKhY+an5gwaVYMv0FW7dBlPO9wTiNVD8oXhNN32ItDfU
sZZOS5MP/R8tHEiZYOLxx4FOKsBmmPal2u0mxHVaNZ5HyDjRfEBIZHP8nOUJ9/jD
Gp1F/Cg9sbQcC66X9LPVI3bezhtjOjUlH0ZtBD9P5Pf+32QTg17tLv6h1EhK56r6
/enKdAof
=Jwzm
-----END PGP SIGNATURE-----

--ol6AcOh+eIlKlVdo--
