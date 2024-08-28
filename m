Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF79C71121
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 20:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A7CA88966;
	Wed, 28 Aug 2024 22:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SYV82S9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74002886F9; Wed, 28 Aug 2024 22:14:06 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 058CA879C1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 22:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39d2ac2a9d9so23681575ab.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724876042; x=1725480842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8g5XFiVlaS88j5mqN2uJnCQXEUv0N3lEUGDa18/L/w=;
 b=SYV82S9u8rQlYDBGTlX0ghJxwOeE4/CYocGruza2JQEms4H0FFQL2Zkz4tK9er//hL
 LQPaaYP2GW/xBrqi+MgnwoSJeHnWPtbxcQw6g/qk+KOoo8UdG4i8DTY0i4Z7zEXDrEeE
 kThSY7R7s906bs4QViqLo4eQvGVxFm2lPfkm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724876042; x=1725480842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f8g5XFiVlaS88j5mqN2uJnCQXEUv0N3lEUGDa18/L/w=;
 b=bSreW5vFTRVQxi8uq2PW7CeZnQj95HFPs0JOwDrOtcLMSG6XKQ6Y6GAb08udCFTMEf
 vATpia4jeQ1neWktNPD3x9+LHDuFFBW4Vn7tDzSvzxP+iQJACI813uUN3jkZdczxOqdW
 FQugDDpxsvfh223H6mkIOq5cSiQyxpxC2PIBVkMCY3iTkD3NuTp69rcRBxgSLnOsyDZX
 GzFXG6PP8RZLTDqoJKVEc6t0krDtQebd1vMm63DgBoQmkR8J3oA7o6CA/2XaiQH3sDj4
 sRauqSprePQ+PH6zEyRmMHw+pwyHzOjTqrCpE3tjeHcqb73a8BQW2QcJPNt5Wq0oFhZ0
 nHeQ==
X-Gm-Message-State: AOJu0YwRuwPy8xHaGS5VrRV8Sh7fyIVQWsHwobghZ5bUmXSEX86jNqsv
 lPANvquo94m9ttM/J74IRPU9iJffkHlfc7nvr1P3pMDg14Hf+IC1V3crm8cu0YBs2kQ7xAtn2SM
 =
X-Google-Smtp-Source: AGHT+IEIyiAD7aVYjNjV1YTE9hdhJewn0/fEtZRxIY/z3aXO7lkm1BqkpcFBZILbLB3Tln0P+44WiQ==
X-Received: by 2002:a05:6e02:b22:b0:39d:4c8a:36f9 with SMTP id
 e9e14a558f8ab-39f3790120amr10791365ab.9.1724876042587; 
 Wed, 28 Aug 2024 13:14:02 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e91f88sm348785ab.44.2024.08.28.13.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 13:14:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] x86: coreboot: Enable receiving timestamps from coreboot
Date: Wed, 28 Aug 2024 14:13:55 -0600
Message-Id: <20240828201355.1111764-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828201355.1111764-1-sjg@chromium.org>
References: <20240828201355.1111764-1-sjg@chromium.org>
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

Bring this information into bootstage.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/coreboot_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 0b103efe16d..692cfd84bf5 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -11,6 +11,7 @@ CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTAGE=y
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
@@ -30,6 +31,7 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_SOUND=y
+CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
-- 
2.34.1

