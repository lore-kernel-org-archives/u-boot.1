Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736F0C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 15:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA960841F2;
	Sun,  5 Jul 2026 17:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ku5uTJXm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ptAvwWEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A838B846F8; Sun,  5 Jul 2026 17:54:21 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0101383314
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 17:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gtX9Q1tvyz8txg;
 Sun, 05 Jul 2026 17:54:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783266858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ea2C++RubZRVX5J/ihJqfOtTqAUtLlDSNe/xEjjmbvU=;
 b=ku5uTJXmRS88WRgwe0zSCtQOw590iy6FkD1OZE71vcJvZVu3IrvTsHJTxZtAXg3fRJFtON
 f6zBg4dFcRdlAocN5sjhtOe1ye4jOekh6PbfgJV9FERVLkpKibi+FX3qqbPIkLZUHgvjhh
 bOpHSRR37Ubg9pUwYgdO11kSMffK/lJjGa/NR0R1XEuGHiQzYuUbBEwBvDUCBGe+5HiT35
 +yTWMjRwdjlPzSgcNyGCdW2CPSGN+gqt5E9FT0gZ27g9qsKVxcUBLxC3ZpogD8XP7YPOhU
 dBmik6ZvxqyoxsfhNDO4OVcDNnZ8z4+fsedSduNn4qtlKUCAznCVXUYb7rE3ww==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ptAvwWEc;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783266856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ea2C++RubZRVX5J/ihJqfOtTqAUtLlDSNe/xEjjmbvU=;
 b=ptAvwWEcvXMulMH1HPbNQMyc/6wBtnyBrRprwEnEqZypUM1VqPo6iKUQelHrMEj9tCdlfB
 7VfwIeMt9BoXYVcpSzvD+YBKVqd51DREO7Vv5zZ7RfPWBbmvhRJzG2YGK4iGIh9nxFbnvS
 2+eedVsz6f5muDeDrl6b8Yo5Ypjre2GlZ2UyKiAexA3v1DLOHZW4bGx31nTfKcm1SMH8qw
 60RdT6Fgxfe6owgMsCC2O/Gnka0iQFhcMBF0x4+4zYOglHxxnJ0CDERTJ+Ai5HSlFM2+SD
 MBo2UrOZGmce+7pwOdkX3Lf8190wM2UzzXopEIDXeAE9gl3ffeCcTX2hZ1mdZw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] MAINTAINERS: Update SH/SoCFPGA/USB email addresses
Date: Sun,  5 Jul 2026 17:52:24 +0200
Message-ID: <20260705155411.48333-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rqbzzcnamniw6k8gxg836addzr4apu98
X-MBO-RS-ID: 35f60329a5b1e7f6db1
X-Rspamd-Queue-Id: 4gtX9Q1tvyz8txg
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

Update the email addresses to a valid one.
Use N: usb to match on all USB related bits.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
---
V2: Fix mailmap
---
 .mailmap    |  7 ++++---
 MAINTAINERS | 12 ++++--------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/.mailmap b/.mailmap
index 76ba0a7fea3..8035490a19a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -85,9 +85,10 @@ Love Kumar <love.kumar@amd.com> <love.kumar@xilinx.com>
 Lukasz Majewski <lukma@denx.de>
 Marek Behún <kabel@kernel.org> <marek.behun@nic.cz>
 Marek Behún <kabel@kernel.org> Marek Behun <marek.behun@nic.cz>
-Marek Vasut <marex@denx.de> <marek.vasut+renesas@gmail.com>
-Marek Vasut <marex@denx.de> <marek.vasut@gmail.com>
-Marek Vasut <marex@denx.de> <marex at denx.de>
+Marek Vasut <marek.vasut+renesas@mailbox.org> <marek.vasut+renesas@gmail.com>
+Marek Vasut <marek.vasut+uboot@mailbox.org> <marek.vasut@gmail.com>
+Marek Vasut <marex@nabladev.com> <marex at denx.de>
+Marek Vasut <marex@nabladev.com> <marex@denx.de>
 Markus Klotzbuecher <mk@denx.de>
 Masahiro Yamada <masahiroy@kernel.org> <yamada.m@jp.panasonic.com>
 Masahiro Yamada <masahiroy@kernel.org> <yamada.masahiro@socionext.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 45e9076de67..d92d3951dc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -162,7 +162,7 @@ F:	arch/arm/dts/Makefile
 F:	cmd/arm/
 
 ARM ALTERA SOCFPGA
-M:	Marek Vasut <marex@denx.de>
+M:	Marek Vasut <marek.vasut+socfpga@mailbox.org>
 M:	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
 M:	Tien Fong Chee <tien.fong.chee@altera.com>
 S:	Maintained
@@ -1726,7 +1726,7 @@ F:	cmd/printf.c
 F:	doc/usage/setexpr.rst
 
 SH
-M:	Marek Vasut <marek.vasut+renesas@gmail.com>
+M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
 M:	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-sh.git
@@ -1939,14 +1939,10 @@ F:	test/boot/upl.c
 F:	test/py/tests/test_upl.py
 
 USB
-M:	Marek Vasut <marex@denx.de>
+M:	Marek Vasut <marek.vasut+usb@mailbox.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-usb.git
-F:	drivers/usb/
-F:	common/usb.c
-F:	common/usb_kbd.c
-F:	common/usb_storage.c
-F:	include/usb.h
+N:	usb
 
 USB TCPM
 M:	Sebastian Reichel <sebastian.reichel@collabora.com>
-- 
2.53.0

