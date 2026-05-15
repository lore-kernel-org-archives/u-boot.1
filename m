Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDB8CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 23:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6A9984812;
	Sat, 16 May 2026 01:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XFR28IL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9421584869; Sat, 16 May 2026 01:11:54 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF4784713
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 01:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-47c7b282e21so187478b6e.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:11:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778886711; cv=none;
 d=google.com; s=arc-20240605;
 b=JEf1hyUqQwehOsOFr+FieAplZ9ayRWXJrt/tEtwgMpZNVX+KizKwCZkRBB5Fiq7plQ
 xuIbzSSU67sy4hLkLAouPlmz+c8fCiMqdB26HKN6brh30SG32ItWpmJ54Y1JZnOm+Jhx
 ApuCS/yeC6e4QU4Znt1ToUlb2XGSQ5FiSUj5puCMPJR9DMh+dtyGi2dSFV51wapd31bN
 VcggYUQoSaAk1HEl3gBQuX4/dHOWZAdprOC6QsLSl/6cEp/ytIVWrnnTPrV8b3umw6US
 c17DpaQDGc5WSgVYWCCbxFuOZLaDI6DMExv2MUMYfBwu7xs9V/JHW0DllsCslWtM56Hk
 b25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c36LsoF7NwGzx2oLAgF0EN8Bh/98KJmDgaYaEJ3G4Ew=;
 fh=WZ5gdBIPClJvaOLUN4gZuxwRaqg2moCepTlohn5msQs=;
 b=OEB6HnZJ70M8UsgAyg4eFd42jQ1tKj96bFROvby4r+o13zLRw45Hq/Sbg1peOwLmZl
 jD0XrIMTDPh2ghGR/k4aaVoBeSE3zNf5GE4b4eTd3uIg+F5jidx4DSNcN9q3eZkgSxdo
 0uVlICqZY2pP/1ufFTMYVbXkah3cDjU1rxVHSrT8+qVi5P+BpRlPPOsvvb7XdzN8IyIo
 4V3HwlHek33A3/bTtfZalqhux1Dfg0eF3gcnlOU/UOdHcP31bVZIOgtRC3C6Jmj+FOAo
 g7yjJKP2OKy/xPs9f8pCtkwD+geAHh4OWhv8Gsq8VD+XGKwLOaJj4A/wm20DqMO6DACA
 vJoA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778886711; x=1779491511; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c36LsoF7NwGzx2oLAgF0EN8Bh/98KJmDgaYaEJ3G4Ew=;
 b=XFR28IL4QZoc7hTtl01DzO/eu9I4Evv86vqGlIS//oEnK7aOfBPOgXKAXweV7FwiJW
 tCCFaOFH2w4/MlE30MA6ssZMz4XLLl4jGZ/IlJh1YsKdHTx45YDdKJa6GwJWf5GZHSZC
 l0ZZ5iIBbkublNJjZI0ho6jkihbiu60eHr9eyKKcFe1FkvEOhCuJH48TrfSqyfjcqMqx
 HINXha522hRXkkJRm9J2WVLWWDt2qilmykh/H48A/U64o7l2/7RKSGEkoN2bbrTLHxm7
 zqIPAFA2Fcf54nMPupLyUHBzNI208cY3RZakZ9ylygol0PILXp3ubmlOBnEuUh5Tclkb
 GIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778886711; x=1779491511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c36LsoF7NwGzx2oLAgF0EN8Bh/98KJmDgaYaEJ3G4Ew=;
 b=eu6p41XqIoHxBwLuljmES48hhCBvbiZfKXPNSg5BRqyQ+sY4yerOJgEzXN7Y79KEoR
 Bu2NcI1VE1lTjN8f1CVdxo1TlEJETCYPMtLjF6MFO38vdufXqYNT8Yzr3zxf5a99FMR5
 ls9uoZq3V70Fva3fCP3s3wIyr0CMZHDjF8nmi7vIpesDVoOI5HdRXKbcVn2qZUDAArAY
 W4zzEvurlyMDeD6OzX2cKDThas8SRuE36I3060Abewk8/h4rFvsqRuH6RhYH/Rkenu9L
 nFEV6FzYZRjTtvCGHss0Mn7XjBGblfTlKVjmChpXymsmpiltPVEhfMWSIuKs7qLKnsFz
 hM5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ++nAFEJiQqDKXJFKVQWY3sd3ztU1O9X8bOKeJVN4LQMpACXHrS9z3700W6X51iu8B0Gfpr270=@lists.denx.de
X-Gm-Message-State: AOJu0YxDSguFdcYOlknJGF8s6DmGVXyxQJPhVPy1AutuHwk0GTXeyfiY
 kRPV5Ex7WKiUq5R/clPNSohpCeRSB9wZCw5/j57LQIIIO18fE3LGZPoroX1mbGlT5ojlThwJSIS
 nV5wGoNXuCl8OJXTnwosh10b8zxKoR4U=
X-Gm-Gg: Acq92OFOrHko7xaeoMVxBbppLaZpZe+Lw8l0i1M7cGFYPJPNTqtg/DjHvRpG+hQLMVu
 LNqxwOvgnDb6sugERuOXFuBHuECqbdq6XMnidsIiGVBpYkkiYXskLPcDXNw2CvfNhXqRglHrSsd
 mp9URMwlTt03V89o2SgM8SkrHiGERi+juBNd5ruNXJqvEAbDuaS3K6GigZuGxqKgFcEQg8QrLa2
 JRxm+TXg0sJuQ1FkSUMr2BnkP6MQ03XfkM/ZImTNxlz9xdtwyB+PJBPT+8fdilrxxlFffxsH7gL
 0h8SU6urnFi64QcQwQ==
X-Received: by 2002:a05:6808:148e:b0:482:6b8a:33a6 with SMTP id
 5614622812f47-482e57ba674mr4167300b6e.23.1778886710656; Fri, 15 May 2026
 16:11:50 -0700 (PDT)
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
In-Reply-To: <20260515150227.GC1858239@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 16 May 2026 07:11:38 +0800
X-Gm-Features: AVHnY4K6z9JssBXGrqrGIhfvj1Zyt1aIvJoLZSp8S9_TUYEhE-R01fDkw9iOdN0
Message-ID: <CAN7C2SApq8ah+NP3k1Jj4kbMhK2s50bN10vfCfXkZaBxkq2w9w@mail.gmail.com>
Subject: Re: U-Boot patch submit standard and requirement
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>,
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

On Fri, May 15, 2026 at 11:02=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, May 15, 2026 at 04:23:49PM +0800, Sune Brian wrote:
> > On Fri, May 15, 2026 at 3:46=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > >
> > > On Fri, May 15, 2026 at 08:46:25AM +0800, Sune Brian wrote:
> > > > On Fri, May 15, 2026 at 12:14=E2=80=AFAM Conor Dooley <conor@kernel=
.org> wrote:
> > > > >
> > > > > On Thu, May 14, 2026 at 07:46:46PM +0800, Sune Brian wrote:
> > > > > > On Thu, May 14, 2026 at 6:37=E2=80=AFPM Peter Robinson <pbrobin=
son@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Brian,
> > > > > > >
> > > > > > > You have made a very generic statement about levels of accoun=
tability
> > > > > > > on patch sets and consistency in reviews.
> > > > > > >
> > > > > > > Can you be more specific?
> > > > > > >
> > > > > > > Ultimately there are subsystem maintainers and each maintaine=
r has
> > > > > > > variation on how they deal with their subsystem. You referenc=
e one doc
> > > > > > > three times in your statement.
> > > > > >
> > > > > > Hi Peter,
> > > > > >
> > > > > > Now I understand what you mean.
> > > > > > Simply one sentence is a bit hard to read what your thoughts ar=
e.
> > > > > >
> > > > > > That document I am quoting does not refer to the entire docs bu=
t only one
> > > > > > section of the docs with that link.
> > > > > >
> > > > > > Before quoting, my declarations as follows:
> > > > > > 1) I am not referring to specific people or party
> > > > > > 2) I experienced reviewer which again not being specific to one=
 that
> > > > > > mentioned this docs is a supreme rules to follow otherwise patc=
h
> > > > > > that is committed is not able to push to mainstream
> > > > > > 3) I simply do a quick check on u-boot mailing pool and do see =
a lot
> > > > > > of uncompiled reviewed patches that are not following that supr=
eme
> > > > > > docs.
> > > > > >
> > > > > > As such I will being to quote:
> > > > > >
> > > > > > The mailing that are reported as not passing the standard of [1=
]
> > > > > > Full mailing:
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20260423042824=
.3480-1-briansune@gmail.com/#3684415
> > > > >
> > > > > patchwork isn't loading for me, but it's on lore here:
> > > > > https://lore.kernel.org/all/20260423042824.3480-1-briansune@gmail=
.com/
> > > > >
> > > >
> > > > Hi Dooley,
> > > >
> > > > Well I am sure you did not have the full picture.
> > > >
> > > > The request had nothing to do with under the --- line if this is
> > > > really the case:
> > >
> > > > Let me bring you back to the history of wonders:
> > > >
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.734=
91-1-briansune@gmail.com/#3680232
> > > >
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20260422065910.539=
8-1-briansune@gmail.com/
> > > >
> > > > None of those reviewers had mentioned this issue once "---" rather =
they all
> > > > just alarmingly repeated the wordings.
> > >
> > > The first mail in the thread mentions it:
> > > https://lore.kernel.org/all/CAFLszThg=3DEamyRohxNA7V+nk+OMVK356nUjAVS=
bu4+kokOJpdA@mail.gmail.com/
> > >
> > > >
> > > > > The comment about the changelog format seems to be very harsh, I =
doubt
> > > > > it really makes any difference. What you did and what the maintai=
ner
> > > > > requested are effectively the same thing at the end of the day.
> > > > >
> > > >
> > > > Of course after reading the docs I got it immediately.
> > > > However did those who request contributors quote this from first pl=
ace?
> > > >
> > > > > The real problem with your patch is that you put the changelog in=
to the
> > > > > commit message itself, rather than under the --- line.
> > > > > None of the examples you quote below do that.
> > > > >
> > > >
> > > > Well after 4 patches of ridiculous request and logic change.
> > > > I guess you will do the same. At least I am not doing it at the
> > > > first moment on replying to the mails who or whom you had mentioned=
.
> > >
> > > I think this is a reply to the comment below?
> > > The aggressive/antagonistic responses begin in your first reply to
> > > Simon:
> > > https://lore.kernel.org/all/CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjN=
wsHAhdmY3Q@mail.gmail.com/
> > > "So forgive me I really don't give a damn on whatever the header
> > > requirements." "There are many better things to do rather than compla=
ining
> > > about the patch headers."
> >
> > Hi Dooley,
> >
> > You are a bit off topic here sorry if you don't think this is the case =
but
> > please do finish reading.
> >
> > For what the accused I will give out specific mailing dialogs to explai=
n
> > [HERE].
> >
> > The major discussion or query is all about the standards or rules.
> > There is nothing to do with the reply.
> >
> > Meantime, I cannot see this as "aggressive/antagonistic responses".
> > When the request changes it is ridiculous as you also agree:
> > The header text /  wordings from the updated patch itself
> > had zero impact on the patch itself.
> >
> > You are just simply telling me that if you get hit by someone 4 times,
> > the man who stands out and responds is "aggressive/antagonistic".
> >
> > Again we are NOT discussing any mailing dialogs but the U-Boot
> > patch header standards and rules.
> >
> > Meantime you had failed to respond or comment the entire mailing
> > dialogs do mention any "---" header requirements nor the
> > necessaries of following docs supreme rule / standard from first place.
> >
> > [HERE]
> > Allow me to quote the request of header and modifications mail history:
> >
> > No docs cited nor clearly mentioned the need of specific wordings:
> > https://patchwork.ozlabs.org/project/uboot/patch/20260420074601.24988-1=
-briansune@gmail.com/#3680096
> >
> > No docs cited nor clearly mentioned the need of specific wordings:
> > https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.73491-1=
-briansune@gmail.com/#3680232
> >
> > So now you are telling me after at least 2 versions of modifications
> > reviewers suddenly think oh this is not good enough (by my rules)
> > I think it should be other styles etc.
> >
> > Now "LOOK INTO MY EYES" and tell me what is the actual U-Boot
> > header standard? Reviewer mood or docs that are given out?
>
> Brain, I understand being frustrated with the process. Ultimately,
> everyone here is a volunteer and trying their best. Which means that
> yes, we are not entirely consistent about some parts of the review
> process. I would ask you to please be kind to everyone, and expect being
> kind in return.

Hi Tom,

Sorry for the additional reply:
First I need to apologize that I am also blinded by emotion and
off-topic.

Back to the topic:

Patch header standard is not consistent so docs is not a
supreme standard or supreme rules on the commit changes vN.

Based on the above response we should conclude one fact!

In those mailing pools that are citations or quotations;
responses or changes requested have no inherent issue
to pass and accept.
The changes requested on very specific wordings are
unreasonable.

Of course Dooley had mentioned the request of after "---"
placement however again based on this reply it should also not
an issue to push to master.

Again basically speaking the entire change request or requirement
is not a must nor really needed in the first place.

I hope this should provide a very good baseline to contributors
and reviewers how they should review and create patches / commits.

Thanks,
Brian

>
> --
> Tom
