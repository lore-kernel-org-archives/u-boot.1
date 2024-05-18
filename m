Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB8EC04FFE
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 00:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D287A8852B;
	Sat, 18 May 2024 02:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nXoKC5Oi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EE878858C; Sat, 18 May 2024 02:08:24 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 295168851D
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 02:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-69b6d36b71cso6376346d6.3
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715990901; x=1716595701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAt4MfK7hNPAT42LQdXPzFf0MBnpRFMyT/p9VKW+mc0=;
 b=nXoKC5OiS3+jianfor96kgjeWq8xxjbWC0Sxn7YsBg8h7IuJi/wpQTdEJ4NzPgJNHP
 FSBHXcJvk3WdkoxA+4tX09JoD1eRKUGL9S3F9XlLGQKjVgG2+flXsMU5oN+QB94ilWJ0
 oXOyRka2VfZCl2d8jlV7YoxLhtohivHMDuO24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715990901; x=1716595701;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAt4MfK7hNPAT42LQdXPzFf0MBnpRFMyT/p9VKW+mc0=;
 b=SnkW8fn+hSajek2PJD+FiZQ+DXIpzDjgstBfol9yqCwEVa5IJqtbCwqSPTzspl3QPI
 8qAwL6WNDKjGkrWB1L24arfolWAvA3vOOAY/zhshZxDnn6iTEUokW9a3oD1reJ0pfHCY
 E6KZgB6zo9Az2Uce+Ycl1EN2k2C0JkDQG+YqLOfr17ebzZe6bUhRdFFKlieI10NlYIOT
 3W9gODu3XavyGhChuGx59HlqwxGjitXOZ3IXhPObQpNMkMpkkVCz5GqoNMtg1E/qrR//
 xq0ZWPbRiscPXeHRB5g70GjgCtN/qDZy5+4PYK4NiNnBqL7J8L8hJ8eD+QkpOCEfaZl5
 xldQ==
X-Gm-Message-State: AOJu0Yw9/rUfQFiLkQ4XcCDSfIlrLucMOzrD1RbVDbVlpei7rj6noOpe
 8ho00capzZud612CSONXn+igsipwm0W1R6fMzDNBuKHJY5G1rrr0VjSNc+SsZXIlrILZa37K3t+
 /H1U=
X-Google-Smtp-Source: AGHT+IHtvj6wkxgY6PSdouOnszoMu8+7Ch03doHXC1vlCsiQdwMW+WO3Tm2bfpopJnbyfbjWgqiXNw==
X-Received: by 2002:a05:6214:5d86:b0:6a0:991b:cea1 with SMTP id
 6a1803df08f44-6a168152174mr266009096d6.5.1715990900813; 
 Fri, 17 May 2024 17:08:20 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a872aca0ddsm756746d6.29.2024.05.17.17.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 17:08:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Quanyang Wang <quanyang.wang@windriver.com>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240510193554.884344-1-jonas@kwiboo.se>
References: <20240510193554.884344-1-jonas@kwiboo.se>
Subject: Re: [PATCH] pinctrl: Fix pinctrl_gpio_get_pinctrl_and_offset()
Message-Id: <171599089991.1049746.9165269947276553002.b4-ty@konsulko.com>
Date: Fri, 17 May 2024 18:08:19 -0600
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

On Fri, 10 May 2024 19:35:51 +0000, Jonas Karlman wrote:

> Linux kernel Documentation/devicetree/bindings/gpio/gpio.txt define the
> format of the gpio-ranges prop as:
> 
>   The format is: <[pin controller phandle], [GPIO controller offset],
>                   [pin controller offset], [number of pins]>;
> 
>   Example:
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


