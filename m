Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8DAC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 19:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0D3B889BB;
	Mon, 22 Apr 2024 21:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gQNqN72/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2628889AD; Mon, 22 Apr 2024 21:36:15 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34989889BB
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 21:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-78d62c1e82bso368906385a.3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713814570; x=1714419370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=COBQdOQFQRfWZfBN8UbPOmShZRnbfaqY6hpmAEWC/2k=;
 b=gQNqN72/yasCdfGFhHhYBtxWSQcPzHrSj+EH8mmVJNEkYrhbx8VzXEdT/GxlQGbQnX
 GDCzZoiprsjz+I84Sx2ET9E8zQQUN0VoPlhPRGvjzJAuY3aY6DH2VSh3Z7kT2afKOpfR
 yuFz6w9kGhJbpQrvyl06IzAlnkTQFTpuur1N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713814570; x=1714419370;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=COBQdOQFQRfWZfBN8UbPOmShZRnbfaqY6hpmAEWC/2k=;
 b=QIt4PgoD9YZ3CUqdfoYdN7us+4GKiNiaDI4HZtj1gerc82h024ESJqUKJzuZ/TlGIm
 C7/2NJpYqZqQCAMt1KNP6HLufhy0mtpoz/xUVwnzlpaqABdFc1WS2ZX/ABQWuaPkPc7p
 4cUZtEMP8wuQ7QqR4/cdmE/NB52mdBTgU8mcq37MuS7TVYkwrtpthKNJIEAKEBasyaiQ
 xQRtE/AaK0ap6RLpRxMX8mAo/M2Vmgdk+YM0YXBlESQe3KhGjQfuJJnzJ+NOhhjoJlIs
 yB73gTPKgwiuQlPXaiyEtqTCyLaMvuTkyGiMxZG9QE5UKijtFJLHkDAo6qdfLvCfU3Gu
 s79Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE2U+pC9SqDF6vEXt6GYvkza7e6LQAnHIMpZJxf9yYir5tkGqvFTNdca7CaIxedppzzyzBJvPN6f/P4fg93H9LUa4qnw==
X-Gm-Message-State: AOJu0YzJtxIuylFrVivgZrL/ivUJd49rBfhFZkAZoSD8SkxnLMjuNr8Y
 eMvSWV7pURhBY0mtYy2aGpVx8iaUt4l0oz/nDVsDGjHU3zSqGPOs9RjHDOfqYlfEi7/TrA0IliA
 SbtcKjw==
X-Google-Smtp-Source: AGHT+IEAj833KYLhmHczk5YAgfw9XjXZ++0w3k03Ppp/nxFvOp9iZ8T+1OMSlDUlU/KDZi1Tj/BkCw==
X-Received: by 2002:a05:622a:1453:b0:439:d1d0:4d2f with SMTP id
 v19-20020a05622a145300b00439d1d04d2fmr2681689qtx.19.1713814570097; 
 Mon, 22 Apr 2024 12:36:10 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 kk3-20020a05622a2c0300b00436b2135b51sm4492448qtb.64.2024.04.22.12.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 12:36:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <kettenis@openbsd.org>, Janne Grunau <j@jannau.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 asahi@lists.linux.dev, Hector Martin <marcan@marcan.st>, 
 Neal Gompa <neal@gompa.dev>
In-Reply-To: <20240418-apple_config-v2-0-7e5c6b9a9db3@jannau.net>
References: <20240418-apple_config-v2-0-7e5c6b9a9db3@jannau.net>
Subject: Re: [PATCH v2 0/5] configs: apple: Switch to standard boot + small
 adjustments
Message-Id: <171381456897.1909236.16480561457391281443.b4-ty@konsulko.com>
Date: Mon, 22 Apr 2024 13:36:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 18 Apr 2024 21:00:24 +0200, Janne Grunau wrote:

> This series contains a few misc config changes for Apple silicon
> systems:
> - switch from the deprecated distro boot scripts to standard boot
> - allows EFI console resizing based on the video console size
> - enables 16x32 bitmap fonts as Apple devices come with high DPI
>   displays
> - enables 64-bit LBA addressing
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


