Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8252BCF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5694890FD;
	Wed,  9 Oct 2024 03:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V2RMz53O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB41D890C9; Wed,  9 Oct 2024 03:55:47 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46E8B890C9
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71de9e1f431so3750375b3a.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438941; x=1729043741; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U1MwVQUd1fL55Z0iAuZnuX5KOA5pwczGH3sbIIaPSoI=;
 b=V2RMz53OKCUE/Ir3GxeqjLA8YF9u2+rtnpF2UloCCgDdFliSqCD+zxL4XDqB0XYUqO
 3okTyqinkc7hTGcJXBYhEIZT9HsWFlDs7k2esf1O6LfZlBrbRaY8dj/3xqwUVkPrtLpF
 9rH0as9XrGfs8Hx+dsJyQ9BbN8pXC6f0N5qZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438941; x=1729043741;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U1MwVQUd1fL55Z0iAuZnuX5KOA5pwczGH3sbIIaPSoI=;
 b=FU593WezwP47yVP1CEOmRQY2bSJpvL61yKzQ8FNGU20loGak94fmsPrJausYaUbNUl
 ZgAWT78m1sJHO1BscrGrFJpYOWx5GxtanJwf1xPRwb8rmpUUDnPEzI6QlHBwShm9k5p/
 XzaDx2jitjCSJE2rXOLGwHCGT2u9wvBxvuciloQpqbYbLneZHfLjJsH6xknEwDkFur1Q
 ZQxpQo9suKA9CsfeMC6dfyJKJLqrUqb61nwuq3LJvnBX0lyN5TrGquLQVcIs7YdBIZNn
 F5T7iApWrjhCgA5g6J6A40X5UfQjsK/i9mfglU3+/fY/gNBKJR9FeP11OI7rdilQFr6B
 GhLA==
X-Gm-Message-State: AOJu0Yy6rbFQ8W+cu9ORUx8BX1gWTMo3+Ks3jc1IBZG5fK+pwRe3xpPB
 40P4YDzgEV1BLRnfxESMEVzKaLVUyZdQyk9ekyv2tfzbXTlUYJU6mAe6Be9avBiDYj5CPGHaCiN
 pUDolIFQqvtlRrhrgvZb7Ky689fopenFehZcb
X-Google-Smtp-Source: AGHT+IEnsEEpBktUmsHwSKaLSy0KtIXVc2B7fpHcon4egqxh3apRBghQ2vXvjgjKjkdueSjmW1jT1E2sVqDivt6OJQQ=
X-Received: by 2002:a05:6a21:1743:b0:1d8:831:ac7f with SMTP id
 adf61e73a8af0-1d8a3bfd869mr1627547637.12.1728438940809; Tue, 08 Oct 2024
 18:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <1cc1dda87239c68cfa30430f08911b78cf4c69fd.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <1cc1dda87239c68cfa30430f08911b78cf4c69fd.1727968902.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:55:27 -0600
Message-ID: <CAFLszThck=mi1xcMRsPGQ4ANs_qT4Ro7LZ6OPiEnaguXcYAVQg@mail.gmail.com>
Subject: Re: [PATCH v11 04/29] sandbox: add dummy driver ETH_SANDBOX_LWIP
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Philip Oberfichtner <pro@denx.de>, Boon Khai Ng <boon.khai.ng@intel.com>, 
 Robert Marko <robert.marko@sartura.hr>, Jonas Karlman <jonas@kwiboo.se>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Marek Vasut <marex@denx.de>
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

On Thu, 3 Oct 2024 at 09:23, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Introduce ETH_SANDBOX_LWIP which enables a mock driver similar to
> ETH_SANDOX but without the dependencies on the legacy network stack
> (NET) so that it may be enabled when the lwIP stack (NET_LWIP) is
> introduced. The driver does nothing at this stage but its presence
> will allow dm_test_iommu_noiommu [1] to pass.
>
> [1] ./u-boot -T -c "ut dm dm_test_iommu_noiommu"
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  drivers/net/Kconfig        | 11 +++++
>  drivers/net/Makefile       |  1 +
>  drivers/net/sandbox-lwip.c | 85 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+)
>  create mode 100644 drivers/net/sandbox-lwip.c

Reviewed-by: Simon Glass <sjg@chromium.org>

I hope that you can get a few tests in there soon.
