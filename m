Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755EBFA1FD4
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 16:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4D1C842E7;
	Wed, 22 Apr 2026 18:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mPpwlY2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF498432A; Wed, 22 Apr 2026 18:28:38 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A0788431C
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 18:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so92774875e9.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776875313; x=1777480113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubqinD/2ACj1c16EbA9jpCKhig8Vombkyn1m3I98TvY=;
 b=mPpwlY2mpOoKEzQlH/VEC1g1Ro6/3jGL5JmML4gBUrRpGhYovtxgfiAPjnsYaVHytW
 gk9yiYSS3fqTq5jj9ccImuRQmohGtdHpNCJoCem5rnOpeUJ/IK4h0iqmFZszuTDej25L
 dys8GDJ33izc3hlH4mCKVT8JFJHP3G1QNPkx4XMgUs7rvZ/vAcdDI5/GEb7eHKkeQAdy
 mjW1k9NJpCmnFPUjbvhjU+/dhViM59DM8MDoblFMfcuDAMU3RYIHvUpGe9HW6sAzsAk3
 RfO5F4HAV4VeYxKwwEu62uNpXElELNhA+z1csZCUaI7aJfLjN/8lpySiLSTzQhiWcZjx
 4T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776875313; x=1777480113;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ubqinD/2ACj1c16EbA9jpCKhig8Vombkyn1m3I98TvY=;
 b=jLOavak2+FOds1RGV6gDLcuxI6y55dinS0CubXEuQ7php+4rV4eNSjogWuPTKofbAw
 Q2i+gaXe7pRmCc0pNu5UIktUMKcKVSiSTEvmcfSDblBbqpq4PD0ymgZTKb6zk8UVp/Sr
 vCqIEYuuhTUnL7BxC8w7PNpyPK/JWNFuKpFcY59+PDrDRneNl5bjrD4qg6x/cQUDmAmo
 NbZnySal/srOJ9jhfSNOtQqIwrd5zHV0Bw1WXyuMGTLYDae3ST++MXgLAPxG81+EZIQE
 xJ6LTuoyjyLbi6u7Bd7u6ZruXKSp+v/cYNyc88NdW5rq09H7zZpSKNfGla63TMSboXkP
 TsjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iXpjcADFzHPB/Gera3939PhjvjJkdqkDwKHy3s9bInjpZhK9d1CQY6BPl7zosB/HXvzva41Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxHjGifQGXKJhfxskhVOxgayeK1pOl7O5jBRpfh80I8PNDjtc+6
 jbhO71Q72fzr7R/rp00MKNa2PDEN24sZTMPoPbXB6qZUytUEyVts2JDI2vlIxEfD6Es=
X-Gm-Gg: AeBDievIoZYst4JZ/ZB/5QPmHM0TEGGwJedeq4+hRgS0/YbIkYoXoVv6q/WbYPEY2uo
 H5w6C/5KMh5xG6PIQtNh8kpRh4L+jEXiR5w0yenlYIIz1FBYtd5foUUQr7samuKyfYzsGgd1gu9
 90b0inB5/A6ox5eO+qQHT0tJOyvtHmpX6vAob1BuDv6NFFZ/5IYI1RiRxJ6nO6T0Ust2KK0UkPu
 37Uheo8LoV2vQ7st3u9UDnAOCJsntwruTcn/8kBZeJRarHofXS5kUN6Z5JFJoA437uDsacUR6rA
 7NmbNLHwnPS1nZMJrRv8b5lwt4kzUxygTS0lU5QHPVSyf1oisdmihdCrnNSCZq24iBzlyw7APVY
 +WG1FAkzpkj0Mon2+9Pblb3QynbnvOaItDg91KYSkpnLBupJEYqCrlcdDdeKKI3IxjOC9Xbf/Lz
 pm0kgFRE6dJOjqRmHrP4pkqrdkB3MlM/xmxVc9expmvZrNbks6PI4CuYs=
X-Received: by 2002:a05:600c:8b38:b0:488:b14f:b8ed with SMTP id
 5b1f17b1804b1-488fb6e815amr345108445e9.0.1776875313425; 
 Wed, 22 Apr 2026 09:28:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7c0eacsm144898075e9.35.2026.04.22.09.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 09:28:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
In-Reply-To: <20260422-u-boot-amlogic-test-v1-1-b5790d3c04e0@linaro.org>
References: <20260422-u-boot-amlogic-test-v1-1-b5790d3c04e0@linaro.org>
Subject: Re: [PATCH] clk: meson: do not fail when setting SD_EMMC_x_CLK0
Message-Id: <177687531266.2025915.11674452554926179447.b4-ty@b4>
Date: Wed, 22 Apr 2026 18:28:32 +0200
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

On Wed, 22 Apr 2026 10:48:58 +0200, Neil Armstrong wrote:
> Since Linux v7.0, the MMC controllers has the following properties:
>   assigned-clocks = <&clkc CLKID_SD_EMMC_x_CLK0>;
>   assigned-clock-rates = <24000000>;
> Which causes mmc controllers to fail in probe.
> 
> Make sure we do not fail until we properly implement rate setup.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] clk: meson: do not fail when setting SD_EMMC_x_CLK0
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/723f14c946cbc8c09c3acf7bb7b7da65a4eeecd0

-- 
Neil

