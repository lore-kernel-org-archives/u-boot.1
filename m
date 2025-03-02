Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D37C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 22:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A186D80842;
	Sun,  2 Mar 2025 23:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aHhdHwWu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DdwMJuvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A73B80F70; Sun,  2 Mar 2025 23:31:34 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87C6C807B1
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 23:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z5c9v1fsCz9sJ6;
 Sun,  2 Mar 2025 23:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740954691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8hJ2qvofihdXUNjCu9Ex0jXbimiu277raLNZfgKskLM=;
 b=aHhdHwWuZK0301WPSnJqmsmAl9LxvfKFR+sk1CC4lXIAUqkWNma2E9spycFvFkCqPLWdA2
 3IxMH5co3EhI/pV25nh3h83q+IG+1WSyx93jMMBCby/z4pHPb2oXElcpBMTRH3bjA4aX8n
 yS4SQkO8ylKau5VYHZeCatmcYg5UYanz0bYuSZ9VTKMFRo4OYvgxos3GT/PvwGQjPetLYT
 /h2fsKvB7ZamNsaMH8s/VypfmjKV59orf5oJhp/PujNUPxXx/4jqtqoaVx4Rb7Zj9GrhnU
 sp7a6sV/+FmcOyEj2phhSwxwdH81Ka+bfcEzuS4D4MT5GQxPWUIT+xIeOLic1w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740954689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8hJ2qvofihdXUNjCu9Ex0jXbimiu277raLNZfgKskLM=;
 b=DdwMJuvZ6aMzRDDvgoDif4nYi0qH9mmnmfjgNo5ipv4ZVD9G0zKNwebybkxx3gwO618rNc
 yL3oB80hSFv8+GIpY4yxNS9EvewM4YbjqMhye2fXxKCkoXYzgxHVVtd/i41qLKk4aszhgh
 /8h05useib8DGsM+ElNgvvRjglI0Z339xTT5XRnu/PmFHBUMyXh4gcqBWzh2DP4Ja/13lR
 tfLQEd8Ayf9rD446Qgt8UeoTbzkXDBOcLVJPiMpdcvOr0Kr8bc8N7tXkmHxtDCFEohm3Lb
 g1Y8mGUqIlz5u29BvJe6cx6/wjBmXtyhSEpdKN+EhtQRSkYOrz68TP7EkT6AIg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Enable fallback PSCI on Renesas R-Car
 R8A779G0 V4H White Hawk
Date: Sun,  2 Mar 2025 23:30:02 +0100
Message-ID: <20250302223116.780594-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d6299a811957a92ba69
X-MBO-RS-META: qu1qcfcuuczc7oo73bas68j5gecrxnn9
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

Enable fallback PSCI provider on Renesas R-Car R8A779G0 V4H White Hawk board.

This fallback PSCI provider provides basic PSCI interface which can be used
by the Linux kernel, but does not provide support for bringing up additional
CPU cores or any other functionality, except for SoC level reset.

This fallback PSCI provider is intended as a fallback in case a proper PSCI
provider is not started before the Linux kernel is started. Linux kernel on
ARMv8a will fail to boot in case a PSCI provider is not available, and this
basic fallback PSCI provider assures such a boot failure cannot occur, even
if that means the system will boot in degraded mode with only one CPU core
available, that is still sufficient to perform recovery.

In the common case, a proper PSCI provider should be started as part of
the Linux kernel fitImage, as the BL31 loadable, and replace this basic
fallback PSCI provider before the Linux kernel is started.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/r8a779g0_whitehawk_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index b49a81dcd49..8dcf8e35ee0 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -3,6 +3,8 @@
 CONFIG_ARM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN4=y
+CONFIG_ARM_SMCCC=y
+CONFIG_ARMV8_PSCI=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779g0-white-hawk"
-- 
2.47.2

