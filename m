Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCFBC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 17:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75EA188422;
	Tue, 28 May 2024 19:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HV+sRN0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D42C088445; Tue, 28 May 2024 19:57:02 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC33C883F4
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 19:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-529597d77b4so1458719e87.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716919020; x=1717523820; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yYpiU4fsTk9n+yKg9M6/lPft5+fnKar0qXgpqwvRYTs=;
 b=HV+sRN0zeh1fVbxWzQnqzzHzPnYKOTmYGL3R3i1Qj0x0mv+wYC/iiVU1mihiwVN3kt
 gT7eKtUbGdGfw2S9atTHhuzLsBLhzTMj5YmAxf9NfDB2QAkb/Db5MlK5C+hadAcOxwow
 vmGNtB2Krnz3iyKcv+qDGZp9lWBG63SM7EmxPoIzMHkEmf8DALdIZnKtFxv7pOQFPyIh
 bs/FKb0glsEBnSoJ3CwJ70wXH83CLRnAR9zFT6tjeEmpYHMIMXDlWQVqBw+EAH3tkHhC
 tIYs7QbVKLZHVVVDibuNdnA8B5Vlrve8esAcWr3zf+PVTjWvT9PQRMMuFde4KSPdXYsW
 fPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716919020; x=1717523820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yYpiU4fsTk9n+yKg9M6/lPft5+fnKar0qXgpqwvRYTs=;
 b=czisOJTFtkuIRtZx5Rhv5wdN4fnCpcv22XscExoXW8yGCFhHaPH+23ubHxr4PZEN2B
 v46SUPWJPzoDbKnJUtUV97ZG/sZozgldjXtsCnAUszQVVV6WmbC8F7x+9Z4h7MlqTkD0
 +6oGmwb8KmHY7doxsAOJEIKlb0XHhsHRYVFs43dpRxSyQ8Ttph63mwo4MyK9XTpfuhKp
 dhB+KczEF1rxKNpgNTWylVabql3l9hV9/bPsnRLzdT6uVxylDoT26ujHDVDjv/QDiWuX
 tJgF0AevTE10uVfMGjtPDTK6RgJeVKrZDPPr7YnjBGcBzGIAAgHNQ8Y+fKfGNlYPh/NS
 fmvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVikF13wp8LHBEqOxNz84Sje6yVzd4qKRAGy4r8YGS3CznhjT4DPcUcNcAKFpxOdWFOhOjftKXAR1hQeD/MQO3fYA8sbw==
X-Gm-Message-State: AOJu0YxtWKLkjVjLgoqQbuSw212oVO489eXo66YoUa9M+r4NKzWfxmC2
 MmXNFvvuGd0l21L/O4M4nSis8tV9ixv6jOUHjLjOsb6uBobjiGdNvyELHlPuVfzyuWwp1Ia5AMQ
 7IVFLZxT8RNZirIlNecx4SCKqB+1AzmsWETrnWw==
X-Google-Smtp-Source: AGHT+IGw9jxid7/T9yXv3fx7DACfRgPwonU754nGhVr3yyoD7MPUWJqn2hncFcXdirS2E1RjgW+/5LNVaFDWv1o6hr8=
X-Received: by 2002:a19:ca1a:0:b0:522:29f5:3b09 with SMTP id
 2adb3069b0e04-529667cf9eemr7141995e87.47.1716919019773; Tue, 28 May 2024
 10:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-2-heinrich.schuchardt@canonical.com>
 <CAC_iWjJFiSrPZveDDhX7wW9J-gBiTCUw2jXpw9MG_+K3nsGaEA@mail.gmail.com>
 <9bcf8dff-1c67-477c-b425-cbb79f5ecfc3@canonical.com>
 <CAC_iWjLwRsgWK33q76rwqg0ovE4h80SHZTjjUqPUsPMgdh7SbQ@mail.gmail.com>
 <ea4d7ee9-811b-4713-9fc1-f5084d8c2d05@canonical.com>
In-Reply-To: <ea4d7ee9-811b-4713-9fc1-f5084d8c2d05@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 20:56:22 +0300
Message-ID: <CAC_iWj+RLCUzMD8VEvpQ-2bFFUGC4AWWkkaRY0f69=2wzV0O=g@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] efi_loader: allow concatenation with contained end
 node
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Tue, 28 May 2024 at 19:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 28.05.24 18:18, Ilias Apalodimas wrote:
> > [...]
> >
> >>>> -               unsigned sz2 = efi_dp_size(dp2);
> >>>> +               size_t sz1;
> >>>> +               size_t sz2 = efi_dp_size(dp2);
> >>>>                   void *p;
> >>>>
> >>>> +               if (split_end_node < sizeof(struct efi_device_path))
> >>>
> >>> Can we be more explicit here pls? Someone might misuse this in the future
> >>> split_end_node < =1 ? And we can document we can use values up to
> >>> sizeof(struct efi_device_path) if we ever need extra functionality
> >>
> >> size_t split_end_node cannot be negative.
> >>
> >> The case split_end_node == 0 is handled below. What are you missing?
> >
> > someone misusing it and passing a value of '3' for example and print
> > an error if the value is
> > 1 < value < sizeof(struct efi_device_path)
>
> I would like to avoid over-engineering. How about
>
> -               if (split_end_node < sizeof(struct efi_device_path))
> +               if (split_end_node < 2)
>
> and changing the function description to refer to >= 2?

Nop, in that case, I prefer what's already there, simply because
values between 0 < sizeof(struct efi_device_path) will be used for
functionality similar to the one we have for 0,1 in the future

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> > Thanks
> > /Ilias
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>>
> >>>> +                       sz1 = efi_dp_size(dp1);
> >>>> +               else
> >>>> +                       sz1 = split_end_node;
> >>>> +
> >>>>                   if (split_end_node)
> >>>>                           end_size = 2 * sizeof(END);
> >>>>                   else
> >>>> diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
> >>>> index c95dbfa9b5f..ac250bbfcc9 100644
> >>>> --- a/lib/efi_loader/efi_device_path_utilities.c
> >>>> +++ b/lib/efi_loader/efi_device_path_utilities.c
> >>>> @@ -76,7 +76,7 @@ static struct efi_device_path * EFIAPI append_device_path(
> >>>>           const struct efi_device_path *src2)
> >>>>    {
> >>>>           EFI_ENTRY("%pD, %pD", src1, src2);
> >>>> -       return EFI_EXIT(efi_dp_concat(src1, src2, false));
> >>>> +       return EFI_EXIT(efi_dp_concat(src1, src2, 0));
> >>>>    }
> >>>>
> >>>>    /*
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>
> >>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>
>
