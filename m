Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3B2D20686
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 23:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 397418899C;
	Wed, 16 Oct 2024 01:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729035914;
	bh=OijfXerhEiNYqx4IXkXV1ZENdgkpFviHeNQaTukLghU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XdkUDLroWi74PCW6KFO/TCimOjlZg4vbj9Yqusud8yMq9tiYN+od+vEqLvc3o/fa7
	 dBQo3SnR0OaC0jc8hazsCA29+Vl75sQ34Ru4KzUIQEZbEI9T5/ioUc3LoAYBRSOL58
	 v+/Sq/YwAol+O8dgVP1FO9v1QnKjYEMZzRZAMAc3SG7hmJJISRsHIk+9IALE7z4Fnm
	 oUuVsaOgZizddsiFbzL2aUgV3IX4/cE5pS5knMVVhNr3DOrVr8KAqlsn9csxu8a8vs
	 mig3pBuSVDmfzpMZ/L0Xda1TOAzcPqe7KksZOsgxS0dsvt8/1Gg50zCJN/yQZhYfRX
	 KlanCF1LtqNug==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EB1F888216;
 Wed, 16 Oct 2024 01:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729035912;
 bh=OijfXerhEiNYqx4IXkXV1ZENdgkpFviHeNQaTukLghU=;
 h=From:To:Cc:Subject:Date:From;
 b=BD5EzEF6p5Xawwc/j2iXMZjj119k+eNVQhLL/Kuy/qHTwl2JpzbX2FWAay8JHS4UP
 4OW6E6bcf5tJSQ3XKuCWsyldOxVh06XczDxpjVH+HJa/wUw6Q2REKvrmmnFsqyd8Ba
 3LP/ky16z2EUtB0uqPY9uxOfnsaO+zq0oM4fyYGigYhedQBesMxtenW70H6uH1BRTY
 qN5fFIlblReVIO9WB4RpEUygFiA/rKZ4MO3iC+eeWnHPSMG9c+kfbhQf1E5358S+ti
 YsNYOUtbLjPw0QqVSdinEPI4/DpAEAmiLbCcH7bbztM2qOcHFV3yVwVI/S4bvwFrvF
 UZMFHbgZUNSjg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH] ARM: dts: imx6-dhcom: Remove fdt_high and initrd_high env
 variables
Date: Wed, 16 Oct 2024 01:44:32 +0200
Message-ID: <20241015234502.129086-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Remove both "fdt_high" and "initrd_high" environment variables
in favor of "bootm_size" to safely contain a kernel, device tree
and initrd for relocation inside of 256 MiB region of DRAM.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
NOTE: If mainline Linux does not boot, this is the prime suspect.
      Non-8-byte aligned DT address is then a dead giveaway:
      Booting using the fdt blob at 0x126d6bac
                                             ^
---
 include/configs/dh_imx6.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/configs/dh_imx6.h b/include/configs/dh_imx6.h
index 9b6f03f6856..09354936d73 100644
--- a/include/configs/dh_imx6.h
+++ b/include/configs/dh_imx6.h
@@ -36,10 +36,9 @@
 #endif
 
 #define CFG_EXTRA_ENV_SETTINGS	\
+	"bootm_size=0x10000000\0"	\
 	"console=ttymxc0,115200\0"	\
 	"fdt_addr=0x18000000\0"		\
-	"fdt_high=0xffffffff\0"		\
-	"initrd_high=0xffffffff\0"	\
 	"kernel_addr_r=0x10008000\0"	\
 	"fdt_addr_r=0x13000000\0"	\
 	"ramdisk_addr_r=0x18000000\0"	\
-- 
2.45.2

