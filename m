Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA96CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4120F84AF1;
	Fri,  8 May 2026 14:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iKKNXR05";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xEs8vhNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB7E984AF1; Fri,  8 May 2026 14:22:07 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07D4E83DBF
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBpCK5LLzz9v8L;
 Fri,  8 May 2026 14:22:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=b0oSHaRLkNahfnl3VyTC/2FxubvcSXUf19fQi93A6hE=;
 b=iKKNXR055fRgNpzwSUcnvH4P1jyFQilIADMWW2Y03f3yF/8fyUXV2yVE8HKGRH/p70rZ0t
 aK9jsbNfvzD6x/tHM7sB8CtDaA+efm4s2IblsIqw1PBobAMUhaMzUxxR1u8dUjUMnWo9K3
 hqVMEWax9bGoBBVDervsij/p2WMTVRINRuLad6QNYL1WsEPkcHpJlMvczHxSgPicLA89Ma
 KhlNlxBZ2AC97TkjfXZ67tewcL+qQ7hPZ3atwYHqj/3U1wKZc1GefLaS+4miBM2a20zGs3
 L9eBOXXsTeo05Vo5M92F4cqtBClADT4azUP7K9L8qO+f0SHaG54fgCgrkfELog==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xEs8vhNi;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778242924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=b0oSHaRLkNahfnl3VyTC/2FxubvcSXUf19fQi93A6hE=;
 b=xEs8vhNiWh9SRM4OPB0eE005y8Eax9jzp5GLVdmRUciePzQvShfTh1hcwGdYCavbwLQ5YZ
 HgJwJRADKEypB0I4TEBf91VmCsCNe3bdT+FJly0fu4EB1+z+qCQ62VablwY4RJ66JDonuF
 AmJHWBCXvVpqEqRHEFLhM1UCXcY4Ur/mn+Ks9ogR7xpxTQRwAeT85RrmAFvqjUHWkWjJk4
 qVc3FGVki34rGC96iAxL12oI1Tzyqa5iGWMlE+IK1jACByVpEo5+Hy1uAUXOc2ZkRMewRl
 LjMIqaw8nf2VG4DKvFMb1qP1AYlaztGrqdJmXDINUocCDZCEAca5VifaV59ecA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] pinctrl: armada-38x: Staticize and constify driver ops
Date: Fri,  8 May 2026 14:21:56 +0200
Message-ID: <20260508122201.512840-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e95bf33b3398f98e627
X-MBO-RS-META: mi3sodh8d9jktxra5hfjiwudr6n55jiw
X-Rspamd-Queue-Id: 4gBpCK5LLzz9v8L
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
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 78184d2860a..c18afe958dc 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -550,7 +550,7 @@ static int armada_38x_pinctrl_probe(struct udevice *dev)
 	return 0;
 }
 
-struct pinctrl_ops armada_37xx_pinctrl_ops = {
+static const struct pinctrl_ops armada_37xx_pinctrl_ops = {
 	.get_pins_count = armada_38x_pinctrl_get_pins_count,
 	.get_pin_name = armada_38x_pinctrl_get_pin_name,
 	.get_functions_count = armada_38x_pinctrl_get_functions_count,
-- 
2.53.0

