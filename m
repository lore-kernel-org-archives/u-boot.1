Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE84CD6E68
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 05:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF13A84881;
	Thu,  4 Jun 2026 07:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fvfeOP34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C15F084895; Thu,  4 Jun 2026 04:21:57 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5A2D8467E
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 04:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=docular.xu@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8423610ec93so124075b3a.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 19:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780539714; x=1781144514; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m6uegxWg9rFHk36kXf8iboM3vFYF9iE7AkOEjo+NsDQ=;
 b=fvfeOP34OVYdabkkyi6mAMjR3THo08uiMYyimMR2yo8yJVIkpBiR/OA1QsU5BYIFuV
 S/c5zxTN7Y6isgIElBomOZA/TLu3u3CsB+2Se2P96rJTRaV3UrsI12dmbwdYCZwYVgfY
 lUabpm4Iwoitqtr4ucQMWcNzyPtTUadSZYPHujMExXxPk2vzagpiyw+ye3Jctmyz7rqd
 Ef216a1EplEjzRtleagKuOIDZMyC/mmv5xzGBahIVLmiqhy6zwJay2PBFf3AaQCYF6sg
 f6M5ZHVeuG6xfQod+yCS/2OUodCcRNdmg/Z8s9c6mw8doVHv1v2eOrDFMslDgR4qIFfb
 C3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780539714; x=1781144514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m6uegxWg9rFHk36kXf8iboM3vFYF9iE7AkOEjo+NsDQ=;
 b=DC61YrK63LYaoQ1ZMGQ8xvSykCZlVb+BOV0vcdAsfvfaTA9/aapmlQ9D9cLDWKAhJb
 aIFfys6SMFCZy0L5i3WPBW75d99S4aatpI8LSD2d20vTK29HkdZ3pDpH+mByfFqWwZDX
 aC7scgKt2ckn3G0uRPtvmuunFXPDGyaevacla7Kji6d4B+FE9LcNN1AcaveBQfdhGiMs
 hBKCfyurMZKlz7HqiMFUCo1DuacvCA+iUqqGCBrU5IwQoYrYYEI70cmGN7M2Nr5uOtz/
 Z5rTJvkKWf61XCk++9ofNHJ5xuh0E8Mas3+hN1w1x1TaURJuv/l4QG4y4Fc/OWtmIS6c
 TUkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ961YbcwkLekQIEA5vQUJ8PEneInQGe4ek5xtdjsj/0D45X0VM28Ug68NUkP1JjPQuWyYJxmKc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2nOY9c8YGE6jbZ+COWzPa4sOW3mvLgzS7O5XD/E6wuF9eNx5L
 XpgNoh3stxRyW9ItGEUJY3uSDyZMETcAoSyLa7XEadEhdZoNScY50pNO
X-Gm-Gg: Acq92OEmayegGT2boJhT7oQlfz+cmJMSt7TmJ0mfvVOjRlLIptwBGFBl5W3xt//943d
 MCULrYdUanfs0V9Kk302PtMoI64H8LJ0RHbq51rY8MfyBjcduGZwvT3aN9BGCaqLzQ0UftD4u/Q
 xXzgX88AZB917KC7ykNfcmm+W8JJzr9cLRipLHu15iQWOdz3BfAgL2nvZl1me556P7PTXesubUw
 JL6sUoduBpkrKg+Ebn1MFqpdF7iIgzI+Rp5mNx50f3/NN18A2tpAbS/wH2ESLXLQ2Z/h0lb5u5k
 jMkNg5HKobgf/5DezGYG5gUy9wcrNdBRYtIkNKRqcGwbUQ6wihmV+9OqVLbaDLmTNKHftm5LZzc
 Z2TbEEAExJjfIjyASk0WWpqiJM8o8vOld7QumsLSkxBw6AkUTGsIA5iKB/y4SLwh1QjXwTh3XKt
 hFTaI8tfw=
X-Received: by 2002:a05:6a00:3498:b0:842:459b:d62a with SMTP id
 d2e1a72fcca58-84284e26fc4mr5933594b3a.17.1780539714110; 
 Wed, 03 Jun 2026 19:21:54 -0700 (PDT)
Received: from localhost ([2a12:a305:4::305d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282221470sm4739110b3a.6.2026.06.03.19.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 19:21:53 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:21:15 -0400
From: Guodong Xu <docular.xu@gmail.com>
To: Simon Glass <sjg@chromium.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de, 
 u-boot-spacemit@groups.io, Vignesh R <vigneshr@ti.com>,
 Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Yao Zi <me@ziyao.cc>, Anis Chali <chalianis1@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 Sean Anderson <sean.anderson@linux.dev>, 
 Heiko Schocher <hs@nabladev.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Philip Molloy <philip.molloy@analog.com>, Michal Simek <michal.simek@amd.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Eoin Dickson <eoin.dickson@microchip.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, Rui Miguel Silva <rui.silva@linaro.org>
Subject: Re: [PATCH v2 6/9] spacemit: k1: Add multiple device tree support
Message-ID: <kcbjubms5betjl6mhyl6f3lnyphjkbp7kkittp6dgw546qzp62@5rwcowvikpuy>
References: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
 <20260520-b4-k1-spl-pinctrl-spinor-v2-6-8d25db98ac8e@riscstar.com>
 <CAFLszThatbG9gMjpXLNmjy1jyuTS8X+_uXKGzacRsvOppv1USQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFLszThatbG9gMjpXLNmjy1jyuTS8X+_uXKGzacRsvOppv1USQ@mail.gmail.com>
X-Mailman-Approved-At: Thu, 04 Jun 2026 07:10:31 +0200
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

Hi Aurelien, Simon

Thanks both for the review.

I'm moving on from riscstar, so I won't be sending v3 of this series
myself. My colleague Raymond Mao (CC'd) will take it over and address
your comments.

Thanks again for taking the time to look at it.

Best regards,
Guodong Xu
