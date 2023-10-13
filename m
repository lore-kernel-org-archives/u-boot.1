Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD82FCDB47E
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 01:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B9686F10;
	Sat, 14 Oct 2023 02:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g6/XZNV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B52C86F53; Sat, 14 Oct 2023 00:03:36 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D1FC86611
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5079f9675c6so783098e87.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234440; x=1697839240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3z35guY+/kZnRVkPpwhY9SOoC35X+1mPtWTjvEdrXy8=;
 b=g6/XZNV+E3ernvn6j/gWmRqi64jJSTR9O9oehNAW8uOd2UDES9mR6LsyO4jEFsYgPF
 mj+dNVeA434Lxdn4W2w5pzgx4vsaqQVtrk1FaMN6IYcB3UlWfc/edb4/Xn6dNVKU1M0L
 LrsdrYJwgpTJf7cyEcReJtqv9Z2kcjsHMwE6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234440; x=1697839240;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3z35guY+/kZnRVkPpwhY9SOoC35X+1mPtWTjvEdrXy8=;
 b=IyVVt/Uw1yHrnsmlbmroJlKX97vE7spq8KHVjDIsXo3rCFQfqfeZB4pYPMSBpxhqZy
 +wMvs07HcC8BpJNFAU3WsJgL1aUR1iAOSVZTZYUC+XzePHfs/1+wrC4Ph+rgiL2eXFjT
 qmfT+snU9h+aQZWK86joDcvcqozAE/2Vx4PfSkfP2KhrRzkuipj3gEKOH9vLb7EFZG6L
 7Qvz19rwoupBv6X5TcDqAP8O84WWoV4ciMhkViUR72tBjoLVk5YRGfVXXO9K3ERPY7ZG
 pjiLoblVR1qLU7gUVLJgyJUo+2Zv0CjuaMzVn7T8Z/2HGk23HN+qkOh8vxp1dT8ci1jj
 7GSQ==
X-Gm-Message-State: AOJu0YxDd0am6jBE9n9wuDCG34VSjDJkFuv6oR2JBoBukBF4vwIYHXg1
 gpFPUS3NEJzkIU8gLOggoiFgR+OIcErCYHLQth5Jgw==
X-Google-Smtp-Source: AGHT+IEMno18V5mgVunnUjlhbFIt5K5yiFDv58AWTDXDQ8+c92pm4witkccdSAcQK1drCsq2r7litzBLNHp+qPjRUK0=
X-Received: by 2002:ac2:4da3:0:b0:503:3682:2624 with SMTP id
 h3-20020ac24da3000000b0050336822624mr21732411lfe.48.1697234440335; Fri, 13
 Oct 2023 15:00:40 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 15:00:34 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1HiyVOJy7RsmNFOq3iQaVCUfyv7ED0akNiSz1DmZLYDw@mail.gmail.com>
References: <CAPnjgZ1HiyVOJy7RsmNFOq3iQaVCUfyv7ED0akNiSz1DmZLYDw@mail.gmail.com>
 <20231010091059.375036-1-sughosh.ganu@linaro.org>
 <20231010091059.375036-5-sughosh.ganu@linaro.org>
Date: Fri, 13 Oct 2023 15:00:34 -0700
X-Google-Sender-Auth: woQiFXyfPnGsTN8xle1N2hUcecQ
Message-ID: <CAPnjgZ1sLoOrHYdG9FDSCBk9oJwiupn1PBfmZ=LmGs6rcf5gaw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] binman: capsule: Use dumped capsule header
 contents for verification
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Tue, 10 Oct 2023 at 02:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The various fields of a generated capsule are currently verified
> through hard-coded offsets. Use the dump-capsule feature for dumping
> the capsule header contents and use those for capsule verification.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Move the get_binman_test_guid() function outside the
>   Entry_efi_capsule class so that it can be called from outside the
>   module.
> * Use lowercase characters in the GUID values
> * Add comments for the _GetCapsuleHeaders() function.
> * Use a simple dict in _GetCapsuleHeaders() for storing the capsule
>   header values dumped by the mkeficapsule tool.
>
>  tools/binman/etype/efi_capsule.py |  24 +++++--
>  tools/binman/ftest.py             | 105 ++++++++++++++++++------------
>  2 files changed, 82 insertions(+), 47 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
