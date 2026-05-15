Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33461CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 22:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A026C84885;
	Sat, 16 May 2026 00:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lE/eFWt6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B06184886; Sat, 16 May 2026 00:30:20 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA6DF84713
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7de7dc85b74so402846a34.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:30:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778884216; cv=none;
 d=google.com; s=arc-20240605;
 b=l1qnaq0Gk0LZUPCJ20kCFtNnSGqqRTNMVdBmMWJqYazSMiJvds81N4dvtZx0EgQCDw
 j3nFr0Nciq9GyGWHZDHec0OKpWQG2VPpd6ndg8ZEdoCdXUrS0QRSQLv8w1+48AzQOgTr
 tmal3b+KFwLHcIT7J+EdkPmnTopITsjZPO0mIizV0falsQfWk2kNa0OyA95mjPRWc7VD
 FcY8Dee0SodLWPeXGk6zheYeJMatzgd7qq35RpWnU9zxtmY5sVQnnFTLteTaVDqT+mRO
 8WtFN7+Va7nSlkkYkWIKf17vb3ORgwOXFycc/tbZUpbZpf0FBv8nhLNWPAZY0SVmKmeg
 0eyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1BhdUj9o+n5cPW2shIA2Uf2aEf/j4yk1bvXjx5/Bxrw=;
 fh=uC4KV75ls8UXUqv4fxi5COunsPsfv7YgqIasgzsVA7s=;
 b=UGrtj9bFPGJcpedQm10rJH3Wr2EqzNyVAwjvfCtEAMe0Ny2uz3+zhUK+uGaw+e/3dZ
 C79qwPwlZsOn/vyPaRdI80iNgv3xwzTRvdn7udiEyENPmOCYwDWoajofnWxDsF06rz/F
 8tb7YfMzXwJfddBzmGqSal+uSgeR30KsA1dMFMSmiLam47/hhms20p8IgKJalZvm6Npr
 tz80F9KH0DynWppElzb+LAK9EPXp6Z3Z6bk7cFVr1/WLjPxffJgbB6u/V1s9jKxAavDW
 GzhUBz8a8477JoenvQaGVP6I+EOC0T1SpGA2BmV6pQ/dXQCNx2g8x3jrIl7hEx/rPUOF
 LWyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778884216; x=1779489016; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BhdUj9o+n5cPW2shIA2Uf2aEf/j4yk1bvXjx5/Bxrw=;
 b=lE/eFWt6Spee6UUyv+LZjiodCZhAGkIuU89z1sLBKYFrCP0Dq+Yqst/ZSwplAOy4aN
 Xr+ZXb2mtCvPLgNj8ZHeEdtxUjCIg8oTvs4NBcZplpng7Y63LAlsaSsf7nqLAguIUZXb
 6DkHX4Ay4XZT36D3OtQwC4wxk1szcB9fHH8Rp6+hUzgE8kMlSPBS2vWQz51c+2V10TSH
 1ZFmy0kNfpwvPi6hLMMaq2SZMLHZxPjUV/ipq2i/61J7s9F5RZ9QKlNoArb9EamH/esq
 yoMM16UR+Q7Phx2IBRJ5fyl5S3FCsyBiZ+XL8NMg/p0baIHCM0llaIy5P1nbDXvVKRMi
 lzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778884216; x=1779489016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1BhdUj9o+n5cPW2shIA2Uf2aEf/j4yk1bvXjx5/Bxrw=;
 b=nk/flhZj2tnOUMEHG+aLUjtpJPbXrtNVuF0XUJZtK6gR4Id8rVAGHwGr2j1wXA6SYd
 gLcPEed6omNjh/beBiaMnOD7MESopmyQ2lmphcL9mkdm6qImgWkCEA8iWxRyxyFz4mq1
 imfIJwdWrt7lpAB5zhNZ3Zw8nAKZYOd+AxVyDNBxWIi7YFHYCiAddy33Dsc1E3CFEd2T
 CBiv0ypkdZMaYOeKhWKrelgcNr0/qo0dCU059C6e3mfeYMWmvNGdgfKGQCybVork5n6k
 ZGewIVqiwBTGNycU/dFYYNyjFHOghPY5tuDB2NeKuj929rDyXiD1q5BBEXErAbABb472
 dk3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/atOqNDxx8dslxMI731SQOknSnvQ+bgXTA0RMfx870ndBMdPQ23U9zlvRfxaqZQj4gi6gVD8E=@lists.denx.de
X-Gm-Message-State: AOJu0YxG3ELqnWQK/bi/22bco943VoYTJmbVBMp7DpdKAl1/FpP4ZqAM
 6U4HS6oVYOotY0HFJvbjP7XFLuTDCDyTi0/++QQul0qFaUNdpZIA2pSQ0cabmOYLBBFVmgBLzM8
 0llECWTzz/YxQ5eJTxMtuD7Gp8MM69gE=
X-Gm-Gg: Acq92OFeIIZXFtTds1WCGO2eNxJ3f6OJBsq8fjC/NQty85TYTEvfLf3Km4DDetCORyO
 nQZWlUv+tQULuaF/SL8rJDPAsmYSUnaIf5fiD80/NrBAhCVdPIl1tWb+FwlLkXQbmasDDkSTe4o
 2atwXhNZyqFMW0whrhxSJmsYhZB013c1UTKdRmM41H3v+hmdKX36lkceDMZeqpEs3kdqsTemy2f
 Z3j1MyQVcdgrL5eJD7ofx3K1GHKbZ564vs0s3gIIHSqr2mSuAjrT/tMPtlBMl3msRpteY9RBwmV
 D70gmShKSj8Bwy97CA==
X-Received: by 2002:a05:6830:6d0c:b0:7dc:cd0b:58ba with SMTP id
 46e09a7af769-7e4ea028c78mr4165607a34.4.1778884216223; Fri, 15 May 2026
 15:30:16 -0700 (PDT)
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
Date: Sat, 16 May 2026 06:30:04 +0800
X-Gm-Features: AVHnY4LXMo3xcRVqyry6lgevE6cjQvI8GVAfc0diq7AsTnouQUeM_Ed5ph2yijs
Message-ID: <CAN7C2SCfhWttCAUBwwzPvj078fDRdUvM01Xj2tryXCCPLYbcrg@mail.gmail.com>
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

First  appreciate the reply.

Of course being kind and expecting the same returns is fair and even.
However, being kind and returning with teasing on the requirements
considered as appropriate action?

Then simply charge the teased unit or units with unkind behavior?
Again I had given out rooms and kindnesses from first place, however the
return is not as even as you had described.
Of course you can 100% recap it as me who shows unkindness on
the table by "verbally".
Without the double standards or even multi standards are being
shown on the table, why do I act unkindly in the first place?

Simple logic:

for(int i=3D0;i<standards;i++){
kind =3D ture;
if(reviewers_mood =3D=3D you_shall_not_pass)
return teasing_func();
}

void teasing_func(void){
int bottom_line =3D false;
while(1){
bottom_line  =3D infinite_sta_bottom_line_trigger();
if(bottom_line){
kind =3D false;
return done_with_you();
}
}
}

Fair enough =3D]

Cheers,
Brian

>
> --
> Tom
