Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F55D10F58
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 15:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA1683FD6;
	Wed, 26 Nov 2025 16:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SQ9Bq7eo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6A5884239; Wed, 26 Nov 2025 16:38:04 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81E9883ABA
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 16:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-450b3f60c31so2320491b6e.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 07:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764171476; x=1764776276; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+VS77j6ltespC8HLeY0FqG90VXc88JtKvZ2OmNsBIg=;
 b=SQ9Bq7eo6YqqO1tVUQDoPtLNU7xFNBSW3XyY5PsKqkDQ8BGvpxybjICH7N8NITuJ5J
 Q35nHnWhC2pNQamBqgFs131ExxFDg91RgNQhae1qsHkNQkz1iP1cf8OxIgLMrWrzR2Dx
 YbFOxG/WGkPy9ksJ7pcq9wQonYqikzxPLlImY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764171476; x=1764776276;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+VS77j6ltespC8HLeY0FqG90VXc88JtKvZ2OmNsBIg=;
 b=WkOp/ldNub6zPK5dWc+9+qRFVy3p0tCf8yq4Z6os7J3Tff4ATGzkeAk+4dZjphqsOn
 hSQlsigb3ArYhabmlXFGkhF2hP2L8fPLO4vXCvJHR8n1MQIe/r+v/62FrhC2IB61ji+j
 zJ5LMyS2EL/y/cl2+F+jbTvr/tPM6wWUSsX/hCn7NPm5Q0b0KM4XxPi8IclyDOOAHhHU
 9ti7hl3ZxjP8HrGcRGqybJsgXt7nop17V0LI2To5k4lfRyEKX6kCytujomyKpPT63Fyw
 QoJ0jTXdvaH7RKUjHKt5hD4apa5r+eunmXETkJ/bwoOLRsZWx3zY7MVw0NY/yghJtk6P
 0+Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU38zetzOk20/QahuETtjBJM8OFbsmrcdm5WWMvWnp5JMnT1iHsOjJPkZtBE21iePauBnirNtk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxdm2UdQacPlT+I/rCNaG7K9ee5ayvyLDm0P5OEGCQ0/aoWTdWK
 fK0DyC+AA/iibWnTQTdA36zSx6clgIw0HrPq/F56s/9bZ9D2SpP1iZs97FCBG1QvUuDUuHZj1v1
 v+rcxz3Q=
X-Gm-Gg: ASbGncuLswPtWFVImcXtALfhIbab542vrsXj17zcc7HYgxV3ox0LLMEJXzdY59pUvHe
 pMLmcGjl0QgkVbM6qr6y65FuLV7WnQGXESA7hIfcmmgXr/bWRlmAWrGxX/80lGyjt7bP3/Zkc+3
 KQNFZbyPs9iMfBUWwoasWOZLu9u1revCUpKrizXI9yOB4sxJ8H8jLynO4xzHhWmV6pUGiQWMG3I
 VLquP4wh5+n9xaPGhWb6X6hfXy8VkMo+4Fts2pPcsBeKtPsTOsI5LybtbAXJYhCn60nAu4Kzs5q
 7xH9TJFHaVmqz201TXWeV1V8i6xp83NBnJKZbIVN2tBbkMdVsV54t4slEFFL5Hna/z3zNd0ALrV
 PacOSXB2LlcErdQh6/+m33CU55Yk8DqAYky8XUmWsaaZSjkqHGqof/hZDbDRvv5xHGma7oUKFoQ
 7k30090Q8Cl9IPZkr7FJqSqzvAa4hREN5rab7RCwoqCq3a7t1uXEwNZl0sUXA=
X-Google-Smtp-Source: AGHT+IH+oARMkQTsWJzksdcuQ4G5FnQO7iJ3RzCG3wVYbbVoqmMtzBrSE+Qlzptrcn4d7WnaEfV0Qw==
X-Received: by 2002:a05:6808:8953:b0:450:d568:a50 with SMTP id
 5614622812f47-4514e834249mr3228612b6e.56.1764171476199; 
 Wed, 26 Nov 2025 07:37:56 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffe32decsm5477749b6e.5.2025.11.26.07.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 07:37:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
In-Reply-To: <20251116014531.2133243-1-jonas@kwiboo.se>
References: <20251116014531.2133243-1-jonas@kwiboo.se>
Subject: Re: [PATCH] rockchip: rk3588: Map SCMI shared memory area as
 non-cacheable
Message-Id: <176417147524.3758873.12546592711160822442.b4-ty@konsulko.com>
Date: Wed, 26 Nov 2025 09:37:55 -0600
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

On Sun, 16 Nov 2025 01:45:29 +0000, Jonas Karlman wrote:

> The SCMI shared memory area is no longer automatically marked as
> non-cacheable after the commit a5a0134570c8 ("firmware: scmi: Drop
> mmu_set_region_dcache_behaviour() misuse").
> 
> This change in behavior cause Rockchip RK3588 boards to fail boot with:
> 
>   SoC:   RK3588
>   DRAM:  8 GiB
>   scmi-over-smccc scmi: Channel unexpectedly busy
>   scmi_base_drv scmi-base.0: getting protocol version failed
>   scmi-over-smccc scmi: failed to probe base protocol
>   initcall_run_r(): initcall initr_dm() failed
>   ### ERROR ### Please RESET the board ###
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] rockchip: rk3588: Map SCMI shared memory area as non-cacheable
      commit: e8c10f9d2446d66f56fc3621752c995dd6e99192
-- 
Tom


