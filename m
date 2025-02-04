Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D14C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 19:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC06980819;
	Tue,  4 Feb 2025 20:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c9/njxKx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E048580805; Tue,  4 Feb 2025 20:43:26 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C093880040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 20:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3eb9a0a2089so3840951b6e.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 11:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738698203; x=1739303003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5tiNq79/BybDoAcqQ9BPWSlZHwR8yMrjGn9r8iZQnQ=;
 b=c9/njxKxGygiGuShoMii0ZQ1qfGYpEaXfOl6LApSrS1DTX4xSv+ja58Vutn06HbE40
 LzQFfKuGtSJSbwY36fDH0QRmuJ+CuZ96YOaTO1tx8MTzElxPzP6O19595ICKf7SbgOex
 zxYMvz3CMzUrwNj35NtvmOR4HLJcemsYtD/QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738698203; x=1739303003;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5tiNq79/BybDoAcqQ9BPWSlZHwR8yMrjGn9r8iZQnQ=;
 b=WNyA5f6lE4nH3/Yg/nj+f82bBtlSIBMQeSt1FpzDVO26kHLEmVv5w0FNCCphYKvFSp
 xJt/Jrp2tpR8LdUg4cqS22+LPX0VkNbmA1yHErPdBNnP/hDGfACuORt3Jfl3cmJCI4Z0
 x5c4eNhchHQ0d8rCE0xS2JpsBmoGjRVxJSGV95ac9vVE9rLrAyWe5UZiByK7a2+gddw3
 JJuvBThB77E9e72kGjXVAZAaCgbvzepRkiTy6iecNB5wgtHhgxmMdoGgEuwfp7SCcb0B
 wHDtF2vKe4qciDuazEK1ByKDGi1IkjmLJUggPF0CRLBHZ1w5bHQwNrb1Dqk5FFya8Y4X
 eMwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoXs6PTz4RJicMz6ohGyTNBmprG222wLdhSz7FXygxeCjiv0juHwh9BOKRsUj2+qCklO3h2uI=@lists.denx.de
X-Gm-Message-State: AOJu0YyY01ofab2SERLWNEPmBonBgUvjcAQvJR+CMmx15uoDK3e+T7SO
 qe5iisxcF3nO59LgEV/MxOpJk6suxh961LCb3CUwlNMhjqmwNTdqDxm+afCde3g=
X-Gm-Gg: ASbGncvJtRKbT9YbvjuIrXVyS0HuAuXodftMDeIvivezJTEVPK7txK+pWOoLMPW/wmp
 P28SyUwqgnkMOBmKuYb1VIqrbe4ESnjh6El/zdw9SuUmOET3jt+k2llRZhFRGtgvBUyfo+xAKtB
 qAiYB51t5rJMTi4RfLvGbNqOopHNtBstTmtXIy9YmvUgYtoPpFb6eM5DIw8NYPjYfQw78Q1SNZ+
 YZNbscD2poPq5ICs3a05g6tqFZApUa7hDGWdXBtMrGxhuk168C1zgF8VkUsJJIbNwaaIu+uSTA7
 MbR2zON8ge6Uyg==
X-Google-Smtp-Source: AGHT+IFy1tmB582qy9MXubPOuj1MOoWcV5G9k27iJJXOS/SZRwid7OWTW7yXjh6x2oaYfZVth3t4UQ==
X-Received: by 2002:a05:6808:3c43:b0:3ef:3a96:c530 with SMTP id
 5614622812f47-3f3239ed560mr19637172b6e.1.1738698203636; 
 Tue, 04 Feb 2025 11:43:23 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333690ba9sm3160867b6e.49.2025.02.04.11.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 11:43:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: 1425075683@qq.com
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
In-Reply-To: <tencent_5BE562924C2EF9DCF6F00FBEB0D50437020A@qq.com>
References: <tencent_5BE562924C2EF9DCF6F00FBEB0D50437020A@qq.com>
Subject: Re: [PATCH] API: system info adds FLASH and clk fetches
Message-Id: <173869820248.637016.7965579710987848598.b4-ty@konsulko.com>
Date: Tue, 04 Feb 2025 13:43:22 -0600
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

On Mon, 27 Jan 2025 17:38:11 +0800, 1425075683@qq.com wrote:

> Refer to api/api platform-powerpc.c implementation
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


