Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B8BC71141
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 18:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ED9982C8D;
	Wed, 11 Jun 2025 20:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EBXM5RcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF45382B7C; Wed, 11 Jun 2025 20:17:45 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B46182B70
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 20:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55BIHcnp1451919;
 Wed, 11 Jun 2025 13:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749665858;
 bh=4GfY+4aDlGRIW1xo6QWETuJlZsY3hl88Nw9dwmehsxE=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=EBXM5RcDMYlRH0hhaPTRbj5zml4XcLjUFzjdwIZOGfoRjzKN+EcioYuVsKsBC2d3T
 oY/SPfOTVWnz41UPgJNpSrAhR0sGJfTfv83jCXAe+OCh0gaceJ598qyFltQAEQelYx
 7FyxbHTpWCbNRarSn31FbrbeQ129s8CIbuIh/ZJI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55BIHcgA1203174
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 11 Jun 2025 13:17:38 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Jun 2025 13:17:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Jun 2025 13:17:38 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55BIHcC9901669;
 Wed, 11 Jun 2025 13:17:38 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 11 Jun 2025 13:17:32 -0500
Subject: [PATCH -next 1/5] binman: alphabetize missing-blob entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250611-missing-blob-help-entries-v1-1-c6de1844117f@ti.com>
References: <20250611-missing-blob-help-entries-v1-0-c6de1844117f@ti.com>
In-Reply-To: <20250611-missing-blob-help-entries-v1-0-c6de1844117f@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
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

