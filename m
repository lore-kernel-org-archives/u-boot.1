Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAADC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 20:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F04584CB4;
	Mon, 13 Jul 2026 22:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dX0s+6SU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29ED284CB5; Mon, 13 Jul 2026 22:57:28 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF48A84A6B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 22:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so4698847a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 13:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783976245; cv=none;
 d=google.com; s=arc-20260327;
 b=Bi1S+hCGL6ZfWOUA7HXY7SSCWYk19FVd+eFnAsljRMzPxysULpjFpyb6nAWpAlVOOG
 S9eX53Zzl0Sk640W1n1bCdutJOMFzCJzCpAIIl9oPJG+avnWVZo+/pnXNJihej5X52mh
 jkw5sWZ/cy5kelFlT1YyI2yTmgQ2zJwhYvaJu9Z9iqj8KPY2hWTI+48oh5IJQyGiK3BT
 qc68jdvHX1W7Bdl5bIRMhH86DAJBpETgdyuH18DMhT7Vm/8YcIDIGClx+LTp5O/1yJ2e
 FrdYRwynWPX1UCGZGA7O4i5XxFS67UUgsSYewIrD+t6HESn6TP1Zd+9Xxk2FBeghJt3r
 ZK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EGPrNRChVvPXQnIrmyPuLno/wzrh1+tkcC9v9Hnhp3M=;
 fh=RYRoxNOjuHPJgeepkDgPG4TS1YEj8vlj2h5gDMROLMQ=;
 b=VD0jSAn8Q6LlwukLXjygSdWC+wbBaryOW9jvmxbXvvP8Tmc8qwHCDn6pRexUhYdQ9E
 IWNSjXs/tZ3+7uIba1k3QkuIb8QHk3U7fLjwfDiq141OliiZAWA5WelZn7DpHgI0WIjv
 erAa6jPROrEFRrpeR4amltkigg/mFXzhmLG1sMwi2L+fXFAFcN6SXODfTCEJlxD9vrbk
 JyrrmvmHPC+j7CjWi/yk2PWZ07VlRZKDTcjxrxKYZZK8dB7c5RkraHX78NJVvdTys4xh
 OQFmfcaydo/SgIL73FGH2L8Egc3AtqrCg2Wyx/I8YpreMuBPYnhuYJ/sgE9Q1IF68BUD
 DA0g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783976245; x=1784581045; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EGPrNRChVvPXQnIrmyPuLno/wzrh1+tkcC9v9Hnhp3M=;
 b=dX0s+6SUHPhOwoFVhW2grPVkl9sO8wfQNHafGTdZavDGrYWqixenYhg3Ki4bcL+y4q
 Sns9TgH8FeASe7RqVBfMg92HXrrgxb4hdZtWXT5izsabTUebaApRcENXeKYKuDe46dzj
 UJyUHJi1vcuI4X/lmx0nhtwmxdVXjQq0GsTQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783976245; x=1784581045;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EGPrNRChVvPXQnIrmyPuLno/wzrh1+tkcC9v9Hnhp3M=;
 b=KybwiJgV3Le3Hz5PmssZAscOCf8uWkrRmNcCi8SLvuhQO8KObBquAS2hb75osJL+D0
 0UD/UqyL8x7fGDA9OCGHKMjIMR77BND6EcIi2AVDMNPJWAkuNEChrK8n3+8Obr0c6ndy
 vVvYqkLzB3x+RMwbQcG/niM/Q/kOa19ds7n/YieVnTa/qwhYEbGls+3MBzK4tWS1juvn
 1yUrUou1jIMXwmsY0RVIIJRUt8WnMwLgOGdOiS2w4UfUCZmDeuTNnOXaWYnag9kv4PFq
 +vBxVF1rw9jea0XWOWEvRPdnSKwU5HWqVVesrMJM1vcavawuns0c+EtmGi6UOP7vm4/8
 zVPg==
X-Gm-Message-State: AOJu0YxxA124ywzdbnn+kVvUIBFMQc1CqwwosdAr7um0UBoQrGkNvYyf
 SGhuhL7BMRV4onZK5tFKnDABThK4KzE7R5k9KAQTd5xW3iSWk+SS4Ot4n93vxHUjDO17L9I6ZJ6
 mONJ+24iOjzLmQ26vuLj3M7VsiFvDjVyKCxJIsm21
X-Gm-Gg: AfdE7cmEI67dK1+z+Ow2DBGq3IVY2kKc3HtWV1hAzcVy4OjatS871zCg2ZMd+0QYY2X
 0WyvfxX/uBvUr5Zql3a8O78LzGwz9ngIP/q5q14bMQeDEuw1TFEdZKEgw2m0Icrz1bfYE1UyLPy
 2OeqXedcDDlR90t/hbp9shKjJcLQIAMqQH5cDwDrqOlmUgfe4+YXT3+pw6YGqPlIf4zH9iXjGmU
 hD8uMoExu077+G8yeyj0LFtX9wX11O9r8MmuOOMpIUxtgxZKetvHnA7tj5FrHLetjWOxZQ=
X-Received: by 2002:a05:6402:321e:b0:697:84d1:e5c9 with SMTP id
 4fb4d7f45d1cf-69c5ef8741amr4932388a12.3.1783976245380; Mon, 13 Jul 2026
 13:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260709142901.2054431-1-pranav.sanwal@amd.com>
 <20260709142901.2054431-4-pranav.sanwal@amd.com>
In-Reply-To: <20260709142901.2054431-4-pranav.sanwal@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 14:57:13 -0600
X-Gm-Features: AUfX_myRz6WrEoLvcwqa1fqoGPLGgnjjlXq6umV8dJr-mUQegf8YuVqgm2ULNek
Message-ID: <CAFLszTjOw7UKS+7OvTkS8RHTcUNcE+YEcTuXqY2AxHdjmt0MhA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: delay: fix offset propagation in
 gpio_delay_xlate()
To: pranav.sanwal@amd.com
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

On 2026-07-09T14:28:59, Pranav Sanwal <pranav.sanwal@amd.com> wrote:
> gpio: delay: fix offset propagation in gpio_delay_xlate()
>
> gpio_delay_xlate() indexed priv->descs[] correctly using
> args->args[0], but never propagated that same index into
> desc->offset. Since gpio_desc_init() initializes offset to 0 before
> xlate() runs, every consumer's returned descriptor ended up with
> offset 0 regardless of which index it actually requested.
>
> On boards where gpio-delay wraps more than one real GPIO line, this
> caused every consumer past the first to silently collide with the
> first consumer's already-claimed offset 0 in dm_gpio_request(),
> which returns -EBUSY. The second consumer's real GPIO line was
> therefore never toggled.
>
> Fix gpio_delay_xlate() to record the requested index into
> desc->offset so each consumer's descriptor is routed to the correct
> underlying real GPIO.
>
> Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
>
> drivers/gpio/gpio-delay.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
