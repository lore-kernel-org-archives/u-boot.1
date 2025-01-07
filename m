Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B30E77199
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 10:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B9E80600;
	Tue,  7 Jan 2025 11:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MSeV/8Ss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F89805FD; Tue,  7 Jan 2025 11:37:15 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E2F805D7
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 11:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e549dd7201cso5435485276.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 02:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736246229; x=1736851029; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dq4zv9Az1Jvh1aq0N28GgehOz7dF+scQWXSh/wvKjd8=;
 b=MSeV/8SsdMNyInArTKW24947NUYCgOabjxIiofgn1BxDwvh0nIS/+KI7ksafjvNLQ9
 J6Jr1lD44KhicjKzMKj0ib3ueWrX1qLif7oY3gtYEC9Xl//oXQcQfZqcGJLrab6jHAa+
 RYaKPCt+9/D92hRbc6g+nBiny/Qa7UotDqtEgt+gSj/Pw6pTkxFFJf8xSuGzPEJrteN1
 OdkcU5kjjtZDtGFY2NCx04u7xfF5ghzWRY+Abylzy/u3mFIvlUS0pbB888cAUz4SLhXA
 iuIMSlFcMeZ1dsquzVjncwwa6bSNlkt/SghoxxUkLI7AQ1Z2Aao1I/ix7h3nubtTJQ75
 VPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736246229; x=1736851029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dq4zv9Az1Jvh1aq0N28GgehOz7dF+scQWXSh/wvKjd8=;
 b=uiI8qgIHcfYsTKnVCoD7JI+3SMHBLovoDNNw5Y1kIIv1fqi/9mENqqJDyT0087KzlM
 L7niuEyTTsCnYN5L7Ip2GhT17gKvz2dboeOl1XKvCAc7Ig7K4P6qv5qJw3BQRCs8axKA
 GKEDOJPUFyIo71qdBYZJqOUA5jgEJkgSIzZ/H/CNSMV8Jk+/Nz9kKj7GqEu9VCdr0PEw
 Ef72UubUv0nNTlB7LvP96K5tKuqLTIAcdilAOQK5vQAIJTPVzpMUs4Ki647XouGYdgV1
 MVkJkt6yJZ6w3JqysMEyfr0KyTcAgyQYbhoilBhE/ziO/K88ZevDmBn+Q4NU/SZokpja
 drUg==
X-Gm-Message-State: AOJu0YygVhGkHZs8M53ALn6+rXVq1Jp5qc0wXwIZxcgbE5QKSZ4PdaZr
 HQyB4EJkgblcre59p5fT6A84KuWvJiXUAkj7TLLIBGMgVGqfbdbilcv5OKZB21z9DTVojGCSfVk
 Kb+7GYobeewC/cKLIRNsO54vNLD+xchZCFtj88A==
X-Gm-Gg: ASbGncuOXoltW093yRUrEk06nqXomo9D3RT++ezeiuOpJpYYi+UIhpI1cNqqTQb6hiM
 fuU8Tyxekk8DLIDWfWOJb+aFAkNeaSUDRDSzMcQ==
X-Google-Smtp-Source: AGHT+IF3g0TjGhWlLqeSvoDeD95dsdctCmV+TL8bN7Xc0PuRC5tn59v5HRmW5QyqBOYxtMlFIwaxIhf6gTVz4tNuT/o=
X-Received: by 2002:a05:6902:2293:b0:e38:8c9:c026 with SMTP id
 3f1490d57ef6-e538c41e000mr45996714276.52.1736246229612; Tue, 07 Jan 2025
 02:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-3-sjg@chromium.org>
In-Reply-To: <20250106143229.3023771-3-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 Jan 2025 12:36:33 +0200
X-Gm-Features: AbW1kvaUiG8VlliXyax0UQluIB2oOyplj6q-Zcw2h0Ukwq9Za6PK1vsY_Y3cVPE
Message-ID: <CAC_iWj+KzQhhKAJgnF9SdYk0kka8d+epNF8Fzm388zqUidvPOw@mail.gmail.com>
Subject: Re: [PATCH v2 02/33] bloblist: Drop BSD license
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Mon, 6 Jan 2025 at 16:32, Simon Glass <sjg@chromium.org> wrote:
>
> Linaro has decided to write their own version of bloblist from scratch,
> so there is no point in having a non-GPL license on this file. Change
> it, to better fit with the U-Boot project.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22215

NAK on the commit message. I explained why it was wrong and
inappropriate in the previous version

/Ilias
>
> ---
>
> (no changes since v1)
>
>  common/bloblist.c  | 2 +-
>  include/bloblist.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index ecce3da9331..c441498ec56 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Copyright 2018 Google, Inc
>   * Written by Simon Glass <sjg@chromium.org>
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 7d462e71914..be7303e1504 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause */
> +/* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * This provides a standard way of passing information between boot phases
>   * (TPL -> SPL -> U-Boot proper.)
> --
> 2.34.1
>
