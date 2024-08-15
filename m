Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B60C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E627488C15;
	Thu, 15 Aug 2024 22:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mzjtFbQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2DE88107; Thu, 15 Aug 2024 22:34:31 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02D5288C69
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7a23fbb372dso1038712a12.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754064; x=1724358864; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RK3kXy7OCw82E9pnK+P2quqUcVEfj8iD3ZDZgr+81BU=;
 b=mzjtFbQzRQe4l6oRKdBFpIBaNTTwZNyI8m1mpIWgRd7KiKWWeTjfQ1yTIrC/7AzgxS
 f2Kx7uRGKWDxUwLRA1RUqn+LcqbtLC3AUL6nK/EERfWoYyxLh5oQ2SlQhHG4Lfhy9sHa
 8tjhlMlIW4nzuT+ApsPkfaYEoA1vki3CfdwTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754064; x=1724358864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RK3kXy7OCw82E9pnK+P2quqUcVEfj8iD3ZDZgr+81BU=;
 b=CrdEwr/Gve/qHYzs9WD0FKaJFKzg2d8dWzFm66g21eXmRJHqN6iiKcD+lRg0GcUehc
 JMBYE/eh05bwfl+OgYhJ955rgELz0pkbjQDTAPXZKh+jDXJueQAnqpris/oxtlwmDAvM
 wet1uS3bcRjPdWqoYdclIOTLtfzrf7NQhYOHn+HakL8Ih0FyH5dbp05bxK6xK2zyQFxn
 LYm6CJEUppTadA6GCyXE14RrCCx1Nfoy+dnoYt6rMAWpbsGEZlq4iRxLX7960BOlihHE
 6N9+viKH7r0R/k6seHO6ahhZ3NyCN45g+a+I+zFP24dzNfnzbKpKVqZsbTTvY90SSJFK
 MSaw==
X-Gm-Message-State: AOJu0YwvX9+gFvstQxVguP9lyP7GgaKAJs8NJvprRYkTKmPWRJf0EurZ
 JqPX7VUHtSjT3xG8QoSe56PQEehTuneGnKyee5fuGimFpTmaAjUSvYmaGAL/IvSeX9BzxYBDBML
 QTSSNrfzh7Raat2iDJbtqH9VOAMTzGKFoNAM5
X-Google-Smtp-Source: AGHT+IEUxiPYnNuY8mBepsqLNUp5DCgEtMv6aPWt/YXcb112sNQ9pN+Bgu8lyOBvFVWpffASCZRI6ZHVax/NK3UpmQQ=
X-Received: by 2002:a17:90a:d78e:b0:2c9:999d:a22d with SMTP id
 98e67ed59e1d1-2d3e076c681mr898078a91.30.1723754064447; Thu, 15 Aug 2024
 13:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-23-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-23-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:34:11 +0100
Message-ID: <CAFLszTg6KRLLJVvim2jytGLRMRAO1+Qf28TDBRmXwxsKwxH7LQ@mail.gmail.com>
Subject: Re: [PATCH v2 22/32] sandbox: spl: enable lmb config for SPL
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Wed, 14 Aug 2024 at 12:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Enable the LMB config in SPL. This helps in testing the LMB code in
> SPL on sandbox.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  configs/sandbox_noinst_defconfig | 1 +
>  configs/sandbox_spl_defconfig    | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
