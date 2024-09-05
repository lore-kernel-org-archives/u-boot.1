Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DECCD5BA0
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 09:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A7488C05;
	Thu,  5 Sep 2024 11:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c5vvFJsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C15188C0C; Thu,  5 Sep 2024 11:17:44 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4B188B88
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 11:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c0aa376e15so264396a12.1
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 02:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725527862; x=1726132662; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9jzQ6DSwPJ0oMkq7yivSJKK1Lc9U1h9YoXs7UbbhmIc=;
 b=c5vvFJsUJAeFyWqSL8gkyM7URzRrx/KuaijZu37AOd5ilXESIex2ugVTV4cPDMQNN6
 qlMD3Ygn5ZwN8SH+xBxM0fiuR4+yBOa7g8b8IFyNi3FDi/9GE5Ie+6/chcfyUuFhK6R8
 kyRVIsKRlEpZXNtfajoPeztNo9YnhuTRZjxBUSNYgfSOaKUZwbE3b/9T6vIU8lbsvpUL
 uTvQ6LGsjm64kiwg9cROJr651rnws4sLJ7pWk8cQKJfiQvH3GwSR+xCgPhHdkNN3X+/I
 ewotT5sJWWkWY76IFvamwDZ2bubwFRWTalpp3tchu1Ej7NFWe1yKT4Il2CdJglhnua0L
 aDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725527862; x=1726132662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9jzQ6DSwPJ0oMkq7yivSJKK1Lc9U1h9YoXs7UbbhmIc=;
 b=GiAJOIfOOapAxyrZj8+SGOiRBXJJ4NDrUO8xsdQo3zHrOIbC7RtSA65B7GSTEyQAmg
 6Nje1J2q02HiiVRBvWvbUF2Zji9eemWbpypkUDRjOTLB9UWbUfBwoT0i6pE3VMAWXMp0
 OTprC6URVBZ1ABkg83FiKInr48DP5hJvJ7gyQLWSx6c+ywt2CG7S0XQwsR/xygGUL9t6
 I4E5uAmHoi9aHOsFW/CtM4rRA+VSlL8Fln8rpILGswYyw95bwKWzd//fQUSgTEMI45jW
 Iiulrqc113ogiQJLww9Z2xZeU67Edt6ldIKMZLoaH1tZAxqfQq1E67+XQCmU1MGnrHqX
 PgSg==
X-Gm-Message-State: AOJu0YzaJOk94IniP8ujk53XkzRe4aS1BdHGQEoEXfzoHHL/FMTeBE1E
 /zGPWOwuipZTTo400jtlnMCOoZB2SA8rZdSGMl1WcyBfBiApm/GBdcygNvUsfkSnV/K6Db59xEX
 ZjVpO16OMgjJhQ93bbrBH/B0aMX0qmxcZYGYsRA==
X-Google-Smtp-Source: AGHT+IGH9rnv7gtAzCmNK39ryLz7uucLR19KPnzudqoEoJWA5AZt5sfdoDEycDDiP/wRNBHEmM+XXU5/P5dalOXPNm8=
X-Received: by 2002:a05:6402:350d:b0:5c2:6e61:fa87 with SMTP id
 4fb4d7f45d1cf-5c3cd7b71d2mr1202977a12.23.1725527861472; Thu, 05 Sep 2024
 02:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <dc2c0bd1-3aa7-4347-a4d6-5754a40e5b7e@amd.com>
 <CADg8p95OdP5DE39VO+2uu28q_MeYFD1qqUZOvoAXQwUztBGZmA@mail.gmail.com>
 <6f1e9198-e9ef-46e3-afae-62b3f84d97c6@amd.com>
 <CADg8p97A+CJjmEtiVVU3S4GLvEie2FFNi6nN2Ho4ZtAceddJ=g@mail.gmail.com>
 <17fdf962-20b7-4bb9-93ba-bdb7335c4762@amd.com>
 <CADg8p979GVQ+bk4RYUmE94Fnd1jQ6sv41V82ZRW=+gjRhn6dwA@mail.gmail.com>
 <41f4766b-7861-4608-905f-9717e6fdc230@amd.com>
 <CADg8p97-Nbn0AsnL4Tu=375uoONmPSgr9Yj0MnEB5u1O8P0AEg@mail.gmail.com>
 <db7aaa38-d66b-4575-a50c-0b1bdbcda9eb@amd.com>
In-Reply-To: <db7aaa38-d66b-4575-a50c-0b1bdbcda9eb@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 5 Sep 2024 14:47:30 +0530
Message-ID: <CADg8p95Sg9ASrTOXOGJz8-HcFxuadRL6K9URYAQdZGCZ9NPgQw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Miscellaneous FWU fixes
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 5 Sept 2024 at 14:07, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 9/5/24 10:12, Sughosh Ganu wrote:
> > On Thu, 5 Sept 2024 at 13:20, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 9/5/24 09:43, Sughosh Ganu wrote:
> >>> On Thu, 5 Sept 2024 at 13:09, Michal Simek <michal.simek@amd.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 9/5/24 09:38, Sughosh Ganu wrote:
> >>>>> On Thu, 5 Sept 2024 at 13:03, Michal Simek <michal.simek@amd.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 9/5/24 08:24, Sughosh Ganu wrote:
> >>>>>>> On Wed, 4 Sept 2024 at 17:30, Michal Simek <michal.simek@amd.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 8/30/24 13:40, Sughosh Ganu wrote:
> >>>>>>>>>
> >>>>>>>>> The following set of patches are miscellaneous fixes and some
> >>>>>>>>> hardening of the FWU update logic.
> >>>>>>>>>
> >>>>>>>>> Sughosh Ganu (6):
> >>>>>>>>>        fwu: v2: perform some checks before reading metadata
> >>>>>>>>>        fwu: v2: try reading both copies of metadata
> >>>>>>>>>        fwu: v1: do a version check for the metadata
> >>>>>>>>>        fwu: check all images for transitioning out of Trial State
> >>>>>>>>>        fwu: add dependency checks for selecting FWU metadata version
> >>>>>>>>>        fwu: do not allow capsule processing on exceeding Trial Counter
> >>>>>>>>>          threshold
> >>>>>>>>>
> >>>>>>>>>       include/fwu.h            | 11 ++++++
> >>>>>>>>>       lib/fwu_updates/Kconfig  |  1 +
> >>>>>>>>>       lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
> >>>>>>>>>       lib/fwu_updates/fwu_v1.c | 18 +++++++--
> >>>>>>>>>       lib/fwu_updates/fwu_v2.c | 80 ++++++++++++++++++++++------------------
> >>>>>>>>>       5 files changed, 99 insertions(+), 42 deletions(-)
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> I found one more thing.
> >>>>>>>>
> >>>>>>>> I did this change
> >>>>>>>>
> >>>>>>>> diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
> >>>>>>>> index fbc2067bc12d..dab9530e499c 100644
> >>>>>>>> --- a/tools/mkfwumdata.c
> >>>>>>>> +++ b/tools/mkfwumdata.c
> >>>>>>>> @@ -293,7 +293,7 @@ static void fwu_fill_version_specific_mdata(struct
> >>>>>>>> fwu_mdata_object *mobj)
> >>>>>>>>              struct fwu_mdata *mdata = mobj->mdata;
> >>>>>>>>
> >>>>>>>>              mdata->metadata_size = mobj->size;
> >>>>>>>> -       mdata->desc_offset = sizeof(struct fwu_mdata);
> >>>>>>>> +       mdata->desc_offset = 0x21; sizeof(struct fwu_mdata);
> >>>>>>>>
> >>>>>>>>              for (i = 0; i < MAX_BANKS_V2; i++)
> >>>>>>>>                      mdata->bank_state[i] = i < mobj->banks ?
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> to break desc_offset location. I generated mdata structure and write it to
> >>>>>>>> primary mdata partition.
> >>>>>>>>
> >>>>>>>> This has been spotted by (my debug) which is the reason why I did it.
> >>>>>>>>
> >>>>>>>>             if (g_mdata.desc_offset != FWU_IMG_DESC_OFFSET) {
> >>>>>>>>                     printf("mdata offset is not 0x20\n");
> >>>>>>>>                     return false;
> >>>>>>>>             }
> >>>>>>>>
> >>>>>>>> But I got one more message below which
> >>>>>>>>
> >>>>>>>> mdata offset is not 0x20
> >>>>>>>> Both FWU metadata copies are valid but do not match. Restoring the secondary
> >>>>>>>> partition from the primary
> >>>>>>>
> >>>>>>> The reason why this logic is in place is to handle the scenario
> >>>>>>> whereby, during the metadata update, the primary copy gets updated
> >>>>>>> correctly, but due to some reason (like a power cut), the secondary
> >>>>>>> copy does not -- this is because the primary copy gets updated first.
> >>>>>>> In such a scenario, the secondary copy of metadata can be then
> >>>>>>> restored from the primary copy. In the scenario where the primary copy
> >>>>>>> is corrupted, it will show up in the crc check, and will get restored
> >>>>>>> from the secondary copy.
> >>>>>>
> >>>>>> But in this case - CRC of primary is correct but data inside is wrong because
> >>>>>> offset is at 0x21 not at 0x20.
> >>>>>
> >>>>> How will this event play out ? Am I missing something ? When the
> >>>>> metadata is getting updated, the offset will be written as 0x20, and
> >>>>> not 0x21. And in case the metadata gets corrupted, the CRC check would
> >>>>> fail and the primary partition would get restored from the secondary
> >>>>> (assuming that the secondary copy is correct).
> >>>>
> >>>> It is not after update. It is initial state with incorrect mdata structure.
> >>>
> >>> Well, if the metadata partition is being written with incorrect data,
> >>> not sure how we combat that (or even if we should). After all, the
> >>> spec clearly states that the metadata cannot be protected against
> >>> malicious writes. The logic that you pointed out earlier is to handle
> >>> the scenario where the primary partition got updated, but the
> >>> secondary did not.
> >>
> >> I don't disagree with you.
> >>
> >> Scenario here is that primary partition is updated with incorrect data content
> >> (but still correct CRC). This is correctly detected that data is not right.
> >> It means primary partition is wrong and shouldn't be used and it is not used.
> >>
> >> But because it has correct CRC syncup code logic is doing syncup.
> >>
> >> That's why I think we have two codes which have pretty much independent logic
> >> what to do. If primary is wrong sync should be from secondary to primary but
> >> that's not what code is doing.
> >
> > The scenario of "primary is wrong" will only play out in case of
> > corruption in the metadata. The scenario that you highlight, that of
> > the metadata being wrong, but the CRC check succeeds will only happen
> > when the metadata has been maliciously written --
>
> yes. And I did it on purpose to check your code and all error condition you are
> checking to make sure that code traps them.

The code should detect and fix any genuine error conditions that might
come up in the field. Even the check for the case where the two
metadata copies are valid but different is a scenario that can
actually happen when updating the metadata copies, and there is a
reason why we are assuming that the primary is the correct copy and
should be used to restore the secondary. If there are any valid
scenarios that are not being handled, they should be identified and
fixed.

>
> > if not, then the
> > secondary partition should also be written with the wrong metadata,
> > and the checks would then fail. In the case of the primary metadata
> > getting corrupted, it does get restored from the secondary partition,
> > assuming that the secondary partition is intact.
>
> When primary is cleared/has incorrect CRC there is no problem and recovery
> happens but if CRC is right but data inside wrong code doesn't check it.

This is where I think that this is not a genuine "error" case. So, if
someone has written a metadata copy with wrong data but right CRC, and
only written this bad copy to the primary partition, how do we trust
that the secondary copy is actually correct ? One can generate a
secondary metadata copy where the primary checks pass, but the image
information in the metadata is incorrect.

-sughosh

>
> Thanks,
> Michal
>
