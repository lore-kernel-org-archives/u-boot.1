Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56844C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A69F887FA;
	Sat, 20 Jul 2024 14:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Vp1ElnKf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bJnBy5yl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2798C883BA; Sat, 20 Jul 2024 14:43:36 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 474ED88418
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WR5nK6rWJz9smp;
 Sat, 20 Jul 2024 14:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vFR34nFNtnMhughM1bLH0UXBgP831jbAlACno10/kE=;
 b=Vp1ElnKfNISAlJxpnTkOG43rwwRYJERVmkySXid6Kg/PwiULfUmAMjyS1AGwRWUHh9KLPh
 XaOg8outvLOCdHNvXEh8RdfDiU5pbgpXPEmNbXD/0egAtK2SYek1bC/ViiEhL9Q/s3EWCE
 rkwZPFmqm2sQdrEgZul51MU/DbdfUHUhoeJV7kVGO64JLhPn6yO4HyP1j+n1oXTwjFKb5I
 B5wFd93bMqMHKWlIOQ2HU590CmOkY/5wPASHRjXkKA13dYjs4Z08pfrZX7Mf03m3ypbNKY
 MKFSILFAyg6yiVpuPeasoWFtJWKO8uUHH9HFWn6oH3YM9V8KWh5/2+1XeeelcQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vFR34nFNtnMhughM1bLH0UXBgP831jbAlACno10/kE=;
 b=bJnBy5ylOFqNclnBnUpFWCCI/tb8QU8DKfQUHxBhao3OBonNzoRFI3zpY597CrjSGNhKQO
 UyNetLYJJ8ym6EbPJZZPcYRzMLBdKhX5vJu/xgX+y9G4lAcdaDa5nxkpf2UQFOeF4r0bES
 U1b108oUetbCoYLszjNDEr94MLJ8X3JJkwoJfTGnOfSM2ELnSN1YGmd6Ei0rGTPc6BgPLI
 zSmkqX7td6uRtnNK+s0iKllh+9fquSYgoWz54Ju8JHsOIOSLPqHKHi7oR8xrpYTW9H9I4Q
 RttfQnVIdNJLqtMoNrd2aIsUlLciSMnFwD68nbrO4fZB9I3Nku+pU+miCFKy6Q==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 02/40] drivers: bios_emulator: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:27 +0200
Message-ID: <20240720124239.7553-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 59a6023fc505e46d87b
X-MBO-RS-META: w7teu8t8mh58h47am46193hx135w1ca6
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/bios_emulator/besys.c                | 1 -
 drivers/bios_emulator/include/x86emu/debug.h | 1 -
 drivers/bios_emulator/x86emu/prim_ops.c      | 2 --
 3 files changed, 4 deletions(-)

diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
index 690fb5a4d7b..2fd794f76c6 100644
--- a/drivers/bios_emulator/besys.c
+++ b/drivers/bios_emulator/besys.c
@@ -422,7 +422,6 @@ static u32 BE_accessReg(int regOffset, u32 value, int func)
 	u16 val16;
 	u32 val32;
 
-
 	/* Decode the configuration register values for the register we wish to
 	 * access
 	 */
diff --git a/drivers/bios_emulator/include/x86emu/debug.h b/drivers/bios_emulator/include/x86emu/debug.h
index 859b54d8600..1c043b78ba4 100644
--- a/drivers/bios_emulator/include/x86emu/debug.h
+++ b/drivers/bios_emulator/include/x86emu/debug.h
@@ -105,7 +105,6 @@
 
 #ifdef CONFIG_X86EMU_DEBUG
 
-
 # define DECODE_PRINTF(x)	if (DEBUG_DECODE()) \
 				    x86emu_decode_printf(x)
 # define DECODE_PRINTF2(x,y)	if (DEBUG_DECODE()) \
diff --git a/drivers/bios_emulator/x86emu/prim_ops.c b/drivers/bios_emulator/x86emu/prim_ops.c
index b3cccb17f20..afe9a40a322 100644
--- a/drivers/bios_emulator/x86emu/prim_ops.c
+++ b/drivers/bios_emulator/x86emu/prim_ops.c
@@ -97,7 +97,6 @@
 *
 ****************************************************************************/
 
-
 #define PRIM_OPS_NO_REDEFINE_ASM
 #include "x86emu/x86emui.h"
 
@@ -120,7 +119,6 @@ static u32 x86emu_parity_tab[8] =
 
 /*----------------------------- Implementation ----------------------------*/
 
-
 /*--------- Side effects helper functions -------*/
 
 /****************************************************************************
-- 
2.43.0

