Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96296F8FA6E
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34CBC842CD;
	Tue, 21 Apr 2026 14:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Bf4SXWql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3350284347; Tue, 21 Apr 2026 09:46:06 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A3B83E36
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 696403FE9F
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776757560;
 bh=7fCUC5FE6tphTrtqBV/w8meg9Ri96tmqQ+v0f51+HDw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Bf4SXWqlK1BSGCl0/DMysixip2vGP9FEoe4nWTKCcQKlZmzJ8wtmyvan0a4NfNlGS
 FEZHsCCk3/CzadrXvWKUubt7nMZTfacYAMY9B7981yFuiGb2rqxgdnh+kol6oEIgne
 SdZPk3IOoMZgMeT2efE2hBhvu3PnT2zZ+zoEZZGpgpAnRR7j+QOKbJcKl+DRXETLHH
 /YK6iAFE9dfiLiOlzRGFxgStI9Vgo1S03vyu5lE80CW0jnqI6OaMnUQFyIu6r1QHxU
 7ftfFwhBQltg4TM/HVm4vCVQbY7yziGA0iy2C0GNbO1qXEbCAtzsDJIYZ2O1hCANR+
 D39mbtwPk77LleUInxl8PiL1pZXfRgrRSAyI1+D2K9Xx3U+mJHkxE03JPq5q/lsw9h
 7VGCuWTX2xp+LRTnQ1zDd6/MYYPMan70eQgyFQfwtTWcdX4nM3JOwTlSr3j92tEfOX
 CTA2ykS2us9BzHAyq6v3hKZrU5cAKzMcG8LOHm3XHcYMzx5ZHe5KtffDGzJIIh3lef
 WSxqjFcwgRXDIxHPYeEW6Fgo6M7J63XzI2i0f1o2d9UBrGF2WNtqhljBWT8nOSgYWN
 nmhcoqpIYUrIAL/Bd7dFhRqUgoB9+cClb0+mF8xOWNkhUwAFs9ZGVkGdpfZFuE0lMl
 jKOCrPW6HpaSxhp11kN/WFVg=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35d9e67f6dcso479260a91.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776757558; x=1777362358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7fCUC5FE6tphTrtqBV/w8meg9Ri96tmqQ+v0f51+HDw=;
 b=Y7L1JcC26p+C7FY3Lqea7nRU/qkMhFMN+N4K9HyGHHLHp81no/nk0tsOUjNWkfWtcj
 WT7hOmHGYot2msSUlelbuk4WAPV1/JF/1PT1YpncnOAlPvN6yqvzAq68LxVK2/cbskSz
 Licpxcown4/YPLmogH2SsxAAV590OhZJ0fQez5be2wCn5lX0j/lGrgquL1yeT4uUY5QB
 8pEgGQE7mo/WJ0KXtGd/YTS85fL/Pq6ixqn3iYkKBRuD2HBdYTt6pHzk2mdmsmtpezjj
 moKxjIhPCYmkXYrJsuEU7R1lbJtTm+NzfKzwJI71GaySeWYM/75E0Hsipnd4xWlggEmP
 QZ8g==
X-Gm-Message-State: AOJu0YyfUL07rzz0U4HFRWjej0lypath4PdTlaYOew8tDF0cQfLuicPJ
 2yFMLYA9zIgULoz5nHL9CBXe5h4qkDM/rM5yzSwNL+OcBxSLnASFs0cU53BeUoIFWuNgDvOJLZw
 3c2Qin87YP/EI7LFFZIRVYjmXhk3c/26EV+t7bzcVYpt2XKjShqs14QtCoaigqdzduNsx57T5d6
 iYVCqiyg==
X-Gm-Gg: AeBDies5E1k2iEASRIipIBseQ9bh/oD6SuYacR2bJ13J6H/tK5cPhdbwFW3qQZ4lcHR
 r8FjG6SJgTNK1mNmnI7ivNUfQ9CzFXPQ0pRxaMD+YDz9rrcjYOvznJRIYyyVZlDTpYNmJXlK/g/
 aWGMSFMXkgJQLszAu4gfSgVymhnn6JX3Wxq55OAVj+QpA4Zdotyu7ezWeU/nM/PkbwFOUAzNkFW
 +P1UeWEk70Xql/ZL0JdxNL+4F1fNY9Rm7cSzz0ge3WGBzRy788xWy02oLS6FlEMsvzUfBc89NfU
 yrNM6gjtpNSLvaUnQ2MPdOqH1IQ54nWfs1ZRptJHS4VWbR6/Z46MoELy6WjTSgUs1etoBsbonbY
 aVmVo4gCvyJdjtXI/XC/dx7GMHIjqFSmI1YfIx73xFsM1MEjV+7qwtHxNYurUlUZxDAKd6ijBH4
 ylLHVMvag=
X-Received: by 2002:a17:90a:ec87:b0:359:f43d:4a6e with SMTP id
 98e67ed59e1d1-361402171e3mr19405846a91.0.1776757558399; 
 Tue, 21 Apr 2026 00:45:58 -0700 (PDT)
X-Received: by 2002:a17:90a:ec87:b0:359:f43d:4a6e with SMTP id
 98e67ed59e1d1-361402171e3mr19405823a91.0.1776757558059; 
 Tue, 21 Apr 2026 00:45:58 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab297c8sm118729345ad.67.2026.04.21.00.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 00:45:57 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: ggiordano@phytec.com, w.egorov@phytec.de, trini@konsulko.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org, bb@ti.com,
 afd@ti.com, d.schultz@phytec.de, peng.fan@nxp.com,
 patrice.chotard@foss.st.com, hai.pham.ud@renesas.com, michal.simek@amd.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 2/3] configs: phycore_am62ax_r5_ethboot: Drop duplicate
 CONFIG_SPL_MMC
Date: Tue, 21 Apr 2026 07:44:39 +0000
Message-ID: <20260421074523.4930-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421074523.4930-1-aristo.chen@canonical.com>
References: <20260420145353.3923395-1-aristo.chen@canonical.com>
 <20260421074523.4930-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 14:37:42 +0200
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

CONFIG_SPL_MMC=n is listed twice in the defconfig. Remove the redundant
occurrence so each option appears only once.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 configs/phycore_am62ax_r5_ethboot_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/phycore_am62ax_r5_ethboot_defconfig b/configs/phycore_am62ax_r5_ethboot_defconfig
index d597e9d92d9..481b55d59f6 100644
--- a/configs/phycore_am62ax_r5_ethboot_defconfig
+++ b/configs/phycore_am62ax_r5_ethboot_defconfig
@@ -22,7 +22,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_TI_AM65_CPSW_NUSS=y
-CONFIG_SPL_MMC=n
 CONFIG_SPL_DM_SPI=n
 CONFIG_SPL_MMC=n
 CONFIG_SPL_SPI_FLASH_SUPPORT=n
-- 
2.43.0

