Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B41C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 02:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D79CF88048;
	Tue, 19 Mar 2024 03:44:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710816293;
	bh=0TyCzzDTZEycThoV0l09H41/k147KRBbeEYZdXewaQA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l/PteOVkAO11Wom7tYXW/cgx+sAkXYTLVBlUxBWTjJWbO530d1WskA9ujFrlupoaL
	 36nrBdagJ+j7jwol7RyNG0P2IP5Sf88Oyf9XS52SGL4xTEg8rzULKOA3udKmlJQF4X
	 qhbcZSsHZrcQZRl44peZR7hh6ATLj0Mh1LC2UfVGRV8ggbhCsKpFlTL60CGUD54gJw
	 O0wY2yqo617oQjXWZ2wtztPIhanp7hYNHw1iOKr9e5BwbqbetcoTCAMfyyAt9FpG0H
	 trN1Mp58vTZKkFWgqZZR84q5SFXlsvS4WDaWugMofB4nrYhWYRO8VmMV2N1+WhXLKD
	 QcMOw4l9Qvb9A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DA70B8573F;
 Tue, 19 Mar 2024 03:44:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710816293;
 bh=0TyCzzDTZEycThoV0l09H41/k147KRBbeEYZdXewaQA=;
 h=From:To:Cc:Subject:Date:From;
 b=jTvCkeai4SsKxnO/fwr1aNlPgxpf+vMEZT4nTUEgbe7UXWWAp+9qNu8a6jg72hBZ1
 S9a1yxRSFSvx0GWQsFExze3ifOB/qmllUY601F/oPcCai1CmjsabeHWyi8Z3ug5YTU
 KR/Gd+CbwbJZUxs7muI084o6txb+cKYeE9wAsDVD5lQIfvh79YwAuV5jRwpwUD2vCr
 jVuEt670lEe5Qa67VxdubDdD0VuOo/fqDmCIquUUoilHquayy47vDacmtYogLTeYct
 eBt5E7z2RL5tFMsXKfpJFLZbufQKpRMnLIhkhCTfpiZmYc/zegMH1URVBobW/lA3Y/
 D2DyD0xFc83SQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Default dfu_alt_info for STM32MP13xx SPI NOR
Date: Tue, 19 Mar 2024 03:44:18 +0100
Message-ID: <20240319024430.103196-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Define dfu_alt_info with SPI NOR layout to make it easy to
install or update bootloader in the SPI NOR using dfu-util.

Use the following U-Boot commands to start DFU mode:
"
=> sf probe && dfu 0 mtd
"

Use the following dfu-util invocation on Host PC to install binaries:
"
$ dfu-util -w -a 0 -D build/stm32mp1/release/tf-a-stm32mp135f-dhcor-dhsbc.stm32
$ dfu-util -w -a 1 -D build/stm32mp1/release/tf-a-stm32mp135f-dhcor-dhsbc.stm32
$ dfu-util -w -a 2 -D build/stm32mp1/release/fip.bin
"

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 include/configs/stm32mp13_common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/stm32mp13_common.h b/include/configs/stm32mp13_common.h
index 5b0658ced92..d6e4f8fd915 100644
--- a/include/configs/stm32mp13_common.h
+++ b/include/configs/stm32mp13_common.h
@@ -63,6 +63,7 @@
 	"fi;\0"
 
 #define STM32MP_EXTRA \
+	"dfu_alt_info=mtd nor0=fsbl1 raw 0x0 0x40000;fsbl2 raw 0x40000 0x40000;uboot raw 0x80000 0x160000\0" \
 	"env_check=if env info -p -d -q; then env save; fi\0" \
 	"boot_net_usb_start=true\0"
 
-- 
2.43.0

