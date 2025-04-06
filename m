Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E09C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 19:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16D4582B7E;
	Sun,  6 Apr 2025 21:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bJehzsba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9558182C0C; Sun,  6 Apr 2025 21:50:58 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8234782BF3
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 21:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2c769da02b0so2424138fac.3
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 12:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743969054; x=1744573854; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRY56dvxzxnxOJJS5m+q1B3/niccFIFKNMAZ9v8d/yE=;
 b=bJehzsbaA/vUgCRAUMq/BBV6FKfx04vzEaIUsSPM/O6F0MgAFgjx0qt4L8CUWQwbRK
 V+pbgcCOQZLgWJeYBBOwVFNsgYRGgY3rBoVh7SPRqEosH82lXFJuoC1xTB2D63HrZg6s
 H4yNOONLZfUhTBYuDLGKtcN6Q3z4s2vnfeHG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743969054; x=1744573854;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRY56dvxzxnxOJJS5m+q1B3/niccFIFKNMAZ9v8d/yE=;
 b=VKy2Zf/yS3trPdvtx5AiEuFn0QCUdNC3OZCEHVjsDLtlK1r8i9ys9hnWxFQRHfjOhD
 Kq6va/GGH1owNvN8E9gqhRqPYEZ51c7zdLbT+m3B9ujZLTmVjk1+MurTrit138ebzrEB
 gbFZ+mNxx1ZrgLjcUuvFDrfFHfiQqKPXOlJcXTAXLiyoVs/9ttT1eic5IdbQUzu5j3zS
 VM0KYzdASzwI/BVVb3GylmwvE2Cugc7reQ9GBOhSLU1chLXFZs5kBqhmbnGypC+rBcI3
 esNGKfWs4EEY1/GXluFv0zhBpIL754+w6S7Xn/o9cG9SkfqpqiI6tdrKvAG2NBMXvGEY
 Fn+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpq81WCqrX9TQ7zqS8/JMuXSKxk3qUq48FE4qCjfHpYfOC6oXgL535U1iiBfXsS50/dR4+rP8=@lists.denx.de
X-Gm-Message-State: AOJu0YykgqD2206UPQS0dN3s/DpiX25ZYVBcwcisJorkl+ULA911aDVO
 GJFIH+Oe6l1O/S5QDY5iESAanOJlBeeeZ116hzOQVmBwRWcM5QJaIN+xdFZVwyU=
X-Gm-Gg: ASbGncuiD3+Tqv8jRNSyibEh/3Sw6QWecn0too9+UKCJCRBtIyBbwi/d7Wd24TvksGy
 JCT50r0qa2tVF71HvsD/AmsAz4yOzPrMrvuXzwY2KsxDZ4Yugv5z0AdVIC7jw8CIgcG+lBl4vZG
 NRRqkSPyn2r2N7Pz1JcHvUfGZdzNgUiCw+KMr1IaLWni/6cAbD5z8up+FlALAtkmn7QPzQvh27m
 FcGYan/94tEROBhUZnlZ36cQaPTUBxDN/Hp2DTGnLMdiRjGDyC+ElMvJJWzjIhSCQAgBmeOvwHU
 P70LgV0X0wzK6IWFiaJlSqQsdlW/jwOAVNN1lMAmg+762RNHParkdFyDzXb/tKpxKCvwd5pX4pq
 uYKV9
X-Google-Smtp-Source: AGHT+IHZ1DATUULvpoo/t2AmCT/zLW1pQU5+qUEYZesTd69v8jjm9FM5pBqmqwtyn2MgORwqDOjqXQ==
X-Received: by 2002:a05:6870:4e07:b0:2c2:d47e:5702 with SMTP id
 586e51a60fabf-2cca188e882mr6017107fac.2.1743969054224; 
 Sun, 06 Apr 2025 12:50:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc845cc500sm1703175fac.18.2025.04.06.12.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 12:50:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Michael Brown <mcb30@ipxe.org>, 
 =?utf-8?q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20250405065812.33027-1-heinrich.schuchardt@canonical.com>
References: <20250405065812.33027-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] efi_loader: stop network in EXIT_BOOT_SERVICES
Message-Id: <174396905288.1127672.6730664769718035062.b4-ty@konsulko.com>
Date: Sun, 06 Apr 2025 13:50:52 -0600
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

On Sat, 05 Apr 2025 08:58:12 +0200, Heinrich Schuchardt wrote:

> It has been reported that memory corruption can occurred because network
> packages where received after EXIT_BOOT_SERVICES. See the thread
> starting at [1].
> 
> We try to remove all drivers when EXIT_BOOT_SERVICES is called. But
> 
> * Some network drivers don't call their own stop method when removed.
> * Some network drivers don't have a remove method.
> * Some devices have CONFIG_DM_DEVICE_REMOVE=n.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] efi_loader: stop network in EXIT_BOOT_SERVICES
      commit: 0efe8ea57fc7a1a6fc5f64fb3cf6bc4a1a4fc219
-- 
Tom


