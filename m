Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC327E8FDCC
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 13:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A9483B5E;
	Sat, 27 Dec 2025 14:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fy18Qwr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5856A83B6C; Sat, 27 Dec 2025 14:45:20 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED696838FA
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 14:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b7a02592efaso1187427266b.1
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 05:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766843117; x=1767447917; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=taZyx01nj3n+tBYWupCI8mIwVLg6KNk7/FLbQ5mPEzg=;
 b=Fy18Qwr3BGh4uAPNZpzygSsM7YP3tAiPMlLL+FHecoua1HZDolQLytNN9EM4eJC0xR
 R+lKxkDvDc4twWM7z6GhVozsZICriW6dU26XkuHp3tCXwrGo6+Wv8OB2wfmGqUpwA2o/
 dPGJTb6mwCES/vL5cI4HOEi0G5X+5m5mv9vUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766843117; x=1767447917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=taZyx01nj3n+tBYWupCI8mIwVLg6KNk7/FLbQ5mPEzg=;
 b=Q3PrRwoPE58lqZLEXbJGEvyh922Oy4IF2GvSI5KyJUtOKBbH5I6JhPQOsXOa8hDWr1
 +fsv+1gVj4eEUkmE8lkxT7kH7A/T+m2iegJIdkl73Ot/H+ojm2uxWUhjsoJLxo+q5okK
 ATUeXnJlbUi5TbznvlWYnKpTxWwb/rRac5Dd+7qTva5N/CWaUeDjH7OjjlLlOdMc/aUh
 Pnnjb/ZEka5ZFV7ACHy4oA7SXy89tuzxxGm4FWZmxe6jTFhBtCXwv+QYiDIscX1gTZoQ
 9IMIxDjBf5s51k/9U2vVBKdmXsaA8Z+u5Um08SEkSIigsyyRGyTuFmnj9+V9yx3H+b3p
 fIWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlEdYLX1OjrNG0noLFhE3IRSS11VbmAU6KpdYbPv1E3j235ssGbG3ClWaHN97iRGX/U7JThTs=@lists.denx.de
X-Gm-Message-State: AOJu0Yxa+DKnBlg0iL8RKIpmlRZpf6G8lmyJtW74/VGNhRgpJYWWEagf
 KG3YSa/kVM9LtiNRN585M/oMFCMlnQIH2sBi/YAVUzJkgK3Zoc48qsskvukruPXWh4/EWfllaKY
 gBZfmUdOk+fIvKNJ7oT0qXCrPf0l3D03NOfMCxf4A
X-Gm-Gg: AY/fxX41u9rRtoaaaodPLZUg8LIS7rm1XD7vEuzGTf8MdVoXa+nTKWoEk2xV+4ixcPt
 Pt5FZ5iwKwdc9huxN0ruMd8+HWTTvMWVf6gKADLnxBEQsE/PQKXUt5aEuMoS/ZjmJWUVevdPrQF
 ScuKQs2AtfDcfyx6QiY7HRf5hlFo9adKUO7Mnmrq8ZkJ6Csi32J5BDhemcGR2DlxzSisJRDnNm+
 CChiq0HyGDkjtLOttYZ5UqY4l0SNvDRspNoCUlMWv+6uXYEreD0pNylHdhmP4g7XO2kWw==
X-Google-Smtp-Source: AGHT+IF3KNNEvr7IQAc33uIys/gVzEa4gObN5n+EgY678D6QSAVAu/4FjLIBawRqqNvETHAmA0iAufKKu11Kf3ztDHM=
X-Received: by 2002:a17:907:97cf:b0:b7a:72bd:ac65 with SMTP id
 a640c23a62f3a-b8036ec9e68mr2658266566b.9.1766843117340; Sat, 27 Dec 2025
 05:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
 <20251221015859.738112-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251221015859.738112-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 06:45:04 -0700
X-Gm-Features: AQt7F2q3aBbYtnpQPrhzWO2_GoMCIZRT8T8ijhxadmCnLMlyMX-2QQ_3TAINpZk
Message-ID: <CAFLszTgiG=NyaVrGAnTJsmkpYc4OOaUo5ebKy=mTrw4Nwc46jw@mail.gmail.com>
Subject: Re: [RFC 1/8] trace: correct handling of recursive call
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Yao Zi <me@ziyao.cc>, 
 Raymond Mao <raymondmaoca@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 20 Dec 2025 at 18:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> __cyg_profile_func_enter() adds timer information to function traces.
>
> Commit 852d4dbd70ba ("trace: Detect an infinite loop") introduced a logic
> letting any recursive call to __cyg_profile_func_enter() deactivate
> tracing.
>
> This implies that a lot of the DM core and timer drivers functions need to
> be marked as `notrace`. This in not desirable as those functions are part
> of what we want to trace when not invoked by __cyg_profile_func_enter().
>
> A better approach than switching of tracing is to immediately leave
> __cyg_profile_func_enter() when reentered.
>
> Reported-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/trace.c | 59 ++++++++++++++++++++++++-----------------------------
>  1 file changed, 27 insertions(+), 32 deletions(-)
>

Please see here:

https://docs.u-boot.org/en/latest/develop/trace.html#board-requirements

This really just papers over the problem you are having. You cannot
use driver model to obtain the timer as tracing starts before that.

So please instead do the small extra work of defining timer_get_us()
for your board.

Regards,
SImon
