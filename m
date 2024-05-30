Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2FDC27C43
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 11:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6697E886C9;
	Thu, 30 May 2024 13:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YvLaUsrq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B95B886E4; Thu, 30 May 2024 13:15:49 +0200 (CEST)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCAE288552
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 13:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4e97a672dadso307810e0c.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 04:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717067745; x=1717672545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xdzJiZ5m0bTtUxGrqTFGf7RBkWc6Wg0/TPGhMgAmd5U=;
 b=YvLaUsrq/Ln8/6cPFoUnyfpHpWKujDDrItA5c09GOFeR3KUsOa6PYX/C4imusVjUja
 awGWfzfEkDoxt0xctUc4foEEgMVHJtEQ9q3Y7eV2Vmkik3oae/hnBH8NrOTrI0UndM9F
 Ko54rpIHzp8QZZ+7YnBnyNODPOQriyppgQ1PxB/dXvD/+nIbJ3XDnHt8b57WLto1J5bV
 rzRBvUazdV7/5jqu2WjUK6uMOUnqoaYWzWh5mDxxpcF9LIFY0UHtDrk+2XVkNKMZ8qoy
 96/ZBh8Fw7gYsq3ohjfQoiQ8/WcxECIr5KB0lSdidzskIa95oUwQHN7C/QRjtkmK7c+X
 RRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717067745; x=1717672545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xdzJiZ5m0bTtUxGrqTFGf7RBkWc6Wg0/TPGhMgAmd5U=;
 b=S/pUGbEDxtVm8IVXlEWXJYuLz5pt2Wd8phMInybANoMS5YtWxkCzM6+hVI+ptMa5F4
 oqlWPesmPqxzkWESK/zj8RXMyz5a9XqFBeSs2mo1r5lxil20m6lOiOmn0oMw+AyZfjR5
 yvNtt8EMSyyuL/7IlN5TIBUhJZIr71qdyxbGbbGgcI5/Rlrxj52iS19I/exjyx1Sib0F
 sOkvslsvHRoLYG/nSobTUD9N7SalAw2f4nYydBYB03PGDVJ5iWkr9O4ALBeepCaxKGzT
 R+rNZa5PM2JQc8y+evwnGmwjSGqyyRftgWMvfLzKEa5wBOGkR+CvFk0KpVullM2F/w2f
 3LyA==
X-Gm-Message-State: AOJu0YwqogsBoR5Xh7F+yGgEtaG+Pp0caJmHHmf82XCDxYTRhT3wnqf9
 hvNytMujDWF8Ba5YLU//Z6xT72RlKpBHEweE58yX23JJGHRWoEL8Yjd2HHw4HXk2zusVZVFy1FB
 i3DMdjrmXmHspofnDjwqRzxhOfD6yKeytPuLV8O+jt5bA6Fs7
X-Google-Smtp-Source: AGHT+IHtbool7r1UowB6D9wdkXFMuJJLeFXpiYUrC+6DlOAk121vB1wIuG1oinzSeX5ZO6R96oRSLoajNi+oRoUpJNk=
X-Received: by 2002:a05:6102:3a56:b0:48b:9f36:14 with SMTP id
 ada2fe7eead31-48bae9f5f6amr2183396137.10.1717067745378; Thu, 30 May 2024
 04:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240528084224.113385-1-patrick.barsanti@amarulasolutions.com>
 <CAFA6WYOGXA7rPoVG_dJTfMYmKXS=Zik+9saP70Sc82C2L_mFUQ@mail.gmail.com>
 <CABxfhNcAArLz618Z4441uVqFZrBATrRJweoU2RjMPP2WyxGnWA@mail.gmail.com>
 <CAFA6WYN1SH-f8p3-odQz2cfHiS625jMgR_NXninVExcdjyynYg@mail.gmail.com>
 <CABxfhNfWdD0NjPNskaxZxDTg9pDoDx5vBHrN9chvMh5Xo_7Kzg@mail.gmail.com>
In-Reply-To: <CABxfhNfWdD0NjPNskaxZxDTg9pDoDx5vBHrN9chvMh5Xo_7Kzg@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 30 May 2024 16:45:33 +0530
Message-ID: <CAFA6WYPsgFFNjLtTupNx1ObUBm=b6J4bMiyZRTLdb8XT3cJ3XA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Fix include directory for OF_UPSTREAM
To: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 xypron.glpk@gmx.de, afd@ti.com, marek.vasut+renesas@mailbox.org, bb@ti.com, 
 mr.bossman075@gmail.com, leon@georgemail.eu, 
 linux-amarula@amarulasolutions.com
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

On Thu, 30 May 2024 at 14:43, Patrick Barsanti
<patrick.barsanti@amarulasolutions.com> wrote:
>
> Hi Sumit,
>
> On Wed, 29 May 2024 at 14:00, Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> On Wed, 29 May 2024 at 14:45, Patrick Barsanti
>> <patrick.barsanti@amarulasolutions.com> wrote:
>> >
>> > Hi Sumit,
>> >
>> > On Wed, 29 May 2024 at 08:57, Sumit Garg <sumit.garg@linaro.org> wrote:
>> >>
>> >> Hi Patrick,
>> >>
>> >> On Tue, 28 May 2024 at 14:16, Patrick Barsanti
>> >> <patrick.barsanti@amarulasolutions.com> wrote:
>> >> >
>> >> > Always prioritizing u-boot includes causes problems when trying to
>> >> > migrate boards to OF_UPSTREAM that have divergent devicetree files with
>> >> > respect to the upstream ones.
>> >> >
>> >> > For example, migrating a board based on `imx6ul.dtsi` to OF_UPSTREAM
>> >> > breaks it, as there are some missing defines in the local dtsi file;
>> >> > the solutions would be to either patch it, which defeats the purpose of
>> >> > OF_UPSTREAM, or delete it entirely. This last option would then break all
>> >> > the other boards which have not yet been migrated to OF_UPSTREAM.
>> >>
>> >> Can you elaborate more here regarding which dt-bindings headers
>> >> conflict? Also, is it only the DTS files consumer for those headers or
>> >> there are U-Boot drivers depending on them too?
>> >>
>> >> -Sumit
>> >
>> >
>> > Sorry, I think I have worded my commit message wrong. I should
>> > have used differ instead of diverge, which is slightly misleading.
>> >
>> > The specific case I am talking about can be found in:
>> > include/dt-bindings/clock/imx6ul-clock.h
>> > dts/upstream/include/dt-bindings/clock/imx6ul-clock.h
>> >
>> > The local header is missing the last commit from the kernel, which is
>> > 4e197ee880c2 ("clk: imx6ul: add ethernet refclock mux support").
>> > This added some new defines, which are not present in the u-boot
>> > header.
>> > Following this commit, the `imx6ul.dtsi` was patched in the kernel to
>> > use one of the new defines.
>> >
>> > Because of this, at the current state, migrating a board which is
>> > somehow based on `imx6ul.dtsi` will give a dtc error given by a value
>> > being used in the upstream dtsi which is not defined in the local
>> > header, because local includes always have priority with respect
>> > to upstream ones even when setting OF_UPSTREAM.
>>
>> So you should just drop the local DT bindings header:
>> include/dt-bindings/clock/imx6ul-clock.h and that should resolve the
>> problem for you, right?
>
>
> Yes, that indeed solves my problem.
> But if I drop it, I will force all other boards which are not yet
> migrated to OF_UPSTREAM and include `imx6ul.dtsi` to
> use the upstream header instead of the local one.
> I did not feel comfortable in doing so, because if any change is made
> to the upstream header in the future which is somehow not backwards
> compatible, then all boards which are still not using OF_UPSTREAM
> would not compile.

DT headers backwards compatibility is something that upstream DT
maintainers assure us about. And we try to closely monitor any DT ABI
breakage while syncing upstream DT. Till now after we added
OF_UPSTREAM support, fortunately there hasn't been any DT ABI breakage
reports. So we should switch to upstream DT headers wherever we can
and drop any redundant local DT headers. Migration to OF_UPSTREAM can
surely be the next step but we want to encourage more and more code
reuse from upstream DT sources.

>
> I also thought this would not be limited to the single header file which
> caused my problem. I imagine there would be other cases of local
> headers which are missing one or more commits from mainline kernel
> and cause the same type of problem when moving to OF_UPSTREAM.

The redundant local DT headers should be dropped wherever we can.
Adding further defines or new clocks in your case isn't going to break
backwards compatibility but rather dropping any existing clock defines
would be a DT ABI breakage.

>
> The opposite problem also exists.
> For example:
> 675575880f ("phycore-am64x: Migrate to OF_UPSTREAM")
> does not drop include/dt-bindings/net/ti-dp83867.h, and I think the
> migration worked properly only because at the moment there is no
> difference between local and upstream headers.

That's a leftover from migration, feel free to propose a patch to drop it.

> If and when the upstream headers and devicetrees will be patched,
> this will cause problems, because the local include will be used
> even if it's out-of-date.
> I have tested this: by simulating a kernel patch to the upstream files,
> which adds an extra define in ti-dp83867.h and updates
> k3-am64-phycore-som.dtsi to use this new define, current state
> u-boot will fail to build because that define is not present in the local
> include header.
> By including my patch, the build is successful.
>
> This is the reason why I proposed this Makefile patch, but of course I
> am completely open to suggestions and ideas better than mine, which
> I suspect are fairly easy to come by :)

The additional complexity added by your patch is just needed to keep
local DT headers but that goes against using upstream DT as much as we
can and thereby reducing maintenance burden.

-Sumit
