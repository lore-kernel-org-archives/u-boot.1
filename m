Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EA5C48260
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 15:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F7387BCE;
	Thu, 25 Jan 2024 16:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bdtJCl2B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9793E879B5; Thu, 25 Jan 2024 16:55:04 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B56A87B8C
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 16:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 57CE540A26
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706198100;
 bh=j5bdO5KjFq2mPgFJkOMYbcGFWORCMWB2uT32Atl8NZI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=bdtJCl2BojGXyGznpLyy/2Z2NTAM3orWAyZTZzQcM7Q38F0gHjEN90O8ojETsG9lX
 HumxdQsAHS/96F+HsqAhl9Si/vOJoQtdYiVZPdALS0aQQHWJourAAtA16OqHvY74eX
 d7K+PxLw3TVf8t/WYSevLnvt8Xodt8TjquLPPDZDbKvm+TD7a8b4EXi6no4pdjNHsc
 sQUp8k7O4sYeHk9qsV9ahjAl3m4Y7Ud3Z/mv43PrmRLxXE9/fpjN6jzVm9nFuaUz+7
 pnLDVqz1t7JsAtfYlcBAMgqeo3OiWcKXMwVhbufR/ilgcvjNzG83Bgn0dBva2CyBAS
 ubNzrOpk8hdXg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40ed389a4dbso3891025e9.2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 07:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706198094; x=1706802894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5bdO5KjFq2mPgFJkOMYbcGFWORCMWB2uT32Atl8NZI=;
 b=gYB/TXJuE8cKFlkH60CWkMzRnTcVGgoaFtLvqWr9tqevRg/PZsp2JhJi1uUVMvg3OP
 FSM0j3Vy9ip8SDElH4p3CE3JhWt1CGRZONUxuENe6RXTJvUcVmfGqbs6ZePmWKWGX9AI
 PVsbBlvbEc3dlZTJCijsCjjF8bsOrVBhU/+GPQhbYvnsOkTKKT3TC09wyGSfQBSZfR+q
 kbRQ1lWanaQLPM9YDBoVDbuhSuAMpNWQh+fLtpFWtbYIc7a97AfbycdNi4YdMG6CiY6c
 5RRBP3Nlq/CBASC9MUSsW1T9KKI93hfc3lHWBhPDEXl+1U7SjlNRM7XC5Jscu8q4aAn1
 yiog==
X-Gm-Message-State: AOJu0YxwWMlDtryd2YTUwhC5IS3v/kppcaTG45xBl3IFGKgt232Hsyd4
 nYE3wZTCyFhaxsz+kd+jd3Cfp2+IyZdTYR0NvEOeT3eR64rIAuADHd3I0LKoEX70DQERutE4I/P
 pWHXLs8cgdkJtRR45VJL0FRd+egXuauB5MeA9SL1asmXBGxoyhgHYzR+U9SIfmiQkeik=
X-Received: by 2002:a05:600c:34ce:b0:40e:416c:c03f with SMTP id
 d14-20020a05600c34ce00b0040e416cc03fmr669938wmq.212.1706198094047; 
 Thu, 25 Jan 2024 07:54:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq13dX8v9Tg8WgmzHWfb0ZVco+CE0NgCp8kb+Brdg0Zn3QMN8LN8Ltuc0XqU2iCngnCxbI4A==
X-Received: by 2002:a05:600c:34ce:b0:40e:416c:c03f with SMTP id
 d14-20020a05600c34ce00b0040e416cc03fmr669932wmq.212.1706198093794; 
 Thu, 25 Jan 2024 07:54:53 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a5d4f10000000b003393592ef8dsm10557471wru.54.2024.01.25.07.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 07:54:53 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 6/6] configs: enable smbios command on qemu_arm64_defconfig
Date: Thu, 25 Jan 2024 16:54:38 +0100
Message-ID: <20240125155438.47617-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
References: <20240125155438.47617-1-heinrich.schuchardt@canonical.com>
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

We have a Python test the copying of SMBIOS tables from QEMU.
To make use of the test we need the smbios command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	no change
---
 configs/qemu_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 5100e193be6..631d8866f62 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -27,6 +27,7 @@ CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_PCI_INIT_R=y
+CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
-- 
2.43.0

