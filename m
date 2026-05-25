Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50661CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E5F848B0;
	Mon, 25 May 2026 17:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MzIjtWjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDDC2848B0; Mon, 25 May 2026 17:15:35 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B43238482E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bdb3fd39045so675195566b.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722132; cv=none;
 d=google.com; s=arc-20240605;
 b=Dd2vxhxCKgyxeVm8/XxHQuokv/ySRWfiuZlkvdS7FiQK3wS2sWqwxfrY3qjiTS2uvr
 d7EDsNoa4n2x+xaHt0SCaxSUMnfshj6sP3wEz07p0CgM/fD5z9M4+FVO80m5Dwv3f+q3
 jQc+w7fOPxX5+X4EuQYBSJp8McGNFwn7kAXgiqFqFl56HMWVJbKnRbiS0HYc0MF7NXZX
 saSwYz+/LVCMyd8dnwSS2QlUEo31E1/9zWW3RL9myn7YAMe3QDZvbC5YR+fPl1hZEJjR
 Fjx28jVv5YKGJtlottuYvEfBOjUV7mgMH0LExa/3BX9PBbvR0ZX3vYRtEh8WZFKvyr7M
 tCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ftP9cukxQ+Xsn+7LVGiG6yGx6wn5IW+eeym2RNblZZU=;
 fh=ihk1itZhMyktciX8eNBs5bqM5FiQIZ4RSe4vini1smo=;
 b=W95bsDABD+4YWlsv2LAHkiYaMeaCo5tt+7z8XgwDOmvJItA7puDfZgBWgq6guIJG2H
 WUpUw2C826LXYkMFx91PF8o9uCt3ppJq3SmcZ139UJmRQDeu70xiKrfg473/Q0RC9RqW
 q7AmEdXqxTNBDgumCl0GP4+oTKWgbe/xmTjNbNHPtj4OMv5mDGS1YXOgrmuCh1Qyn8hM
 3sL0KKPzs1ZByiLuhNOi86fqHy0Y0ojXVu8PbSRZ3Q+5a6mRgUwlX2OjvrZQI9M13rxH
 bD8FOnGczVGHoei3it+PTdE7bBgI+8c4e/ty6K5a3KcLvTMcD2KGpREn4KFuyUAHD186
 ms8A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722132; x=1780326932; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ftP9cukxQ+Xsn+7LVGiG6yGx6wn5IW+eeym2RNblZZU=;
 b=MzIjtWjPQuYL6z/9HK+Mx7DeAH6gT0muPq7xCFHtuaVDuVpimi7Yb6KELxoe+IxeSd
 MdiwIJ+CHlvs3RiXgS8LPZzdWZbXLnxnsNuV7cxfvyWcnj+GJIO94r3qUFtwczSs+M/M
 gVumMZr4uxF0fb65esjw7BGLU1hQYSBduvXAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722132; x=1780326932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftP9cukxQ+Xsn+7LVGiG6yGx6wn5IW+eeym2RNblZZU=;
 b=KbYNxa2oijIcLjCtpBpxYqUDlAz95vzwM2DcfY8SWxCzZ6hdpSIvjfyyauVVzdivGR
 L5AJmEtJt0AVDtZNLSboWT5Y3iZu4mog7VrL3wDCGQZPUnel9puXxLKdifNpI72wWwSb
 CaM1gukE810eatt5e6HgqbqpSfruGvS7DV3SOzqT+HoyPnbppe1QUD7jWm1gadD17Ins
 ueR6UhM5NCUQRg2jqqK35gVfp9WUCo79xXBLvTsmUZOzGP/APziHBZSUBaHeFO68Oobk
 4qpl7RsITXMcWY1pfzCG421JBUazzloujdOIjv32ScQxw3GH2ni7EVXhCmX/+y0AwA2+
 K2Pw==
X-Gm-Message-State: AOJu0YwiOj64iiPM5gQxpxXTzmF5qkUwj+RTU/w8rnDbh2SIgPrpOcrl
 pfu+gTO9T2u3+DKM9Xc3I6pPr1yQpxLRvIdekIdPsFjfHekHqCvDP0OkHUJD8dpWuu6nQ9EBFOK
 axuUiLP4e/7UWZzz8JVvjbd5z/u6q0mmi+Qa/9tBf
X-Gm-Gg: Acq92OFOLDDmw4Hd2czZFzVCNvw5t65MLiqO95gNoTdk4qO/u2rNJLQU1HCVU8cgTru
 6c5yX29tbDC20ajUlVXb5KzCxYNIzWMLd15PmKQGO2xb34rumH30sQLNUPJAezCQ5G1Hda63Egw
 hK5F0WbE9qS1DfdH/2WHUcyyhEIur06AeOw7nUT6YYR+LtP4yJivFwaUO2I9qJUxOGBj3eBiB5X
 SrCjoNasPRd3jcnDu/yLjtSSxBAPO4ILKe0zWsXt7+/ziARYdF26Y053GQKq7/jzdCoaX98yDPi
 ZqhdBg==
X-Received: by 2002:a17:907:3c88:b0:bd7:e0ce:9824 with SMTP id
 a640c23a62f3a-bdd2542d562mr853265866b.3.1779722132121; Mon, 25 May 2026
 08:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260521190011.32751-1-jonathan@joggee.fr>
In-Reply-To: <20260521190011.32751-1-jonathan@joggee.fr>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:15:17 -0600
X-Gm-Features: AVHnY4JL9DZPrMG21OaSBde-JqYF4B7exhQKcnZqYjpOXZ5XN2ZvCeoSHxX5JEk
Message-ID: <CAFLszTgTKJHO1JS2GZXcOyHaVMTOKBv6ovv5Qhp_NX8Ck83o=g@mail.gmail.com>
Subject: Re: [PATCH] doc: wdt: fix typo for expire
To: jonathan@joggee.fr
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

On Thu, 21 May 2026 at 13:11, Jonathan GUILLOT <jonathan@joggee.fr> wrote:
>
> ---
>  doc/usage/cmd/wdt.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/usage/cmd/wdt.rst b/doc/usage/cmd/wdt.rst
> index 711b74d20da..28abf98def9 100644
> --- a/doc/usage/cmd/wdt.rst
> +++ b/doc/usage/cmd/wdt.rst
> @@ -16,7 +16,7 @@ Synopsis
>      wdt start <timeout_ms> [flags]
>      wdt stop
>      wdt reset
> -    wdt expirer [flags]
> +    wdt expire [flags]
>
>  Description
>  -----------
> --
> 2.54.0
>

Reviewed-by: Simon Glass <sjg@chromium.org>

(please do always include a commit message)
