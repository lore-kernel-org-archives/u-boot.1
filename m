Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0D3C36010
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 11:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8993181E8C;
	Fri, 28 Mar 2025 12:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eQdKQUms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75418805C8; Fri, 28 Mar 2025 12:34:32 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B10981E06
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 12:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so266275366b.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743161670; x=1743766470; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fXIt0zmYICAu9eikf6V4qbVRXjIUUpVeY1nW9T/3tNE=;
 b=eQdKQUmsss1kq+FwCRcUzz1y5I49AxUGtr//PhY3UR+6DeP9qg8TtyiAYbqsAeaozL
 D0dVx78xbLuMWpetL/W3ELGdGsNkeZAPL+q6Sya6MawkEkTtUKNv1FMhh39ZbLCi5wiV
 SZ5t+cZfHAGdkXf2UEPhO2+Eb46N4RjG5/EjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743161670; x=1743766470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fXIt0zmYICAu9eikf6V4qbVRXjIUUpVeY1nW9T/3tNE=;
 b=FSI3J+7Qoc5UycgldRDkMtexUatjuGMC0VsMJ9raCRdi/EbnnS09RhRRdLUNnjpfKr
 ccFLiYknx8vXQxqwnbAfT9EjOH2MEU3Nq+i+QBOfSW8Fx9w4wjo57SgAAHbKxHlPS38D
 vK1i3bHMdWqDgg9K03/BluUB5zgwnIOnz149qZtTLZxY9NIi7Wz0SLztKKiQa5L/H+74
 rL4uSaoqON/A8+TPZl+Xm/D88f91QS9BUgqA5IM1YzqkiUJiFwAcEOZga9JvWe9g4iQV
 TD59Ufo+jcAlt6wENAWIsx0wrnXg+H/tJqbNXvEKsa2GAPxq5BlxPavdy4QobxGU7pG4
 jeYA==
X-Gm-Message-State: AOJu0Yyh+mscmmYNn9kOYW1XqyX1Kax8x5gsIxtDuNfolwlcxBFbp1mO
 lzgEj1MPV60E6XrX7Q5ZsGhrjRtjfo1ADkdw5UxMcB1XlDGFKe23yLJ82fZUKIepL3VeULMKgS6
 KnL+k5YnFynHK5aZyZYyE5Xn70Sev2vAQ7QXq
X-Gm-Gg: ASbGncvJvuICZbYvf+1sYUGDogMDr7S6MZR6ohjLopalJzdsRr7XqOXUlK2EI9I+iNN
 4vcTggEaLxHUCuo2YpHnOrOMPRTaVNgzOUFnMzpKjn7jM6Qm+FlXNtHkyWraiPa5CoDDoN09okX
 Dz9WLQw8vWevghmpcJRJM0nVGQLOk=
X-Google-Smtp-Source: AGHT+IFXxW0PGfChDwby+87/yxudoxXDZ7GasB1tgTMJah1q8afzc4wZELvk8ozkJgydjPJ+M1K4tSSBEq+bxpXU+Ic=
X-Received: by 2002:a17:907:c1f:b0:ac6:ed4a:b271 with SMTP id
 a640c23a62f3a-ac6faf03c04mr639806766b.24.1743161669892; Fri, 28 Mar 2025
 04:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-23-sjg@chromium.org>
 <a9ac4bc4-5732-4c14-a11d-dc3c9e0ae4e5@linaro.org>
In-Reply-To: <a9ac4bc4-5732-4c14-a11d-dc3c9e0ae4e5@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 05:34:16 -0600
X-Gm-Features: AQ5f1Jrwpbmdj1734Vd0S1O6I34xiI7-Fzn9bueRU47CjG2QuZzyHHHeqpEQbZQ
Message-ID: <CAFLszTjppAyOHqa8Nrqt=tm2BvEm6CP3QANSf2se_tivso=v5w@mail.gmail.com>
Subject: Re: [PATCH v4 22/29] efi: arm: Drop startup code from the app
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Raymond Mao <raymond.mao@linaro.org>
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

Hi Caleb,

On Thu, 27 Mar 2025 at 10:33, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 2/15/25 04:22, Simon Glass wrote:
> > The EFI app uses different startup and relocation code and the existing
> > code uses symbols not present in the app. Drop it.
>
> Shouldn't this be squashed into patch 18 ("efi: arm: Omit the ARM
> start-up code in the EFI app")?

Why is that?

> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > ---
> >
> > (no changes since v1)
> >
> >   arch/arm/cpu/armv8/Makefile | 2 ++
> >   arch/arm/lib/Makefile       | 4 +++-
> >   2 files changed, 5 insertions(+), 1 deletion(-)
> >

Regards,
SImon
