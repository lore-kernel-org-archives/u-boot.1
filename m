Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971D2D3B7C2
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 23:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9ABD887FA;
	Mon, 25 Nov 2024 00:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l4ViImFN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8003C88B0B; Mon, 25 Nov 2024 00:54:35 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 568198877E
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4668983b04eso7976541cf.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 15:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732492472; x=1733097272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzI4qkeY+pdV3kQN6kpjQAXX6W5Ys297UHRHoeaeJV8=;
 b=l4ViImFNxhcYMHU50S9Q9XHeddWSh1g7kVkZHcLcXBbF2TSTYXhsHjiykHQaLD9RRN
 w2yGpLgTFfj4mDm+oGvoYnDRuAnOCRNRiRH8xyfRPZ8CTeNQ+0ywtRoP4QAiwLfdWfhL
 4eovl1mzAMVlzuSRkYnQ9Zml2hu+6O3/WSpog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732492472; x=1733097272;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzI4qkeY+pdV3kQN6kpjQAXX6W5Ys297UHRHoeaeJV8=;
 b=H1X9YR+DaKQZBr1pyr5LQCmbAJfxNzw6GJ9bdiZ4Vhyhxw5s0f/qHsUlkIjkxE/XtT
 Csr8vXMZ9p+816rsoKDYo/u2frjln1xJ3gBAyzuHvXx6yHLONkwNugF8gRHZsmDlCER1
 o7QLHr5+6tmbT6EstLuz/KWkerVGWVf4xHOCEBHg2Ks5OPoTOdPlHG/734g/563WHK0E
 X1XpUEyaaSs2Ekp844N8KGM2IEG6P8B4SN1hj/kkIFrv4WNP1MALJQ63lC6q1x8rrksG
 AJEsEKWBODeFSUSHfARTpZe8jAvvGzhcwH9iQ8BaF4CSzKCasRigTM0CtTjN7ulYvG8n
 fveg==
X-Gm-Message-State: AOJu0YyMVSmFNeI4LC8nzbt9Kuwg0Zr9xoMtjH1WjaCaJQNoJXOvOfMZ
 Lbh8acxJ+CQqd4WH/TYv22KWrL/pkVLwZidDi6cQf1fGnCC8hYrXNPfkaWYLGTw=
X-Gm-Gg: ASbGnctylmqIg/VpHlrZPEFZY5KmshuGLUAYa9fRZG7sBXMYT53nra1zzWdOexTSaER
 GSiQJ20qrzgZrAf9fZoJWm4UXuK1fpIIWuJw/IM9Comynpzw2r0dpyj9suq1HtbSmH4CC7zuV9h
 wxzKwtmturmWEoHWcCpKvK5PP+HsLuYfHQrK2FrbsBnuTrtwXxfdmyQU60rDpWU2W3VxT8aOT77
 0BsnR38iOObqbywj6VcCQE3Uny4xS2l6bKk4qd5+uSqKPIG
X-Google-Smtp-Source: AGHT+IHGsLX6mxpibIeztavPADxSfwopyyHKaehlN+PAEWp3sqz2s0m/PD3ovfTw7+UyBeJLHKP4oA==
X-Received: by 2002:a05:622a:1915:b0:461:3834:b632 with SMTP id
 d75a77b69052e-4653d535afbmr155839651cf.1.1732492472229; 
 Sun, 24 Nov 2024 15:54:32 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c3d9c14sm39505091cf.15.2024.11.24.15.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 15:54:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <kettenis@openbsd.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241123-iommu_apple_dart_ordering-v2-0-cc2ade6dde97@jannau.net>
References: <20241123-iommu_apple_dart_ordering-v2-0-cc2ade6dde97@jannau.net>
Subject: Re: [PATCH v2 0/2] Fix device removal order for Apple dart iommu
Message-Id: <173249246979.3866893.9999724495145524536.b4-ty@konsulko.com>
Date: Sun, 24 Nov 2024 17:54:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 23 Nov 2024 22:44:03 +0100, Janne Grunau wrote:

> Starting with v2024.10 dev_iommu_dma_unmap calls during device removal
> trigger a NULL pointer dereference in the Apple dart iommu driver. The
> iommu device is removed before its user. The sparsely used DM_FLAG_VITAL
> flag is intended to describe this dependency. Add it to the driver.
> 
> Adding this flag is unfortunately not enough since the boot routines
> except the arm one simply remove all drivers. Add and use a new function
> which calls
>     dm_remove_devioce_flags(DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
>     dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
> to ensure this order dependency is head consistently.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


