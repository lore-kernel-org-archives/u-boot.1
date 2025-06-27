Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCE1C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 13:31:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4301282E35;
	Fri, 27 Jun 2025 15:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 867EC82E35; Fri, 27 Jun 2025 15:30:40 +0200 (CEST)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fa9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D2DD82E9A
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 15:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bTGdj58N0z2Lj;
 Fri, 27 Jun 2025 15:30:33 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bTGdj0FLLzjyC; Fri, 27 Jun 2025 15:30:32 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 27 Jun 2025 15:30:16 +0200
Subject: [PATCH 1/4] rockchip: tiger-rk3588: enable "env erase" command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-tsd-eraseenv-v1-1-46b69659f879@cherry.de>
References: <20250627-tsd-eraseenv-v1-0-46b69659f879@cherry.de>
In-Reply-To: <20250627-tsd-eraseenv-v1-0-46b69659f879@cherry.de>
To: Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Erasing the environment to start from scratch is actually very useful
and "env erase" is the proper way to do it instead of using "env
default -a && env save", so let's enable support for it.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/tiger-rk3588_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
index c14bd9774e96fa2c2494d10a875d36365533863a..fb29cecd38e997f7b94951c8dab3085d3a6aba87 100644
--- a/configs/tiger-rk3588_defconfig
+++ b/configs/tiger-rk3588_defconfig
@@ -35,6 +35,7 @@ CONFIG_SPL_ATF=y
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
 # CONFIG_CMD_ELF is not set
+CONFIG_CMD_ERASEENV=y
 CONFIG_CMD_ADC=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y

-- 
2.50.0

