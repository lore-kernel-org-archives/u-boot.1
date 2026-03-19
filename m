Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714B61090233
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 14:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA30A83E36;
	Thu, 19 Mar 2026 15:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jTP+hot7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA6C783F2E; Thu, 19 Mar 2026 14:52:05 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC45783DC9
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d76a331ebbso390002a34.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773928322; x=1774533122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgm8Cef6KMThkSFmEwutmhspDt4xgNWSL7zwEiMTenc=;
 b=jTP+hot7ofc/YRfsKwzmCL0scvmaevRQ3Vs8q5agbAwS7ykUHOnFCsB6fNUFXbEHYY
 qJpOMhFWGQZiqxwYv8yiJ76CSVtAw7+x/XIGcJp243kKxVyeiAWMIUQ0JCA8xLcFOg08
 RbUD07u3JZNz+7nKSUNt/YvD46fOoLEc9lBpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773928322; x=1774533122;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bgm8Cef6KMThkSFmEwutmhspDt4xgNWSL7zwEiMTenc=;
 b=KCEPZQetaut31f5NjZMwl9+tCIUAe6UHxY0fr8usm1Fy5st7RN5/g0KYVqmodNStIF
 e1WXQ5A1g+ZPAEJ6INOMEBpxnFn5erVNlFuH4QBD4NLyvPCNDl1sY4UUs2cYrn5iKa97
 LlP8/BdMFkei2lIyKRyYDnDwhW/VsnsSRDjVvWtCplm+L2RIhCvYTOlVDnxMFw6ezBs4
 yQbg7cF6p/iOXoalTLkQ5inVaI1s0sYEBRYEfQIe0TtNUtny0PNlpzBoux9KUvcYyfyO
 96P2TMjRGZbfj6z+5muth9vld7FabFeo3Y4M6DCLVr7SkQ9qY1IyQ87acjy75Npx/iHE
 JahA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCsvsOzrQ8EsbkG7foj0/1Gd1FDuBeh9IpaUagOB4dBZg+IbVArzFhWySGF2VmvToC0PpkOOA=@lists.denx.de
X-Gm-Message-State: AOJu0YzkcFDJBqUumyYHwdzgVCoXbZEwGvVDvOlqOFOuxJ+SHPCVMjyl
 MZ5TduhbYKtuecerfAmYe6qj5IAiNqKSFaGRZjNNqGF6fgq9fRS0jgtEPx5JDv4gh8o=
X-Gm-Gg: ATEYQzw2GJzbLOXQ/D0hjBwHoy3ietFd0gdLmsKPOtcM4ctP6OAQNQT2fm0ql1yZg9g
 68QilL1QCmj/ltGRQQ5wh06pZc3qlIMuxP0FKmYcYvM0ZjN6X+ZOXaydzCdDCv8XzmGfX/U+vrx
 6BdSWBDxH1J+JpYqeZl8aHJEkZ14rQEKrxOdVYeNpD8p9QNZVl8B9VVRuIqorrqglSVmrZPsNxT
 qH6ovgSvHVRlU04zm3Bv+fcTBRBfRvt91HPHSwnYJWx/auMM5kvObn+UN7N7vpcxg63xRTtw3N2
 mZ8wnQKCWDmn9J0GbUCStIARnWVKLqAzdxORkJA3sFWUK86UQyUFt9I8yBowViDcgMGnqN6hCuG
 D5clVPkl5R2J5diqUfJSSFcLL0zHzjVCvS6h78tNRWO90pts66QWg2b+hbXKDPQjT+StgHcisLB
 EvSS/Qq1uwYiDDKI1HTNyB27xMjViH7gfhOCDu1H89VItZhEock+kE0sLgMtbFJ7Dc33sRC7bX0
 G0DjNPyz6YkysdgYmlAuEwgTh8/kIT4ZzFXirdpukmCEJQ=
X-Received: by 2002:a05:6830:3144:b0:7d7:433e:49cc with SMTP id
 46e09a7af769-7d7ca74739amr4775278a34.27.1773928322208; 
 Thu, 19 Mar 2026 06:52:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9952114sm4536778a34.3.2026.03.19.06.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:52:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Huan Wang <alison.wang@nxp.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philip Molloy <philip.molloy@analog.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Harsha Vardhan V M <h-vm@ti.com>, briansune <briansune@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>
In-Reply-To: <20251120-legacy-led-removal-v1-0-369d44338358@cherry.de>
References: <20251120-legacy-led-removal-v1-0-369d44338358@cherry.de>
Subject: Re: [PATCH 0/2] led: remove legacy API
Message-Id: <177392831989.1606269.12794108785048510603.b4-ty@konsulko.com>
Date: Thu, 19 Mar 2026 07:51:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Thu, 19 Mar 2026 15:18:37 +0100
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

On Thu, 20 Nov 2025 13:48:04 +0100, Quentin Schulz wrote:

> This migrates the last user of the legacy LED API, IMX233-OLinuXino and
> net/bootp.c, to the modern LED framework.
> 
> I do have concern about being able to use BOOTP in SPL? In which case, I
> should probably add an additional check on CONFIG_IS_ENABLED(LED) in
> addition to IS_ENABLED(CONFIG_LED_BOOT)?
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] led: migrate last legacy LED user (olinuxino+net) to modern LED framework
      commit: 765a126a2f1f5eff82276e9fecbb0745e9fce77b
[2/2] led: remove legacy API
      commit: fcbf81694c9399a71ac100b4de15089c3e09dd8c
-- 
Tom


