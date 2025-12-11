Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0A6D41D61
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 15:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 339FD83A3D;
	Thu, 11 Dec 2025 16:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="G45L/6md";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C2DF835C6; Thu, 11 Dec 2025 16:37:20 +0100 (CET)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [95.215.58.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B881A839E8
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 16:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1765467436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILbUNCSnXyTaNoYPaOSIDMSyyOtGk0iOiYrCLWGNl1E=;
 b=G45L/6mdxa4CJWH5cYWJdRwHYK9iZchZrvBUmZbbabK3ooHb5mpn6SqTLuyKdZkHzH+kIf
 0gtEhHlOjXdbRcPk3BhevBtONwRO6Ma3Nef1LNE8GXnwPfFY+V94+d+kuVh8kgvjourOaF
 6uvZeKUs7hhBw04ZXaaBFD16PmhSnC6V0pnVDblMLxGxLDUBDA6OvIBdynLBqK9Ojt8XUf
 jzcdVMj6+bvvSi2J0sHg1I8mImF+XWKyq497dd0LmrvzBtUS27m9593tZOc9XLonNebels
 TIVLV2aABzz7LV1FBxgJ7OuwEeNg09dE3jLaU+BVP2go5tiCBtP0x8NnYgvEEQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Thu, 11 Dec 2025 15:37:01 +0000
Subject: [PATCH v4 2/2] board: libre-computer: use common Amlogic EFI
 capsule support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-meson-capsule-v4-2-59f126ba4115@postmarketos.org>
References: <20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org>
In-Reply-To: <20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Ferass El Hafidi <funderscore@tauchgang.dev>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=pGecB8zpcy7zi63OWMn2x/h8ilsFDzwbIHRXYOEsaew=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpOuUoMVYqJkra/dGJzP7jGxiFR4yr6jwWzaxNY
 ARps2nTD66JAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaTrlKAAKCRCEr8vQ14ma
 A9bED/45Yu+bjw44e4XCGj3lR6QEt2Ai4+Hag9Pv2nM6EcAIwcsvjydywRK3ODJgcUUELl1qmdD
 9zcZF1dapRazlgcRvoL25vxkUtEwhxgBAu30rrCCZ0iDIVEv6oskOT5bj1V7NBBFy45d3KwUlzN
 0pYmZCfqlpwKb2Nrr2vAu/3QF/95EMNbGfoRvQHvC+J12nswI4RIFfTsID4Au/Bch7GewRvNOhS
 h7Fu3Xl1fMCAbT7HZHrLJK0+/ysCBo2vXONAlRq3WYEooWptxP/hsNTUVOcG7uzCgsBtZE5mCJH
 TBrhPmG2hilxHpNPZpdKf9OYWMOGAldl3Ww72ENXbeEw+MPJSBsw9lhdkAXn5isUvW12+S6EOM5
 PK6hLAS16DKZidYVGi2By98pHTsFGzDGyUC3oY/wQQjG5mA/Uri89z6g3TwHxAbtPKdPBxDRxuR
 dmWnNsdC47mMgKb5HE68+ONpuLGt8dQivLb1ffs3QBaoSMGYpjjYxQsxEfKjmK1yvXAL/bjtqip
 xQ3206seDO9+SkPAjkYTV4UeXSKQBSGHxINXF7R9C945v4wmrqk6e3jvixAz88XmDLigpseGnsK
 aD12Gyi/+BapGB7+zz1/v5uBfAwzLscbw8hNJV3FTpFdSdDHUdpfpBuVFzVxvrePMfXS/FKywCU
 Rfw4tzK/Bza95VQ==
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

Remove the board-specific capsule support code, as we now support EFI
capsules across multiple Amlogic boards without the need for that.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   | 14 --------------
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   | 13 -------------
 board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c | 14 --------------
 3 files changed, 41 deletions(-)

diff --git a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
index b3b78bfd0ea..760dc740004 100644
--- a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
+++ b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
@@ -12,20 +12,6 @@
 #include <asm/io.h>
 #include <asm/arch/eth.h>
 
-struct efi_fw_image fw_images[] = {
-	{
-		.fw_name = u"AML_A311D_CC_BOOT",
-		.image_index = 1,
-	},
-};
-
-struct efi_capsule_update_info update_info = {
-	.dfu_string = "sf 0:0=u-boot-bin raw 0 0x10000",
-	.num_images = ARRAY_SIZE(fw_images),
-	.images = fw_images,
-};
-
-
 #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
 void set_dfu_alt_info(char *interface, char *devstr)
 {
diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
index daece299848..966fd287878 100644
--- a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
+++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
@@ -20,19 +20,6 @@
 #define EFUSE_MAC_OFFSET	52
 #define EFUSE_MAC_SIZE		6
 
-struct efi_fw_image fw_images[] = {
-	{
-		.fw_name = u"AML_S805X_AC_BOOT",
-		.image_index = 1,
-	},
-};
-
-struct efi_capsule_update_info update_info = {
-	.dfu_string = "sf 0:0=u-boot-bin raw 0 0x10000",
-	.num_images = ARRAY_SIZE(fw_images),
-	.images = fw_images,
-};
-
 #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
 void set_dfu_alt_info(char *interface, char *devstr)
 {
diff --git a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
index 09a69b090ab..760dc740004 100644
--- a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
+++ b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
@@ -12,20 +12,6 @@
 #include <asm/io.h>
 #include <asm/arch/eth.h>
 
-struct efi_fw_image fw_images[] = {
-	{
-		.fw_name = u"AML_S905D3_CC_BOOT",
-		.image_index = 1,
-	},
-};
-
-struct efi_capsule_update_info update_info = {
-	.dfu_string = "sf 0:0=u-boot-bin raw 0 0x10000",
-	.num_images = ARRAY_SIZE(fw_images),
-	.images = fw_images,
-};
-
-
 #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
 void set_dfu_alt_info(char *interface, char *devstr)
 {

-- 
2.51.2

