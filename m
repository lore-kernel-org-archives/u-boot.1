Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A30C282DE
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 16:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D2180E94;
	Wed,  5 Mar 2025 17:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MUGoIfxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9BC480ECC; Wed,  5 Mar 2025 17:22:44 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F6D800C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 17:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e62d132a6a7so489391276.3
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 08:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741191760; x=1741796560; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z/kibKEUP5gtN3qGs4ZTkdQzM2AN1XhblvuJqG6zURs=;
 b=MUGoIfxNUsS8z5ubM2ZtGVwu1XYegEdhHq5UrPpukMciTkRg6hq0p2g1b2iprQOjXL
 XZ8TZnXbebr2B6LJ2xZHUAj2nk9XxYEd6g6I6Ew2h7M7K8F3dnkmshYL2KNp6z8DzLDG
 kiRSLhy5Q6fMsPewwFRpMFeISEIqCUJoML8EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741191760; x=1741796560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/kibKEUP5gtN3qGs4ZTkdQzM2AN1XhblvuJqG6zURs=;
 b=sy/LfTu9MLaV8VTrs3/j2Im+xjMIzOYoSmfpyGdxZUa1GG0SijXBg4W1gT+rEYaEDa
 j8v8FawXZxnPqJAa5vKr+qWi9xBy8h3eekP1ABgJGkvwQe3KaYr53OzWMVLz+ph4mKGG
 JreUP3HnvkZiFiiTBpuSvZHOn6ESeQBTV+GP0EYdYkeV91P6wTMkoDM6pH0TdKZL+vrN
 moJsTrjFitceeq8GAoHHP4nE8lLj52TK8oFDxSeBVFRTVNSO9kW+rQh76acj7BnL731u
 Xn7wpw9Pc/GQXZUYnkY9g4CuJXqv1J5SHR/C/rVaBSHbIq/INOrvDMOJUIv/0M0gPBN0
 dkKA==
X-Gm-Message-State: AOJu0YwDUPQpP1v9AQ03U8L2aBg0+MN544D8M33NKe5PIFvomkKJMTvR
 tPUYTZsMwehTnhvI+IZBX5lbq2vjI5MKarinY6EHsvqnlDzROQJuhsFs43I7fms=
X-Gm-Gg: ASbGncvfjA7SOtTiLFRW6wNv47V+VHWHzRU86P5k1rtzjuvtBpfrMGDbfaLVOptONi8
 hHHJ+xTYwTkzw3TAyUhK41Da3nhHAJuASKTDw33mbPQrKp9ZcUcHGU3OzNR4ILfWh2xEhdL211a
 hD8Wx/zZ9kbefq61Z8CUZx3Ykwp5cXwd8vTqko+VR/Bq94zXQMc2CvTtzBD9YAYvgct6DhZ8vR9
 6ILcQongrrRhKcPfZ6QUVi+PJHMCH8HaHCH9aXIPsOpxlrmBOjh54F3bp6ZXYVUvaLrI+DGgptt
 +uolO/iv40baRQA1iyr3iZ86m/HEQ3yzBXqp45AQoN5puw==
X-Google-Smtp-Source: AGHT+IFchvsTbX6aZDZ2wftGI6aHAiIoyfdt7rdoVS7T5AAtRNNO8/ZRYgEuTuUhzA8T5j/SpdpJ8w==
X-Received: by 2002:a05:6902:1583:b0:e61:1be5:d0ae with SMTP id
 3f1490d57ef6-e611e196a54mr5478255276.5.1741191759583; 
 Wed, 05 Mar 2025 08:22:39 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60b8492409sm3717247276.26.2025.03.05.08.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 08:22:39 -0800 (PST)
Date: Wed, 5 Mar 2025 10:22:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in
 the project)
Message-ID: <20250305162236.GT2640854@bill-the-cat>
References: <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <CAFLszTh=oq3z4P_tAKYETHE40yfHQOH1XHeKqmhQEAQ=PL1HUw@mail.gmail.com>
 <20250221175320.GN1233568@bill-the-cat>
 <20250221181055.GO1233568@bill-the-cat>
 <CAFLszTgnj+ZFq1vEcSSKCOeYjx0NKesO8Lo3aOJ2Nm-jhuTvig@mail.gmail.com>
 <20250224232303.GJ1233568@bill-the-cat>
 <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
 <20250304152909.GZ2640854@bill-the-cat>
 <CAFLszTiNQSs51iE=rcM7qQjipmWCKZiPX+gV2ztb+ZAB8m2MBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WaJdF4LlRkPrG3pq"
Content-Disposition: inline
In-Reply-To: <CAFLszTiNQSs51iE=rcM7qQjipmWCKZiPX+gV2ztb+ZAB8m2MBw@mail.gmail.com>
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


--WaJdF4LlRkPrG3pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 07:19:25AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 4 Mar 2025 at 08:29, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Mar 04, 2025 at 06:13:36AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > (I changed the subject as 'change' sounds like change for change's sa=
ke)
> >
> > Frankly, you have a lot of "tidy up" patches where nothing was
> > functionally wrong.
>=20
> Yes, but they are important too. One of the problems I see with U-Boot
> is that not enough people are willing to do refactoring and code
> maintenance on the required scale.

Again, how much "refactoring" is needed of everything.

> > > On Mon, 24 Feb 2025 at 16:23, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Feb 22, 2025 at 05:00:59PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > (I think you chopped off too much context, so I've added it below)
> > > >
> > > > That's fine. But I omitted it because it's also true for any other =
DM
> > > > migration, and bootstd more fully and adding more classes of device=
s for
> > > > bootmeths and I honestly think you have a half dozen big things tha=
t are
> > > > in various states of being merged and enabled and perhaps even more=
 that
> > > > didn't get much past sandbox being enabled.
> > >
> > > Yes I often have new ideas and start things.
> >
> > And my point is they need to be finished.
>=20
> We've been through this quite a bit and I believe we have a shared
> understanding of why it is hard for me to 'finish' things in your
> tree.

I don't think we do. Because from my point of view you're as interested
in finishing up the details and working through the migrations as you
are on moving to the next thing.

> > > > > On Fri, 21 Feb 2025 at 11:11, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Feb 21, 2025 at 11:53:20AM -0600, Tom Rini wrote:
> > > > > > > On Fri, Feb 21, 2025 at 08:03:12AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > [snip]
> > > > >
> > > > > [unsnip]
> > > > > > > > > >
> > > > > > > > > > Sure, but we can't even get sunxi bootstd or LED over t=
he line. How do
> > > > > > > > > > you imagine we could retire the legacy image?
> > > > > > > > >
> > > > > > > > > Partly by focusing on one thing and not 5 things at a tim=
e. bootstd is
> > > > > > > > > stuck on reworking efi bootmanager integration, and LED i=
s waiting for
> > > > > > > > > someone to confirm that really, finally, we have all of t=
he old use
> > > > > > > > > cases supported in the new code.
> > > > > > > > >
> > > > > > > > > But more importantly, do we really have anyone not using =
u-boot.img? I
> > > > > > > > > don't know.
> > > > > [unsnip end]
> > > > >
> > > > > > > > If we did one of these sorts of things at a time, we would =
only get
> > > > > > > > 2-3 things done each year!
> > > > > > >
> > > > > > > A project with 4 yearly releases finishing two 2-3 big change=
s a year
> > > > > > > sounds great to me. Rather than not finishing a dozen things?
> > > > > >
> > > > > > As this is a huge thread already, I'm splitting this part out.
> > > > > >
> > > > > > I would seriously frame slowing down and having just one big ch=
ange
> > > > > > being in progress at a time, until it's done, as a good thing, =
not a bad
> > > > > > thing. We're a small community with limited bandwidth.
> > > > >
> > > > > I can't see how that would work.
> > > >
> > > > Well, what we have today is clearly not working well enough for you=
=2E And
> > > > "just land my changes" is still not an option for mainline.
> > >
> > > You really haven't addressed my point here.
> >
> > Then I don't see your point, or fundamentally disagree with it.
>=20
> My point is that I am trying to keep U-Boot in a position to solve the
> major problems I see with boot firmware, largely because I don't see
> much else out there. I can't do that with 2-3 big changes a year, not
> even close.

Then maybe you need to fork off and make Simon-Boot. Or maybe you need
to take leadership of the project as a whole. Because I do not see what
you want as sustainable for the project.

> > > > > I just looked at LED[1] originally sent almost 5 months ago and t=
he
> > > > > latest version is marked 'changes requested'. I don't know of any
> > > > > changes I can make. Are you hoping that [sorry forgot who it was]=
 will
> > > > > get around to digging the only affected device out of his drawer =
and
> > > > > try to get the activity-LED going? It might take a while.
> > > >
> > > > Yes, and as a reminder it's only been 6 or 7 months since mainline =
had
> > > > all of the required functionality, maybe. And what *you* could do to
> > > > speed things along is implement the functionality on any of the boa=
rds
> > > > at your disposal. Anything with a LED today would be fine for this.
> > >
> > > Oh well. I would have thought that Christian's series was enough ther=
e?
> >
> > Might be. Waiting for someone to have time to confirm functionality.
> > Which you had previously agreed was a good idea, I thought.
>=20
> OK, so we'll just wait another few releases?

Until someone, which could be you even, has the time to verify things,
yes. Easily. Happily.

> > > > > The sunxi one[2] was sent over 6 months ago and the latest versio=
n is
> > > > > also marked 'changes requested'. You could apply that series with
> > > > > either the bootmgr revert or the patch that drops bootmgr for sun=
xi.
> > > > > Then Heinrich can come along with his patch on top of that.
> > > >
> > > > The sunxi one is blocked because it needs to be rebased on top of t=
he
> > > > fix I did for BLK stuff and then yes you also could have done the
> > > > "bootstd uses bootmanager" idea that you've both agreed is a step i=
n the
> > > > right direction. Because it's actually a generic issue with bootmgr=
 +
> > > > bootstd that only became more evident as more platforms moved
> > > > towards using it.
> > >
> > > So can you clearly explain what is blocking sunxi?r
> >
> > In no particular order:
> > - Testing.
> > - Fixing the problems with efi boot manager, which is a global "use
> >   bootstd more" problem, not sunxi
> >
> > And maybe:
> > - Handle FEL correctly. I'd have to re-read everything again to see if
> >   that was resolved right, or not.
>=20
> Andre did the testing which is how he found the bootmgr/FEL problem.
> FEL is handled correctly in my series.

So FEL is OK afterall, good.

> For bootmgr, there are two patches in my series so you can choose
> which one you want.

And the answer there was neither, both are wrong. We instead finally hit
a more fundamental problem. Which you don't want to solve. And Heinrich
has said he'll post RFC on, but hasn't had time.

> > > Does it just need a rebase?
> >
> > Not just a rebase.
> >
> > > Which patches should be included and which not?
> >
> > Once the efi boot manager part is fixed, just the parts required for it?
>=20
> So just take the patch which disables bootmgr from sunxi?

Who was in favour of that idea again?

> > > Also we
> > > normally expect patches sent first to have priority.
> >
> > No we don't. There might be some general advice / rules of thumb but
> > it's far from some sort of absolute rule. Things are merged when they
> > work and are correct.
>=20
> Well I was a bit put out seeing the series rejected on v3 due to an
> out-of-tree thing I wasn't aware of.

Yes, you need to figure out how to get a better handle on your emails
since you shouldn't have been unaware then.

> > > Here you have
> > > apparently applied your BLK stuff and then want me to rework on top of
> > > it?
> >
> > Yes, I applied the "handle BLK correctly" part that I tried to explain
> > to you how to fix a few times, and you either didn't understand or
> > didn't care. I'm leaning more towards "didn't care" now and thought we
> > should break things a little bit first and fix them later.
> >
> > > I agreed to the bootmanager work-around but I'm certainly not going to
> > > write it. I would rather make bootmgr more iterative, if that is
> > > possible.
> >
> > Then more bootstd migrations are likely blocked until it can handle efi
> > boot manager correctly, which you don't want to do.
>=20
> The correct way to handle bootmgr is (probably?) to have it use
> bootstd to scan for stuff. But as you know, I can't get patches into
> the EFI subsystem, so it's moot.

Since you insist on starting with several "tidy up" series that have
been rejected before starting on the problem at hand, yes, that's true.

> > > > Which is why I had spent so much time trying to get
> > > > you to migrate more SoCs to bootstd because it's your feature.
> > >
> > > So take the sunxi patches and then I'll do the next one? On the one
> > > hand you complain that there are too many balls in the air and on the
> > > other you stop the balls from landing. It just doesn't 'compute' for
> > > me, sorry.
> >
> > Yes, I'm sorry you're having trouble following my requests. Again, I
> > wanted more bootstd migration not for its own sake, but to expose
> > problems with the framework and for you to then fix those problems.
>=20
> There is no problem with the framework. Please just follow my notes
> above and apply the patches. Specifically these ones:

That it doesn't work nicely with EFI boot manager IS a problem with the
framework.

> 733876246aa sunxi: Add a bootmeth for FEL
> ab5fbb4f7c0 efi_loader: bootstd: Drop bootmgr for sunxi
> (leave this one out for now) 9f4ed60d90c RFC: Revert "bootstd: Make
> efi_mgr bootmeth work for non-sandbox setups"
> 90d88509ebd sunxi: Move to bootstd
> e0a16425620 sunxi: Drop old distro boot variables
> da69a979ec7 env: Provide a work-around for unquoting fdtfile
> 7c37601d6be (dm/std-working, dm-public/std-working) sunxi: Move to
> text environment
>=20
> I'm tired of hearing that there is something wrong with bootstd here,
> so please stop saying that.

Well, from my point of view there is a problem. Because your "tidy up"
isn't working with what mainstream OS distributions want. So it's not a
1:1 replacement for what we have today that does work.

> > > > So yes, I think things would be in a better place if we tried to get
> > > > *less* big things done at once and didn't pick up another big thing
> > > > until the last was really done.
> > >
> > > You should address my point above. Are you trying to limit me to 3-4
> > > large series a year?
> >
> > You personally? No. The whole project? Yes, one big feature that's
> > complete and works every 3 months for a project with limited resources
> > sounds amazing. U-Boot isn't a toy personal project, it's something used
> > in production on real devices and needs to move at a sustainable pace
> > with minimal regressions.
>=20
> I believe that is getting better with the increased focus on testing,
> something which I have been pushing for years.

I'm referring to the breadth of testing, not the depth of testing. More
tests are good. More boards being tested is more important. Your lab is
good, yes, but it's not like HW vendors haven't been testing already and
for a long time. And your feedback on their feedback (needing to be able
to use a they-push-out model) wasn't positive.

--=20
Tom

--WaJdF4LlRkPrG3pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfIekkACgkQFHw5/5Y0
tywDqQwApbHuY/zjBfDTs0fnyhwy7gvxumwsRlRArniiyHqo1Z//WVZJcviTkmip
svLIBvD4gNYVx/HieG6rtl6C1g41l76c2lJ8PyXahbwdYsNw8AA/vj/bE2wftucM
fhT4FI5Cxaj9F/2yBAa4+1/JZalAIAnURkJ+zfDUAEAQrHjst7LX92mSmYa6HAjW
utOt1Aho7Wu2sUzbvjUGl8kH8qD5AwwLA1U6v6n7xg/ZIQtMLEYoK/475CQ8npcn
fGd6XxSQt3eWvYn2yyR7G+R8UXWUxLmoQauVcy+eW6w+Gsg2PdH3KeF1Pu7JtyF9
6GQd1ydUOiu17xFupr/HsLPRQXAUT3v4hWIT9abTOC3WtegcSMb5Dj/TGK1fkPu2
qzUu90Nk6QW16YssLCPTDyUKIUonJSRexD6VHcqu5cyanh1UKzltaJ8LFtqC4KMV
E8jTE75wZEz7yNHx7R7rrpoYIgkU3FsF79KV8QNm5gpN10Ns6kUWWaezLcW+rIQO
QtlwvrSe
=5hZi
-----END PGP SIGNATURE-----

--WaJdF4LlRkPrG3pq--
