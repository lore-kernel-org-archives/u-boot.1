Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EA1D16816
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A83418432F;
	Fri,  9 Jan 2026 12:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WHUNqCyY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80EF384333; Fri,  9 Jan 2026 12:35:30 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 176528432F
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-64ba9a00b5aso5981248a12.2
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958522; x=1768563322; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c0P8gq/y5pWX0OORA1DCwa2PUaiYt9BbPewlawzGg6k=;
 b=WHUNqCyY7m+HB/QrDyez6ALvodA/5SQIvKC1XiaDmRwV3goLVPsoTolopd8v056Ga4
 YJ6lXZb52ik4qRBHtzMcHNjCMcKrwDxU+xLDRCBlQsbkC6+vRGXao2A8qB8GZIuP2RBi
 0p7KxVFQpxKBYsCI9ohElM2T6AnGikpkUNASE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958522; x=1768563322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0P8gq/y5pWX0OORA1DCwa2PUaiYt9BbPewlawzGg6k=;
 b=T6lJr4L/xD/HeYxXhk4I4sEpX5DOeRok8NbQBx5MiNOsKT3MkEJIvB5Yh9ROnZLPPJ
 b/P73lod36q2E/EKZFNpneKZgNWPQ1m89yXzFlTZPJ9qGBx0qRFT/dwEfSOtwkPFNErd
 ZJDlDDh5O3a5+NBCkr0bEUde4vm0GEdlD8aD4XSidzWNP8dyU26LLMBWDQy1vPzuQCnT
 qdZQadVCf+dOOC2kj+5JUFyDN6ZPR4kzDuO0EAhC+adFNA3HBp8mvlkGf4FJVe+2i54y
 nO0aa4aiOW0K3kdQFVjyH9xEe4OvaXz03ORuZU8OAto2gucaaHmXiQq++1+1W1siaGot
 0Duw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/gf5pR4EgZXrT6+Gp0iKJap8APfbYzBDFYm7IcGKiexmA/DWHG5n0AEKQnUrHer/TT0QOh6U=@lists.denx.de
X-Gm-Message-State: AOJu0YzO3oP5r7apcOPu287dohNzOcyP96nFQXyvX/0DrfoUme/t5gAe
 EepRh/6C/qSTtQFfAPVspYW0hKZ4+kWx1Rm44HYn/EPdbWRVK3iz/SBpYCu++MEDGdKUjWGDq/G
 5fEMAIBedV7h51eehaviAfmLhX+ASs5Y/TIJjj1It
X-Gm-Gg: AY/fxX668mhrKOuv8ID3wQPpuWfdS/Kwe/hggHN+JqL2a4zRLYIb0Ohw9N8RJ9TCj3a
 UTCztSYJQstW9GnwfoyvV+D73Glm2JHrtYoGv77zynucEvA8PzxYsQ6UWef2/W+DHSN1dY2GR8+
 BfTsF117fTBXR5Ae/0TthR0gcM7H4q5q8yIQN0cF1I61XiWCVLjVKgecqd/AL1WtmnY1t1hD4gm
 5xLsmfGisqJVrhpVUH3/Yxy6iFlRk9hw2xF4yyWy8FDIqVXgVMVZpeX1NhQ2I6g0K/L1A==
X-Google-Smtp-Source: AGHT+IFrDtsfnDawp09sdB5Pe/yJqZxaZgYwa1x71cgzNgs3YU/+7RYDEFt8z3XbU+wE3IspgrRPDyhuAIsNwhaCGwY=
X-Received: by 2002:a17:907:9455:b0:b72:58b6:b263 with SMTP id
 a640c23a62f3a-b844516a6f8mr892476766b.60.1767958522485; Fri, 09 Jan 2026
 03:35:22 -0800 (PST)
MIME-Version: 1.0
References: <20251203-fit-compat-v2-0-0fea56f23809@cherry.de>
 <20251203-fit-compat-v2-3-0fea56f23809@cherry.de>
In-Reply-To: <20251203-fit-compat-v2-3-0fea56f23809@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:34:51 -0700
X-Gm-Features: AZwV_QgQkU8OAWpZrX9zxLH8c4yoxb6CykRqMx7PLYu8lmy4eTmkSR5KdngTzeI
Message-ID: <CAFLszTjEWwT3y6PggTF+t6+1tcz24yhQJoVt7rTsZGnO6dwL0A@mail.gmail.com>
Subject: Re: [PATCH next v2 3/4] boot/fit: declare (and use) new constant for
 conf's compatible prop
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 3 Dec 2025 at 09:19, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Fit conf node may have a compatible property[1] which stores the root
> compatible of the first blob in the fdt property of the node. This can
> be used to automatically select the proper conf node based on the
> compatible from the running U-Boot (matching the former's compatible
> with the latter)[2].
>
> This adds (and uses) this constant for FIT node parsing.
>
> Note that this property may also appear in fpga image nodes[3] but that
> isn't done in this commit.
>
> [1] https://fitspec.osfw.foundation/#optional-properties compatible paragraph
> [2] https://fitspec.osfw.foundation/#select-a-configuration-to-boot
> [3] https://fitspec.osfw.foundation/#images-node 2.3.2 Conditionally mandatory property
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  boot/image-fit.c | 2 +-
>  include/image.h  | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>
