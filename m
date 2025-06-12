Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DEBC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 11:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D7C082CB6;
	Thu, 12 Jun 2025 13:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bHzHxPeM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 692A9828A2; Thu, 12 Jun 2025 13:39:10 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B00282C7F
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 13:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55CBd2hx1675380;
 Thu, 12 Jun 2025 06:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749728342;
 bh=8b3mdcSQJlhZMUVM2kqKKlYylA/Qw9o/Bq04K98mVVI=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=bHzHxPeMQtolRptDCMeTOAkZk+PJN2a/X8AmWsznJP3DKVTX/4ZV/bfVcokwB0nS/
 /BougKoZnmPyam2ubTqDO8Q2xPO90RyOdIinWIJ4w4WCmljydeXn3QKu5dg0ufBH/J
 K7DaX3nsg8dhxSMiARtROvhEEJw99qq9Zaumnp7U=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55CBd2cW3606968
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 12 Jun 2025 06:39:02 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 06:39:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 06:39:02 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55CBd21p2099279;
 Thu, 12 Jun 2025 06:39:02 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Thu, 12 Jun 2025 06:38:50 -0500
Subject: [PATCH -next v2 1/5] binman: alphabetize missing-blob entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250612-missing-blob-help-entries-v2-1-36f1c8078155@ti.com>
References: <20250612-missing-blob-help-entries-v2-0-36f1c8078155@ti.com>
In-Reply-To: <20250612-missing-blob-help-entries-v2-0-36f1c8078155@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3203; i=bb@ti.com;
 h=from:subject:message-id; bh=uaI6ZIbAGIbxygIyBO6H7T2aZTOKZbcSvTTLYxr9yHo=;
 b=owNCWmg5MUFZJlNZUiyIowAAaX///77vfu/z/+rlnZftPf1XfFTv8zfvGn7Vx+7f2/Lcy8awA
 RsMIeoMRoaAaAA0NAyaBtBNAaAAADRoeoBkZAZA0AAaaMgHqGIB7VDaTwodGgNDQ0AaADQANDQ8
 pkADQPSNDRoGjIGQNDQHpGjRtT1ND1DZRobU0NomhoNMhyaegJpiZANGjIxBkA0yBoGQyaYTTQZ
 GTTQAaA0wRhMjQANAAaBiNNMIAAWYpCFx5EYKG5VOTCwWyh/BktMgNBVfkDkNLwKMbskQgAyP5r
 FKbCrUOD0JHaVM4Tp5KqQxABzEbAosdhreDVc8OhdQDQ188DvSyAyXDUB+Vo/oSJGUuShDhlKlb
 5MKyCUqhgnh9e2nxdE+WZfBnlTsfQsqYIhnZlHirxTBZRMZXFz9Au1D97ReQ5QrV0usSOW2gCxv
 6yM3KudIIUK7V0XO3lbKDvSVII5dbTdO6zCgm4bocQNa4TG+3md7B5V+Bx5jLPZ4+YmSYKH+9/K
 EkP1odNE3pRRuNevhuRZsDCyaimxln8PbK3TelBTPDcbVdT6L+d9vGzUpQcwCUR8EI+bQzfzKHC
 BZYYobEcYIAjC+ai8PqONC5IZAcgUFxRbqwYWZPiyaKXdV2e5BDZAxhyXPzLtDRcGfELCMlLuou
 P/xdyRThQkFIsiKMA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

As the list of entries grows let's alphabetize the list to make
searching a little easier. No functional changes intended

Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 tools/binman/missing-blob-help | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
index ab0023eb9fb59fb84757770bcec4993d8351e9fb..b73b16f18491c2b45300ee4734d0f57eebb5635b 100644
--- a/tools/binman/missing-blob-help
+++ b/tools/binman/missing-blob-help
@@ -14,15 +14,6 @@ atf-bl31-sunxi:
 Please read the section on ARM Trusted Firmware (ATF) in
 board/sunxi/README.sunxi64
 
-scp-sunxi:
-SCP firmware is required for system suspend, but is otherwise optional.
-Please read the section on SCP firmware in board/sunxi/README.sunxi64
-
-iot2050-seboot:
-See the documentation for IOT2050 board. Your image is missing SEBoot
-which is mandatory for board startup. Prebuilt SEBoot located at
-meta-iot2050/tree/master/recipes-bsp/u-boot/files/prebuild/seboot_pg*.bin.
-
 iot2050-otpcmd:
 See the documentation for IOT2050 board. Your image is missing OTP command data
 block which is used for provisioning the customer keys to the board.
@@ -31,22 +22,31 @@ meta-iot2050/tree/master/recipes-bsp/secure-boot-otp-provisioning/files/make-otp
 for how to generate this binary. If you are not using secure boot or do not
 intend to provision the keys, disable CONFIG_IOT2050_EMBED_OTPCMD.
 
+iot2050-seboot:
+See the documentation for IOT2050 board. Your image is missing SEBoot
+which is mandatory for board startup. Prebuilt SEBoot located at
+meta-iot2050/tree/master/recipes-bsp/u-boot/files/prebuild/seboot_pg*.bin.
+
 k3-rti-wdt-firmware:
 If CONFIG_WDT_K3_RTI_LOAD_FW is enabled, a firmware image is needed for
 the R5F core(s) to trigger the system reset. One possible source is
 https://github.com/siemens/k3-rti-wdt.
 
-rockchip-tpl:
-An external TPL is required to initialize DRAM. Get the external TPL
-binary and build with ROCKCHIP_TPL=/path/to/ddr.bin. One possible source
-for the external TPL binary is https://github.com/rockchip-linux/rkbin.
-
-tee-os:
-See the documentation for your board. You may need to build Open Portable
-Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
-
 opensbi:
 See the documentation for your board. The OpenSBI git repo is at
 https://github.com/riscv/opensbi.git
 You may need to build fw_dynamic.bin first and re-build u-boot with
 OPENSBI=/path/to/fw_dynamic.bin
+
+rockchip-tpl:
+An external TPL is required to initialize DRAM. Get the external TPL
+binary and build with ROCKCHIP_TPL=/path/to/ddr.bin. One possible source
+for the external TPL binary is https://github.com/rockchip-linux/rkbin.
+
+scp-sunxi:
+SCP firmware is required for system suspend, but is otherwise optional.
+Please read the section on SCP firmware in board/sunxi/README.sunxi64
+
+tee-os:
+See the documentation for your board. You may need to build Open Portable
+Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin

-- 
2.49.0

