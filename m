Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF65DC3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4231582C0C;
	Sun,  6 Apr 2025 17:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BM/KvlT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1535E82AA3; Sun,  6 Apr 2025 17:38:11 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF9082BD6
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-601fcbff303so1768074eaf.3
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 08:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743953887; x=1744558687; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MipgmUjRkndxltTjrz4EbX+l4xZ4UIW7Y0a24IYadQg=;
 b=BM/KvlT86YJLHmpz9bC0+og1JYr3POhjw4lN+SjkktNpNB3TUN2n3yFwfxeEeLmprL
 9kBjVDv17dGeCSOEe05UmiwKh0azgVe9jfD4U8qBrtfnW5XURHJz3r6a4Owp6Uw3UMzI
 IgHQCR+WvmV/eptMaa9Wq4EikbWRGyb5lXziY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743953887; x=1744558687;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MipgmUjRkndxltTjrz4EbX+l4xZ4UIW7Y0a24IYadQg=;
 b=WvfYPTwL2BaWYmGwkcrLGt7HrvbW0JkiGAnRH1+NpiZl64Zlmw79BvIqQPt30zv6Wr
 a/Suu2CvJlUSrmPmXcI6TdxO75PCCqQT8YNMZIrv4+u+gzDws9dyih/ykdijkRdFzna0
 AipoOWt9pXlvX4MkxuBiKbryQyOYZxOda7IVoKrVsmkPPRvCkw9Ox0pBwJSYR37slTcp
 i8E0ScyoOdSzdwwLEDP154rCUel8ZXToOvsbpKQu2Y/X7HRgn/V0EsZIoLVomzH+Fe20
 FD3jt7o/XjzHqj5L1Z+0h9Qe90wWRpR8yPF49w2fIlDhUC4kvFuvVQmtSW3x157ZQ/wb
 4Y0Q==
X-Gm-Message-State: AOJu0YySpttqvtY5JUvIRguVTgK2uCYHO2x/NXO9kn7PPO4HYJH+H86m
 d14pYsYGvOP1eei8i5G1bGc+KWKLYIkIQNhQnwUgGHmQrsMzqz7OGc1/HJlEME54+Eu09hnq/uR
 b
X-Gm-Gg: ASbGnctG+VS4b87qpGWAuIRd3PtOVDsImo5hcJqPH4SwCpdBcWWFfPACRij1BY7tVAV
 3XG87s8qrBCQuO7VXr+4/0mu6SfRu5TkDdbwRZu0a2mnOXvpIurwgbaEgsNglDybSo4v68BWl9G
 WV5hvnjPsojAIaWNc+LQXk4oxnfKbI+K+IVwT60N6Ids9GUKpUo8+kOeWu9sFrcCwGT1o+ADUcq
 rgT5VWKm92M/0y4MW+xRc11yFMUxPZ0iq7J69NUG0gu3kU4pZS92bK1Pd/Jz+V+b/QvD0Zj8uAV
 2rO3bkikI5UwyEWb6LD50g2O/DTg9cxzrFvvG0mv/I6nhr46BgBJwQyMQlkoC3zzeYc1eYF4XDZ
 vjsje
X-Google-Smtp-Source: AGHT+IGCqtEfs5shQ22unok0MPEtPWjnA8e2xezv5n2hyOU5JOxTEkrI8rQkzw3FI73KxLKAQq0J2A==
X-Received: by 2002:a05:6820:1ad6:b0:604:d2b:c585 with SMTP id
 006d021491bc7-604165c24acmr4631547eaf.3.1743953887525; 
 Sun, 06 Apr 2025 08:38:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4cddd6sm1447384eaf.15.2025.04.06.08.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 08:38:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250319185458.270297-1-afd@ti.com>
References: <20250319185458.270297-1-afd@ti.com>
Subject: Re: [PATCH] arm: mach-k3: j721e: Split out J7200 SoC support from
 J721e
Message-Id: <174395388604.154794.2750395089107786398.b4-ty@konsulko.com>
Date: Sun, 06 Apr 2025 09:38:06 -0600
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

On Wed, 19 Mar 2025 13:54:58 -0500, Andrew Davis wrote:

> Currently in j721e_init.c we check which firewalls to remove using
> the board configuration (e.g CONFIG_TARGET_J721E_R5_EVM). We do this
> as J721e and J7200 have different IP and firewalls but use the same
> SoC definition (SOC_K3_J721E) even though they are different SoCs.
> 
> The idea was they would be similar enough that they both could use
> the same SoC config to help with common code sharing. Board checks
> would then be used differentiate.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: mach-k3: j721e: Split out J7200 SoC support from J721e
      commit: 03e3fdd3d09e5e586f7e1420f30510ea2d614f7a
-- 
Tom


