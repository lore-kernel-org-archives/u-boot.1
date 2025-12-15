Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504A2D5B84D
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 17:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A4A382FC7;
	Mon, 15 Dec 2025 18:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RSjSm00p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA10F8003E; Mon, 15 Dec 2025 18:19:54 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C574A80325
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 18:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c7660192b0so2673258a34.0
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 09:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765819191; x=1766423991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEOXPQm6zhDgjOEmYL41w7hEko4hlPFnM4YvWyOMcpg=;
 b=RSjSm00p+eR731cRuuQV7asciLTN6gbEgZtSuNarCtZ1mDcYzUCcCwvGC1j1xYA1R4
 O8iDAT2fa/BfPl+D3zUbsycnUsd2N31iVXZ2YHPZ2Bh+pQFXiTn8Bt+isFPt7VTWGNoe
 mN6/CceN99wYN/OGrf1yFIWk2dL4aDJxOKwdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765819191; x=1766423991;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HEOXPQm6zhDgjOEmYL41w7hEko4hlPFnM4YvWyOMcpg=;
 b=dLg53Uq/X1VADEm6aeHrN4q6WXAI8yHc0UmSPgVA/LxnZiAh0CzvsNw8qf3xaQn+Sy
 QFBQgGaNO83pbMxo0em4YthEJIBZjTdjWENl85i/ugj+5pWbXjVDfEToOCN8PQygyF3D
 vRBrLyPBKCqVNtsq6/CCFvnFAVH5JgQA4DMFw7LXM3xHc+uQPU/fDGrHDmmNt7ibt3jK
 CLR0qpAh8V52vnxHvjmyiAfP7FzOf7ZnIZ589ZU24MDKMxyZ3C0PM0luHgfypmwBL3Ai
 iGf8uVNGE9gVsOyMGw0z8OHkkosDP5RN2weZSQQ0jvLlVHldtyitYeJjiwRelzKMiPNj
 CevA==
X-Gm-Message-State: AOJu0Yx2TKofJdBedv8EMlyg7fhzrUwXONBCyqIIim7Zyl0fj51H4gfO
 O5m9ghxziAiomzKpoEDRM6NJK7eByUkUj4TipcCaBhe7UV3XHzRNkTDnHP6Wn9Yr02I=
X-Gm-Gg: AY/fxX6M/d/SYF9wbS3GftOItYAG6ZuMkVE4gDQlUoPGnMUmyxqg2wHZxQeI5XcSSYb
 6IMnfwrfXvM4WJU9jJ8wGBCETcscjRc+WTGbmW+OZLOyURiQKe0vZT6lAsiudkF0aq7ZvBMmbJh
 ogF54XZBWeBC70am55XUiRC5hojlWlbFM/NNQkmGGiZ68rKFJJOZ7GmsquXHPB0eOMuCaQ53hen
 L4hzBn/ZtFGdAH/KyJ4bRZrak7+L2s2WjzETpFncHP44wHttupR3ZIijO0uA2IgkU7OYyjqVGCR
 puvqzjLBfeBOiTlcQ4ckdoXm21+WUIG/EQiAsuGU5guPuBcv/gGjXkjGjhG0EFX2Y4V/Ompu6aC
 SoJTLezB0uq9gx2e4PBqCbJyOveKh5jtsMykcC36kZ2QEpTBqjB0FhF9opHdgsZIdW8Ck3h3HYV
 o2UzFDpLzFvOjAQWZosBah59Ij3TofTX+4PO2QcWuq4X04YD0yU4kfxkCw4io=
X-Google-Smtp-Source: AGHT+IH8D2kdRad55IEwzN4OnSOmM5tyPRxlHQvfU+OGzxlY+DK6bqLAnJHGKCe8n9gwxUE6A9c/zA==
X-Received: by 2002:a05:6830:917:b0:7c1:12c5:334e with SMTP id
 46e09a7af769-7cae834e67bmr8495117a34.17.1765819191418; 
 Mon, 15 Dec 2025 09:19:51 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb345977sm9710691a34.29.2025.12.15.09.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 09:19:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20251128-topic-omap-prm-v2026-01-v1-1-72c5cc4c7728@baylibre.com>
References: <20251128-topic-omap-prm-v2026-01-v1-1-72c5cc4c7728@baylibre.com>
Subject: Re: [PATCH] power: domain: Add ti-omap-prm stub
Message-Id: <176581919060.1844985.12009533412905319650.b4-ty@konsulko.com>
Date: Mon, 15 Dec 2025 11:19:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 28 Nov 2025 15:31:06 +0100, Markus Schneider-Pargmann (TI.com) wrote:

> Upstream DT uses simple-pm-bus instead of simple-bus. simple-pm-bus
> requires power domain support. On am33xx, PRM manages power domains but
> all domains are enabled at boot. Add stub driver with custom of_xlate
> that expects no argumetns to allow simple-pm-bus and dependent devices
> to probe.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] power: domain: Add ti-omap-prm stub
      commit: 86d2747a9c92dacccf0bedd57d586252e2c9532d
-- 
Tom


