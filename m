Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB659CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7977B847C5;
	Tue, 19 May 2026 15:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eUfJA4Jf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2290847D9; Tue, 19 May 2026 15:56:24 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B218846DD
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de46b8e432so3767368a34.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198981; cv=none;
 d=google.com; s=arc-20240605;
 b=NtK4G+UnlxTFBsG1u4bXP6vzYfcvVHj9uwx3eohCNwW6Qhemcm6aL6Enn8jl/443lJ
 p3wolYcRvM755cauBmnsUFwYqk5i5blI/66xYh73+e8PkcBcdXE+XKK5fbtptxIsybZX
 P+NYMWImiMbnjCnTWBhPiXhkb3HSJyfV/b9DS6E8I54RMichmLZveY8wiPc+Y8gwaQIr
 yc4lGc3Uz6b94GnuzTZi2Giop/4V1A/mYhYa0TNKApzUzza5pusLIUDEBor3QhHXNXY+
 /f+MrpPkhsi/a+B3IMfSNGQu9N9q1U3P76hS6tOBBLaC25tCNejpQdTm46jErXwL2dy4
 mZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rZLl5jTCxqC+jLw1PoaIux5SbINijxSfHaKoPrUtRv8=;
 fh=Fg9Wsco3ajK58ajjJ799p3dmQeKQu0sFFCdktj9aVmc=;
 b=LiCzOpoS58oyucITOCH3iof0xhSTyozzZt/+d3oeXasohZfhL65vs52o7h485xvWaM
 HQJ/cJYqRPLGR/XIHs979pQTyIRoH86m3mU+DmdGN/sPky1CgllFdf3jnQAOBJzKb7VP
 956UKANZDqHVkKGY7JH1WMhP45WMz81dRNU8B1ikYNKgx/DjOYGY7BmxK0Op/Zv8nyWw
 5t3tC/O4j4NRkWmHecjsZx2nU5MC6x15yC+ByTK+EXvE+hnDL/KXFarZ93tBiE3YFeGK
 Pxk62BTYvAiJf/I2x/Qckj+koz+II5Pwmbg8pNnvxG7a21RG0UcPaacSU1wjfEmz7Hxv
 0mLQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779198981; x=1779803781; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZLl5jTCxqC+jLw1PoaIux5SbINijxSfHaKoPrUtRv8=;
 b=eUfJA4JfxXrbsp6pnXIvpe5fND76i5xMfGYxsFEwL6xCf2mkCcdpsrXG8WXTscbQY4
 yYsVxpK0xm+9fp1ikBsWRUCjNON936Ud/mdunpC47ox8rW7eKE0mQRxhZbmpABoIrHuM
 ZRKIUDmFbpZJDjZ3TtSwG0wZR3g3QiB+UxTw12zNnUTrIBUYI9iH9ay+8b9PwyMb5+Dh
 PuYs0D4mOWq3UjKrYwUuKPTbk+TyRj7gUXeRqAy7koe4H10P/hglqsww33eswcaRH2Uy
 93WCUolQ0CgIdE5VTkl3ASAV3zJFTPHP4UvR2jOgsPp54QmGY8xQjm0kZce8LvutkSBN
 /x+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779198981; x=1779803781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rZLl5jTCxqC+jLw1PoaIux5SbINijxSfHaKoPrUtRv8=;
 b=Z4JgWU8WOCQ1J2a3C9v+MQPRyFH+XwaFbpGLHujTzFspBwwkVsRGSmQqMugxH+YKv4
 mdEHkaK8fKqc0FPpn5H62VqiWlee7rYNrOU+6vzSVLJBHWszBjbl7hkwjigBvdRuaIwN
 sLQxq8bD8Je9A3HnIs8Zi/96g9pPtlsJs4hTSV4Dsvj9Y64vP1xrGfUmOFgSzqAzGLfv
 GJVC+xVTQY7fNBI2JD7CKnb7NaetMd5Xn+VjhVeyAhNc3eYergFdaX5+2x+zLv/GEAqo
 XtejLX/MeP+ElPV0vwVGoEYmD0xNWMW7NcNL7ltJWivrKBz5L7lY4fz9GSYxgbtWQnA4
 p9CA==
X-Forwarded-Encrypted: i=1;
 AFNElJ95Uj+3FKqjrL/S9dVWZoBb/ncZsnyPw14PXc7YRMSD4ji7UVUQVKvNlyPYm9h+Fd1Hs1W4Ycc=@lists.denx.de
X-Gm-Message-State: AOJu0YxRkujXWkjGHxcE5S2yDf7WRw32VCyDEm660YKel0h4U5KWss79
 63nyLzQ/8p3JjuSOwiBRmEC+Xz3BjEnba90tMgz3bTt+PUd7mMk81bQvDk55JQew6p1npEdZeid
 whZMJ0nx4Cq3c2Cxyelj7Tdp69aQJveJVZRnyTrvL9g==
X-Gm-Gg: Acq92OGFNy/hGirutQx8S85RTiSBYUbfVPbR94pSSYcHIPZqo00DtbC248aWVn/ibqc
 PSckgqk3CMsoG3iJIqnY5x63yYG0xtaTAX33olhIt0D/2u3IzyeifXigZ7u+4c5ABu+goNerKH9
 pK5GWwFdSl1MlG22BcWw7KDq12fq+o7mxOyWExRbSMs4SqurQW+UcAGNPpp8gMmxNbuMv8Crsxr
 geqbtHZUr+WEmgaQ2zWz5lSfsn4FFjyk01/aJq9Fjit7ja9Amy1Wdm9kJdMnzpyLyjMMFBQbgvN
 weQ6d38=
X-Received: by 2002:a05:6830:4987:b0:7d7:b841:c6dd with SMTP id
 46e09a7af769-7e4f2a1c956mr14391031a34.11.1779198980710; Tue, 19 May 2026
 06:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <c8cb1fbe-b15b-46b6-a39e-e6c2bd652ec6@cherry.de>
 <CAN7C2SCguh2M3JFC2UE3UFYf6_Z9a9038UEKpFLTTGFTH_r60w@mail.gmail.com>
 <3c49cee2-bd74-40c8-acb7-7a587ad895cb@cherry.de>
In-Reply-To: <3c49cee2-bd74-40c8-acb7-7a587ad895cb@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 19 May 2026 21:56:09 +0800
X-Gm-Features: AVHnY4LiMXVfCC3eaEorVVQwoeD4u29_-jgB5ijJmxru-A13lcNFMVSV8TDB03g
Message-ID: <CAN7C2SDWyq1mgABS1Q1b6PAb_pe5Vbty+SC_S+TbCs7TCm65OA@mail.gmail.com>
Subject: Re: U-Boot patch submit standard and requirement
To: Quentin Schulz <quentin.schulz@cherry.de>
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

On Tue, May 19, 2026 at 8:45=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Brian,
>
> What I understood as being your complaints are the following:
>
> 1. you were told to put the version changelog in your patch to match the
> expected format. You did it in the next version but not the way we
> expected it. You were asked a second time to reformat your changelog to
> adhere to the expected format, with a more precise guideline. A second
> answer then provided you with the link to the documentation.
>

Hi Quentin,

I learn from you and understand the kindness here.
But sorry that from what your quotation shows:
That's why I am very sure everybody from this email pool
have not read all the context from beginning to end.

First the mentioning of change versioning not started at v4:
Read this ->
https://patchwork.ozlabs.org/project/uboot/patch/20260420074601.24988-1-bri=
ansune@gmail.com/#3680096

Second, I never complained about the needs for specific requirements
either strict nor slack!

Third, I would follow without any issue as long as there is good info
and minimum redoing it again and again due to the inherent bad
instructions that are being laid down.

Four, I gave at least 3 versions of modification options changes with
comments either agreeing to disagree yet following reviewer suggestions
as first priority.


> Appropriate links are
> https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.73491-1-b=
riansune@gmail.com/#3680205
> https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-br=
iansune@gmail.com/#3683491
> https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-br=
iansune@gmail.com/#3684415
>
> The requests made by Simon (reviewer) and Tien Fong (maintainer) are
> valid as this is explained in details in the docs. See
> https://docs.u-boot.org/en/latest/develop/sending_patches.html#sending-up=
dated-patch-versions
> where you also have an example. However, I see the requests for
> "'Changes in vN:' rather than 'Changelog vN -> vN+1:'" as nitpicks. I'm
> almost certain neither Simon nor Tien Fong would have requested you to
> change that if it was the only thing to complain about. It's just that
> the changelog being part of the commit log is an issue, and since you'll
> likely need to send another version to fix that, "oh by the way, also
> try to do this while at it" happened. It's not unusual. If it was the
> only feedback, I would have understood the frustration.

No you did not! Because I expected people who mentioning rules and standard=
s
are perfectly crystal clear on delivering the necessary correction to whom =
it
request to follow.

>
> The second and third links do NOT invalidate what had been said in the
> first one. There was a misunderstanding because there was room for
> misunderstanding. I understand the request made by Simon in the first
> mail could have resulted in the patch you sent, which doesn't match the
> expected format. Nobody's fault here, misunderstandings happen all the
> time. We make things clearer in subsequent versions of the patch or
> discuss them. I do not consider what Simon did as being hostile. If
> something is unclear, you can always ask for clarification.

I again clearly speak out my mind clearly.
I never intended to use an inappropriate tone in the first place!
However if you request me the change one specific things do it properly
by good context at least less than three times.
Again the context which going to correct also be reasonable and
really what it meant rather than oh I think this is not my standard
strictly changing it and alarmly pointing it is creating a git am issue.

>
> I will also note that Simon took the time to better explain the rule a
> second time once the misunderstanding was detected and to provide a link
> to the documentation.

Again it is not second rather even considered as fourth.

>
> I will join Neil here and tell you that the phrasing in
> https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-br=
iansune@gmail.com/#3683515
> and
> https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-br=
iansune@gmail.com/#3684100
> is unacceptable towards Simon.
>
> Additionally, dismissing Simon's comments simply because he's a reviewer
> and not a maintainer is not the solution. The project relies on
> reviewers because maintainers do not have the time to review each and
> every version of the patch. We put trust in reviewers so that the work
> load is lighter on maintainers (and hopefully, with more eyes, we miss
> fewer bugs).
>
> 2. you feel like you were victim of a double standard because reviewers
> didn't complain about missing or misformated changelog from other
> contributors.
>
> Provided (by you) links are
> https://patchwork.ozlabs.org/project/uboot/patch/20260508-qcom_spl-v6-1-a=
aac1ab17b50@seznam.cz/
> https://patchwork.ozlabs.org/project/uboot/patch/20260513015606.591384-2-=
rs@ti.com/
> https://patchwork.ozlabs.org/project/uboot/patch/BESP194MB2805271AD5DBE47=
B322F8DC3DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM/
> (and some others)
>
> First, there are some patches for which Simon (or Tien Fong, who shared
> Simon's opinion on changelog formatting) didn't participate in.
>
> Second, your examples sometimes are patch series which do have a cover
> letter where the changelog is mentioned. They do not appear on patchwork
> (but they do on the mailing list). See
> https://lore.kernel.org/u-boot/20260508-qcom_spl-v6-0-aaac1ab17b50@seznam=
.cz/
> and lore.kernel.org/u-boot/20260513015606.591384-1-rs@ti.com/. Yes we
> have inconsistencies here. Simon has complained in the past with
> changelog per-patch being better (for him) than changelog per-series
> (i.e. in the cover-letter). Having *some* is good enough for the project
> is what we decided on.
>
> Third, you cannot cherry-pick a single patch version and say "look here
> nobody said anything", later patch versions may receive feedback like

This is because that patch involved some area that I also intended to fix o=
n
and the patch had been rejected and handed off to Alif.
Meantime, the reason is because it is reviewed by T.F. and also very good
example to feedback to whom that the original alarming is absolutely
unnecessary.

> you had, earlier versions may have received feedback that wasn't taken
> into account (this should not happen, but mistakes happen). Usually,
> once a patch or two gets feedback that something warrants another
> version, reviewers and maintainers pay less attention to the patch
> series as we know we'll have another version to look at in a few days/wee=
ks.
>
> Fourth, different reviewers and maintainers are different people. They
> have their own rules, either stricter, or more lax. It may also depend
> on the reviewer or maintainer mood at the time. You cannot hold Simon
> and Tien Fong responsible for another reviewer or maintainer not telling
> another contributor to follow rules.
>
> If you want to name that multistandard, then yes, we have that. It's
> sometimes desired (not every maintainer wants to apply the same rules
> with the same strictness as others, that's their right as a maintainer),
> sometimes not ("oops, we merged something too quick and forgot to check
> all the rules"). But I don't believe we're applying the multistandard to
> someone in particular. If this happens, please bring this up as I'm
> pretty sure this is not something we want to see happening.
>
> If there are things we can automate or document better, then please
> consider sending patches to improve the situation.
>
>
> As an aside, I'm not a native speaker and we may be coming from
> different cultures, so this might explain why I'm reading most of your
> mails as being aggressive, dismissive and sometimes plain rude. I
> understand it can be a language barrier, but please remember that we
> have a somewhat diverse community where people come from different
> cultures and different levels of understanding of the English language
> so what may be rude or not rude to you may be received differently by
> people reading you (and vice-versa).
>
> As personal anecdote, I still cringe when I remember participating on
> some forums when I was 14 and thinking "bullshit" was an okay synonym
> for "a lie" or a simple difference of opinion, I cannot imagine how the
> other people felt when reading me back then.
>
> I'll finish by saying that sometimes it's easier to spin a new version
> than arguing or getting angry, even if I slightly disagree with the

That's why I mentioned dropping this patch and I will do the next
action before understanding the full picture why and how could
reviewers review in such a manner.

> reviewer or maintainer. It's better for my health and it's less
> time-consuming. Picking one's battles is not an easy task :)

Well with all said I only point back to an example that T.F. review
and applied what he mentioned to me as alarmingly not going to
pass the U-Boot system so why not mentioning during the code fix
etc.

Again I never write to pinpoint down to a specific person or persons.
But just finding an appropriate balance on slack and strictness.
However what I saw or experienced is unable to do so.

Again this mail pool is asking why and how the rules are being applied.
Meantime I also did not complain about any of those quotations in the
first place.
While Peter expects a full context citation to follow what is the actual
situation here, so I had no choice to quote it and make life easier in
the first place.

I never complain about anything but just seeking an answer to the
standard and rules on patch reviewing and commision.

I guess this is more than enough to explain my original question.
Meantime I appreciate all the efforts on explanations and referencing
back to my patch mistakes.

Thanks,
Brian

>
> Cheers,
> Quentin
