Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533EFCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D1DC86E81;
	Thu, 12 Oct 2023 05:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y69BxJPY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3803186E0E; Thu, 12 Oct 2023 05:42:29 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EAA786DE7
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a505762c9dso6498697b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082146; x=1697686946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3+6EwElypQqehvXEAPEMH4KXWWN0YWQFvLehe8nyTaU=;
 b=Y69BxJPYIOOsKRBfvdAB0pASLPdFGxXh8T/LoqPICpGvXD8uU1pgAT5V1RFyViwL4V
 hL9x3bDh4mDB6dheKUNIVkeh4XRebBsVeO21wx2CWyiUPErDemAa2HqEGnMlJqDgQkYo
 Ga4DuMOUHfkhVWYOl1oy5ZAqtOBqbfYvhC0mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082146; x=1697686946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+6EwElypQqehvXEAPEMH4KXWWN0YWQFvLehe8nyTaU=;
 b=Q080L8waq+GM8RNwlgRQzC1tSna3HsuyalxzReaOGjj3C5Zckpo3SwkZoAXhJ0/qZm
 0BmZhlfMGp14iKpw6/OAG3DSB2mkNlmflpvZLpbsR15smenNUFWhbjVwqa1AWvNrqC9H
 IveAAgdDmkiYcg3/zSXV2rBPb8tswsVEOY74WKWYJcdY/aNrFnCJixitAIPfkl/nCGQz
 FB3ntRhzhfnip9F6EsR+EA7qL1OagQEBt6NR/obsEWs0ZIAjXTXkVEqnanCq+RggmhEs
 26JClWAX/KHZLMtFqZ461+5HUv//kESGRadllF2jT7GKXCbH6MlmjydD9zbFkiPTQthl
 HBjQ==
X-Gm-Message-State: AOJu0YxYXTKQuoSy2xppj+b+uZzWGEJHV+kEuqBBvRs8z0TIUe4C3uxH
 2AlzoNR7Q32qBawryq+fndQo7BW3LlfQQGLXQYNRvg==
X-Google-Smtp-Source: AGHT+IH8AhfbSsqjMx4oCI/qso585i/uwjYWlcYT90LKSG6A6oIsxphlI+k/fnY9TsDNm63T0JJ3KFEL6l7Ku5e2L2c=
X-Received: by 2002:a0d:cccc:0:b0:5a7:cfc7:7b31 with SMTP id
 o195-20020a0dcccc000000b005a7cfc77b31mr6193313ywd.24.1697082145660; Wed, 11
 Oct 2023 20:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-11-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-11-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:24 -0700
Message-ID: <CAPnjgZ015780NUha9bz817scqeUpQNc=4sxB-AmgvnWRXAygGw@mail.gmail.com>
Subject: Re: [PATCH 10/26] lib: acpi: Fix linking SPL when ACPIGEN is enabled
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Heiko Schocher <hs@denx.de>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> lib/acpi/acpigen.o is only compiled into SPL when SPL_ACPIGEN is enabled.
> Update several files which reference these functions accordingly.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  drivers/core/root.c  | 2 +-
>  drivers/i2c/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
