Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0835AC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D7E688C63;
	Thu, 15 Aug 2024 22:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aHXTLFrN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A53CF88B59; Thu, 15 Aug 2024 22:33:47 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB1D58887A
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2d3c5f769d6so954760a91.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754021; x=1724358821; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kK0bgZmluGzfZf3Ls+0w/w6cIkSJPu/XkeGcFNlMUOU=;
 b=aHXTLFrN5hA3rynv09BqoIpGtka7w+yoSGGoMtcH9720kg5JUXSu517GP3rAGs+hYM
 4D+Ce0VZvqXBK9quV8AE6pdmeA2WRejKWMMTHwsoG/I25cju1jAq5RA780oD4zDBGfYo
 Uvpp/+RUHOlzXs0fsuwBpFfM/s5dlunQOiITk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754021; x=1724358821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kK0bgZmluGzfZf3Ls+0w/w6cIkSJPu/XkeGcFNlMUOU=;
 b=nJIrs6TLJweGXvG/Svk2eE4J0m+IedeAQsz811/MHGOXc/gsMOlG030FzTWBo95yvk
 4C0/RkR6++WNsdQiNg9WO+2vx46qZ1YZSi20U5aIWvXSXZeOeCjlYrOhtSuQfl8vBuqU
 zs8ZALdmws/SK8PQ1/IM8gTtk4Lmus5wwaGbPrOVVtc+Y37X7+q+KmJsLIg8ntsFZrfZ
 4k4NN430uTmENvaol5B3d0G/hExX5DE0jKBrYfKIvIIxKTi0eFh3q5P70QFJ2neSPVcZ
 9kVhVDpPmFiGWvcQM0uA0tkw+qpLcrHSTlasbROh+h6NIjHEQKNlyWQ9Cc4PC5SlmpuU
 v1fA==
X-Gm-Message-State: AOJu0YyWykqJj1Kuew6w7+Skbvqh/EDqrDb0U/SLhVU3dMrW+5JzKt97
 WKV+IBMOhKriyEMf0cvan8OupKseNZaiMfKRO15x8UnAq4cJmf+YypPb87Vf3LYtGoxWz+hp4VE
 1EK7tTj5Rp8goMaLMxSf4n3rWn8jTN53tCV8S
X-Google-Smtp-Source: AGHT+IGfZ7Gn9117+JW1PJxEGicGlgjEvGG8Wtjn5ykmee6uMD0KuabeyruHCzDiCId61wVqEfCvkXhBVWDDwx1hqHE=
X-Received: by 2002:a17:90b:e0b:b0:2d3:b8eb:9c3c with SMTP id
 98e67ed59e1d1-2d3dfc3a98cmr901308a91.2.1723754020576; Thu, 15 Aug 2024
 13:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-3-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-3-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:33:29 +0100
Message-ID: <CAFLszTi_nDiqxF9fke5My48HjoX0zoZQmKU5SVQiRpQ5EHDv7A@mail.gmail.com>
Subject: Re: [PATCH v2 02/32] lmb: ut: disable unit tests for lmb changes
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

Hi Sughosh,

On Wed, 14 Aug 2024 at 12:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The LMB module code is being overhauled to make it's memory map global
> and persistent. This involves extensive changes to the LMB
> code. Disable the unit test code temporarily till the changes are in
> place. These tests will be enabled in a subsequent commit once all the
> LMB module and the corresponding test code changes have been made.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  configs/sandbox64_defconfig        | 4 +---
>  configs/sandbox_defconfig          | 7 ++++---
>  configs/sandbox_flattree_defconfig | 4 +---
>  configs/sandbox_noinst_defconfig   | 8 ++++----
>  configs/sandbox_spl_defconfig      | 8 ++++----
>  configs/sandbox_vpl_defconfig      | 7 ++-----
>  configs/snow_defconfig             | 2 +-
>  7 files changed, 17 insertions(+), 23 deletions(-)

As mentioned last time, could you update the tests as you update the
code? That way we can bisect if something goes wrong later.

Regards,
Simon
