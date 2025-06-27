Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0A8C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 13:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF2183010;
	Fri, 27 Jun 2025 15:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F168182F83; Fri, 27 Jun 2025 15:30:43 +0200 (CEST)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::190b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD3DA82F5D
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 15:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bTGdk3ZvBz1ZN;
 Fri, 27 Jun 2025 15:30:34 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bTGdj63XxzllZ; Fri, 27 Jun 2025 15:30:33 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 27 Jun 2025 15:30:17 +0200
Subject: [PATCH 2/4] rockchip: jaguar-rk3588: enable "env erase" command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-tsd-eraseenv-v1-2-46b69659f879@cherry.de>
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
 configs/jaguar-rk3588_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
index 03d38274b15f78929c025154be0b7f1268574cfe..3b29270b2b0055c21a54ddf2dbb1c0860b0c60b6 100644
--- a/configs/jaguar-rk3588_defconfig
+++ b/configs/jaguar-rk3588_defconfig
@@ -34,6 +34,7 @@ CONFIG_SPL_ATF=y
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
 # CONFIG_CMD_ELF is not set
+CONFIG_CMD_ERASEENV=y
 CONFIG_CMD_ADC=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y

-- 
2.50.0

