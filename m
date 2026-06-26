Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2851C43211
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 14:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5743684894;
	Fri, 26 Jun 2026 16:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VxsITouQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A634D84704; Fri, 26 Jun 2026 16:45:44 +0200 (CEST)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com
 [IPv6:2607:f8b0:4864:20::132f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3934A8404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 16:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-30c944aacbaso1612932eec.1
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 07:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782485140; x=1783089940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d06NZ8KN5+bzXKzxnma2sLK7pk/1rTPK7joU6HDMXwI=;
 b=VxsITouQgt16Q5EcvqXm5cRwwgJ/xx+xOKr2WJEfxmwrEQg5EuR4B99pXQl+Cjqmg6
 mXCq/JoICDsXcxm+YUNC2FXdBWQKHmZgyxfJnRnHbKm3z9z+USIJEFZd4GAlgc3Nn+gZ
 YvTvZyxKAEG6Wpw8YHvqMlpFHMPT3saZBu7CF1TgHW/lUEz9z1M2/taXe+IlXc6OcnpR
 s+j1RiNugu0s1C6RnwX8RGlfHzsYbSQRFUUgfQ258OQrADd73Oh7fSeoBgnB6keT7UvG
 ZfIWTAvM8feb0MF6kmL4KlLAQ6vARmPyUDiGraOe8fszlecnD9H/yL7LIaJ2Dw1AJx5o
 muMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782485140; x=1783089940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d06NZ8KN5+bzXKzxnma2sLK7pk/1rTPK7joU6HDMXwI=;
 b=sTzkb+8V7AJKRas6cIq8BXvdcDyVe38JhfDo6xLCx2JyBvIZvQFct5UIhP0RbZ4FDn
 ds3zhLkVdwsJtEHq1anEUjcs59b3+JVma1Rqxk1IYIKYeh279i2NrJB+o+1o1LFpnJC3
 R5KLBKd0N9qNq9D6XC3fWLR9F5hp2etUGldlPlQa4tJxbnn18YEFixm8zVz9/xEODfEB
 wBNlVBPy3S0AbKBoqZxR5eHoxnmR7GDFYnOxcq8d2cSKQ+kEuPcocmbPn1JSnULZXp5b
 wJBrcMgucCw8ngzyEaxIAUnqo7olqIExkEOj3MY9Qt+uZ2WUOnSp+aXnS9AOzfI5spLB
 V19g==
X-Forwarded-Encrypted: i=1;
 AHgh+RryHSe+TW25p/8LUMPKqdGcKi6l3t1NaCVioV3l6ducN+e1nrhRnBp8b567PKtO/Nr4NQ8wzAk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6QzsJdKyi6IHzh6loL9FjemHD3X7o0LpG7xESWILamjpHoz2L
 HSbk9QrvA/as4+6sXNv77rCqacUEw7iPhtFFk6WEIS/KRSLDyvD2/L5hpBVW9g==
X-Gm-Gg: AfdE7cm9kM4vqYVo+7uiMc/uWNdeXVDiJg3mHNYMKxBByx1jmx3yyQM2QamlErs3caX
 GBU5goVujDs/U5GDlOJWSF1e5s/l+qb5JPlrdwGlZ93IyKzHAUltTiEOBgDu9UHoY8KC3iAf1sa
 1yhdVNQ4JxdLWd8ExYumHCZVLHn/5fN7+BWIwDKtbDf6oZMtdLlJes1ynu+zrSR73zx+osjkDTW
 Ijx1SHo/IcWG4wBuKMiESVyYF+Xdp1s0gLrFwj8LniDLoyevSNtXRPlI5i/1HoCa5egXUhlO3oD
 J/gtrFDFCoPyhY77hAJEZmk6kss58LBTBvSRupCfF+bp0aKg3stZg/PZyo8UXdPPYA/PsRXSZZJ
 CsH9l/knkk2HYzoH1B4u1gBo5oJ8FC/h0buO1glZL17aiZMJ/FayBLNoKxiujvmRu7n3GgZrqdV
 slsABOVsAtJdo0NdMPy0XDox6Fa53jF4NPZtWpNPwzlbwHVCMlz9JJYsMhOMo=
X-Received: by 2002:a05:7301:3d0d:b0:304:eaa8:11ea with SMTP id
 5a478bee46e88-30c85124ae2mr6890285eec.34.1782485140362; 
 Fri, 26 Jun 2026 07:45:40 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:24b8:381f:62d1:5cfb:ac63])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d9105b57sm18823739c88.14.2026.06.26.07.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 07:45:39 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: djw@t-chip.com.cn, sunil@amarulasolutions.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 1/5] roc-pc-rk3399: Enable redundant SPI flash environment
Date: Fri, 26 Jun 2026 11:45:29 -0300
Message-ID: <20260626144533.2925490-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Fabio Estevam <festevam@nabladev.com>

Enable redundant environment storage in the SPI NOR flash by enabling
CONFIG_ENV_REDUNDANT and defining CONFIG_ENV_OFFSET_REDUND.

Having two copies of the environment improves robustness against
power loss or interrupted writes and is useful for software update
frameworks such as SWUpdate that modify the U-Boot environment during
system updates.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 configs/roc-pc-rk3399_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 1df5cb03adbb..4c9a5a69b4d0 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_ENV_OFFSET_REDUND=0x3F8000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_DEBUG_UART=y
@@ -39,6 +40,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-- 
2.43.0

