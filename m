Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA85C54788
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 13:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D439387D29;
	Thu, 22 Feb 2024 14:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TTdxuXdo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E4E87CAB; Thu, 22 Feb 2024 14:55:20 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7394587D29
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 14:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33d2b354c72so3872258f8f.1
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708610116; x=1709214916; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b6mvdJ4MZVeOtRTtaZtFTIvtN/k/ueCSeXLCghIMVCs=;
 b=TTdxuXdowjDBxOwXbU/BzrjtxiLaoGxIJ6n0tp/r5hyjKt53bSGZnHckELQ0wXRJqi
 0NUWjOJnf72USx9uIBrM01Wwi5btQxZsEy7em/sYSzTdzgGo3Ik8ucmN+g+X6m6Ysip1
 0qB9Q22hDfl3hsHXPHjNw377f0QQ+ocA4CQPOwlsZsPT9Jg5vKMBA6igCQoPDI1ENlxO
 Q+l73inF5gWdn5mXsKGHyDY00qlu6p3J88rHVFOLxkBROVSKpDJtLKtJjhBMt5FwZBp2
 cUM7ugs90hJ0OMWjyXGo4qseMG3Qp5kjCyTWIYfW5POiEr/NJ/G1RQzogBOQcsLXKTQP
 hSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708610116; x=1709214916;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6mvdJ4MZVeOtRTtaZtFTIvtN/k/ueCSeXLCghIMVCs=;
 b=gmJPMThfdVCwd4weI0w7aGipoqJ9yTmSpxR2gjfvqa5Ag8wBAIqSdC6Jrf4xUyNAc5
 1brvNroyVHuEp4vCyjxoLrnuDCajT6gN4Nl3i0FcCp/5P6hQmOiLIK/lKTKFFhnaCLwT
 YztnYbvjVZ3j2e+jGdQvOWBqjzdXkGSmxkJXqy6jfzYHftb8ERQ8v3GmGOQm9KaC0n7j
 71Re7ldEQGnIdTLDSeiVlyfb+Bf/lvaY+A3sGq4YBcKKXr98jWvqUyvATbBTsaf4Xewt
 L1qSacXWo5KSci29R4ryrDgWZCnM9le7Lq3EaIDM6EGt6o1vQIu0Q5FVy9yS6WG2Tt8l
 bf2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYNLrPIhUsvHD8M2Jez1qHKckfrjmwlTg/5TMuWPC7OAHe0+HdiaWMm3bysWHk8kqFS67iy7ywnf6RtQmdk1ZMLcOMbQ==
X-Gm-Message-State: AOJu0Yy0C5QCXaflwvrk8LBFkg5o/r8d1YtaDR6ToEAxmAOZAhuOqv2c
 ROb3O+ZbAEE/puWt03Rtnm7m0j6rqEVFU6+mjkHUQhFY82LvOLUPOv0NxUa/2pc=
X-Google-Smtp-Source: AGHT+IFk0bdv9EkoPZ8OIZ/Yv+jMWQ+Ofm2ii8SmCBNGMWQCdnCaSScpRRKjDQqlJENJ270mek5CQQ==
X-Received: by 2002:a05:6000:1a85:b0:33d:264d:6dfc with SMTP id
 f5-20020a0560001a8500b0033d264d6dfcmr14346238wry.63.1708610116659; 
 Thu, 22 Feb 2024 05:55:16 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 by1-20020a056000098100b0033d873f08d4sm3805706wrb.98.2024.02.22.05.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 05:55:16 -0800 (PST)
Date: Thu, 22 Feb 2024 16:55:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bin Meng <bmeng@tinylab.org>, Sumit Garg <sumit.garg@linaro.org>,
 Fabio Estevam <festevam@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] ARM: Enable CONFIG_64BIT for static analysis
Message-ID: <a5cd6ea2-c573-45e9-bfb5-70010913356b@moroto.mountain>
References: <d156b6f6-429e-4c6c-b863-f8554480d74a@moroto.mountain>
 <20240222131619.GV3040305@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222131619.GV3040305@bill-the-cat>
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

On Thu, Feb 22, 2024 at 08:16:19AM -0500, Tom Rini wrote:
> 
> That we have 'config 64BIT' in arch/{mips,riscv}/Kconfig as well is a
> leftover of thinking this is like the Linux Kernel where there's no
> top-level arch/Kconfig file, can you please move the two existing config
> 64BIT entries to arch/Kconfig and then select it for ARM64? Thanks.

Sure.  Even better.

regards,
dan carpenter
