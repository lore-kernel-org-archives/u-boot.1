Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84760C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB168847B;
	Mon, 26 Aug 2024 12:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ty1tqUGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8455F889FC; Mon, 26 Aug 2024 12:32:06 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52AA08847B
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2021c03c13aso30144895ad.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 03:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724668323; x=1725273123; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v75RwO0MAhKDNsghRgnt7vpixKnJFczT0kQ7pIspyds=;
 b=ty1tqUGt3MsOyVgri5f4iXeTIl31zP7FzYT7j5C3miTgVISq6GJuUTwS7/uiOTixQc
 Y4ACPvIs5XHMFJw/7wWSgCGUkklMukTZ1x7ecXCwy3YPEySGpSS/cyVssuIpaPlZn37J
 r7AsUOqEGvEaMXU94mky3ij4rjRbUPigpIdrsGa/l+N76IaBrsTfbRCFf1UhTV7fXg6S
 CKH+HM3DlbGXd4S8UXkDuladAOIxQL+wjc//l//CxO5hAihxL9mXdDqgh1QBLC5S+PPO
 AlL4kjbfCL0dcE/abqjx38kBwas9QjusSROu7wLvBc0Bzzrw/Sb2UuRowaU1xEUHqXYO
 FlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724668323; x=1725273123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v75RwO0MAhKDNsghRgnt7vpixKnJFczT0kQ7pIspyds=;
 b=bOzXyvt8AVyaM/tfOnW1JFzJt8m4usj3CoW9UrF20UCT8vsraZKyUNIN4TSBhfNW24
 bHRVWY9CUeXwHdYhuW4vpMzqt758uwsVg46tW16kGrOGogOYmN2U/KHL6AeVTuZTNuvK
 xAm6iunp0sXtGthmm2Ut58oyFCTQ8v9dNtGBpwU/g4tfGXj9lQvmbgLjguuXWa/f0JGr
 5BYlmQLi2UVZPcl3lf4KyVQal4UgLA6ZBVzPH271iRspwh/0Q7yaK7pYo3bnuDPn2vHk
 Zwj2BSHXCcgvsrnjFECOj+2ENNEDUhYv4kVHzOma2HNsKmV7UNxD0DfCGcfk2qSiYkYV
 AZ9Q==
X-Gm-Message-State: AOJu0Yzj+TZ0aGb4pRgV/GavHoy2fRA+JXvHPQZg7ZcoNZSzfqZhWvxb
 xAhswunnIJwl85lzMXGo5ChN5TstLqckU1Qo9AFmbb74v2A8YHCo7Wah9JJh5GmSldq5+4b945p
 llJ8jhsh0NE8xxCrijsX1kYYMlh8kSBs1UYjvKQ==
X-Google-Smtp-Source: AGHT+IFGzJ57LjESElF51gamoOzkrDAvli/FRZiRCP36qaheNN6RTKDMKFkfRwVAVO5VFO5Mc/zzzwN7ZCLXChLq+kw=
X-Received: by 2002:a17:902:d2ca:b0:202:2f0:3b83 with SMTP id
 d9443c01a7336-2037ee2ce5emr239599265ad.13.1724668322471; Mon, 26 Aug 2024
 03:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-6-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-6-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 13:31:26 +0300
Message-ID: <CAC_iWjKJha0dcOADp8DrhUN-JZv7aAFbxyaAX-9UL_iaM=jB_A@mail.gmail.com>
Subject: Re: [PATCH v2 05/32] lmb: use the BIT macro for lmb flags
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Wed, 14 Aug 2024 at 14:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Use the BIT macro for assigning values to the LMB flags instead of
> assigning random values to them.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  include/lmb.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index 7b87181b9e..a1de18c3cb 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -5,6 +5,7 @@
>
>  #include <asm/types.h>
>  #include <asm/u-boot.h>
> +#include <linux/bitops.h>
>
>  /*
>   * Logical memory blocks.
> @@ -18,8 +19,8 @@
>   * @LMB_NOMAP: don't add to mmu configuration
>   */
>  enum lmb_flags {
> -       LMB_NONE                = 0x0,
> -       LMB_NOMAP               = 0x4,
> +       LMB_NONE                = BIT(0),
> +       LMB_NOMAP               = BIT(1),
>  };
>
>  /**
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
