Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6057CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B7684874;
	Wed,  3 Jun 2026 18:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ueT9zidn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20EAB848E2; Wed,  3 Jun 2026 18:22:50 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C2738469D
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so118976375e9.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780503766; x=1781108566; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8dX70j20CQMPt6whvUJlcTYZA1yYFATm6Yp1uf+IeA=;
 b=ueT9zidnYZXLrcgtL8TyLTWe13Pk1AtsAqKwM0LtY8q/2eOBkobbxu8oK9S0vEqOpV
 Oe3msAB8sG1i5nih/cRG1R0l1kKvXrkuDjBxFO659g3XuKHKgOG+679PnE5N8hWsEo4c
 AUNAGwaBpVSYUykiwJl3PPeZNy/2RVNj63cWTicnwSsTjbV2oXKRLVgkeUn4jo8yB6uS
 ggaK3/fhlWf3yR3fQrGHPWIcbR0dGtCvFktEczx8WypIo+U5j163+eCegJ/8jHnT8UzK
 /d+le5sq9C6hoSAGQXrQkKdHwgQbzgZ+ZKxYpbTe7AsSJX4NbnfzNEb086wtkTntg32x
 DUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503766; x=1781108566;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q8dX70j20CQMPt6whvUJlcTYZA1yYFATm6Yp1uf+IeA=;
 b=U8TeokdfdfYC/hP0cpZwJWssh3YMZWYWN3WK4u9AyypL1W7lqgozq4F745ou8vKGFQ
 QOg451o89VfWcyepa4hruJDjdn5oK1by+npRousYoEif9wN5GH7o5ecfS4KCyH8eZTGJ
 3fEqWSbly/bxs7J/c+eIMHeNMA1Gd89gcjRi0QbvZ8jXTdhYuocqAQAF2vjZaqClCk/H
 3sVKR+a6zeEBvx9fHU5rF7NZaGDLjroUdHQIiwKlxdk859kKxbYGSZ5nIJxHcVutUB9U
 yUXxVDqFbgkK1U+eO2x+x+UqZ97zDYl880IQHDyVvebbReTaEUhFcnyjybpzUfbTdcD8
 8Ekg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pLlQxCMkB8xFktZaIu8RkdmL3aF0fCmCDWnUTpwgc+fKe168ux6+rxpMOYr6gJoHBJglsq3c=@lists.denx.de
X-Gm-Message-State: AOJu0YzCHajXdrM6s1INIhh8L0u0A7NsUTaqgQtnODP2175MAGDADP1O
 g9lSv290i9gD7duL+xQ5bDy+SlSO4vfpyx8FSb5c4TKZ3gEVXVI6740fUUa/H6+2Blg=
X-Gm-Gg: Acq92OFjgde7Q4R7Z9DC+E5N/AdlBticFON/OG4lWqMGckbr1J61cjUvCD1RMDzoQYN
 6CG6nz9oCepShq2bu0vM+5KbzO13pPQl5XU/H/5cSbc3GPYXNIchZsJJc4KgWfjYgWFpsm1tJkY
 iBytJDAAn5zCk5axSUpuB4f9Qkb0j+zuHK2l1Sl7zZNvwd+vm8U9F4ZQ3phQ8fdqdbGoNpjD6W5
 HC66g7S389/DJx0bavUaaGbqk3ltu1CFhUNj8/blDiryhRiCIXrQU+FqXpXDszJcD69PXR5TTol
 2Y1H5C/HRasASk3DLox24WwgCvmJ3hy28bI+ZU+oVGXrg9Vr9JRB2hzPII8fIc3b4bLUiFQQyJJ
 nRGfCfst6d9qCyxPhWyXC20+n6Su2YyZ3HSJavdJO4Ml9FI/m0cyB8wHg1LyQ9eUt+j5DtfSs6V
 i9XRNbmQ29UGdbMax86bfv9NYSkupkg5LTW5h5BG+0cnpu/SlGBG9t3Z3YtP/x339Ykg==
X-Received: by 2002:a05:600c:1c1e:b0:490:b35c:88ea with SMTP id
 5b1f17b1804b1-490b5ed1429mr70596095e9.15.1780503766419; 
 Wed, 03 Jun 2026 09:22:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b7d6b990sm33713275e9.2.2026.06.03.09.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 09:22:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Prashant Kamble <prashant.kamble223@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20260524100625.11135-1-prashant.kamble223@gmail.com>
References: <20260524100625.11135-1-prashant.kamble223@gmail.com>
Subject: Re: [PATCH v2] nvme: fix dcache invalidation range in identify command
Message-Id: <178050376572.31799.239213310684239538.b4-ty@b4>
Date: Wed, 03 Jun 2026 18:22:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Sun, 24 May 2026 15:36:21 +0530, Prashant Kamble wrote:
> When the identify buffer crosses a page boundary, PRP2 is used
> and dma_addr is advanced to the second page:
> 
>     dma_addr += (page_size - offset);
> 
> The subsequent invalidate_dcache_range() calls then use the
> modified dma_addr instead of the original buffer start address.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-nvme-fixes)

[1/1] nvme: fix dcache invalidation range in identify command
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/29c40bb2a13ed1c294497044e2299cc0a511ce32

-- 
Neil

