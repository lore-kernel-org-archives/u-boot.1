Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE24C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 19:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE1F8882F;
	Tue, 30 Jul 2024 21:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ORAkzV2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 228D7888A5; Tue, 30 Jul 2024 21:44:50 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17CB18887E
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 21:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4f887be28e7so155044e0c.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 12:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722368687; x=1722973487; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ljMhW0YcHd/W2TDaXiS3WQ2+QMmdz4y2dpz1qoM957M=;
 b=ORAkzV2ek2ZvY98a/uxUNvs0d87JJkPDI1fUo4D0G/djC9glDiPj7VavMYiNzb8XKN
 /8jAaunucV+7/a/1yE9HOOpaCdyO7UqKeSHbKRbNMCzUrP8CmEakHypOA3QFJAR0wdY7
 w6bBeQqQ3GzmON/x+3Woylkaf4O5Z4/cjnHDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722368687; x=1722973487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ljMhW0YcHd/W2TDaXiS3WQ2+QMmdz4y2dpz1qoM957M=;
 b=NXKIxE4dUjwPputzgU69Lazqj5RW8E6TGth1RN6HOPU2Oup59Bjq0q4nBHVeajnQot
 vVy/T7D7BRCan785zSr0GWP7iGBN5rCy8t+vlhMd9fpJxbQdUmziLux13kJqaBUGocou
 EQgpW7maD7VL6uFpbtOEXT6f8m+e9hjnpu27yJaLrjta8Eg/HEBVes7gb9tfcGClw0di
 LBgf7XELjxU83DtzGjvNnKEjITXULaI0m25zZKtJYZOaoTtvkmYHvzav10WsoQfJVgKt
 +G15NPbjRThfe9SNUTjdjfCrRQ2gwVl9HVUV4SThHElzuKDs6vQXn/BwnMS1zY1DAX7M
 omgA==
X-Gm-Message-State: AOJu0Yzk1H25mU7/Mk1W+8c0X9IGmVIWo2xlNocm6HXBg8NUE9QmmY1C
 cKusw1VIoJV93GiajK8AT9jFGf7HH71beg7nUPZyFgRA2myjYX1BVAW7VuFkHSmHiy/L+qiPS7P
 i5c38BGY4dWzUU0Qv0vo98aJ0wkvQ8zmS/oDD
X-Google-Smtp-Source: AGHT+IEKf8nOo94cb3YVaZy0H69xSrTdMHbEMvZPOj8ZThx9BIerVYKpdWoiGqinOIZ83+WNXu9WvPAFxbww8lNHztA=
X-Received: by 2002:a05:6122:1d4b:b0:4f5:199b:2a61 with SMTP id
 71dfb90a1353d-4f6e697fb3fmr15190124e0c.9.1722368686940; Tue, 30 Jul 2024
 12:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
 <20240730111132.1097315-2-sughosh.ganu@linaro.org>
In-Reply-To: <20240730111132.1097315-2-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Jul 2024 13:44:36 -0600
Message-ID: <CAFLszTjpjxtJZGsN=WnBQN42yEpfeETviAMVt0_umN_rzkQPKg@mail.gmail.com>
Subject: Re: [PATCH 2/5] efi_memory: use list_count_nodes() to count list
 entries
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 30 Jul 2024 at 05:11, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Use the API function list_count_nodes() to count the number of EFI
> memory map entries.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  lib/efi_loader/efi_memory.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
