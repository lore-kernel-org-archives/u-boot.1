Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027C1CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 12:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CA0D8842E;
	Thu,  4 Apr 2024 14:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lnvxbka4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA7FE88436; Thu,  4 Apr 2024 14:01:48 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B7BD88411
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 14:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4162c210c33so778625e9.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 05:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712232105; x=1712836905;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VRvetmlTkD5Xrcb+LYXKHctwSL6mt2pppwoZwGmj+3Y=;
 b=lnvxbka4HZZpqtaf1D2lzqNmNx2NyvlWLA7jJIUtYQk68jtIsYf5/Pedw9cWVPGr6U
 i0LQdFT+K61eGNiy/5cg8QhBWaaemj6iahjvWgpcz9rQ+JOAn5PpTvZId1dCqgYBHKin
 52z2DGB4G/eeFoStty3mdJiRvAC/c34DyY7PHMlTiNDZxex2hPuwltC2VeryRuIYB4vN
 RPFp2X//uNzJowXwjfpUpsEUjxb1z8B8t1JgAE2PS+C2rKQKn1z/sZQKmIWEQg+9vCfR
 XqCJ9Jw+dtVoxCDmG9Ulj31I/qjIe2T+OTQQ1gBxfkqsaj55YGGlhcY886lAkJmRcTK/
 ta3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712232105; x=1712836905;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VRvetmlTkD5Xrcb+LYXKHctwSL6mt2pppwoZwGmj+3Y=;
 b=KxCXTFt8AJMKhc3F/j491GT7eoWdXUmCclX/Xd3mcmLQNjhGIgbMBffCFD41N1iDUh
 y2CthALrcXxwwzFWBOzXrUM+ja55s4pvvsCUqSK3lTnJ4p4vFEtHpqQOUhruurOxuLIp
 BPRWHClY/2OdQB3ia0nlXC2LKgVpOeK4SxmvF0uqk1X9jOK8ymTj0M5DDt+DGR4WNxT0
 Kq9ljjJUaCCKKF7TdCHBR7ypgJdwev2P41pd8cg3R44ZQddY1ClicqKUG61n8hKIlP1e
 YdRD4DHzUcCSILxYhphIs2lMA0OhxJoo4CG5/gdrscJJPrHNYHoDPqs7Xu+JoEjzlThE
 +ixg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4CYn7Hyfve7ZTLXIKP2U8IK5T427wQQwfOpLDDCSSDD22QfEwEIe+WcnU82mrHIttbF712v+PCdW34/2cmFmTOedA5A==
X-Gm-Message-State: AOJu0YzRt5LkYE9TXpX9wD/Rqmq46RVRk6o/x09wzRioDcxJ6yCH3wgk
 6wtYHOcKyFjHe0rR8I9tL+9BJtpwVLo5Jk5UOAyYfwpCXmM/0Teg1o6+9+m819wNq5h0QpIn0Th
 1
X-Google-Smtp-Source: AGHT+IEwfKp8QyGCe2CgyNyTNBXGqc2+GPxdPa13qWvHq/l3gutYE5r8fwnL1HmqHAHfCUH6vtq1tQ==
X-Received: by 2002:a05:600c:4206:b0:415:52f8:ca74 with SMTP id
 x6-20020a05600c420600b0041552f8ca74mr1847128wmh.36.1712232104654; 
 Thu, 04 Apr 2024 05:01:44 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 o7-20020a05600c4fc700b0041567ce9f10sm2530150wmq.0.2024.04.04.05.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:01:43 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de,
 jens.wiklander@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Manorit Chawdhry <m-chawdhry@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] MAINTAINERS: add entries for tee-related orphaned files
In-Reply-To: <20240404105248.3241506-1-igor.opaniuk@gmail.com>
References: <20240404105248.3241506-1-igor.opaniuk@gmail.com>
Date: Thu, 04 Apr 2024 14:01:41 +0200
Message-ID: <87y19t49qy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Igor,

Thank you for the patch.

On jeu., avril 04, 2024 at 12:52, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> Add orphaned TEE/OP-TEE-related files to TEE subsystem entry in
> MAINTAINERS. This includes:
> - optee_rpmb cmd and test for it
> - Misc. OP-TEE tests
> - OP-TEE SCMI agent implementation
> - Documentation, including device tree bindings
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0462ade4ac6..0f7325d6045 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1642,9 +1642,18 @@ M:	Jens Wiklander <jens.wiklander@linaro.org>
>  M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  T:	git https://source.denx.de/u-boot/custodians/u-boot-tpm.git
>  S:	Maintained
> +F:	cmd/optee*
> +F:	doc/README.tee
> +F:	doc/device-tree-bindings/firmware/linaro,optee-tz.txt
> +F:	drivers/firmware/scmi/optee_agent.c
>  F:	drivers/tee/
> +F:	include/sandboxtee.h
>  F:	include/tee.h
>  F:	include/tee/
> +F:	include/test/optee.h
> +F:	test/dm/tee.c
> +F:	test/optee/
> +F:	test/py/tests/test_optee_rpmb.py
>  
>  TEE-lib
>  M:	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> -- 
> 2.34.1
