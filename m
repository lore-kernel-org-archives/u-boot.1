Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBB8CD4F39
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 00:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 121B884671;
	Fri, 15 May 2026 02:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bInQe8Ax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B253D84676; Fri, 15 May 2026 02:46:37 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F9F9836AC
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 02:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-479aa2dbea2so3760560b6e.0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 17:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778805994; cv=none;
 d=google.com; s=arc-20240605;
 b=CxKgcU0LZVglXcELl25ohvZEkFZNO5zrEu/JD2igCBf8wdzuzjZQvUUPyyIw3ns3Zv
 gD4z0X6RBtYruLyR7vtSLAmX6ohQKurFijlL3dDaaUO5Q0Pd3rnLMyswRvRQ+USpMmnl
 EYH6Arb9m5e/+Jbtm1IdBNSTd/hj2m/X8q7nl56Mixu9UY60IiyJ4xRWT0VBLdI2tkrc
 La9SFDWB8S2eTnVeh2aHN1GsCw1UOk8DtqK68NZGHlasyhZND7vlQMRvftC+kHURXWvo
 c/wx2Gy7GmagQ+cmBqTclifDjc8IcUdplpR7QH7THzKcMeQysVqEU0V33xZ20iUTaD7F
 6MZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jKp098lpvpHDAQf7Zz/09PLD13pfyekS6g8gbIg+hd4=;
 fh=RqRCtJ1kBghELp2W4GFVUm6WEit4LD84SAwsVzeWs6s=;
 b=hlJTbwM7y4pb/uthl352OdFtNUUSzsBci4JWy39vuujEjuCD4DKpe0HkejGoPdbIyo
 8Yp14QUl+h71Q3GmItghn2qFSi3ta+XLjcbVHARUM6Ut3KG9XyUc5FM4Eli1Br/baZ52
 EaejOuLNeqy4ViUR7F7dvdtJdKmAwRYelw17Mp/Ad+Naq9XMUZ1vkx3SYdqIlw7DnqSH
 FLmCY33PI4cAYJXOxnnt3QSuzazmQWoHKFCTMv1JSyU+eGzwQEo584lSs+eZr+3uKEPM
 ZTlWzUqtXlGLmUyA1ckiSTh0/bQvnbvZjbEqubDVFTFo5x76BszqiNE3ZKmHZpwxBEJQ
 cKtg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778805994; x=1779410794; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKp098lpvpHDAQf7Zz/09PLD13pfyekS6g8gbIg+hd4=;
 b=bInQe8AxbT9/Fs7fYsYa8qfl6mBdLhy9AsKyvRitMX06gaFA7K2vJm0qm18thyxo7G
 RY9/WhGGa2CWmOa/SczImIfajzRwYUF68e5Ous8sYmw8XdASbBLCHHH91sGQR6ZU//rB
 R+etz0NYXukh0a4x+fSAs4rrpwmdOd7tAHVc6ll68lFABlXkff+AMp23Cw/LGMGjkWEY
 XqeUspGdTb8aX6WT6p9cfZNZ934S5MtRHJ4e3GO7VVpE7Rclz88QScmGG8gDtCWHaRwE
 uCRMvxka/SyQ5lTCJd7WrrLo+s/Mt1S87LBw7POglKQeKQYtY12ydCK5D2mqg3qr0uEW
 93Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778805994; x=1779410794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jKp098lpvpHDAQf7Zz/09PLD13pfyekS6g8gbIg+hd4=;
 b=Jn/XlTm+1AgTf73q35ZWl3dlkdmqqFV0YbVs2603lZGVi85PSjRByDQZpoRxUPRoEv
 KH9PfMTcq16RHIpMDViia64WxM/VqB7npgCN/18PQNZafxunQH5BuxZEJo6ua/7GrC/D
 4T4eaczkU5v7JKJLFLoBDix4a7THX8EMbJBuB1DYwSorJssu/dpWtltBDOCRq5REzelM
 ygl7TvELMlDLGbW2bSMxnESTjJo7Dwt1b30Jdbzmu19/wZkAyrAubylwgCQAtJIRmcdL
 H12QPqgymGVWgcfZ/6+hZ0eN/EC/k2uDPeV0y9moXPXJ/9YZ6DFo6AbsuTwDYB1Ptx0c
 GvFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SFh0mr68KxSa3VpMbinIUNhJxv26FxzXLHvdlu8Kp78Wy0EH7QBJGQPGdS63bRL/bvSPegp4=@lists.denx.de
X-Gm-Message-State: AOJu0YyAC/xmlCrPzZEMWNbA+8J3LuhJbRXtXnbHDtjKatllK9eMBLXc
 6B5Y02wZCiuckXd1oiSqVRbD8cmxIde+7TyEUfjyQOkXl+tvZtDYJrofxJjkJWLsBQ5Wq/ndYf9
 /+VPXLFFOzj2s9vCEH7pZBMPGttBWnCQ=
X-Gm-Gg: Acq92OFvB1oRkrMif0q0iKfbGxQVlDXZrGeJlzMQ8BSs5DNjevL9v/BEjjmhAALZa+W
 xCPlFz4147z2ueh41oxHupyYuOGmCrwT35LbXHzcmU4cu9yezmVIjUau9//5b1Fg7mEOCCefCC5
 C9Yi4WEn3FbLIPxFyq1tAr9rKHfTCbHmYab+fniGVcNwT4nE81S0i9gDN6y14+dLgwkW/apgGA3
 lED7ZoVvJGaGfQcPcRwNXgGMy7+MA2WWU3aPBGsoMvDnpcfKqYrOCb27M5kbKwuD95yV+P4Jcw9
 B/XfEGkiwiYm1UIF1YRcQMuOzS0xtw==
X-Received: by 2002:a05:6808:23cd:b0:479:ac7d:6d8a with SMTP id
 5614622812f47-482e57b92c8mr1230319b6e.24.1778805993735; Thu, 14 May 2026
 17:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <CALeDE9PU0-fW_+erR9QHK1ST8fcStx0FWWk_0M8ELjtADugd7Q@mail.gmail.com>
 <CAN7C2SCATJL_rhpBZWwZuQVpLdnbDh5+DRFbtGHoxCXu62AVmw@mail.gmail.com>
 <CALeDE9PesKLwzt=uu_b8+pq5QXFnnK1YAO9WL3f8=CHx93w61w@mail.gmail.com>
 <CAN7C2SC_YwotE2-PS=eAFEnMOXp7jVrhaOSbKsuChLVr4zEa8A@mail.gmail.com>
 <20260514-spotted-happier-0ccb77ca8f24@spud>
In-Reply-To: <20260514-spotted-happier-0ccb77ca8f24@spud>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 15 May 2026 08:46:25 +0800
X-Gm-Features: AVHnY4IXLonnic-yfQlcFUJNiZcmNVfZBxE_gd2xWtdnItgXae8ipgt8KCGD4cU
Message-ID: <CAN7C2SAVWp23mKeG77MoV6kUKQDBN_Ge3CUMa_quAXP5YbV6UA@mail.gmail.com>
Subject: Re: U-Boot patch submit standard and requirement
To: Conor Dooley <conor@kernel.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

On Fri, May 15, 2026 at 12:14=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, May 14, 2026 at 07:46:46PM +0800, Sune Brian wrote:
> > On Thu, May 14, 2026 at 6:37=E2=80=AFPM Peter Robinson <pbrobinson@gmai=
l.com> wrote:
> > >
> > > Hi Brian,
> > >
> > > You have made a very generic statement about levels of accountability
> > > on patch sets and consistency in reviews.
> > >
> > > Can you be more specific?
> > >
> > > Ultimately there are subsystem maintainers and each maintainer has
> > > variation on how they deal with their subsystem. You reference one do=
c
> > > three times in your statement.
> >
> > Hi Peter,
> >
> > Now I understand what you mean.
> > Simply one sentence is a bit hard to read what your thoughts are.
> >
> > That document I am quoting does not refer to the entire docs but only o=
ne
> > section of the docs with that link.
> >
> > Before quoting, my declarations as follows:
> > 1) I am not referring to specific people or party
> > 2) I experienced reviewer which again not being specific to one that
> > mentioned this docs is a supreme rules to follow otherwise patch
> > that is committed is not able to push to mainstream
> > 3) I simply do a quick check on u-boot mailing pool and do see a lot
> > of uncompiled reviewed patches that are not following that supreme
> > docs.
> >
> > As such I will being to quote:
> >
> > The mailing that are reported as not passing the standard of [1]
> > Full mailing:
> > https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-=
briansune@gmail.com/#3684415
>
> patchwork isn't loading for me, but it's on lore here:
> https://lore.kernel.org/all/20260423042824.3480-1-briansune@gmail.com/
>

Hi Dooley,

Well I am sure you did not have the full picture.

The request had nothing to do with under the --- line if this is
really the case:
Let me bring you back to the history of wonders:

https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.73491-1-bri=
ansune@gmail.com/#3680232

https://patchwork.ozlabs.org/project/uboot/patch/20260422065910.5398-1-bria=
nsune@gmail.com/

None of those reviewers had mentioned this issue once "---" rather they all
just alarmingly repeated the wordings.

> The comment about the changelog format seems to be very harsh, I doubt
> it really makes any difference. What you did and what the maintainer
> requested are effectively the same thing at the end of the day.
>

Of course after reading the docs I got it immediately.
However did those who request contributors quote this from first place?

> The real problem with your patch is that you put the changelog into the
> commit message itself, rather than under the --- line.
> None of the examples you quote below do that.
>

Well after 4 patches of ridiculous request and logic change.
I guess you will do the same. At least I am not doing it at the
first moment on replying to the mails who or whom you had mentioned.

> Also, your responses to Simon in the thread you link are very
> aggressive and antagonistic. Please try to be kinder to those that take
> time to review your submissions.
>

Regards,
Brian

> Cheers,
> Conor.
>
> >
> > Quoting message [A]:
> >
> > - The required format is 'Changes in vN:'. Custom formats such as
> >    'Changelog vN -> vN+1:' are not acceptable.
> >
> > Now quoting those examples that don't follow this supreme rule.
> >
> > Example 1: Reviewed without any change requests as [A] complained
> > also aginsted [1] supreme standard
> > https://patchwork.ozlabs.org/project/uboot/patch/20260508-qcom_spl-v6-1=
-aaac1ab17b50@seznam.cz/
> >
> > Example 2: Reviewed without any change requests as [A] complained
> > also aginsted [1] supreme standard
> > https://patchwork.ozlabs.org/project/uboot/patch/20260513015606.591384-=
2-rs@ti.com/
> >
> > Example 3: Reviewed without any change requests as [A] complained
> > also aginsted [1] supreme standard and even "Accepted Stage"
> > https://patchwork.ozlabs.org/project/uboot/patch/BESP194MB2805271AD5DBE=
47B322F8DC3DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM/
> >
> > Example 4: Reviewed without any change requests as [A] complained
> > also aginsted [1] supreme standard and even "Accepted Stage"
> > https://patchwork.ozlabs.org/project/uboot/patch/20260511144437.46645-1=
-james.hilliard1@gmail.com/
> >
> > If you want more examples I can keep listing but I think this is more
> > than enough.
> >
> > Well in order one t o follow the rules other should do the same.
> > Under such bases I have no issue however I cannot see this is
> > the real case.
> >
> > Enjoy!
> > Brian
> >
> > >
> > > Ultimately the rules are there as guidance and if someone chooses not
> > > to follow them to the letter there is little that can be done. if the
> > > individual becomes problematic they will be asked, publicly or
> > > privately depending on the situation, if they could better comply and
> > > there may be further action.
> > >
> > > It's very hard to act on your generic statement without examples,.
> > >
> > > Peter
> > >
> > > On Thu, 14 May 2026 at 09:41, Sune Brian <briansune@gmail.com> wrote:
> > > >
> > > > On Thu, May 14, 2026 at 3:29=E2=80=AFPM Peter Robinson <pbrobinson@=
gmail.com> wrote:
> > > > >
> > > > > Hi Brian,
> > > > >
> > > > > Can you provide more context?
> > > >
> > > > Hi Peter,
> > > >
> > > > Not getting you sorry.
> > > > Context means?
> > > >
> > > > Thanks,
> > > > Brian
> > > >
> > > > >
> > > > > Peter
> > > > >
> > > > > On Thu, 14 May 2026 at 03:02, Sune Brian <briansune@gmail.com> wr=
ote:
> > > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > Sorry to bother you.
> > > > > >
> > > > > > I am curious that for me myself I had no issue to follow
> > > > > > the requirements [1] as long as all patches that are
> > > > > > passing the review stage do follow the rules in [1].
> > > > > > However based on most recent commits and reviews
> > > > > > most of those are not even close to what [1] mentioned.
> > > > > >
> > > > > > So at the end, reviewers in U-Boot just made their own
> > > > > > standard and requested contributors to follow?
> > > > > >
> > > > > > Rather the U-Boot itself should all follow the docs rules?
> > > > > >
> > > > > > [1] https://docs.u-boot.org/en/latest/develop/sending_patches.h=
tml#sending-updated-patch-versions
> > > > > >
> > > > > > Thanks,
> > > > > > Brian
