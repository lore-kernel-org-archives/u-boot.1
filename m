Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7173CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 11:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D1E83AA9;
	Thu, 14 May 2026 13:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZEuGdOsA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC288039B; Thu, 14 May 2026 13:46:58 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8A6A83FF5
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 13:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e4004a4a6fso255062a34.1
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778759214; cv=none;
 d=google.com; s=arc-20240605;
 b=b0ALk3DBELHkc8w6V96ppmEVjHKPC+rY9e6EXWYb+rQRLpD8BXOfw6xtGIzbZBwYlU
 PvbtYjd4MscW38qplfigjYo67+g90IDG5a13E+e0S8/8TY0jGrwO7aCwwc4UyK3noesp
 ESqfkod02jvwSb64ryp1KlqHa5Or124LE5UPqCObWKtb+2UbZhUGY3DKf2ulpweRzRHP
 HjKkt2Yn7YBYgG6ruuK69ELg+bpdIMspilzzym++mNU5jz7SaKGCOweHd/4FQVyIIrwv
 DSJGmlqNuQt86Xs9MT9AhywuiiOxy7/vXN8mDpQdyQRQl7C55CMPqpOojMrvfq5T/zrW
 77QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2jX6dHtGonaK8bSns3S34DxAUt2utl9B+qAyk/QQS5U=;
 fh=JvRO2XAgGIwVKEnxMiW6IwaVpkwiNLmEUD56LasLEd8=;
 b=HWF5VZbEG1Ifrjryg83fx32zWgHyabYXPXfMPCOqDx/i03EGILyNuBaGerBLrIF3Jy
 uUWZwNOZwZ+N1e2cI4jNZQdzVy3XxgEOLJotI9qr8yfAYDFBxyxsQWSJRBd0P8sTafyY
 ZLXPZVuiKIyDT8Ut+SA/BMQyxpcKZIDYagLq3gdn5CbvWNMBsMqoJ28qBN69hWZE+P38
 1Fsy+hWLUusWyxtETLIcaJBAsur2H36qM5u41xhloAQW0WU9UoezeE/Be3h4YX4MNSgS
 VXeHk1lIm8JL6O/CBUHRwWkTYQg63UMXKssiVC79PQi8q0wQV5eqFCWtt/RzvvD4yZFL
 hOhQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778759214; x=1779364014; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jX6dHtGonaK8bSns3S34DxAUt2utl9B+qAyk/QQS5U=;
 b=ZEuGdOsAf2/WMq9fLqWGVZBucqGeRKdDwNeOimrYciIGetgtxYmgMbOyQP3Hz5i/x2
 HVnEBUauw9Ebd6pCWpCUOz7RtAodXUquBFpUZLXv2ItbIdywotQMDFz9dT1JFvjG0SJO
 BPUG4ZymETy1+uF40caOaIT+Nq91BrRBzC+/12IBiRuXzp/MGNgan0S1VnFn1ujYOARb
 7Er/MVNVBWAnXwt0zrgUnn+Wzk+xo2LD3y58E4PWsiM3Xatxx0LWDvU5Z+8p+IMfMzHX
 BW6LgrXxMhVOohx2/AxBJvFtLY2UBvXElyMUOh1gMgVhEOTQVwK4DjiDxJjjjrSvdWPN
 j9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778759214; x=1779364014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2jX6dHtGonaK8bSns3S34DxAUt2utl9B+qAyk/QQS5U=;
 b=CwBYQSmoQfJueEXOU7sLUtArVG5aewmNjJ/dZHJLs1jkLCzyuOA8+SX1s8zE3fpgUk
 205Fy5V915wxCCYes+XPQmhH18AkL2Xw3oJI9OFmZikFJblVCPyn+pcVq90ZOibUsjAc
 pkkK/qZonjnBIuX2/7nfz+pKoC9/aPRjGi6SuZiDbIdsTh/tukNVdPFfhCmyLjYCrzbA
 kAWUn+iqCG6noP6spxR1krlLD21pVUuRK0TiKN53KnpJG1ieFDohWYNXe/SAQxsdgvRt
 8DHWGGXyMwUdxA4ZddDcZJ7li40BqMP7NKWMkTnwbwP6aBiR0fzWuCF+F4ORCqbmKAgz
 JNbw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kYP8Dn+avjNVr7T4q4KZFhOIc7mKhkHWR0gH4LBqpE0neoq/gR/xhUSt3NsyNTj5rTso+Npg=@lists.denx.de
X-Gm-Message-State: AOJu0YzNxSD67TV7aeO2lAp50KjRZSP4qnwS5poAuXL8WVV5FQJ+rhoi
 Us40xdYLtRkDE77cN7DDBWJJ17sqEv4v2qgir09EfCsI/6Dvwb5tZUmI+RUO2Fmm79VdCXd7XYu
 25sYdLcERUqugdfwbv02fkq8D+iBHASWW7zhy7SSp1Zv+
X-Gm-Gg: Acq92OGeQ73qMR7tFF8GTQINY065WLzY94o7mMU0PgVoVaM5mN680t86Spa03wmGUID
 WF98GJVRepyRDZrTflH0aKXMsOvJS/HTvJ8QSOtJMnFreSCtv5HCURSPmOmfBBnMnDJy0uqB520
 fbCZ8lF+p4yS64Ta1vIaEapJ22MljW8tkHobuskXZABA7hVe+YA/urT82Jv0wURHH9U+oLvpE70
 p30iSj7lcLQ5SNw55ss7NNq0ZVNIz/3FOREJYc+FTPy3/QbO2sTlEEhL3IGV0cMndBwweUcCTNv
 NqkDwlqV
X-Received: by 2002:a05:6830:81cd:b0:7de:649d:f2ab with SMTP id
 46e09a7af769-7e3dc8800ddmr4113654a34.13.1778759214371; Thu, 14 May 2026
 04:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <CALeDE9PU0-fW_+erR9QHK1ST8fcStx0FWWk_0M8ELjtADugd7Q@mail.gmail.com>
 <CAN7C2SCATJL_rhpBZWwZuQVpLdnbDh5+DRFbtGHoxCXu62AVmw@mail.gmail.com>
 <CALeDE9PesKLwzt=uu_b8+pq5QXFnnK1YAO9WL3f8=CHx93w61w@mail.gmail.com>
In-Reply-To: <CALeDE9PesKLwzt=uu_b8+pq5QXFnnK1YAO9WL3f8=CHx93w61w@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 14 May 2026 19:46:46 +0800
X-Gm-Features: AVHnY4Jd-TyriQ_0unz1HIeVibu_OgHZJF4WERCgopAo46cmJj5fCT6_-n99woI
Message-ID: <CAN7C2SC_YwotE2-PS=eAFEnMOXp7jVrhaOSbKsuChLVr4zEa8A@mail.gmail.com>
Subject: Re: U-Boot patch submit standard and requirement
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, May 14, 2026 at 6:37=E2=80=AFPM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> Hi Brian,
>
> You have made a very generic statement about levels of accountability
> on patch sets and consistency in reviews.
>
> Can you be more specific?
>
> Ultimately there are subsystem maintainers and each maintainer has
> variation on how they deal with their subsystem. You reference one doc
> three times in your statement.

Hi Peter,

Now I understand what you mean.
Simply one sentence is a bit hard to read what your thoughts are.

That document I am quoting does not refer to the entire docs but only one
section of the docs with that link.

Before quoting, my declarations as follows:
1) I am not referring to specific people or party
2) I experienced reviewer which again not being specific to one that
mentioned this docs is a supreme rules to follow otherwise patch
that is committed is not able to push to mainstream
3) I simply do a quick check on u-boot mailing pool and do see a lot
of uncompiled reviewed patches that are not following that supreme
docs.

As such I will being to quote:

The mailing that are reported as not passing the standard of [1]
Full mailing:
https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-bria=
nsune@gmail.com/#3684415

Quoting message [A]:

- The required format is 'Changes in vN:'. Custom formats such as
   'Changelog vN -> vN+1:' are not acceptable.

Now quoting those examples that don't follow this supreme rule.

Example 1: Reviewed without any change requests as [A] complained
also aginsted [1] supreme standard
https://patchwork.ozlabs.org/project/uboot/patch/20260508-qcom_spl-v6-1-aaa=
c1ab17b50@seznam.cz/

Example 2: Reviewed without any change requests as [A] complained
also aginsted [1] supreme standard
https://patchwork.ozlabs.org/project/uboot/patch/20260513015606.591384-2-rs=
@ti.com/

Example 3: Reviewed without any change requests as [A] complained
also aginsted [1] supreme standard and even "Accepted Stage"
https://patchwork.ozlabs.org/project/uboot/patch/BESP194MB2805271AD5DBE47B3=
22F8DC3DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM/

Example 4: Reviewed without any change requests as [A] complained
also aginsted [1] supreme standard and even "Accepted Stage"
https://patchwork.ozlabs.org/project/uboot/patch/20260511144437.46645-1-jam=
es.hilliard1@gmail.com/

If you want more examples I can keep listing but I think this is more
than enough.

Well in order one t o follow the rules other should do the same.
Under such bases I have no issue however I cannot see this is
the real case.

Enjoy!
Brian

>
> Ultimately the rules are there as guidance and if someone chooses not
> to follow them to the letter there is little that can be done. if the
> individual becomes problematic they will be asked, publicly or
> privately depending on the situation, if they could better comply and
> there may be further action.
>
> It's very hard to act on your generic statement without examples,.
>
> Peter
>
> On Thu, 14 May 2026 at 09:41, Sune Brian <briansune@gmail.com> wrote:
> >
> > On Thu, May 14, 2026 at 3:29=E2=80=AFPM Peter Robinson <pbrobinson@gmai=
l.com> wrote:
> > >
> > > Hi Brian,
> > >
> > > Can you provide more context?
> >
> > Hi Peter,
> >
> > Not getting you sorry.
> > Context means?
> >
> > Thanks,
> > Brian
> >
> > >
> > > Peter
> > >
> > > On Thu, 14 May 2026 at 03:02, Sune Brian <briansune@gmail.com> wrote:
> > > >
> > > > Hi Tom,
> > > >
> > > > Sorry to bother you.
> > > >
> > > > I am curious that for me myself I had no issue to follow
> > > > the requirements [1] as long as all patches that are
> > > > passing the review stage do follow the rules in [1].
> > > > However based on most recent commits and reviews
> > > > most of those are not even close to what [1] mentioned.
> > > >
> > > > So at the end, reviewers in U-Boot just made their own
> > > > standard and requested contributors to follow?
> > > >
> > > > Rather the U-Boot itself should all follow the docs rules?
> > > >
> > > > [1] https://docs.u-boot.org/en/latest/develop/sending_patches.html#=
sending-updated-patch-versions
> > > >
> > > > Thanks,
> > > > Brian
