Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CB2C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F33807B3;
	Wed,  5 Feb 2025 02:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KcLlUf9H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA24A807D7; Wed,  5 Feb 2025 02:56:48 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB0A580040
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eba50d6da7so1785878b6e.2
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720604; x=1739325404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSC2Uk/8rQfIPArodsIC6zT20gPtf9nPkhbMjGAja3Q=;
 b=KcLlUf9HESQnw79oCtfgBI3VW6nk1R/j9zf2R5w0jvzlRB0sfUx6ossgs8hjfw1kr/
 3++EGfmqNi8Vna34IbVDjEO/HJ41rgIRSKiCWrS9gLxGSb0b0TzrN42hobyZM2gB+xBF
 ir6Vu3n0rgKBz7wRLIM0KhS7LES1n9p7FPO8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720604; x=1739325404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tSC2Uk/8rQfIPArodsIC6zT20gPtf9nPkhbMjGAja3Q=;
 b=qmH5332vyj2wJIqluyIARllxdYpUQk0Q0MAgHC0IwfZN59j9WmPVHwHwxYgzpIEpVv
 FavXsh2yWgWhR32md69kiuXtv2roQbigcK3qNr6xdgYpY5CQM6yEWsViE1sEwdlA8Fbc
 Dm5JHlfmoaqGp6/4GQF+Tks7fSBxSAIODLcrl86vrwU6pVt6YRUIXHj+nRNxyOSYZ9pm
 gj0CZbhRYKTm8YtxnyEtKHDrDFbX1Wg0k0OEk6D/tp2AKSDLsURm+a3VDhR85ijz30W5
 8pFq+2H29o7pd2Tu35onYtQdsg6gXdYxkwg9A8qYP2QEMkSw5B5Uvj0hM9x98B0DSKiQ
 sI9g==
X-Gm-Message-State: AOJu0YzweKJMiTxwf1UD4xz5sn8u03ELCOUCRhT2bQ3Wcpe5ANoWtYOw
 U6nx+BcFwB3D3qwV0isEg7GZfGR87XYtp6yOelb2JE/IPq9KnKoKaeP9WLJCqeVSFkUmukS0WQc
 =
X-Gm-Gg: ASbGncv6lUsCdOnSChyOjce2qMotezrDOIAQrx9Fa+/o7VMGBzF6M6lZhHH1xd2meFt
 5zFVCKtmAi5dp+5uj7etUSIP/BoMoIw3i1IN4S0z+v9gzmwTjanVTIyptXf9+dx8qHiIg8bjaxE
 2Hkj6b6SlGqnAi2U8au2cPQ63VndJe5l2t8j85EODrsWiczn6Dt2oyxJ57m+4rZZdUmFlFKhVpY
 5usuRZjlq2SDK/9wiIA0H8CXxlxt70+yaWWkjVY/nIUa476HQPzy7hYfv/4qvm/IwinWsURctkb
 +MkjdbRVzTIT8gt8AERPUELpe/LWgb5VVNuOYQxYPTTQBgHHAG4J
X-Google-Smtp-Source: AGHT+IH/J+1WGITtKgl+B3Lp0JAtecMvihu8r3KoGQcx5rel4v1TV/AAv+1yErT3JuwQjhyfq5FArA==
X-Received: by 2002:a05:6808:1521:b0:3eb:3d21:9ce1 with SMTP id
 5614622812f47-3f37c10b308mr569655b6e.11.1738720603886; 
 Tue, 04 Feb 2025 17:56:43 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 08/29] rockchip: Add more space below the stack pointer with
 kevin
Date: Tue,  4 Feb 2025 18:54:58 -0700
Message-ID: <20250205015606.2686149-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Move this up higher on kevin and bob so we can accommodate a larger
U-Boot, e.g. with debugging info enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/chromebook_bob_defconfig   | 2 +-
 configs/chromebook_kevin_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index decac2e1935..2f08cff41e6 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -7,7 +7,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x400000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-gru-bob"
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 5bbea6c42a8..8959d397256 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -7,7 +7,7 @@ CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x400000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-gru-kevin"
-- 
2.43.0

