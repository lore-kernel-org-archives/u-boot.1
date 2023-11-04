Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6A0C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 21:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DE0386F12;
	Sat,  4 Nov 2023 22:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="QN8bztfG";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="OZ0cPl2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6117C86F32; Sat,  4 Nov 2023 22:26:10 +0100 (CET)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 211FB86F02
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 22:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 2372cadb;
 Sat, 4 Nov 2023 21:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=s1; bh=hp7YqWrwtGN1iNOfDcO08J2a/vQ
 =; b=QN8bztfGEhM2wH4gmt+nZ6WIfcYiXAny2BE9VqNWKg/VeJl0YdG5AUMNZeZ
 KBdLwTiYaV+5DcdQS/S3ik8n40Fa7LlOMUJgqncuPLKTsie8nV5AQiJHGqRg07KN
 iLJn80ppb783aX/qZ5SoK303h6W2vIzBqvRoZTaCpl0KJD8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=from:to
 :cc:subject:date:message-id:mime-version
 :content-transfer-encoding; q=dns; s=s1; b=pzgkFRv2zfF5cO6rximzL
 b4sUZjArj9UHGNpvAY7PPgtjytev/9JYXupuv2VkR2ceOLcGABRRMFI3Vxw4RFI8
 PebSf+McZgxXkItyGrJtaOz9nej2GVyquh3maMWLd6OAjdiSGG7PzCX/4Lb+K+e+
 etRPCkE2KBkYJvojdOOTm4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1699133178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VlNFwgzYCpnU5QKXwzl9Z2z1hb1f5bafNDwUJWjE/Gw=;
 b=OZ0cPl2iZfvK6fSPCNnt68lUoRmROGB06FkdFp33GagGClrXobeSw+z/BWMlsHUEo17NxU
 7swpt17qHUA/ShldK8PTT6oIKuFvxf+RiHvPoJYV8ZFJo3xZphlZBGvyn/r/UlQYkZ853i
 c3/pzM4f8V1YixfPHG0xXRSjaLKmVoE=
Received: from localhost.localdomain (host-79-24-2-249.retail.telecomitalia.it
 [79.24.2.249])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 593ecfd6
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sat, 4 Nov 2023 21:26:18 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH] m68k: remove common.h references
Date: Sat,  4 Nov 2023 22:25:25 +0100
Message-ID: <20231104212525.260981-1-angelo@kernel-space.org>
X-Mailer: git-send-email 2.42.0
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

In one case (mcffec.c), had to replace common.h include with
config.h, to avoid CFG_SYS_CACHE_ACR0 redefine-order conflict.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 drivers/net/mcffec.c        | 2 +-
 drivers/net/mcfmii.c        | 1 -
 drivers/rtc/mcfrtc.c        | 2 --
 drivers/serial/serial_mcf.c | 1 -
 drivers/watchdog/mcf_wdt.c  | 1 -
 5 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/mcffec.c b/drivers/net/mcffec.c
index ec1fae9688..4e0a9a8b7c 100644
--- a/drivers/net/mcffec.c
+++ b/drivers/net/mcffec.c
@@ -10,8 +10,8 @@
  * (C) 2019 Angelo Dureghello <angelo.dureghello@timesys.com>
  */
 
-#include <common.h>
 #include <env.h>
+#include <config.h>
 #include <hang.h>
 #include <malloc.h>
 #include <command.h>
diff --git a/drivers/net/mcfmii.c b/drivers/net/mcfmii.c
index eae2065451..9bf887035d 100644
--- a/drivers/net/mcfmii.c
+++ b/drivers/net/mcfmii.c
@@ -4,7 +4,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
 #include <config.h>
 #include <net.h>
 #include <netdev.h>
diff --git a/drivers/rtc/mcfrtc.c b/drivers/rtc/mcfrtc.c
index d2ac889c30..9708971c5c 100644
--- a/drivers/rtc/mcfrtc.c
+++ b/drivers/rtc/mcfrtc.c
@@ -4,8 +4,6 @@
  * TsiChung Liew (Tsi-Chung.Liew@freescale.com)
  */
 
-#include <common.h>
-
 #include <command.h>
 #include <rtc.h>
 #include <asm/immap.h>
diff --git a/drivers/serial/serial_mcf.c b/drivers/serial/serial_mcf.c
index bb2afd0d8c..76143575fa 100644
--- a/drivers/serial/serial_mcf.c
+++ b/drivers/serial/serial_mcf.c
@@ -15,7 +15,6 @@
  * as serial console interface.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
 #include <dm/platform_data/serial_coldfire.h>
diff --git a/drivers/watchdog/mcf_wdt.c b/drivers/watchdog/mcf_wdt.c
index b36488bb5b..b555bbeb68 100644
--- a/drivers/watchdog/mcf_wdt.c
+++ b/drivers/watchdog/mcf_wdt.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <hang.h>
 #include <asm/io.h>
-- 
2.42.0

