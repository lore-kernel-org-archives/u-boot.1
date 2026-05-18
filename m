Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6CDCD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8269846AE;
	Tue, 19 May 2026 00:05:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e9SG/c0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3218F846B0; Tue, 19 May 2026 00:05:19 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3B38469F
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dcd689829eso2474425a34.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779141915; cv=none;
 d=google.com; s=arc-20240605;
 b=YGM37mw9vLowUqbO5/HzeUfwjxnX0KZ8yEbZRfY18pCA/GaTx0hcW3ASrDzs/9NsYL
 KRVB3mizUwjpkrbF+a2n7Xy058OOGbOIQZ/4nNIIeNA7t2RJneDjAoMsNIqNB0XuxKNj
 6yF7DKfmvOd6gyD7woj4tyHhQoYgGkU1Po7gNppxWcfzX0lLU/dYUMhBpp4NsY+i5c/5
 42rfL7dmLzcwcNMCwoBCaRHb4ft6CIcvz0ExLZSwNbl8ZD0TFrMLQTaaynO7+l/0vCJZ
 H/W8qnvv0/Bm2E60o2/OQJNXNtA9CGK5rY6wCcejFAu+YKhzmqabyMAz1eyn/KDtE9sN
 P8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PUOjZ5hmM3NEemSfPbkLXPHUecSForQrgAdveZbxq2A=;
 fh=RX93IlWfjxJ9N6jgCIPvb9zIApoOcY8FpzckTc7x648=;
 b=EE7/QThB7RsmpxiWnv8R+jN+p8b1591s6Z3WKPRdjZiXxdNzLrDcNlAZ+wzfq3S408
 fBOQ9C/6ajVK+e520XVXXyRqFYwp7948fMIDGt1prvZnYzC7iGCFo2Tx09lE3kY/dQa6
 jQN+QgsVcabInfmB+MQ9z+jVCeigWNoF24wYmcl5ml1WvcEpfCf8wtIV+TATIeFggGiI
 A0wlPyBq+ZlmFb69kK6v8C4FFHyqcG90EQrA3wnHn2PeZXm/cHjagRAwFeX5wvCVidqs
 LyrDmLJX3kDT9NZ4eqZjDWnWZRkpdft9c3I2BaR9suOVzDbxsVg4/U8O1xLeK+htnTKk
 /txQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779141915; x=1779746715; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUOjZ5hmM3NEemSfPbkLXPHUecSForQrgAdveZbxq2A=;
 b=e9SG/c0nE4R2S+n3cpLoRGgWt2KlGhLQobQKYLCnKQYl1wCmvJCYqSqy1PcQFKJ9S+
 sCUYiIpcPlIaf93uhZTSfrIiZYbYc7HhswpvQ4IYdjO1ihgb3Rvl1Ne3p5vq4MGF0Av6
 xUTTCBXqrA9D7bDjP7inxP5aE27+ZipR4ExFxBuZdxlX5I9kXYIG4kYJ4sowJwm12DrG
 sDU0FlZGL2N3l/CSx06TDvYFHjM6TKMFcsTAg5ZX3lI1Ysa9UJ1psJtlL7IlOnv2e0gX
 kLvH/+qsCvKx4SyIrv6l/ccf3t/oCT/re6NTz8ahjV6AqAvXJY0zR2UV/8u35tObL2qB
 zbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779141915; x=1779746715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PUOjZ5hmM3NEemSfPbkLXPHUecSForQrgAdveZbxq2A=;
 b=e0biotXiI4S/bnS/4QN/+5EWoVzrS+kLiWMXxx7sDuUK/P7QrAX673mZVjZbdGSTUu
 oID47kswy9ETUOSx83F9bMPmrFpti3YsaCFoTLDEpSOGfyS89r83sdORWz3bNhZLG5UI
 Hqwqyio0PLCJg30ph0wkh2AUlklniJEojpeW6ZlUcCWVUyUlZKKJs9cLchjCnnbGVSDw
 gNQd0TW/5sAouIgztQUWiuxhOHVdKrCZ+x+qAOVoebwbG68o2cNVrRDmKjsjHFNHQeTx
 Xh8qiVow+amwh8q6+MUAlNNJ4YEedT27fUiJyNLB44Yzzz+ojT8eTXNH8xsRT6rYwOyB
 0SWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8eIc90XJuv06ohsylIcjxLN0tnG0K55zABtlqkqdWaNTR6TLgeUIo9aT/Kd8QnE9Q4+1vjXDk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxr3DaD2iqQJBPKZu//P+Pt7ZVxazcCPB51gG/z4Uwvfjpp98sQ
 SLj6WwXzHtmCi+NRfJfsc79D5wWkD7zgMb9TVDkGnVOgMKx5O27MzCKnL49e2Me6yKmPJ2tkPfN
 JAD0tRstZpL6587XWmQy8nCW3/m65mll4BofytVg=
X-Gm-Gg: Acq92OF/gIk1NcjopJ482ip+MjttboZJh2XmBYCCwVYmOuDpTxOTJZND0Q0UikoEUeU
 8WSgE8Dio+KezHT3YKBuNNaOJtjVUBHFLb2tP1a4St7HGsQ1owYPHhEbQWchNkT90BwRDUaZJld
 YDPqG9+nStCEIMwZcqYb13KcjaI4g+D2CFioTJnijWCAVBcXB/vFNduD0QmWtlfQewL3D8KNcpY
 8mCV1choikePgegf9ZOkzq9WiuVfUUN7mMAMqMfBMNurZ0YGfiqABx2KUpQDJXDEUYz646U4CaQ
 zlJVTkU=
X-Received: by 2002:a05:6830:4118:b0:7d7:e57a:bcd with SMTP id
 46e09a7af769-7e4f2bb64ccmr11000998a34.20.1779141915083; Mon, 18 May 2026
 15:05:15 -0700 (PDT)
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
In-Reply-To: <1207964a-67cb-4882-ac49-be40e577a5dd@linaro.org>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 19 May 2026 06:05:02 +0800
X-Gm-Features: AVHnY4J8XBnQ4buEkSPyJ8elVgsX96fJb1lW03G5wYV5j6ZpRKatS0zUGVzk0Qk
Message-ID: <CAN7C2SDGejA8XH57NUhp1x2KEHoWx7atay7xx1KA9GhqhcpH9g@mail.gmail.com>
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

On Tue, May 19, 2026 at 3:17=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 5/16/26 01:11, Sune Brian wrote:
> > On Fri, May 15, 2026 at 11:02=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> >>
> >> On Fri, May 15, 2026 at 04:23:49PM +0800, Sune Brian wrote:
> >>> On Fri, May 15, 2026 at 3:46=E2=80=AFPM Conor Dooley <conor.dooley@mi=
crochip.com> wrote:
> >>>>
> >>>> On Fri, May 15, 2026 at 08:46:25AM +0800, Sune Brian wrote:
> >>>>> On Fri, May 15, 2026 at 12:14=E2=80=AFAM Conor Dooley <conor@kernel=
.org> wrote:
> >>>>>>
> >>>>>> On Thu, May 14, 2026 at 07:46:46PM +0800, Sune Brian wrote:
> >>>>>>> On Thu, May 14, 2026 at 6:37=E2=80=AFPM Peter Robinson <pbrobinso=
n@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> Hi Brian,
> >>>>>>>>
> >>>>>>>> You have made a very generic statement about levels of accountab=
ility
> >>>>>>>> on patch sets and consistency in reviews.
> >>>>>>>>
> >>>>>>>> Can you be more specific?
> >>>>>>>>
> >>>>>>>> Ultimately there are subsystem maintainers and each maintainer h=
as
> >>>>>>>> variation on how they deal with their subsystem. You reference o=
ne doc
> >>>>>>>> three times in your statement.
> >>>>>>>
> >>>>>>> Hi Peter,
> >>>>>>>
> >>>>>>> Now I understand what you mean.
> >>>>>>> Simply one sentence is a bit hard to read what your thoughts are.
> >>>>>>>
> >>>>>>> That document I am quoting does not refer to the entire docs but =
only one
> >>>>>>> section of the docs with that link.
> >>>>>>>
> >>>>>>> Before quoting, my declarations as follows:
> >>>>>>> 1) I am not referring to specific people or party
> >>>>>>> 2) I experienced reviewer which again not being specific to one t=
hat
> >>>>>>> mentioned this docs is a supreme rules to follow otherwise patch
> >>>>>>> that is committed is not able to push to mainstream
> >>>>>>> 3) I simply do a quick check on u-boot mailing pool and do see a =
lot
> >>>>>>> of uncompiled reviewed patches that are not following that suprem=
e
> >>>>>>> docs.
> >>>>>>>
> >>>>>>> As such I will being to quote:
> >>>>>>>
> >>>>>>> The mailing that are reported as not passing the standard of [1]
> >>>>>>> Full mailing:
> >>>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3=
480-1-briansune@gmail.com/#3684415
> >>>>>>
> >>>>>> patchwork isn't loading for me, but it's on lore here:
> >>>>>> https://lore.kernel.org/all/20260423042824.3480-1-briansune@gmail.=
com/
> >>>>>>
> >>>>>
> >>>>> Hi Dooley,
> >>>>>
> >>>>> Well I am sure you did not have the full picture.
> >>>>>
> >>>>> The request had nothing to do with under the --- line if this is
> >>>>> really the case:
> >>>>
> >>>>> Let me bring you back to the history of wonders:
> >>>>>
> >>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.734=
91-1-briansune@gmail.com/#3680232
> >>>>>
> >>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260422065910.539=
8-1-briansune@gmail.com/
> >>>>>
> >>>>> None of those reviewers had mentioned this issue once "---" rather =
they all
> >>>>> just alarmingly repeated the wordings.
> >>>>
> >>>> The first mail in the thread mentions it:
> >>>> https://lore.kernel.org/all/CAFLszThg=3DEamyRohxNA7V+nk+OMVK356nUjAV=
Sbu4+kokOJpdA@mail.gmail.com/
> >>>>
> >>>>>
> >>>>>> The comment about the changelog format seems to be very harsh, I d=
oubt
> >>>>>> it really makes any difference. What you did and what the maintain=
er
> >>>>>> requested are effectively the same thing at the end of the day.
> >>>>>>
> >>>>>
> >>>>> Of course after reading the docs I got it immediately.
> >>>>> However did those who request contributors quote this from first pl=
ace?
> >>>>>
> >>>>>> The real problem with your patch is that you put the changelog int=
o the
> >>>>>> commit message itself, rather than under the --- line.
> >>>>>> None of the examples you quote below do that.
> >>>>>>
> >>>>>
> >>>>> Well after 4 patches of ridiculous request and logic change.
> >>>>> I guess you will do the same. At least I am not doing it at the
> >>>>> first moment on replying to the mails who or whom you had mentioned=
.
> >>>>
> >>>> I think this is a reply to the comment below?
> >>>> The aggressive/antagonistic responses begin in your first reply to
> >>>> Simon:
> >>>> https://lore.kernel.org/all/CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJj=
NwsHAhdmY3Q@mail.gmail.com/
> >>>> "So forgive me I really don't give a damn on whatever the header
> >>>> requirements." "There are many better things to do rather than compl=
aining
> >>>> about the patch headers."
> >>>
> >>> Hi Dooley,
> >>>
> >>> You are a bit off topic here sorry if you don't think this is the cas=
e but
> >>> please do finish reading.
> >>>
> >>> For what the accused I will give out specific mailing dialogs to expl=
ain
> >>> [HERE].
> >>>
> >>> The major discussion or query is all about the standards or rules.
> >>> There is nothing to do with the reply.
> >>>
> >>> Meantime, I cannot see this as "aggressive/antagonistic responses".
> >>> When the request changes it is ridiculous as you also agree:
> >>> The header text /  wordings from the updated patch itself
> >>> had zero impact on the patch itself.
> >>>
> >>> You are just simply telling me that if you get hit by someone 4 times=
,
> >>> the man who stands out and responds is "aggressive/antagonistic".
> >>>
> >>> Again we are NOT discussing any mailing dialogs but the U-Boot
> >>> patch header standards and rules.
> >>>
> >>> Meantime you had failed to respond or comment the entire mailing
> >>> dialogs do mention any "---" header requirements nor the
> >>> necessaries of following docs supreme rule / standard from first plac=
e.
> >>>
> >>> [HERE]
> >>> Allow me to quote the request of header and modifications mail histor=
y:
> >>>
> >>> No docs cited nor clearly mentioned the need of specific wordings:
> >>> https://patchwork.ozlabs.org/project/uboot/patch/20260420074601.24988=
-1-briansune@gmail.com/#3680096
> >>>
> >>> No docs cited nor clearly mentioned the need of specific wordings:
> >>> https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.73491=
-1-briansune@gmail.com/#3680232
> >>>
> >>> So now you are telling me after at least 2 versions of modifications
> >>> reviewers suddenly think oh this is not good enough (by my rules)
> >>> I think it should be other styles etc.
> >>>
> >>> Now "LOOK INTO MY EYES" and tell me what is the actual U-Boot
> >>> header standard? Reviewer mood or docs that are given out?
> >>
> >> Brain, I understand being frustrated with the process. Ultimately,
> >> everyone here is a volunteer and trying their best. Which means that
> >> yes, we are not entirely consistent about some parts of the review
> >> process. I would ask you to please be kind to everyone, and expect bei=
ng
> >> kind in return.
> >
> > Hi Tom,
> >
> > Sorry for the additional reply:
> > First I need to apologize that I am also blinded by emotion and
> > off-topic.
> >
> > Back to the topic:
> >
> > Patch header standard is not consistent so docs is not a
> > supreme standard or supreme rules on the commit changes vN.
>
> The base rule for U-Boot is right as the beginning of the doc page:
> ```
> A good introduction how to prepare for submitting patches can be found in=
 the LWN article How to Get Your Change Into the Linux Kernel as the same r=
ules apply to U-Boot, too.
> ```
>
> But as the scope of U-Boot is very different and the account of people wo=
rking
> on the project is significantly lower, so the actual review/maintainance =
allowance
> is less strict.
>
> >
> > Based on the above response we should conclude one fact!
> >
> > In those mailing pools that are citations or quotations;
> > responses or changes requested have no inherent issue
> > to pass and accept.
> > The changes requested on very specific wordings are
> > unreasonable.
> >
> > Of course Dooley had mentioned the request of after "---"
> > placement however again based on this reply it should also not
> > an issue to push to master.
> >
> > Again basically speaking the entire change request or requirement
> > is not a must nor really needed in the first place.
> >
> > I hope this should provide a very good baseline to contributors
> > and reviewers how they should review and create patches / commits.
>

Hi Neil,

> The baseline is clear since most of the U-Boot developers, reviewers
> and maintainers are experiences Linux developers as-well.

Are you sure?
If so, why do I clearly see the double standard?
And why Dooley would clearly mentioned doubt on the specific wordings
making any difference.

Again without the double or multiple standards placed on the table
and teasing with ridiculous changes requested due to specific wordings:
why is it required to raise the tone from first place?

Reading specific dialogs is not going to understand the full picture.
I also doubt you do read the context before reply or comment.

Meantime you are off topic on the citation of context [1] in this mail.
My question here is pointing out double or multiple standards on specific
wordings.

Thanks,
Brian

>
> And as an extent, other rules does apply informally to U-Boot like
> any other Open Source project ran by volunteers, please have a look at:
> https://docs.kernel.org/process/code-of-conduct.html
>
> I'll cite the following behaviors that any Open Source project would like
> to have as basic rules of communication:
> - Using welcoming and inclusive language
> - Being respectful of differing viewpoints and experiences
> - Gracefully accepting constructive criticism
> - Focusing on what is best for the community
> - Showing empathy towards other community members
>
> I did review the communication between You and Simon, and this exact thre=
ad,
> and your replies are not acceptable, and I'll ask you to reconsider your =
tone.
>
> Thanks,
> Neil
>
> >
> > Thanks,
> > Brian
> >
> >>
> >> --
> >> Tom
>
