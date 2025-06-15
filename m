Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586A1C61CE8
	for <u-boot@archiver.kernel.org>; Sun, 15 Jun 2025 10:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A7A2807B1;
	Sun, 15 Jun 2025 12:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nQ48uy0D";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PpgcxXyG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2999080C83; Sun, 15 Jun 2025 12:48:31 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 343BC806D8
 for <u-boot@lists.denx.de>; Sun, 15 Jun 2025 12:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bKqcF0KgYz9sST;
 Sun, 15 Jun 2025 12:48:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749984509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/wbzA8Qnqcl5z9GX6t7wijlb3ArXVRYSF6WelcoRGSU=;
 b=nQ48uy0DEuOKtbxQvyPOpDJwXW6ZEAytP8mHqPT5MVF9e6rDBv0GqtOmx6v41RnoSZmFlp
 7EPOiXVSq746Ph3Cuqr8gDRGNA8tk8XXfIy5ZkU+zQkQnYYIPhSYAeYJTvKnOMj8JtpIya
 JoA1Uu5xSYcy4WLAd20i4Ffganh91OxM+EL0tLbU3Jpz5dkNdjsRXUtl4XNz68N6vXuGtc
 efqnBvyUJ1aDNCZmeod/BD4EiOnl/5ApX/Kjrj0KGelbmSxM+24rS8IVlqqc4kZ9EAyxFs
 TMTwG3iwoDcO1M9v8RfGmKy09JGrZNFuxBA+Oy9QTbrdSZifhsq9foB1VG6lbA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749984507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/wbzA8Qnqcl5z9GX6t7wijlb3ArXVRYSF6WelcoRGSU=;
 b=PpgcxXyGYp/yMf2jyotMAmhkZxgx5lKHt+2BgGfmui9t4rMWyjUfDpGLqR++GMhHQGsSSB
 I+t+QqcLo9Tg9JZpYkg2PM3ufKdatV3eHVB0PlrK14CzrAjr7M0ZplpdRJdD//fvSGuAvR
 7VDKsdVS7jvvAN2xu65TVjPgjckrsceK5c0ONyvnMxv6w80w0fRSxlKhzP4il3zS9S83l0
 3ox6wY0VS7uKcE8WNCsE1vy3qDOpONdJk8JNpiISxd0YkY12UK/Om2HgtyUYtHCOj/X6jA
 IvLDcRP2T7fO/Q0/1QmtzEnsPVDAQenRgB4kJ+4vszObQjRHaC348597OfeLtg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Move early SPL stack into System RAM SRAM on
 R-Car V4H boards
Date: Sun, 15 Jun 2025 12:47:51 +0200
Message-ID: <20250615104816.14774-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yrjgppf1zwp74e11wq594acg3g9gk5rj
X-MBO-RS-ID: 24c6b7b85ab616098f2
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

The CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xeb300000 does not make it into
board .config on either R-Car V4H White Hawk or Sparrow Hawk, remove
this configuration option. The early SPL stack is however pointing
into the RT-VRAM and may corrupt payload loaded into the RT-VRAM by
the BootROM. Set the early SPL stack at fixed location at the end of
System RAM instead, where it cannot interfere with the payload loaded
into RT-VRAM.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/r8a779g0_whitehawk_defconfig   | 4 +++-
 configs/r8a779g3_sparrowhawk_defconfig | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index 8dcf8e35ee0..5d9cfc97a97 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -26,7 +26,9 @@ CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_RENESAS_RAVB=y
 CONFIG_BAUDRATE=921600
 
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xeb300000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0xe6400000
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_TEXT_BASE=0xeb210000
 CONFIG_SPL_STACK_R_ADDR=0x44000000
diff --git a/configs/r8a779g3_sparrowhawk_defconfig b/configs/r8a779g3_sparrowhawk_defconfig
index 47fc536df81..7202828cd66 100644
--- a/configs/r8a779g3_sparrowhawk_defconfig
+++ b/configs/r8a779g3_sparrowhawk_defconfig
@@ -29,7 +29,9 @@ CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_RENESAS_RAVB=y
 
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xeb300000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0xe6400000
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_TEXT_BASE=0xeb210000
 CONFIG_SPL_STACK_R_ADDR=0x44000000
-- 
2.47.2

