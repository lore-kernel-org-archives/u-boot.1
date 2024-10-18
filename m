Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55205D30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85F7F891D6;
	Fri, 18 Oct 2024 16:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cGJv1EY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6039890A9; Fri, 18 Oct 2024 16:53:03 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 567E6890FE
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbf0769512so12664066d6.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263175; x=1729867975; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fy3aJYz/CklOekapZHkuRpKSbkC5kCBlTH5eW0q7FLU=;
 b=cGJv1EY8cIe3o4MTrJkPJvzzwpdfUZO8u7DX258ArNN5bUsS/SNzSYUlFzQ2gEO59M
 ln8sNUpzODBUxFLpkHkMwyqeUMpMeLZTxc9/P6tVBqVGbMWohwbhdLRtrT6KTrrn8XTC
 /8IntwRx82OSw3opvPKoNg0SmDmPOl6bJJiHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263175; x=1729867975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fy3aJYz/CklOekapZHkuRpKSbkC5kCBlTH5eW0q7FLU=;
 b=hWq7J54FNsZIvkFUEjZQCFVbHZhY4L2pqnsf87dv5pCBL6b/sq97dM5oPqHNkVipAl
 QkjS6yVJszSrHieZvsGJVV7IHBZUPBP1uEDPW3mMRXCLM8iRSSWLPWo4R6mWEDWP2YNo
 T4SrHGNFzCF7B+qHfmC0EH9vADHc62LbXwiTRdrsWj+sSzjStMHQfvcm0kAZaC6m48+G
 DJ8bFxiHFlDB6c11BJikbsGllycBnnXZ+tb41ugT7IT4MmL5A0tY2P0Uz2LWTQjaIipO
 fpp77pn78qt+r2VD0vOAl7G76bjnkQaqjkd4Fd24tJu2k63eyi7vFqAOGMXEb5KGrQCA
 iLBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+GQZOiocbSy8SrN8kWPfcC8gSJG6PIQnrMbyp3XdpkcqrYGRzTo5CbhQmx0tfF8PDJP0HAKY=@lists.denx.de
X-Gm-Message-State: AOJu0YwPJI5vRZpLcbanyhAaKIf/T4wRQz0TyAY/qiU+fGOalc78+Wn1
 q0dhNHjc0Xf0mt+e/N50o5wZNhMCtoAeG1GzLmmtIPTMu2myfBW1QP67eY8okC/KZg/tLwZnvM3
 WAKpkQQQF/utfKdN7CXlEGeubhHxjqeqNJ/l+
X-Google-Smtp-Source: AGHT+IEb0S2MMsqpBCdArRUefCQNYq6Oknd0bxenviWUrsUu4nj9fLiMELAhruEmqtTWAa0obo0d0+WRsbu9iuhHeGk=
X-Received: by 2002:a05:6214:428b:b0:6cb:e648:863e with SMTP id
 6a1803df08f44-6cde1604c46mr22485996d6.43.1729263174946; Fri, 18 Oct 2024
 07:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
 <20241018013015.127620-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241018013015.127620-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 08:52:44 -0600
Message-ID: <CAFLszTgJ2Cu1q-N_ZUnDAw0766EaMNmv=2QFvoy-Ew2Jzn+Nxw@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: make blk_create_device() static
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Heiko Schocher <hs@denx.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, Johan Jonker <jbx6244@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

On Thu, 17 Oct 2024 at 19:30, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> There are no users of the blk_create_device() function outside the uclass.
> Let's make it static. This will ensure that new block drivers will use
> blk_create_devicef().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/block/blk-uclass.c | 19 ++++++++++++++++---
>  include/blk.h              | 17 -----------------
>  2 files changed, 16 insertions(+), 20 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
