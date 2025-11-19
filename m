Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BF7CF2591
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9670A83F1F;
	Wed, 19 Nov 2025 14:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QOAKAjcK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8013D83F2B; Wed, 19 Nov 2025 14:16:33 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9696D83F1F
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b472842981fso836835966b.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763558191; x=1764162991; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tS00YxZZ1SdGT7IB2SyEylLS1tLFnUsuMYGW1t2Gj9s=;
 b=QOAKAjcKSaeD/2M5NRXeU789D325fHHXH8vhZ9ICfDNjcj2/7o0SjGKIoG0bytURXg
 LPl+5CZylMg4AQcRTVyEWifXQgGYlJDZXckLgFHjhQppqSKCY/vkM8tABUcuAjfrzDAQ
 LC2Qzt60IXRfZL944Tmd828ZJEjjd8v5AMvlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763558191; x=1764162991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tS00YxZZ1SdGT7IB2SyEylLS1tLFnUsuMYGW1t2Gj9s=;
 b=RjwrabmgdBjXW5HUk2hnu+abB7F/pYv1U1gXrlLCDjyRaISuG6veUTFAHl8Z2er1KF
 kLn4UTS8i71hDiPZU7MsveqB1hsAUbmBW99MjW4oLMOBZphpS1qRVh3hfSRFUs3njCJa
 1Y6TyHpDzShhT79td09gIpCxsgv5EtDcUBiXMRcsSmK4Od+cGN/jYKzUfKMW6nNanZWw
 9yUX1+RN8dq37Ip17wF/yA2wtiXbsrXQPRkAj9u2NVv4N1MgrLYFBl6Tf3IgfUOTose1
 LZtPiuUu1oAoSFMsmHQSBJp8OHSy8YMLM3wLkqlz+h/u2ONVbLKo62/Kumq6u5vMTOSv
 0pyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg1J88sPtP+N4IYvkbSPypWWNu7M4oP3apkp9aOv022OWj9gvUkRwwGMVEDFEN54zCpSbgy8c=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2eVAHecstqtSE6PJr4Gfz2R/YgB3DZR5+A3Fvg2MdVyULuEWg
 muOZ6TlHO2uf+fojUa2herv9UghK+5H5KhGVmCUUfo6rm973DQfLlZ0bHCsxnMzGImmpf+9Xmci
 hUVZ0E2Yy89K/3Z0OxwID2hzQjXFmOh4tiWckMSEw
X-Gm-Gg: ASbGncuHWTk+z/FtRaN5bIINN4hsxuLOY+0Ij/38BJVEwWa1u6m1Y+pl/bhk3wzEcRu
 5QX40VR6O7ude1JRTsaSx3lkOSFLV2/XYrnfOpi0kJetwj5ddyjDGIXJJmG27e8KYc/aet5eZZN
 Wu9aGqRtsrKacFn/5qm9E3L8Li7nzac/MRhB3m5qvi7XD7eIKz/X1LB0edu5xhi2hwd61caZckW
 W6hCh79XbR/XsRyjYAnhrt7yU2etHHMBafC1EH5TlMPr0iEVHqwZ/Zmoa9x2WsZELErCK7fMSJL
 tCmM
X-Google-Smtp-Source: AGHT+IHUoR8s8IXYw6EeNUv6rCPgx3je9jrxrR++V906pnTUZ1lkkY4bTUq9/DbrFmwIYx5sxQbZl3tl15GqF/BmIt8=
X-Received: by 2002:a17:907:2da7:b0:b76:45bf:ce38 with SMTP id
 a640c23a62f3a-b7645bfefefmr169717766b.19.1763558191032; Wed, 19 Nov 2025
 05:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
 <20251118201733.67297-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251118201733.67297-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 06:16:10 -0700
X-Gm-Features: AWmQ_bn1US9UVxcdt5SutlEzavWOAGzrl-u5_NX9MiR6Xn-5xEh7reXsf1wa_JQ
Message-ID: <CAFLszTjLXEcRfhk-jSmYgbv8+qUpifTdfP8iGh2sHX=BiLDn2w@mail.gmail.com>
Subject: Re: [PATCH 3/4] doc: add include/test/ut.h to HTML documentation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

On Tue, 18 Nov 2025 at 13:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The asserts in ut.h are often used. Provide online documentation.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/api/index.rst |  1 +
>  doc/api/test.rst  | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>  create mode 100644 doc/api/test.rst
>

Reviewed-by: Simon Glass <sjg@chromium.org>
