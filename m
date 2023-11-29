Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAD8C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 19:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 075108768B;
	Wed, 29 Nov 2023 20:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ZtZ65s07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5649887646; Wed, 29 Nov 2023 20:27:59 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A4587646
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 20:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-54a94e68fb1so2483732a12.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 11:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701286077; x=1701890877; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=06H8gnAWeBbV1U0UsQ+9v9mQ4IJq9bueFvFcx0L3Zpw=;
 b=ZtZ65s07mFn5nwLK4JiBjJEEIOQ3QX7mz86smA+CxxDopSAvvxWmxtCAItjxDfPveS
 l5uT/sXfty6d9rULAO+DehXPx3ZXMhtNqFLLGHCT+0OukiN6J/dfpAGZjqbM/WMAMhkY
 zbmulxybjxYPY1vi1tyYoanxBkj7eplFcrZ/dpWiIoz5zdhYKttzluRf1ycQqpQLPV4T
 dVNVW6aqSnDMpUXVg0G4lSvroYss6gdHFyEazpwwT3YQNtcwlCopukmu1nzwUNekbjbI
 i+eaHEdX0Y1ao3wg+IeivjjoQo1Zn9yuI7tVlOd8sZ/+NHG3eH3KxRhGsTXYHPKtDVh9
 TouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701286077; x=1701890877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=06H8gnAWeBbV1U0UsQ+9v9mQ4IJq9bueFvFcx0L3Zpw=;
 b=rDLHRpm//ft+3bFCiJHHeoF/qq9Xf+8T532xaMMYXl3cZQ8YkCnM7dU7nCOQmxX9nD
 ehhHZQBuxaP6pT36bUPDEr11nXt9KO/OcDP7F8/qyi2o6EbE8dkw/Bw1EZWko+C9VER5
 Pr0lArPCF9AZJYX2db0yENxb7KQHzsd+QKPa7AFFZKdP0Kq42TXFuW4lw+Y42OtLiv5v
 c2Yu3S9mOovYMZ1sVGJ+FrxHswLE2rMP2poHRPAtrpJ1WPPG6mJDhkq6n99dgxwNuHq9
 EnkyBDeydCNL88XZ6AtwIiXXVVq/Uu2zYqieJrrKR14DsCap1b+RY6o0kVqlVJiv3NUV
 mg0g==
X-Gm-Message-State: AOJu0YwApGr2tsalwOAE8Hg8sfwHlfvZBmsByNgV6JfV5MrAYSAL9L6l
 sGJg+/yQjwqyCKJrPIwFXkRVbIYBMpPTixnoBjYC5w==
X-Google-Smtp-Source: AGHT+IEuS9Grx3w7TonDZ5akkj55aLQTTN9XgxxNosZc8g4t0F6uKTrb0GxSmURL0psDSPFQZY/hkVXPYwd6fJIeMnQ=
X-Received: by 2002:a17:906:b810:b0:a04:eac3:2812 with SMTP id
 dv16-20020a170906b81000b00a04eac32812mr20214435ejb.26.1701286076553; Wed, 29
 Nov 2023 11:27:56 -0800 (PST)
MIME-Version: 1.0
References: <AS8PR08MB6806D08B61DB1A97ABF68BBDEBD5A@AS8PR08MB6806.eurprd08.prod.outlook.com>
 <cover.1700843096.git.piotr.kubik@iopsys.eu>
 <01aeaae2b87933e8a33a575ec0d23e2d464d6699.1700843096.git.piotr.kubik@iopsys.eu>
In-Reply-To: <01aeaae2b87933e8a33a575ec0d23e2d464d6699.1700843096.git.piotr.kubik@iopsys.eu>
From: Simon Glass <sjg@google.com>
Date: Wed, 29 Nov 2023 12:27:45 -0700
Message-ID: <CAPnjgZ0wjR7dosOqVPJAgvGzF-RfV0pTiP9g3TC0uyUZLS7ejA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] bootm: Fix flags used for bootargs string
 substitution
To: Piotr Kubik <piotr.kubik@iopsys.eu>
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

On Fri, 24 Nov 2023 at 09:35, Piotr Kubik <piotr.kubik@iopsys.eu> wrote:
>
> Commit 51bb33846ad2 ("bootm: Support string substitution in
> bootargs") introduced a feature of bootargs string substitution
> and changed a flag used in bootm_process_cmdline_env() call
> to be either true or false. With this flag value,
> condition in bootm_process_cmdline()
> `if (flags & BOOTM_CL_SUBST)` is never true
> and process_subst() is never called.
>
> Add a simple test to verify if substitution works OK.
>
> Signed-off-by: Piotr Kubik <piotr.kubik@iopsys.eu>
> ---
>  boot/bootm.c              | 6 +++++-
>  test/py/tests/test_fit.py | 8 ++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thank you
