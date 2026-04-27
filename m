Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72257FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF34884178;
	Mon, 27 Apr 2026 15:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="Cu/ONMD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B594842C7; Mon, 27 Apr 2026 15:59:09 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8EB7842EF
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1777298341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rrzIW+eQjZzr4UmMFpw8D1dGosY1x2N8RolV/1eXSc=;
 b=Cu/ONMD5XZryVz9modAQit7k1xV/81ExDux7odojKmpWfA2XzQsvkUht/fAmHPpGFc70N6
 Ht0j6UkGupq74NhhxdjIiizsIF49ssFsWr5MFQuGHR4pmYrki5G5hNP3E44kTulLvBD2dM
 BcX56VOtFbatjiP5kSwwFQSsAev6wJ8=
Received: from archlinux (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 88738b1b
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 27 Apr 2026 13:59:01 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, u-boot@lists.denx.de, sjg@chromium.org,
 Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v2 7/9] configs: stmark2: add bdinfo command
Date: Mon, 27 Apr 2026 15:58:52 +0200
Message-ID: <20260427135854.18496-7-angelo@kernel-space.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427135854.18496-1-angelo@kernel-space.org>
References: <20260427135854.18496-1-angelo@kernel-space.org>
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

Enable bdinfo command.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>

---
Changes in v2:
- recreated by make menuconfig
---
 configs/stmark2_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/stmark2_defconfig b/configs/stmark2_defconfig
index 4617cb19dfe..42629ad5d5f 100644
--- a/configs/stmark2_defconfig
+++ b/configs/stmark2_defconfig
@@ -22,7 +22,6 @@ CONFIG_SYS_MALLOC_BOOTPARAMS=y
 CONFIG_HUSH_PARSER=y
 # CONFIG_CMDLINE_EDITING is not set
 CONFIG_SYS_PROMPT="stmark2 $ "
-# CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_EXPORTENV is not set
 # CONFIG_CMD_IMPORTENV is not set
-- 
2.54.0

