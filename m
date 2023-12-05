Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D451CC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 00:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1160E878B2;
	Tue,  5 Dec 2023 01:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U0NT0O7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F8E87899; Tue,  5 Dec 2023 01:53:02 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26F248789A
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 01:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5d8a772157fso15191797b3.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 16:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701737576; x=1702342376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i6nzNYH97fV3Wy6vvcuDon5EUIU3268a9rKoWkbSvao=;
 b=U0NT0O7xlzIOOPAqs4Jn1ICYDDTtWhD/wN7TjBKeaNC8lpOga+HgKVyoLLvH1HyQ3X
 /QIHvte/NwFOybUyJ4SpDFDoTAnAJxW25TG4gmhK/Obh2ZfBA2yaH3T8NG4YEdV8dZZ5
 uXZbtlGQ+sKuTdh4uWDgBWvLMxp5dUJ/npVSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701737576; x=1702342376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i6nzNYH97fV3Wy6vvcuDon5EUIU3268a9rKoWkbSvao=;
 b=YNwtG0p4gZwI8k3jqLDkoqNZzWH0mN551HDQu7O19scH2EKpJxNU4hIzLYkoXcxIuv
 sU718UEFO00OZbUdQs4qF7p92ta4I3NNwU8ejkc8k1dA2Ecq2v/MHIK5R/64RBo/gC8J
 Cn1VmKdLBs21U12lmISIGTcgNTVAKh3AIHdrIQI2ZxDl822vOD4k0o1jxHP3mK8ZdvhC
 USfUsJaNnUmWFAhYfZF01pi5173+DjEI/6UleMOMiTcxK04RbX3XlAedK7RrvSCs+oR0
 CxC7D23pZF+DckKlinjn2IazJg/eqCJ4YTSGOWGOoYJmG2X6BNpKwWQW8kxs2LCpLGLP
 aUQw==
X-Gm-Message-State: AOJu0Yy2eril+7GUDz4puwDXKtmIvce+vrujnEX5m6iXS5xyIpxqlJeQ
 IvT4qODhgoLmqAP2DewS/DuFinXNW7lALy2N5stkfg==
X-Google-Smtp-Source: AGHT+IFLLkCoUMohDuh1kgXFPibTQ7VeSgDRTvvwQkr0HT9Pe24EpFeeTHI34y0o2K1ZPkO5RB4fzG8tZBFbfSDmdbg=
X-Received: by 2002:a81:99d2:0:b0:5d7:1941:abe with SMTP id
 q201-20020a8199d2000000b005d719410abemr3681912ywg.89.1701737575645; Mon, 04
 Dec 2023 16:52:55 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-18-raymond.mao@linaro.org>
 <CAPnjgZ16Cv5r6GB0j_WXTPTsASGj=Hi5Cdytyo-K7a-c73AeoA@mail.gmail.com>
 <CAEfUkULfyrxaVhmcWrQEitWAiJHCA_WPZPbQ_5HyQArZonCE0g@mail.gmail.com>
In-Reply-To: <CAEfUkULfyrxaVhmcWrQEitWAiJHCA_WPZPbQ_5HyQArZonCE0g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Dec 2023 17:52:10 -0700
Message-ID: <CAPnjgZ2q4C1shN3kz3NpKLgQE=wZU0f2CCArtMtWg6P1vz=yWg@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] qemu-arm: Get bloblist from boot arguments
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Sean Anderson <seanga2@gmail.com>
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

Hi Raymond,

On Mon, 4 Dec 2023 at 13:06, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon
>
> On Sat, 2 Dec 2023 at 16:16, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Raymond,
>>
>> On Mon, 27 Nov 2023 at 12:53, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Add platform custom function to get bloblist from boot arguments.
>>
>> This should be the same for all ARM platforms. The ultimate goal is
>> something like [1]
>
> Yes, I agree. The current series just focuses on Qemu but ultimately should be adapted
> to all Arm platforms.
>
>> >  #include <common.h>
>> > +#if IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST)
>> > +#include <bloblist.h>
>> > +#endif
>> >  #include <cpu_func.h>
>> >  #include <dm.h>
>> >  #include <efi.h>
>> > @@ -102,6 +105,16 @@ static struct mm_region qemu_arm64_mem_map[] = {
>> >  struct mm_region *mem_map = qemu_arm64_mem_map;
>> >  #endif
>> >
>> > +#if IS_ENABLED(CONFIG_OF_BOARD)
>>
>> OF_BLOBLIST and please avoid #if
>
> I will remove the build option for argument copying, as they don't really depend on OF_BOARD
> or _BLOBLIST.
>
>>
>> > +       /* Check the register conventions */
>> > +       fdt = (unsigned long)bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
>>
>> This should happen in fdtdec.c automatically. See [2]
>
> The reason I have to call `bloblist_find()` here is to get the fdt address and compare with
> arg0 and arg2 (see below few lines of code) to check if it is compliant to the register conventions
> for AARCH64/32 defined by the FW Handoff spec.
> This is better to be placed here instead of fdtdec.c

We should first sort out what we are doing with my patch...as
mentioned elsewhere Ilias and I did discuss it, but perhaps not for
long enough.

Regards,
Simon
