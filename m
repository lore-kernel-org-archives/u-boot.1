Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5525FC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF8382DB0;
	Mon,  7 Apr 2025 12:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CShI1OMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3A082CF4; Mon,  7 Apr 2025 12:45:41 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6FD82B45
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-abec8b750ebso714230866b.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744022737; x=1744627537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tP+iexP7TAfU6JJZpg4TlrremT/+YXOGksUDJqR+JwE=;
 b=CShI1OMecI7RC9oexbymN59Z1hMmDepYP3b7Xkt+TpOesGGMBHQzITJCPpsQSwQjPM
 3ui2W/ASgjTO2pRmTDLXGHhE4e+5SqCkhuF2XOLlMwzu3Jc1iBE1zqB+N6qgLQ36wTSe
 oaTNmJCdbPrLMouoMtHmPf9y3EqePc5827GxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744022737; x=1744627537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tP+iexP7TAfU6JJZpg4TlrremT/+YXOGksUDJqR+JwE=;
 b=AKoSX3J8eyd/NqjgmpxNTWiwZlkw8Q3pKLfOVBlWii9i8jUX41y9pSKRqAh18EYl8R
 kvcJom7qrwWbUyB5ePhYrBzmlrizTGG2urBHXHA8RuOqvd2obJiXE45T1u4JOj2yQajl
 sd+5iyZyMmZlF8LhZnr3GoItkMVtZ/e1DEQ5QcxKVlTMl2FuCc65Vepuae4sdoV5+aQn
 Sgs8CfN5iKsoVgCHaVf/8UHDyzM2mYd8ml9xCU//9Q5budQ744MYYSdvC1DSslSAcYVp
 H+Ejq1lB05mDhmwUgbgPZxQbdyZH2ugxF8iThdJCA6NpuVKqDyUYxvYzl37xW62IGWHC
 +sdw==
X-Gm-Message-State: AOJu0YxUiS2a1j37VCVdS0+KdZYDIOrbdkGoWCkrDOdaX4nTZ1H4o6K2
 y50Drf//fvXwhKBoaZPkRk2xxNynFxhQRBda2rE4MK0/8FHZj40dGUbMbLoDO17GBay9At5h3Qi
 mFLfI9xi8MaXEmHWq0h9Qf6B7vky9cbTuy0so
X-Gm-Gg: ASbGncszlczjLetjHu4ro87aYU9SdjljFYFyy/N2JqxUZOyfLkDzaSHfGIix9vp7KRj
 j3sKv2kJ9wIyY6qik65lUCxVF5vzn3h1TRfaPPBzp/4iQXCS9VPkrKYrhFVUk1rKYOlP+M+dfDj
 /tOquipcIrGcuqNA34NyJdgDq3PGc=
X-Google-Smtp-Source: AGHT+IFIF7NRponlHO2c+lu0ZjIAZ3Ku4cG+NXGqhasf68FweEKcaPps0GJFB1oQuox4bUtHVD3/qEi8eVI3tdPML1g=
X-Received: by 2002:a17:907:7e5c:b0:ac6:b816:454f with SMTP id
 a640c23a62f3a-ac7e77768d2mr753473266b.54.1744022736374; Mon, 07 Apr 2025
 03:45:36 -0700 (PDT)
MIME-Version: 1.0
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
 <20250406225319.GH5495@bill-the-cat>
In-Reply-To: <20250406225319.GH5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 22:45:24 +1200
X-Gm-Features: ATxdqUHJ1D8vhxlBTz1NL6c25HXxX7H_IoOUy7YBy1SMqprSObHmscGq4fWOxOU
Message-ID: <CAFLszTh3hB1yYJ_TaEvNh3mosEwq2yn02ajXJm3Cv1mvpf67bg@mail.gmail.com>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in the
 project)
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Mon, 7 Apr 2025 at 10:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Apr 07, 2025 at 09:15:42AM +1200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 4 Apr 2025 at 03:27, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Apr 03, 2025 at 12:55:38PM +1300, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 3 Apr 2025 at 11:35, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Apr 03, 2025 at 08:22:13AM +1300, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 2 Apr 2025 at 06:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Apr 02, 2025 at 04:45:37AM +1300, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Tue, 1 Apr 2025 at 04:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Mar 28, 2025 at 11:42:20PM +0000, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Mon, 10 Mar 2025 at 09:53, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Mar 07, 2025 at 08:46:31AM -0600, Tom Rini wrote:
> > > > > > > > > > > > On Thu, Mar 06, 2025 at 09:10:47AM -0700, Simon Glass wrote:
> > > > > > > > > > > [snip]
> > > > > > > > > > > > > Again, back to this thread, if you want me to migrate things, consider
> > > > > > > > > > > > > applying the sunxi patches as I have described above. I will then look
> > > > > > > > > > > > > at the next target for bootstd. But while you hold this up, I cannot
> > > > > > > > > > > > > move forward with more bootstd migration. It doesn't seem that much to
> > > > > > > > > > > > > ask.
> > > > > > > > > > > >
> > > > > > > > > > > > I will take another look at what's still relevant. But I believe it's
> > > > > > > > > > > > still blocked on the fact that it changes behavior and breaks users.
> > > > > > > > > > >
> > > > > > > > > > > In details:
> > > > > > > > > > >
> > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-2-sjg@chromium.org/
> > > > > > > > > > >
> > > > > > > > > > > Now that the underlying BLK problem is resolved, this can just be
> > > > > > > > > > > dropped I believe. Removing the BLK dependency from BOOTSTD can happen
> > > > > > > > > > > when you're supporting a flow that lacks a BLK device entirely. This
> > > > > > > > > > > would be another reminder as to why putting unrelated changes in a
> > > > > > > > > > > series is a problem.
> > > > > > > > > >
> > > > > > > > > > OK, then just don't apply this patch. Problem solved?
> > > > > > > > >
> > > > > > > > > Well, for a hypothetical v6 you would not include it, sure.
> > > > > > > > >
> > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-3-sjg@chromium.org/
> > > > > > > > > > >
> > > > > > > > > > > This is fine.
> > > > > > > > > > >
> > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-4-sjg@chromium.org/
> > > > > > > > > > >
> > > > > > > > > > > This is not fine. This is also not a sunxi problem. It means that we
> > > > > > > > > > > should drop bootmgr from rockchip, where the conversion has already
> > > > > > > > > > > taken place, and would need to drop it from future conversion too.
> > > > > > > > > > > Neither of which are desirable changes.
> > > > > > > > > >
> > > > > > > > > > Why do you say that? I don't understand how this relates to rockchip
> > > > > > > > > > or why we would need to drop bootmgr from that.
> > > > > > > > >
> > > > > > > > > Then you don't have enough of a grasp of the details of the area you're
> > > > > > > > > trying to solve problems in? Or maybe you need to refresh yourself on
> > > > > > > > > the details of the area you're trying to work in.
> > > > > > > >
> > > > > > > > Or perhaps there isn't a problem? The sunxi case is special because we
> > > > > > > > have a FEL boothmeth. That isn't present on rockchip, for example.
> > > > > > >
> > > > > > > Again, you seem to have forgotten what the problems with the series
> > > > > > > were.
> > > > > >
> > > > > > No, it's just that we disagree on the path forward.
> > > > >
> > > > > Then why did you bring up FEL? That's the part of the migration which is
> > > > > NOT a problem, I keep being reminded when I ask.
> > > >
> > > > FEL needs to get priority, that's all. It was a problem until I
> > > > adjusted the priority.
> > >
> > > And there's been zero objection to this. So why are you mentioning it
> > > here, in the discussion on why the migration is blocked. I know I had
> > > been unsure, but I asked, and people answered, and I accepted the
> > > answer.
> > >
> > > > > > > > > > > This patch in particular is
> > > > > > > > > > > where we have the note:
> > > > > > > > > > >
> > > > > > > > > > > "Yes, the introduction of boot standard changed the boot order and
> > > > > > > > > > > specifically deprioritizing scripts is unexpected."
> > > > > > > > > > >
> > > > > > > > > > > Which should have had more attention than it did.
> > > > > > > > > >
> > > > > > > > > > From memory the scripts are a fallback used when the other things
> > > > > > > > > > don't work, so that was the decision I made at the time.
> > > > > > > > >
> > > > > > > > > The key point being we changed behavior that others depended on, and
> > > > > > > > > didn't document it well and didn't make sure the change would work for
> > > > > > > > > them either.
> > > > > > > > >
> > > > > > > > > > > This is the thread that to me spelled out in details where the
> > > > > > > > > > > conversions are now blocked. We changed behavior and that in turn breaks
> > > > > > > > > > > users that have come to rely on ordering.
> > > > > > > > > >
> > > > > > > > > > I don't know what action to take on that comment. We cannot have 100%
> > > > > > > > > > backwards compatibility with the scripts, which after all weren't even
> > > > > > > > > > documented. But it is very close.
> > > > > > > > >
> > > > > > > > > You need to get feedback from the people you want to migrate from the
> > > > > > > > > scripts and ordering and rely on to something else and see what works
> > > > > > > > > for them.
> > > > > > > > >
> > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-5-sjg@chromium.org/
> > > > > > > > > > >
> > > > > > > > > > > Is an alternative to the above which then turned in to a discussion that
> > > > > > > > > > > I would very briefly summarize as "no discussions were had between
> > > > > > > > > > > stakeholders before integrating efi bootmgr with bootstd".
> > > > > > > > > > >
> > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-6-sjg@chromium.org/
> > > > > > > > > > >
> > > > > > > > > > > This is fine, but only relevant once migration happens.
> > > > > > > > > > >
> > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-7-sjg@chromium.org/
> > > > > > > > > > >
> > > > > > > > > > > If Andre is fine with this, this is fine.
> > > > > > > > > > >
> > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-8-sjg@chromium.org/
> > > > > > > > > > >
> > > > > > > > > > > This is a generic bugfix. I will take this to next today.
> > > > > > > > > > >
> > > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-9-sjg@chromium.org/
> > > > > > > > > > >
> > > > > > > > > > > If Andre is fine with this, this is fine.
> > > > > > > > > >
> > > > > > > > > > Well, is he? I thought he was. Can you check?
> > > > > > > > >
> > > > > > > > > You're free to. It's one of the innumerable examples of why when you
> > > > > > > > > group multiple things in a series and there's problems with another part
> > > > > > > > > of the series, unrelated changes get dropped.
> > > > > > > >
> > > > > > > > It would be easier for me if you could apply the patches as I've suggested.
> > > > > > > >
> > > > > > > > But if you are willing to apply these patches and just want me to send
> > > > > > > > the series again without the BLK and RFC patches, I can do that.
> > > > > > > > Please let me know either way.
> > > > > > >
> > > > > > > Again, you should:
> > > > > > > - Take the non-bootstd sunxi enhancements, rebase them to next and post
> > > > > > >   for Andre. By themselves. This way they won't get stuck.
> > > > > >
> > > > > > There's no point, though, since it doesn't provide the bootstd migration.
> > > > >
> > > > > Are you saying there's no point in generally improving things if it
> > > > > doesn't also involve one of your particular projects?
> > > >
> > > > The series is called 'bootstd: sunxi: Migrate to standard boot'. If
> > > > you'd like to apply just the patches from that series which don't
> > > > migrate sunxi to standard boot, please go ahead.
> > >
> > > I'm not the sunxi custodian. General sunxi changes would go through that
> > > tree. And then a repeat of everything I've said about how bundling
> > > unrelated changes hurts everyone.
> > >
> > > > > > > - You should work with Heinrich to come up with something that handles
> > > > > > >   efi bootmanager and bootstd without breaking how our actual project
> > > > > > >   users use us.
> > > > > > >   There's no reason to migrate *more* platforms until we have this
> > > > > > >   fundamental problem sorted out.
> > > > > >
> > > > > > It isn't actually a fundamental problem at all. We shouldn't even be
> > > > > > discussing this and it is really unfortunate that you continue to
> > > > > > block this effort.
> > > > > >
> > > > > > As to bootmgr, I would be willing to implement a solution here, but it
> > > > > > would involve changes to how bootmgr works under the hood, i.e. to
> > > > > > have it be iterative instead of doing everything at the start. My firm
> > > > > > understanding is that such changes would not be acceptable to
> > > > > > Ilias/Heinrich and anyway I am unable to get patches into the EFI
> > > > > > subsystem.
> > > > > >
> > > > > > So the fallback is the work-around which Heinrich proposed. He is free
> > > > > > to implement that if he likes, but I am not planning to do this myself
> > > > > > as I see it as a short-term measure and it may cause problems for
> > > > > > bootstd, as did f2bfa0cb1 which I bitterly regret allowing in (but I
> > > > > > suppose they were happier days before everything froze up).
> > > > > >
> > > > > > > - You should work with any FOSS distributions to get their feedback on
> > > > > > >   what would make their life easier, from a user of U-Boot perspective.
> > > > > > >   bootstd won't be useful if it's not something our users want to use.
> > > > > >
> > > > > > Bootstd is designed to replace the distro scripts and the feedback I
> > > > > > have received is that it is good at that. If you have any other
> > > > > > feedback, or any suggestions on people I should contact, I'm happy to
> > > > > > approach them, or they can email the list and cc me.
> > > > > >
> > > > > > But really, it would be a lot easier if you could just apply this
> > > > > > series so we can move on. If I can see even just a glimmer of
> > > > > > compromise here it will help my confidence.
> > > > >
> > > > > Your sunxi series is broken as posted. I am not interested in applying
> > > > > or encouraging more bootstd usage until there's actual work being done
> > > > > to move forward wit bootstd (a thing you want) and EFI (a thing most
> > > > > distributions want). That would be some of the general feedback you've
> > > > > been given and missed or forgotten.
> > > > >
> > > > > This is even setting aside that I can't recall now if you ever started
> > > > > on making non-BOOTSTD_FULL more useful / usable in general because it's
> > > > > so minimal that every conversion ends up also enabling BOOTSTD_FULL in
> > > > > order to be flexible enough for users to decide SD vs eMMC and so on.
> > > >
> > > > You can hold this up for as long as you like, it's your tree.
> > >
> > > And you can do whatever you like in your personal tree, sure. But
> > > there's rules for working in a community project.
> > >
> > > > I'm always happy and willing to discuss and commit to future
> > > > improvements. The pattern I see, well-established now, is that you
> > > > block my current improvements until some other things are done (this
> > > > series, PXE and many others). Or sometimes you see my series, come up
> > > > with a clean-up and block my series until it is based on top of that.
> > > > If you could move away from that pattern and operate in a more
> > > > cooperative manner, we could definitely get a lot more done in your
> > > > tree.
> > > >
> > > > But again, you can hold this up as long as you like. I just feel it
> > > > would be better for the project if you didn't.
> > >
> > > I continue to not accept changes from anyone that knowingly break other
> > > use cases and users. You are not an exception to the rule. Leaving
> > > things broken for now and improving them later is not an option in
> > > mainline.
> >
> > If that is your justification for blocking progress then it won't work
> > in this case. There is nothing actually broken with my series. Shall I
> > send it again so you can take another look?
>
> Well, again, your series includes "Pick one of these two NAK'd patches
> to continue". So no, you probably shouldn't.

This is the patch I think you are referring to:

https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-4-sjg@chromium.org/

I think disabling bootmgr on sunxi is OK. People can always enable it
again if they don't want to use FEL, which after all is a development
feature. It's not a huge limitation in my view, although it might
eventually become a problem. We could always add a bit of
documentation to explain the issue.

>
> > > And I ask everyone to fix problems that are exposed when they're doing
> > > something else. Sometimes, when it comes to Kconfig symbols I'll end up
> > > doing the cleanup because it's tricky to get things right for 1300
> > > platforms.
> >
> > Yes, I know how you feel.
>
> So are you engaging in some sort of tit-for-tat now?

No, actually I was just empathising with you, that so few people are
willing/able to do the work to really make changes and dig into
things.

> I honestly do not
> understand why you're not either:
> - Stopping with the things people have told you to stop doing.
> - Continuing with your own downstream fork for fun.
>
> Your "lets try having two trees" idea is not working and must stop. You
> must decide if you are going to set aside concepts that have been
> rejected or properly fork (and give the community the domain name).

It is better for the project if we work together collaboratively. You
asked me to pick one thing on which you might compromise. I gave you
three options but you rejected all three. I have compromised on loads
of things from my side.

So how about you pick one thing that you could live with? The lack of
compromise is what is creating the issues here.

Regards,
Simon
