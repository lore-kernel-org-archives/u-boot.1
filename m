Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D116ACE7A81
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 23:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D7D0864AA;
	Sat, 23 Sep 2023 01:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ef0QszZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3455B8654D; Sat, 23 Sep 2023 01:35:34 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 541EA86290
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 01:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 51ED63F704; 
 Fri, 22 Sep 2023 23:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1695425731;
 bh=qkPXodTIyh+UrNhL+O17lKsG7j4GuGk8PLUFAX6U7X8=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=ef0QszZTHP9led1VDj0szSN+bKl0wHlAg8QEiJU1+S+twRW/MeAqOes8CgFOXBWag
 ZzlsgWuTSNGwYoFnTfQWKB6fgPo43MUg1gGV354V485aLY3buLx/3n6LaCiWAbmlQR
 LDuKfDTZXFVh/K111GC7baOt7jMD9Od7e2xxeWJPwEND/L9mSnrO9EBZAUPLuTPFrv
 XSSHoMa7Jv2qPAZ0rLf6DcLv3oqD5Ewvu/B0DE9lUq2WupEo9zi4TsR2fLF3gBMDsZ
 FP0Fewfvy0z5RMHOQICZzgAvMqgvr2WY09qJty2lh6/xEQa9H+xx3Il3DZM1GMs88c
 PS1QgjciJPk/Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: enable CONFIG_DEBUG_UART by default
Date: Sat, 23 Sep 2023 01:35:26 +0200
Message-Id: <20230922233526.62642-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Most boards don't enable the pre-console buffer. So we will not see any
early messages. OpenSBI 1.3 provides us with the debug console extension
that can fill this gap.

For S-Mode U-Boot enable CONFIG_DEBUG_UART by default.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 1c62c2345b..06fae7ebe8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -141,6 +141,7 @@ config RISCV_MMODE
 
 config RISCV_SMODE
 	bool "Supervisor"
+	imply DEBUG_UART
 	help
 	  Choose this option to build U-Boot for RISC-V S-Mode.
 
-- 
2.40.1

