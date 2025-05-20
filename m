Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E9DC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 08:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C206B82AF6;
	Tue, 20 May 2025 10:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XW54py8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B5282B72; Tue, 20 May 2025 10:55:18 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B197782B31
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 10:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so37809085e9.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 01:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747731316; x=1748336116;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8sDBAZPd7TNDf2SB9WCnsccXGxXhHnDodOfT72Q382s=;
 b=XW54py8BoBmp8SKJrByZiMBI300rXRY/WKLeHTGJKkJ7KyDjHFryjRGLxshlx8uebq
 aNWDVOhZgTrkj4G3ZjMtpYJ4qQ4bL3cmcD/jLJqnr7XKOc/MB0UEmJH2Ug0Waqj/noaA
 2FqoFlosrk2Gd8M1a3/UCR6irVb2Vt3YO0ngU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747731316; x=1748336116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8sDBAZPd7TNDf2SB9WCnsccXGxXhHnDodOfT72Q382s=;
 b=QjdpLaDImc4SY9Y44BGDdstCQ3rWk9epAoH5DXsD6eniDIrxK/x+WxWiPgGhO01Hfv
 4WMmFqkdPePuRRddSE3pUD/GCFA85C/UBQUTDUlMgli+FJr78JZh1ScnFFFs8Tt8AMg+
 tcXso4jnvu4nAMaAHGyqLnzDEISIdwiAXwpPWNnhu9RPquyHn7N9mzn7yxeR7udaH2Iq
 6+0HhiH8Ovi0GxCIIZQUWJSmVHKZUUxWW0WSLH79UPdRvOaR9ArkKZWqVHQ2USoldYWh
 6Dl+Smr8wjK0ccrtREq51ejxtl4p/4yeGJO5qWVnzrIl7Im4YtMtkE+TcoMJYJlA4Xx/
 uW1w==
X-Gm-Message-State: AOJu0YzG+zBQ/RAnZdMrylbyEmr5RhgmAKY7kZPjp3gSYGGRZ8ApiCj3
 vRi9gVztCkh8bO2yYs4iD1SnRCbjX/g2hsvq7O5KNRQXKKDbg1mvE8LXIZZVPZcGqdvwkhE2u9+
 np1jK
X-Gm-Gg: ASbGncuCCM3pXStaZeIqmK6/hmg4nYv5CrwxQqW6RpgJ5pOUXwwLy6wmPpYsmPfnWxD
 qMgZtvHq2NDw7D/18kv5LYCItEES9CungWZua4zmNK38p6nRkEwwmA4NnIgBCAYcq8vZeZwJw0g
 yOBfev6yZs4aoeF/yeJns9D2vhLOjd8cNPjegLudc/nROm6gm7OmCfKqBaXGxmDwQ3/Mx+ey1ca
 b+GAZU94/M3oa4a0SVyf2zZbjGgn+d8Ub0vM+PFGOC56rta8/pss9yiHKwwFpuM/0YeXreuvLaE
 9GVj0NHcT5TclUrx647EScKg8fx8cDXWYMIUxJEFDqxQVOpC2G1A84/pV8jhmpaLlLV17F2M5gy
 NXLe9zAS+IPmx5XU=
X-Google-Smtp-Source: AGHT+IGc06ED+EKLTYBGpgA9OH4CaMCnLibhkyKT5uYLVzSFYs9T4qCwzqyPuPoqB8Gb4QjXP+NfOA==
X-Received: by 2002:a05:600c:8a5:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-442f8b7a2b9mr120611015e9.10.1747731315920; 
 Tue, 20 May 2025 01:55:15 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f062fcsm21541315e9.15.2025.05.20.01.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 01:55:15 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Sven Dembiann <Sven.Dembianny@bshg.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Simon Holesch <simon.holesch@bshg.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/5] board: bsh: imx8mn_bsh_smm_s2/s2pro: enlarge
 CONFIG_SPL_SYS_MALLOC_F_LEN
Date: Tue, 20 May 2025 10:54:19 +0200
Message-ID: <20250520085436.925901-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520085436.925901-1-dario.binacchi@amarulasolutions.com>
References: <20250520085436.925901-1-dario.binacchi@amarulasolutions.com>
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

The commit dda454e933c6 ("serial: mxc: Support bulk enabling clocks")
breaks the booting of the BSH SMM S2 board. The analysis of the issue
revealed memory allocation failures during the registration of UART4
clocks as well as other peripherals. Increasing SYS_MALLOC_F_LEN to
0x10000 fixed the issue.

Dropping this option allows it to be set to the default value of
CONFIG_SYS_MALLOC_F_LEN, which is set by default to 0x10000 on
i.MX8M platforms.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 configs/imx8mn_bsh_smm_s2_defconfig    | 1 -
 configs/imx8mn_bsh_smm_s2pro_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index 1c11d4705419..206d216394db 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -15,7 +15,6 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK=0x980000
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x950000
diff --git a/configs/imx8mn_bsh_smm_s2pro_defconfig b/configs/imx8mn_bsh_smm_s2pro_defconfig
index d2010d13b8cb..ef486f51eeeb 100644
--- a/configs/imx8mn_bsh_smm_s2pro_defconfig
+++ b/configs/imx8mn_bsh_smm_s2pro_defconfig
@@ -16,7 +16,6 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK=0x980000
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL_TEXT_BASE=0x912000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x950000
-- 
2.43.0

