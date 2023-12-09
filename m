Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD775C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 14:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23B6B8759F;
	Sat,  9 Dec 2023 15:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rgW6GlBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CBC7875A4; Sat,  9 Dec 2023 15:23:25 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45C108757F
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 15:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5d6b9143782so25508787b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 06:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702131801; x=1702736601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHcrVMdJq0sD4JbIeT5FBjhpcCUCEVcGkJCuSRTVYiE=;
 b=rgW6GlBd1LwxhYnHu5xUXcfb2bxdOUH6qiuixHgT/bX//daW/kKAg6JZ+Xx/VY57Q8
 anJw436qSSQQR40nedWehLDx0yQFJa88cam788gJG7lyDs5G7fgluzHaIcXkdX1wBdCL
 d7atLeKPGcMlDj0Oh+phS5HWtMKqRF2NnTcnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702131801; x=1702736601;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lHcrVMdJq0sD4JbIeT5FBjhpcCUCEVcGkJCuSRTVYiE=;
 b=g2ZJU4LT8ELG2rntFqlfamZuarAAiD3CupqHUyqwOoWBAhfbC63S26w9UtuLLTi0Ah
 GWU+VS+9K2DjzNbpqy08m5hAUYa5zt4gQ9cxEs10vCaQhRYxH3QVTJ/KQxKzFRkEvBRc
 EB0Hqu0xDE34Mb70SJeFGlTnkZ2697M2jL9KKwMSc9oybPq0lYy5PwxETYkQ+SC0jGc9
 BnnwM2xSlfec6YZqkjSZIQRZ3QwShSuNJped5GllurER3hZ97zGRqa9b6net04yAJzAX
 g15Xet9wN32KITPuAKW3uKDWchMCSwWxHS9XG+YcW5QCVeUacr5qhNOy1/UzTzLDUkAJ
 Uk5w==
X-Gm-Message-State: AOJu0YwX1ud1lFyObBc/BIWqtz4NzHMeLbhHPULAuCcDplntfxfwH1qM
 COYH4Na1RnnFb2Q4gdjiuKfUNnCnJGLrAJofX+KenA==
X-Google-Smtp-Source: AGHT+IH4SrdK6hldLT4XKvZbg8MYhbAZrp5KabFOL+iJzxQagm1R0K6sUL9B0zE6BRNYFgGLyWcroA==
X-Received: by 2002:a0d:f641:0:b0:5d7:1940:7d6c with SMTP id
 g62-20020a0df641000000b005d719407d6cmr1122762ywf.67.1702131801649; 
 Sat, 09 Dec 2023 06:23:21 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a0dff05000000b005d38b70b3easm1516817ywf.19.2023.12.09.06.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 06:23:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <kettenis@openbsd.org>, Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
In-Reply-To: <20231201-apple_t602x_extend_memmap-v2-1-a3831a0f3105@jannau.net>
References: <20231201-apple_t602x_extend_memmap-v2-1-a3831a0f3105@jannau.net>
Subject: Re: [PATCH v2] arm: apple: t602x: Add missing MMIO regions to memmap
Message-Id: <170213180090.3401106.15464501368527379682.b4-ty@konsulko.com>
Date: Sat, 09 Dec 2023 09:23:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Fri, 01 Dec 2023 08:12:33 +0100, Janne Grunau wrote:

> The memory maps for Apple's M2 Pro/Max/Ultra left MMIO space out which
> was not used by any driver at the time. The display out exposed as
> simple-framebuffer use a power-domain controlled by a device in an
> unmapped region.
> Add a map covering this region as well as another MMIO region in the
> range 0x4'0000'0000 - 0x5'0000'0000. The added regions cover all MMIO
> annotated in Apple's device tree in this range.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


