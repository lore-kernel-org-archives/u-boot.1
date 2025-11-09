Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAC8CCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 13:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F36483EC0;
	Sun,  9 Nov 2025 14:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aYUwFy9m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C916C83EF2; Sun,  9 Nov 2025 14:51:18 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A751483EA9
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 14:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3e3dac349easo1458680fac.2
 for <u-boot@lists.denx.de>; Sun, 09 Nov 2025 05:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762696275; x=1763301075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bf9ihVqdnDmHR80tptWSf0DUFcE+1twPA6yTJ3A1vjM=;
 b=aYUwFy9mci93pgvPVLQnjL+ikWKcUOIzu0eXbsW7iT7Ku7uNYPBwUo0u0LReXm+NQE
 0E/N0Jcx6CYVbsDAJiUGs5SpfZXNp0v7utBOiYx/JwD42SAsHDRkAm4cLp6rJXv7UZAe
 RuyION92w9W+kjNNas1nuTKITTpOOswopd9l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762696275; x=1763301075;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bf9ihVqdnDmHR80tptWSf0DUFcE+1twPA6yTJ3A1vjM=;
 b=Qy/rIuzHgwft2NViOhJLdiliWO5exDsJ+cu5vp4wZoMnboB5f7bCttyFGPnv7A+pPJ
 xiGYXnD6hU+Rm4IRmoBdNqD/BWdEu1G0pS3ixUczHLUJdJebllKB0YWlNT/cSet1b3rh
 Qf7ObN7RCEJhnQ0ZTF9x3zTaoiYQupYJcHClyO9spODur5VcvBnhjabpjAlj2d0FsKjN
 CPFz+Dcbrx60jbcFbYlRqUH13xgTuJxIRILTGno8yR9sWKaTCg6qHum8LgZW/72OeQok
 7dMYa6uv/wJBoZD6ihT8CncYt1yq5Ke+Nk8Mw8rRScMLUHDpaZPhspWKp34k31inVboh
 orzg==
X-Gm-Message-State: AOJu0YxwzVIvAr5Gx6+wCJ3gVyR0CgNs7G+7+2BElOE8OvRzYsj6yVzY
 w3DpauklcYY1GgobsviYYrt6PPjRiXvjyfAQa0vtmic4hbp9JjE7NugNqtDKHv2fKBg=
X-Gm-Gg: ASbGnctSIWOIm/aWvJd2U6X7jJOusu/egG24aDQFuw5/Gap/q7D7m7vQAN67rrrorLY
 Dnoqqj03+DaCfljaWjoDVYgwpHE+75rhQ1Q/noZI73NawGZ8Mwt/njwCQMyRiFTy1xKjxrP6Hyg
 lr1eREpkqq5JMHRz3nk3e3qo5cArc+/CqRU+80ZPAV2nPjPpqC1P+C2v6MghxoU+uI1lLVihFfD
 uSaItfmaVI4t+H7zHPkntMdYjHTVx2/zB4aYBP0km7VFFiKCsMke6sXi+fv4qy2leLWZzs0Kaec
 fvutbhTM2PBiZZrE0RhOzoAOEXHv17AZJ2XiNJRUYk5DaMrycPxHq+ZUjhSfl6+BAk8b7tPhClb
 ahMIxLiCMn++2uXiIpE3YZWxrPT1ExDvtSSUgwMoCeYYO5qb0km0zYpSXsnh7t9J3nHJbRmutT6
 a8UO9v5QjH62re+diQGfeOnx3hzDNqpddBRx8tkD885MijZP1NkqbfvoPQPog=
X-Google-Smtp-Source: AGHT+IFGbZmunz/tZ16U5G4cL6KU0RMSUaK3UJEy8bSy5LGJME65Sb682FHMAlYrtkgLQg95sBafjw==
X-Received: by 2002:a05:6808:6503:b0:450:4cbc:b20e with SMTP id
 5614622812f47-4504cbcc04amr18824b6e.31.1762696275390; 
 Sun, 09 Nov 2025 05:51:15 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45002752ca9sm4622376b6e.14.2025.11.09.05.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 05:51:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>
In-Reply-To: <20251107232811.480532-1-marek.vasut+renesas@mailbox.org>
References: <20251107232811.480532-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <176269627388.3997959.17208358368956040732.b4-ty@konsulko.com>
Date: Sun, 09 Nov 2025 07:51:13 -0600
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

On Sat, 08 Nov 2025 00:27:20 +0100, Marek Vasut wrote:

> Remaining R-Car Gen5 driver patches, MMC, clock.
> Also a trivial adjustment for mailbox core to
> allow operation without .recv callback.
> 
> The following changes since commit fdf36c2e9ad4f770ee951398a86bd55404d9b7ec:
> 
>   spl: remove redundant prints in boot_from_devices (2025-11-06 17:42:07 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


