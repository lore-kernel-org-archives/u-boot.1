Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5163AC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 15:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B077E87956;
	Wed, 27 Dec 2023 16:30:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sMMTRtEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED258798B; Wed, 27 Dec 2023 16:30:53 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63F0087834
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e7dff3e9fso1967383e87.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703691049; x=1704295849; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S9wFGQejXu2FZ8qgCDgtSD0KxmccqY69jN+uJPFqPSw=;
 b=sMMTRtEA5i1VfeQ/DWjk9TAkQxel1o1HozZC0mg3ebRvKmPJnNfeSv5bhbvcaCwbpA
 j2kfDH/LK4rChshIvg7r9cOP6hUy9E24/zMuBKdsGCs18q1lWLWmkDw88E2BQkc7+3oQ
 sNYINIiEmenceAOg3Jteuq2RTCN5RPlPV6ewLe46CK90VvLCB+moOvXiqpLRy89rAGE8
 biWIFa7q5WoCMOayAqDtijHMwWmo+WCSToJs6N6MiGvNPP9BavT3bv8h//8TYGJQwGk4
 NE3iCr5jvp+izqzwF2C1YEnN2e6DtHev1hp9Iz0quS1nbL/AFB+KQwVnjfd93ZX5DU8b
 1ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703691049; x=1704295849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S9wFGQejXu2FZ8qgCDgtSD0KxmccqY69jN+uJPFqPSw=;
 b=etfRwvUQ4clreWHeC08jcL0EC1BfTChGpyTkI+6rFlyaetixXwcUyxUPHd0cxS3b0H
 c3w8S2ZG5qj3tOVup5y2gT7AT/x3D421iUsLiBe/NmJldFzvydMb4HCyELi3CYHWXRr7
 /C9JZ+MzJDBdlqYoka51Ax0RJaTM+AhZYVXWjw8Yin/6vTdoMoz3gaw+YQo/fBRZT/nw
 ltCpI6KCeNYCrbWBaDBACVDrNVYcjrl4m+yd8SKh3pQAqlOwb/zJrjbi7crO22OvI6W9
 qjON8eWAPryimdXOdCKGK+/Y3bq8VXd5XTXj0mX56lLyY8C9njW9bk5wOm2ttkAYu4oI
 LvcQ==
X-Gm-Message-State: AOJu0YxqXGkPeoUOhZT7OnR7cndoJ6Y7qlJITCs4M/fZk+QinV6biICU
 s4XwObK8JTLwdWB+BgQaNwbqdbjrHDUn4Co8lEZKoJEWPWpeTg==
X-Google-Smtp-Source: AGHT+IF/VzxhY4OkWvdHk6Qq2FQh4U2aLnw/5ZKji4yNg96UsMkexd8L1piJ4jQox31M7aEpX5CZhpm/pzF3BVBx2yI=
X-Received: by 2002:a05:6512:ba4:b0:50e:7d20:b295 with SMTP id
 b36-20020a0565120ba400b0050e7d20b295mr2186084lfv.66.1703691049616; Wed, 27
 Dec 2023 07:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-12-raymond.mao@linaro.org> <ZYv5wc_D1VgRcQKw@hera>
 <CAEfUkU+4ePLot_81gx7JH4Fcs=qPxa-jCSEDrEXswwbHA+uyQQ@mail.gmail.com>
 <CAC_iWj+fU6kVZd2Eq6y+mw65Y3mRvq3GUkE=0Ci5WvJMvqUC+w@mail.gmail.com>
 <CAEfUkU+EvPnShF4xVowVZnWzP01XmgLFgRbsR56KXwKVho+Mvw@mail.gmail.com>
In-Reply-To: <CAEfUkU+EvPnShF4xVowVZnWzP01XmgLFgRbsR56KXwKVho+Mvw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 17:30:13 +0200
Message-ID: <CAC_iWjJXF--ahkKjKzf+eR1MEW9qLJAPLnbxY9KBY4t74vpK4Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] bloblist: Adjust the bloblist header
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

On Wed, 27 Dec 2023 at 17:09, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Wed, 27 Dec 2023 at 09:58, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> On Wed, 27 Dec 2023 at 16:50, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Hi Ilias,
>> >
>> > On Wed, 27 Dec 2023 at 05:17, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>> >>
>> >>
>> >> [...]
>> >>
>> >> > - * @chksum: checksum for the entire bloblist allocated area. Since any of the
>> >> > - *   blobs can be altered after being created, this checksum is only valid
>> >> > - *   when the bloblist is finalised before jumping to the next stage of boot.
>> >> > - *   This is the value needed to make all checksummed bytes sum to 0
>> >> >   */
>> >> >  struct bloblist_hdr {
>> >> >       u32 magic;
>> >> > -     u32 version;
>> >> > -     u32 hdr_size;
>> >> > -     u32 flags;
>> >> > -
>> >> > -     u32 size;
>> >> > +     u8 chksum;
>> >> > +     u8 version;
>> >> > +     u8 hdr_size;
>> >> > +     u8 align_log2;
>> >> >       u32 alloced;
>> >> > +     u32 size;
>> >> > +     u32 flags;
>> >> >       u32 spare;
>> >> > -     u32 chksum;
>> >> >  };
>> >> >
>> >>
>> >> Aren't fields still missing from the current version?
>> >> e.g max_size and reserved?
>> >>
>> > They are all in. Please see:
>> > [PATCH v3 14/14] bloblist: Align bloblist used_size and total_size to spec
>>
>> Ok. But why aren't we squashing this to #14 then?
>>
> I can squash other changes with #14 except the ones for `align_log2`.
> And `align_log2` with patch #12 due to the dependency.

I think that's better.

Thanks
/Ilias
>
> Regards,
> Raymond
>
>>
>> Thanks
>> /Ilias
>> >
>> > [...]
>> >
>> > Regards,
>> > Raymond
