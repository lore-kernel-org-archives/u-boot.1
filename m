Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4BFEEE25C
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 11:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B39084214;
	Fri,  2 Jan 2026 12:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gYNxah4z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4E08421C; Fri,  2 Jan 2026 12:03:05 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D23A284207
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 12:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-787d5555274so109231967b3.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 03:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767351780; x=1767956580; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E7iqDqX314nX4bODYpOa5xOLyS3OOayaR8PrmzfkHP0=;
 b=gYNxah4zn/x0NRXGaUzAGc33PQBdg4on84LNx8alkZ08hkgDRGKZAluVG3YgoAbR/e
 iSkFRuqd2xlO39slSLufoamFHAOlLeQLfw4JZahHugK1MfKyueV8N9tvtPXQwsvEqrSm
 usqU1BhBjBpB9babMIcQ50dLV4mhtn0KBggEJpzt67yrRT6HkvzfFeFdcjQ9Ionh1XPs
 +cFXictzC43rZIbf5kRHwQvg04KagGBwgOygQkvQDXr4uphfUrlyimJ7yWXVTyiuFSKm
 xHmLT9RzMkigPJ99hnVoDEoHun9Ev8vyxkj8JVJDq1hUgyoPus/UbqJF8k2o47jiBojy
 NumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767351780; x=1767956580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7iqDqX314nX4bODYpOa5xOLyS3OOayaR8PrmzfkHP0=;
 b=B+W3iGkVgCTjwjtqW6nQ/XIWt2Z702SCZQWfZoSO2LqFeU++JuTurz9JE2b3mU8HUW
 PxDMyWuKIM6f9lSowMZ0DM1XXz7JCzYxkmbR7RtjPTkw9ykfdGi9NBocStupN8WnwcV8
 N1m26xGqQkcZ07ItcGuo3jn1FxAkMyE42c4nW+07ojUbGf1h2tpbqzTqiJn0XAh/vG2I
 rzzS6z3zwpRtBKA+bUjrEfRopmczqsc9opRJXJq9hDh+i54lgNEcJ26SLe1E6Eja2RkU
 1wt7u09EAOhCkUJlPizomM5UkCzhG+fZgRn7NsgNc0BdPR6Q0KGhHORALxyrVZPF1/nA
 LqQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbrhbpeNXxI3bGKYwq2xw+dROCh5xA5HU3Da+jtlpVjExP4pX7CjsI8T9L36DFWbmAkcwoRmM=@lists.denx.de
X-Gm-Message-State: AOJu0YxH0R1dbhy19EcD4qWBJnJjCm0qAs0WfWeBCWT6ruPTMiiVZUrU
 71bDKrfjDIEG8/Igh/b9IaxCo/xKBNXVr7doaxBmihUTXcV7cB08TReX1nNnOOhhLC0n7973Auz
 rQqzLZwgnra05x9Znnv/bvyUfZ15fEVZwBmzOrLxokQ==
X-Gm-Gg: AY/fxX6DbkgwKMdNzWCxZvIjwGKUmA6mnM5KsV9T64/C/FWnYngRzmqvcjfuQg8zakj
 yqkRDrHvOB9k6pcfWl6l6S+W9Une2WpnnTF/0UHDUWrd9jG/HwLj7dpG55X0Tha1urKvBYX5sEF
 7XfPpcflNWUHFMCkBEGOPpl/VlaZPvG7G2GecFnWVZ/enE+KTpmPRDDOSpHPZh+0BUA08lYtCrZ
 6J6eTt15e0G7wLMC90agymB4vnIIfG638MGgKYj3BNxCyzgQfWWT1FDIqSE4w7MKnxMcG6YXMs5
 TtitHD+pkyfs4gdWp/KvQxZ+TzFctJoOEMGnNCxUiZbPYkigRmawznz/ljQ3qEdhdtVzuLA8cuh
 zbeT4ZO8LCne+0p/fLrwioYKhZ513Z81kxgBCSaMs6n/+vyjxnrnfe98BpeMAN3vE/KLST8Ck9T
 0iPEP7X1sG3KVC9MTdfDceFm69vKKOlO1MbsT8w0qxGQ4isGDFlxtDcIBn+4OvZ60Wwq8hu3h/V
 KZYA8OHkpi+zMMbeZZSwjq92FPBD/ulau4b3lz+RVYaXg3CHmVqGY79AQ8HEmSdEj0KLo3KYaYw
 kfDdmY6HsjtYtOh/TU4Mfn8oiIV8Bi8+Wp1eYscWS5r0khx2I+ngIue/LapBLEgxtg==
X-Google-Smtp-Source: AGHT+IEWQICSWKJ5qX0e/Z1yz4Pm+4ieE5xeQKSb8aE7AC5dbZaIvpW8Ide39q9AaiT/mMdgJq/6yXlsdFXUBo4FWx8=
X-Received: by 2002:a05:690c:7483:b0:78d:6b8f:bb40 with SMTP id
 00721157ae682-78fb3f48f06mr309458117b3.30.1767351779538; Fri, 02 Jan 2026
 03:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
 <20251231191054.247270-2-heinrich.schuchardt@canonical.com>
 <CAC_iWj+VHVyOv43pMxfdUr=0e+9bjp+Gz4nzuweX1uSibObrXg@mail.gmail.com>
 <f2a7fb41-5059-4b52-95a6-d0754981d3ec@canonical.com>
In-Reply-To: <f2a7fb41-5059-4b52-95a6-d0754981d3ec@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 Jan 2026 13:02:22 +0200
X-Gm-Features: AQt7F2rwhof6SPCayi1wUujKhKLxBenNAjIGlPY57ESSSGtoELmVUnIZX1n7rFk
Message-ID: <CAC_iWjL1=C88jd4eazziSSwr5RVEfc0t6ZTAmBDrCKgzgbtYOQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] Makefile: repair CONFIG_CC_OPTIMIZE_FOR_DEBUG support
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
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

On Fri, 2 Jan 2026 at 10:27, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 1/2/26 08:12, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >
> > On Wed, 31 Dec 2025 at 21:11, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Since commit 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
> >> CONFIG_CC_OPTIMIZE_FOR_DEBUG has no effect on the non-host code.
> >>
> >> This patch reestablishes the prior logic to add
> >>
> >>      -Og -Wno-maybe-uninitialized
> >>
> >> to KBUILD_CFLAGS.
> >>
> >> Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   Makefile | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/Makefile b/Makefile
> >> index 6b5c5ee019e..2a972af4906 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -869,6 +869,11 @@ endif
> >>
> >>   ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> >>   KBUILD_CFLAGS  += -Os
> >> +else ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUG
> >> +-KBUILD_CFLAGS  += -Og
> >> +# Avoid false positives -Wmaybe-uninitialized
> >> +# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78394
> >> +KBUILD_CFLAGS  += -Wno-maybe-uninitialized
> >>   else
> >
> > There's a ifdev CONFIG_CC_OPTIMIZE_FOR_DEBUG a few lines above.
> > Wouldn't it be better to move the HOSTCFLAGS under the new ifdef as
> > well?
>
> Whether the Makefile is organized by host vs. device or by Kconfig flags
> is a matter of taste. In your patch 5f520875bdf0 you opted to organize
> the code by host vs. device (like in the pre 5f520875bdf0 era) and my
> patch keeps it that way adding the least invasive change.

Ah fair enough. To be honest that wasn't my choice, I just followed
what the kernel did in the makefiles

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Best regards
>
> Heinrich
>
> >
> > Cheers
> > /Ilias
> >>   KBUILD_CFLAGS   += -O2
> >>   endif
> >> --
> >> 2.51.0
> >>
>
