Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA094C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26178373D;
	Mon, 26 May 2025 12:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G+c3aNXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6268482B19; Mon, 26 May 2025 12:16:32 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4360182B19
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-86135ad7b4cso36805439f.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254588; x=1748859388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bi3gmA0hWvlmk8/7UxzSZ8+J6QleEnwrnquq7ZzwXxs=;
 b=G+c3aNXg4tFUkawyZUpYs+WavwYR0R4ec8kOw1QcXAOUeEGEMoalrg6/LO8gYy5vWi
 kcNw0k+Xb4nTCj3s5cVnxV8s7viyDI820q9l6AHpLelSPZxzvfmIEpu9NUti+qt9UeOA
 3b3HXQbVVH5P5ET5FyOMhN3Fc7L+4LVUvg3t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254588; x=1748859388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bi3gmA0hWvlmk8/7UxzSZ8+J6QleEnwrnquq7ZzwXxs=;
 b=HYJY48iRtdeofs9phrlksC2cAQUMXDtdi0UMSeEOvFUWfNsy21Yo9oTiKrPeczdev8
 6RbdejVlF6I6iqcgIkkW46ClcDLZVfx10K9jaH352W5V4zWXhQFdLgy7TjZ0VL8k/tKu
 OPtfKRFpjQnDOqQlT84p4FAOeBk8caOdFvemDDdotHh6ts0iaLN3G28QLXafR3CBvsX5
 G1qqauz15Yd7KwL0opfH4zflw9zhGcAZBSr4c+546uWjQnh1mKLv5Izw0rhLGqzVlUPs
 l4JVln2rNK9Qh3GNB68PcfV+i859s1DJtylndPMVqya3xcAG+YbbGG12qSXeNdchZ53L
 WWlw==
X-Gm-Message-State: AOJu0Yxpi3kxMny5DbDUxXWI/X7aFfJ9UUyGEDEOTptyr+5soH2ii44g
 o0kYetG6TNz+NuW5zGn0daewjZuPK36gmvJw9ieIux0fKMJLtMlAGAoL1kSaqWZM1qdUk1kMhpt
 9AVHGkxc8
X-Gm-Gg: ASbGncu6QnwIa74lXSPr+VdEM5i1BRAy2WcJVKKEQ/9ZZX57b/KG/XnEEpwlPnAZvnc
 wpd3Hdpwie6S6C8Kcms6aiczV0iSCwe98U0RCc195g+pEC8c7PWbnnfx3ruf516qmManeG2UiCs
 SSeqEqlgVTg6gDhc9vThSHY28chBRXd/YNLJ366gTUabD6+wSiC1b5C/BMvF+KlR5n+ivF5aNJ2
 GoYclLsYqI2HrXdJK847Yvxwz3SgkYD2EaHuMzfVJQKbFcILVWuyRMVx+pBR60Vp41l710zBrfH
 YqQS2Ru29had6KL0HtBGS8ga8YJmc6YoILSppR11VcJ9N7MajxAUrN82a3Nxc94IaHIRpgXRqIu
 ZQlO3/oRhmY/Z
X-Google-Smtp-Source: AGHT+IHcdIFFm29NFC5l1VnvB6AGHcOusgxdIUgmeIZ6udBO+je7+bpNaLTDaRbv/BCMO0X5OZboKA==
X-Received: by 2002:a05:6e02:3081:b0:3dc:8bd3:3cdd with SMTP id
 e9e14a558f8ab-3dc9b6800f6mr64246115ab.1.1748254588421; 
 Mon, 26 May 2025 03:16:28 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 15/25] rockchip: rk3399: Adjust TPL stack to allow for
 bloblist
Date: Mon, 26 May 2025 04:15:01 -0600
Message-ID: <20250526101541.3254628-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

Reduce the TPL value a little to allow for a 256-byte bloblist to be
safely located above the stack in all phases.

Note that for most boards, SDRAM init happens in TPL so the SPL stack
ends up in DRAM, at address CONFIG_SPL_STACK_R_ADDR.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Reword first paragraph to mention bloblist instead of other stacks

Changes in v2:
- Reword commit to mention comments from Jonas

 arch/arm/mach-rockchip/rk3399/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
index b36c76f6d69..a31df823d1e 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -145,7 +145,7 @@ config TPL_LDSCRIPT
 	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
 
 config TPL_STACK
-        default 0xff8effff
+        default 0xff8eff00
 
 config TPL_TEXT_BASE
         default 0xff8c2000
-- 
2.43.0

