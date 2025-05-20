Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825A2C54799
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 11:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 529EB82BBF;
	Tue, 20 May 2025 13:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="abk26Ta0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3729082C2F; Tue, 20 May 2025 13:38:07 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4457382B48
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 13:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad5574b59c0so484004166b.2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747741085; x=1748345885;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=utkffFrvbQ7mU7V/LwrxwzHbkZuG0TKCFcBC3slGrxA=;
 b=abk26Ta0CE8Cn0iYG67tTGRUKX2u2haPpiCEhUFpPtkq9GVIVB0j2a7mIfLJ5CJlkm
 gSF4FfzrszCDOyz0Ka6eEZYD3ofKheCProaL3DDPFyxnkc/EEOlV05F+i+XxCQoR+75O
 Vh8ESRWyvVcbOyJ++fvu/L76XZ5bq6D/01E3GmkVUBv7fA4LUrVJ2lGit7JH9hYT/YWC
 FayfsW93pr41VvmBaDim+Sdd9Js/yNd8Ktvf3sO4WPovACZiwvZXI7rS6S+YH1Iz3Ul9
 ZMDBq0107PBAZH7RMTqWFEE3ny1sAXWvH6VfZVllw6a9Ghi5/vQmsO3+i5B3KoJ1MSL5
 4Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747741085; x=1748345885;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=utkffFrvbQ7mU7V/LwrxwzHbkZuG0TKCFcBC3slGrxA=;
 b=G0MHv0AV4M8ewL0DbgtucfYChM9S6LmTxH8Y66IVJMRV+mj5C8TlfyrPRNwjrt5/91
 56niT1QlPxYaeH+VfF2RXWGO2894nt90W4ImZJCsmrqQ9yLo1Zl1KyUsh82sRKK9QTHy
 7Wug5IBybA+QbXNjdnjYGiyIlCJnv/wsleTHFDZjf8oaDRIJPpVantnU761hQIdudmFj
 yaLlAhvk1/dRxCQ5NGgsxjzyYiJhBygitGKnS6tUmVKegDh2AOUBvCgg2qDV+CLc2Daq
 SkbOtrAIcZcRcufQ6NhT6it1ZrRMfJ0GGdmaUZYigfbnSfafA8CHX3qvZt+FSNzJf7RQ
 hu6g==
X-Gm-Message-State: AOJu0YxnuVoMtfAc+H2mIUUGUL1p7QBmFFC8D3jIvZGsE9q/zMd7oi2L
 B3GhauHgP4E3uAhpdqMY+y6tvKUqeLBdkTwcqn2KTmYQHAFLsUfSV+SW0M9tC5h3wPc=
X-Gm-Gg: ASbGncvYp9MKi2Gpk687YLaOav3RSbb1JefRm3pDMdMkV8VaX5Li1QowTSv9yWrFoD2
 rb2ciVXYWQeXnk90UrTMH5X65twelciGV//4/XrNhbpdW0Fu8mU3Kzu1xQKdAWVm4yzhDsCrR6S
 xg0IDTSVFufzmk85hUFLy4dC6+3JvSxtfCaRqn/gggekHIsgiVCvadViCVjjjl1NYvC0afvqfQY
 6dVZw2+RoR4+F7fe+MLp7DDyI6Bf4ZcdTMY/Qt1WHhB8bTBvc6oWdXr2gxxU7/K3vtuMt65q+XT
 rg3On1o6GThQiP2yUxz/UiZFQ31Rd7+8+BXMuRTtR0bAjaQUQCYQ4dR7e3G0ridg
X-Google-Smtp-Source: AGHT+IFhsu70r8JEA+vbP613UZEdgARjr4XZ7WCiEEni5IJvQIfOPUxoaxVRJ+mJzqQm+PIWNNxmDg==
X-Received: by 2002:a17:907:c24:b0:ad4:fd7f:a4 with SMTP id
 a640c23a62f3a-ad536f9d85fmr1216194266b.47.1747741084630; 
 Tue, 20 May 2025 04:38:04 -0700 (PDT)
Received: from [127.0.1.1] ([185.72.186.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4383bdsm715331166b.122.2025.05.20.04.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:38:04 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 20 May 2025 13:36:44 +0200
Subject: [PATCH v5 6/6] rockchip: px30: Fix hard dependency to
 DEBUG_UART_BOARD_INIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-silent_console-v5-6-ef9583d93285@thaumatec.com>
References: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
In-Reply-To: <20250520-silent_console-v5-0-ef9583d93285@thaumatec.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

Because DEBUG_UART_BOARD_INIT depends on DEBUG_UART, hard dependency
to DEBUG_UART_BOARD_INIT in ROCKCHIP_PX30 can cause warnings if
DEBUG_UART is disabled.
The DEBUG_UART_BOARD_INIT is already implied by ARCH_ROCKCHIP entry.
Remove hard dependency from ROCKCHIP_PX30, so that it will be
consistent with other rockchip boards.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 arch/arm/mach-rockchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index dac160d33ae3..d3ed870b169c 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -13,7 +13,6 @@ config ROCKCHIP_PX30
 	imply SPL_SEPARATE_BSS
 	imply SPL_SERIAL
 	imply TPL_SERIAL
-	select DEBUG_UART_BOARD_INIT
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply SPL_ROCKCHIP_COMMON_BOARD

-- 
2.43.0

