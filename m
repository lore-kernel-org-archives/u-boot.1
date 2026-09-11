Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12544C88E50
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 01:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C49FD606A8;
	Sat, 12 Sep 2026 01:07:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6TdDcfvz7FN; Sat, 12 Sep 2026 01:07:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4475E60672
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789175247;
	b=LSZABdVAq48D7/a9jYaZqlWECqr6VV0+4aW1zcpC+XyccaPlDvO+dY8HMt3Lk/hsTjBp
	 poX9jw2HnY9mH8cCMFZQCba/bwPOpxRCuBzS9KnyU4Sm68/i+1F58Ybw+U9x3OkJGAC8R
	 nyR/ldnAx459ire6erFBVschYTEQqiZNzx6eJg38YWYIEkCvdKYRwFCmk98KcH0EoybW1
	 Gtm/PVu3SJxxfToto+ppTHv0uGqR2JyyUIXHyTRsoTTgidTptV9/zU3tQJzsRiv0BP7Rv
	 NH7NctVAB+uTS+hRKH+s6IGN5DJeBVsJAP7GfHZfo+wQg/iuuQ4OcngrRPTKu6Py8Jg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789175247;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=tDDZqT2KnI+3K/w8pj0tcA+1djRYdAyv3HinxuGgYGg=;
	b=NeaYNFUXInQRx4pfYW8VdJ614Xg7Ok9dJ1qN+xqAc08FGEBPjZiIwWp8ohVoWTRyCoV/
	 cSb3SHvrUKZ0heO27jgF2RoUHLKXYl6l83hz/2zv+9jf9xe/ZDewhBf0MrAK8bNUmFJla
	 N+FuQCBB+9zyPseGrUWQoJ/djFlrGt8JUj1N9hqm5LSb5ypdwmP/DMv//BYcEtMv3UsoR
	 zQne5ZT682fx2OVLBPH7ctzA1PVlwUbpoUkSSa8uMKqbz16OzEyQIYdD3Wz3RHB2ZYlum
	 j6dd1i90behcraot+I5FZ1gbHAoxxuEy0jHbFxTg1kbgEBjpT3HxYRnFSERCTgpuJJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789175247;
	bh=tDDZqT2KnI+3K/w8pj0tcA+1djRYdAyv3HinxuGgYGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ZjuCWStRcG0c6puIoBaeihFH/ehD8gmKMcpZ8smJyjAFgisrqlya6puIl3L6wooS5
	 OErbqgzKFapuAURhhoksVVqQbPqU3g5vQlenbGfsg2OfGi7Gz7A7i4u0uHFBSuvnzM
	 +4Z4giN+JHam1RHSiFrBS2NP2r8QJUA3yGdMaZtCB9v8AkcATjb1UvKu/qhg69ge1d
	 xd4UpDoGrpPVAm/FfrpDqw9ttikAqkgHkDCNRS+N5dxvTGR7+NAUsDUq9ub1ECBHvu
	 RhYgInSR5p8r36z5aHTpQDa7onmbM4I1iqcpUv96nc9SGlup/OWgav42ra+mTn3Cxr
	 3U7yKoABzJMzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4475E60672;
	Sat, 12 Sep 2026 01:07:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AC2D3AF
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 307D680EDD
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9AR1gs63fxbb for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 18:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7CDE680EC0
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789150743;
 b=pCPlwdxpK9JoXAVwP6EjcVUk2JBdibuI44RWlDjsgdEx76ZqGCTFtVnt9n2j177mdF6M
 t6EQAlFdIK6mSYskJVoNmIHfJXn/lTDKwON/S9WvPg2uW2zioayzKfKjqYUq63opTgX4L
 WOgpU2JIcZShIJhfVnclvtOiPC1tpzPasvSI0y2nb3orduIJg+BNoFPuxzOIZzujK3u5S
 OYSw54QhtB0rSr8sKj/y2Uo6p8qIw7FHanjjRDhaqIw5Q5mwDYebXYglvj1q1XfS7WbvJ
 cZd9BYgOO6xIIqYjiNu+xd/QRtWHLvxb2SsulutXfe8DGIMBlnGlM0pWaut8WMpsX9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789150743;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=tDDZqT2KnI+3K/w8pj0tcA+1djRYdAyv3HinxuGgYGg=;
 b=cT62llUnTEl6Kuca0oNFpJ0/2wfZmMXdEFzUALecHhtM1HeORr0lT10/PLLCSO/YV4sF
 sJLtBmlc2zogL9gXhkHc24e/n8R4yWdG08AZh2Tb5A5zHmApvluMYHtGtLiOMMdJYQhBX
 1cqW9+XD8nI9dp6d/h8rTWObTwTrBDl1V0YWU6YeUvJy71Ss9TZYyFQMj18ECpEDn9Zni
 XA10JUE9uchkH2pP6HoAeJcaLvy24CysK+pazjLhzdIomZPj8GheZDImFVy/xgylHIX9J
 KaqaJ5uS5LmdXypeT5YX4vx1BPAegvg3bL2SDEafaPNBPRKTBp08qCMmYQp4aJkVgKA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=H4tZiHJa; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=H4tZiHJa
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7CDE680EC0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:19:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F3B4541823;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D67F1C2BCFA;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789150741;
 bh=soMrRvmwrQRwT5uwfDdhSkAzubeXKfbMF/KLCuaLDfE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=H4tZiHJaj1HhEvp8dq1SQnm7XFnYtpJZfdOrYkGK0vsil2kK3ikoJqhJhDt7/x1WT
 JkC+vLUyBHgfq76+r/6nj2spsWiUd7q4YQ2VZlgb0kPfGmZLNS08NnxEkAxOjU9zN6
 yYIMLJTrko3HluoKfecKMTzNkKEf99rAI9fAQ29c1pbGP0lgd0LEtbhfrGO5ToRMsI
 4McjxYnwuTLOvY/h+hvzrS+rcC8JGS2CPOF/6XaFOx4e7qqL4gO1JFpciTb5vazjI5
 HGKBMLUeeb3chxfGAx7EOsP0X26cU+qeqgxIRrb5DFJvAxF2JfVCqVIJTJAAg+LrP5
 fAffJYZ4K0Xng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C1359C88E59;
 Fri, 11 Sep 2026 18:19:01 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 11 Sep 2026 20:18:50 +0200
Subject: [PATCH 4/4] arm: carry previous bootloader's bootargs into $bootargs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-android-bootargs-carryover-v1-4-6ebb43da3df0@protonmail.com>
References: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
In-Reply-To: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Alexey Charkov <alchark@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789150739; l=2305;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=VbmVfaCKN9oCVXFuYc3390vt4fabre7I+6mi2MUK2Qs=;
 b=hS+XKBq4FxRJuDN5uOIiyex2j8Jzqfvc+9VvoLkTxcnfsuwNjYw10UuHZf8JAsGnjIcveVap8
 Y7IbCy7amaODAm8Rm9hrO7LNeUBtlWiZV6MssN6JH3VN0nVx8jfBoDq
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 12 Sep 2026 01:07:23 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

The existing SAVE_PREV_BL_FDT_ADDR / SAVE_PREV_BL_INITRAMFS_START_ADDR
options surface the chained FDT base and an initramfs pointer in env,
but the kernel command-line ABL had already prepared in
/chosen/bootargs is silently dropped the moment U-Boot starts.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 arch/arm/lib/save_prev_bl_data.c | 15 ++++++++++++++-
 boot/Kconfig                     |  8 ++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/save_prev_bl_data.c b/arch/arm/lib/save_prev_bl_data.c
index 4357acaef6c..5ad607a6251 100644
--- a/arch/arm/lib/save_prev_bl_data.c
+++ b/arch/arm/lib/save_prev_bl_data.c
@@ -66,7 +66,9 @@ int save_prev_bl_data(void)
 
 	if (IS_ENABLED(CONFIG_SAVE_PREV_BL_FDT_ADDR))
 		env_set_addr("prevbl_fdt_addr", (void *)reg0);
-	if (!IS_ENABLED(CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR))
+
+	if (!IS_ENABLED(CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR) &&
+	    !IS_ENABLED(CONFIG_SAVE_PREV_BL_BOOTARGS))
 		return 0;
 
 	node = fdt_path_offset(fdt_blob, "/chosen");
@@ -75,6 +77,17 @@ int save_prev_bl_data(void)
 					__func__, reg0);
 		return -ENODATA;
 	}
+
+	if (IS_ENABLED(CONFIG_SAVE_PREV_BL_BOOTARGS)) {
+		const char *bootargs = fdt_getprop(fdt_blob, node, "bootargs",
+						   NULL);
+
+		if (bootargs && *bootargs)
+			env_set("bootargs", bootargs);
+	}
+
+	if (!IS_ENABLED(CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR))
+		return 0;
 	/*
 	 * linux,initrd-start property might be either 64 or 32 bit,
 	 * depending on primary bootloader implementation.
diff --git a/boot/Kconfig b/boot/Kconfig
index ae6f09a6ede..92ecc89e06f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -2036,6 +2036,14 @@ config SAVE_PREV_BL_INITRAMFS_START_ADDR
 	  If no initramfs was provided by previous bootloader, no env variables
 	  will be created.
 
+config SAVE_PREV_BL_BOOTARGS
+	depends on ARM
+	bool "Save /chosen/bootargs from the previous bootloader's FDT into $bootargs"
+	help
+	  When u-boot is chain-loaded from a primary bootloader that already
+	  populated /chosen/bootargs in the device tree it handed off (Android
+	  ABL) copy that string into U-Boot's bootargs environment variable.
+
 menu "Configuration editor"
 
 config CEDIT

-- 
2.55.0


