Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4026EC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 14:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A326832BC;
	Wed, 28 May 2025 16:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZOQkglZs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEF75832EB; Wed, 28 May 2025 16:39:09 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6863D832AF
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-604e299b5b6so1928239a12.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 07:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748443147; x=1749047947; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DSVRr3fBrjzZLjWJ6ziSqf1maH3IjgJWnZ07A2hgtPk=;
 b=ZOQkglZs9cgF5KuOKxPmU+XI+nJELDTYImJsG1GU0HJ1z/5NWv9MQzwOh+8GkIOrhb
 OvqxJU5Yim+kavbiNwTICfFqnpaEiLpdfUC+Iu56QE07kDQ6GdqPJPyqYPpg6gDT/bQM
 /8A9ZQIq5CVsZIbOHCWHc84BeU/9vSdXN6OuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748443147; x=1749047947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DSVRr3fBrjzZLjWJ6ziSqf1maH3IjgJWnZ07A2hgtPk=;
 b=d4UehA1dX5Y6IQIjhGRoxRYyXBkyUpgcdI+IFatcFHf1tOcGQSVWugJ2AXHD9HLkoL
 R24JDZPCF1Dz3kx/LKaZEfZGiiFnWwrHdfITiunRjM18wXoj1L/tQezyBxWUTb9Zr00I
 Ejy0HIwHDJAVjF54eSOlVJhZ9VkyrhLMKAe1cS1JrM5xgvkoS3Gd3jB/GAGgvOlYEUZ1
 D1jH3wdrNM2Yg71HoRY2OOeFMeT26lgrhT58mxVOQDb2E6SqkRSVkwtOe85jLX17OYiY
 TQcBq6M1TSO9ILy4ipgBuq6K7azrP+rq+MPqBZv0J5aF3DggjKKDZBiPJIM+Uc/SXdQB
 DfEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVmsb1Ixc6ffbmc3Q5Tr/3pmH3l6RJUvnCxs/G93fHQo8FQdYP/LOiscGxqION4nCo6nG0u4M=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2vLS5aGICpLk/MZA5fELg/Bx+F/jHuvr4VjU1iNxB1MJaAMlc
 wfKZhXFwZVFS46JOvFCxrGIaEEk9wcYAjbFg8yExccJd/YItpphsW2NQ9vV9lcaHGG762gwIaOY
 CZ/+ZSHNjjc/ur/WpMcjt5mMN9ouvA/SC73vpoOu/3+jV8uLFDJDDAw==
X-Gm-Gg: ASbGncsolky5P/DFF5FXK3WCymi9Ctfgz9YPuqOyRr/J2tOtbt2PtauNWaJQ4D+FVVP
 m5xlXgPC2NE5CgaPJAPVjfDqfHdePxIaiUAzh3Vh3wUgsWkg6YA2HpMPORoRylsq80Fxgi6M+X5
 AmNOZoFtvhHZPK/fzmpWdartZztAE8wYrQ/J/1860l+Q==
X-Google-Smtp-Source: AGHT+IHx9SeQM9q2JejcyxEM8+WvEsgI5x9j6+A8M6i7PVpZRwzBOoI78JL2OIxub4JwwlKlmhZJV6Acp1q6FESin7Y=
X-Received: by 2002:a05:6402:2793:b0:5f4:8c80:77d with SMTP id
 4fb4d7f45d1cf-6050e4424e5mr3701003a12.6.1748442751874; Wed, 28 May 2025
 07:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250528-dev_read_x32_default-v1-0-6ab1734dd7a2@cherry.de>
 <20250528-dev_read_x32_default-v1-1-6ab1734dd7a2@cherry.de>
In-Reply-To: <20250528-dev_read_x32_default-v1-1-6ab1734dd7a2@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 15:32:16 +0100
X-Gm-Features: AX0GCFt6Nlc1tMw4bPI54paS9FZ7plrPHSjQtcQIlxRUGu65pfIwXpCFNyYejjs
Message-ID: <CAFLszTjw2E3v4sWNtuMc0tafLmtPMv64z=xqzbQyHSQ04NE6Rw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dm: core: use u32 instead of int for
 dev_read_u32_default
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On Wed, 28 May 2025 at 14:06, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> dev_read_u32_default is for getting a u32 from a Device Tree property
> and allows to take a default value if that property is missing.
>
> Considering it calls ofnode_read_u32_default which takes a u32 and
> returns a u32, it should do the same instead of using an int, especially
> considering that int size is typically architecture-specific, as opposed
> to u32.
>
> This incidentally matches all other dev_read_*_default functions (except
> dev_read_s32_default which will be tackled in the next commit).
>
> Fixes: 47a0fd3bad38 ("dm: core: Implement live tree 'read' functions")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  drivers/core/read.c | 4 ++--
>  include/dm/read.h   | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

Re your comment above 'int' seems to mean 32-bit on the toolchains we
use. For example, in global_data we use int when we want a 32-bit
value and long when we want a machine-word-sized value.

In general I try to use natural types (int, long, ulong) where
possible, to avoid the compiler masking values before calling a
function, which can increase code size. In this case I could make the
argument either way.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
