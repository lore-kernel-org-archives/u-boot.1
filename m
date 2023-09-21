Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FB1CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80B8F86D15;
	Thu, 21 Sep 2023 03:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZOBtBOrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2388886D17; Thu, 21 Sep 2023 03:05:56 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CA66863D9
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59e77e4f707so5517857b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258353; x=1695863153; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aq+I9fP4WPbPNZpjjSM6G4HBVvnZPrcgTLmW//wKD/c=;
 b=ZOBtBOrSnlI05vZBO3UlIB9/lwQ7UQFk2h6lzOF0ONWH1zHKXYc7qK/psYI21rO+Jz
 DrGWyWZOf/kE4JvDvs6/rNpJMcrc7tLCPx0LUwQzGED0vSgecoe7DmbZMI4UN7iUQ1Ty
 V/8zTQjFsvUYXwfJTeudhJyUaGRN9PMWOs4rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258353; x=1695863153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aq+I9fP4WPbPNZpjjSM6G4HBVvnZPrcgTLmW//wKD/c=;
 b=aIsTU7M62e0Dot4c7aGCXS5Ffsqi5qMHE7wzAEjd/IdLUKbdqPaN/BICsXUc51owfu
 /yjbwGCsqzhEqUTqF6CAAkvD6ETDRimjVxbETUq1nt47rIDatKsc+2nvh2Gd0PSRnzQu
 d9z2YeAHDDZk0K7dhRpSaWhPBscKipLIMBcLt+aqfl/1+jd9BlFollNiXh/LX/4g77cP
 /+gD3vvuht2iuL7oh6dthpYCKYytzQYj46pQPPIi9fGL+mPMPRhlJU19loo6lX/cNKUj
 aNQw0sIosGGYfmw+44LVc7vg8/+gMwDiKCqTrVTcbSSautHTu8hkNMqcpXQN0axbrVDX
 yfHA==
X-Gm-Message-State: AOJu0YxO3q1PrvUH2m/FH1z3wTcdmwwVwWANRSI19Ubuufo/M4nEOakH
 KOclO5ErLUJOKT3s3A4gi/F5KOuYrxX5I0kftqZOnA==
X-Google-Smtp-Source: AGHT+IGDc5aTbG/5qyjWZh3eE8lYC172GV6mkWVZhD5h+jSxW4Bbg+ppjcRApGEJrfsOhYFJdC7ccdVlOHMj9WAYtJQ=
X-Received: by 2002:a0d:dd02:0:b0:59c:682:78e5 with SMTP id
 g2-20020a0ddd02000000b0059c068278e5mr4426524ywe.18.1695258352636; Wed, 20 Sep
 2023 18:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230915144323.76660-1-afd@ti.com>
In-Reply-To: <20230915144323.76660-1-afd@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:44 -0600
Message-ID: <CAPnjgZ2XzAyv5CV1JxB_XRS+_KQxNkp024ZiGYHw1JMmr6EWKA@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Force regeneration of env.txt
To: Andrew Davis <afd@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Fri, 15 Sept 2023 at 08:43, Andrew Davis <afd@ti.com> wrote:
>
> If the source .env file changes to one that is also older than the
> generated env.txt file then the .env file is not regenerated. This
> means when switching board configs we do not regenerate the env.
>
> This can be tested with:
>
> $ make j721e_evm_a72_defconfig
> $ make # this may fail to complete but that is okay for this test
> $ make am64x_evm_a53_defconfig
> $ make
> $ vim include/generated/env.txt
>
> Note this is still the J721e env not the AM64 config as expected.
>
> As ENV_FILE is set based on configuration, regenerate anytime
> autoconf.h changes.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>
> Changes for v2:
>  - Depend on autoconf.h as suggested by Simon
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
