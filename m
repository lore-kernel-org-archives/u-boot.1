Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10FBCD4F52
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 08:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B7CC843B6;
	Tue, 19 May 2026 10:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FtaHsX4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8741E8460E; Tue, 19 May 2026 10:17:41 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F28C84119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 10:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7de431da8fbso3000657a34.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 01:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779178657; cv=none;
 d=google.com; s=arc-20240605;
 b=hbwmSXj+UqfzGHVke/V5lWI/liUaUWRobj9VRq/yevH+YUI2aS+oYZ3AvG5uOMfVdj
 LpPj2n5ZovYlqtzbH5eeUjsO8S5OUOa0aT/RBZ/NaIwUxgnkuYvDcKkV6Dwmb9aItLN1
 ieLyIFLUUDpxFU/PhfFEx06eTOdU17Z5McB4PGdDCoXzCcltOYe53eIr+EI+1QOg0VIm
 Gnfew8LPRKxuUWuL8r95Ateb2OZJCDoxDVv7GD9OgMCxrguicki8OnFKJbJF3Nn7wg/L
 VgiMN7mM5ZyamLZIzIqRjhIcYikjgUkWrmmTjIOG2ldrZo8wpPuxCgcG1afx3kDNahOp
 J1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hqg4ZW/75ux0ciYuBSFuB9cYfluketIhyET3eLwmIqg=;
 fh=lnlBzgbfmfg1pgL53Zpjn8oBkKh4OYgoRQ69kN1wY64=;
 b=OpD7m6blvJatrLzLfloa11Go6jOubqHbHOULzBVGfMfzeuWMd65jgDU1B8OwEOgeY3
 7DxLgR1Zy7k+xCRbhWTmgcVMZQXv5qTERF7OtRdJwaOVEDhIgzT0CGKAd1RK3czYCEm2
 vD1CyR9E92VMJlv8dTXOHN9+jNbCMmx/w5Rw6Si2rw2CBXg6GTP0iqy+VdOFJhshHOD+
 /3g30VUiQ8WXAFPiJEmUMHR1KwxvKHvrkj+zJMR4JiO+J2dksEHw6fOruRaXKKO+ekHO
 EAUme6VMFFROuJQPSRFW3m8saWuzEH0kE885Mam/UsfLAbNFrcrPgGVAt0aQUXBaKKPS
 4wCg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779178657; x=1779783457; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqg4ZW/75ux0ciYuBSFuB9cYfluketIhyET3eLwmIqg=;
 b=FtaHsX4OLCm+EP8gYBPSuMMQ9SBUt5GnJyZWdBXTsOlG4A/bGMtp2c4YQ9KCMxqzmk
 0/SOZd3er10GV/KjrzEGneRt3U9WgVN/1velrbQqxesrRHnMvZC05e5QXtBxmkYC/Eg4
 93iJ7LwYF+3iFJJKxYCf2tmcNgfGecXFQGnpUEFmNx/DzrfIyaIL/zUG3Zl99xdxpO+r
 xnhcjeCLGSToEVnbyegaqcG5pSsKlEdSgaWv4i/gyN0Tydx8k+fPH7JSi/GBwuvMWWDV
 UF0ujk9oHsnMXwDA1ouV4LejnYFXY0SlBUIwPx//Rxj+wn3RX76A6VX9u4p+/ibFfSiU
 JrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779178657; x=1779783457;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hqg4ZW/75ux0ciYuBSFuB9cYfluketIhyET3eLwmIqg=;
 b=P7asb9wCcfflEKZhDG6B0hYFMPfOOGhoJ96gBQWAqvu0k5nnFPXU6Ftds1z5oUC2S1
 3YYnZIBuOZscBpLR6c1gTKB3IwarJ2HCTIM2gIGK0/xmYLmpet0Cyi4lfSCNZDQFqW0K
 dom2Ed8Z0EWLI1gEg24fvzb8XBvImYqdWx+JYFHo/b8r89j7uBkOza5f7qZ6eZTQPm1a
 7U18UJd7Va36UZJeYwZQK0Jo/2icfiYwnWUVhpIQdr/EaNBN/hdVymkJXHtLC4FDjtnS
 krwGLIv70GE6Bbn+Maad48O0Cowl+4cNVFbZh4EUsh7vMcW9FYRk1leceeeDf7c358Qe
 hlSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1wYDTPjQBCXx5zfRw0YQk1Tjb4THB7Yx77/oUrGFlAV+qwu35M09jMscsSgzr/rxUG056XTw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywby9xvbMUIRrhQzW0vdG7yOjsbDgvM58KqB6ugyiLLVgkl93Gx
 YlM8rprt6nk8KKVXiYtsLEET5cwvyKLg2Szj+8JkL5mqVQ9dFbdc1D4HUZw6hfrjFS0HNgmDx1B
 crQWswIXNxdygD48Z45qTJXGYRpOWsSo=
X-Gm-Gg: Acq92OFFTKGb24QhdHhSQFrnu+QwKDiJT4iNqrwa+jBthXvSOfkgmEQNJd5Zwo2XKtb
 ou950iwUKSlyNZ15SrTlFzXFva3xIZQM4sef1gGY7aXm853+U7fHUk2tqpz06LOEeSU82TkkBjW
 0A7s+2b6F6XfK8/0iH6tBra278m+0CBmZibMOxJVsOe6SLPek1dQJQVBat6s0Cy5ehJLbzEA21S
 kf4yzO9lixxB+K66TmPjEKEAVtfEh11oqJZ1vJBQoVAE3785iq0jawIQxBv9j4tuny/o2+OuOrK
 4P0VKQw=
X-Received: by 2002:a05:6830:6f4a:b0:7de:4ebe:e44 with SMTP id
 46e09a7af769-7e4ea06def3mr12912903a34.2.1779178656782; Tue, 19 May 2026
 01:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <CALeDE9PU0-fW_+erR9QHK1ST8fcStx0FWWk_0M8ELjtADugd7Q@mail.gmail.com>
 <CAN7C2SCATJL_rhpBZWwZuQVpLdnbDh5+DRFbtGHoxCXu62AVmw@mail.gmail.com>
 <CALeDE9PesKLwzt=uu_b8+pq5QXFnnK1YAO9WL3f8=CHx93w61w@mail.gmail.com>
 <CAN7C2SC_YwotE2-PS=eAFEnMOXp7jVrhaOSbKsuChLVr4zEa8A@mail.gmail.com>
 <20260514-spotted-happier-0ccb77ca8f24@spud>
 <CAN7C2SAVWp23mKeG77MoV6kUKQDBN_Ge3CUMa_quAXP5YbV6UA@mail.gmail.com>
 <20260515-finished-womanly-675afb9b0c7c@wendy>
 <CAN7C2SDDjM+MJbx2d0N8zC74bytb6gKvjw_6auMPLLNGJVwvfA@mail.gmail.com>
 <20260515150227.GC1858239@bill-the-cat>
 <CAN7C2SApq8ah+NP3k1Jj4kbMhK2s50bN10vfCfXkZaBxkq2w9w@mail.gmail.com>
 <1207964a-67cb-4882-ac49-be40e577a5dd@linaro.org>
 <CAN7C2SDGejA8XH57NUhp1x2KEHoWx7atay7xx1KA9GhqhcpH9g@mail.gmail.com>
 <f7ffdaa4-5aa0-4519-badf-01bda4c61a13@linaro.org>
In-Reply-To: <f7ffdaa4-5aa0-4519-badf-01bda4c61a13@linaro.org>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 19 May 2026 16:17:25 +0800
X-Gm-Features: AVHnY4LWxvSwxRAFCgNybr_OPAtV1ne9iXck8kChT5GzBpUNoTWrLyvIzkTgLEw
Message-ID: <CAN7C2SC5avzY20XBSK6rxKfQuSk-ruZhpQwahtCVQzG__HXmNw@mail.gmail.com>
Subject: Re: U-Boot patch submit standard and requirement
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 19, 2026 at 3:06=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 5/19/26 00:05, Sune Brian wrote:
> > On Tue, May 19, 2026 at 3:17=E2=80=AFAM Neil Armstrong
> > <neil.armstrong@linaro.org> wrote:
> >>
> >> On 5/16/26 01:11, Sune Brian wrote:
> >>> On Fri, May 15, 2026 at 11:02=E2=80=AFPM Tom Rini <trini@konsulko.com=
> wrote:
> >>>>
> >>>> On Fri, May 15, 2026 at 04:23:49PM +0800, Sune Brian wrote:
> >>>>> On Fri, May 15, 2026 at 3:46=E2=80=AFPM Conor Dooley <conor.dooley@=
microchip.com> wrote:
> >>>>>>
> >>>>>> On Fri, May 15, 2026 at 08:46:25AM +0800, Sune Brian wrote:
> >>>>>>> On Fri, May 15, 2026 at 12:14=E2=80=AFAM Conor Dooley <conor@kern=
el.org> wrote:
> >>>>>>>>
> >>>>>>>> On Thu, May 14, 2026 at 07:46:46PM +0800, Sune Brian wrote:
> >>>>>>>>> On Thu, May 14, 2026 at 6:37=E2=80=AFPM Peter Robinson <pbrobin=
son@gmail.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Hi Brian,
> >>>>>>>>>>
> >>>>>>>>>> You have made a very generic statement about levels of account=
ability
> >>>>>>>>>> on patch sets and consistency in reviews.
> >>>>>>>>>>
> >>>>>>>>>> Can you be more specific?
> >>>>>>>>>>
> >>>>>>>>>> Ultimately there are subsystem maintainers and each maintainer=
 has
> >>>>>>>>>> variation on how they deal with their subsystem. You reference=
 one doc
> >>>>>>>>>> three times in your statement.
> >>>>>>>>>
> >>>>>>>>> Hi Peter,
> >>>>>>>>>
> >>>>>>>>> Now I understand what you mean.
> >>>>>>>>> Simply one sentence is a bit hard to read what your thoughts ar=
e.
> >>>>>>>>>
> >>>>>>>>> That document I am quoting does not refer to the entire docs bu=
t only one
> >>>>>>>>> section of the docs with that link.
> >>>>>>>>>
> >>>>>>>>> Before quoting, my declarations as follows:
> >>>>>>>>> 1) I am not referring to specific people or party
> >>>>>>>>> 2) I experienced reviewer which again not being specific to one=
 that
> >>>>>>>>> mentioned this docs is a supreme rules to follow otherwise patc=
h
> >>>>>>>>> that is committed is not able to push to mainstream
> >>>>>>>>> 3) I simply do a quick check on u-boot mailing pool and do see =
a lot
> >>>>>>>>> of uncompiled reviewed patches that are not following that supr=
eme
> >>>>>>>>> docs.
> >>>>>>>>>
> >>>>>>>>> As such I will being to quote:
> >>>>>>>>>
> >>>>>>>>> The mailing that are reported as not passing the standard of [1=
]
> >>>>>>>>> Full mailing:
> >>>>>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260423042824=
.3480-1-briansune@gmail.com/#3684415
> >>>>>>>>
> >>>>>>>> patchwork isn't loading for me, but it's on lore here:
> >>>>>>>> https://lore.kernel.org/all/20260423042824.3480-1-briansune@gmai=
l.com/
> >>>>>>>>
> >>>>>>>
> >>>>>>> Hi Dooley,
> >>>>>>>
> >>>>>>> Well I am sure you did not have the full picture.
> >>>>>>>
> >>>>>>> The request had nothing to do with under the --- line if this is
> >>>>>>> really the case:
> >>>>>>
> >>>>>>> Let me bring you back to the history of wonders:
> >>>>>>>
> >>>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.7=
3491-1-briansune@gmail.com/#3680232
> >>>>>>>
> >>>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260422065910.5=
398-1-briansune@gmail.com/
> >>>>>>>
> >>>>>>> None of those reviewers had mentioned this issue once "---" rathe=
r they all
> >>>>>>> just alarmingly repeated the wordings.
> >>>>>>
> >>>>>> The first mail in the thread mentions it:
> >>>>>> https://lore.kernel.org/all/CAFLszThg=3DEamyRohxNA7V+nk+OMVK356nUj=
AVSbu4+kokOJpdA@mail.gmail.com/
> >>>>>>
> >>>>>>>
> >>>>>>>> The comment about the changelog format seems to be very harsh, I=
 doubt
> >>>>>>>> it really makes any difference. What you did and what the mainta=
iner
> >>>>>>>> requested are effectively the same thing at the end of the day.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Of course after reading the docs I got it immediately.
> >>>>>>> However did those who request contributors quote this from first =
place?
> >>>>>>>
> >>>>>>>> The real problem with your patch is that you put the changelog i=
nto the
> >>>>>>>> commit message itself, rather than under the --- line.
> >>>>>>>> None of the examples you quote below do that.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Well after 4 patches of ridiculous request and logic change.
> >>>>>>> I guess you will do the same. At least I am not doing it at the
> >>>>>>> first moment on replying to the mails who or whom you had mention=
ed.
> >>>>>>
> >>>>>> I think this is a reply to the comment below?
> >>>>>> The aggressive/antagonistic responses begin in your first reply to
> >>>>>> Simon:
> >>>>>> https://lore.kernel.org/all/CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_u=
JjNwsHAhdmY3Q@mail.gmail.com/
> >>>>>> "So forgive me I really don't give a damn on whatever the header
> >>>>>> requirements." "There are many better things to do rather than com=
plaining
> >>>>>> about the patch headers."
> >>>>>
> >>>>> Hi Dooley,
> >>>>>
> >>>>> You are a bit off topic here sorry if you don't think this is the c=
ase but
> >>>>> please do finish reading.
> >>>>>
> >>>>> For what the accused I will give out specific mailing dialogs to ex=
plain
> >>>>> [HERE].
> >>>>>
> >>>>> The major discussion or query is all about the standards or rules.
> >>>>> There is nothing to do with the reply.
> >>>>>
> >>>>> Meantime, I cannot see this as "aggressive/antagonistic responses".
> >>>>> When the request changes it is ridiculous as you also agree:
> >>>>> The header text /  wordings from the updated patch itself
> >>>>> had zero impact on the patch itself.
> >>>>>
> >>>>> You are just simply telling me that if you get hit by someone 4 tim=
es,
> >>>>> the man who stands out and responds is "aggressive/antagonistic".
> >>>>>
> >>>>> Again we are NOT discussing any mailing dialogs but the U-Boot
> >>>>> patch header standards and rules.
> >>>>>
> >>>>> Meantime you had failed to respond or comment the entire mailing
> >>>>> dialogs do mention any "---" header requirements nor the
> >>>>> necessaries of following docs supreme rule / standard from first pl=
ace.
> >>>>>
> >>>>> [HERE]
> >>>>> Allow me to quote the request of header and modifications mail hist=
ory:
> >>>>>
> >>>>> No docs cited nor clearly mentioned the need of specific wordings:
> >>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260420074601.249=
88-1-briansune@gmail.com/#3680096
> >>>>>
> >>>>> No docs cited nor clearly mentioned the need of specific wordings:
> >>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.734=
91-1-briansune@gmail.com/#3680232
> >>>>>
> >>>>> So now you are telling me after at least 2 versions of modification=
s
> >>>>> reviewers suddenly think oh this is not good enough (by my rules)
> >>>>> I think it should be other styles etc.
> >>>>>
> >>>>> Now "LOOK INTO MY EYES" and tell me what is the actual U-Boot
> >>>>> header standard? Reviewer mood or docs that are given out?
> >>>>
> >>>> Brain, I understand being frustrated with the process. Ultimately,
> >>>> everyone here is a volunteer and trying their best. Which means that
> >>>> yes, we are not entirely consistent about some parts of the review
> >>>> process. I would ask you to please be kind to everyone, and expect b=
eing
> >>>> kind in return.
> >>>
> >>> Hi Tom,
> >>>
> >>> Sorry for the additional reply:
> >>> First I need to apologize that I am also blinded by emotion and
> >>> off-topic.
> >>>
> >>> Back to the topic:
> >>>
> >>> Patch header standard is not consistent so docs is not a
> >>> supreme standard or supreme rules on the commit changes vN.
> >>
> >> The base rule for U-Boot is right as the beginning of the doc page:
> >> ```
> >> A good introduction how to prepare for submitting patches can be found=
 in the LWN article How to Get Your Change Into the Linux Kernel as the sam=
e rules apply to U-Boot, too.
> >> ```
> >>
> >> But as the scope of U-Boot is very different and the account of people=
 working
> >> on the project is significantly lower, so the actual review/maintainan=
ce allowance
> >> is less strict.
> >>
> >>>
> >>> Based on the above response we should conclude one fact!
> >>>
> >>> In those mailing pools that are citations or quotations;
> >>> responses or changes requested have no inherent issue
> >>> to pass and accept.
> >>> The changes requested on very specific wordings are
> >>> unreasonable.
> >>>
> >>> Of course Dooley had mentioned the request of after "---"
> >>> placement however again based on this reply it should also not
> >>> an issue to push to master.
> >>>
> >>> Again basically speaking the entire change request or requirement
> >>> is not a must nor really needed in the first place.
> >>>
> >>> I hope this should provide a very good baseline to contributors
> >>> and reviewers how they should review and create patches / commits.
> >>
> >
> > Hi Neil,
> >
> >> The baseline is clear since most of the U-Boot developers, reviewers
> >> and maintainers are experiences Linux developers as-well.
> >
> > Are you sure?
> > If so, why do I clearly see the double standard?
> > And why Dooley would clearly mentioned doubt on the specific wordings
> > making any difference.
> >
> > Again without the double or multiple standards placed on the table
> > and teasing with ridiculous changes requested due to specific wordings:
> > why is it required to raise the tone from first place?
> >
> > Reading specific dialogs is not going to understand the full picture.
> > I also doubt you do read the context before reply or comment.
> >
> > Meantime you are off topic on the citation of context [1] in this mail.
> > My question here is pointing out double or multiple standards on specif=
ic
> > wordings.
>

Hi Neil,

> Please read my entire response instead of inventing stuff:

First I read your comments.
Second, hold your horses and ask if you really understand the entire contex=
t?
Third I did not "invent stuff" which I also suggest you check your tone. Th=
is is
a serious accusation.


Allow me to help you a bit:

Quote:
https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-bria=
nsune@gmail.com/#3684415

According to what you mentioned, it is less strict, however from what
it described
does this follow what you had mentioned?

While after that there are several patches that the same reviewer
does not necessarily need the specific wordings to accept.

I just understand as normally when the citation clearly mentioned a
distinctively strict standard for commit; suddenly other patches
did not follow the same standard / rules on the same group of reviewers?

When two review standards are shown to the same reviewer how can you
describe this? Isn't this considered a double standard?

>
> ```
> But as the scope of U-Boot is very different and the account of people wo=
rking
> on the project is significantly lower, so the actual review/maintainance =
allowance
> is less strict.
> ```
>
> There's no double or triple standard, there's simply a more disparate
> allowance due to low review and maintenance capacity.
>
> To make it simpler so you can understand:
> We're happy when people takes time to review and pick patches, even if do=
esn't
> strictly conform to the "rules".

If so why specifically alarmingly tell the specific docs section from
first place.
As well as making strong phrases that specific wordings are not passing the
standard of ....

>
> Reviewing, picking, building, testing and creating pull requests takes a =
lot
> of our precious volunteer engineering time, be grateful of that.

I will suggest you read the gpl 2.0 license give and take on both sides!

>
> We're a fully volunteered, self organized open source project, please kee=
p
> this in mind.

Same story, different sides, aren't contributors  working under the same
bases?

Now you describe it as such:
due to the volunte actions you have all rights to bully, tease, act
like a tyrant
on whatever the passing line defines.

I plan to stop in the first place as Tom had nicely answered my question.
Quentin gave out why and what was missing to do it properly in the first pl=
ace.
Dooley agreed with the harsh wordings where it simply made zero differences=
.

Where any constructive comments are very welcome as well as long
reading the full story rather than jumping to conclusions.

My goal or my original question just query on the specific wordings are
necessary or not. Nothing to do with the tone nor the reply dialogs.

However once describing the tones; all people jumped out. You should
change your tone etc.

Well, aren't we living in a "causal system"!
Without those standards, guidelines, and rules plus various variants
in the first place I will not give out a strong tone!
Meantime, when telling specific unity with one rule and another
to other unities this simply represented as being targeting.
Clearly displaying double standard either you gave out slacks on the
first place or what Quentin mentioned, strict patch format maybe with very
little slack.
While doing both well this crealy introduces other thoughts.

Again appreciate all the work on all parties.
So if you are still happy to comment / reply feel free to do so.
There is no doubt that same reviewer two different stories on reviewing
thing.

Best wishes,
Brian

>
> I think this thread loops in the void, so I think it would a good time
> to stop responding.
>
> Neil
>
> >
> > Thanks,
> > Brian
> >
> >>
> >> And as an extent, other rules does apply informally to U-Boot like
> >> any other Open Source project ran by volunteers, please have a look at=
:
> >> https://docs.kernel.org/process/code-of-conduct.html
> >>
> >> I'll cite the following behaviors that any Open Source project would l=
ike
> >> to have as basic rules of communication:
> >> - Using welcoming and inclusive language
> >> - Being respectful of differing viewpoints and experiences
> >> - Gracefully accepting constructive criticism
> >> - Focusing on what is best for the community
> >> - Showing empathy towards other community members
> >>
> >> I did review the communication between You and Simon, and this exact t=
hread,
> >> and your replies are not acceptable, and I'll ask you to reconsider yo=
ur tone.
> >>
> >> Thanks,
> >> Neil
> >>
> >>>
> >>> Thanks,
> >>> Brian
> >>>
> >>>>
> >>>> --
> >>>> Tom
> >>
>
