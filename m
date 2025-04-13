Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0EAC3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 13:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC561829C3;
	Sun, 13 Apr 2025 15:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VmcL3KSq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZoLjmvgc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A03829C7; Sun, 13 Apr 2025 15:11:20 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 492DF8298E
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 15:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Zb9m60JX2z9t8t;
 Sun, 13 Apr 2025 15:11:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1744549878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1KJElwgv9WZzrsCNnYwCxuk+aHR55xe8JnaELBTMzqM=;
 b=VmcL3KSqz7GAFzZ7AwDoR2SnVXJLnXeJ9uNOMbMyjAT6vSAT+8ZkD3cfKhEW+8sESgBy6O
 q5Cnc+7L+lK2zYyGqzjaQ3M2gPsupCk2tmEKI/wvOIEog7dhXXBS0RuiU/eNPSX6IXShJK
 wEtTOTtsoKajOvqmDsGINTxlBpduRTDcuPatUAS2mZV2ngpy8vnpVTzVvuquQycDBKvLpg
 n4c6ICxZ+LjAIFMkPtVl1+yE8ebNEVwJzfD8FrlFcmGBbX6l6s/34dcvzmKS+o4IV6bfox
 27c+yMVn9zQkWG7hbQm6YK9R1GTl3gTTO/JrjTvO+riakRArgCbW4rQNWrtcig==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1744549876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1KJElwgv9WZzrsCNnYwCxuk+aHR55xe8JnaELBTMzqM=;
 b=ZoLjmvgcWubBVsVtn6rl0E6a2mCXXN0doVSz4mmpTCrUQaHlSpCPmb99h5+zECTZ/0JkcY
 aU8hHFviDk65EiaUzX0ZANWp2LSxUuGF9jJaOAjdrL6qBK/Nt0B0o9A5t2SPZjNi02jB8T
 7L5pvGpTIan7wUYcO1/q+0o94F6qxAs5oQYZ5OzGAWKFmfYXNSWeX1m8JBKlVV+vhooZDq
 X4HFmCoy312EFbIT0SZ59Uopmv+ovM3NzE5Hs32HZYGvHglV2uswXR6WJyuE2SeImEVJ35
 gg6IZUPl9b+VSP3i8Cagpxb5QZPAFU20Y81IhbyfxB+gukZr+9m9XZGSwgAKQA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: renesas: Enable serial RX buffer on Renesas R-Car
Date: Sun, 13 Apr 2025 15:10:45 +0200
Message-ID: <20250413131053.68941-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a15aa0b4f4ee4d712e9
X-MBO-RS-META: bk6eb1pkm4trjwynxqrm845obiewferg
X-Rspamd-Queue-Id: 4Zb9m60JX2z9t8t
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

Enable CONFIG_SERIAL_RX_BUFFER on all Renesas R-Car devices which
use the SCIF serial port. This allows receiving large strings at
bulk even if the RX FIFO is small and would otherwise overflow.

The usual trigger for the problem addressed here is a paste of a
very long command into U-Boot command line, somewhere between 400
and 500 characters long. The trailing end of the string is usually
not received and the command line input stops responding due to RX
overflow errors. The CONFIG_SERIAL_RX_BUFFER allows efficient read
of data from the RX FIFO, which prevents the overflow, and allows
safe reception of long pasted strings.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/renesas_rcar.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/renesas_rcar.config b/configs/renesas_rcar.config
index d0a12f266aa..db5846e992c 100644
--- a/configs/renesas_rcar.config
+++ b/configs/renesas_rcar.config
@@ -24,5 +24,6 @@ CONFIG_MTD=y
 CONFIG_OF_CONTROL=y
 CONFIG_RCAR_GPIO=y
 CONFIG_SCIF_CONSOLE=y
+CONFIG_SERIAL_RX_BUFFER=y
 CONFIG_SPI=y
 CONFIG_VERSION_VARIABLE=y
-- 
2.47.2

