Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E143C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 15:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A8478129B;
	Mon, 21 Apr 2025 17:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q4zBlP6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7715F812BC; Mon, 21 Apr 2025 17:31:34 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C658681273
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 17:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e6f4b3ebe5so7313576a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745249491; x=1745854291; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LwWvLaR8g5xbd1z5jSCDvYrtqqsX2SUsB35Abo+nJmY=;
 b=Q4zBlP6ftHO1SWYUD87j8Q8lNAGOLN1WE+B9qdHSbPjZZZanvUJJ6Aw6vDrhFTSx8D
 NyLK6ppAblFIovFcsS6+gPznkFXEQY9nLtuFxAeLPVyiLFE264beYhyGq6XMQcgiADY4
 ou5bpDnExJVi16XYkM4FmbbgB5J9/BCZ4AqXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745249491; x=1745854291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LwWvLaR8g5xbd1z5jSCDvYrtqqsX2SUsB35Abo+nJmY=;
 b=jHOIX/86v6evexbjEBKxVu1Pt8YnTEa23Kob1Oxyd8JoyP0oQJfIgf9pg2UlFJLD7z
 WhymukFG4dg8+Umrk+C4x53X/DuOBTuheMUtvjosKXeWm/ohZNKrUqxJppy1EQFwPLfZ
 22n09YZxbuXfBye3+H3o5ni71EGs2k7vu/qyt0jMV+xk7rq3D/Fi5h4UYya3GV7ipzD/
 0RurhumfdytEPNIrbaxMNcLRjryu2JmLmAEJI8eaIOmVONST6MhfxVQeq3AN/gtPyVod
 EPzH4OeMlYrOQ+HjZRSP+f/vhYDBrKUG2YEqbT+Q0u/UftwgAAwWb1jKs8zXk3AlH6k5
 Rg3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8Zj3Pkuw756o8/8aoibNbb5YaZcfXcesEkoozSMxzq+B4oSlcz03Q8qL+/H+rBBWPZdLLU6A=@lists.denx.de
X-Gm-Message-State: AOJu0YxqAuKs64HeQ6kzgHQbm6Fj/qU67xBRKp4DjS0MmcmtAUfwUd1d
 nx4Iv1uadJIGfihYMjESWKJ/bUmaB1g2OlA/qjnF1KCP3yZhClId7Dx5ZtZfadwfWU+g3969V9Z
 +u3lYD2vDvECP4mkmo8y5SRDuG7XhkSCuPllScnFfvgR3BGo=
X-Gm-Gg: ASbGncvgZhe4qbpH8TpBtq1bI/utrE2UkC9xCOBc7/m5CODdZmxAkd44iXIkTv896RK
 bABZX6WvzM7ztCmFjG0zNyrr8ZsykynV/y7q9gjPPQI9U8nKbf8/i4Omc3Fd/xxrg3P7Mgx8Cqs
 35pOsgSq/9FFkw6RbTov+IRdw=
X-Google-Smtp-Source: AGHT+IEIzUy6EVNxg8kT0aS7iS6JFjQ7GIJSoX2xNN8n5nL6CbxM5TyPNh4I2YmGeJC2qXi+xQerKF7o1RS4TKH7At0=
X-Received: by 2002:a17:907:2d0b:b0:ac7:391b:e689 with SMTP id
 a640c23a62f3a-acb74e75fcbmr884359366b.59.1745249491203; Mon, 21 Apr 2025
 08:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
 <d8f9a58a-10cd-4366-bd6f-85f4effc747c@cherry.de>
 <CAFLszThDLbf3fQySO_8u6OD3-BK2abE6NFVhvviRtrNs=PKdsA@mail.gmail.com>
 <d448af91-ebe1-432c-ae20-3e8eb2efddf1@canonical.com>
 <CAFLszTh29kgQ_bE8_gnORWH0PQ=H94=q7757mFOfiopCUL3eTg@mail.gmail.com>
 <CAM=mAOnLTX3ZB6ioyPOoR+wyNKoA2VnxCKFMUHrZyM_wpuGzOA@mail.gmail.com>
In-Reply-To: <CAM=mAOnLTX3ZB6ioyPOoR+wyNKoA2VnxCKFMUHrZyM_wpuGzOA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Apr 2025 09:31:19 -0600
X-Gm-Features: ATxdqUHrijKEPqI8xInsjUZZiJeNU7i1geV4B0D1oRP-qmwWpWnKebe7Js07u9A
Message-ID: <CAFLszTinquyp9JW=Z+w6BFkGUy3sJJuJH_CfkOdEO0FvPteAbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] buildman: allow specifying configuration fragments
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Heinrich,

On Sat, 19 Apr 2025 at 13:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> Simon Glass <sjg@chromium.org> schrieb am Sa., 19. Apr. 2025, 16:14:
>>
>> Hi Heinrich,
>>
>> On Sat, 19 Apr 2025 at 04:20, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>> >
>> > On 4/18/25 13:39, Simon Glass wrote:
>> > > Hi Quentin,
>> > >
>> > > On Fri, 18 Apr 2025 at 05:27, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>> > >>
>> > >> Hi Heinrich,
>> > >>
>> > >> On 4/17/25 12:40 AM, Heinrich Schuchardt wrote:
>> > >>> Currently we are no able to build with configuration fragments in our CI.
>> > >>> With this patch buildman gets a new argument --fragments for passing a
>> > >>> comma separated list of configuration fragments to add to the board
>> > >>> defconfigs, e.g.
>> > >>>
>> > >>>       tools/buildman/buildman \
>> > >>>       -o build \
>> > >>>       -k qemu-riscv64_smode \
>> > >>>       --fragments acpi.config
>> > >>>
>> > >>
>> > >> What about using:
>> > >>
>> > >> --fragment acpi.config --fragment fragment2.config
>> > >>
>> > >> ?
>> > >
>> > > Yes that could be useful. It would also allow wildcards, although the
>> > > code would need to drop the config/ directory prefix. Also, I see that
>> > > -z is available so perhaps that could be a (bad) short option?
>> >
>> > Hello Simon,
>> >
>> > What do you mean by useful?
>> >
>> > --fragments a,b conveys the same information as --fragment a --fragment b.
>> >
>> > We are not passing any config/ directory with the fragment names.
>> >
>> > Using wildcards in does not depend on how fragment names are passed.
>> >
>> > As maintainer of buildman, please, clearly express how you want the
>> > fragment names to be passed. "Could be useful" does not indicate any
>> > decision but let's me hang in limbo.
>>
>> NAK
>>
>> We need a file which lists the valid boards for each config fragment.
>> Buildman should parse that and it should be possible (with an argument
>> like --build-all-fragments) to build all fragments for a board (or all
>> boards), to make sure that things actually build. See [1]
>>
>> So until that is done I'm going to NAK the whole concept[2].
>
>
> Building all possible permutations can easily result in excessive numbers of CI builds.
>
> We have been breaking ACPI builds multiple times and now you block testing.
>
> I am not amused.

I'm happy to discuss the merits of both approaches, but remember, I am
your mirror. So if you can be flexible, so can I. Maybe Tom might put
up with having a file? We only need to list the combinations we want
to test in CI.

Regards,
Simon

>
> Best regards
>
> Heinrich
>
>>
>> Regards,
>> Simon
>>
>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20241108152350.3686274-9-sjg@chromium.org/
>> [2] https://lore.kernel.org/u-boot/20250329002537.GN93000@bill-the-cat/
