Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAFEC369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 21:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC20281F45;
	Thu, 24 Apr 2025 23:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uEw36xbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4054C81E25; Thu, 24 Apr 2025 23:32:42 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A377E812BC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 23:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2c2ada8264aso767601fac.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745530358; x=1746135158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7/oHx2cM8nPm+7roK2i7yvMBTKiCv7i7rGs1bXKMQU=;
 b=uEw36xbS9xCJ5ocwV3yfJDoBwfu72JFU0EENWCc+l0BKOuGiZLqVVC5aM9cNlK2aMR
 65uGubhEX46JAiZxNi+mtT+ZIf27RPfUBcFjYk5qS+L3UHVNrajUvwR4Z8TKLHaxP0p+
 mLrwkGZMqbM+m5DIm9cziO2WZ9XFpXTPY5RQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745530358; x=1746135158;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7/oHx2cM8nPm+7roK2i7yvMBTKiCv7i7rGs1bXKMQU=;
 b=cTaepSH+sR3kR7gzfGEL6vZzjWTLmmzdIA4mF8lIe2nbtpAJ+loQSSaWp226gwoxD2
 asHml82TYwXBW40oVhDmsjnA/ky0HZQqVMazqf9fUW6zwf5hCGOltSfOMzei9SJH66hC
 E8wKG+tGx2bt/eXZJfCR9WnRrJ3b7BZwmQ4g/oaQ8jyzC1oob8GpyvVVnNJECLFmtFK7
 LOubrtyaE0on/G95gOSGdIiL6u3+S1O9QEsL+GzR72rz4nFDGo6d1yIjrMEAha2L54KA
 N6ayVhhNPwqGMS6LwzqmwObjJWuIDKZI03y6odwySUP9vJm6OB1luRghTYbpMzbcW7/+
 W0EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXclNzajvBma+5h2GsdW+bAu9xLvg1xwFeZwjaOzyUfeK5Vb+Poy1gdYZs4HnAXR2GWX8TP8UM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3sxay8tq+3/kAdIQKyQXRvYkcpOkIV8BXirTSci4/eTaI6yOE
 KxjrHWthEZQg6dxbsEPLOqcZ1faVOK+v587IjO5JLg2nu2WcIuW15+tr5SwAI7A=
X-Gm-Gg: ASbGnctSGOkQBQmDBheW1GB1WMEPMtmrJDL98xYeg319rR06JC3wUcp53SsAZN+9NA5
 MC8fgwIuzn/CO5TZm6D5AFVs2W+foigveNdh+vW2hF9yo1HsMxh4PoRpOd08Kko8O6X/pv7Hqhq
 p0dCsyF4MP9HS0NAaEDrx+jA2LAYs7K8pR69wyYISB/POg/gaQskbeCN11QiFrMG6fIrF67QE+3
 8NcsDPfHb2cb7I+8k0Ii7Zv6CSvINQ51rZSIWobqepmF4r3vgVS9fq1l6aM16Gpg9+HL5Vpz7/R
 yQvxYMNGxBZINHUTtVY4HlMqHlQXbdogiZa629ZgrpThPAEJX6/RUxJ5Yao5ANxNzHwSJbOJMD1
 g5XRQwN9xGjA=
X-Google-Smtp-Source: AGHT+IED3NEIOSNndaVDV1a1PLwGaRk2m6dUUITabWl8JMhCQC97+qK0ce0oRr8O/lqGC/8bbBUbDw==
X-Received: by 2002:a05:6870:9597:b0:2cf:bc73:7bbb with SMTP id
 586e51a60fabf-2d99db1cdaemr45410fac.25.1745530358476; 
 Thu, 24 Apr 2025 14:32:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d97364d9b6sm489419fac.8.2025.04.24.14.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 14:32:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Judith Mendez <jm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20250417234334.3661321-1-jm@ti.com>
References: <20250417234334.3661321-1-jm@ti.com>
Subject: Re: [PATCH v3 0/4] More MMC fixes
Message-Id: <174553035751.4093791.16180261907716689267.b4-ty@konsulko.com>
Date: Thu, 24 Apr 2025 15:32:37 -0600
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

On Thu, 17 Apr 2025 18:43:30 -0500, Judith Mendez wrote:

> This patch series fixes MMC_HS_52 mode in am654_sdhci driver,
> as well as HIGH_SPEED_ENA and UHS_MODE_SELECT for HS modes.
> 
> Also add TI_COMMON_CMD_OPTIONS to K3 Sitara board a53 defconfigs.
> 
> [0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] mmc: am654_sdhci: Add MMC_HS_52 to timing data
      commit: c511c708aaf00d850f2c8eee7d083466a04109b7
[2/4] mmc: am654_sdhci: Fix HIGH_SPEED_ENA
      commit: 02c6913a97934c3b68629739b9c6273539e37a96
[3/4] mmc: am654_sdhci: Add am654_sdhci_set_control_reg
      commit: 6067aa66b3bb44e35742e60fda49eb3fe664ac23
[4/4] configs: am62*_evm_a53_defconfig: Add TI_COMMON_CMD_OPTIONS
      commit: 40dacdd9232edca29c3759951aa6f846d7a2c504
-- 
Tom


