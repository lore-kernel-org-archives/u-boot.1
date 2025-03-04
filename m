Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FEDC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 04:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BA1E8141D;
	Tue,  4 Mar 2025 05:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XynLuefx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7272181417; Tue,  4 Mar 2025 05:41:59 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55FB5812BF
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 05:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6f47ed1f40dso39905127b3.1
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 20:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741063316; x=1741668116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oT3vR9WvC00m//KxRsjlAfBdQl31J/SJVqK9wOluzII=;
 b=XynLuefxcWmO6k5lE1BTRvtw0VJxFtnSEKK1vPvnwg9BKRC8pOYEGRBLwZMwMWkccj
 UDNnvUj9J8FBPMkPUKy5EWZjxv6DT1RWdL5V7YLPBYOFm43bbQXHnwuzNfg1QSNxl1Pz
 2lsqVvgMDFdd9+no5Keqtkw1q4cEEL6RCMwZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741063316; x=1741668116;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oT3vR9WvC00m//KxRsjlAfBdQl31J/SJVqK9wOluzII=;
 b=neJKPxrXwxoiFgJASbxn3utOb/4DaXUkVu81J6chulZ2zFejFxqofWounRH5rPlfmm
 2BaGXuOb2rEzAZGhUQnQQKKDfWy0nt4xyCEZoyLAICJF7MZumqn81hSa6VJgAsx8fS1a
 UyrdcH9Ep9fDUsiq5C8xxS4wXswzm6gu4rimQt/rEgEZcbXA6jFB3SG58YfmOxBtCP7e
 kx6AKdSJMOzbWAiHcof81cA2AKt+FbBHQrmyJ1Irq+ifs1Mi3AnoLXdid/grWCvZvo9f
 0Vk27pJ5lj5KxD27hZzt+MDwinySDJS0o0Jm2Abru6v7K5kj8L8TH54hhH2Ouq1EMJS6
 Tnrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMG546nzOotiMSBAUOAPMWyakWxPPTjWX5jRGqunTcpFcW7WRez0huBz2zr3jQuSFYRej1ACw=@lists.denx.de
X-Gm-Message-State: AOJu0YyEbKCj6uDxp3TwNi/LE9nU6cHGB2GWGBmquB7CBrsrknyG40OQ
 sPeqnM6MfhOpGrwuZb71Z4HveRcH3Q2mK96yRIet0UQ0lOHTPmie4aN74aDxxWg=
X-Gm-Gg: ASbGncvQr4Udr1Oy7lYNkgLGMUSbG5yneLa7/Je5qygxIWRZS2B2XMUd4MelN9KBt/d
 nlQ/wpR3gLrBOIGfmyaXAqbfLr7x0TYsWwVAp+SsrLxzTqgTYik6Z9Sb29qa22oXAzh0bicTSjz
 bI7hQMjVoLLhDDLOR43PWig5DP/BlqHYiYeZcOR0MKG8vk5LZyD21q2qXBnPLja49IkzFw7qCD9
 PKhzh0KW+ZKcv3BK7A0zpBakJnGK6uZ8hNM/hRMbGLjZhfMy57JncRlOkmqH0xC2bnWvWBLKLY8
 L9sYPb8uALQEAqj/ln23idNYRB4ipLyr8Ly7svsUMg==
X-Google-Smtp-Source: AGHT+IFswDF/yupC4+Nd50DPRfhp3NebYzuv/GHpJiuRkd7Dk2IyzfNk+AXJ9OcZFJvh9RZIWVD51w==
X-Received: by 2002:a05:690c:4b8c:b0:6fd:3f9e:b7d6 with SMTP id
 00721157ae682-6fd4a074751mr220175777b3.19.1741063316299; 
 Mon, 03 Mar 2025 20:41:56 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca60d57sm23182697b3.51.2025.03.03.20.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 20:41:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, bb@ti.com, sjg@chromium.org, Keerthy <j-keerthy@ti.com>
Cc: u-kumar1@ti.com, u-boot@lists.denx.de
In-Reply-To: <20250217105718.3109-1-j-keerthy@ti.com>
References: <20250217105718.3109-1-j-keerthy@ti.com>
Subject: Re: [PATCH 0/2] arm: mach-k3: j722s: Enable ESM to support watchdogs
Message-Id: <174106331427.1753567.16167414749607244411.b4-ty@konsulko.com>
Date: Mon, 03 Mar 2025 22:41:54 -0600
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

On Mon, 17 Feb 2025 16:27:16 +0530, Keerthy wrote:

> The series enables watchdog support on J722S. It adds ESM initialization
> to enable routing the watchdog events to trigger a SOC reset.
> 
> Tested on J722S-EVM.
> 
> Keerthy (2):
>   arm: mach-k3: j722s: Initialize MCU & MAIN Domain ESMs
>   configs: j722s_evm_r5_defconfig: Enable the ESM Configs to support
>     watchdog
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


