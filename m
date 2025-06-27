Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0CBC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 13:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 283B88301F;
	Fri, 27 Jun 2025 15:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E417382E35; Fri, 27 Jun 2025 15:30:46 +0200 (CEST)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [83.166.143.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC8082E52
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 15:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bTGdl1gFWz248;
 Fri, 27 Jun 2025 15:30:35 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bTGdk43ryzkLq; Fri, 27 Jun 2025 15:30:34 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 27 Jun 2025 15:30:18 +0200
Subject: [PATCH 3/4] rockchip: ringneck-px30: enable "env erase" command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-tsd-eraseenv-v1-3-46b69659f879@cherry.de>
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
 configs/ringneck-px30_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index a6562d03edc96557428d51e2f73609ed3d230895..210bdca3edee1f9a9bda9ddb0a54b77098387dfc 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -40,6 +40,7 @@ CONFIG_SPL_ATF=y
 # CONFIG_CMD_VBE is not set
 # CONFIG_BOOTM_VXWORKS is not set
 # CONFIG_CMD_ELF is not set
+CONFIG_CMD_ERASEENV=y
 # CONFIG_CMD_LZMADEC is not set
 # CONFIG_CMD_UNZIP is not set
 CONFIG_CMD_BIND=y

-- 
2.50.0

