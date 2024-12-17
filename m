Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8378E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AED48034E;
	Tue, 17 Dec 2024 20:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qhm+zfaE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC76D80312; Tue, 17 Dec 2024 20:47:25 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F07D880107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436341f575fso44720795e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464843; x=1735069643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jq1ZG7UqXYig6TSc+laARbdlJXxYmTIyqYtQh+4TL+A=;
 b=Qhm+zfaEadNUQ6slgfxqIiZJzfecINAD4zxjk4NbMVvwdK7hZOEIPpkWocLcgbPpow
 sAYYDKL2/s9dqiYl6rYWBW0BYiB74iEbRZffb0Marb422LLKPwgAqtwq2B9dg7WCDUuR
 0LN+9Yq4Coj/JlTVDSkaL+y6H9kG5tMPJXTfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464843; x=1735069643;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jq1ZG7UqXYig6TSc+laARbdlJXxYmTIyqYtQh+4TL+A=;
 b=gB1T3sCXpHw7QqPmiVbFA0F1OGd0p4i2sCTs9IMhY2hrhdplG1VXCjYRKkmStFKEhx
 gWm/jGV3iIGjOem51pofdc58fvsOAarqPM9xuCqhJzXta3I47mC8GdS8RSW4f3gYdoli
 21WMe6+qL1c2eWF8EACXKCGjXCzR0DQY9zc+HuWWV1Kxk5ElS2VCrCQBq3rXfYhtOlef
 6wJ8Jy7oq2wkWiB7VAcKffD2bGyQOKhOPgAVdUv4g99r7LjTLSar6PvvcaL73FWqCSGp
 HmvShJdUJU7E130prwND+fBU5+DvVWaK9D0jT89WNPHgyTdEywGMD5yDa6m9LugYiGHZ
 pzaA==
X-Gm-Message-State: AOJu0YxL0cDKcR6NmLaiK5LxBIZ3j0p4WRUk0fSrzGSDSeWtmYETOi19
 39yhyHoSdKWZym4tR8vFy4c054BiJzLB4+QoN6olGa2gMSC8LK6j0Kjmi0Oc67iFBZ1MJrOsT5t
 QjDM7zUjXPGJ6nHf8lm1YtETib2Z0+lxh+Jh+
X-Gm-Gg: ASbGnctW3sPJ7s8ctwA+zLFLCYUVkVEJHdE9EvFGg83kgVfn6DaokWNIIGt+X5rXRF1
 kIMDGvn8jD/7ZcgyyICuQ2CLhksE7D7e+rcHMe2Q=
X-Google-Smtp-Source: AGHT+IH8dXSlvzbPN+HQ8MkCxpc3B8jKq0Wx5+EeAdJYeaC7iV2BhPnycwFR9IA6dp3+OkTwxUOl65mSKTp3wZNt8Zo=
X-Received: by 2002:a05:6000:2a4:b0:385:f66a:4271 with SMTP id
 ffacd0b85a97d-388e4d6a338mr135353f8f.4.1734464843488; Tue, 17 Dec 2024
 11:47:23 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:47:20 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWjL9kduAOJDEHKU0CBz87+ZJz_4TbXHmR3DdPU=i38+_rg@mail.gmail.com>
References: <CAC_iWjL9kduAOJDEHKU0CBz87+ZJz_4TbXHmR3DdPU=i38+_rg@mail.gmail.com>
 <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-16-sjg@chromium.org>
Date: Tue, 17 Dec 2024 11:47:20 -0800
X-Google-Sender-Auth: GoC2J0JPJt6Zbg-ebiPSuQvk3bY
Message-ID: <CAFLszTgqUFMRGEdOzxs0PN=XOw9uvw9D25YGqTtNSXaBT8jtwQ@mail.gmail.com>
Subject: Re: [PATCH v5 15/23] efi_loader: Rename physical_start to base
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> The word 'physical' suggests that there is an associated virtual address
> but there is not. Use 'base' since this is the base address of a region.
>
> Change some uint64_t and remove some brackets to keep checkpatch happy.

Please drop this. physical start is what the spec uses and it's a lot
easier to remember when reading the spec


Thanks
/Ilias
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_memory.c | 38 ++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
Applied to sjg/master, thanks!
