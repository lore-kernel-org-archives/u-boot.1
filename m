Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CB2CD68E5
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 09:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0721C86DC3;
	Tue, 10 Oct 2023 11:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QBbDlj3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C0786D85; Tue, 10 Oct 2023 11:03:23 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B394186DAF
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 11:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DCCCE0009;
 Tue, 10 Oct 2023 09:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1696928588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWqG/XaeypBiB35sFSuJ4gjOWF7y12bdiSFYRDXk3+s=;
 b=QBbDlj3wui8EFc95QjswqpcNTYehUx4fNKn+hxOzg4SxcCC0EiSeZw/fHpv5Ey405ezxgr
 BVPABDyX36FCFirWpxvK9eaaUtkJ1zVuKhk9ois+Obi+VC4jsRLD1Nb6OmtZSUlMrfe5Ap
 Ajt22ig+ppNFO6GvCn/N5cNYxQjh71ETJ/nEJrOMN7GgEVUz6xuaHqtUv9KUw07L/E1eLL
 TykiEvCJZgnFN3iRadSjq0PUGNE1Hl+M7F7GsfEuOSBk56KTwaxLXPDea98Xzn+uenEWjE
 LVkF06y7CWv9rDi7x38i1mw8/9JsSUzVZ7LLvvQuuUBfFeBn7cGlYOgqi2NrjQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Vasut <marek.vasut@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 2/3] cmd: bind: Try to improve the (un)bind help
Date: Tue, 10 Oct 2023 11:03:03 +0200
Message-Id: <20231010090304.49335-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010090304.49335-1-miquel.raynal@bootlin.com>
References: <20231010090304.49335-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
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

While it may sound totally obvious for the regular U-Boot developer to
get the parameters of the bind/unbind commands from the output of 'dm
tree', it did not felt straightforward to me until I was explicitly
told to look there. And even when I knew the command, I did not make a
direct link between the arguments of this command and the columns
returned by 'dm tree'.

Several of us lost a lot of time because of that, I would like to kindly
help other users by slightly improving this textual line. Unfortunately,
because of how this string is used (like within the 'help' command) I
cannot detail much more, but at least the pointer is there.

While we add this message, we can also imply CMD_DM when we enable
CMD_BIND so the debug message does not lead to an unknown command. This
way the 'dm' command will likely be there unless explicitly disabled.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 cmd/Kconfig | 1 +
 cmd/bind.c  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 6cc3bf6c2d0..668411fd87c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -996,6 +996,7 @@ config CMD_BCB
 config CMD_BIND
 	bool "bind/unbind - Bind or unbind a device to/from a driver"
 	depends on DM
+	imply CMD_DM
 	help
 	  Bind or unbind a device to/from a driver from the command line.
 	  This is useful in situations where a device may be handled by several
diff --git a/cmd/bind.c b/cmd/bind.c
index 4d1b7885e60..be0d4d2a711 100644
--- a/cmd/bind.c
+++ b/cmd/bind.c
@@ -246,6 +246,8 @@ U_BOOT_CMD(
 	"Bind a device to a driver",
 	"<node path> <driver>\n"
 	"bind <class> <index> <driver>\n"
+	"Use 'dm tree' to list all devices registered in the driver model,\n"
+	"their path, class, index and current driver.\n"
 );
 
 U_BOOT_CMD(
@@ -254,4 +256,6 @@ U_BOOT_CMD(
 	"<node path>\n"
 	"unbind <class> <index>\n"
 	"unbind <class> <index> <driver>\n"
+	"Use 'dm tree' to list all devices registered in the driver model,\n"
+	"their path, class, index and current driver.\n"
 );
-- 
2.34.1

