Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3C6C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36D748716E;
	Wed, 15 Nov 2023 14:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UjXSlWrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A07C4871F0; Wed, 15 Nov 2023 14:16:59 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F0428615A
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9e1fb7faa9dso1007279166b.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054217; x=1700659017; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cQicGWinVP9SRh0HxYf99sFHEfXI79ZdZZo0WlfZAr4=;
 b=UjXSlWrZcQ0oakUsUH3h/Dmadxs8E1/BtO7hQDfxN4xaVX0a/s0vW2ApzykvAf4zW0
 QRhPkmSGen7+d0WBQ2/4yih9VNU3u75MlpIsgcTrM2hOrt+JguD+bPXNBBDT1+kTjOr+
 5kYqCFZ6LcQD5q+pvGdcVg9dfYAykWMTcNi+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054217; x=1700659017;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cQicGWinVP9SRh0HxYf99sFHEfXI79ZdZZo0WlfZAr4=;
 b=A8omRAnkl19WgdSdyaS5FvZPTXVyttM3aK+5Haq2/1k+/D7WcsWMA85XojUuwCo9Y0
 +Re95QjbnBrnOzavQlTGh9nJ65ZhFC+N8rVxJRaTui17onZxv4m2HlO1XLFVE2dSgB3m
 +ckUXUKDyifJF84prq2OKXOqtSod3Fhv85Zaf8KqT0FauDQoGkaXFPBSbj86Aqr5keiw
 LzVcsXCP4fogyfrUKdUdYxgEuFGheyPHP1MbF1dAfHHt+cNWOUYeHn/0KmwH9znbfKfQ
 dmuqcCPdL3CR1TpM1HCPLQVJ2w319JK5FJlezrK5WUEL7lpdS60LSS0LVp8MFN473jp4
 5bPA==
X-Gm-Message-State: AOJu0Yw4FiS/Qk/z+1pfQ3WWbCa/uAa3qaAB58MRb5LX045PC514KG3H
 QbZlcna9NUZ4MJaLTv7qaBty+u+fnC0vOrkr2dlwXQ==
X-Google-Smtp-Source: AGHT+IFYOPRPFSyekmDbpcCS2TNxjOqjm4ToY+ThunUbJY2sE8OamCGQ2Y+QUu/Z7ELpYZJmoORYhrFpFZhswurHvOc=
X-Received: by 2002:a17:906:cb89:b0:9e7:2d0b:8c74 with SMTP id
 mf9-20020a170906cb8900b009e72d0b8c74mr9193186ejb.60.1700054216948; Wed, 15
 Nov 2023 05:16:56 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Nov 2023 05:16:55 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2cSpXU=RKQDCjzNQtBJ7=rrxPDkqm+g6WQX8KenJftDA@mail.gmail.com>
References: <CAPnjgZ2cSpXU=RKQDCjzNQtBJ7=rrxPDkqm+g6WQX8KenJftDA@mail.gmail.com>
 <20231104184043.12419-1-heinrich.schuchardt@canonical.com>
Date: Wed, 15 Nov 2023 05:16:55 -0800
X-Google-Sender-Auth: OLP60k8Xs97sWOgvv78RWcDDCk0
Message-ID: <CAPnjgZ2Fv7yzXWSs5RASS=zap_56NkYzHTnPGgZVzmfup=Yevw@mail.gmail.com>
Subject: Re: [PATCH 1/1] dm: Do not enable debug messages by default
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Sat, 4 Nov 2023 at 18:40, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> CONFIG_DM_WARN has a text indicating that these messages should only
> provided when debugging. This implies that the setting must be default no.
>
> We should still create debug messages.
>
> Reported-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/core/Kconfig | 1 -
>  include/dm/util.h    | 4 +---
>  2 files changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
