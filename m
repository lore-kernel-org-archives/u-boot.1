Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F333C27C75
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 20:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA8588855;
	Wed, 12 Jun 2024 22:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k3TuooXN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C5228884B; Wed, 12 Jun 2024 22:24:37 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F66885A4
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 22:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b064841f81so1774036d6.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718223874; x=1718828674; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CkA4F487TPVQgn6by5/R9oPsR6ifkZ6uNxoBQOmV9KU=;
 b=k3TuooXNmhloXJBpDh3OUbPUaUDibmUY4ynOqox/AN7BN5j7L9f25ZRV3G4ns6OJ4g
 sTBPSSvLMM2tdnxm7AXNIOHfZzwKxN1Po+ql6+xDAlqWaGrVrcjtPH6amRIzdhkrH/KB
 yELv0+DY8XbV2uTN27Ca2adPaxUOOJ9Ss0Vk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718223874; x=1718828674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CkA4F487TPVQgn6by5/R9oPsR6ifkZ6uNxoBQOmV9KU=;
 b=b11uFnrb81rKWWjtR00ncZweeSLYjwZPkysukF8EWfLncxbgcHes2fCS9gAx51yHfv
 fnMIXdkxBowV8OABjH93RvShrD0Vpt3Dhkzs/fohq2w5MFReFZv7MFv3VCt/XYMeSMT9
 4MTCk5xUfrgxtphFcwGMgsDh3fH1VM1tWkop6ieMtFfdeMWrRx9o8N/KkhTBezevHLnw
 Te3vG9eQBdJMgOMwrs6DNgJyM/ucI+ccPNp8M2RQi2X+qNQbL/fUqrgPXf2pAdsRCRKm
 zjtreZo7hbds8m+hqCxn8KtNZ+7S1iwqnGwv/8RFaGNO5ZW/RYRMwhLwVlwJy0lCht8T
 kpEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuntq7n+YSQLMZR9eS+5y5rpK17cZvfyuHOPcjuQGKQpNtd7KzXn+qlp9ZK0pJtMkp5NIo/nhs/2ry/YBjIDxpVN3yZA==
X-Gm-Message-State: AOJu0YxtjbRJw4J6hGRfyh8JH1HvVBR7GnZ+NNPQRKiDifCMdOrfMbvi
 wT5A5AeInHOIcdQ0LCiCF/OsnDG3dkd+hlYy0hHVDlaLD0faZJwnEo6mj41LO6vVmUtGH9jd2FP
 61DXH+eM9EeMlY5FpLCufXkvo6eeIznVnCgdU+6zDH/dP3Qw/xQ==
X-Google-Smtp-Source: AGHT+IFHqK/AikyYRJb9lMcrIlgs/AwTW/BV/UdECRAQEZD4hBsPPea2EE8wWZlTfJw2Qy18bghLgFQ5Rc8VwPGjJTQ=
X-Received: by 2002:a05:6214:3904:b0:6b0:8410:6857 with SMTP id
 6a1803df08f44-6b190cec4bfmr23313766d6.9.1718223873701; Wed, 12 Jun 2024
 13:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
 <20240612-bootflow-efi-crash-v1-2-27b71b0ff08a@cherry.de>
In-Reply-To: <20240612-bootflow-efi-crash-v1-2-27b71b0ff08a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Jun 2024 14:24:21 -0600
Message-ID: <CAFLszTgk3MDyesHxVvY-zPgu+7g6Ty4V_h_KKB4_Mq2qweG16w@mail.gmail.com>
Subject: Re: [PATCH 2/4] boot: fix typos in help text of Kconfig configs
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
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

On Wed, 12 Jun 2024 at 08:58, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This fixes a handful of typos in various help texts in Kconfig configs.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  boot/Kconfig | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
