Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B35CD494C
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 05:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED6A686CF6;
	Thu, 21 Sep 2023 07:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M+f0vBgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A192986CF6; Thu, 21 Sep 2023 07:09:24 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8DD286D0A
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 07:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-532aaba8747so530278a12.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 22:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695272962; x=1695877762; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRzAYBsNfKLtzS29ydfssRKmbT4osFoZ/dopX2/V4N4=;
 b=M+f0vBgPFW9A9SJQhvc8e9oA7cTVjcn6UnmhZGnjxLC9XxTc1eNrndBrubzDFt6c1O
 euTqTQnHMs40BkGVWrRVHFzIWxa0w/TGS2PqXqktlJJKzkK0V2FkjAE9SZy0/rBTf8kc
 sYnDynWknIz/Mrh+u0irE9IIN/Of/JsJVByN0G8bjzEWfVv79U4hb9pFRYVbAUSOL74V
 GQt3epM/y+SEOShIe1fnpO8zRTWto7G9hVL1Djri7w6lWacAztKax+8UTIis69Tm+XNW
 2RLTMLCZ1fDiPe52rnQzrhYTjB9/a1UeO0eE2S9SiKmKpvkP21ma5J4hOL8FClrduZM4
 dTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695272962; x=1695877762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRzAYBsNfKLtzS29ydfssRKmbT4osFoZ/dopX2/V4N4=;
 b=MhwcXDHZuUap86vkHeJAK3+RmEkq6qarRm8gWjrjuA0Jf+Eh24/4vd5jzjAl807RyE
 UOruL1OsMlYWESSuljrTKpf+JC7stldYANHRnfdJ5I+IjSqALeOCPzJp6Q5oggOSOhrd
 7LS9Xb3pNWa1I6yQsTH/dAmhXDHsTmK89fTXqIz+zD5TfY9OAccH3Y1VBHARkmpj33FE
 jOWNaq2NqmyooQ2YmYhJRd4juU4vku6HNcFFnoO1fMzE67TbJZhI0o2tU6SSSKYr5bh1
 pTEQMvgqPus3QNeYxa1iAQA1yflSYls83mPIcuDgMZAtOhhaGKT/7uemmvBFzOdXjmeo
 jY0Q==
X-Gm-Message-State: AOJu0YyHDbAOwMOAvM1wCGEB8/gdsneoIlmqlIunRL2TQZQ4y7XamiKd
 Orj7mpgz4GmgjMR4aUYMn4nXU/4dTh/G7b4o1ZnbNrAA
X-Google-Smtp-Source: AGHT+IG4w9o6V7wevbNiXZ0I6HmL798ArgcE39RZgBu6WmYaAgpAX2P2+Bp7dcuWU3NfTs0pBOZZGjqsyX647pKgieg=
X-Received: by 2002:aa7:c0c6:0:b0:530:a226:1f25 with SMTP id
 j6-20020aa7c0c6000000b00530a2261f25mr3551544edp.17.1695272962112; Wed, 20 Sep
 2023 22:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230920030027.1385833-1-sjg@chromium.org>
 <20230920030027.1385833-9-sjg@chromium.org>
 <6c3f7c16-c67b-4c7d-9d91-0e214702fa88@gmx.de>
 <e40d4f2f-7fdf-d565-eeba-ca27f1fa44d7@denx.de>
 <54f9ad4b-3b76-4c7d-8f82-da9ab850f1e8@gmx.de>
In-Reply-To: <54f9ad4b-3b76-4c7d-8f82-da9ab850f1e8@gmx.de>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 21 Sep 2023 13:09:09 +0800
Message-ID: <CAEUhbmV6jb=3FfB=i=DVUFh4f=+zGWiudKyqjwzEyVBfcYRQfw@mail.gmail.com>
Subject: Re: [PATCH v5 08/20] x86: coreboot: Drop USB init on startup
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marex@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Wed, Sep 20, 2023 at 9:37=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 20.09.23 13:50, Marek Vasut wrote:
> > On 9/20/23 09:19, Heinrich Schuchardt wrote:
> >> On 9/20/23 05:00, Simon Glass wrote:
> >>> This is very annoying as it is quite slow on many machines. Also, U-B=
oot
> >>> has an existing 'preboot' mechanism to enable this feature if desired=
.
> >>>
> >>> Drop this code so that it is possible to choose whether to init USB o=
r
> >>> not.
> >>>
> >>> Use the existing USE_PREBOOT mechanism instead.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>> Changes in v5:
> >>> - Make use of the uSE_PREBOOT mechanism
> >>>
> >>>   arch/x86/cpu/coreboot/Kconfig    | 1 +
> >>>   arch/x86/cpu/coreboot/coreboot.c | 4 ----
> >>>   2 files changed, 1 insertion(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/x86/cpu/coreboot/Kconfig
> >>> b/arch/x86/cpu/coreboot/Kconfig
> >>> index b97c27790419..178f8ad18162 100644
> >>> --- a/arch/x86/cpu/coreboot/Kconfig
> >>> +++ b/arch/x86/cpu/coreboot/Kconfig
> >>> @@ -25,6 +25,7 @@ config SYS_COREBOOT
> >>>       imply FS_CBFS
> >>>       imply CBMEM_CONSOLE
> >>>       imply X86_TSC_READ_BASE
> >>> +    imply USE_PREBOOT
> >>
> >> For automatic initialization of the PCI bus we have CONFIG_PCI_INIT_R.
> >> Wouldn't it be preferable to also have a CONFIG_USB_INIT_R instead of
> >> relying on console commands in CONFIG_PREBOOT?
> >
> > I'd much prefer 'preboot=3Dusb init' or whatever console command, since
> > this is not hard-coded into the U-Boot binary and can be overridden by
> > user if the 'usb init' is inconvenient/unnecessary/... without replacin=
g
> > and/or rebuilding the U-Boot binary.
>
> Just for the record this means using CONFIG_PREBOOT:
>
> include/env_default.h:
>
> #ifdef  CONFIG_PREBOOT_DEFINED
>      "preboot=3D"    CONFIG_PREBOOT    "\0"
> #endif
>
> Thank you for the clarification.

Will you update the coreboot documentation to mention the PREBOOT
mechanism to initialize USB so that a USB keyboard can be used as the
input for the U-Boot console?

Regards,
Bin
