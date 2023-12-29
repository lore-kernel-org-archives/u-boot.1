Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EBFC46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 06:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868E187A17;
	Fri, 29 Dec 2023 07:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zwk99/Zd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6137D87A1D; Fri, 29 Dec 2023 07:36:03 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA4E876B2
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 07:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50e759ece35so4286602e87.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 22:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703831760; x=1704436560; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=44hpaCeA/0G+fcuN4shHPIYwfPGPfM9wWulajIT5CGE=;
 b=zwk99/ZdYiqxmiLgenFzqzCRKOtersacwUrQqHm0IZL7V1dcne4Q6iCQE9YmBarGVW
 6tf4vR6VPxYKnVONvytGaIzDelrZWhBeqJiFLzNVv8vBO9HI06LgD/wb4o4wVXPwBdux
 SOZeZ1TQY9qC4KX7Q0nX1+zbCYIP9sKbbZysapIEvB8HM19kj5wNpkgxPVq9QKFZEe5Q
 P5nDQ1Knma/PL5SjAqbr1+XVicsedhD1v380xB5JdYjRJpRR8xR24F4xOX7Y05dFQ968
 bLIbroSBTtp3ezGSjdMYwjM2mwbLw5lKEX2137+sEanMWGef07ngEbwZKas9jm9k2MPV
 cZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703831760; x=1704436560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=44hpaCeA/0G+fcuN4shHPIYwfPGPfM9wWulajIT5CGE=;
 b=cE/6YXA04gc71U7WsnajKV2yLEEET5OZ5/r62AeKrwouRc/blEgyHN6AHpjAfUTJ4a
 kYPlf3rAdNlnVVfElJFR25vgZjoWGwDuxZgf23cb/KpyMDg0tNuQRFP8pcp0QldoNmJt
 /ixPI2W6J6TREm2OfXgmwxI4zsbdrXaSeMpbBLAm4+sFB2R2923YltqWB/8PjOSFiGlJ
 OzmghfsZPzQQ8Dhq+ePfjZXXyXwN9hYRIdOMjljGsptoh2r/7hxbsWny09S/2ABQEAtP
 4k8kRrjQtxJK7LvxdNKvXymBtW7TncSfrsXvNnj+cT1txFvMk7L2wzWJrYLsOIqoEE+d
 2ZCg==
X-Gm-Message-State: AOJu0Yw1kStwX3xWVHCkGby3s9CDPBcO9JNfJBnEb6xxJZwM/uAV7az0
 56VlxJq0pCgTc7FOfDvo5vp/pv2Pp2ZJw7aXHin2Tc27WolXxQ==
X-Google-Smtp-Source: AGHT+IGXTsjSKz7ASaxYUy/0jR80uD08iDccfOPR4582oX1Zhcw7scik0rfsXHz4Z4e1P1t9SDexEvTIer/ddvx/Muk=
X-Received: by 2002:a05:6512:1055:b0:50e:7e25:c238 with SMTP id
 c21-20020a056512105500b0050e7e25c238mr3846788lfb.88.1703831760403; Thu, 28
 Dec 2023 22:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-9-raymond.mao@linaro.org>
 <CAC_iWjJ2GAOU93x1gHPYKXyiU0j6Tp0yHqeCtsctY3mOdz+9VA@mail.gmail.com>
 <CAEfUkU+wUZJ2cb98sHAcbF-4HbN5-G2NVCSjX3ehpAkHNKUgUw@mail.gmail.com>
In-Reply-To: <CAEfUkU+wUZJ2cb98sHAcbF-4HbN5-G2NVCSjX3ehpAkHNKUgUw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 29 Dec 2023 08:35:24 +0200
Message-ID: <CAC_iWjKG2snRug69fK+xt71eJYPXgb8WV7eUMC0sE1wWLaUWqQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] bloblist: Handle alignment with a void entry
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

On Thu, 28 Dec 2023 at 18:04, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Thu, 28 Dec 2023 at 06:32, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Raymond,
>>
>> On Wed, 27 Dec 2023 at 23:08, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > From: Simon Glass <sjg@chromium.org>
>> >
>> > Rather than setting the alignment using the header size, add an entirely
>> > new entry to cover the gap left by the alignment.
>> >
>> > Signed-off-by: Simon Glass <sjg@chromium.org>
>> > Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > Reviewed-by: Simon Glass <sjg@chromium.org>
>> > ---
>> >  common/bloblist.c | 23 +++++++++++++++++++----
>> >  1 file changed, 19 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/common/bloblist.c b/common/bloblist.c
>> > index 705d9c6ae9..73dbbc01c0 100644
>> > --- a/common/bloblist.c
>> > +++ b/common/bloblist.c
>> > @@ -142,7 +142,7 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
>> >  {
>> >         struct bloblist_hdr *hdr = gd->bloblist;
>> >         struct bloblist_rec *rec;
>> > -       int data_start, new_alloced;
>> > +       int data_start, aligned_start, new_alloced;
>> >
>> >         if (!align_log2)
>> >                 align_log2 = BLOBLIST_ALIGN_LOG2;
>> > @@ -151,10 +151,25 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
>> >         data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*rec);
>> >
>> >         /* Align the address and then calculate the offset from ->alloced */
>> > -       data_start = ALIGN(data_start, 1U << align_log2) - map_to_sysmem(hdr);
>> > +       aligned_start = ALIGN(data_start, 1U << align_log2) - data_start;
>> > +
>> > +       /* If we need to create a dummy record, create it */
>> > +       if (aligned_start) {
>> > +               int void_size = aligned_start - sizeof(*rec);
>> > +               struct bloblist_rec *vrec;
>> > +               int ret;
>> > +
>> > +               ret = bloblist_addrec(BLOBLISTT_VOID, void_size, 0, &vrec);
>>
>> I just noticed the 'BLOBLISTT'. Is that on purpose? or a typo?
>>
>> > +               if (ret)
>> > +                       return log_msg_ret("void", ret);
>> > +
>> > +               /* start the record after that */
>> > +               data_start = map_to_sysmem(hdr) + hdr->alloced + sizeof(*vrec);
>> > +       }
>> >
>> >         /* Calculate the new allocated total */
>> > -       new_alloced = data_start + ALIGN(size, 1U << align_log2);
>> > +       new_alloced = data_start - map_to_sysmem(hdr) +
>> > +               ALIGN(size, 1U << align_log2);
>>

Writing this as
new_alloced = hdr->alloced + sizeof(*rec) + ALIGN(size, 1U << align_log2);
is much more readable

>> So, wouldn't it make more sense to add the dummy record and align the
>> whole thing *after* we've added the entry?
>> Doing it like this might leave the last entry on an unaligned boundary, no?
>>
> The spec just cares about the TE *data* starts at an aligned address but not the TE header.
> Not sure if I fully understand your question but each TE *data* will start at an aligned address
> after calling `bloblist_addrec()`.
> And each TE is allowed to have its own alignment value, so we have to do the padding when
> a TE is being added but cannot predict the alignment value for the next TE - that means we
> cannot do the padding after each TE is added.
>

Ah thanks, this makes sense

> [...]
>
> Thanks and regards,
> Raymond

With the change above
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
