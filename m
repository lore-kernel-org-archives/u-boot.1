Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2562D637DF
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3800E895A3;
	Thu, 14 Nov 2024 04:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kmv5eGOC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A2B2895A9; Thu, 14 Nov 2024 04:53:32 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 153188957F
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso16890066b.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731556409; x=1732161209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=01LqUxzmJ0lT7nve/UiBAzVFWWhHm8+EDwPJecP9Rh0=;
 b=kmv5eGOCf2HXVJnGCqB0nR/Ar8qhH0ywPM5m/9YpqTJ+JU7UXbzVzQRl+knE3LuKoH
 zxFe4pKwDjXrDrKP0IsjOyEnsu/yFP5zlEOUVMu1dKMhOsug5gS/f51bn+PIuGbH+Urg
 2tAMMkVrcWE6QU44ZGCuwt87dz+/SrRfmcr7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731556409; x=1732161209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=01LqUxzmJ0lT7nve/UiBAzVFWWhHm8+EDwPJecP9Rh0=;
 b=A15otUW7SPw6usOnfw/0a1GM4/E8rYcQwcjbq3fyHp+faI+noDaK7ztH6tXRfEuGWY
 Asi3VK8yV/FAdSQQszz8i2yskcMQ6PmW7/4pG14xQaYhNOf2oO+79Vit0JRkTeVWEnsR
 kRToCQuJwTuCLRKJVblRiGBiWAa1pKNmpBzwBcQ+3rUcXPAMbOY2OU8cm6NRut5FP9v9
 xEicjhyl6Z/GxE9y46cJ5sntxZtG4n4ZEILPhj1RGEnmcy8AOCa3agdyS7cl/+g1Qabo
 VVTzxgHN47c1V+lDAC0xAbamSeMGB4laC+TPPRKEHqfbLnjHy1PqK3Vy3Icx+foeiECP
 25Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcUj46BJtWyYgYA1lOvJrU3bl0UBQdFiHc40oDxLRFatwvkRUaSmZ7UaFhqQvowB7b6N/jUVE=@lists.denx.de
X-Gm-Message-State: AOJu0YzbaMgIVHgo5gFtNQGkTE+sGvtOUEXkUvfsMaDIXoU/lPXBJ3Mz
 IJACdcn27r17IhZdGP1njJoa1G68TDYgvFEYCTFL4LzN+ZnsDWVVz5bT29uyl8Eoefo7pJUpwiD
 H4LRwjOjJE2rLLOK5NLWJ5tjj/pG7I5+MXHce
X-Google-Smtp-Source: AGHT+IFRlMSJs0AXNSzX6APjzDmTHtfLrBJlBg0LrscIF0BlmPqhokK+2S3S0jyDo7rlQBJ5Dlkn5OPdydenLR53kpY=
X-Received: by 2002:a17:907:1b21:b0:a99:ff70:3abd with SMTP id
 a640c23a62f3a-a9eeff25d17mr2255595766b.31.1731556409269; Wed, 13 Nov 2024
 19:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <20241031-iommu_apple_dart_ordering-v1-2-8a6877946d6b@jannau.net>
 <87zfmi4rzy.fsf@bloch.sibelius.xs4all.nl>
 <4ff61e8e-03c7-42d2-b2fe-8dba1697641f@gmx.de>
 <CAFLszTjDaQGaaL9qM_s+oxNrAkGhunGkbAjyR1giEDgnShUfzw@mail.gmail.com>
 <5FA71CBD-F9AF-442A-8564-4F663F44BF42@gmx.de>
 <CAFLszTi9As9YFFoWuD9GW6gHpriZSNVCFmq5fKkdCi9jeRuqjQ@mail.gmail.com>
 <C4EB5D10-D037-49BE-BE0A-00BD3D1514FC@gmx.de>
In-Reply-To: <C4EB5D10-D037-49BE-BE0A-00BD3D1514FC@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 20:53:17 -0700
Message-ID: <CAFLszTiaDi7Sbrjsjt42UObz1Nb8SqM8CFBdcTOAXih3pJV3PQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi_loader: remove non vital devices first
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Janne Grunau <j@jannau.net>, Mark Kettenis <kettenis@openbsd.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

On Wed, 13 Nov 2024 at 11:45, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 13. November 2024 17:03:03 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Heinrich,
> >
> >On Wed, 13 Nov 2024 at 08:17, Heinrich Schuchardt <xypron.glpk@gmx.de>
> >wrote:
> >>
> >> Am 13. November 2024 15:39:22 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >> >Hi,
> >> >
> >> >On Wed, 13 Nov 2024 at 05:52, Heinrich Schuchardt <xypron.glpk@gmx.de>
> >wrote:
> >> >>
> >> >> On 11/1/24 21:29, Mark Kettenis wrote:
> >> >> >> From: Janne Grunau <j@jannau.net>
> >> >> >> Date: Thu, 31 Oct 2024 23:48:02 +0100
> >> >> >>
> >> >> >> DM_FLAG_VITAL marks devices which are essential for the operation of
> >> >> >> other devices. Removing these devices before their users can result
> >in
> >> >> >> hangs or crashes.
> >> >> >> This potentially fixes EFI boot of Renesas rcar3 devices. Their
> >clock
> >> >> >> devices (and with this series the dart iommu) are the only devices
> >> >> >> markes as vital.
> >> >> >> The arm boot code already handles devioce removal in this way.
> >> >> >
> >> >> > There is a typo in that last sentence of the commit message
> >(devioce).
> >> >> > Otherwise:
> >> >> >
> >> >> >> Signed-off-by: Janne Grunau <j@jannau.net>
> >> >> >
> >> >> > Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> >> >> >
> >> >> >> ---
> >> >> >>   lib/efi_loader/efi_boottime.c | 1 +
> >> >> >>   1 file changed, 1 insertion(+)
> >> >> >>
> >> >> >> diff --git a/lib/efi_loader/efi_boottime.c
> >b/lib/efi_loader/efi_boottime.c
> >> >> >> index
> >4f52284b4c653c252b0ed6c0c87da8901448d4b4..7db3c95782970f8c06a970a8ee86b1804cd848b6
> >100644
> >> >> >> --- a/lib/efi_loader/efi_boottime.c
> >> >> >> +++ b/lib/efi_loader/efi_boottime.c
> >> >> >> @@ -2234,6 +2234,7 @@ static efi_status_t EFIAPI
> >efi_exit_boot_services(efi_handle_t image_handle,
> >> >> >>              if (IS_ENABLED(CONFIG_USB_DEVICE))
> >> >> >>                      udc_disconnect();
> >> >> >>              board_quiesce_devices();
> >> >> >> +            dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL |
> >DM_REMOVE_NON_VITAL);
> >> >> >>              dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
> >> >>
> >> >> Simon's patch 6224dc9ba428 ("arm: Remove vital devices last") addressed
> >> >> the same issue for bootm on arm. But what about about other
> >architectures?
> >> >>
> >> >> This logic should be moved to drivers/core/root.c instead of
> >replicating
> >> >> code.
> >> >
> >> >We could have a common helper, but it should not be in driver/core as
> >> >this ordering is more of a policy decision. Unless we can add a
> >> >parameter telling dm exactly what to do...
> >> >
> >> >BTW, Heinrich, this behaviour is exactly what my bootflow_efi() test
> >> >was supposed to check. But since it doesn't have the
> >> >exit-boot-services piece at your request...
> >> >
> >> >Regards,
> >> >Simon
> >>
> >>
> >> Why can't we generally remove non-vital devices first if all are to be
> >removed?
> >>
> >> I cannot see anything device specific here.
> >
> >No objection to that...but it needs to be in a new function, not become the
> >default behaviour of dm_remove_devices_flags(), which is supposed to do
> >what it is told and in one pass.
>
> dm_remove_device_flags() makes no specific promises concerning the deletion sequence and its internal working.

Do you mean in the function comment in the header file? We can
certainly update that.

> But obviously it will fail if non-vital redources are not deleted first.

Either I don't understand that, or I don't agree. Can you give a
specific example?

>
> Leaving this broken function exported and writing a new one has no user benefit.

This function works fine. It is not broken.

>
> We could copy the old function to a new static function that we call as needed from the old function name.

Yes, that's fine with me. Also, did you see my note about the
bootflow_efi() test?

Regards,
Simon
