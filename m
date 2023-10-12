Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7E1CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2B4386EE8;
	Thu, 12 Oct 2023 05:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T5E9F68O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6BF886EC0; Thu, 12 Oct 2023 05:44:40 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF34E86E8E
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a7af45084eso7405667b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082264; x=1697687064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p5Z6bUsDYS/38oRy65ikhDgyKBzR5naIOuSFaKSsdZs=;
 b=T5E9F68O3mqBc/wKrCGkNxVwslFY8Rtpu2AfIhPXOr+ijNQsFwQ8rtsIS9wFavLKob
 4Bda3PiLhUTIaoibddBMqeulvMbZfKljIG8rOfayXHnvRXfLf1pubYbYxTYuWHBA0C84
 GRyZ5JJT7XJRMf9dI0niV7cDn1SPOWaSKz9Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082264; x=1697687064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p5Z6bUsDYS/38oRy65ikhDgyKBzR5naIOuSFaKSsdZs=;
 b=P+0hSDE/3m0c8Yq0iLx9HC5A7TkuyU4fzsaKfKTGdGrj7eAf9JhPznm/ZaEYs0UQ3k
 tvB3ucGcDybXArLXjN0ohMOXJyWX0W3SVBeg75R6q1cDuDsbJ9kvT3iE6Au86Q1XaDyr
 CRbJE4a3t/Mzkze7vNJZYnxEFjLkXcmFbZicFIUNmWYM06JSIftTHYnwBg68eNJshrqf
 C+jXMff2Sll1jB/YhnOcHusi/UiBy27xHJLj+8cdU+nn9wGs1sD/ddKoegnaZGcGsKUd
 ly9wgHclI5y18gowczYjsD8/BjuRB4FRx96JuDjXTz0GNpgI8zflfGrP+nGiycGfUCLD
 8JJg==
X-Gm-Message-State: AOJu0Yy/iLnZRGE2whnyoDT8COgXQnNveM3pKDRfXkR2aTI3+PiYRjXn
 vwMM5R3hJ4+GljqB460mkLYGKF6GIx3gvk//Oiuk7g==
X-Google-Smtp-Source: AGHT+IHbXpRmCsY07BtkcQCeuUHASFVbstKYS+7qBDDYYsmI1SBZQRaCiwj1yt8N3zLSRiYhD4uP9KBy47FP7ikkVoA=
X-Received: by 2002:a05:690c:250e:b0:5a7:a959:338 with SMTP id
 dt14-20020a05690c250e00b005a7a9590338mr8181431ywb.13.1697082263709; Wed, 11
 Oct 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-27-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-27-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:18 -0700
Message-ID: <CAPnjgZ3xEcNf2uKVzT7ZbeXQDQz_t=ye3L43PyAXGT+NtpHXuA@mail.gmail.com>
Subject: Re: [PATCH 26/26] test: spl: Add a test for the SPI load method
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>
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

On Wed, 11 Oct 2023 at 18:57, Sean Anderson <seanga2@gmail.com> wrote:
>
> Add test for the SPI load method. This one is pretty straightforward. We
> can't enable FIT_EXTERNAL with LOAD_FIT_FULL because spl_spi_load_image
> doesn't know the total image size and has to guess from fdt_totalsize. This
> doesn't include external data, so loading it will fail.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  arch/sandbox/include/asm/spl.h   |  1 +
>  configs/sandbox_noinst_defconfig |  6 +++++
>  include/spl.h                    | 10 ++++++++
>  test/image/Kconfig               |  8 +++++++
>  test/image/Makefile              |  1 +
>  test/image/spl_load.c            |  1 +
>  test/image/spl_load_spi.c        | 41 ++++++++++++++++++++++++++++++++
>  test/py/tests/test_spl.py        | 10 ++++++++
>  8 files changed, 78 insertions(+)
>  create mode 100644 test/image/spl_load_spi.c

Reviewed-by: Simon Glass <sjg@chromium.org>
