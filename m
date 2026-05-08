Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C01CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 13:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18D7E84C81;
	Fri,  8 May 2026 15:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ysn72MX+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gGKCfRpe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 880E184C3C; Fri,  8 May 2026 15:51:09 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95F4484CBC
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 15:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBrB22hMkz9tTG;
 Fri,  8 May 2026 15:51:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778248266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rkHxRayKEytNwluiRAhlwh/wTK0FoS1MLLLdy+g/PiM=;
 b=Ysn72MX+4KLeTmCa+SyrIbytEqVkC4eFnl8bp2K7ea61aucSETo8Zuwtp4RvgG58uyV/gr
 1QZtZg7ObjfVY7El1mIjUgeLNYxDr8vopfWGQnus/y9WPkdgxAuG/FFR4tDpSvEa8YMbU7
 bw0F9gEJFWf/2tRpacnRrpylSj4kSMzC0AyUygfbTqIdCjMJ7MFsdTpETjh2IGLT5g7S1B
 anKu4TEY21nA8nXuJ3sc9FFkCvJ1duR8fg6rKGNoSnKk2PVcjJ6kQvi+3nph+K01soACF+
 6gGu93z78muFtt2TOfI/26XXJvA/duxRVQHpDA89p3BJCgdAmcHgVwd/RYfomg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=gGKCfRpe;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778248264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rkHxRayKEytNwluiRAhlwh/wTK0FoS1MLLLdy+g/PiM=;
 b=gGKCfRpePXtfgxdGUN7JcEh68rj2TXoFpIBprPBiCfTBaL50Typ3O6/mTtOz+VSsagG3oi
 7hlA0gz2GL5vYkuskelLFKFKvVQ/zLTDHcnOpm6ssfTd9cDOosE6GwqpWgL61e4R7pm7rK
 VmULRgOMs/Mw252pIf7nTUhAkJ7HHAf25TPfNldcxmeCb3eVcu2EZQUZ5O5eOX+LPpfV/y
 TV74uKMVNPEOjb16Zsvo4IHU3GBJ5NzHMWGSZGrMNATTTLJEH9bqRhxPEWeAonVURxItzq
 u9wsE9hQRpGJ5Gsz/UgaXE9gO7nyBCYwWwJUmDMe1+t1QaLEdyy+gzkkguA0Vg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] cpu: armv8: Staticize driver ops
Date: Fri,  8 May 2026 15:50:53 +0200
Message-ID: <20260508135102.518693-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1w8cccwsisn4ebsuq75xfemsu4zkr8on
X-MBO-RS-ID: 52e7e052afdd41e913a
X-Rspamd-Queue-Id: 4gBrB22hMkz9tTG
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

Set the ops structure as static. The structure is not accessible
from outside of this driver.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: - Drop the const part, this conflicts with ACPI_OPS_PTR macro
---
 drivers/cpu/armv8_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpu/armv8_cpu.c b/drivers/cpu/armv8_cpu.c
index 4eedfe5e2c5..ed87841b723 100644
--- a/drivers/cpu/armv8_cpu.c
+++ b/drivers/cpu/armv8_cpu.c
@@ -124,7 +124,7 @@ int armv8_cpu_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
 	return 0;
 }
 
-struct acpi_ops armv8_cpu_acpi_ops = {
+static struct acpi_ops armv8_cpu_acpi_ops = {
 	.fill_ssdt	= armv8_cpu_fill_ssdt,
 	.fill_madt	= armv8_cpu_fill_madt,
 };
-- 
2.53.0

