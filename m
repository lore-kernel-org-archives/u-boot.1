Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1429ACCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 16:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24AA483655;
	Tue,  4 Nov 2025 17:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EvL36lW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0313B808AF; Tue,  4 Nov 2025 17:39:53 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFCE88389A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 17:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-656b1f906f8so462026eaf.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 08:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762274389; x=1762879189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WyVg/qh/sHDEvpxgGPJGgbILH3xBU8r078tW5vCBo+U=;
 b=EvL36lW/K1f0IEruMVeuzqa1QZxUksp61t3/F5qWuaOoFVWSOCUkjq0HW0oc7gB+O6
 VihLucsiki4TMb13XwySMIP52stACY6wDgz6x+CBU9Rl5umyqTMH5uKZGvpKD5SgFZ45
 9FfvCbK0OvuetL/m0lvTds7WYTE55N+fQ3F+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762274389; x=1762879189;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WyVg/qh/sHDEvpxgGPJGgbILH3xBU8r078tW5vCBo+U=;
 b=wFUf2HtM4A0NUHcNumTFp5kQjY5cP0Hc2/VN1ep0WQRDeMZ5x/sTqxJ/Bezqr9yXb0
 dxavotwAwxaQRW/UKlVT/3JczETQdkgCIlBBB4yoRGmgl22VrpGNLGaEezJswjLaIXsg
 rCVdrdMiItMtTByYKDI92r++vKCkN386/5+sQipARA8geK2w5X2wZZVJh6Gie8Dhsali
 yo1276GXbBUNy+v4vBejJ29UD1e1gulikMTPCO+1wOeNtY5Hut+9zs8rsGjKIfpTFLNC
 aVs8uUSb+kL5iAsXxcvoXy8srIWANvDEanqz8hlYgn/0BZlMXu112MqcV1d4etaF65fo
 URXA==
X-Gm-Message-State: AOJu0YwSlgno1ygcdXOFV1mASFWiEevqCexjk1Op72OqDQJosBJRBmOs
 7ovcqq39t2jm0J9hb1D02yU74vTmA2sUpt0faD0l0MsXP6KJs7fo2MKyEq6Sjd8yv3c=
X-Gm-Gg: ASbGncu6eziMGB4jmCodFuvz57gWv645qqgWJSIag4w93vxY3z2Q1RqC5xR3HF5EY9l
 Sfxd66nAaZcuoxlfl32LsgVgBo/lSa/g5zFjfUStD8J0XcFGS17CC4uzat3eQBSHQgYs2hzSVRT
 8JNBR/cmzs1pH/kjeerdoNnYhRXwwAFwY8CYr2IRnhPPggdvH3Ytm2GFHKo6/YtSGcJ2s9OWDAF
 63nr7yqIr4UtCPpEIZfWqqS1tMQFuDxWNpRmVXeZsNh1roMwbllf7R7YuXEC09Jii9Z0AIp0Tl5
 gr7FpkDKTSwVtp+bNPbhkJtnvLVy/LI55bGeZng5FbximGt77IsY4jQw+XGvZyYRe8hs/sAv5TA
 OC7QSzMdn84qy5zTHHvw1fkDSHWw2L3+Iby3f77YaXlmABu84iDi9OK9ImSwSz+3Opk4+5JztFY
 mGTkHKRnaIFQVq4W+RlYE9JGkRk6IjDiOzFgwcaA==
X-Google-Smtp-Source: AGHT+IFrom6/CJURana+qrdV+aKr2MF3wUE65vK8fBMl0cp5o3BV74+7TPjLFsG3e/FV9n3HWrkt8g==
X-Received: by 2002:a05:6820:220e:b0:638:3df8:c802 with SMTP id
 006d021491bc7-6568a6f185fmr7117563eaf.5.1762274389682; 
 Tue, 04 Nov 2025 08:39:49 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656ad43a2b4sm936601eaf.18.2025.11.04.08.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:39:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Dhruva Gole <d-gole@ti.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <20251031-k3_fix_mmu-v1-1-3f3cb6f8b3dd@ti.com>
References: <20251031-k3_fix_mmu-v1-1-3f3cb6f8b3dd@ti.com>
Subject: Re: [PATCH] arm: armv8: mmu: fix mem_map_from_dram_banks
Message-Id: <176227438767.3616625.7163628753160715296.b4-ty@konsulko.com>
Date: Tue, 04 Nov 2025 10:39:47 -0600
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

On Fri, 31 Oct 2025 21:47:31 +0530, Anshul Dalal wrote:

> mem_map_from_dram_banks calls fdtdec_setup_memory_banksize to setup the
> dram banks though that is expected to be done by dram_init_banksize as
> part of board_r sequence.
> 
> This has the side effect of modifying gd->bd->bi_dram as well, therefore
> this patch removes the call and updates spl_enable_cache for K3 to call
> dram_init_banksize.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: armv8: mmu: fix mem_map_from_dram_banks
      commit: 45b7857d3b5b4cb12a5cc0a121bc8ac4b57427fa
-- 
Tom


