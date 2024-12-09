Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BDEE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C4DA89774;
	Mon,  9 Dec 2024 16:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h7MBsgA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 809C08977F; Mon,  9 Dec 2024 16:01:03 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DA889772
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa67333f7d2so232514766b.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733756461; x=1734361261; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+DkGQADpfZriOxtD0wc5LVq/DSV1AnmLC6eNggI45fU=;
 b=h7MBsgA7mxhpXvLaPXsoR+Meh2bQOClZenq7A52uJcQVwXsajM0hpWPgJQHUVOQlTN
 Csx5xidUgz59SEzYoKU4die7zATUo0yYtkscxBHjGEFHkEE5RfJ9nX7Q0aT/D0Wd2O3X
 832ddz+RHaBEFZMOc/5qEd336IU+XigF1yfOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733756461; x=1734361261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+DkGQADpfZriOxtD0wc5LVq/DSV1AnmLC6eNggI45fU=;
 b=dgsNXy9GRQwKC2G95G5OgzadzQNU/a0r4xfocm8vCncliQw5ESAXoA+FQ/Jla3djoZ
 +7rgqqYMlIbG6xHULowRMUMFzE4dOWyPZI3pMZ0+vfUaxrG4sxwazJ4Dzt+wvlzsJ0if
 2FhR7psFmms4AjXW4AmVLKmGLSgy9rO1afDL5OOMcD4FlEC01DPiTltAqWh8I14fiRCO
 eO8kGfxkfYJGTWWy3rSmJZGdPQgzb6eeIW82nJL4EG+hbP9fChMkT0r2FwwIVJ5M/Txb
 CV6mWw0ncRorRNkUQyyACLtL/sMRvH1YuihBzIvaIfEhpPqYFLzQPzVrTyWFhBA8d68s
 1VYQ==
X-Gm-Message-State: AOJu0YzN266UIXNIsxxe9jy5olexdrhqXuNcmoxPSNMk82t30sHlrpR0
 YyQXQ9k7UIeI8JFplGga4AeiT5lJ3WfLjPOq3XKkR0aqgu0ztSPiI+BCJGZcaNYn4KfxUkdoXxt
 cH3Nvir5OzapFjXNVK8+FM/dmZ4CPEUUbMlr1
X-Gm-Gg: ASbGnct4Wb5cUkXumROCn9P9e7KbqL0wxetoQQN334X1H9zOWdC14CX8SRiDWdjSue5
 buj1rFXHakTVQ0OPshKwhSuv7DetCmZS9
X-Google-Smtp-Source: AGHT+IF2T1qKAhPiPMSSpFrk31T5nDhI7pzX8G06scm39Ztv1rWZNByQYwi4mwYxRKr0lUA+owjSqfdi8NNp77Ai1Vo=
X-Received: by 2002:a17:906:31c5:b0:aa6:8b4a:46a4 with SMTP id
 a640c23a62f3a-aa69ce222dbmr73031266b.44.1733756460563; Mon, 09 Dec 2024
 07:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20241208190741.4192601-1-trini@konsulko.com>
 <20241208190741.4192601-4-trini@konsulko.com>
In-Reply-To: <20241208190741.4192601-4-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 08:00:42 -0700
Message-ID: <CAFLszTjyqf0bctZ0aY2r2+kQD07q1fnJ38E0DjuKcqU9+B6skA@mail.gmail.com>
Subject: Re: [PATCH 3/9] GitLab CI: Make wider use of tags
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Sun, 8 Dec 2024 at 12:08, Tom Rini <trini@konsulko.com> wrote:
>
> First, introduce DEFAULT_ALL_TAG, DEFAULT_ARM64_TAG, DEFAULT_AMD64_TAG
> and DEFAULT_FAST_AMD64_TAG and remove the previous DEFAULT_TAG (as
> anyone making use of that will need to adjust their jobs). This allows
> us to say that some jobs can run on amd64 or arm64 hosts under the all
> tag, while some jobs must run on amd64 (the Xtensa jobs due to
> binary-only toolchains and sandbox for now) Then we rework the world
> build stage to only run on our very fast amd64 hosts, or our arm64 hosts
> (which are also very fast). This should result in a similar overall
> build time but also a much more consistent overall build time as we
> won't have the two big world jobs possibly run on our slower build
> nodes.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .gitlab-ci.yml | 74 ++++++++++++++++++--------------------------------
>  1 file changed, 27 insertions(+), 47 deletions(-)

I'd prefer fast_amd64 to avoid spaces

What is the run time for this new, unified 'world' build? I just
wonder whether splitting it might make the runs go faster?

Regards,
SImon
