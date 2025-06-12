Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ADDC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 05:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44A9F82977;
	Thu, 12 Jun 2025 07:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fVMzvOOG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E0E82A4B; Thu, 12 Jun 2025 07:14:09 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE331828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-32b31afa781so3478401fa.3
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749705247; x=1750310047; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UfJEbEMPssPBS1sDRnXen92VhSHkBVZUre35gWnK7aY=;
 b=fVMzvOOGFNHOGd5qdSlJH/rRk1jmPg6Gl0RK1gfSnIVz45tmFQHDZRC2nSJcyTidsF
 Ih4C74tw+fmyEppJ0wFIq/baHNYJRzE+lrlN0ZMpBvJe2iGxGYWzNesFGlThjQa3zGrs
 rzhXNzCtr3cRBdgTjuQzR8zUbbR9yjtgKFg+yUH8HppJthhQYtLLnT9+3Pc1YWNmN/aD
 JO25obXxaJkxN78x8eqRRt0eJ8izLZ2YolwCpgqYLC5Pof9ov/CCtO3kqBmGbaI+GWL5
 Gl5PiQGcbRkOwfKi3EWsB4P5CFFsxWmTH/VhZ7/2WsTF/Oj8EgLKJk/2bc4cuzc6E3G/
 EjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749705247; x=1750310047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UfJEbEMPssPBS1sDRnXen92VhSHkBVZUre35gWnK7aY=;
 b=amP6vTkH8l5YUowVA6E0mR4yqu8wWyKi3WhFiD6XCxQlswkzBvCnfAIm5fnzhNAPoS
 5ErozFvxOcauD5VtiLVsaoGBjCspptrbcvv6D2DlhPnVN3LBecmR7TbvM2r9WVEFK+Ei
 Xg15Y0jpfFGGC5RJii8nBS3NfoLSt/wJGhM5LwShaPk+HErakXYAmaue9aR6aR4IQf+u
 gTbAzWNRS/ktkr09+h3NJ6dBzrl2Qcqk3lPJHHr9yTbW6rNM9wMu9jnNMWPh7+XpUfU8
 IDSL6Tq2G+lf3Ekzr7IXNa/z5Kv43UFJQC6mtBCamtS6862blo4/5/hZcnZKggp6kLKi
 ajeA==
X-Gm-Message-State: AOJu0Yw2FObRx0UHOEHVhBY96ieFxmQSR7pMbTvD+4+DHBZnyEa4C6Qy
 ey1NeTe3UROJqKu3bDGPLN5MEsefKK3TzgTWPrmUZKsP3YxmTO/aHXxpJLoUFH0wTsfby6MlA2R
 K80kwKAAUjnwjn3kRPr90+fh9c9pKH80=
X-Gm-Gg: ASbGncsEVtuPnLo2ufmNqRl47MeoSzDGe8fb6WEoo3KKVfE8sEzsxgefggahqx/L0D7
 tQQ9WKnNZGvYkmsoXWOO10ZCBJiJqpaQiBbHnbgQfdqK8JuPaZkQem0wiR1Sqzu/kD7VO/xakY7
 GbFtDH4dBtej65qQ/G6y6RYwyvl77yVjFD0IXRM+qFgutA
X-Google-Smtp-Source: AGHT+IFnZLTPmiy9wcVVfQHkgMepv0WA8bHNkLy4/hJ7JQJbBLG/Tvt/PsEt0mU3RtZzYy/7shZ7Tn6bMMN8LOH3VsA=
X-Received: by 2002:a05:651c:210b:b0:32a:88b8:9ab with SMTP id
 38308e7fff4ca-32b30705d9fmr5738561fa.27.1749705246766; Wed, 11 Jun 2025
 22:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250611142352.3990076-1-trini@konsulko.com>
 <174968817336.20873.2253388108943248289.b4-ty@konsulko.com>
In-Reply-To: <174968817336.20873.2253388108943248289.b4-ty@konsulko.com>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Thu, 12 Jun 2025 07:13:54 +0200
X-Gm-Features: AX0GCFu6KfN_Q0Fezs9GI1DO0AAyNoyxbbtkGq9NjAXn1XB7WjNWXo4agTJgZ5M
Message-ID: <CAEyMn7aseZADnoRWVrgrbKBAK8xjZiLLtMBEe7yyOLmiJWY1Dg@mail.gmail.com>
Subject: Re: [PATCH] mmc: Kconfig: Really correct dependencies SDHCI ADMA
 options
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

Am Do., 12. Juni 2025 um 02:29 Uhr schrieb Tom Rini <trini@konsulko.com>:

> On Wed, 11 Jun 2025 08:23:52 -0600, Tom Rini wrote:
>
> > When doing the investigation for commit 53bb8fdea12a ("mmc: Kconfig:
> > Correct dependencies SDHCI ADMA options") I missed the implications of
> > MMC_SDHCI_ADMA_HELPERS. The problem is that FSL_ESDHC via the
> > FSL_ESDHC_SUPPORT_ADMA2 option will also enable these helper functions.
> > This in turn means the correct dependency here is
> > MMC_SDHCI_ADMA_HELPERS and not *MMC_SDHCI_ADMA.
> >
> > [...]
>
> Applied to u-boot/master, thanks!
>

Just tested the latest master. Looks good.

Thank you for the quick fix.


>
> [1/1] mmc: Kconfig: Really correct dependencies SDHCI ADMA options
>       commit: b62e422d6e6878e9bca1d20fe372ffdd7db294fa
> --
> Tom
>
>
>
--
Heiko
