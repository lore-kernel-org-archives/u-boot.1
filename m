Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E917C369A1
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 07:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C74C182AA4;
	Sat, 12 Apr 2025 09:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ilfot5ie";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 753A182ACF; Sat, 12 Apr 2025 09:12:31 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F4A0828D0
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 09:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6ef60e500d7so24095537b3.0
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 00:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744441947; x=1745046747; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=njlL7+4LzmIgr/rFtRs2NJdpV+3JIkJwY/2HLVRms2E=;
 b=ilfot5ieBKKhynYLKmwRGhH450LGsdk7Cr19hIGWW8Z305fdyCRWGxQKTs6HUZYYmi
 uinjj0Z0JJ418eIeoXq8z/F0r2lwAwxCT/g9CEJD6V9VNw1osKDHsb0hAxTiEZJ7769d
 WANDMEnC3XRLm/Yg0w69ugXJOwrP542LsFWH1BymOizxY9Mb7oeLXcrKQCC8MQNxFUra
 ZNumZzRdiLPWfWZbjgj/UMXpBEGmDRnIczQ2f5TrRU/Omb8/unux8P5FG38HTg1uTkRs
 QUEb/ERJbaRhWF73eqrRsAbtemBcPrjzWIz7nKxBslqKk6olywyAltr2nWLn/IjL43wn
 P2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744441947; x=1745046747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=njlL7+4LzmIgr/rFtRs2NJdpV+3JIkJwY/2HLVRms2E=;
 b=G02C9+3bLpcgSNJF9tFnZIM/Wsd8xcDvF3EzeA9yFm8nJq+5ocCaddc/U/N/gQBJm2
 ipg/3vmt4/XSjx1mvGQkkIXZIVieGR5eB11yK6tkGIf2psxEUOIXqVCrglztBMt9Njof
 +G2ZfWuDqgJYBcVKR0WhXIo25Z38CYLQtEnS94ozl8iMD5K8lVYpZsE5LJNpWuz5bfzu
 RySNMS2Xdm+PZ0Q7+1tbXDMjdMJXsBaMru0SEny3I8nN7wzSjn4d5mxv6SGjfThDitYW
 RS8f9a9k7DQjdsU5PiGsiqz7AXA2heB18YXSCAnrn95LDO6gBofBD/s0b1nEDrSgQlbi
 Iw8Q==
X-Gm-Message-State: AOJu0Yx+yygApcuZ+N1mpLOOpg78aoZ1QtWnRfX5Rh95oWJQ2kAbtRWI
 iXkX/WniftMbVJQOD+Z+jugK0t8VmgaMelIeIsXxN3VsNevvcZIc4CtanmW783dxcWfwG46QgY5
 48o3h0OA/c9cmyoODauLjDED1u/NeZO0IRbnILZsGZz4Vo/2K/6E=
X-Gm-Gg: ASbGncuH0jGtdYbfLS4P82KQLWSnr7zRt4ANL1iTFlD/b+4UlQw3+uyUWjOso57oGQg
 gP+Ak2+DUdl8a+i90vw898kK0HPpbda0zfNENkx/fEmn+bvPqv8kdR6cjb7z6tAcoDwwpfoHbr2
 Y9C6cUIhqTQ4KjH48P0tLUMQ==
X-Google-Smtp-Source: AGHT+IGvKYuLQfLKnpIgxYfeco/va7UTDzhZjNjG2k7qXF9N44Y82fIzFw7gu6Urk0okKlS186WGKUqjIOfVS6pEzlc=
X-Received: by 2002:a05:6902:1703:b0:e65:91f5:d455 with SMTP id
 3f1490d57ef6-e704df604e1mr9233210276.48.1744441947063; Sat, 12 Apr 2025
 00:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250411053256.17332-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjL+L4ad1hfz1a5J2ozUPEwmwkZSZRuU3_mb-Qz4LG3KKg@mail.gmail.com>
 <fc25a873-94fe-466d-bb9c-d38edf39f8bd@canonical.com>
In-Reply-To: <fc25a873-94fe-466d-bb9c-d38edf39f8bd@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 12 Apr 2025 10:11:51 +0300
X-Gm-Features: ATxdqUH4f8CGoZ8DLZcADWb9iBei2fuaob02fWVfWmQzplXyDc1OxpSA95yAS6M
Message-ID: <CAC_iWjLBX2W0vvpLwmedRmMdaZqmLFjzCOiyWwvfSrBAD55auQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: check executing in EL2
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

Hi Heinrich

On Fri, 11 Apr 2025 at 15:05, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 4/11/25 12:00, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >
> > [...]
> >
> >> +
> >> +/**
> >> + * current_exception_level()
> >> + *
> >> + * Return:     current exception level, 0 - 3
> >> + */
> >> +static unsigned int current_exception_level(void)
> >> +{
> >> +       unsigned long el;
> >> +
> >> +       asm volatile (
> >> +               "MRS %0, CurrentEL"
> >> +               : "=r" (el) : : );
> >> +
> >> +       return (el >> 2) & 0x3;
> >> +}
> >> +
> >
> > We have an identical function in arch/arm/include/asm/system.h, can we
> > use that? It's static inline so you may be able to just include the
> > header file directly. Also, that function adds a 'cc,' which tells the
> > compiler that the instruction might change the condition code flags. I
> > don't remember if this is needed, but it doesn't hurt to have it.
>
> The function current_el() in arch/arm/include/asm/system.h is already
> used in switch_to_non_secure_mode() when determining if U-Boot should
> switch the exception state. Including the same function both in the code
> under test and in the test should be avoided.

Fair enough

>
> https://developer.arm.com/documentation/ddi0597/2025-03/Base-Instructions/MRS--Move-Special-register-to-general-purpose-register-
> does not describe any side effects when reading the CurrentEL flags?

Thanks for the link. It seems there isn't. It's only a read and should
not affect condition flags at all.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Best regards
>
> Heinrich
>
> >
> >
> >> +/**
> >> + * execute() - execute test
> >> + *
> >> + * Check that the exception level is not EL3.
> >> + */
> >> +static int execute(void)
> >> +{
> >> +       unsigned int el = current_exception_level();
> >> +
> >> +       efi_st_printf("Exception level EL%u\n", el);
> >> +       if (el != 1 && el != 2) {
> >> +               efi_st_error("EL1 or EL2 expected");
> >> +               return EFI_ST_FAILURE;
> >> +       }
> >> +
> >> +       return EFI_ST_SUCCESS;
> >> +}
> >> +
> >> +EFI_UNIT_TEST(el) = {
> >> +       .name = "exception level",
> >> +       .phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
> >> +       .execute = execute,
> >> +};
> >> --
> >> 2.48.1
> >>
> >
> > Other than that LGTM
> >
> > /Ilias
>
