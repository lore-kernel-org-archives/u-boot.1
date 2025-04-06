Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35C5C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 22:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7380682BCD;
	Mon,  7 Apr 2025 00:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="frIuSO47";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA8282C79; Mon,  7 Apr 2025 00:53:27 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1833D82B8E
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 00:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72bceb93f2fso2556250a34.0
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743980003; x=1744584803; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oh2FqU8t2ZdY4ogl9xY11rukrBdLxhO8lRkNkZdmGYg=;
 b=frIuSO47lpFJibq+VtNjAOxFhXjzOHsB2ZxJ3dbiiW3hO33yc6X+3tWvLVe87HJCiu
 Q8332zP4dPpcUp3E8YncOy9O8xYEmp7ibJW33HOokX72UkIrJIfrQTEXZgXeSO+lwQfz
 KU13YOQ5zHbjOKAjd30Iz1shQcCNbsArgPgyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743980003; x=1744584803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oh2FqU8t2ZdY4ogl9xY11rukrBdLxhO8lRkNkZdmGYg=;
 b=aLibIMmRmU0qPSJlhSh4apGwESonwVASR1nYiw5iiMjWGuOmV6RXvYftLXOFANqya7
 L3k5JCgIhAcJDlczO2xwLP/+Hs/257WhE98faxS0CeiSyog21TQmD50z8lPgAbXufwbv
 Ck4q42+VDc2cVjilySeeJfF+wZsMdwg+CdBQu88NRNpaZLIHxsPVBeAY6KtreypXK4vX
 MDI9nu6vTIGwQbXY/8TTvRQqflkCoQXRCyNJBXu4PNZsDkpPQdiaJykfBIx1RlNr6i55
 DVhhhFXSJdPT+Is4WaVJY1KYaLpDeeLicHlH1gdHaDnKSzLdfqOslFHOPYqedu6+YXjO
 tsiQ==
X-Gm-Message-State: AOJu0YxetEZqXRoxvM0yf0HSZ16bct/Zm/7rzvYTpmeZiNkCQlembCXh
 Zc8yI3kfHa0Gv4HwDa+sQBSzozS+WhvdQLUgHLn2spa8cvpQ1TLdVqOAHhsLEmY=
X-Gm-Gg: ASbGncu90/eOfIYLBudIJSF+DYwr7Kddv9qFm5drO1YpFW/yGiN2Ed4KLvUFvvJKdGs
 UriFlvEfu98fLxW9/HWDXjBR2Zqc31/RHUCTK9z8ZsDvDddLcm+16BVXMhCG7RJqSbp9DfhtyZp
 Vco6yRU2jVgqqRC1hj9yRTB81UgtyrF4YftyXUW5g+0cxsFOYkpwh5FhOK43XtNdHqyeOHNVZOR
 vrA8vZ1YA4fxUH7JLx/QcLoaQEIk0NvWOxQj03uknpGV0hGFRPP1a9tvKk+8zI0OwcpEGbDk2DQ
 uVJISyQG3sSwoJA/XeiJsExUnnFI2NNYSLMO+rLX7cNm4NtHvRbJp3em3Yevb+LJVhbUfrFL9xj
 Q6kvY1SzdV1ti5gUy
X-Google-Smtp-Source: AGHT+IHabB2+r0f+sawBCvKiOTTfvLGluFNEQOAWTuanUBnfGLS57ELqAlzNsHmqSq5huyYyGwko4w==
X-Received: by 2002:a9d:5f04:0:b0:72a:6f75:37e8 with SMTP id
 46e09a7af769-72e2df96878mr8136801a34.0.1743980002645; 
 Sun, 06 Apr 2025 15:53:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e3059a2c8sm1512382a34.49.2025.04.06.15.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 15:53:21 -0700 (PDT)
Date: Sun, 6 Apr 2025 16:53:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in
 the project)
Message-ID: <20250406225319.GH5495@bill-the-cat>
References: <20250310155336.GJ2640854@bill-the-cat>
 <CAFLszTirohLrKadFfdw28UMfH7nt2owKHOGdf-ehwQqemQUpDA@mail.gmail.com>
 <20250331155144.GX93000@bill-the-cat>
 <CAFLszTjNXzkVe_OULMOtt2imSD5KY-KPMgxT7FA=fFqnm0aaeA@mail.gmail.com>
 <20250401171822.GM5495@bill-the-cat>
 <CAFLszTjzxXW_SdDMbjPKitgQ6HSv3Vse6ANrr5QEr85A1byyHg@mail.gmail.com>
 <20250402223534.GE5495@bill-the-cat>
 <CAFLszTiftx2RpeNdBmms8e=HZm2YqH_sjea7Ot1gyaSWAScivw@mail.gmail.com>
 <20250403142741.GJ5495@bill-the-cat>
 <CAFLszTiE4GQ77nzssR42HcE8bcCKzjuNcL50kprQ+zb947mR=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6Kge65dD3ezuiaIi"
Content-Disposition: inline
In-Reply-To: <CAFLszTiE4GQ77nzssR42HcE8bcCKzjuNcL50kprQ+zb947mR=Q@mail.gmail.com>
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


--6Kge65dD3ezuiaIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 09:15:42AM +1200, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 4 Apr 2025 at 03:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Apr 03, 2025 at 12:55:38PM +1300, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 3 Apr 2025 at 11:35, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Apr 03, 2025 at 08:22:13AM +1300, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 2 Apr 2025 at 06:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 02, 2025 at 04:45:37AM +1300, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 1 Apr 2025 at 04:51, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Fri, Mar 28, 2025 at 11:42:20PM +0000, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 10 Mar 2025 at 09:53, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Mar 07, 2025 at 08:46:31AM -0600, Tom Rini wrot=
e:
> > > > > > > > > > > On Thu, Mar 06, 2025 at 09:10:47AM -0700, Simon Glass=
 wrote:
> > > > > > > > > > [snip]
> > > > > > > > > > > > Again, back to this thread, if you want me to migra=
te things, consider
> > > > > > > > > > > > applying the sunxi patches as I have described abov=
e. I will then look
> > > > > > > > > > > > at the next target for bootstd. But while you hold =
this up, I cannot
> > > > > > > > > > > > move forward with more bootstd migration. It doesn'=
t seem that much to
> > > > > > > > > > > > ask.
> > > > > > > > > > >
> > > > > > > > > > > I will take another look at what's still relevant. Bu=
t I believe it's
> > > > > > > > > > > still blocked on the fact that it changes behavior an=
d breaks users.
> > > > > > > > > >
> > > > > > > > > > In details:
> > > > > > > > > >
> > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/202411=
13150938.1534931-2-sjg@chromium.org/
> > > > > > > > > >
> > > > > > > > > > Now that the underlying BLK problem is resolved, this c=
an just be
> > > > > > > > > > dropped I believe. Removing the BLK dependency from BOO=
TSTD can happen
> > > > > > > > > > when you're supporting a flow that lacks a BLK device e=
ntirely. This
> > > > > > > > > > would be another reminder as to why putting unrelated c=
hanges in a
> > > > > > > > > > series is a problem.
> > > > > > > > >
> > > > > > > > > OK, then just don't apply this patch. Problem solved?
> > > > > > > >
> > > > > > > > Well, for a hypothetical v6 you would not include it, sure.
> > > > > > > >
> > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/202411=
13150938.1534931-3-sjg@chromium.org/
> > > > > > > > > >
> > > > > > > > > > This is fine.
> > > > > > > > > >
> > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/202411=
13150938.1534931-4-sjg@chromium.org/
> > > > > > > > > >
> > > > > > > > > > This is not fine. This is also not a sunxi problem. It =
means that we
> > > > > > > > > > should drop bootmgr from rockchip, where the conversion=
 has already
> > > > > > > > > > taken place, and would need to drop it from future conv=
ersion too.
> > > > > > > > > > Neither of which are desirable changes.
> > > > > > > > >
> > > > > > > > > Why do you say that? I don't understand how this relates =
to rockchip
> > > > > > > > > or why we would need to drop bootmgr from that.
> > > > > > > >
> > > > > > > > Then you don't have enough of a grasp of the details of the=
 area you're
> > > > > > > > trying to solve problems in? Or maybe you need to refresh y=
ourself on
> > > > > > > > the details of the area you're trying to work in.
> > > > > > >
> > > > > > > Or perhaps there isn't a problem? The sunxi case is special b=
ecause we
> > > > > > > have a FEL boothmeth. That isn't present on rockchip, for exa=
mple.
> > > > > >
> > > > > > Again, you seem to have forgotten what the problems with the se=
ries
> > > > > > were.
> > > > >
> > > > > No, it's just that we disagree on the path forward.
> > > >
> > > > Then why did you bring up FEL? That's the part of the migration whi=
ch is
> > > > NOT a problem, I keep being reminded when I ask.
> > >
> > > FEL needs to get priority, that's all. It was a problem until I
> > > adjusted the priority.
> >
> > And there's been zero objection to this. So why are you mentioning it
> > here, in the discussion on why the migration is blocked. I know I had
> > been unsure, but I asked, and people answered, and I accepted the
> > answer.
> >
> > > > > > > > > > This patch in particular is
> > > > > > > > > > where we have the note:
> > > > > > > > > >
> > > > > > > > > > "Yes, the introduction of boot standard changed the boo=
t order and
> > > > > > > > > > specifically deprioritizing scripts is unexpected."
> > > > > > > > > >
> > > > > > > > > > Which should have had more attention than it did.
> > > > > > > > >
> > > > > > > > > From memory the scripts are a fallback used when the othe=
r things
> > > > > > > > > don't work, so that was the decision I made at the time.
> > > > > > > >
> > > > > > > > The key point being we changed behavior that others depende=
d on, and
> > > > > > > > didn't document it well and didn't make sure the change wou=
ld work for
> > > > > > > > them either.
> > > > > > > >
> > > > > > > > > > This is the thread that to me spelled out in details wh=
ere the
> > > > > > > > > > conversions are now blocked. We changed behavior and th=
at in turn breaks
> > > > > > > > > > users that have come to rely on ordering.
> > > > > > > > >
> > > > > > > > > I don't know what action to take on that comment. We cann=
ot have 100%
> > > > > > > > > backwards compatibility with the scripts, which after all=
 weren't even
> > > > > > > > > documented. But it is very close.
> > > > > > > >
> > > > > > > > You need to get feedback from the people you want to migrat=
e from the
> > > > > > > > scripts and ordering and rely on to something else and see =
what works
> > > > > > > > for them.
> > > > > > > >
> > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/202411=
13150938.1534931-5-sjg@chromium.org/
> > > > > > > > > >
> > > > > > > > > > Is an alternative to the above which then turned in to =
a discussion that
> > > > > > > > > > I would very briefly summarize as "no discussions were =
had between
> > > > > > > > > > stakeholders before integrating efi bootmgr with bootst=
d".
> > > > > > > > > >
> > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/202411=
13150938.1534931-6-sjg@chromium.org/
> > > > > > > > > >
> > > > > > > > > > This is fine, but only relevant once migration happens.
> > > > > > > > > >
> > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/202411=
13150938.1534931-7-sjg@chromium.org/
> > > > > > > > > >
> > > > > > > > > > If Andre is fine with this, this is fine.
> > > > > > > > > >
> > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/202411=
13150938.1534931-8-sjg@chromium.org/
> > > > > > > > > >
> > > > > > > > > > This is a generic bugfix. I will take this to next toda=
y.
> > > > > > > > > >
> > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/202411=
13150938.1534931-9-sjg@chromium.org/
> > > > > > > > > >
> > > > > > > > > > If Andre is fine with this, this is fine.
> > > > > > > > >
> > > > > > > > > Well, is he? I thought he was. Can you check?
> > > > > > > >
> > > > > > > > You're free to. It's one of the innumerable examples of why=
 when you
> > > > > > > > group multiple things in a series and there's problems with=
 another part
> > > > > > > > of the series, unrelated changes get dropped.
> > > > > > >
> > > > > > > It would be easier for me if you could apply the patches as I=
've suggested.
> > > > > > >
> > > > > > > But if you are willing to apply these patches and just want m=
e to send
> > > > > > > the series again without the BLK and RFC patches, I can do th=
at.
> > > > > > > Please let me know either way.
> > > > > >
> > > > > > Again, you should:
> > > > > > - Take the non-bootstd sunxi enhancements, rebase them to next =
and post
> > > > > >   for Andre. By themselves. This way they won't get stuck.
> > > > >
> > > > > There's no point, though, since it doesn't provide the bootstd mi=
gration.
> > > >
> > > > Are you saying there's no point in generally improving things if it
> > > > doesn't also involve one of your particular projects?
> > >
> > > The series is called 'bootstd: sunxi: Migrate to standard boot'. If
> > > you'd like to apply just the patches from that series which don't
> > > migrate sunxi to standard boot, please go ahead.
> >
> > I'm not the sunxi custodian. General sunxi changes would go through that
> > tree. And then a repeat of everything I've said about how bundling
> > unrelated changes hurts everyone.
> >
> > > > > > - You should work with Heinrich to come up with something that =
handles
> > > > > >   efi bootmanager and bootstd without breaking how our actual p=
roject
> > > > > >   users use us.
> > > > > >   There's no reason to migrate *more* platforms until we have t=
his
> > > > > >   fundamental problem sorted out.
> > > > >
> > > > > It isn't actually a fundamental problem at all. We shouldn't even=
 be
> > > > > discussing this and it is really unfortunate that you continue to
> > > > > block this effort.
> > > > >
> > > > > As to bootmgr, I would be willing to implement a solution here, b=
ut it
> > > > > would involve changes to how bootmgr works under the hood, i.e. to
> > > > > have it be iterative instead of doing everything at the start. My=
 firm
> > > > > understanding is that such changes would not be acceptable to
> > > > > Ilias/Heinrich and anyway I am unable to get patches into the EFI
> > > > > subsystem.
> > > > >
> > > > > So the fallback is the work-around which Heinrich proposed. He is=
 free
> > > > > to implement that if he likes, but I am not planning to do this m=
yself
> > > > > as I see it as a short-term measure and it may cause problems for
> > > > > bootstd, as did f2bfa0cb1 which I bitterly regret allowing in (bu=
t I
> > > > > suppose they were happier days before everything froze up).
> > > > >
> > > > > > - You should work with any FOSS distributions to get their feed=
back on
> > > > > >   what would make their life easier, from a user of U-Boot pers=
pective.
> > > > > >   bootstd won't be useful if it's not something our users want =
to use.
> > > > >
> > > > > Bootstd is designed to replace the distro scripts and the feedbac=
k I
> > > > > have received is that it is good at that. If you have any other
> > > > > feedback, or any suggestions on people I should contact, I'm happ=
y to
> > > > > approach them, or they can email the list and cc me.
> > > > >
> > > > > But really, it would be a lot easier if you could just apply this
> > > > > series so we can move on. If I can see even just a glimmer of
> > > > > compromise here it will help my confidence.
> > > >
> > > > Your sunxi series is broken as posted. I am not interested in apply=
ing
> > > > or encouraging more bootstd usage until there's actual work being d=
one
> > > > to move forward wit bootstd (a thing you want) and EFI (a thing most
> > > > distributions want). That would be some of the general feedback you=
've
> > > > been given and missed or forgotten.
> > > >
> > > > This is even setting aside that I can't recall now if you ever star=
ted
> > > > on making non-BOOTSTD_FULL more useful / usable in general because =
it's
> > > > so minimal that every conversion ends up also enabling BOOTSTD_FULL=
 in
> > > > order to be flexible enough for users to decide SD vs eMMC and so o=
n.
> > >
> > > You can hold this up for as long as you like, it's your tree.
> >
> > And you can do whatever you like in your personal tree, sure. But
> > there's rules for working in a community project.
> >
> > > I'm always happy and willing to discuss and commit to future
> > > improvements. The pattern I see, well-established now, is that you
> > > block my current improvements until some other things are done (this
> > > series, PXE and many others). Or sometimes you see my series, come up
> > > with a clean-up and block my series until it is based on top of that.
> > > If you could move away from that pattern and operate in a more
> > > cooperative manner, we could definitely get a lot more done in your
> > > tree.
> > >
> > > But again, you can hold this up as long as you like. I just feel it
> > > would be better for the project if you didn't.
> >
> > I continue to not accept changes from anyone that knowingly break other
> > use cases and users. You are not an exception to the rule. Leaving
> > things broken for now and improving them later is not an option in
> > mainline.
>=20
> If that is your justification for blocking progress then it won't work
> in this case. There is nothing actually broken with my series. Shall I
> send it again so you can take another look?

Well, again, your series includes "Pick one of these two NAK'd patches
to continue". So no, you probably shouldn't.

> > And I ask everyone to fix problems that are exposed when they're doing
> > something else. Sometimes, when it comes to Kconfig symbols I'll end up
> > doing the cleanup because it's tricky to get things right for 1300
> > platforms.
>=20
> Yes, I know how you feel.

So are you engaging in some sort of tit-for-tat now? I honestly do not
understand why you're not either:
- Stopping with the things people have told you to stop doing.
- Continuing with your own downstream fork for fun.

Your "lets try having two trees" idea is not working and must stop. You
must decide if you are going to set aside concepts that have been
rejected or properly fork (and give the community the domain name).

--=20
Tom

--6Kge65dD3ezuiaIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfzBd8ACgkQFHw5/5Y0
tyxN7Av/ezlt6CT2VwzL7HIIDljpDBICKN7dlIcsTjut7E/vSjMhV9HuiGjXTSSO
xFerNu0TgZVgFgdPxbDLITR3CJGc4qWUy6yxhgpUQ8uNBrcbgFecFeQXY9qBM/mA
xWm+XdojKH/tn0rkJvgPmnAL/gZ7laKCqCpZYmc1mIRPVLw7epVPRZ/MZTsPhd5J
wRBiIv7cHUVyKoC4iifweO/irbooitpcNvLC0xmv8rsgWNdwakCHVPXYm+bUN87A
/bHGwy5CO8cnbVG/9jiqEr3U1vMsz8krW/vvxGNPK00mVPzONikAa8gI8RPb5xOf
xqLjFHqtS2qKjuNmplWePkKT08ulymHFyfRloOpXIyxHSHZDzLYLGJz6zOU7nGSJ
tAiUji7HTv6jWFdK5ykCy7KSNuv5JioxcNGiuLI9Kl+ZcivJb/3AMZZIXx/3SusY
9vOAiBZ0iTl7QRmXk0uTkKhqummGvwovFOPW8ga/ZDkO50v6fenlDjOUDPe6W7/A
lGQoBIO3
=j/0u
-----END PGP SIGNATURE-----

--6Kge65dD3ezuiaIi--
