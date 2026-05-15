Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADB2CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 08:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5FB8836AC;
	Fri, 15 May 2026 10:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UCmpAncw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C66FC83AA9; Fri, 15 May 2026 10:24:04 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E9D8341A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 10:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so4733920a34.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 01:24:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778833440; cv=none;
 d=google.com; s=arc-20240605;
 b=CNl1CFdx7+KQZGMYMgLqPRBu71vXBZCLfqaDowv9BvlpfxllH/g4yJB5Ug1H2pc7CX
 P3fZpLchLKdz4f6d3/x834l+MdV0yO0clnqjfVccJNlc2wRIxW1JbxdAT/Kru3aAmOHP
 cnX8r6Tm6kbrR8gH2UideSjdCYMBZ0sD1i3+tZ9XVaBG/Ob1iAnNnU9cpy+tFGPezoVi
 5SQf7DszHxg06b7yR+vpm9DVlxVU5UGyQ1IMbsiN8DV7si8Sg4QuTywUu/yZ4Yf4YbzN
 EwFJCzXF0BymVFoFaFiSnNMB8zhtpu7Z7Vq3zVXxZDBKGEnIY2RMnhfsbtNyQoVpsyLB
 6ADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6f5NQ782CfRPqjXPpWcXY2bcE8L09VlQ5vkm9DDRdRc=;
 fh=On/p5S40i1zl0q6p7pBUh7zlBBbykzJVdqc2xVCFgFQ=;
 b=GkUKGMjTE5ZAIJjOZkRxP3aQxWTEyVrmCulcSL4bIB81bT9JrAER22CqsxWw+p4RmP
 sovjBjkQjX3CjVnBRtQweuvqbl9YY3PvqLyid8hWKrBa0qcnR0+5ULXgjByZfnzUOugn
 ZKyy7qE3Og+xKeSxycvqS6qwza3rtx/s/g3Tao1YCFeJJb3tHER5DJ//+ccttgjuE6va
 qLqf6KWRk0JBJpT54lqp0fGnaxJ0FgDtH+PUZQVZBVm986K3FH0UN7bu56IeeWxsrdN8
 QrlhhHFjVVDuuoEjGw0kEmxXgmGl/g6LPs/XXhAnJfH+Ev+NPg7BP6/luONH0Eh/hyxo
 P09g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778833440; x=1779438240; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6f5NQ782CfRPqjXPpWcXY2bcE8L09VlQ5vkm9DDRdRc=;
 b=UCmpAncw6JxspcW/6QSKEZ7l2K+MgThDIAYk7Ohf3o13w6mqrEed/7+fZd3JfbRQKa
 eHZtgfLor6b0JlXmMDxje5A0ZBQZ2CghZ4m9JhT22cq0T1JRPj2UD3uJD0lKoYhpHRHf
 SEI20I++sBj7RNyUY9ogzAFlo6U+Y6a7w6e0lt7Hl3Pbu6jQv2QAxhXTl7MwCeq5wbqO
 /obzAuDVnVNwopOmXEtF5EML7eUijiw/QUne/4ejyi8VyDttIbEX54x4mQJRpGgbsUpO
 rgC8X+nfqkc/4KyUb0EA+1WAc30wPHfqrHVD+Q3Vk+2XauUMdict4yZ3m8QWHLmeJPDB
 c72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778833440; x=1779438240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6f5NQ782CfRPqjXPpWcXY2bcE8L09VlQ5vkm9DDRdRc=;
 b=sjmTgFBn3jn1gYJVam8EnRFwbbdlL39MCKQqvDlLq0NQfJ9nvCAPHNYjIloA4Gv9+Z
 8097xnkR5fv78pnZEU5P3zR3OPXpAOjhVtc2UVFyT1PDDL+7/4/ym+OqUtSTA1zVDukn
 4BLQZO6FQ1FioOUNzz85GP9JTPrcCRSarr0yQMNJQrpvM94jcKrUrfFqOgDU7Q/N92/F
 lqf5h2uKPbhoevC02u5fMAj/viLFKgQPRRe+84PLleEw0Nv3qz++/1wOUmlomwEDx6sE
 N9aPaS/Cduda+FqN8fqqUyNL9uPoK76i9aVi3nww+JeWK9sFOWrzuBKaWI0HfEW648h5
 tz4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DMMPRpi87pybQHYgPlz//UnJKKmJ83dsXvz7NzRcgwa3UeMcnkD27RbaRmt35ovlMbznpMp8=@lists.denx.de
X-Gm-Message-State: AOJu0YymH+tDZmH7CpSLRUZp/TeBrqIs/THSJW47MDaKA2c4YZ+uj2NX
 4ydj7d51MT0SvFDTwPvdC12b8VAuYEFDckME/wdBu5A0XGLMPCzQNVmsrpXDBhEINGQMKw3vxib
 P7Q/PEVFIw3MaRAWA/v0jkLQC91FAxnI=
X-Gm-Gg: Acq92OFWZxvbqZmUFcbskBk1puGPpClSGzlY7WmFEgFZafe4+GrXsw2AsPlNIjYLGeN
 YQnE+AG6OioXKOymd7QHBYD6hwMBqqpFJ0LqWgaKQEcvhOtTzAFm8Nt7Clwpgvgvlilqlg99ZgH
 rG57kuj7S2BxOhFtBwVQ5R/sDLhsXukE0iPNH6iJIT92kgwnhePnqkZLzNbLW/mub8XEJ3ktfyM
 UTw6zCthNIuBEa6aZnE1OM4kE3mN3TwsEjozcUYIzj+WLiGsZ5OA/PxIJdIvWOOC+4d4zQ8vuaz
 nych/Suf
X-Received: by 2002:a05:6830:67cf:b0:7dc:4947:36a1 with SMTP id
 46e09a7af769-7e4f2b3b650mr1829144a34.12.1778833440568; Fri, 15 May 2026
 01:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <CALeDE9PU0-fW_+erR9QHK1ST8fcStx0FWWk_0M8ELjtADugd7Q@mail.gmail.com>
 <CAN7C2SCATJL_rhpBZWwZuQVpLdnbDh5+DRFbtGHoxCXu62AVmw@mail.gmail.com>
 <CALeDE9PesKLwzt=uu_b8+pq5QXFnnK1YAO9WL3f8=CHx93w61w@mail.gmail.com>
 <CAN7C2SC_YwotE2-PS=eAFEnMOXp7jVrhaOSbKsuChLVr4zEa8A@mail.gmail.com>
 <20260514-spotted-happier-0ccb77ca8f24@spud>
 <CAN7C2SAVWp23mKeG77MoV6kUKQDBN_Ge3CUMa_quAXP5YbV6UA@mail.gmail.com>
 <20260515-finished-womanly-675afb9b0c7c@wendy>
In-Reply-To: <20260515-finished-womanly-675afb9b0c7c@wendy>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 15 May 2026 16:23:49 +0800
X-Gm-Features: AVHnY4IYFgxuiFHKqr5bUhpVsSqI3wdLjVTQqbbU6vLvst9jKzCYn9Opmw__aI8
Message-ID: <CAN7C2SDDjM+MJbx2d0N8zC74bytb6gKvjw_6auMPLLNGJVwvfA@mail.gmail.com>
Subject: Re: U-Boot patch submit standard and requirement
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, May 15, 2026 at 3:46=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Fri, May 15, 2026 at 08:46:25AM +0800, Sune Brian wrote:
> > On Fri, May 15, 2026 at 12:14=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Thu, May 14, 2026 at 07:46:46PM +0800, Sune Brian wrote:
> > > > On Thu, May 14, 2026 at 6:37=E2=80=AFPM Peter Robinson <pbrobinson@=
gmail.com> wrote:
> > > > >
> > > > > Hi Brian,
> > > > >
> > > > > You have made a very generic statement about levels of accountabi=
lity
> > > > > on patch sets and consistency in reviews.
> > > > >
> > > > > Can you be more specific?
> > > > >
> > > > > Ultimately there are subsystem maintainers and each maintainer ha=
s
> > > > > variation on how they deal with their subsystem. You reference on=
e doc
> > > > > three times in your statement.
> > > >
> > > > Hi Peter,
> > > >
> > > > Now I understand what you mean.
> > > > Simply one sentence is a bit hard to read what your thoughts are.
> > > >
> > > > That document I am quoting does not refer to the entire docs but on=
ly one
> > > > section of the docs with that link.
> > > >
> > > > Before quoting, my declarations as follows:
> > > > 1) I am not referring to specific people or party
> > > > 2) I experienced reviewer which again not being specific to one tha=
t
> > > > mentioned this docs is a supreme rules to follow otherwise patch
> > > > that is committed is not able to push to mainstream
> > > > 3) I simply do a quick check on u-boot mailing pool and do see a lo=
t
> > > > of uncompiled reviewed patches that are not following that supreme
> > > > docs.
> > > >
> > > > As such I will being to quote:
> > > >
> > > > The mailing that are reported as not passing the standard of [1]
> > > > Full mailing:
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.348=
0-1-briansune@gmail.com/#3684415
> > >
> > > patchwork isn't loading for me, but it's on lore here:
> > > https://lore.kernel.org/all/20260423042824.3480-1-briansune@gmail.com=
/
> > >
> >
> > Hi Dooley,
> >
> > Well I am sure you did not have the full picture.
> >
> > The request had nothing to do with under the --- line if this is
> > really the case:
>
> > Let me bring you back to the history of wonders:
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.73491-1=
-briansune@gmail.com/#3680232
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20260422065910.5398-1-=
briansune@gmail.com/
> >
> > None of those reviewers had mentioned this issue once "---" rather they=
 all
> > just alarmingly repeated the wordings.
>
> The first mail in the thread mentions it:
> https://lore.kernel.org/all/CAFLszThg=3DEamyRohxNA7V+nk+OMVK356nUjAVSbu4+=
kokOJpdA@mail.gmail.com/
>
> >
> > > The comment about the changelog format seems to be very harsh, I doub=
t
> > > it really makes any difference. What you did and what the maintainer
> > > requested are effectively the same thing at the end of the day.
> > >
> >
> > Of course after reading the docs I got it immediately.
> > However did those who request contributors quote this from first place?
> >
> > > The real problem with your patch is that you put the changelog into t=
he
> > > commit message itself, rather than under the --- line.
> > > None of the examples you quote below do that.
> > >
> >
> > Well after 4 patches of ridiculous request and logic change.
> > I guess you will do the same. At least I am not doing it at the
> > first moment on replying to the mails who or whom you had mentioned.
>
> I think this is a reply to the comment below?
> The aggressive/antagonistic responses begin in your first reply to
> Simon:
> https://lore.kernel.org/all/CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjNwsHA=
hdmY3Q@mail.gmail.com/
> "So forgive me I really don't give a damn on whatever the header
> requirements." "There are many better things to do rather than complainin=
g
> about the patch headers."

Hi Dooley,

You are a bit off topic here sorry if you don't think this is the case but
please do finish reading.

For what the accused I will give out specific mailing dialogs to explain
[HERE].

The major discussion or query is all about the standards or rules.
There is nothing to do with the reply.

Meantime, I cannot see this as "aggressive/antagonistic responses".
When the request changes it is ridiculous as you also agree:
The header text /  wordings from the updated patch itself
had zero impact on the patch itself.

You are just simply telling me that if you get hit by someone 4 times,
the man who stands out and responds is "aggressive/antagonistic".

Again we are NOT discussing any mailing dialogs but the U-Boot
patch header standards and rules.

Meantime you had failed to respond or comment the entire mailing
dialogs do mention any "---" header requirements nor the
necessaries of following docs supreme rule / standard from first place.

[HERE]
Allow me to quote the request of header and modifications mail history:

No docs cited nor clearly mentioned the need of specific wordings:
https://patchwork.ozlabs.org/project/uboot/patch/20260420074601.24988-1-bri=
ansune@gmail.com/#3680096

No docs cited nor clearly mentioned the need of specific wordings:
https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.73491-1-bri=
ansune@gmail.com/#3680232

So now you are telling me after at least 2 versions of modifications
reviewers suddenly think oh this is not good enough (by my rules)
I think it should be other styles etc.

Now "LOOK INTO MY EYES" and tell me what is the actual U-Boot
header standard? Reviewer mood or docs that are given out?

Regards,
Brian

>
> > > Also, your responses to Simon in the thread you link are very
> > > aggressive and antagonistic. Please try to be kinder to those that ta=
ke
> > > time to review your submissions.
> > >
