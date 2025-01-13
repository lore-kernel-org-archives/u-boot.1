Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3B0C02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 18:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBBE0805DA;
	Mon, 13 Jan 2025 19:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bAeLzbKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13782805E9; Mon, 13 Jan 2025 19:52:25 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F022C801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 19:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28a4fccso6755171a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 10:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736794342; x=1737399142; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jYBSJ8rUt/xVA6ojvrffG20JxSdu7m3OzC91KML+LlE=;
 b=bAeLzbKpO+B1ErSaCnOH6k4WpSp1LiQphHZUgwXxiLb0325kcsgidjVV1AnieLT/PO
 JNYm2gnSyhZe3ZMtGUr+o+VvXXeeZIbi+Mr4tQ/6qW6RM5NuovyFY4RigYENeHfxWrUz
 Kjm1+Qa1AzT5DuOj6Lw5BPJ2Sz2Untv5gPZeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736794342; x=1737399142;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jYBSJ8rUt/xVA6ojvrffG20JxSdu7m3OzC91KML+LlE=;
 b=sRZ+Af1nbneTF3y2i5y4+fFOWrP+e4cZXIT38OYoj5gNPBz5YL2QM8z2hvcVeVgntq
 4SqYhtBmPbRcf52dU0iFgyXZIHWPDPAgBFTsonpFvpX3IQGEIy8peVqNvqMG8OQIaLgF
 q5bKABlAVeUQYjCGffKR2i+T34SX9uzEngh8BvCC7j86gIKwdnwL8Xp1iMm/OQnFklcN
 hg9J65I0nNYeO0ikTK50oWw3ZaSSl3nGvs5WQHk+8MDaIGP2v3FyVNQbAbrG+5DxUim5
 ig1ANJiko/wOi7629Q2DUDDeEljyJ7U0iaeCTEZYAM0qh6SCM3mvmTdCEEJiW2Rp2boV
 bPBw==
X-Gm-Message-State: AOJu0Yz6SZU7FNJNPqJPTNL5S30jHvFbtxHEC4igHjlJGbUReWc2+YJM
 MGRGYx7kyNfZgMYbcRl4xRRIVDTNy7BCZ1s0ub070n5LNkAuu5imm+0NbqZFdHb13GN+40A3d4Z
 rhSYOpphBzxXuXFwYiByQkfZUkyYzGtQDrtjEFw0nkH0yMFM=
X-Gm-Gg: ASbGncuQWq8d7Cvr882QJojYpGItfwM4hcSMuiS9lb6S5QbxJf4FBN6LbF8F2dtXYhg
 NarsmcgNQ3BIGuN2j1/OcQ87wXYgP/UVaB/YQ4YI=
X-Google-Smtp-Source: AGHT+IGb/GVXntEm8yS4kunwbJM7uEOJHmQtMZ8n3U3irl8Ci/PmmzpVpExOe4PjH05kp6MKQG3+eL5efCqNmMpzWfA=
X-Received: by 2002:a17:907:2dac:b0:aae:eb0b:f39a with SMTP id
 a640c23a62f3a-ab2abc6ea73mr2110094166b.42.1736794342390; Mon, 13 Jan 2025
 10:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20250110215640.892539-1-raymond.mao@linaro.org>
 <20250110215640.892539-3-raymond.mao@linaro.org>
In-Reply-To: <20250110215640.892539-3-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jan 2025 11:52:11 -0700
X-Gm-Features: AbW1kvaePv4B8Nu6zwZGUE0hdtfiPTYbXh9nh-jue3serAfvigNA_VsaDF-cSus
Message-ID: <CAFLszTiozCfFBm-6hukf7C74GCE4ZjQm9bo7hURKoD=tO7GFgw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Levi Yun <yeoreum.yun@arm.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>
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

On Fri, 10 Jan 2025 at 14:57, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Get tpm event log from bloblist instead of FDT when bloblist is
> enabled and valid from previous boot stage.
>
> As a fallback, when no event log from previous stage is observed
> and no user buffer is passed, malloc a default buffer to initialize
> the event log.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Remove patch dependency.
> - Remove the fallback to FDT when BLOBLIST is selected.
> Changes in v3
> - Malloc an 8KB buffer when user eventlog buffer does not exist.
> Changes in v4
> - Replace the default eventlog size with TPM2_EVENT_LOG_SIZE.
>
>  lib/tpm_tcg2.c | 55 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 19 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
