Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072E5CD5BCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9214C83DF7;
	Thu, 13 Nov 2025 12:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OnoS6Zln";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kpVlhEzA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D09A83E0B; Thu, 13 Nov 2025 12:58:20 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 991DC83D13
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d6f1623W9z9spJ;
 Thu, 13 Nov 2025 12:58:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763035098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BIPyYJ15scc4EQy3Smx3GT4YDhkaghNc4X6F3inttBk=;
 b=OnoS6ZlnXqWyFupRQO1dmjkTNLIwJ+c54oNNtG8+/Iyra/NinA7U9JZTVtNZ5eL0D4TIRy
 5hvjkfwEARbA2Enkb65NsUJbxWkRXU24mI1D138VTNcUyTngvLbn/c+2j+SkQae0V2FtOo
 u1Vo5SMjWhc9lavDmpH8/sLdJRI6yFut0SmzdahX0kPasf8wR7RUkuu38Hy51Scw14+ED6
 HB9eMxZCWKa7zHYPajIp8un8LQQnFDS5xrUsyicm4xugOW/wnZxDyF8fnPGTCRFkaOw6p9
 5wbjzDBrTruqb5kle0z+PMjQ0pYO+hE7Jsya/UQNI8YrgwLRfAOzcaOpNJL2zw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=kpVlhEzA;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763035096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BIPyYJ15scc4EQy3Smx3GT4YDhkaghNc4X6F3inttBk=;
 b=kpVlhEzARLNXx3UN8Sc9lOF9jNxsN/SoYuWY1BmoFmOKPObDhd1QMPKElp8OOb5HkK7MSF
 Cld9UVB7fS2sKKpDqVfhS7AyPtEOarfVu09wY0M0SB80liM0aRsoOIiKXyNtMc4dSQXPZu
 3c8lk9TvluRoqmUhwT8n+pcfdRHNJ0HHZ60BQdOUcM09v4QJmpJqMwh8ah9kO1puxmopHP
 WuiBVzwmXvCyiiBS1B0culyVaE+bYxe3yJarJzmhr1CmcTppT+N52gWTvei+7RJRDkVHux
 EgVoyYjoRPuxhna7yYM4hgcinqeJKPXSLTVvh3EB68xRUn8QI24zmghU1r1pGQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] test/py: Use aligned address for overlays in 'extension'
 test
Date: Thu, 13 Nov 2025 12:57:52 +0100
Message-ID: <20251113115811.947992-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0bf970865df4919abe8
X-MBO-RS-META: soxb73rj8yasqsamsefj9je3hxxz9tbj
X-Rspamd-Queue-Id: 4d6f1623W9z9spJ
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

The 'extension' test would set 'extension_overlay_addr' variable to
decimal 4096 due to conversion in python. The 'extension_overlay_addr'
is however sampled using env_get_hex("extension_overlay_addr", 0);
which converts the 4096 to 0x4096 and uses that as DT overlay address,
which is unaligned. Fix this by setting extension_overlay_addr to 0x1000
as intended, which is aligned.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Use only %x
---
 test/py/tests/test_extension.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_extension.py b/test/py/tests/test_extension.py
index 61223496054..6daab0c9782 100644
--- a/test/py/tests/test_extension.py
+++ b/test/py/tests/test_extension.py
@@ -38,7 +38,7 @@ def test_extension(ubman):
     assert('overlay1.dtbo' in output)
 
     ubman.run_command_list([
-        'setenv extension_overlay_addr %s' % (overlay_addr),
+        'setenv extension_overlay_addr %x' % (overlay_addr),
         'setenv extension_overlay_cmd \'host load hostfs - ${extension_overlay_addr} %s${extension_overlay_name}\'' % (os.path.join(ubman.config.build_dir, OVERLAY_DIR))])
 
     output = ubman.run_command('extension apply 0')
-- 
2.51.0

