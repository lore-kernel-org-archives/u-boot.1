Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28996C3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 16:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B783282131;
	Thu,  3 Apr 2025 18:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LgDj6YcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 131258213E; Thu,  3 Apr 2025 18:10:54 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0E282131
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 18:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2c1caacc1f7so590470fac.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743696650; x=1744301450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sN1wGk096sT2a9l1mhJZz/6sb2P40K2zaImfLuPov4g=;
 b=LgDj6YcBBAUMDW1cLd/EppF1PY4ZXb7MdxjZJW9kNiNUY88f1wY6iUIirZz9fM07he
 VGYvCcp89BRGn3yFg4shaFe5jf5FBfCUhQjct+VMaXy1IW4Tc+AqIjMwbLsRHQdgDo7m
 kgEhlXBuNeCXlzguGVhbEl3FdRtAcEbEpOZTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743696650; x=1744301450;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sN1wGk096sT2a9l1mhJZz/6sb2P40K2zaImfLuPov4g=;
 b=R027xTC3dSJkZx8HMCWCVCYt5Gtu8inIFUEP5MM4M5R4TPrPhHziD8UZv/7fUbHMZT
 IsQCr7ke/xiKkgfuR/Lahvxh3lF5ceaAWZ33YaOMqtIHu+yIef+hO7X040X4kAzZV8Ln
 3s98La2PjU9+A4dAzq6dnLpja+ZVJzL1YXz7pNvmIH9TOGOwxq0MmXFnfo/ElGp0hF1+
 lZuti81qhlWe36vqpiFO+06yZTvdKqz/B7YzGmx0Fa17jJf7oGgZ0N3cgmL62fOt3Exb
 JiHvRNJkT7jQNEHRK3OU0WqUmgECulXTlP7pRmp9nt39G028coxiCR523fMeDRaZ7Zoo
 5PJg==
X-Gm-Message-State: AOJu0Yw5mSmvY28EwbjrCyJ1XJ2zKfnv2Vr7RkncI5dERvg9GjA1P7nJ
 Fp+vL9vPE6dwxCwjjQeIUYr9/VZHdpmfP4dHPKwC15OQz9JT9BafIbQ33uezTnpD49RfBiNW7PC
 fTgE=
X-Gm-Gg: ASbGncs9nV+HzkZ8OLLMfbrnIYyzv71XzMvuid3iXysZI2pT1T5IIE3vZHfT9M31f5r
 qNGRX0F6ZUbCw+gO55kUKZGhksiBw4OPpXN8PyyoH37jEgLMrIKdeTj12EOL4+Itls8AS+WXwUC
 Bf2AoFX6XiKk4bFsaHxAF0oQQ2uXuntzQHfvbov/pFSd/uB6fw8GMW5BzaOnPMtGyeGlkxAywix
 WFEa7pAwbSj7aUsnEET+E9wmXGK77luhlYsFeO6kCuLEY4/xLoeqieDrdB5QT3PgANNZ8WjRCoO
 qeDL0IyOwHd8qoL9PIH0AMtmWKOaDe5yXp3kl9fjwgiWqz1t9SUZMInV7I00yMkc+mpA85MjdBk
 i+nP1
X-Google-Smtp-Source: AGHT+IFQwQacxv9FMi7A3QSwJxi2peHugRxsirOiX7KxHj4NopzvmvOA0d2+JCkTauEKquXxU5lBzQ==
X-Received: by 2002:a05:6871:582c:b0:2c2:dfbb:2dbd with SMTP id
 586e51a60fabf-2cc9e507ad9mr4687fac.8.1743696650577; 
 Thu, 03 Apr 2025 09:10:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc845c69d6sm309862fac.13.2025.04.03.09.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 09:10:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: open list <u-boot@lists.denx.de>
In-Reply-To: <fd4216c2-d450-4e47-aad2-b5986c68f157@linaro.org>
References: <fd4216c2-d450-4e47-aad2-b5986c68f157@linaro.org>
Subject: Re: [PULL] u-boot-at91-fixes-2025.04-a
Message-Id: <174369664950.1466036.11170704897062352266.b4-ty@konsulko.com>
Date: Thu, 03 Apr 2025 10:10:49 -0600
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

On Thu, 03 Apr 2025 13:15:18 +0300, Eugen Hristev wrote:

> Please pull tag u-boot-at91-fixes-2025.04-a , a late pull with a single
> fix for the reset command on sama5d27 boards.
> 
> Thanks,
> Eugen
> 
> The following changes since commit c17f03a7e93dfbbe5d32f5738274187065d9493f:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


