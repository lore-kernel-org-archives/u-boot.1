Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7168C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 19:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 482DC82FB4;
	Mon,  7 Apr 2025 21:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kcrU8RAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F498307F; Mon,  7 Apr 2025 21:10:10 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3172D82EAA
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 21:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3f94b7bd964so3069150b6e.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744053006; x=1744657806; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+D5r5u6JMwUqKRcVsibXiEW04cNgCz0HL4u77JYZxj8=;
 b=kcrU8RAOibGC6QvesUT9eAeThudPF11mru8aNzoqylkqPDSfJ8nFr4jZJs77D/sP/j
 XM8SHiShIZ9NazW8kSnS3y+ifm79wcCHZSjA+k3VFS2GyvrXT+TCObl05osPWPL4GG4a
 41tA8dHtl19mbit5Xr3/c7prq2s2n4tGN+I1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744053006; x=1744657806;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+D5r5u6JMwUqKRcVsibXiEW04cNgCz0HL4u77JYZxj8=;
 b=rY+bW3FW2ZG+UouhUjWWUhl81LMNyHDsxqvrV5V2apYGEWclCI5DvWWd0KIOsm6u/3
 cbiBOG5xxGtbbE1WzX1ddTXaMG5F2fLbC91+lM0o7Cl3HAuQKVYHtAtX7mgtKgSJBDPM
 vcNwqm16YsJslToRd85K7cNPTMi1agx2YYaxZVqgEmuCiBVw5IPxuANw5aiQ1pW9jlwQ
 BOV20le2U8YHWDbecfHGd0H8nR5BwrQ9WJQ2s8uHarhagtQPhCgvph3ynnMz3tCAFT3e
 6gHXjKDwJyHbg+HWNGybxVUXvaYZXm78Kt/UZhpu/HxrYLts5DHznduoHAaHzSoDx3mJ
 BQPg==
X-Gm-Message-State: AOJu0YxTH+9+DFEfxXH4HzgZeX487JrUCuXSuyLiSNBkqKG3jVPi+D3o
 hRU9ny7NqYEYtHWS+xcVmmGwPEyn3yJQs+RiOhDa6TuFnbmTnJ0xCv1bR8qaHX4=
X-Gm-Gg: ASbGncsk7wIJ6JxvnPIUio9XKXw4jifREhuH6J81OEcKQ6wIVIgKfNSN3RSDiVK81Fi
 5SEce5quZM32b3tWAXz9BZXWLN6rcsEu1N9l6dl14Dsn2RxpGTWhiHTHWBnMP/pvt9OSI2ZRZNz
 wTtgBEOYJYD4fAMxLyYVAEuXZnEYuc5Ngw1/SbY3NjkyZbys0BuM0QOgilrGCGC+u/+Wuvdm0KM
 LI52abuhnqvw4gs8Xf2q18dOQjUYW1Qgt07qS5Fe6zKjk/+fMrkKsdsEy68dlLA06AQJEY/5f+1
 552OrwqTKA/kZeQcSvO/QrtmqRlMMt7Jacd85+14XESjGxS3iCDCPOPmLhNNsqntIlSR9Zrej/k
 h4WSE0w==
X-Google-Smtp-Source: AGHT+IEZ1fRpCyxRqxJAmOzRw8ikJN1bBRO6MqCqC3o48EFpDqiO16lB0DhQjuwYbMPBONHMjaWmTw==
X-Received: by 2002:a05:6808:10c5:b0:3f9:d5a2:899b with SMTP id
 5614622812f47-4004669f705mr8108455b6e.38.1744053005702; 
 Mon, 07 Apr 2025 12:10:05 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e6517736csm51255a34.21.2025.04.07.12.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 12:10:05 -0700 (PDT)
Date: Mon, 7 Apr 2025 13:10:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in
 the project)
Message-ID: <20250407191003.GN5495@bill-the-cat>
References: <20250331155144.GX93000@bill-the-cat>
 <CAFLszTjNXzkVe_OULMOtt2imSD5KY-KPMgxT7FA=fFqnm0aaeA@mail.gmail.com>
 <20250401171822.GM5495@bill-the-cat>
 <CAFLszTjzxXW_SdDMbjPKitgQ6HSv3Vse6ANrr5QEr85A1byyHg@mail.gmail.com>
 <20250402223534.GE5495@bill-the-cat>
 <CAFLszTiftx2RpeNdBmms8e=HZm2YqH_sjea7Ot1gyaSWAScivw@mail.gmail.com>
 <20250403142741.GJ5495@bill-the-cat>
 <CAFLszTiE4GQ77nzssR42HcE8bcCKzjuNcL50kprQ+zb947mR=Q@mail.gmail.com>
 <20250406225319.GH5495@bill-the-cat>
 <CAFLszTh3hB1yYJ_TaEvNh3mosEwq2yn02ajXJm3Cv1mvpf67bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/n5V0QXM9EIJGznK"
Content-Disposition: inline
In-Reply-To: <CAFLszTh3hB1yYJ_TaEvNh3mosEwq2yn02ajXJm3Cv1mvpf67bg@mail.gmail.com>
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


--/n5V0QXM9EIJGznK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 10:45:24PM +1200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 7 Apr 2025 at 10:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Apr 07, 2025 at 09:15:42AM +1200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 4 Apr 2025 at 03:27, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Apr 03, 2025 at 12:55:38PM +1300, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 3 Apr 2025 at 11:35, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 03, 2025 at 08:22:13AM +1300, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Wed, 2 Apr 2025 at 06:18, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Wed, Apr 02, 2025 at 04:45:37AM +1300, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Tue, 1 Apr 2025 at 04:51, Tom Rini <trini@konsulko.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Mar 28, 2025 at 11:42:20PM +0000, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 10 Mar 2025 at 09:53, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, Mar 07, 2025 at 08:46:31AM -0600, Tom Rini =
wrote:
> > > > > > > > > > > > > On Thu, Mar 06, 2025 at 09:10:47AM -0700, Simon G=
lass wrote:
> > > > > > > > > > > > [snip]
> > > > > > > > > > > > > > Again, back to this thread, if you want me to m=
igrate things, consider
> > > > > > > > > > > > > > applying the sunxi patches as I have described =
above. I will then look
> > > > > > > > > > > > > > at the next target for bootstd. But while you h=
old this up, I cannot
> > > > > > > > > > > > > > move forward with more bootstd migration. It do=
esn't seem that much to
> > > > > > > > > > > > > > ask.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I will take another look at what's still relevant=
=2E But I believe it's
> > > > > > > > > > > > > still blocked on the fact that it changes behavio=
r and breaks users.
> > > > > > > > > > > >
> > > > > > > > > > > > In details:
> > > > > > > > > > > >
> > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20=
241113150938.1534931-2-sjg@chromium.org/
> > > > > > > > > > > >
> > > > > > > > > > > > Now that the underlying BLK problem is resolved, th=
is can just be
> > > > > > > > > > > > dropped I believe. Removing the BLK dependency from=
 BOOTSTD can happen
> > > > > > > > > > > > when you're supporting a flow that lacks a BLK devi=
ce entirely. This
> > > > > > > > > > > > would be another reminder as to why putting unrelat=
ed changes in a
> > > > > > > > > > > > series is a problem.
> > > > > > > > > > >
> > > > > > > > > > > OK, then just don't apply this patch. Problem solved?
> > > > > > > > > >
> > > > > > > > > > Well, for a hypothetical v6 you would not include it, s=
ure.
> > > > > > > > > >
> > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20=
241113150938.1534931-3-sjg@chromium.org/
> > > > > > > > > > > >
> > > > > > > > > > > > This is fine.
> > > > > > > > > > > >
> > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20=
241113150938.1534931-4-sjg@chromium.org/
> > > > > > > > > > > >
> > > > > > > > > > > > This is not fine. This is also not a sunxi problem.=
 It means that we
> > > > > > > > > > > > should drop bootmgr from rockchip, where the conver=
sion has already
> > > > > > > > > > > > taken place, and would need to drop it from future =
conversion too.
> > > > > > > > > > > > Neither of which are desirable changes.
> > > > > > > > > > >
> > > > > > > > > > > Why do you say that? I don't understand how this rela=
tes to rockchip
> > > > > > > > > > > or why we would need to drop bootmgr from that.
> > > > > > > > > >
> > > > > > > > > > Then you don't have enough of a grasp of the details of=
 the area you're
> > > > > > > > > > trying to solve problems in? Or maybe you need to refre=
sh yourself on
> > > > > > > > > > the details of the area you're trying to work in.
> > > > > > > > >
> > > > > > > > > Or perhaps there isn't a problem? The sunxi case is speci=
al because we
> > > > > > > > > have a FEL boothmeth. That isn't present on rockchip, for=
 example.
> > > > > > > >
> > > > > > > > Again, you seem to have forgotten what the problems with th=
e series
> > > > > > > > were.
> > > > > > >
> > > > > > > No, it's just that we disagree on the path forward.
> > > > > >
> > > > > > Then why did you bring up FEL? That's the part of the migration=
 which is
> > > > > > NOT a problem, I keep being reminded when I ask.
> > > > >
> > > > > FEL needs to get priority, that's all. It was a problem until I
> > > > > adjusted the priority.
> > > >
> > > > And there's been zero objection to this. So why are you mentioning =
it
> > > > here, in the discussion on why the migration is blocked. I know I h=
ad
> > > > been unsure, but I asked, and people answered, and I accepted the
> > > > answer.
> > > >
> > > > > > > > > > > > This patch in particular is
> > > > > > > > > > > > where we have the note:
> > > > > > > > > > > >
> > > > > > > > > > > > "Yes, the introduction of boot standard changed the=
 boot order and
> > > > > > > > > > > > specifically deprioritizing scripts is unexpected."
> > > > > > > > > > > >
> > > > > > > > > > > > Which should have had more attention than it did.
> > > > > > > > > > >
> > > > > > > > > > > From memory the scripts are a fallback used when the =
other things
> > > > > > > > > > > don't work, so that was the decision I made at the ti=
me.
> > > > > > > > > >
> > > > > > > > > > The key point being we changed behavior that others dep=
ended on, and
> > > > > > > > > > didn't document it well and didn't make sure the change=
 would work for
> > > > > > > > > > them either.
> > > > > > > > > >
> > > > > > > > > > > > This is the thread that to me spelled out in detail=
s where the
> > > > > > > > > > > > conversions are now blocked. We changed behavior an=
d that in turn breaks
> > > > > > > > > > > > users that have come to rely on ordering.
> > > > > > > > > > >
> > > > > > > > > > > I don't know what action to take on that comment. We =
cannot have 100%
> > > > > > > > > > > backwards compatibility with the scripts, which after=
 all weren't even
> > > > > > > > > > > documented. But it is very close.
> > > > > > > > > >
> > > > > > > > > > You need to get feedback from the people you want to mi=
grate from the
> > > > > > > > > > scripts and ordering and rely on to something else and =
see what works
> > > > > > > > > > for them.
> > > > > > > > > >
> > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20=
241113150938.1534931-5-sjg@chromium.org/
> > > > > > > > > > > >
> > > > > > > > > > > > Is an alternative to the above which then turned in=
 to a discussion that
> > > > > > > > > > > > I would very briefly summarize as "no discussions w=
ere had between
> > > > > > > > > > > > stakeholders before integrating efi bootmgr with bo=
otstd".
> > > > > > > > > > > >
> > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20=
241113150938.1534931-6-sjg@chromium.org/
> > > > > > > > > > > >
> > > > > > > > > > > > This is fine, but only relevant once migration happ=
ens.
> > > > > > > > > > > >
> > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20=
241113150938.1534931-7-sjg@chromium.org/
> > > > > > > > > > > >
> > > > > > > > > > > > If Andre is fine with this, this is fine.
> > > > > > > > > > > >
> > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20=
241113150938.1534931-8-sjg@chromium.org/
> > > > > > > > > > > >
> > > > > > > > > > > > This is a generic bugfix. I will take this to next =
today.
> > > > > > > > > > > >
> > > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20=
241113150938.1534931-9-sjg@chromium.org/
> > > > > > > > > > > >
> > > > > > > > > > > > If Andre is fine with this, this is fine.
> > > > > > > > > > >
> > > > > > > > > > > Well, is he? I thought he was. Can you check?
> > > > > > > > > >
> > > > > > > > > > You're free to. It's one of the innumerable examples of=
 why when you
> > > > > > > > > > group multiple things in a series and there's problems =
with another part
> > > > > > > > > > of the series, unrelated changes get dropped.
> > > > > > > > >
> > > > > > > > > It would be easier for me if you could apply the patches =
as I've suggested.
> > > > > > > > >
> > > > > > > > > But if you are willing to apply these patches and just wa=
nt me to send
> > > > > > > > > the series again without the BLK and RFC patches, I can d=
o that.
> > > > > > > > > Please let me know either way.
> > > > > > > >
> > > > > > > > Again, you should:
> > > > > > > > - Take the non-bootstd sunxi enhancements, rebase them to n=
ext and post
> > > > > > > >   for Andre. By themselves. This way they won't get stuck.
> > > > > > >
> > > > > > > There's no point, though, since it doesn't provide the bootst=
d migration.
> > > > > >
> > > > > > Are you saying there's no point in generally improving things i=
f it
> > > > > > doesn't also involve one of your particular projects?
> > > > >
> > > > > The series is called 'bootstd: sunxi: Migrate to standard boot'. =
If
> > > > > you'd like to apply just the patches from that series which don't
> > > > > migrate sunxi to standard boot, please go ahead.
> > > >
> > > > I'm not the sunxi custodian. General sunxi changes would go through=
 that
> > > > tree. And then a repeat of everything I've said about how bundling
> > > > unrelated changes hurts everyone.
> > > >
> > > > > > > > - You should work with Heinrich to come up with something t=
hat handles
> > > > > > > >   efi bootmanager and bootstd without breaking how our actu=
al project
> > > > > > > >   users use us.
> > > > > > > >   There's no reason to migrate *more* platforms until we ha=
ve this
> > > > > > > >   fundamental problem sorted out.
> > > > > > >
> > > > > > > It isn't actually a fundamental problem at all. We shouldn't =
even be
> > > > > > > discussing this and it is really unfortunate that you continu=
e to
> > > > > > > block this effort.
> > > > > > >
> > > > > > > As to bootmgr, I would be willing to implement a solution her=
e, but it
> > > > > > > would involve changes to how bootmgr works under the hood, i.=
e. to
> > > > > > > have it be iterative instead of doing everything at the start=
=2E My firm
> > > > > > > understanding is that such changes would not be acceptable to
> > > > > > > Ilias/Heinrich and anyway I am unable to get patches into the=
 EFI
> > > > > > > subsystem.
> > > > > > >
> > > > > > > So the fallback is the work-around which Heinrich proposed. H=
e is free
> > > > > > > to implement that if he likes, but I am not planning to do th=
is myself
> > > > > > > as I see it as a short-term measure and it may cause problems=
 for
> > > > > > > bootstd, as did f2bfa0cb1 which I bitterly regret allowing in=
 (but I
> > > > > > > suppose they were happier days before everything froze up).
> > > > > > >
> > > > > > > > - You should work with any FOSS distributions to get their =
feedback on
> > > > > > > >   what would make their life easier, from a user of U-Boot =
perspective.
> > > > > > > >   bootstd won't be useful if it's not something our users w=
ant to use.
> > > > > > >
> > > > > > > Bootstd is designed to replace the distro scripts and the fee=
dback I
> > > > > > > have received is that it is good at that. If you have any oth=
er
> > > > > > > feedback, or any suggestions on people I should contact, I'm =
happy to
> > > > > > > approach them, or they can email the list and cc me.
> > > > > > >
> > > > > > > But really, it would be a lot easier if you could just apply =
this
> > > > > > > series so we can move on. If I can see even just a glimmer of
> > > > > > > compromise here it will help my confidence.
> > > > > >
> > > > > > Your sunxi series is broken as posted. I am not interested in a=
pplying
> > > > > > or encouraging more bootstd usage until there's actual work bei=
ng done
> > > > > > to move forward wit bootstd (a thing you want) and EFI (a thing=
 most
> > > > > > distributions want). That would be some of the general feedback=
 you've
> > > > > > been given and missed or forgotten.
> > > > > >
> > > > > > This is even setting aside that I can't recall now if you ever =
started
> > > > > > on making non-BOOTSTD_FULL more useful / usable in general beca=
use it's
> > > > > > so minimal that every conversion ends up also enabling BOOTSTD_=
FULL in
> > > > > > order to be flexible enough for users to decide SD vs eMMC and =
so on.
> > > > >
> > > > > You can hold this up for as long as you like, it's your tree.
> > > >
> > > > And you can do whatever you like in your personal tree, sure. But
> > > > there's rules for working in a community project.
> > > >
> > > > > I'm always happy and willing to discuss and commit to future
> > > > > improvements. The pattern I see, well-established now, is that you
> > > > > block my current improvements until some other things are done (t=
his
> > > > > series, PXE and many others). Or sometimes you see my series, com=
e up
> > > > > with a clean-up and block my series until it is based on top of t=
hat.
> > > > > If you could move away from that pattern and operate in a more
> > > > > cooperative manner, we could definitely get a lot more done in yo=
ur
> > > > > tree.
> > > > >
> > > > > But again, you can hold this up as long as you like. I just feel =
it
> > > > > would be better for the project if you didn't.
> > > >
> > > > I continue to not accept changes from anyone that knowingly break o=
ther
> > > > use cases and users. You are not an exception to the rule. Leaving
> > > > things broken for now and improving them later is not an option in
> > > > mainline.
> > >
> > > If that is your justification for blocking progress then it won't work
> > > in this case. There is nothing actually broken with my series. Shall I
> > > send it again so you can take another look?
> >
> > Well, again, your series includes "Pick one of these two NAK'd patches
> > to continue". So no, you probably shouldn't.
>=20
> This is the patch I think you are referring to:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-4=
-sjg@chromium.org/
>=20
> I think disabling bootmgr on sunxi is OK. People can always enable it
> again if they don't want to use FEL, which after all is a development
> feature. It's not a huge limitation in my view, although it might
> eventually become a problem. We could always add a bit of
> documentation to explain the issue.

That patch links to:
https://lore.kernel.org/u-boot/20241112171205.4e80548d@donnerap.manchester.=
arm.com/

Which I would summarize as "EFI boot manager plus boostd changes
behavior in bad for the user ways". And it's not FEL. The FEL challenge
is sunxi specific but also seemingly resolved well enough.

Which is why I don't want to migrate more architectures until:
- We can be more confident that we aren't breaking boot order for users.
- Someone is actually making progress on EFI boot manager plus bootstd.

> > > > And I ask everyone to fix problems that are exposed when they're do=
ing
> > > > something else. Sometimes, when it comes to Kconfig symbols I'll en=
d up
> > > > doing the cleanup because it's tricky to get things right for 1300
> > > > platforms.
> > >
> > > Yes, I know how you feel.
> >
> > So are you engaging in some sort of tit-for-tat now?
>=20
> No, actually I was just empathising with you, that so few people are
> willing/able to do the work to really make changes and dig into
> things.
>=20
> > I honestly do not
> > understand why you're not either:
> > - Stopping with the things people have told you to stop doing.
> > - Continuing with your own downstream fork for fun.
> >
> > Your "lets try having two trees" idea is not working and must stop. You
> > must decide if you are going to set aside concepts that have been
> > rejected or properly fork (and give the community the domain name).
>=20
> It is better for the project if we work together collaboratively. You
> asked me to pick one thing on which you might compromise. I gave you
> three options but you rejected all three. I have compromised on loads
> of things from my side.
>=20
> So how about you pick one thing that you could live with? The lack of
> compromise is what is creating the issues here.

My perspective is that your refusal to slow down and get something to
completion is the issue. You keep sending out 50 part series that
refactor a ton of things. And this is because you have a number of large
changes in mind at all times. This is not functional for a project where
most of our testing happens close to a release. Small incremental change
over time is what works for us.

--=20
Tom

--/n5V0QXM9EIJGznK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf0IwcACgkQFHw5/5Y0
tywTLQv/aRo2Eb5lTI3oJinOhZvQwwANl3760ZeQ2u7uD7NNR/v4Lc6nz272gtJv
kLJgV2O9kTz0c0telynXRhgJEfZTM+BZPi34laJKk52LIyw66Cwt6ro1ifx8eBpJ
D1cTCkPkppZU8H8+xKJt/fDPN2McesT/VNcctYgaGKLfuhZfdiBhg7DdhMMKGVrN
YZ3Z8TDkeKoWoC2qzCa/X6T3AE2M8iZWf8VWZt6A+XxbDlVpHw5Tyfj/3jIglGWh
p9jMIYr+CGXLxagX48QRfy8bHTyseWxWm6zraay9OWGtf+tspoxG/Td2ZoMsu2jL
n+jU6KCSNYsZFaZPhgQAcmJ6I1dBuJ7mBBR6VEnc4O04eU2d9LNU4ELpMklGw6j3
hotTNXwAF/jXFKc+8UUfun55v1slRv8mV2hHny/N5hm0q7nmUqPd7bvgD9kpoEr4
7pNf8UQuRCPId183lOMTMfSQds8xOrAj5RO7kn6rS/IZve8ZAvWAUzm/SWVNKuAL
PHXl4fji
=Qj5H
-----END PGP SIGNATURE-----

--/n5V0QXM9EIJGznK--
