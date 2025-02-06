Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20608C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 21:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44CBD80E90;
	Thu,  6 Feb 2025 22:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AbM0xr58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB13E80CB0; Thu,  6 Feb 2025 22:27:24 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A85F80C6E
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 22:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5dcd3454922so2833206a12.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 13:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738877242; x=1739482042; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m0nCVyXTs4yqXIoYqHNJARFBKK5xoNqWtIrPkVMz7aM=;
 b=AbM0xr583HOTJUqYY0z4RtruJcW8eEUN4bPs+wWajEoo0W5PsbSW7K4dK8336Lxxd1
 1sHY/mJD5Xr4eFCAEtshJE9bVRrImkn1NQg3cc5M3kjHlQTKEjGEm2oYdzUfXwxYToGt
 JGxN78K8kOneyCH0qUF1mr7K0eUO730h8fDlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738877242; x=1739482042;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0nCVyXTs4yqXIoYqHNJARFBKK5xoNqWtIrPkVMz7aM=;
 b=R9gnOOR13ciYlokrC7B1nit84R8x0eSb8ZtQGPKucXRw/aUMUpdY3WONLTc6gIwXaN
 gVbny1cbAzZgKqSfMvVoq64l/1NvJzOK0tR/hYP0yE1FxxjvxO/rvZFMZZQV/GItE3gk
 fKZFVt0qGGBg3kXZmY0siVSW5N2THpbtqkyroBb05c4o2mIlK5/tThe43Upiqk+VdYl4
 WKgUd8PksZ7HhgjrkE8MbXP15rmyr0DHvtz4tpNIJGcQbmtHZ/0rCbQ4aJz5tPt2m27r
 Tx+UjV1GI3lKfWCEnQ/NfxJ4256HZXga5Gg4VYv8iwwtdQEqirCJK8qG7zwwsAW1vdbj
 YRXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwQGKkOXnFSXrgFyubPbuE1vpWmO8m6eqe5iu2oKEaKRUJmBw4zG70FjXaqMe6tFNBn/TkqJo=@lists.denx.de
X-Gm-Message-State: AOJu0YytHkUE5KGDLY95UOX2nYP/CQMrEAXqu1h7qkH06epAf7boNnex
 PU2hYlHlSf9ehWK/c71GExSHZCz9FJBFWuFlr5yb5E16iq+oKjEPM3IVtgcELsSAdur01h5cqM9
 HLuJn1XsprfGUNMEyG3bEEWqvRgTTt2weNnzO
X-Gm-Gg: ASbGncuWNYgZ9cKETNrG9m9B2j8owzh/jaRfO3PwrARZH/auUbDxjKrsHDiV5mQGSos
 /PqIFyE5LXO+MO1YEXgVfYZgslAxj/Ls7TlhgjW1gnM0aWTj+6Sv8CoCcAFYbN2VughsedKd+3w
 ==
X-Google-Smtp-Source: AGHT+IEKoJXqt13Xrz6g37FkiZ2/UGF1y0WfsyEnNHSb3ApSsxIE1JJv+CaMNn1ClbfKk6hKuZAtCUJA3NkFQPx1Eu8=
X-Received: by 2002:a05:6402:35c8:b0:5d3:e9fd:9a15 with SMTP id
 4fb4d7f45d1cf-5de4508fa8fmr1054110a12.32.1738877241834; Thu, 06 Feb 2025
 13:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-23-sjg@chromium.org>
 <3926cdd3-39e8-44da-84f4-b9c877d6ac60@gmx.de>
 <CAFLszTgN=k7mjR3-=XW7ZZOMpRPSdxuAXqszPeE4qJAwVKOnVQ@mail.gmail.com>
 <eb12d64b-c10a-4fa0-b32d-10658667814b@gmx.de>
In-Reply-To: <eb12d64b-c10a-4fa0-b32d-10658667814b@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 14:27:09 -0700
X-Gm-Features: AWEUYZmtPkTBl7AOieNUxdK_FY6XMr0tpdoQTNqV0s8NV30SYuROvGiwnjw620k
Message-ID: <CAFLszThSP4xvThtXEe+VTo2496ouUvZxQB+NxfyHP_Wv3w8ngw@mail.gmail.com>
Subject: Re: [PATCH 22/32] efi: arm: Allow use of the EFI table in the app
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, 6 Feb 2025 at 10:13, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 2/6/25 13:37, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Thu, 6 Feb 2025 at 03:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 2/3/25 18:42, Simon Glass wrote:
> >>> It isn't worth the hassle of omitting this field for the app, since code
> >>> is shared between the payload and the app. Adjust the condition to avoid
> >>> a build error in the 'efi' command with the app on ARM.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>>    arch/arm/include/asm/global_data.h | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
> >>> index 8d51111f095..6a85fb2e152 100644
> >>> --- a/arch/arm/include/asm/global_data.h
> >>> +++ b/arch/arm/include/asm/global_data.h
> >>> @@ -108,7 +108,7 @@ struct arch_global_data {
> >>>    #ifdef CONFIG_SMBIOS
> >>>        ulong smbios_start;             /* Start address of SMBIOS table */
> >>>    #endif
> >>> -#ifdef CONFIG_EFI_STUB
> >>> +#ifdef CONFIG_EFI
> >>>        ulong table;
> >>
> >> Unfortunately this field is not documented at all. Please, add a
> >> description. The description '/* Table pointer from previous loader */'
> >> given in the X86 code is quite unsatisfactory. I would not know what
> >> table the field points to.
> >>
> >> If this field is EFI specific, shouldn't it be defined in
> >> arch/x86/include/asm/global_data.h?
> >
> > It depends on what the previous firmware was. Where it is coreboot,
> > this stores a pointer to the coreboot tables.
> >
> > On ARM it is somewhat EFI-specific, although only because we don't
> > expect people to want to boot from coreboot to U-Boot on ARM. But I
> > have long-since given up betting against any particular boot
> > combination.
>
> This does not quite answer the question if we should move this field to
> asm-generic.

I didn't see that question in your response.

>
> As the usage of the field is non-trivial it should be documented.

Yes, agreed.

Regards,
Simon
