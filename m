Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0716F8D74A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6746084223;
	Fri, 17 Apr 2026 10:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ow7Ont23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E4284228; Fri, 17 Apr 2026 10:18:03 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A8483FC0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-651c5d525f6so403838d50.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 01:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776413880; cv=none;
 d=google.com; s=arc-20240605;
 b=dUm2VGwCQ5GcusyRexARLssM/duA/zPgr46fKdYsO32Ddim2ib3rXNtUsZfUgEnPHg
 Y+QcN9skcUBY5NVFfZ9hQtwBCohtzMLTxddDocdQ54Glvk33+EDyjQc9WzFiQb5d596g
 RdWUC+rL87TbCGbU2hhFOl88Sde+iHd+fub9uQCgpfJA+QhzNJtXxZnmN5+w6lgC7QAV
 sDUW+DJ0JOndSuttsr6VF8mJL4DBhOLBUpMBGf+UiMeF35Qzxk/nTXPFpm1f6v46VwvN
 8O3UQlv0T1dZQP5/jRAE8EFEvaCYKZJMtg1uxfRhY54ypAsuo4Ky3o6bVMW0YcmUZHFf
 QV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=urWwqCIqjuNkbTkDSoSg/IV5uqX10pE3oZZM9GmQbys=;
 fh=IkuYRYtWIVK1RIQT9qro7ygMRZ7BBqXmQotIu4AFxso=;
 b=J63lxXni1RGG2Fz3J6UMWJgdJZ3z40zgmoZ0HEi2u/HJXq5gRyFCm1mjdYEldaL4dA
 rWvApyCNzmhSdSJyrkHhT2SxtcYlpfuaLkhF7dMfhwOnB4/2DI4ys52uEP3F8S3AWLmY
 0XUSWz3OdmMsWupJ61kgJW+lW1SRP+oDNODij5yG80N59S4NAFV+y01k/IS7DZvEyYW6
 bK1NVxt1BZFOPCb447dH2jiiBp1AD3XmqMdXEhKfno/xhqow34sodJGdy4pRKTd6k+wd
 E+l3pbUo4z+uyiQw/ccpnG9F98JFEE480cmQWJi61ZdWX0B47wI28dG66isjGsDu+H/K
 g42w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776413879; x=1777018679; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=urWwqCIqjuNkbTkDSoSg/IV5uqX10pE3oZZM9GmQbys=;
 b=ow7Ont23AMiPnGi2CdDuwycESLakllaRdOXbOfAq+1fh1XgPo/TRUtyItVhps1Fvym
 CBl9ZSuh852QlTNqNWruM+f4OT0jKe3K9SqSSe47GABLHiaj2J47miHcbDoVaaDhgasn
 D+2vbnOLbio/5kMT3ib7E2ugMlCqK9vJc6zH6aWtkkrDbrfDZx6PwohCLTKwztpTX4Z6
 0nZLlCeb49twW4HSV7zPrLz4JDI+waSJaeeFdXsOdm1gy3DTtm5WV2NUIdHvL6PJgZ/j
 gncejyrWd44ZyJ+8zGcFYjgGVhYzjywlpi9k+S+LZfu1z1p4Z7huyAVjjvNiuoARfyKS
 dTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776413880; x=1777018680;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urWwqCIqjuNkbTkDSoSg/IV5uqX10pE3oZZM9GmQbys=;
 b=BCT1xmvmM1IZQkPLwzYnEn3TAMHM8jvetwCRS5Gy4eA3oZdiWCAB4uqJKKkqET2dXL
 TqI3FKylaEwGvime0G0s+qRuNExuRh8468zELm49W+4ijPAJUMBvmHDGSbqbdMv5NcFx
 4PaTAoXhT7Nl0JyEVN19dbNVtV5d9xRcLZjXV8WNysbcr9lmmVR6GgtF980xkSroBTHr
 GOv7zwWHUCa1uXEdWIyUVu9+h36rk3ARsV/xhrQnM/t2kLyqYcW/ZOm+PjB8Q71P/EUi
 bCvwCnpQoasIjpwXB1V6zsy39srb1fEuQGi0tKXaSj0BhWOJT0wUWPrUhHYKRXXKL3Ae
 JZiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vE9sMJh1yE8gmU8QZEWj8d+Pgu9HeuCsGcAsIUG9H85kO7zdMzLc4OS/mpvB/ZbEw/g6o5xw=@lists.denx.de
X-Gm-Message-State: AOJu0YwL/++L3LNANC3we9OzsstLmOfawEljGmM/q/t6DLK1ehulYgu0
 ftXFKBEI190YqRk7OBJ1ezKQ8LNN882VvraWAjPck3NwdOjwCcQ4uNK1yXYAvgLbF8fZAmKnLCZ
 HprtBUdEwLhLUuRfMEYBPAGYUd4AB54nk3UNf51Ircw==
X-Gm-Gg: AeBDieteU3OW3Oby8RnQ7B6y8KeLQoGU8QMrunH0PYSnKsOmhWtkkR9uBCni+m6RErG
 dcjqlQleTMHC/6t11gOCmlCwczP6QRLYzUKo+PWTce06wqN2MnGTTJhnKvZHnxrkbrwrzvVCYwi
 CHz7JNbwYqNxXBBN6XExtPuZ1f+k+SJGK6Nsceash9TZ9WtZfsKNA4ALl5OKpVQeHI0KbIJ1/VZ
 zI0zrfitqOPpvmLokHDMZHl0C1pvA9P8OW9d+wqcU+46ck++nT4bz23BOcFXf+HaOV8vdQQ8N8G
 bkboQV1omrvtuZS8PQetKBVo1z/Zce7Rjqbw6ce34g8cN6Rzx6fBHD1oHAT6KH7J7AGRAX+tEx8
 7bCjpEGa5glQUMMDyqDwHSWO/BLAQGSsxI0KH5aE9/b/mJH/4LeFK7eAxAsJMh/jn+jlXZv8jID
 taKrFNQ6U2eeaJc4FrdMTixau5fopPPiTW0kKOrksAK0E01c1KgMVeX2INsApPfKddBCNbLXORl
 6D/wg7heI3Gp8a4xBikBH3JHcQwLuwsTA42lY4i63UhVp7MPJ/UvYkU7NHnfBpPo5BbrMfmK1qw
 amylE+NR9al4QwnQmyQmRKFpoOz8v52N3dj4llcLhw0btBl8vEbfUkpzYC48gqIBHg==
X-Received: by 2002:a53:ad4b:0:b0:651:bb0b:700f with SMTP id
 956f58d0204a3-65310a6d20emr1208249d50.47.1776413879481; Fri, 17 Apr 2026
 01:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-5-rs@ti.com>
 <CAC_iWjJOzdFwAppsCKwFMf_uJ0TGi3JpSzcj+9iWegLryha5-A@mail.gmail.com>
 <DHUV0ZQ8Y0KC.1HCMIW6TK4K9A@ti.com>
In-Reply-To: <DHUV0ZQ8Y0KC.1HCMIW6TK4K9A@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 17 Apr 2026 11:17:23 +0300
X-Gm-Features: AQROBzDDXB9Sa7vIcy0D-if-GoC--4dJzb-g0HSE3sZlD3eWW-x2as0nzpmeS74
Message-ID: <CAC_iWjKtRMz1Vr7VXyw56cij=zhcSRfOdGO=XGui3uYGcp1x7Q@mail.gmail.com>
Subject: Re: [PATCHv3 4/6] efi_selftest_memory: check for duplicates first
To: Randolph Sapp <rs@ti.com>
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

On Thu, 16 Apr 2026 at 23:26, Randolph Sapp <rs@ti.com> wrote:
>
> On Thu Apr 16, 2026 at 3:55 AM CDT, Ilias Apalodimas wrote:
> > On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
> >>
> >> From: Randolph Sapp <rs@ti.com>
> >>
> >> Check for duplicate memory mappings before reporting any incorrect
> >> attributes. Could be that second allocation has the correct type while
> >> the first doesn't. Knowing there is a duplicate in this scenario is
> >> more helpful than just reporting the first mismatch.
> >>
> >> Signed-off-by: Randolph Sapp <rs@ti.com>
> >
> > [...]
> >
> >>                         }
> >> -                       found = true;
> >> -                       if (memory_type != entry->type) {
> >> -                               efi_st_error
> >> -                                       ("Wrong memory type %d, expected %d\n",
> >> -                                        entry->type, memory_type);
> >> -                               return EFI_ST_FAILURE;
> >> -                       }
> >> +                       match = entry;
> >>                 }
> >>         }
> >> -       if (!found) {
> >> +       if (!match) {
> >>                 efi_st_error("Missing memory map entry\n");
> >>                 return EFI_ST_FAILURE;
> >>         }
> >> +       if (memory_type != match->type) {
> >> +               efi_st_error("Wrong memory type %d, expected %d\n", match->type,
> >> +                            memory_type);
> >> +               return EFI_ST_FAILURE;
> >
> > This check is now outside the loop and only checks for the last entry.
> > If you wan't to split the fucntionality, don't we need a loop over all
> > memory areas and the type?
> >
> > Thanks
> > /Ilias
>
> Not necessarily. At the end of the day we can only really raise one exception
> anyway. I just think informing the user about a duplicate should take priority
> above mismatched attributes. It hints at a bigger issue.

I dont mind about the priority. We can swap that over. But with this
patch we will check for less problems than we currently do.

Thanks
/Ilias
>
> >> +       }
> >>         return EFI_ST_SUCCESS;
> >>  }
> >>
> >> --
> >> 2.53.0
> >>
>
