Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0EACD8C99
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 14:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37BFD84B20;
	Tue, 10 Oct 2023 16:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VewMULqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FF988071F; Tue, 10 Oct 2023 16:42:29 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4802F86A24
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 16:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-533c8f8f91dso10078154a12.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 07:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696948947; x=1697553747; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3vExcQdx6kAOxadZ/p+4Yq1f+IA2BznXNn23bGk5eDA=;
 b=VewMULqOcwfoNEPsYQDiMOr2QHssrTBT4Nlq+vGPsu8WZPr++wKz2Ox7yv/RSdkiug
 Oz4F9YOCJmOm00/lsM1Rh8H7Z0tjcuq+lx4ltAhQhry8f1MyWKDCdNB+uLJLR9De3td+
 jpEwsaMl9SRdn4SNJ4iAQIGyUPhkCUrF6ITjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696948947; x=1697553747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3vExcQdx6kAOxadZ/p+4Yq1f+IA2BznXNn23bGk5eDA=;
 b=EeWxNdCIWmh4KsEpmbbBqdQNk3YgDD1D0j9FkkVCeuZVNukIZkYUAbpVRwQ8C2KM7B
 jzTYMyCH6Jd/+Xpf3/Ags1Vtop0Gvs+c3TBDi8HcNOqmrux6JM01YkjRKxY2tRAdoO2n
 25LLffo1mq0wMLxzNV/dSdb1V/yILsstYpfECkijilf/OfvRNH4r4OoxLX5ymyDllT67
 ioZcc5301gvf3Xne4N7Kc7rjilS5NadXcqWGzTHqiHtYb9YRw7KWVQN8YB7sKkk+xfpA
 GkMA8FjqMit7ZD3I/e5f63uPLxYhxp6jX3BSJrEtiYwiNVE3Qv1sWk5pLr2ApQq+TAJX
 xmKg==
X-Gm-Message-State: AOJu0YzefaUrp7UYfdKDq44PkT/FmNrD0oyy8gq3tM8/hhGySx2zMyRO
 1GxmXpkSTLGM6pDFWoRIn+jG8hfNbTcXcbZ4MlJ7HA==
X-Google-Smtp-Source: AGHT+IGra4bTUZarMaHn/nXKB/yDaxWqkvpeqZIjY1fG9j8rVhoQDKtBh8HG55mHNKwqwwkRDgmdT+qTJ489w1A6paw=
X-Received: by 2002:a17:907:7850:b0:9ae:75dc:4589 with SMTP id
 lb16-20020a170907785000b009ae75dc4589mr18426333ejc.64.1696948946486; Tue, 10
 Oct 2023 07:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-8-sjg@chromium.org>
 <20230925004346.GP305624@bill-the-cat>
 <CAPnjgZ3ieXXhidSeqzMuPBCgy9UrvOt5zSMO671t1KG9zWAGxQ@mail.gmail.com>
 <cad8dcca-eaa5-872b-db9a-86f5438b120c@gmail.com>
 <CAPnjgZ38gfWghmejpQFkJ9y9F8fdC-Wo-YSHT_4_cu8dW1UDGw@mail.gmail.com>
 <2ffb2d81-9c63-2ce3-ccba-3d5461008a51@gmail.com>
In-Reply-To: <2ffb2d81-9c63-2ce3-ccba-3d5461008a51@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Oct 2023 08:42:13 -0600
Message-ID: <CAPnjgZ1Goy0Xt=vj6YYeOEPwYO7wkATKawQtOwCW8JTM1ShdcQ@mail.gmail.com>
Subject: Re: [PATCH 07/25] tegra: Change #ifdef for nop
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Tom Warren <twarren@nvidia.com>
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

Hi Sean,

On Mon, 9 Oct 2023 at 17:40, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 10/9/23 11:32, Simon Glass wrote:
> > Hi Sean,
> >
> > On Sat, 7 Oct 2023 at 17:21, Sean Anderson <seanga2@gmail.com> wrote:
> >>
> >> On 10/7/23 19:10, Simon Glass wrote:
> >>> Hi Tom.
> >>>
> >>> On Sun, 24 Sept 2023 at 18:43, Tom Rini <trini@konsulko.com> wrote:
> >>>>
> >>>> On Sun, Sep 24, 2023 at 02:39:25PM -0600, Simon Glass wrote:
> >>>>
> >>>>> This code is normally compiled for Tegra, but sandbox can also compile
> >>>>> it. We should not use UNIT_TEST as a synonym for SANDBOX, since it is
> >>>>> possible to disable UNIT_TEST for sandbox.
> >>>>>
> >>>>> Correct the condition.
> >>>>>
> >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>> ---
> >>>>>
> >>>>>    include/k210/pll.h | 2 +-
> >>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/include/k210/pll.h b/include/k210/pll.h
> >>>>> index fd16a89cb203..6dd60b2eb4fc 100644
> >>>>> --- a/include/k210/pll.h
> >>>>> +++ b/include/k210/pll.h
> >>>>> @@ -13,7 +13,7 @@ struct k210_pll_config {
> >>>>>         u8 od;
> >>>>>    };
> >>>>>
> >>>>> -#ifdef CONFIG_UNIT_TEST
> >>>>> +#ifdef CONFIG_SANDBOX
> >>>>>    TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
> >>>>>                                      struct k210_pll_config *best);
> >>>>>    #ifndef nop
> >>>>
> >>>> Tegra? Do you mean sifive?  That's where CLK_K210 stuff is... but it
> >>>
> >>> Oh yes, I got confused.
> >>>
> >>>> also seems wrong, you can run unit test on real hardware, and this is a
> >>>> test that could (should?) be run on that platform.
> >>>
> >>> Only if it enables UNIT_TEST. You cannot run unit tests without that.
> >>> The current tests are designed for sandbox.
> >>
> >> FWIW I have run this test on actual hardware. My intent here was to allow
> >> unit tests to access functions which would otherwise be declared static.
> >
> > Er, with or without UNIT_TEST enabled? How can it even build if this
> > declaration is only for sandbox?
>
> With UNIT_TEST of course. Although since this is a forward-declaration, the
> UNIT_TEST ifdef isn't really even necessary. If it's on actual hardware, nop
> should already be defined. So maybe this should be something like
>
> #if CONFIG_SANDBOX
> #define nop()
> #endif

It is the CONFIG_SANDBOX that I am trying to remove. Can it be
CONFIG_UNIT_TEST instead?

Regards,
Simon
