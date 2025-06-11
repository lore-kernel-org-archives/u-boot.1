Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FBCC71135
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 22:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDDA482977;
	Thu, 12 Jun 2025 00:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W+rEJkxD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61EB081FEE; Thu, 12 Jun 2025 00:21:24 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C3A82B20
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 00:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7304efb4b3bso228190a34.0
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749680481; x=1750285281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9znhEPmW1GXKOJW9LakwEs1HigH03yivxk/iFl0oQ4=;
 b=W+rEJkxDKVK52IZh/yRzxsqAE79SsfSaNxP+P6+oLdPrVdADVFb8/m41deYzRZ3Zph
 3nbWBAWxv0HWp4hzxu35RLCM/rGDYVqMFrDf0AgPE/7HfTqBABsv51ABUQdLW1ncBs1P
 RsWyolq2skquNubdlsdNMPetnSbm189M8imGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749680481; x=1750285281;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9znhEPmW1GXKOJW9LakwEs1HigH03yivxk/iFl0oQ4=;
 b=EX498FoYXVDEoZgpXOrbTxjrj+VmQwJcf2CvCgbhPCzJYj6bn4B6MLSr7FsqWNc10D
 fDf3qb4DaAmr9UUYjeX/p8sOFmiGYKT8cj3oNyeo6tfu1zAEFzU/gynPqtK81n8/lI4n
 dj1F6pe8vvBBeafMmQEM2gWwIfX6VlAfounSWLlkwhwsAhS5Hk5e2UxFgimD2VScRu8t
 zFPYAyI05ygBVyoLjD6LBx8GeSnSwwp8m79EvP0lBXAxCp8nEnBkLWXQENup8N5TTnFN
 V7d9xsYqp3gsIZHMRMt4SnWa9gsD4ILv9SFLDq/Rk7+P6uZbmbwnhX9Qrk8C1X2q8MjP
 SEHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZQDbkszn0LKhOkrWdUU+BQAAp0PalvRUDK4+vp2vPl2ly/ADPUll9zo5pqj0KcmA0HhcDWBc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3gUy0yZ8hURl3vWbn2Ru4IChbYTnfs/rrQR3S5lt7kzUboFY0
 hVI5up1IHCjhu2FfhCfPgz13KPeAMWhadd4vDRKJkOuSXZAvT1ARTYB2DI9qan//aGQ=
X-Gm-Gg: ASbGncvvEyAFgVv8x06c55u8TCdGEIi4BXOsmaPnIYiOjI0TZsVv62iYFR1jHW1Ws0B
 fdO1JPNnXYashh20ISlHvP9dhO9jmdYCRyw7Uswmkvh6Qv/1lcNb7la88Kxn95khnEHIimFOymo
 gL2OE6dKGgFyr1+vPxV5gZ3mDhEMvQ2dDriOFUDZ4p5kJjodvnNx4wV8iMW+NBGWzxhCFItpBT2
 AXKSc4cB0bAkd2njOy9SuRmiPVs4fGIxaKKENaWiUll2iuugce9QPqLt9YXeKJSWDzQl6uEHcQD
 Y1L4/JDRdjnpbml5AAx0KUWWnHi2V7gbliDAKIugREvMvLVuztmVYMqFou8Lkc/Rv3mZXblrdpS
 5zs2lpMSirATNWBQtgZggYK9+43SH7f2g
X-Google-Smtp-Source: AGHT+IGJOotUL40UsM3Fm9oyI8h3qPFpbWFWEdIUwsywEH9QuCv3ow5KmydooaWYNf0vkfxqsKJBQg==
X-Received: by 2002:a05:6830:498d:b0:731:cb3d:67db with SMTP id
 46e09a7af769-73a05d85d13mr3886962a34.16.1749680481008; 
 Wed, 11 Jun 2025 15:21:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a16a57ec5sm55294a34.18.2025.06.11.15.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 15:21:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250528-dev_read_x32_default-v1-0-6ab1734dd7a2@cherry.de>
References: <20250528-dev_read_x32_default-v1-0-6ab1734dd7a2@cherry.de>
Subject: Re: [PATCH 0/2] dm: core: use {s,u}32 instead of int for
 dev_read_{s,u}32_default
Message-Id: <174968048012.7268.16537271096862477625.b4-ty@konsulko.com>
Date: Wed, 11 Jun 2025 16:21:20 -0600
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

On Wed, 28 May 2025 15:06:17 +0200, Quentin Schulz wrote:

> Out of all the dev_read_*_default functions, only two do not properly
> use the type as argument and return type: dev_read_u32_default and
> dev_read_s32_default. They both use int instead of u32/s32.
> 
> Considering that it's generally not guaranteed that an int is 4 bytes
> but also for consistency sake, let's have them use the expected type.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] dm: core: use u32 instead of int for dev_read_u32_default
      commit: b4b66e2f298e10d53749ce8d3ca086acbfc62f6a
[2/2] dm: core: use s32 instead of int for dev_read_s32_default
      commit: ad03050e26b1a61b3fe10a645a36da11652355e7
-- 
Tom


