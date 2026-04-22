Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FBAFA1FC1
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 15:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE0484399;
	Wed, 22 Apr 2026 17:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="RIe4onnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A393484333; Wed, 22 Apr 2026 17:39:33 +0200 (CEST)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [95.215.58.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40202842E6
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 17:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776872370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNPhg45MzTi1ZtvS4xQLym0Inbjtyod1lrkB+jfBc+o=;
 b=RIe4onnSwGu0oLZ/y1paZq1v7phdmB257GZv5l65yd+WaQHGf+zDi2yGhfw6mGxOjJHmfX
 fUbeGTmNZnkjQ+v+E4mBH8xsRaHyjtf7eKXvmSks9AXm2pldIc2AAaH7TcrKkldC34rj+n
 Ik9SItiYsNzx6HRXfF/Px2MJ/a6rU8myCDepWL8olE3OMimVjlYWagDikQVPHpMId6Idva
 fPjkIm39+K1EDvV3Fhgx0K/iqlbvwZpD/pGjuIpGoQsW93E46hgaW3zeHEAkq5d3CTTA7v
 e7CYmRlPL8qWBX73eqGd/At2ENiqyUu1envI1hL+gBMEpgQ9SlILW1UQ9CTSMw==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 22 Apr 2026 15:39:07 +0000
Subject: [PATCH v2 4/4] configs: libretech-cc_defconfig: enable EFI Capsule
 on Disk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v2-4-e04e4c9e69f9@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=LMGF3fO18XQ6NCapMDLKdOuMoeXUFmiMa4p/kVkgmOs=;
 b=kA0DAAoBhK/L0NeJmgMByyZiAGno66yjGbsKF9LuqvrpHIsZJbnQiv+qipR0oprp5ioVoZ4Ay
 okCMwQAAQoAHRYhBAMBvDf7VVys/XmL7oSvy9DXiZoDBQJp6OusAAoJEISvy9DXiZoDvG0P/0xg
 0+LLH5lAyseaEww8sJ7RaylZPOAiQyidflFcYMM5Pk09eMhtpHlKccLOZ5RmBmwlchqYvEbdZKo
 GVN0I12myiRtppuaP7PoXQytW9eB78EqTgNCEXtasx/nddpA8Bq0cU7V1Jl8Gbe64fmotSeY2Yp
 Kh575OEvA3q/CZf7dnNYF/9hfBfpnb6C60uY2sdelko6ls/HMCfMnscaiaIafKtcEUJ5hiWnYYg
 kpc13nZNncb2RU6wCWk4m64R8rGAXP3LozVck3RacLgtwfefdwGoupNz+Hk5eY5IZ89Hi6rf2Uo
 cYN+mbEQj1pPe8FPTEuHKaKk56wxBNs1IkmURX2LPJwewBm5h92thqmN/ka84EZ54cxryX6gnNu
 b8J1p59oYbmB40N/k5beFBEqlIzM1LjjmuuCGRNM3MSQmSVGu9JCJHHqJUYu/ueBeWlorSNmxvW
 0U7m/dClenLe0AKPtuQ322wd9cVN9WiNCSpwVQS+TDVND+CIzkMLx5mcnHdr4odasQw1GLpI03l
 Hlbibs2qayuz04qmNxhTwAtKWpzGtDo3jhvQw/GTxtvXzD0iYMKzL9LXPSHmb3+1BTE+VficWl4
 oOeO0qBffXUivqHqLBWbw7JK23hT+zJolKqLfEw2xfY2MmhI2IMcaVpsc/gTST6XnJT00VsF6lu
 Jp5wZ
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

