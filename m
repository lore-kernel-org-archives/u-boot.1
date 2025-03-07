Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E349C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 14:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80F3281417;
	Fri,  7 Mar 2025 15:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d9cVLyJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC9C80F4C; Fri,  7 Mar 2025 15:46:39 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6566D8122F
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 15:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6feab7c5f96so15360367b3.3
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 06:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741358795; x=1741963595; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sd7EEBQBOmFu/ongRUvqzoRrFzIwXdDUR4lmSZcSfTk=;
 b=d9cVLyJvpgL9ZaH9TXjEXecS9AjbhM0DY9vUNmepfajlOCNX4pZAFdgxv0a6ulaQ80
 fxCS7jvKMVgJ36KKg27UwwzgyNOIDk28jCTVq+dtl+GhSAzTl3is9qOe5l7asZAOuTko
 JpcOF/CcFTAQBlp5r7e5olwgAGqXzsiBJrIio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741358795; x=1741963595;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sd7EEBQBOmFu/ongRUvqzoRrFzIwXdDUR4lmSZcSfTk=;
 b=iSGcyN7HIWLFyY1Drz6UJdZMg8Mx3RP2v5zR2UEhsZgja4Z7Uf83SeQTkI7ofeAxOR
 x8QZRJf953ZK9gXlwLT7sxwZpz12UQolBOQstEEfnI9To0M2bGkH4xjoeGT9p7xjEiXD
 +ifpmTsFzVQ4SJdB49BtZKPHmnF0yl/NGEwX5ro+P/f+Bvmf4b136N4XiWiJiYAaY19u
 bUKbG6PTlEFlHT/vOrTFtDQgoq0nPv1PbWt6CfgEGHqkdUMj+BahXPST8qnfJDSXrIP8
 rnfZGq8O1GUA4oOjOcsFNSpqyua7YxXtMZjMGTOpAuLCBHX+E8zO4hrrBoaJ1ABGhMZW
 BgiA==
X-Gm-Message-State: AOJu0Yxg7dvYqYPb0EKl1utL/HLl7MtiyLyc7VgW4siOXnOe6WiWVtkX
 GtvQQeYVFZxwBq7l3olSm7P3lTPLgadPTz23H8dmMRUW85pxN/YJJotWDhYqdTU=
X-Gm-Gg: ASbGncvLjMh9HGwkZlGPlvEODerXZYmQTwhDvcHosMo0UbFAghJERMeLHZQh2aNWXe5
 581k1F0AQRaeVg7GnxRENNWspgQcZ/ueYU3sT3OpA/hOYZsfgb7d3Sw+AjmNP+uh0Agn5bz4EHi
 0ofiC6DAUpYBSxOOENMo8qzkaO6vpISluTJ3hRpHf1kNkIbXpT8gFrIjl4L3vE+OOs1pG4h6RGH
 bbVj6Bg2ipFMmSWGg5aDjTmWgqttz6+6G8mtXZBuHa9cPUGb29ieAqMbhCCZS8p0oX7kST0f3Ov
 LurdeTwY2fbcqb5NGhXO/hJ8QJ65USJidg/7ZtSZCgtgzA==
X-Google-Smtp-Source: AGHT+IFJed0JnKg/kh+MUOkszIw26hDbUT+sIecfrPki6B20dQoGA9BwdCXaN+x2IfBb6sgFKGR7Hg==
X-Received: by 2002:a05:690c:620c:b0:6fd:a226:fb50 with SMTP id
 00721157ae682-6febf2e9695mr49432407b3.13.1741358794908; 
 Fri, 07 Mar 2025 06:46:34 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2c46dfasm7570317b3.102.2025.03.07.06.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 06:46:34 -0800 (PST)
Date: Fri, 7 Mar 2025 08:46:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in
 the project)
Message-ID: <20250307144631.GN2640854@bill-the-cat>
References: <CAFLszTh=oq3z4P_tAKYETHE40yfHQOH1XHeKqmhQEAQ=PL1HUw@mail.gmail.com>
 <20250221175320.GN1233568@bill-the-cat>
 <20250221181055.GO1233568@bill-the-cat>
 <CAFLszTgnj+ZFq1vEcSSKCOeYjx0NKesO8Lo3aOJ2Nm-jhuTvig@mail.gmail.com>
 <20250224232303.GJ1233568@bill-the-cat>
 <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
 <20250304152909.GZ2640854@bill-the-cat>
 <CAFLszTiNQSs51iE=rcM7qQjipmWCKZiPX+gV2ztb+ZAB8m2MBw@mail.gmail.com>
 <20250305162236.GT2640854@bill-the-cat>
 <CAFLszTjv54tYLHkG=RNeXJoZ+f-QHxMH=B_aU2=iOZhaoD7qKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tvxXt2aBCZ/kCv1f"
Content-Disposition: inline
In-Reply-To: <CAFLszTjv54tYLHkG=RNeXJoZ+f-QHxMH=B_aU2=iOZhaoD7qKg@mail.gmail.com>
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


--tvxXt2aBCZ/kCv1f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 09:10:47AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 5 Mar 2025 at 09:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 05, 2025 at 07:19:25AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 4 Mar 2025 at 08:29, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Mar 04, 2025 at 06:13:36AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > (I changed the subject as 'change' sounds like change for change'=
s sake)
> > > >
> > > > Frankly, you have a lot of "tidy up" patches where nothing was
> > > > functionally wrong.
> > >
> > > Yes, but they are important too. One of the problems I see with U-Boot
> > > is that not enough people are willing to do refactoring and code
> > > maintenance on the required scale.
> >
> > Again, how much "refactoring" is needed of everything.
>=20
> Without regular refactoring, projects just die.

Strongly disagree. Regular refactoring makes contributions too hard for
new developers because everything is changing all the time. See for
example how you and I (seemingly) shared a gripe about how python
changes all the time and supporting things long term is too hard.

> > > > > On Mon, 24 Feb 2025 at 16:23, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Feb 22, 2025 at 05:00:59PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > (I think you chopped off too much context, so I've added it b=
elow)
> > > > > >
> > > > > > That's fine. But I omitted it because it's also true for any ot=
her DM
> > > > > > migration, and bootstd more fully and adding more classes of de=
vices for
> > > > > > bootmeths and I honestly think you have a half dozen big things=
 that are
> > > > > > in various states of being merged and enabled and perhaps even =
more that
> > > > > > didn't get much past sandbox being enabled.
> > > > >
> > > > > Yes I often have new ideas and start things.
> > > >
> > > > And my point is they need to be finished.
> > >
> > > We've been through this quite a bit and I believe we have a shared
> > > understanding of why it is hard for me to 'finish' things in your
> > > tree.
> >
> > I don't think we do. Because from my point of view you're as interested
> > in finishing up the details and working through the migrations as you
> > are on moving to the next thing.
>=20
> That sounds right, it is nice to finish migrations. But I don't like
> the slowness of it all.

Yes, you wish the project would move faster and I think it's moving too
fast.

> > > > > > > On Fri, 21 Feb 2025 at 11:11, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Feb 21, 2025 at 11:53:20AM -0600, Tom Rini wrote:
> > > > > > > > > On Fri, Feb 21, 2025 at 08:03:12AM -0700, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > [snip]
> > > > > > >
> > > > > > > [unsnip]
> > > > > > > > > > > >
> > > > > > > > > > > > Sure, but we can't even get sunxi bootstd or LED ov=
er the line. How do
> > > > > > > > > > > > you imagine we could retire the legacy image?
> > > > > > > > > > >
> > > > > > > > > > > Partly by focusing on one thing and not 5 things at a=
 time. bootstd is
> > > > > > > > > > > stuck on reworking efi bootmanager integration, and L=
ED is waiting for
> > > > > > > > > > > someone to confirm that really, finally, we have all =
of the old use
> > > > > > > > > > > cases supported in the new code.
> > > > > > > > > > >
> > > > > > > > > > > But more importantly, do we really have anyone not us=
ing u-boot.img? I
> > > > > > > > > > > don't know.
> > > > > > > [unsnip end]
> > > > > > >
> > > > > > > > > > If we did one of these sorts of things at a time, we wo=
uld only get
> > > > > > > > > > 2-3 things done each year!
> > > > > > > > >
> > > > > > > > > A project with 4 yearly releases finishing two 2-3 big ch=
anges a year
> > > > > > > > > sounds great to me. Rather than not finishing a dozen thi=
ngs?
> > > > > > > >
> > > > > > > > As this is a huge thread already, I'm splitting this part o=
ut.
> > > > > > > >
> > > > > > > > I would seriously frame slowing down and having just one bi=
g change
> > > > > > > > being in progress at a time, until it's done, as a good thi=
ng, not a bad
> > > > > > > > thing. We're a small community with limited bandwidth.
> > > > > > >
> > > > > > > I can't see how that would work.
> > > > > >
> > > > > > Well, what we have today is clearly not working well enough for=
 you. And
> > > > > > "just land my changes" is still not an option for mainline.
> > > > >
> > > > > You really haven't addressed my point here.
> > > >
> > > > Then I don't see your point, or fundamentally disagree with it.
> > >
> > > My point is that I am trying to keep U-Boot in a position to solve the
> > > major problems I see with boot firmware, largely because I don't see
> > > much else out there. I can't do that with 2-3 big changes a year, not
> > > even close.
> >
> > Then maybe you need to fork off and make Simon-Boot. Or maybe you need
> > to take leadership of the project as a whole. Because I do not see what
> > you want as sustainable for the project.
>=20
> Or you could just be a little more flexible?

I need to go look at the other email thread where I asked you to tell me
something I can do, before I reply again here.

> > > > > > > I just looked at LED[1] originally sent almost 5 months ago a=
nd the
> > > > > > > latest version is marked 'changes requested'. I don't know of=
 any
> > > > > > > changes I can make. Are you hoping that [sorry forgot who it =
was] will
> > > > > > > get around to digging the only affected device out of his dra=
wer and
> > > > > > > try to get the activity-LED going? It might take a while.
> > > > > >
> > > > > > Yes, and as a reminder it's only been 6 or 7 months since mainl=
ine had
> > > > > > all of the required functionality, maybe. And what *you* could =
do to
> > > > > > speed things along is implement the functionality on any of the=
 boards
> > > > > > at your disposal. Anything with a LED today would be fine for t=
his.
> > > > >
> > > > > Oh well. I would have thought that Christian's series was enough =
there?
> > > >
> > > > Might be. Waiting for someone to have time to confirm functionality.
> > > > Which you had previously agreed was a good idea, I thought.
> > >
> > > OK, so we'll just wait another few releases?
> >
> > Until someone, which could be you even, has the time to verify things,
> > yes. Easily. Happily.
>=20
> The incentives are wrong here, of course. People should *want* to test
> in case patches break their use case. People who wait 6 months to test
> are just not that interested in the project.

Strongly disagree. We're a boot loader. People reasonably expect that
it's not changing all the time and doesn't need constant attention and
re-testing.

> > > > > > > The sunxi one[2] was sent over 6 months ago and the latest ve=
rsion is
> > > > > > > also marked 'changes requested'. You could apply that series =
with
> > > > > > > either the bootmgr revert or the patch that drops bootmgr for=
 sunxi.
> > > > > > > Then Heinrich can come along with his patch on top of that.
> > > > > >
> > > > > > The sunxi one is blocked because it needs to be rebased on top =
of the
> > > > > > fix I did for BLK stuff and then yes you also could have done t=
he
> > > > > > "bootstd uses bootmanager" idea that you've both agreed is a st=
ep in the
> > > > > > right direction. Because it's actually a generic issue with boo=
tmgr +
> > > > > > bootstd that only became more evident as more platforms moved
> > > > > > towards using it.
> > > > >
> > > > > So can you clearly explain what is blocking sunxi?r
> > > >
> > > > In no particular order:
> > > > - Testing.
> > > > - Fixing the problems with efi boot manager, which is a global "use
> > > >   bootstd more" problem, not sunxi
> > > >
> > > > And maybe:
> > > > - Handle FEL correctly. I'd have to re-read everything again to see=
 if
> > > >   that was resolved right, or not.
> > >
> > > Andre did the testing which is how he found the bootmgr/FEL problem.
> > > FEL is handled correctly in my series.
> >
> > So FEL is OK afterall, good.
> >
> > > For bootmgr, there are two patches in my series so you can choose
> > > which one you want.
> >
> > And the answer there was neither, both are wrong. We instead finally hit
> > a more fundamental problem. Which you don't want to solve. And Heinrich
> > has said he'll post RFC on, but hasn't had time.
>=20
> Or you could just make a decision.

I did. It's the one you don't like, which is to slow down
bootstd/bootmeth/etc.

> > > > > Does it just need a rebase?
> > > >
> > > > Not just a rebase.
> > > >
> > > > > Which patches should be included and which not?
> > > >
> > > > Once the efi boot manager part is fixed, just the parts required fo=
r it?
> > >
> > > So just take the patch which disables bootmgr from sunxi?
> >
> > Who was in favour of that idea again?
>=20
> Andre seemed OK with it as no one uses it at present and it allows us
> to make progress.
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-4=
-sjg@chromium.org/#3418689

That's not how I read the final parts of the thread.

> > > > > Also we
> > > > > normally expect patches sent first to have priority.
> > > >
> > > > No we don't. There might be some general advice / rules of thumb but
> > > > it's far from some sort of absolute rule. Things are merged when th=
ey
> > > > work and are correct.
> > >
> > > Well I was a bit put out seeing the series rejected on v3 due to an
> > > out-of-tree thing I wasn't aware of.
> >
> > Yes, you need to figure out how to get a better handle on your emails
> > since you shouldn't have been unaware then.
>=20
> Yes I've scaled back my reviews significantly and that is giving me more =
time.
>=20
> >
> > > > > Here you have
> > > > > apparently applied your BLK stuff and then want me to rework on t=
op of
> > > > > it?
> > > >
> > > > Yes, I applied the "handle BLK correctly" part that I tried to expl=
ain
> > > > to you how to fix a few times, and you either didn't understand or
> > > > didn't care. I'm leaning more towards "didn't care" now and thought=
 we
> > > > should break things a little bit first and fix them later.
> > > >
> > > > > I agreed to the bootmanager work-around but I'm certainly not goi=
ng to
> > > > > write it. I would rather make bootmgr more iterative, if that is
> > > > > possible.
> > > >
> > > > Then more bootstd migrations are likely blocked until it can handle=
 efi
> > > > boot manager correctly, which you don't want to do.
> > >
> > > The correct way to handle bootmgr is (probably?) to have it use
> > > bootstd to scan for stuff. But as you know, I can't get patches into
> > > the EFI subsystem, so it's moot.
> >
> > Since you insist on starting with several "tidy up" series that have
> > been rejected before starting on the problem at hand, yes, that's true.
>=20
> Yes, I am aware it is true.

Then it's misleading to say you can't get patches in to the EFI
subsystem.

> > > > > > Which is why I had spent so much time trying to get
> > > > > > you to migrate more SoCs to bootstd because it's your feature.
> > > > >
> > > > > So take the sunxi patches and then I'll do the next one? On the o=
ne
> > > > > hand you complain that there are too many balls in the air and on=
 the
> > > > > other you stop the balls from landing. It just doesn't 'compute' =
for
> > > > > me, sorry.
> > > >
> > > > Yes, I'm sorry you're having trouble following my requests. Again, I
> > > > wanted more bootstd migration not for its own sake, but to expose
> > > > problems with the framework and for you to then fix those problems.
> > >
> > > There is no problem with the framework. Please just follow my notes
> > > above and apply the patches. Specifically these ones:
> >
> > That it doesn't work nicely with EFI boot manager IS a problem with the
> > framework.
>=20
> It's a problem with bootmgr, which I'm not going to take on, since I
> am unable to get patches into EFI_LOADER.

It's a problem with bootmgr and bootmeth/bootstd.

> > > 733876246aa sunxi: Add a bootmeth for FEL
> > > ab5fbb4f7c0 efi_loader: bootstd: Drop bootmgr for sunxi
> > > (leave this one out for now) 9f4ed60d90c RFC: Revert "bootstd: Make
> > > efi_mgr bootmeth work for non-sandbox setups"
> > > 90d88509ebd sunxi: Move to bootstd
> > > e0a16425620 sunxi: Drop old distro boot variables
> > > da69a979ec7 env: Provide a work-around for unquoting fdtfile
> > > 7c37601d6be (dm/std-working, dm-public/std-working) sunxi: Move to
> > > text environment
> > >
> > > I'm tired of hearing that there is something wrong with bootstd here,
> > > so please stop saying that.
> >
> > Well, from my point of view there is a problem. Because your "tidy up"
> > isn't working with what mainstream OS distributions want. So it's not a
> > 1:1 replacement for what we have today that does work.
>=20
> Which tidy-up?

The bootstd/bootmeth framework.

> > > > > > So yes, I think things would be in a better place if we tried t=
o get
> > > > > > *less* big things done at once and didn't pick up another big t=
hing
> > > > > > until the last was really done.
> > > > >
> > > > > You should address my point above. Are you trying to limit me to =
3-4
> > > > > large series a year?
> > > >
> > > > You personally? No. The whole project? Yes, one big feature that's
> > > > complete and works every 3 months for a project with limited resour=
ces
> > > > sounds amazing. U-Boot isn't a toy personal project, it's something=
 used
> > > > in production on real devices and needs to move at a sustainable pa=
ce
> > > > with minimal regressions.
> > >
> > > I believe that is getting better with the increased focus on testing,
> > > something which I have been pushing for years.
> >
> > I'm referring to the breadth of testing, not the depth of testing. More
> > tests are good. More boards being tested is more important. Your lab is
> > good, yes, but it's not like HW vendors haven't been testing already and
> > for a long time. And your feedback on their feedback (needing to be able
> > to use a they-push-out model) wasn't positive.
>=20
> Are you saying that you want me to implement a framework to access
> test results from HW vendors and that until I do that, you consider
> that I am holding testing back?? Anyway, don't such frameworks already
> exist?

Oh goodness no. I want you to stop trying to personally boil the entire
ocean, to use a phrase you often use.

What I am saying is that the direction you're trying to take testing in
seems to be the opposite of the community feedback, so maybe stop going
in that direction and focus on one of the other things you're trying to
do.

> Again, back to this thread, if you want me to migrate things, consider
> applying the sunxi patches as I have described above. I will then look
> at the next target for bootstd. But while you hold this up, I cannot
> move forward with more bootstd migration. It doesn't seem that much to
> ask.

I will take another look at what's still relevant. But I believe it's
still blocked on the fact that it changes behavior and breaks users.

--=20
Tom

--tvxXt2aBCZ/kCv1f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfLBsAACgkQFHw5/5Y0
tyzSaAwAkPSvf8Vdgh6jcTA1seKVSF4X1XAoq6vTgVuwdlzwaWH/mskXQt8rg3+D
HZ1tH8NgEqm3lWV0WkCKc3YaLHg1QJgu4iKjg42JbFFASFr9xK+FTdaM7rqPhJ0y
6waKHe6N2UCh/6jF0/wdAV9m/yl3LAaFpBGvTMuB3zPVnA50w3XeJLmgBIRqFiGJ
8BUcsat8aPfoMHhND5G0t9ltkkNGXngHc4JjDXysapFY8qzTYORtE0oiSHXbYC4r
oix4U1f3O7FxyF/Zx3KA+QfN2a/+iEhAGXECPTEw1ai//NGayno9b3JxEGOvVMcS
gJ8YxzE+Tmzyxg0wl3VLn71bFQDh1JXGOAcNkX5v2sGnx7mn2EXPQ/WuMmxE3Z8w
MhVdgItSeamoU7QqLxd+0DGtZO//Zp2ELlMqmggY21J4Ce9lpoz713JXSi9HzW4P
Fc1BZ2nn1tyK6TD1jwOWIcgH99joiOyu/vYmVIodrVA8ceFfCnhfah3WMSfPhDu7
YmD+KPBa
=MBW8
-----END PGP SIGNATURE-----

--tvxXt2aBCZ/kCv1f--
