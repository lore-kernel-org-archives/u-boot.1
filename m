Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE02CCF9EA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385C8836F0;
	Thu, 30 Oct 2025 06:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="csVKzLNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 695FF83771; Thu, 30 Oct 2025 06:01:21 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F454836D1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b704db3686cso138719666b.3
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 22:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761800479; x=1762405279; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EgGm3385DdZTzcRQzcMv5U/pmWTWNpyTByzvWQoNYuw=;
 b=csVKzLNxFTcxufbtxWmn4fK/NMmtzJ0jsG6nS+TvJrV43PQaDTtbZvy5946LDizGKd
 fwbEz2ClRwDa/GKYvVp6D3Tgkt6KtX50IZkRqekNFmrfifLEIo8kG4t1U9Y79bbasF9H
 7n3CxzflZXO5Fwiy0sVmo2Bb21Umx7EuQLgwdxiDO4N8MKUyryjQNavGV2PYi4I+aR/l
 UX0reKbpFdiHyzqIK9Vvvv7C5WwwA0jY1XxodD+7iUsht8PBbANl0vA9TRPYiXOKQQfX
 ZSabgczuWWps0Exb3b4lNAzwQkFGWE1pZr7Sy2egErth1BH+oHqEpzYzaTg8zc8at8T8
 IrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761800479; x=1762405279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EgGm3385DdZTzcRQzcMv5U/pmWTWNpyTByzvWQoNYuw=;
 b=OcL5mFQelORZVhVm0zIxrJ9TuJ2kFWdvkpX7MnAO4UbROyDNgQ8s5GkU3xi+USUoi0
 28XezFvnnOR7p3xzWg4NbjGHckmxhe1715GD+asj1msauwtFkAK1U4P7TmdpzxViKdMf
 g3UPpdqPHXH32Rkw5yzA9ZIsP7W8TsZgVHRLilDGCkYOvKu1qkKv83zn8f+Lvc/797GA
 NN7WPSA4E52uZLn0Ag6GTKgYpLQfR6DKw59MwljMExJhUnS++PZQETBszlW651pRm0l3
 gWGrqvj0nonKb7DzrbOKyHezHp2UVD8vQZOCFa/UCCS/opGslOk9YJeP+17zECCCkBWm
 OkIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr/uz7KwziWvWaxMi91h6qbDFK/Sw48wShjUN/rLRcf5v3561AL2vkIoojFYbTfuGYdCyDiLU=@lists.denx.de
X-Gm-Message-State: AOJu0YxcG+AGmomxh6SwVJGvmCyGQWYThF8dArGDnkw/F28X3vAd0AZF
 94k0H2SNdU8JuL/1hciHuTvAPcf6FtzHJ1i/rCifS9zwKF3Ul3LmAIxURZJtkzv07jfhyck1Qx4
 69PCspHiQEA4I58cFHWDYeq5qVpKQMkg=
X-Gm-Gg: ASbGnctjHiU/gG9xKW2jUJGZIe/hGiUqu8OHbHIMQb8chljRxvlLwHoUjDVsGofsZsm
 E8y0ELtQJzFli68H9fDEifqDlJ3bOKnvBdz1t3W73iPWolQVixai7UQf9MJ/NGAHZjV2zHHJBYH
 0tGzrdloZkNqJstRhlDST8PaI3lkkaunABD/V4VxOcE9AmN7sVgId02sJYEbyBuWNPQId93r9bb
 S+wDQ8mDOX55jHzk7cu1h0Wp16rSPyP2jDyDqvDtWGwFTXPIJ12ImTgswZU0+l4/+F2vQ==
X-Google-Smtp-Source: AGHT+IFW9Aroli9UXvmHq6ToaTFgSkhGR78l9nV7iAfHQDe8Y2UL4tYQryXjEPzRW1zia4cvjJ+8A3MqBpMlyQ+o8ZU=
X-Received: by 2002:a17:907:60cb:b0:b3f:d9e9:baab with SMTP id
 a640c23a62f3a-b703d339722mr615399066b.27.1761800478522; Wed, 29 Oct 2025
 22:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251026010658.19271-1-semen.protsenko@linaro.org>
 <20251026010658.19271-2-semen.protsenko@linaro.org>
In-Reply-To: <20251026010658.19271-2-semen.protsenko@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 30 Oct 2025 10:31:00 +0530
X-Gm-Features: AWmQ_blGFbkjlW2KYPdtct7Qb6ylr7z9-stHNjyIa_AW7CXi41SBfnCpBhHeZwE
Message-ID: <CANAwSgQScETiuKQ=wLsUwFbPgyNw2DP82vrOA7WWgoWMC_0yAg@mail.gmail.com>
Subject: Re: [PATCH 1/6] mmc: exynos_dw_mmc: Extend dm_dwmci_ops without code
 duplication
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Simon Glass <sjg@chromium.org>, 
 Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
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

Hi Sam,

On Sun, 26 Oct 2025 at 06:37, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Instead of extending dm_dwmci_ops by copy-pasting the structure code
> first, copy the actual structure data with memcpy() and then set the
> .execute_tuning field. Now if struct dm_dwmci_ops gets modified in
> future, these changes will be automatically reflected in struct
> exynos_dwmmc_ops, which prevents possible issues in future. It also
> avoids code duplication.
>
> No functional change, but it can prevent possible isssues in future.
>
> Fixes: eda4bd29929c ("mmc: exynos_dw_mmc: add support for MMC HS200 and HS400 modes")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
