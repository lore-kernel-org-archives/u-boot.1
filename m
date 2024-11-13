Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AD5D637A0
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 17:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B0E89269;
	Wed, 13 Nov 2024 18:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hsrXXtzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0F788FFC; Wed, 13 Nov 2024 18:40:43 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21457891DB
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 18:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3e5f835c024so4398616b6e.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731519640; x=1732124440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtiMEishsqi1DZC5e3cuysiV3F4i3uTvZx5QVGkLlg4=;
 b=hsrXXtzPIRPTAnVT1rS6B1HWsV0Lk5y3xkhKZ0Tdi3Waarm3TwZoWOfKjvO6Pk3+Lk
 3B1+qhi4KAMyOxIEY/HfDfeMKxReoxIx268DLjvmyPVaUN2whkoEouj6NP6Rdc0F7R/i
 e0Ez1SabooEL8S+EEvTQL1ayDSSLMWqXgmKAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731519640; x=1732124440;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtiMEishsqi1DZC5e3cuysiV3F4i3uTvZx5QVGkLlg4=;
 b=QAIEfKPeXX4ljBfinvI9mfBbvqrvhXChYgVg3YNGuSKR6EqrSonjPE/6Ji+KDa7g/A
 WA0ZicbTw3dF70EZGzaJrV2wtGBG5i3/TimBBbhlxTfr2WXrVOjGKJYRnVizS4aw1k40
 rNdJ+Ge6umICRXDR70nk6ZGsBvbzTd1s4LJ9ORlLSvsE1831NSk3ZISHMn4DwRLJkM4o
 CARNEUoqxt/X/5toqyxi6ZFgNnJjbtRaAOPylH9YS3BYGV0SIBnuAryw7OwQolkQcU4+
 VDt5G3T6VDJPzShSt8MG5G6bRYvXEzJ/felgb6vPzl8dW2PsGFxeaknLBxOUcTtx/aRO
 Xjhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJI9iJsv2iPJIPmFP2a+Oi1btlhaWD7SfVEioKp0c6TL75ZY26SA39SScNrdfthX4d2t418GA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/AOIWSjhm3rw0xi6S02CSgLW/abvOl4ocqclqLBSz9Mcibw3U
 z9mqDr29/1Z8mHmEvzppmyyIg5qV8og0203qN+3ejSBOZ3zkIe3lVNtgiYSIijY=
X-Google-Smtp-Source: AGHT+IFi/pIxYpUk0lt0YfJgxq/NdI1jkCWBBGoN5Fyjk/e/+psUhj+U5uZK0uvs8zZXjsoQwBMExQ==
X-Received: by 2002:a05:6808:399b:b0:3e3:ee40:204d with SMTP id
 5614622812f47-3e7946ab7bemr20725351b6e.14.1731519639928; 
 Wed, 13 Nov 2024 09:40:39 -0800 (PST)
Received: from [127.0.1.1] ([145.14.135.248]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e7b096bdabsm736295b6e.21.2024.11.13.09.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:40:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20241103035015.29486-1-heinrich.schuchardt@canonical.com>
References: <20241103035015.29486-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] lib: vsprintf: fix API build
Message-Id: <173151963849.1299521.12930587944020717095.b4-ty@konsulko.com>
Date: Wed, 13 Nov 2024 11:40:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sun, 03 Nov 2024 04:50:15 +0100, Heinrich Schuchardt wrote:

> Avoid a build failure when building with CONFIG_API=y, CONFIG_EXAMPLES=y:
> 
>     lib/vsprintf.c:312:14: warning:
>     ‘device_path_string’ defined but not used [-Wunused-function]
>      312 | static char *device_path_string(char *buf, char *end, void *dp, int field_width,
>          |              ^~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


