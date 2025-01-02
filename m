Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCECCE77197
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 19:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CD358007D;
	Thu,  2 Jan 2025 20:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E7Yf9/II";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323BD80196; Thu,  2 Jan 2025 20:15:56 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C568001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 20:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e387ad7abdaso17724324276.0
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 11:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735845352; x=1736450152; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9xaCr1m59kzUgFKMzs4eXKM05PVWOI8ehnQs0dAfiw8=;
 b=E7Yf9/II6jsB7yayDlxp06VUUEROXBcYdP7fHm7ppSpXTMbM1bEGqUdNhAe2aDIQ+i
 f02fWvTnbmEqk+mXvsr2yoLVF4NGsKmgab6vpOvsibQQjS8Joq+N9d6cjhTHKy2suGGQ
 w9/XbDWuDdH5tqfLurokxFsqmg9E285HBfZw0gAFR38h52xwwjR14aizjbkjFw2QgMP2
 LBO1h0PwlqZTfDf8Bq9/eWObsY0kDbZ27+pwS6cDzzbiCR9yjw05yiVCGZBTut8qnuUD
 pVWwai/hltV7RiTOnqY8Kg/TWJ1l5uGTY2lhwVap08kw13Q46njIqNWpBby9WHMc8EV9
 WgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735845352; x=1736450152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9xaCr1m59kzUgFKMzs4eXKM05PVWOI8ehnQs0dAfiw8=;
 b=Ox3N/KCVQdmKSwru2eDlRVngotl1odoUrAWLaRZK/NTQdZ4ChGvSjmd/G5zidmfuDw
 myZM32i4Zb0NNv/jy9jV6spqC+ajXidKFXsMz5eht6xluA4uPxbbjMEWCLXcIBfK125I
 nUZxYqyN5rEb5t2xoIHDLFQQp/WdZD1SARgi/HzJBVf2OnOHe2TdSJFtinSWe/ClROM/
 s0gu2DW2e0kx8dwd9rIpZl/pyy/qIDOojk2eO+SvJkQa9aLXDETFHDAUsDdCmpKsaYhq
 xKkk9/Sy7DFf3/JN34A90UkVKz+Z3kzk2Lfzz5dLuYUphB5gWfJDKM+NaYDtIkAcm2ii
 orcg==
X-Gm-Message-State: AOJu0YzvWZCMUI3B4LKfI3yQ/YfuxDlp9jtKbf50CN0v5F39+SBrV1dC
 e5EFn4zaYkc7JJ77XP3vi0fKuoPQTue1VhOtI5KKkRhJRJH136mQBlxenMd0kvqvH7oU0apHkpS
 QqoXtsxX/lVTDhgEEu0KF375w18k2Gtzq4mTYEQ==
X-Gm-Gg: ASbGncvYYhD6CQWP9pSCwQF3b2WvWhBXojMZuEnqjOzqcbaHbqcqz/xUZK2KSjNWK9W
 c544FmyWDr9zYbOD9IT2voHboLcc6COEqYpC/
X-Google-Smtp-Source: AGHT+IELT2S6FAhlY6PDkbNp+Pv5TF6MRZ4f2YdGd2jscap/pG/yH+V5DRSmcwoSOoA36/Z3opZpzWcRdJ0UmUdBugc=
X-Received: by 2002:a05:6902:2b09:b0:e3a:1b9d:83e9 with SMTP id
 3f1490d57ef6-e538c26b197mr32780157276.22.1735845351998; Thu, 02 Jan 2025
 11:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20250101195817.995321-1-sjg@chromium.org>
In-Reply-To: <20250101195817.995321-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Jan 2025 21:15:40 +0200
Message-ID: <CAC_iWjKUdqGkAEXyz0LobkCgF_oX9dC1xCzz2qEWXbuOhkg=Kw@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Drop BSD license
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
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

Apologies for the formatting, replying on mobile.

On Wed, Jan 1, 2025, 21:58 Simon Glass <sjg@chromium.org> wrote:

> Linaro has decided to write their own version of bloblist from scratch,
> so there is no point in having a non-GPL license on this file. Change
> it, to better fit with the U-Boot project.
>

Apart from the commit message being wrong, it's also intentionally
provoking. There was no bloblist in TF-A.

The TF-A code is implementing the firmware hand-off spec [0], which Linaro
participated in the creation. The U-Boot implementation was adjusted to
adhere to the same spec after the TF-A code was merged.

[0] https://github.com/FirmwareHandoff/firmware_handoff

Ilias

>
>
Signed-off-by: Simon Glass <sjg@chromium.org>
> Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22215
>
> ---
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
> 2.43.0
>
>
