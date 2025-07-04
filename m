Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532A7C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 19:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD1DE81F6B;
	Fri,  4 Jul 2025 21:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=lechnology.com header.i=@lechnology.com header.b="VMdiKN4y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD8198206E; Fri,  4 Jul 2025 21:15:41 +0200 (CEST)
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6BD6803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 21:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=lechnology.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@lechnology.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V8MOiFawivrUCcK8DUobHLUXfIBwaXkGYlzmoDvoQjg=; b=VMdiKN4y83MA+s0MTAtnSLpt70
 JT0N+WFwREqXrlArw0/v5fPq1hNce3ZJy6XKRPA/38B5yh/4mVHpQSB9/JkKRhka02VET0BgQJmsy
 gPU9U4NA9Jf9gD7m4g9yUEiAyiKGDVbGkhRxUNF+YaDwt/91cayzrRncJjMHOn3NGSdkGSCZB88Qd
 t5HccnNSUD+q2L1HotSUBRt0i0REXsbkgHbjhMx1rIsr3z/rQ5esVWy/ljp4qRmH8uuWpgY20XfhI
 Kgqcd5Kg4w4KXokx/IyxYPqz1yWWs5krxSKQHWJcFKWRW095uayOjdtnZr+hscPZgHh2QqUyVfj/k
 C35/vYUg==;
Received: from [2600:8803:e7e4:1d00:d956:6ab3:7240:6bd9] (port=44150
 helo=[127.0.1.1]) by vern.gendns.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <david@lechnology.com>) id 1uXltE-0000000073t-1TuJ;
 Fri, 04 Jul 2025 15:15:36 -0400
From: David Lechner <david@lechnology.com>
Date: Fri, 04 Jul 2025 14:15:20 -0500
Subject: [PATCH] configs: legoev3: adjust to reduce binary size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-b4-configs-legoev3-use-thumb-instructions-v1-1-6749cc9ecb45@lechnology.com>
X-B4-Tracking: v=1; b=H4sIAEcoaGgC/x3NTQqDMBBA4avIrDsQY/zBq5QuNI5xoE0kk0hBv
 LvB5dt87wShyCQwVidEOlg4+BL1qwK7Td4R8lIatNKt6pXB2aANfmUn+CUX6GgwC2Ha8m9G9pJ
 itqkggrR0ZpgGXbemgeLtkVb+P6/357pu216wlHsAAAA=
X-Change-ID: 20250704-b4-configs-legoev3-use-thumb-instructions-ed648a821543
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <david@lechnology.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831; i=david@lechnology.com; 
 h=from:subject:message-id;
 bh=MeReC5F+BqbJDbgsuauPWdv2EGtWIURqA5jl+rjJ9wY=; 
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoaChRQUSOR+ik0cqNSJdmJ4mY6LduHAlqF8R2l
 ZVVRsj5T4yJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGgoUQAKCRDCzCAB/wGP
 wI8ICAChY8F3/KcrlHDzSpdpqYn9xrY/TfBCELEzG1x9/WcLjvPJUXCWTYzMRw7cevlXpHkvF+b
 JURWu0Sxv/3tTWeXprdBDyPKHW0btQtwMflDD1slyBdRyMSme6ttt++hOnvnyhm2FzjS/qaidzs
 pwHz1GLwaMxDXEdBYC6QTVxUNrLicqNXoEwNEHvvopKBbxlxC6s+GIZ8d5lU6ryW+WgEy4Lg/oS
 xbLXXSmC4Y/A4aYwHXKQKtghcH/WaUFRRSVybkjfrlL+R+wGVnQ+ELsr5E2QVUB3V6x/j5afqUC
 LiohObhhcDX8vnwLPlpiIaOe4Crs5Es95dl1NJbYGKD487Nk
X-Developer-Key: i=david@lechnology.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Adjust legoev3_defconfig to reduce the binary output size.

As u-boot has bloated a bit over the years, the legoev3_defconfig can no
longer build something that fits in the 256kB size limit of the EV3.
This drops a few unused features, but the real difference-makers are
enabling thumb instructions and using link time optimization to reduce
the size.

This reduced u-boot.bin from 279,920 to 198,416 bytes on my local
machine with arm-none-eabi-gcc (15:13.2.rel1-2) 13.2.1 20231009.

Signed-off-by: David Lechner <david@lechnology.com>
---
 configs/legoev3_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/legoev3_defconfig b/configs/legoev3_defconfig
index 60b7a84205c0fef1ffed39de7b7c1a3d5cdff217..e234894bcce2a74121d0ca1128faebac0eefa8ca 100644
--- a/configs/legoev3_defconfig
+++ b/configs/legoev3_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_DAVINCI=y
 CONFIG_TEXT_BASE=0xc1080000
 CONFIG_SYS_MALLOC_LEN=0x110000
@@ -12,6 +13,7 @@ CONFIG_SF_DEFAULT_SPEED=50000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_DEFAULT_DEVICE_TREE="da850-lego-ev3"
 CONFIG_SYS_LOAD_ADDR=0xc0700000
+CONFIG_LTO=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
@@ -31,7 +33,6 @@ CONFIG_HUSH_PARSER=y
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
 CONFIG_CMD_ASKENV=y
-CONFIG_CRC32_VERIFY=y
 CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
@@ -56,4 +57,3 @@ CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_DAVINCI_SPI=y
-CONFIG_REGEX=y

---
base-commit: d1d53c252a4a746db5ebcdf0d6de3aa0feec504e
change-id: 20250704-b4-configs-legoev3-use-thumb-instructions-ed648a821543

Best regards,
-- 
David Lechner <david@lechnology.com>

