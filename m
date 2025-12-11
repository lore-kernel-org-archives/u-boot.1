Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051B3D41D69
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 596C583A28;
	Thu, 11 Dec 2025 17:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="E3n1OBKD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A3E6830E4; Thu, 11 Dec 2025 17:35:04 +0100 (CET)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 418418334F
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20251211163501a05ccea9ff00020704 for <u-boot@lists.denx.de>;
 Thu, 11 Dec 2025 17:35:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=h02BlDQ5cMNRPuZdnzhVwIoO5RavaBsBKNWHkvODayw=;
 b=E3n1OBKDit3BJJy0C4ApuFO3MWF4c/XRog24GyYrFxEWlcOKs0wq9goZOMMbYw9sD9lIr1
 yx6oBYDTbGQAnUw/USDpdz2arpl6qfoOmR2I9V3wf0khpFPriInPaMLiaygRjb/yYrw6yWhJ
 rdEob0k8KgEEbpnzxC4a+As0E9PNH/VjveNGfFg5OXeVWwSAWTw7AgEFen/fNLomMrsVYx8s
 nR7Yolh3cXO0oUbeKW+cOeDcwn2GTYXur4hG6UYaKq+FDkV59lUAPw48hZYC8cqKbKw12KM4
 /GiWL58qkUWs0e/y3FUZpr7vLBJGexbtEls5JnUSlcfx0ar7mKOR51oQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH v3 5/5] configs: socfpga: Fix de0_nano_soc boot
Date: Thu, 11 Dec 2025 17:34:59 +0100
Message-ID: <69dfe7e155ee00f039a00dd52ae7968bed0b8c94.1765470899.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1765470899.git.jan.kiszka@siemens.com>
References: <cover.1765470899.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

By default, the de0_nano_soc used raw sectors, but the address became
invalid due the raw-mode refactorings. With loading via partition type
fixed, we can switch to that mode which is in line with what the ROM
loader does.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configs/socfpga_de0_nano_soc_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
index 32cdf6d3a6c..6564cbd03c6 100644
--- a/configs/socfpga_de0_nano_soc_defconfig
+++ b/configs/socfpga_de0_nano_soc_defconfig
@@ -28,6 +28,7 @@ CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
 CONFIG_SYS_MAXARGS=32
-- 
2.51.0

