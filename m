Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380AAC25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 735C98871F;
	Tue, 21 May 2024 09:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PlszoA4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2A99886FF; Tue, 21 May 2024 09:13:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37ABF88713
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 10A896202A;
 Tue, 21 May 2024 07:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D016C2BD11;
 Tue, 21 May 2024 07:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716275629;
 bh=9CaGO6PB4D9Dv65Mn4OctTjpsfAtAnCrFCYQeipcZ5s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PlszoA4+lnRxVLUrWOJBJVUfWU1JNX0Jx3niJqAS6n2FrGMT57QqLQhF7P2vMkuNY
 +khSnogMT6GWGc2QaeeSc+CA64MpQrhUpsfVw1H2tcd8S8suFuj7cUhaemE/YgA/l6
 LoE1nEl3HjkK8jaiaqQd+wppM5xKS6kdBHXukp78uJHos82P6ioNrP00c65b21hg6s
 +1T6RSu+QcaMZwlelJY6GOMPQgMycX50KfRCQyGHdwxE+BM3y1idH2qzoOIzKDqvT/
 PqwFjSJMvEYxxN2xE35z9rf0n6aEcxMFaEsN4V8LprtgLYEOSr6ckhF8NbDOYAbk2M
 /hGuBQ7eyKEHw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 05/11] cmd: eeprom: Fix usage help for the eeprom command
Date: Tue, 21 May 2024 09:13:29 +0200
Message-ID: <20240521071335.4193-6-kabel@kernel.org>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240521071335.4193-1-kabel@kernel.org>
References: <20240521071335.4193-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The bus and devaddr arguments of the eeprom command are optional, and if
only one is given, it is assumed to be devaddr. Change the usage help
from
  <bus> <devaddr>
to
  [[bus] [devaddr]

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 cmd/eeprom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/eeprom.c b/cmd/eeprom.c
index 322765ad02..0d604832e4 100644
--- a/cmd/eeprom.c
+++ b/cmd/eeprom.c
@@ -418,14 +418,14 @@ int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 U_BOOT_CMD(
 	eeprom,	8,	1,	do_eeprom,
 	"EEPROM sub-system",
-	"read  <bus> <devaddr> addr off cnt\n"
-	"eeprom write <bus> <devaddr> addr off cnt\n"
+	"read  [[bus] devaddr] addr off cnt\n"
+	"eeprom write [[bus] devaddr] addr off cnt\n"
 	"       - read/write `cnt' bytes from `devaddr` EEPROM at offset `off'"
 #ifdef CONFIG_CMD_EEPROM_LAYOUT
 	"\n"
-	"eeprom print [-l <layout_version>] <bus> <devaddr>\n"
+	"eeprom print [-l <layout_version>] [[bus] devaddr]\n"
 	"       - Print layout fields and their data in human readable format\n"
-	"eeprom update [-l <layout_version>] <bus> <devaddr> field_name field_value\n"
+	"eeprom update [-l <layout_version>] [[bus] devaddr] field_name field_value\n"
 	"       - Update a specific eeprom field with new data.\n"
 	"         The new data must be written in the same human readable format as shown by the print command.\n"
 	"\n"
-- 
2.44.1

