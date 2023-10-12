Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39CBCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3131D86EE2;
	Thu, 12 Oct 2023 05:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dIRd7VXu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D79786EC4; Thu, 12 Oct 2023 05:44:36 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD2BD86E7D
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7fb84f6ceso3670807b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082264; x=1697687064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K4NitmTn8jK9rqBtRMC3b7jNCGwxCaif8qZFQnLd/6c=;
 b=dIRd7VXul6W2fVxU0AQq1VdElF8FS31kWlIvyHder2BKkkBpNN82ULzkrQIzX8BYkZ
 8qljbopYsj1h0CzFWdM5SecAlmp4wyinCwKMY9XE83uYjdsMpNOLShkKyJPgOchtx1G8
 oJ6qsI5UzfM+DPD4bsbVzC97eGUtR2zndWO+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082264; x=1697687064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K4NitmTn8jK9rqBtRMC3b7jNCGwxCaif8qZFQnLd/6c=;
 b=TnlTYeqsR+fFrt+bv6GtlTIv11SMewuC8EZG6w72jXw0CgcLPbWJBOI+aL3BCPVMvD
 9W+mtfPrB7xA4aFHVPhnN6PgVrnok9auH3waceBCzup4/zRTuSseYCZee1XSrUqeq3eX
 JPLcQbM681qtEnfqq05PxvH8z1NTiq8+j6yUhxZAaXysAHt9aOoQX20QfY8qZnuiKQLq
 Wi1OtuFyKa2KXeCjvkOT/O14c4JDsDM82Xk0nzceQGsTTJqR/maTSVinH3sg90HE2A9T
 UQRmW0YU/VSqTiEo1KoqvpPgELO+t+SpOCwacd0OvM2CIUoDaLWkF4ORPBm+RtbUqeR7
 CWMw==
X-Gm-Message-State: AOJu0YzE/jET9ygufpqERW6A7Q/3YHJO+qRnYY+nib0VkgpAdJJt2aqM
 64EZ8LgsZ7Cr5XFRRNhnJFBqi929efdJ6lqhKVuDLkKuVn2asngzIw0=
X-Google-Smtp-Source: AGHT+IFA1aDV7ipQQzY7ZdWVGaZYNUBdb7DSCbbnecvQdk4yM0Z1ALUlDUX7X/dmEh8G5BrF1mHBp/Hsd+SHB1N0zks=
X-Received: by 2002:a81:8843:0:b0:573:285a:967f with SMTP id
 y64-20020a818843000000b00573285a967fmr24590294ywf.38.1697082263662; Wed, 11
 Oct 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-9-bmeng@tinylab.org>
In-Reply-To: <20231011131552.14665-9-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:42 -0700
Message-ID: <CAPnjgZ0u2eg1SjDN-8FPmnu2g5zVD9Z5P+HWTo+N1KhK_iDPQQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] ufs: Handle UFS 3.1 controllers
To: bmeng@tinylab.org
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
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

On Wed, 11 Oct 2023 at 06:16, Bin Meng <bmeng@tinylab.org> wrote:
>
> Extend the version check to handle UFS 3.1 controllers as well.
> Tested on QEMU emulated UFS 3.1 controller.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
> (no changes since v1)
>
>  drivers/ufs/ufs.c | 3 ++-
>  drivers/ufs/ufs.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
