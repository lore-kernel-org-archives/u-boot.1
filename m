Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBE2FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 10:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC2684658;
	Tue, 28 Apr 2026 12:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="F4H/Ms54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29DA384664; Tue, 28 Apr 2026 12:24:35 +0200 (CEST)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C805D845C8
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g4c4H3gRFzJVk;
 Tue, 28 Apr 2026 12:24:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777371871;
 bh=YS32itU25xk6AWiKTQvD7dcxqNwjKkKX3S1+LUB061E=;
 h=From:Date:Subject:To:Cc:From;
 b=F4H/Ms54VLmfokql78dZ0I+8xV5Vixqav6hwP7YDiRoGfNiB/cIvlKhnBofHlRntg
 uRAsqUklsxhjryMZDmguGuBEhsH3uhlRZQS8ki9p1lEbmW2062SPoJj0N5IDPJxW+y
 44IOJsDb5mWoIDrbeGbY6ieg8/4PGl/XAnrlEj6XKqFgWv0vWp25NtWes6QMzy8fUc
 RVCLEfmouMzuDNzB9beYya8DA93dZJZbDRaQnLmfgzH9af/NnOFoy3Bc4RgGCF6580
 AkSI9EI2yHHYmSIQZqxHGU00XJz1lL0Yg7x0YdDVLUL17RnyvJQCfju0aemaBlK39R
 S5lbB6ewtAdOw==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g4c4G3WG5zHGW; Tue, 28 Apr 2026 12:24:30 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 28 Apr 2026 12:24:21 +0200
Subject: [PATCH] doc: bootstd: specify CONFIG_BOOTSTD_DEFAULTS provides
 network features when NET=y
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-doc-net-bootstd-v1-1-f5a939f1686c@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxA0asgz1iCUArqVVAHEptihqSKQ4WEu
 HsDjG/4fwflKKzwKnaI/BOV4DPqsgA3j/7DKJQNpjLP6mF6pODQc0IbQtJE2HXUNsbxWFuCXH0
 jT7Jdx+F9W1e7sEvnBo7jD6UPRadzAAAA
X-Change-ID: 20260428-doc-net-bootstd-77d532cea1bd
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Martin Schwan <m.schwan@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
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

In the past, we only had one network stack which was called NET. The
network features were enabled for the legacy (and then only) networking
stack since commit 22353fa6b585 ("bootstd: Add some default filesystems
and commands"). Then instead on relying on NET legacy stack for enabling
networking features, the dependencies were (mostly) changed to depend on
CMD_NET in commit a0c739c184ca ("boot: Create a common BOOT_DEFAULTS for
distro and bootstd"). Then a new stack (lwIP) appeared, then CMD_NET was
made available with this new stack in commit 98ad145db61a ("net: lwip:
add DHCP support and dhcp commmand") making the networking features
possible to enable and finally commit f1e978fd54d9 ("boot: Update tests
around network symbols in BOOT_DEFAULTS_CMDS") made it explicit that we
need *a* network stack to enable some networking features.

Align the bootstd documentation with what's actually implemented as
Kconfig dependencies. Note that BOOTSTD_DEFAULTS selects BOOT_DEFAULTS
which selects BOOT_DEFAULTS_CMDS which then selects network features.
The CMDLINE symbol needs to be enabled as well for BOOT_DEFAULTS to
select BOOT_DEFAULTS_CMDS, but I don't think we need to go that far into
explaining what's required to enable some commands.

Reported-by: Simon Glass <sjg@chromium.org>
Closes: https://lore.kernel.org/u-boot/CAFLszTgZC1FGy8965pHiG-u=FhrguftRv41ghQ_Qb_RRXx6tyg@mail.gmail.com/
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/bootstd/overview.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 99ff7d6192d..397f6db18b4 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -422,7 +422,7 @@ includes the full set of commands, more error messages when things go wrong and
 bootmeth ordering with the bootmeths environment variable.
 
 You should probably also enable `CONFIG_BOOTSTD_DEFAULTS`, which provides
-several filesystem and network features (if `CONFIG_NET_LEGACY` is enabled) so that
+several filesystem and network features (if `CONFIG_NET` is enabled) so that
 a good selection of boot options is available.
 
 Some devicetree properties are supported in the bootstd node when

---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260428-doc-net-bootstd-77d532cea1bd

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

