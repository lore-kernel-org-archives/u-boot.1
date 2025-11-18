Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8502CF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7349183BD2;
	Wed, 19 Nov 2025 00:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NU5BifLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5136B83CB1; Wed, 19 Nov 2025 00:33:18 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3376A83A94
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3d18422565eso4160998fac.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763508795; x=1764113595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59hCpoCbpwz5NY//U2nGJHp8IE4jhmDm6b8Dyy0x36o=;
 b=NU5BifLWg0TAgDDNKIPJOeyr5Bwd6cDSjOuv7TurQRhogNjZK1SeGhheQNNoAuSSdX
 /hxme5QYS3T2p4OYsDhSK6KaeuLkQ3lNYb9c+UuOAfnzNzyNsMnkZoMr5SCPGbk3HVf7
 X/8Oh1hhuOnjlBfyKGVYMsD9vW49uBgGgehzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763508795; x=1764113595;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=59hCpoCbpwz5NY//U2nGJHp8IE4jhmDm6b8Dyy0x36o=;
 b=mrHJbNcI5WaoZiifo47bdtt0FZo+NJycUT4qgac+uS6iGjKURGRq7JIKpdIYK57EMd
 iGijLTskc0RJqtEZ5cg9I18AJHkSJ2zDVBf0qY6lmYMZ66pjfKt5jtIBR47BlmfgXyT6
 yLLtVMpH3YAslnqU/CY6bEaK3kj80Fl/ctCLT3H54avO1oa3R7YPojE59JWnCGuMJmUz
 aVLmD+cmkrIifLjzcY7PlEd35n59sFIRtonMIgMIQ+VIL0A40ATUZQeMmMwsIeg8WZql
 WYhKsYMQvq7ofPhsdeD9+7rxjbo/jwcC5sXzx7DrPnky5MpxZ/CD6XWXF9RG/vfZbz0e
 K1Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZBL5MspNanG2kGIoOkdXC45ApIv1R2oqpGQ2N/9/be79g+YI/Lu4XmcvylJ10WrM2/1TIWF4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7OD6xbVkxIUeiVC6NVePyZHpNhjUyExnpJEm0MGNkBIyZpag1
 66gsyqgZ/VwIRw59UtK6vqSCL5VPk7bTMkp7dditlPkYs27A6ukon28XjkJqXFKxDx8=
X-Gm-Gg: ASbGnctvb3TKnUuGqnp7i/fz4DE6DKFUxNJJwLxC+bcbvK6c+IvH+JOTU17CuuWMSUX
 cQ0ga0D/aVOwYvjLTOPorYpvEQDprxClrwyAw75SXdLjhNGlbUNCHS60AF+7oKwj/Z5u/RZh0pH
 DU9I4ld6Ec/SmrGJDYFcbxi91jrkrMcdaz65Igo1CHVoIjDA92jXw1UTwmqxn6iMMjtzFqFonkQ
 8QFAdpZxuh0Qo+nF+K8KoK2rV8g3/ftYzZYCwnW+1xl7rVw2LnKG0jGmRrWtrKeV6TjtVynscD8
 dKL8svOCPUQSOC1j/U2+wMokn4GzOMGN3zcCLLtID8voutI2nzA+VLddRZCI5sJkDnn+vJhn6g3
 xxm+BFCzZw6guw15JSgTqhebwFbN7rrbSPyR6I2iOoCFeCuA0kOQfHoIf/hKsGT9Xp2Uf+EPZ9L
 SYEZHjWqPvxOltvYAr9oqGZsjppnuUov+B0IAdgtNyWZhRPylo
X-Google-Smtp-Source: AGHT+IEZlVO7X5tPBlhsSe3X4Mr8hqs2KQYaX6p6JlGJ85YF4o5YP4k2aC0fkHd8FrW56BxMEMu4Iw==
X-Received: by 2002:a05:6870:3d9a:b0:3e0:ffcb:2f84 with SMTP id
 586e51a60fabf-3e869169bfdmr9658046fac.28.1763508795002; 
 Tue, 18 Nov 2025 15:33:15 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e89697fedcsm4075794fac.1.2025.11.18.15.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 15:33:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251111-tee-env-needs-optee-lib-v2-1-272a2c675a77@cherry.de>
References: <20251111-tee-env-needs-optee-lib-v2-1-272a2c675a77@cherry.de>
Subject: Re: [PATCH v2] lib: optee: forbid OP-TEE OS loading without adding
 OP-TEE OS reserved-memory nodes
Message-Id: <176350879415.654721.14753051307495000304.b4-ty@konsulko.com>
Date: Tue, 18 Nov 2025 17:33:14 -0600
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

On Tue, 11 Nov 2025 12:52:34 +0100, Quentin Schulz wrote:

> I've spent time trying to figure out why my board (Rockchip PX30-based)
> suddenly boot loops when running a specific program in Linux userspace
> after working on a U-Boot upgrade. I actually inadvertently had the TEE
> environment variable set for a device which doesn't actually need to run
> any TEE OS (so had OPTEE_LIB disabled).
> 
> It is currently possible to build an image with an OP-TEE OS (via the
> TEE environment variable) without OPTEE_LIB. U-Boot will happily load
> the TEE OS and the next OS (e.g. the Linux kernel).
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] lib: optee: forbid OP-TEE OS loading without adding OP-TEE OS reserved-memory nodes
      commit: 1c13c9bbb54d979737d56544c5dcaec3ef0481d7
-- 
Tom


