Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EC7CCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 11:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C8B58307F;
	Sun,  2 Nov 2025 12:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hq895bxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033CF830A0; Sun,  2 Nov 2025 12:13:37 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE0E3800B1
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 12:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-65682227f37so1208679eaf.3
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 03:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762082013; x=1762686813; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XasnhCyWw/2flgOVVjZLMmWpmFpkivbgvRHPcv0OETE=;
 b=hq895bxUP5lBamZIb0m1CgktxS4/wNtKU2AspgpAD6211gLnGxVgHj3jc2BLc3nR02
 VeV9CHGZJQHCJIrQqslni6zkZQ0TNX3uAVsiZCMBaeVlFEdsHJ05z/rdkj3NbYdXJJzW
 VMCeJPUuYG7Gm5IS9oYJ3auLTkH+oaGKdw/6oYr1qZOJ/Z+w3Q9WHa6+MoO3mU9qS4Aq
 rfG/MwwPacdjWhBt375nKYCVmjwkZFrLT/DRqbfLre3jfoZk8q2YGDAbiRMDB4Ly059J
 CXgnEwcqtBUa+aeGrkNiG051VxEIq7sn/76fDNXb+NFkpBpUE4iSUww2e+2NzsbmoyyO
 fSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762082013; x=1762686813;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XasnhCyWw/2flgOVVjZLMmWpmFpkivbgvRHPcv0OETE=;
 b=Djy0AKYc6eUmwWi4/N9IM5eMEpifYa8YxSQNgegaCRR5JvKALnZ/sYw6l4sfm2LSCq
 Ts9h5uGkGOo/wY41rv3e4kjVNRdwl6sif+P8H0u8X5+vym64RctvGi+xXGL2er0dyNFh
 h3Gm9rKYwHzUhN/aSXKlX82sywkzLIDjBZptB35XzgbFkBq1qkB345wOPjQwRiPAG6Tp
 2eujDCGTSexHjASysm6/mzpebAruDKopvRpfHcDfuE4jD9MRHzj7GyWjuEnJ9x3qCHq3
 shHRLQHTSKiuCZ12J3B3u4mo7j1gfJaSMQoN/ypko1EbT2zBQALLUT/kiGsMy2J6Qd7/
 Cpbg==
X-Gm-Message-State: AOJu0YxNfp925HrIH34fU/Zrhel+SuOtwLuAb3qqH26IHcQo4DAPz27M
 9G/YCX5kcjlacD7BsF3iwPV/TrmgAEbHgGw4GlIT/q2aAiaFhiIA6THuMniWFKdwD2DejjzaEoZ
 3ZPClMxtqlemY2DerWk/2icVT9ElrZA/i6lRV
X-Gm-Gg: ASbGncuWktcB2aMsRZs41J1VPj2dQtfkHtcbwgz37LoR9ISXtbe9jISzuF7MfvCSwVs
 s1Rd0nMC5zdGLFwO2wwRgQi9cZZIw8H1XEnMJw+pnGSdPglSD9TuiRzQgi/JP5P91ASE+CMCq5k
 MFLGjKDStJMrWmcTsQoff2PuKkV9q/yIZNPYFxYRk9U9ScJO46otkECR/uHd0eqqvrVqzLmYOHC
 M+9ehRcpK28RALJoF8tezmvK2NlTw2MU27RRtdFfh6jMvHLmIv4WP/iofJb
X-Google-Smtp-Source: AGHT+IEyPZbI00T8TI3zMQSQyZYT4Dj8TXSUuKfzwh1scpKl6FassVYRMo9JLW3D3fHGi/EEw+mRLc9KpLraZvEHLKA=
X-Received: by 2002:a05:6830:4890:b0:73e:7f48:e6bc with SMTP id
 46e09a7af769-7c6966f544amr4737843a34.2.1762082013418; Sun, 02 Nov 2025
 03:13:33 -0800 (PST)
MIME-Version: 1.0
From: Sune Brian <briansune@gmail.com>
Date: Sun, 2 Nov 2025 19:13:24 +0800
X-Gm-Features: AWmQ_blOx2IKI2na5vhT9bDWNBdr_IPSvJf6Oge9Rhl4z5xW8iHPSUuNxC-ecjk
Message-ID: <CAN7C2SBYSsYQkRbKTwcBfpBFsUbvY1oG_LoH_KZSNzgCTNeDUw@mail.gmail.com>
Subject: Re: [PATCH] Revert "power: regulator: Add vin-supply for GPIO and
 Fixed regulators"
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

- ret = device_get_supply_regulator(dev, "vin-supply", &plat->vin_supply);
- if (ret) {
- debug("Regulator vin regulator not defined: %d\n", ret);
- if (ret != -ENOENT)
- return ret;
- }
-
- if (plat->vin_supply)
- regulator_set_enable_if_allowed(plat->vin_supply, true);
-

This patch resolved the previous boot issue on mail:
[DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD power-on timing

Quotes:
"
While testing mainline U-Boot (v2026.01-rc1-00070-ge34d01d23e45) on the
FriendlyARM NanoPi NEO4 (RK3399), I observed that SPL sometimes fails to
initialize the SD card with the following message:

    spl: mmc init failed with error: -5
    SPL: failed to boot from all boot devices
"

So the NanoPI NEO4 boot stall is somehow
caused by the previous regulator patch.
However, this is very puzzling why w/o reverting
mmc works normally but not SD.

So the delay method proposed by Jonas in previous mail
about delay timing is not the actual root case for RK3399
NanoPI NEO4 SD boot stall.

Regards,
Brian
