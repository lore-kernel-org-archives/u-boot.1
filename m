Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C09FA1FC5
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 15:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C5D4843B8;
	Wed, 22 Apr 2026 17:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="eoYsc8AT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7C43843D0; Wed, 22 Apr 2026 17:43:43 +0200 (CEST)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02EB184312
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 17:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776872621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZWMj5PhxaCUBE7s/8ebpRzJthAArwHQGp0OE+VSZSE=;
 b=eoYsc8ATz/T2igY9inSIg2G255gc79nTSY737cNWaXKHF3ekYaNpB4ZBfGBRATsBHb1IPZ
 oYX4yejsKnQWmc8v5r58wQltn3sXnDeoYAXyEMXaLBh4hYJKsGFgRs0LfRfKY5CRvvAkBo
 U0F4HW5385MBbwERQka+Hob9v3V9QTGYaOuEgtTNKU8ygV1cb4mww4wfXDNaKQbfBXNwtF
 DlNEELDeuxqTVwtDzxW9IzRC9tr3wNHmetlmvHChJ2PottDd7oMN//4U4Rg13GsMnRFOgk
 9HcWbHdUwKLXtKee9bwDGeN17pI2aDe2n5B9cmL0vTsmqpiKtIf+WZVUYt9XYg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 22 Apr 2026 15:43:26 +0000
Subject: [PATCH v3 4/4] configs: libretech-cc_defconfig: enable EFI Capsule
 on Disk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v3-4-07b5ccc8f552@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=h3H7H6BQ9c4ZZVorSfdAEgQutvIWYusUDSBHHnVcpRE=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp6Oyjmnr8LwfdX5FGCTAkOQupPffuXGxGBOjv1
 wI+/qeEOaqJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaejsowAKCRCEr8vQ14ma
 A1nnD/42k+zhnc5kiwNh73DQ/l2EaSxOpwZdb0gqOO8BMk1uf5wjhIvUDP7HdkCguPgunPkFooK
 wHhf7WgGlwbrg4ZZnVn5RwHFSOeOUnHKl2EXj5+QPif/4YigmC5nVTvUTJVHJet8/YvLTt/FEYw
 LLhOmDT98QjwJ4y3eflHKHVRuBtXDTvUM5QT7HlZnz4WJaZ/+y1/g9yJO9LZ0jmw8EEf7ZLtbpS
 dqXQS99ulnPs7Sfd2X1gYnAiWYxU1CVJqNGMQRXIlR8u/hL/IIr4Ds21JTDArpBl2yp0G88mzGI
 Y0MlZOvJnFkdnbQRY9sbOBULJjxqeyXrtSzVaCL4k/CsmQMAeQZJooP3Ipxr5ayizm0xb56uO5L
 5nOJqplDhW1V0Uw5xgu7r7xwAJrRbyoR+vQW39HAt40rVMWYxZQhO4CqJxMvgbix6cEMuMquRCC
 TaynaN/JbGn857rr1f1YpOkXbmtoIrLpVKrr6WSuup+0bDqYs8R7E+21lL8HCA5URsGtPEXvxnj
 I59rt1oKbMukJg0UO0idE6CeuBrEIfZV4miRGyOiHv40VK7+wDnC+FOhvM/vP5ny0y5UzXeedKe
 XpB+ydb9+wWrp2ZfcbAZ3QDTXe7LXGqEl9AqzbYyD4Is8HQno+Ig2064jv9ZTX8UME/svu06rz8
 Ikta+KYKbrenbgg==
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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

