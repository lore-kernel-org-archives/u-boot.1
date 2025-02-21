Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6001DC021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7292B80FFC;
	Fri, 21 Feb 2025 18:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fKUlJtjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 382C1807C4; Fri, 21 Feb 2025 18:38:26 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED8FD80F70
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22185cddbffso55910295ad.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740159502; x=1740764302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpke0nA0oQzoqX8hu+qLYHAsOT6rx3U2B6/HNpN03ik=;
 b=fKUlJtjjOX8sMMga2onBY7YC8qAxMZBb5Av7yhuQY8igG12RS61cTV6aacimtUDGUL
 4kHdmFEXFiC5ewt1akvzghS0/YTvPEI4Ekkwly82Ym2LydQeUQwK1WNmiXja8d11MPjd
 msxMrQloEBjdztUIrSJv3Z0aH5uNhPBZ/MGFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740159502; x=1740764302;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cpke0nA0oQzoqX8hu+qLYHAsOT6rx3U2B6/HNpN03ik=;
 b=ARPBR+WbTUN27UuAVMWAIaT7e0P/6NBe2qDDqV3/4TD1yzGVA8FbxEdZ6G0VUX+oE/
 mvWZVll33gWROxLHgVDZLjtFsGUWUNFYvkIFHwfWXfAqTvwmtrUhvO/P3tOjCzj0IGfh
 LzjKBBiyvoRQUF2yPf60cKwPRW/WytHHy+j1Jlgpg4lal1bNDVFoLMWXE/bEDbNo1mlf
 DGrxub3Cu2KEWPydMAwi055OfUzKaYKYRbj6hhwfgr7HQ4uo4l3ZL3Emx+CqL9PtUJeq
 IP/7o8rsGGs10hO4zN1Lj5jjP5L0lJklcFQlxw5y5fdLLme9LJOOTfBdN13uSacGaXKq
 UzYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt5/cT819cUOyeqWm9jFnKYb0ODaa+/Pec2/c3NBHdTGC5y6i4u72dK1jHkFxNir/kfX8ixm0=@lists.denx.de
X-Gm-Message-State: AOJu0YytRsDKhy0o9JnfPsC/pQjB6B6KymCafoKuuWrok0OBlkw1H/Sv
 Bw7OwC1DXXLlULvBNeLJFT/hJrXxBIKiddU4Pk2NyRf2MwfuoDuB7YAEuLqVPDM=
X-Gm-Gg: ASbGncuA8I530Dfwfu0zpZ60L5RMfphWb+QdNvR7cGAyLs4QhzuIRPWC/igvBXplwne
 Vti814fiKghLBHHis1DEANE0xN2DKKcmGCYo4PYPaKk4LigTztWKxEqgym7Vb+6O3ggV8Jyt7E7
 svZVBD6d/3mMN3g8hYO8muRNBkEB7AqjBD44x24mdJwBiifZO75GBmR6A2Gv8ijp6JGAmrSINL5
 bbWyp2cjKiHUA1VhVzXXk9CK/p8K/nreevTPJRv/Ukr+qnnxH4AlskGOMl3J63kiUe53pcVILJ5
 YJ80inOjXVzLtOS9DR6AO7M=
X-Google-Smtp-Source: AGHT+IGFhPVlBmV1zOnj9ketNskjFbq1bb/cmIBK3TDfP7ZSNXO39eK6fsd4R6Vc/HW4lCJJhD1CRA==
X-Received: by 2002:a05:6a21:3a93:b0:1ed:a5f2:dba6 with SMTP id
 adf61e73a8af0-1eef3d9e04emr6802084637.14.1740159502579; 
 Fri, 21 Feb 2025 09:38:22 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adec4756d0csm8792554a12.55.2025.02.21.09.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:38:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: hnagalla@ti.com, m-chawdhry@ti.com, bmeng.cn@gmail.com, 
 sjg@chromium.org, u-kumar1@ti.com, afd@ti.com, u-boot@lists.denx.de
In-Reply-To: <20250213092322.1484706-1-b-padhi@ti.com>
References: <20250213092322.1484706-1-b-padhi@ti.com>
Subject: Re: [PATCH] remoteproc: k3-dsp: Flush D cache after loading firmware
Message-Id: <174015950129.3526942.12666797058865347350.b4-ty@konsulko.com>
Date: Fri, 21 Feb 2025 11:38:21 -0600
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

On Thu, 13 Feb 2025 14:53:22 +0530, Beleswar Padhi wrote:

> Memory region used by remote cores was set to non-cached region but
> commit 7c9c6e192580 ("arm: mach-k3: Merge initial memory maps") makes
> all memory region as cached, unified across K3 devices.
> 
> This causes inconsistency while booting remote cores on devices, due to
> cache incoherency between remote core and boot code.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


