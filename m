Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ECFFF8864
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E13B383693;
	Tue, 28 Apr 2026 05:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="hpnmF7m1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3FCF8421D; Tue, 28 Apr 2026 05:08:58 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 767B483BC4
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4756e74f8edso7635673b6e.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 20:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777345735; x=1777950535;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7mgDB1eD+lNRL3Xx161jwV2GMbbLih1BSF97C+IktJU=;
 b=hpnmF7m1UtxFxg0ySHCXVDWGX5pzsZXi9aR4wZERY8Yv6pDcmCkTS9QCxT57+FwE7h
 9r94prlPn3qaVcJvIsOOC2/y2a4GGHN1IJ3UHx2zVmBPRgSZLGOUuVL7paboGSZD3nsY
 DDnEswindYOaDNk6DbkopPJW6qdk87vLCdTjBhKFUFIm8h1ZwfBjUnd8lCsHpPN6kcCe
 upyQRiSANjp29W3igVtEoSIEGYKoLONcycHvuf+2/sVhLBDV1QwucFDGyjQ/s4hm72/8
 cR+2QkbzazxClm/vJMksEktUVU/2wkMcQC+jumq3bdV3XoEMOMXe49zT7fvjluz54lrE
 Pa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777345735; x=1777950535;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7mgDB1eD+lNRL3Xx161jwV2GMbbLih1BSF97C+IktJU=;
 b=EyHjcW2D4I+X+m5cpn64WdzrXqHvqRYFN+dv9IOzyGPiKN4wEWyX9i+Umr4l/AOlP3
 IeruP77l7jGPRPFLx5xiz4fLu8mKpWsy1O0R/vB8A5P8fDU8WgCNjd6e6T6AG5cZUcfW
 DZlOV2Hs7ahhZjHANO5nykSXoJhiQAlqrQK/zF3FjXVvqq76gthpeCxilHbVTD6py2nr
 onQ2OKCkprAtSnWEN2aezAX4ln/5pNh+1tHcoCuKFoTBRXjcckW0wJ/xDVRnK1DgGCNK
 i36suzLIpKufMAW1rL5/AkAeh2WAW9RVH3rJL4i/Smm0Gp7Kx9T8j1Z6LzegmuI6k73E
 DEiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ90Hxa/AE6DTISDvdozU976qEGO27vUF8aBJ2Gm8PcrLj+EdWLPBnKQbUF1XMlr5nrYCKdytz0=@lists.denx.de
X-Gm-Message-State: AOJu0YwK19ksSqF+UpoU+cckIUKVnnW46vw0QiPMQgzGDOdRI/jAiB29
 PE+cmCczu36I6TUQdOlCokI3/rlzyh1PqTBSRCsdzUiHLK+hoAEEVUs59XUF2bVrxN4qPwdZiFP
 3ES9m
X-Gm-Gg: AeBDiet10oBynRAnRyR9geA0JHrUCZw4yy5cpHZInRXVUhJbIr0SMZ62bSSD8L0hnoO
 kVu2oFOxUE7+l8f+JeefWjIT5eH/l0mwJgJbHETshkUCpCtMaryJ6f6IMDZwY/geaaHo+Ydz3aE
 FwvmkdUgA+bRE3jG0jP4MbZKYuNWxCfl2dHPYvYSel8vRKWV7oBpXHnXNOaIPnsCvWm9nWXTWhE
 Yc0WvYmZnuxate8iZIffjehbT14lpROwSaT/iLlSqCnJNv/7K+mMoGNyKMbNDh1PSKnGL72/eR1
 Lxkuq/ScvZ0UANnnR5xkXjLYmHox3WmVkjmmTk8Kww3pURpLkvxLPYaKRA51pFVqPboVMVCcynz
 mED68miwVdOHJBqcuG0w+SwrTN/QWPFRbwT0HHltbWq3kyl3c59+L0jfIU2LdeMKvI3cCG6j0cv
 Mx3g/IKuXcFMJyeq+PopwTvjFXwrj2LPz+aidr40Vviv5LsgvtsrS7hrJgmnRJnO7jnZRxuT7TY
 noZgCsiCwignOourpobVzg=
X-Received: by 2002:a05:6808:144c:b0:479:fbe5:3a4a with SMTP id
 5614622812f47-47c291c5283mr419205b6e.46.1777330670040; 
 Mon, 27 Apr 2026 15:57:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:efba:bc47:a81b:dd0f?
 ([2600:8803:e7e4:500:efba:bc47:a81b:dd0f])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c291bb1fdsm320180b6e.13.2026.04.27.15.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 15:57:48 -0700 (PDT)
Message-ID: <ff1c773a-fa47-43a2-920a-31b215536f3d@baylibre.com>
Date: Mon, 27 Apr 2026 17:57:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: mt7622: remove empty header file
To: Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Julien Masson <jmasson@baylibre.com>
References: <20260421085627.78213-1-weijie.gao@mediatek.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260421085627.78213-1-weijie.gao@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/21/26 3:56 AM, Weijie Gao wrote:
> Remove the empty include/configs/mt7622.h header file as it is not needed.
> The Kconfig entry that referenced it is also removed.
> 
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  arch/arm/mach-mediatek/Kconfig |  1 -
>  include/configs/mt7622.h       | 12 ------------
>  2 files changed, 13 deletions(-)
>  delete mode 100644 include/configs/mt7622.h

We also need to remove this file from:

board/mediatek/mt7622/MAINTAINERS

