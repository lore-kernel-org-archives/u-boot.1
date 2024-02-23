Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDFAC54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 17:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2FA7878E2;
	Fri, 23 Feb 2024 18:14:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="ysMqpVV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5FC38791E; Fri, 23 Feb 2024 18:14:27 +0100 (CET)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF4B8744F
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 18:14:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivan.orlov@codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zSeRyxgkNQxvN9KUMDs+14XehiKHpqN7reuxuWRt6/Q=; b=ysMqpVV9HztQORzNpFvh9PvPeQ
 Snv8o/PxcHJiXv5A1EuUM4aXQYvJHg3UiVmMlP57Su+TKUVpVLyajKx5P67W44ij1TV6ZRIke73vY
 wt32DcGXi35KiLJuv+loO1kfLph0RoBR/aFB2SG9ASZeXr/b+flqbEeJD7oiFIhkns90lw1G9e7hx
 pJmREW94Z8DqvYmZs9EEKm3YEEZWpo7BJfTQhy+wYbpsxEadBGRy4qwEnz4tIeHlXvwCLcs/EQOfC
 EKRCR+0MhCcbA7YvLVovCyz4OqH2evZMrUGaZqDa/D+Z8fenKV5IFP3VdnZk9FhZlStr27coacYxF
 gd4qLKVA==;
Received: from [209.35.92.67] (helo=ct-lt-2504..)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1rdZ7u-004cuw-Em; Fri, 23 Feb 2024 17:14:22 +0000
From: Ivan Orlov <ivan.orlov@codethink.co.uk>
To: trini@konsulko.com
Cc: Ivan Orlov <ivan.orlov@codethink.co.uk>,
	u-boot@lists.denx.de
Subject: [PATCH v2] cmd: eeprom: Fix config dependency
Date: Fri, 23 Feb 2024 17:14:20 +0000
Message-Id: <20240223171420.9492-1-ivan.orlov@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
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

We should have CONFIG_DM_I2C or CONFIG_SYS_I2C_LEGACY enabled in
order for `cmd/eeprom.c` to compile as it depends on the i2c functions
which are not compiled otherwise. Update the Kconfig entry for the
'eeprom' command correspondingly.

Signed-off-by: Ivan Orlov <ivan.orlov@codethink.co.uk>
---
V1 -> V2:
- Remove redundant SYS_SPL_I2C_LEGACY dependency as we can't realy
enable commands in the SPL mode

 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a86b570517..5d68a461cf 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -740,6 +740,7 @@ config CRC32_VERIFY
 
 config CMD_EEPROM
 	bool "eeprom - EEPROM subsystem"
+	depends on DM_I2C || SYS_I2C_LEGACY
 	help
 	  (deprecated, needs conversion to driver model)
 	  Provides commands to read and write EEPROM (Electrically Erasable
-- 
2.34.1

