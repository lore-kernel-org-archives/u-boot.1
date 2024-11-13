Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD897D462B2
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 14:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D90089049;
	Wed, 13 Nov 2024 15:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jZKkpUwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96E2889170; Wed, 13 Nov 2024 15:39:36 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D36588CEC
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cf04f75e1aso8283408a12.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731508774; x=1732113574; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pEKIYJjy36b66qsTOWX3KlE2V2AUg8787ImmXlErLIs=;
 b=jZKkpUwbZ6vuOtUzYdU4LPmUr4Auxhx/DcIB48cllIap1MGMDhgDvVjWL/3ZU9JRRF
 eDesFzZaM11C1dspnQAQ0aGCgtpWnpuN6vAJE3sa2kK9poDtv97hQdCeABCS1MIABpw/
 8j14c9Fnu8/1sBBxXwEMmC7DMFmx9+G64dfjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731508774; x=1732113574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pEKIYJjy36b66qsTOWX3KlE2V2AUg8787ImmXlErLIs=;
 b=JINIAlIYtlzVt5ds3ntYqmDkdJv0oyK9rqxEzvRFjWmTDR4AcuywsxQjlCaaKMebV6
 aGo40oQX38sFgcXtQrMD1n/ZtMKhadMEfAmAfuiEx43ayJPKaNwxdsJQfhlIPjPHDDG0
 psFLYtYj85P6xblMNUggbdk+pGiZBye7efPp0OjSUvSHVC0Sa94WNnPJ6m/pUxwdez2A
 GdbHBO7p93Phg0pzvnz8MF8kPWcWt/xAZSCXnljFBlzFscFfq4z8assr5/esl2k6ndAd
 NqH02jKHzySfvuXq8glctgbY3l6a7aYjSvWVvWoTe5XzjHgGAzNryRuafJbu5X/ObwQ+
 my0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyKq8Wz42s4EIP5V5sKUSp/siVVRHgI2fSkpEfLXb6/xo0oO0g9YAiKdfy96XncyRxgB5X3aw=@lists.denx.de
X-Gm-Message-State: AOJu0YzUXfYlHl4VrPTKhNWgpc5/M6e5NetiDRJG1+FHyouATXh2N+aO
 YfLNg7xhx5LIAHMRqUXr6VrlrrKgXed5q7nZnhj73/sziMyVM5LB2FlfRCxzGYHRGKojwYO0lcr
 KgaweBJHmqs44D5ltGwtsiMzIFtkOMnUAToHs
X-Google-Smtp-Source: AGHT+IEvtTHavfbI5+Nst7Z/6Gakz/7vcuBZYK1uWz5hPE41+84lhkYbzKXGzwrcszly7FK9EpslpGWkpxMo4+30auo=
X-Received: by 2002:a17:906:c10f:b0:a9a:8028:45d8 with SMTP id
 a640c23a62f3a-a9eefe9bb73mr2142410166b.7.1731508773948; Wed, 13 Nov 2024
 06:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <20241031-iommu_apple_dart_ordering-v1-2-8a6877946d6b@jannau.net>
 <87zfmi4rzy.fsf@bloch.sibelius.xs4all.nl>
 <4ff61e8e-03c7-42d2-b2fe-8dba1697641f@gmx.de>
In-Reply-To: <4ff61e8e-03c7-42d2-b2fe-8dba1697641f@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 07:39:22 -0700
Message-ID: <CAFLszTjDaQGaaL9qM_s+oxNrAkGhunGkbAjyR1giEDgnShUfzw@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi_loader: remove non vital devices first
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Janne Grunau <j@jannau.net>, kettenis@openbsd.org, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de, 
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

Hi,

On Wed, 13 Nov 2024 at 05:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/1/24 21:29, Mark Kettenis wrote:
> >> From: Janne Grunau <j@jannau.net>
> >> Date: Thu, 31 Oct 2024 23:48:02 +0100
> >>
> >> DM_FLAG_VITAL marks devices which are essential for the operation of
> >> other devices. Removing these devices before their users can result in
> >> hangs or crashes.
> >> This potentially fixes EFI boot of Renesas rcar3 devices. Their clock
> >> devices (and with this series the dart iommu) are the only devices
> >> markes as vital.
> >> The arm boot code already handles devioce removal in this way.
> >
> > There is a typo in that last sentence of the commit message (devioce).
> > Otherwise:
> >
> >> Signed-off-by: Janne Grunau <j@jannau.net>
> >
> > Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> >
> >> ---
> >>   lib/efi_loader/efi_boottime.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> >> index 4f52284b4c653c252b0ed6c0c87da8901448d4b4..7db3c95782970f8c06a970a8ee86b1804cd848b6 100644
> >> --- a/lib/efi_loader/efi_boottime.c
> >> +++ b/lib/efi_loader/efi_boottime.c
> >> @@ -2234,6 +2234,7 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
> >>              if (IS_ENABLED(CONFIG_USB_DEVICE))
> >>                      udc_disconnect();
> >>              board_quiesce_devices();
> >> +            dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
> >>              dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
>
> Simon's patch 6224dc9ba428 ("arm: Remove vital devices last") addressed
> the same issue for bootm on arm. But what about about other architectures?
>
> This logic should be moved to drivers/core/root.c instead of replicating
> code.

We could have a common helper, but it should not be in driver/core as
this ordering is more of a policy decision. Unless we can add a
parameter telling dm exactly what to do...

BTW, Heinrich, this behaviour is exactly what my bootflow_efi() test
was supposed to check. But since it doesn't have the
exit-boot-services piece at your request...

Regards,
Simon
