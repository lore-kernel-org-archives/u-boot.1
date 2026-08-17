Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5300DC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19B2440744;
	Mon, 17 Aug 2026 15:57:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8YM0hynFCNn1; Mon, 17 Aug 2026 15:57:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 431E140661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786982250;
	bh=awNLBxzUNHtwmAt7IAa58XW0rPRFsEsW0/H8W1rrYKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kFcSQ+ZUPsS5867+I5A44Xd079+wvvoXPTDmIKilDjwYIX4FOR8ior1rUt+j/MQaP
	 X/WMRLfXGZSf0wOCESscaQbqKruos19fLWpNQ1F0epHEZjl4i4NKuZqE2Olbt5iqMl
	 JTC6VDvIwWB/n1oxkNwPX1urSpw6LP4n3kQLz9moEkN5XXT/Ut8NBPch3jxQM4sfwa
	 Q3E80tXAJI1zKCt+I2n8Hfqut6g3101mn11pjPeQqYKbo6bNmj8n1ljwMtk6CPdmG1
	 4EZ6u0DGSaFX8XfFzPv9jsRgbtB0T/pM634z6x1MU7sSNi8YSXoH/QWMSAsR62dL9e
	 UjJriUbzkHL6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 431E140661;
	Mon, 17 Aug 2026 15:57:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 91002282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E8CF60792
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:57:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wrKbeNhSUO8M for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:57:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 915AE6072A
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 915AE6072A
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=JFSsh99s
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 915AE6072A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:57:27 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4956869750eso24245585e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786982245; x=1787587045;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=awNLBxzUNHtwmAt7IAa58XW0rPRFsEsW0/H8W1rrYKE=;
 b=JFSsh99sRWhrk0A7R7WZGzjcpf8byr0rUVH7482d6di5QbnaBEH/O2KRtZcjuvCf+0
 yCgY/YVTLN/4GZyO+9bARgHlT+Ayct5wm+guPEumEVEZ5exCKEqcZD9RcEF4Mvm8Hhmv
 DxaJ0n/O80pwsnHouXnXxkLRrmx0borLUxf+Y/c8wyUPV0lhj/Rly+Tp8LKSnTR6OT6N
 gz9+hMKw/AXpxW6TEY9Q6DZhoA1r1AuHYN2vZvR9LwR1i13ZiB+fTys9YtdJSPto5yIs
 cdxczlH2P/W1BhpFOs/yA9aPPDqwYuyPWPgZL1Z2uve8j9d+3/nz5tE698gbvvc6Qdcy
 IfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786982245; x=1787587045;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=awNLBxzUNHtwmAt7IAa58XW0rPRFsEsW0/H8W1rrYKE=;
 b=pSwIXQI0UWkT145oTSpegawt3M/NZCw/c1mimp6HXC0BX24YOomfRTPSsOmQGikhhb
 SnkIvJpp+cZubFcak/MycntPTClVPGe9KDV+RX17d5/VK0ECJDshPUNnls3WY2WvS2FC
 /4v21WT/4Dmt6z1uWPZN3D76PZAlRapUTYMaCVcbtIg4wK7N/duOhxfDTuCyd+XOIKRu
 FIn0Vxm832F7D+xMVqzd0xOm6t2SXayQ5578t3cW8JArIy/p4TFCYa1ng7/kSZywi91b
 shO1dQ/Y+Qt5EoccCtX6vQIMCMQF37kZkcsvhysREOvVGQgHCxD7HnMe6s1gGvvfVhIk
 ULqA==
X-Gm-Message-State: AOJu0YxvGz3XyterxbCRACA843k2hkT2XryUKLK/sZbwHHpFPOmcKzIY
 tOhTZM3jxhlyny5fS5r27lCbhtNiK94sEvy0PCrXD8/cDNhDazLSk1c4BsazCiQ/NjI=
X-Gm-Gg: AR+sD12roWRjJHeqxKLH2Ihp34rYWxTL90fVlj4NNSrRwiS655/l2wO9JmBsaqSl5U/
 0UoBnvMsZCIaSx1GEALHIle67p6rGhWHfep8IM3Z6vJLr4QzL6jVA8yGIxkv78WhHsi4FSFTWtp
 UHMRHZvB8FJZhGgeY+4SpEIgdS4HGuaMIMd9UR82DuwRA1LcM8ntSCuau+qnGWF/LWFC7VHivRk
 nvK1mm9EmV9Jar1XYGZUSASRKfzkZEOgMALGZS6f4JLAqZjg1aMcNEo6nvBL4jAm8qldCnM1F2A
 P/S9mn1ggcKmmgNy9hDHJsfQojk1s8KKF909XNOOt9qxyIUUIwnUfhZsZUWM10KpO2MvlWZfpCW
 plfm1ups/Gjxh4aDDDqi6mCzEUKgmaLA0SMdZnCTaiVOToGLxh+f8Y0/VqJNvyeOsalKJiWPFQc
 8y7OdNxB15XCVvl9xKvY7JnmtDMHFwCZ9fpACWzH4wYLOV5BveJ6GrqvpEbYq4gJ5HhU/rrR0xt
 +fJLr6YQHI=
X-Received: by 2002:a05:600c:3049:b0:499:781e:25fc with SMTP id
 5b1f17b1804b1-4998792e359mr274760355e9.3.1786982245280; 
 Mon, 17 Aug 2026 08:57:25 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:ee4a:c814:cb38:c5b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999619a7c3sm146554855e9.15.2026.08.17.08.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 08:57:24 -0700 (PDT)
Date: Mon, 17 Aug 2026 17:57:19 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v2 1/8] pinctrl: Add compact Nomadik pin controller
Message-ID: <aoMvUB8fs9vkGizN@linaro.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-1-ca9a110bd9c6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-ux500-external-sdcard-v2-1-ca9a110bd9c6@kernel.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Aug 17, 2026 at 11:31:50AM +0200, Linus Walleij wrote:
> Add the minimal pin control support needed to consume default states from
> the upstream DB8500 device trees. Resolve the nine Nomadik GPIO banks
> through nomadik-gpio-chips and apply the mux, direction, value, pull and
> low-EMI settings directly to their registers.
> 
> Only the DB8500 binding and default-state configuration needed by
> U-Boot are supported. There is no GPIO ownership or sleep-state
> handling.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  MAINTAINERS                       |   1 +
>  arch/arm/Kconfig                  |   2 +
>  drivers/pinctrl/Kconfig           |   7 ++
>  drivers/pinctrl/Makefile          |   1 +
>  drivers/pinctrl/pinctrl-nomadik.c | 235 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 246 insertions(+)
> 
> [....]
> diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
> new file mode 100644
> index 000000000000..56ec7edcca48
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-nomadik.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2026 Linus Walleij <linusw@kernel.org> */
> +
> +#include <dm.h>
> +#include <dm/pinctrl.h>
> +#include <vsprintf.h>
> +#include <asm/io.h>
> +
> +#define NMK_GPIO_BANKS		9
> +#define NMK_GPIO_PER_BANK	32
> +
> +#define NMK_INPUT_NOPULL	0
> +#define NMK_INPUT_PULLUP	1
> +#define NMK_INPUT_PULLDOWN	2
> +#define NMK_OUTPUT_LOW		0
> +#define NMK_OUTPUT_HIGH		1

Can we somehow reuse the defines in
dts/upstream/include/dt-bindings/pinctrl/nomadik.h for this?

Looks fine to me otherwise!

Thanks,
Stephan
