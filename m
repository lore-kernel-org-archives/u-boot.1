Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B96C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 22:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE8C83B64;
	Thu,  7 Aug 2025 00:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aJSXKNBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7076783AEA; Thu,  7 Aug 2025 00:27:39 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8163483B21
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 00:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3004ade907bso261009fac.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 15:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754519239; x=1755124039; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8p6bzym2GSLI8nt88tXXkQJgSQFp0dSPdjrPN0lGpY=;
 b=aJSXKNBnRN4ZBAFGRJEyir93RUp3Btwy+24r6uih65w6Gw6yS5jAsWWe0hIlBU3Pkx
 nZZVDRV4tS7glbZXWI0sWfz9jpOitJ9qDQYFtX7WUsmDq4LNfqkWKWNjoV0NT0FT5vfO
 ViwbpL+XsZKuynzOjh0R+F6lfTcLvPqJIgmD182cRFpmwcBi1xk9TzBru7C3i7pD9p3V
 s1bNLJU8niHYwV9ojaTETc63K/g4qlEJh+opsfUoCfPkegC4eUfAySBHDVfoPfVt7ME9
 CtNLa2mTgMEfdIAa6TNOKPkUzcGuTFu86/gOpypafeqkRebp8b51olAxGoX95KXPMLY5
 9Gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754519239; x=1755124039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8p6bzym2GSLI8nt88tXXkQJgSQFp0dSPdjrPN0lGpY=;
 b=v5fmYrZHM/vAO41F5DBKw39mGrUE26r2YRL8cJNvumMPbi44hBrjtTKTZoGzaGKKBE
 6/rr+SYmwFfk0w6pv36huCPT3rsqTqstrUu05fNofhivPPm3bXWPoZOHxj1wm/zPQN6O
 7uF3prKsBEBM9A85kkNYkG9tzWAW1D6lsObN/i2IjK60nxy5ZrIjZkqiXtXOSAU8F/ZT
 aoq+PVRQ1LERDCLbV0KkMqXWfmHPU3prhQ8XlvZDz9XRf6be11fSQZjL3OoPBFB6OG8e
 UVyMulMEHN1MYe8ZDLPH4exmQMFVNWKNP0lk3rVgJ61WjHV1TvH8C7bCsgsl2xfRFf2P
 1A3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGjGDdfLajC1LMmb+I+QuEiNcJcsKEXhvPvRf69HaS1VoYAgZOYf9YspuDygq9vU7OT6exo2Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyB64xASxyeMV8uwO7VQNbFiJbI+FW7bIFVAHdxIrwfZvd+SJOE
 MIOljMCIchArX+p6AoDYRyoLvDgw/JIMcO7ydZcTWb04FnWmrs3wUPjkAlOwo3Tz28g=
X-Gm-Gg: ASbGncsw9NyLbX0JZqCJR4xdW2E6VrPwu+j/3OzCwxYXeAkbcA5nopMXKAb3va5LFpL
 /lIiRiRFhwHBP0xWEKhv95L5SzkQkff3O4x5D2s3d1bWTpjlR+npWq0Qg046o2zwolODPPK/TA3
 zXd1UjyrdqDI/N5GNkxAgNKmT1ijNBjjK9YKbM1uj9lABsSISiQBIKj7fzE1KwL9AfwWJqyiD4G
 BLDjlZl2DapF92Bjtm9tq/qH5D1XJzvnsVNnOKmY432bNeiwqBu8URYO7F1H8UJRm4gBZvfAQgJ
 6GMw1VLrCYPRv3FWeHF5DdRqJfGR3BgDlGzbnFfTQ4YUBy2AW/pICHOukdKDc3Npam1SF/MB1Yv
 nXJocbErDjJAaXR63AO4Q+uuZYU2Ar2bOxlmX
X-Google-Smtp-Source: AGHT+IHSv6TMSgiZ0nMwAW61kuOrLxK3+ODDZ08V8MzzJj0aqYPUpMYOMQli/wfH3AgfVw1CXKZ4KA==
X-Received: by 2002:a05:6870:b616:b0:2e4:4617:f6e1 with SMTP id
 586e51a60fabf-30be5d9d5d2mr2351093fac.2.1754519239399; 
 Wed, 06 Aug 2025 15:27:19 -0700 (PDT)
Received: from localhost ([136.49.61.16]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b7f798bafsm3080653fac.17.2025.08.06.15.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 15:27:19 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 09/10] configs: e850-96: Enable USB host support
Date: Wed,  6 Aug 2025 17:27:09 -0500
Message-Id: <20250806222710.23773-10-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806222710.23773-1-semen.protsenko@linaro.org>
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
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

Exynos850 SoC has a dual-role USB controller which can be configured in
USB host role. As it's the only one USB controller on the board, it's
shared between "device" USB connector (micro-USB) and host USB
connectors. The hardware automatically powers on the host related parts
when the micro-USB cable (for device role) is being disconnected. Also,
as U-Boot lacks dynamic USB role switching capability, the only way to
switch the role at the moment is to modify "dr_mode" property in
U-Boot's device tree file here:

    dts/upstream/src/arm64/exynos/exynos850-e850-96.dts

This won't affect the dynamic role switching later in Linux kernel, as a
separate (different) device tree blob is provided to the kernel.

Enable the USB host support and corresponding commands to make it
functional in E850-96 board.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 configs/e850-96_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 412c99468f29..d7cd1b4b8ba5 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -29,6 +29,8 @@ CONFIG_CMD_CLK=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_EFIDEBUG=y
 # CONFIG_CMD_DATE is not set
 CONFIG_CMD_RTC=y
@@ -63,6 +65,9 @@ CONFIG_SYSRESET=y
 CONFIG_SYSRESET_SYSCON=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
-- 
2.39.5

