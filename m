Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA7CC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 16:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 167B686784;
	Tue, 14 May 2024 18:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="g7+o5K3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E2F865D0; Tue, 14 May 2024 18:31:45 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A599A86784
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 18:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a59b58fe083so47314666b.0
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1715704301; x=1716309101; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFTewi20nkFQJ241ybk+qN1cy+JY/ASoRwXW68Bml9w=;
 b=g7+o5K3bzJTownLagm4C9GkvnDtuG48jrPo6PANIZ14wLdnuLVIrycDasXw76J6n3j
 dti//Tk4a3YsXQpptGYtaPZQG0CGmPT4M6+UrP57/BnIwdbzZ/jJaMr0OmO37cXo9zbb
 9zc1/Z64CjmN7b7/695zSaGDspWROZPbSRNUV3V2rP6EgU1f3G6tr5+2IGUES5/3Sisz
 iEEcn1g9si+bkOcGolLRyVSM6r+SLsn3uIx0GVpbjAULrkub9wztib9VuTBakhuJp3oH
 XTnPDjnvxlYS/zNa3NJC8rBvGjgyuVlzJIBVMzq/dmVu2COku5b+i2xQ8+WD4eTnI42D
 AsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715704301; x=1716309101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFTewi20nkFQJ241ybk+qN1cy+JY/ASoRwXW68Bml9w=;
 b=rC+d4LLlJHV2DWlM7ZZnqAb/cw2Ew0qzrS+ABkTfWtqZ3kdNTVmAUn6VKjLP2mxDxj
 fI9tvOjSbcjzT+9vcnC2IHc6YW0+AFGh20Uqv5afU7CTJ5qvkZxo7E3lKdGb//56BL5n
 2GRB2HMWz1CWKhFYI+2aZQ3jVilV203e3oTQ/Dkl9yVjyxh3+YFjBfJkQwxSlwDKuaPg
 +sntg350r6IAcN4h9/6EsmCY6dByqnQXxNMarArYW2qgwbzCcQfL5ha/XQNvd0+mpyjb
 oAt4GIARoDy9+5kA/IK8QRiwIAHmgSXTikRQyZQcdMTfCYOCHG+NCHbDVxvUWJfK/BWx
 SNSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb2G9kSLkSjcFP7iudNHdXchw3pzm9D3hZgzGa2fLvyk3SYdtaE8dpaC+MiPtLnrIvwSwMtEp0KEQvcIl2mhlMGU3EDg==
X-Gm-Message-State: AOJu0YymnqyEvdJsJwEZei7tWjLeJKKNAa2un1WnF+xk3o6ZNAvL2pX0
 32dTBBP9RrtY8q4Uid1fztiPVU/ODCnbLCXnYgDikfP6VWLo2ZY8djg8Sm4h1+TH/ogj4J77Qau
 11N58cb1l1WH6s5KkirGbOLLvKTuS1h/dTINM0A==
X-Google-Smtp-Source: AGHT+IGF+xk1iayd8xBSnYCpk9KG1jiFyB6jY8y/Ea2g2w3dO1BQJkjH3TJrKLIsl0kcUe9/oIySs0VfsbNA6eC5r30=
X-Received: by 2002:a17:907:7845:b0:a59:de2e:98e0 with SMTP id
 a640c23a62f3a-a5a2d65f2c6mr864074066b.56.1715704300844; Tue, 14 May 2024
 09:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240427001157.1460302-1-tharvey@gateworks.com>
 <495f60d6-6ff2-4c53-8b2c-867b5ca05993@denx.de>
 <CAJ+vNU0R5iTgS2_C_OV2VYh5fQnyPV-Lw003CTJAkp1Q6Qdedg@mail.gmail.com>
 <ef623aca-ead7-42dc-bacf-6cb51bdfba41@denx.de>
 <CAJ+vNU3bOrBHf4nQeb=1_EfrcsjcjYncQN3Od2=O93yuVQc2FA@mail.gmail.com>
 <c0704b40-51e2-4f35-b062-ceeaee1b2986@denx.de>
 <3a1a4406d54e6cdc09f03e88f265e555@manjaro.org>
In-Reply-To: <3a1a4406d54e6cdc09f03e88f265e555@manjaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 14 May 2024 09:31:29 -0700
Message-ID: <CAJ+vNU2dy9Z6hFjbU_RLv+N9gUOasp-XxUQYKuWM971f0aAsxQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: allow use of hardware partition names for mmc
 partconf
To: Dragan Simic <dsimic@manjaro.org>
Cc: Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Avri Altman <avri.altman@wdc.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
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

On Tue, May 14, 2024 at 5:05=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello all,
>
> On 2024-05-14 01:02, Marek Vasut wrote:
> > On 5/13/24 10:52 PM, Tim Harvey wrote:
> >> On Mon, Apr 29, 2024 at 1:51=E2=80=AFPM Marek Vasut <marex@denx.de> wr=
ote:
> >>>
> >>> On 4/29/24 6:48 PM, Tim Harvey wrote:
> >>>> On Sat, Apr 27, 2024 at 4:20=E2=80=AFPM Marek Vasut <marex@denx.de> =
wrote:
> >>>>>
> >>>>> On 4/27/24 2:11 AM, Tim Harvey wrote:
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>> diff --git a/include/mmc.h b/include/mmc.h
> >>>>>> index 4b8327f1f93b..7243bd761202 100644
> >>>>>> --- a/include/mmc.h
> >>>>>> +++ b/include/mmc.h
> >>>>>> @@ -381,6 +381,21 @@ enum mmc_voltage {
> >>>>>>     #define MMC_TIMING_MMC_HS200        9
> >>>>>>     #define MMC_TIMING_MMC_HS400        10
> >>>>>>
> >>>>>> +/* emmc hardware partition values */
> >>>>>> +enum emmc_hwpart {
> >>>>>> +     EMMC_HWPART_DEFAULT =3D 0,
> >>>>>
> >>>>> One more thing ... eMMC hardware partition 0 and 7 are both
> >>>>> referring to
> >>>>> USER HW partition. Have a look at the git log, there have been
> >>>>> patches
> >>>>> which handled this case in the MMC subsystem from about a year ago.
> >>>>
> >>>> I can't find what you are referring to. I assume you are talking
> >>>> about
> >>>> calling the first name something other than 'user' as technically
> >>>> it's
> >>>> not (but it gets treated as user).
> >>>>
> >>>> Can you find the commit or discussion you are thinking about?
> >>>
> >>> It seems this whole thing is much older:
> >>>
> >>> 7dbe63bc950b ("SPL: Add CONFIG_SUPPORT_EMMC_BOOT support to
> >>> CONFIG_SPL_FRAMEWORK")
> >>>
> >>> +                * We need to check what the partition is configured
> >>> to.
> >>> +                * 1 and 2 match up to boot0 / boot1 and 7 is user
> >>> data
> >>> +                * which is the first physical partition (0).
> >>> +                */
> >>> +               int part =3D (mmc->part_config >> 3) &
> >>> PART_ACCESS_MASK;
> >>> +
> >>> +               if (part =3D=3D 7)
> >>> +                       part =3D 0;
> >> Sorry, I haven't been able to work on U-Boot for the past week or so
> >> and am just getting back to this.
> >
> > No worries.
> >
> >> I'm glad you pointed this out as it made me aware that there is a bit
> >> of a mixing of eMMC PARTITION_CONFIG (Ext CSD 179) fields
> >> BOOT_PARTITION_ENABLE and PARTITION_ACCESS in U-Boot currently.
> >>
> >> I'm going to add an enumerated type for each and update the various
> >> places where a 'conversion' as above is done but I'm still a bit torn
> >> on naming conventions.
> >>
> >> Consider the following:
> >> - the eMMC spec refers to boot partitions and gp partitions as 1 based
> >> - the Linux kernel device names for these are 0 based
> >> - U-Boot does not currently refer to the boot devices by names but
> >> does currently refer to the gp's by names using 1-based names (the
> >> 'mmc hwpartition' command)
> >>
> >> Personally I would like to name the boot partitions 'boot0' and
> >> 'boot1' to match Linux but I think I should name the gp's
> >> 'gp1'...'gp4' to be backward compatible with the 'mmc hwpartition'
> >> command.
> >>
> >> What do you think?
> >
> > I agree.
> >
> > Maybe you could also check this with Ulf (Linux MMC maintainer) and
> > Avri (mmc-utils), both on To:, so we would be consistent and in sync ?
>
> As I promised earlier, I went through a few JEDEC standards and some
> publicly available JEDEC documents and presentations, and my conclusion
> is that no official numbering scheme for the partitions seems to be
> defined there.
>
> However, I'd propose that we keep "boot0" and "boot1", because that's
> pretty much become a de facto standard, and also switch to using "gp0"
> through "gp3" for the general-purpose partitions.  That switch might
> be some kind of a backward-incompatible change, but it would follow
> the names of the corresponding GP_SIZE_MULT_GP0 ... GP_SIZE_MULT_GP3
> fields in the EXT_CSD register, as defined by JEDEC, and it would also
> be more consistent with the numbering of the boot partitions.
>
> Though, general-purpose partitions are mentioned as GPP1 ... GPP4 in
> one place in the JEDEC standard, which just confirms that no official
> numbering scheme seems to be defined.  Moreover, the boot partitions
> are more than once referred to as "boot partition 1" and "boot partition
> 2" in the JEDEC standard, which means we're already not following the
> standard with "boot0" and "boot1".
>
> Frankly, it's all a bit contradictory and confusing, but I think that
> the increased consistency would outweigh the backward-incompatible
> downside of the switch to "gp0" through "gp3".

Dragan,

Thanks for your freedback and sorry for the late reply.

I also went over the spec and found that they used 1 based naming in
their referencing of the partitions but noticed that Linux uses 0
based naming for both boot partitions as well as gp's when creating
devs. Seeing as both Linux and U-Boot tend to use 0 based naming I
wanted to go that route but then I noticed the 'mmc hwpartition'
command (enabled via MMC_HW_PARTITIONING) which is used to create gp's
uses 1-based gp names in its parameter list and that 'mmc info' will
display the gp's, if configured, as 1 based as well.

I submitted yesterday a new v3 series where I use boot0, boot1 for
boot partitions but gp1, gp2, gp3, gp4 for gp names just to stick with
the current usage of 'gp' in U-Boot (although the array of names isn't
used currently in the 'mmc hwpartition' or 'mmc info' commands.

I'm open to further discussion on the matter. I hate to make things
non-standard just to be backward compatible but I have no idea who is
using the 'mmc hwpartition' or output of 'mmc info' currently with
regards to gp's.

Best Regards,

Tim
