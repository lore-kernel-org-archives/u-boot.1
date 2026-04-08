Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E111510F997D
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 20:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA088412A;
	Wed,  8 Apr 2026 22:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="c/FAhEEv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 225FB83936; Wed,  8 Apr 2026 22:30:29 +0200 (CEST)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3016D83CF5
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 22:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1775680226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNPhg45MzTi1ZtvS4xQLym0Inbjtyod1lrkB+jfBc+o=;
 b=c/FAhEEvKnw++eLyHjWPMkNbg93YGA04cMB7Qf36fzaVnJhoiRyypT8ZIynYZsdNliubU6
 QUqzo+R+sSUnuyILaoi9PxCK+DNFBkyXcTUMxJUY4BFbvHjUFItf4sHSMN0UJEzjnKNnB/
 uFznWLmoXIVZ9YRo8lWcHIx2pvgrWuOrSaua2N9BbM7Se/YY5FDEWkPGZI9KmMdxy5sMk0
 gS37i2nhMnx8bNAl6634TXDTkYbJ6hK0OkELB/0mM+hW+KY3dRblsyApAziGuOlm/p64je
 nPhJ2u2N+1oKJAljI7H4lumBXTbNqKB2X1Wusm0tWLjA6Kvh9zJxAlvxm1/dKQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 08 Apr 2026 20:30:15 +0000
Subject: [PATCH 4/4] configs: libretech-cc_defconfig: enable EFI Capsule on
 Disk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-b4-amlogic-sysreset-capsules-v1-4-6f3386eb5124@postmarketos.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=LMGF3fO18XQ6NCapMDLKdOuMoeXUFmiMa4p/kVkgmOs=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp1rrbeAkal0nYzAmxj+fy2G2Hoe9U2Yg8iQbIG
 FfUVRQoqAWJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCada62wAKCRCEr8vQ14ma
 A00ZD/9y6P52CCZyNpFtE507QevwwhQapaEMU5d53bgTlEFB9yk2xgbKOZI5xrXC+2MrXMeNyEN
 qkzjwBFBZJUGgyAiiGQ9JJjos/tvLkfcXYfqTNnL3SiYSbB5heNpzzJbCV+qTX/LUkzLxJ1WfH5
 1G/wmDDwbuTwWLf1qNWz03RCWZgn4E8xNDJrYYopYhqGOME3ZyWstJWVgvKSEUzlJ4h7y7ueaiW
 wZiZW6mei4WcJ0ebgvL9A72SqcJEef9K3hCXX8k1t2SWvScKVF2FSPUcc5bvt8aB6Sl4/yjnjOn
 JKyu7qj6L71kKM0C0Q1kQebThHvlCOpNrVP2LyU9IDlOuzfR3uqDKAZmcW/dLnYmiaijsj1vL1C
 r9DToZubR40bkQMmf6Y2d6GiPVTFtu952IIkVT7sh5jOkDuL9aeKxEHu/Qs8YSYUA5rs6y/oUNN
 j3z9czzVLjNq5OEtJdaK6mWGH+G1J274ESeatHJuDLSRY87w6RViV+woXHyfTKH5QR+CcRIF5ey
 OmcC73YZ1HgidlSfCVn9rKCiCeM9sTu4XJxXx7MieC6J6TveDpUSZF8cf1PGlrG/e4MA9Lwl1io
 c9Oz09lmpkOKc71XgRQF+l4I07vd84nFksBI6FMoS4Yn85wClsAhLApJTLBjaREKd4xx7Rjw+r9
 UVkqXvTI6gA6SVg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Everything is in place to allow this board to support EFI Capsule updates.
Enable everything needed to support Capsule updates, as well as Capsule
on Disk. All this allows updating U-Boot on eMMC directly from linux using
fwupd. Also enable DFU_MMC, which is a requirement for EFI Capsule flashing
to eMMC/SD to work.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 configs/libretech-cc_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/libretech-cc_defconfig b/configs/libretech-cc_defconfig
index d5878bdc431..622922e97ee 100644
--- a/configs/libretech-cc_defconfig
+++ b/configs/libretech-cc_defconfig
@@ -16,6 +16,9 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" libretech-cc"
 CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
@@ -38,6 +41,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
+CONFIG_DFU_MMC=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_PHY_MESON_GXL=y
 CONFIG_DM_MDIO=y

-- 
2.53.0

