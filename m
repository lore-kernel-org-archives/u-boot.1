Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45277D35154
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 20:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8425E83CE3;
	Wed,  1 Apr 2026 22:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wr4qNHpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A0C83D8A; Wed,  1 Apr 2026 22:24:53 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF2780517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 22:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b941762394aso18229566b.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 13:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775075090; cv=none;
 d=google.com; s=arc-20240605;
 b=c+KCBRGLa/0A72NLitzRRXO5xrEJ4kcDJReSwjtlK9zF29K6PAoySusqtgV3Gnwju/
 f7iRQdlL2/GdGo6nmi1H+cZi8ba/HM0GYbyMeB7kni6caQsw8hbYXxIk/Q13xaNDInBM
 wUcuQOYLN/FLNDaj72G9l825J3eAvB90K6ON3ec1EPtdVHlTI3sP6Z+5RaHw5uCfqGIS
 c/r8/pBT2FJD0NUSMo4Y11bIUsK2KCF6VaS3lLz3Es7qijq2cJCqYZ1kuoDnnobAKmJQ
 mPZizoSg0O9pvmANFTqec21zfSQMhdnQG7gjlpgvPsz0dDemxINLCRFyaCAVj8cVeek2
 nZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qrr5X9VJae69pUAD78AOEHgGCwij8aJv08Fn9vCUVzo=;
 fh=RnB5lhiZ2zWwUKd56qUm2o6d636ryv0VxB/lSwXL6qU=;
 b=WwI3TpLnmc/zwEs9zf8EBzMdBp+OLS9IWwm/MzyjYTj5SpahvmdCqYPcNEHygmncvT
 dCmZ2OzoZdrPypdmVZMif7jNjxBcinx1Z9he9P5qrNF1GM262k8oUtDsbHn3opzQJvpN
 akXjDcQYeUn0Rzj+FH2BarP1jBZr89u9zJ3LrEVEKDISN4hmdJ1V+dYGRqKHYUerwKdi
 Qq12Piw65NQv7KwSWgCzolKtS1gMJsMikTcXEfWo3BqPXWAqgEURlLi8xEuH9yvynBtZ
 X3onQxC/lSB54uMul97ssoe6i+CuPfBsHuS2879QmsRsFTp5ywdT4mu6+f7zjmnpnESv
 Mcsw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775075090; x=1775679890; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qrr5X9VJae69pUAD78AOEHgGCwij8aJv08Fn9vCUVzo=;
 b=Wr4qNHpHNl+uQOJTzgbagf/HwOfNdN663JDnPJKW+lvBaaXWSYbZjpVxlIpB6ddpkP
 tCMIJd40XyUZlbZ6O7xo8csXlqPYdDoGedfClbXaJ0/OBrchoFTFFSHbFRocCf5J+2W0
 Uzf7VvM2VjTsYIWGHPOAjcULklyLQpb+wEdOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075090; x=1775679890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrr5X9VJae69pUAD78AOEHgGCwij8aJv08Fn9vCUVzo=;
 b=BF3/p+HwC0Sc2M1d+UN2pt9m41/ymgA5Hq/nfXr8fp7J+xdvzX67LRalLRcmZD+0ub
 jcT4mi6eqRYeAtgwYu0EqRsGqDZqFm7VQbWvC3kHBUl0ipUXZBFNMIoSO1tYCMmXc2si
 3gFtlBDRQnilg34tzbd2PNlY4yYeWUVsqPdfzyHFVREen1qx1dItt75N5jUqImcl7LJT
 nBNpRGIpbij/9akfBQPL7eIg5E/1pDLLaodmw5QXk9xsn/8AKMqSVai3At6M1hQ0RlOY
 0Ss/nLtgvAHlUPrKb/ienZt7zMMg+4o0s6oi/vEA+D9Yxu9bvdQr7RoQKhtTk1SDLXM2
 zXsQ==
X-Gm-Message-State: AOJu0Yy+oPL5cEKrnzgZEPex29eXqn5NWU7Go6yiCSfDFRzhl4xK1nky
 FE9Gql5dzZYyH7ezVfyGn1aWucvGcWF85y1OknbyvK0+ci5GBjydL47+XPobcU+/AWW2EicuSpT
 qN2IMaRziM1V0Nv1Tb5wPzo6a/SmKtUu48lU6+pLrH3vDK4EtCZXUkA==
X-Gm-Gg: ATEYQzwJbHH4DLDM7LrY0i46oAWLWjPFqHUV5k8XhC8gZLSeyq37DUObITePnLE2vSB
 HQnk2uIJbeM/A+r067FjoeZQIBUBOLTVCrPZhFrmMRsev1/4rQDHkZfScTTMtaCxFepT0zB0pmf
 5Itu6PRUH+VTeKkVZN641kdluZ0T7VdfR+zL0YoyL9TA8QR9L+16nieA38WXTEZAPvSbeS7ZyRt
 zB8IFgz8PhJETHjwsfREgPqmCbJ/0rFDQU6OouU+D0vAyyvHsnLYJJGSLHwSFGxriOLd/YfXlBq
 dMZJaF/wdnjVAOlcvjl6khoiERdKSglEFtjeKxw=
X-Received: by 2002:a17:906:9f91:b0:b97:a1ca:e100 with SMTP id
 a640c23a62f3a-b9c3f14c9e0mr33472066b.32.1775075090291; Wed, 01 Apr 2026
 13:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775023421.git.michal.simek@amd.com>
 <cb15ff67b9915de6f0153d2b9f4114f9c8d8edfb.1775023421.git.michal.simek@amd.com>
In-Reply-To: <cb15ff67b9915de6f0153d2b9f4114f9c8d8edfb.1775023421.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 16:24:36 -0400
X-Gm-Features: AQROBzDMLrT2DZrCbu2p428i0IvMRoCnRZB1npfnD3M48OlkE8xePm9x9hCmV_k
Message-ID: <CAFLszTiGPx6dax6XnQDx82E4zsSEUHot5tqaKgdo-DUQvipLXA@mail.gmail.com>
Subject: Re: [v3,1/3] event: Check return value from event_notify_null()
To: michal.simek@amd.com
Cc: u-boot@lists.denx.de, git@amd.com, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org
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

On 2026-04-01T06:03:43, Michal Simek <michal.simek@amd.com> wrote:
> event: Check return value from event_notify_null()
>
> event_notify_null() returns int but its return value is not
> checked in run_main_loop() and in fwu_mdata tests.
> Add proper error checking to all unchecked call sites.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> common/board_r.c    | 6 +++++-
>  test/dm/fwu_mdata.c | 4 ++--
>  2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
