Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B454FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C204184486;
	Sat, 25 Apr 2026 20:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N5ESmQsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 250588448C; Sat, 25 Apr 2026 20:33:16 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A0E384445
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-8b038a00370so75766306d6.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777141993; x=1777746793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C9WmJSEhO9A0FULwe9kZLf8tw1TNrXZotWxHHJges60=;
 b=N5ESmQszwMyoF50uytK6MfWlHbp8DJx4O0OPrjpCqAqc23BYBIDQIpm0tkMRbcppsI
 bjwoaE6rKBP4YVHR+YP5R/r3dLDa3fP0OdyDhBNL8tfGYFDKLoTueAkDeNxszLvI/eqp
 QPVT7LD3fdaK1VMUvUoZzplqRsLpE42j+mCow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777141993; x=1777746793;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C9WmJSEhO9A0FULwe9kZLf8tw1TNrXZotWxHHJges60=;
 b=npSyvCUS4Fp8N2TeKRnEJJk9zHea07E1x1kAv8hekpB9kzpAKC33Kxnd8Lv1wn8Rox
 wNccb6WfUNRZMigbMg0tU0OVVUfZN1DvxonYkHA3ruKnZLhdEIGO1/70LRU020e/X7YR
 GC/A8NeMDZZwGjfDX7oLLV1QV+CKVpMtckoB0T68SBDzn6z+84Vrts0ZhlfjhhsF8HIx
 b5yhpwdYmxYbr0d9HEDVDuanke0D9l8+1XP4KTFZ7gXS4ObuwG6vrGCSv74G0Kz6lU+j
 +tHbOwWG33PaafBkX4cRvm6O7/I6XpeVbkg7en5P3qynDXGBhQCtFHYmkLEQrRUxv5y+
 0cRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kKiq+tiOqFQOo5TPmWFcvNO9BQhuJruNjWG0vwXht1a83SimWf1qVl5h6Ra1qZM+dqsBVaEI=@lists.denx.de
X-Gm-Message-State: AOJu0YyZQHpX8a+sXivkWFNOFXT2HzYDicDali7F5ywm5RoP8A3qIch/
 RawUg2SbhUQIHXLTEa//IF1y5YKvBWosQfe8MZ3L1clXE5Gv4cVqwgKeGDBqtGjpehEwzne3cqg
 ZMerXwzpm+A==
X-Gm-Gg: AeBDieuIUw5XBk53JY1g7xSm/N5B/v65vGdHp0HrJ5WJYuBLECnbw2DBFP3oKvWZDm8
 9rEm5pAakNsu/c7bXyMoCuJS6Ex7hDYrKbrs4U38LReSl8nBtv89MecOQ6EvwlbwOTqljyfulOY
 7DGaqHaYR0/5pdAWMv9+7IQzYAe2NBhBb4wnLFoeQLVTzC+mRtEoWbYFtaHidVWb5jjc1321KxT
 oZHd+pUAk3nLxoV6MWG8okqBAVdyASaPC0uY1tTSjndmyFj3xcheybCWXGvEnMOZn+nu2xJiEL8
 s0memkktHTfrUpGL1NL/KPZxo9NPoEBqxQ0Jl458crzyPx0iUsWvLPdh+yZSA5zFZrds/GYEThs
 5EOA25ilXRJkKp6cnmJpHV+/MbLiPbl2jwI9zJZj+Wmg6wiNmpyaqyhEjecku23pJWak0IGzxX7
 ErPxiEee+eVYX3FzScF6QX+oIHGkVD0DWyM4mr5VKJ/fHyBtLDiO0Q1t8hNfo3pTPsLavpYJplq
 aZay52txw5k8JSw3kfn/HV84UeWvF0sdD1zgkArgbXeLwu5rjgrCMurQd+W
X-Received: by 2002:a05:6808:80b0:b0:479:dcb1:dcee with SMTP id
 5614622812f47-479dcb1ede4mr7952535b6e.18.1776898139202; 
 Wed, 22 Apr 2026 15:48:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-479f3cf40d1sm3874175b6e.12.2026.04.22.15.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 15:48:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vitor Soares <ivitro@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20260401141844.539308-2-ivitro@gmail.com>
References: <20260401141844.539308-2-ivitro@gmail.com>
Subject: Re: [PATCH v1] configs: aquila-am69: Set ENV_MMC_EMMC_HW_PARTITION
 and ENV_RELOC_GD_ENV_ADDR
Message-Id: <177689813850.1956774.6334118032132278169.b4-ty@konsulko.com>
Date: Wed, 22 Apr 2026 16:48:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 01 Apr 2026 15:18:42 +0100, Vitor Soares wrote:

> Set CONFIG_ENV_MMC_EMMC_HW_PARTITION=1 to store the environment in the
> eMMC first hardware boot partition instead of defaulting to 0 (user
> data area), where the rootfs and data partitions normally reside,
> risking corruption. This keeps the full boot stack self-contained in
> the eMMC hardware boot partition.
> 
> Enable CONFIG_ENV_RELOC_GD_ENV_ADDR so that gd->env_addr is adjusted by
> the relocation offset during U-Boot relocation. Without it, gd->env_addr
> keeps pointing to the pre-relocation address of the default
> environment, leading to incorrect environment access before env_load()
> completes.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: aquila-am69: Set ENV_MMC_EMMC_HW_PARTITION and ENV_RELOC_GD_ENV_ADDR
      commit: 6f44d897435fe700afb7bb1858d6bc15516c3956
-- 
Tom


