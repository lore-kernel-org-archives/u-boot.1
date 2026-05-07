Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92312CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9498B84BDE;
	Thu,  7 May 2026 18:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ie8Ji3gu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y/wWh3pC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF8584BE0; Thu,  7 May 2026 18:43:43 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04BF384BDC
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gBJ3d58KTz9vHr;
 Thu,  7 May 2026 18:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dpfp+xr6Z6pgfxkR35Et1lsQ86DS091VM/7acs4FVkk=;
 b=ie8Ji3gu/EWqNEdXKME8X068UwQRxhv5g5SmehEmab156ZI9a0HtVpExaVVv5p+qEYzyCE
 U5qGFgvcKg/p6hBb+mSuAnrhmtFICSWfID0+lQe4QqhVspBzTsA9f3Nygt1ZTWcMMk1K5y
 wciFkocnyaB1L70Gs+UwsiISrmUS1gOnY0jZ6MKz6pvk2nOsolGPYq+WZHg7dXuV5iASVV
 H6fzsSauwYuOewYPJue7Hgo7yZQznDdPxvXGLMATQyBhueB4dZgCgvq7E60ar4fu87xG0o
 O7IPSvItEf/bL97fu9MzXZ6Kq1DOozGRTNuNhA4TO1ehHwZFc7m5YJ7FpArOtA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dpfp+xr6Z6pgfxkR35Et1lsQ86DS091VM/7acs4FVkk=;
 b=Y/wWh3pCcRM0rPsZMM3RGcuW9NzE8yLrwrN09zUOJ3YJkzu3TTPQEVT3mzK+VDFckMpkfr
 8UwoyAi07S6pYa4xqs2Ko92S9JlorHb8ucpB2IDbCVsR3NpzPM7CbId63IC9L61iG9fIw+
 iJLjMczAsSWw0ztIvDtman7Z8ryWcU8K8mRQ2NGOdEauJR4U8n/DKUhSn3qwZ0TlIwh/t7
 sVAVNoY4yN8AzDpVjuyhodLGvc27XjgzKmnb3wjqxc7v7rXMFU3DPucp5e3pPt+FDHqVet
 wQgWMNMkDF7v6c5mnDVGF5gQIl/HE36UEOd4KFT8L+ncj2ogSlwV1IatY66HjQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] cpu: armv8: Staticize and constify driver ops
Date: Thu,  7 May 2026 18:43:30 +0200
Message-ID: <20260507164338.59399-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y7q75iz11ba3c4b53dc7w4chz4s54aox
X-MBO-RS-ID: b8fb081eb6b7e64503e
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

