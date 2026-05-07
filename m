Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611A7CD3445
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 23:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 915AB84BCF;
	Fri,  8 May 2026 01:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BuPyzJx0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DFKxz7SQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5787284BCF; Fri,  8 May 2026 01:24:58 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B9A84B58
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 01:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gBSyZ55NXz9tX0;
 Fri,  8 May 2026 01:24:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7yfNli4oQxxeclmTxqF8351nggcfWOEbWlH/I7a+4g=;
 b=BuPyzJx0OdvG1jtZ8nxqGCd0AYwsjkjdXC4vEpjA9lXDdeYdQPBNzzzFVgqNh5fVe1X7dt
 lhmApWDBRaVfE9o4CJBjgzgujuzRlACqooPfdDU5C7aB5N+YHwZD/k79vf/z8Aaf3RaIM6
 o7QEsKKcC4IXKTxks9G0emPSDeKx3je+SoGBEMJmhuXCkA5Nm7Jdsw790fXkQrfKQQ502A
 wwxH+GA9r7JFfRB577Lu/VnUlcRdeC5brrcqykkLDjvZnhoxgXCZpdxcP0Y6gJ3Ai2odO2
 zVD6B5yVicXQNwySDPF+u3ysgURA6/Aw9VJAL9gjN6B9ARvsx4AcVsdKFAxQYw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=DFKxz7SQ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7yfNli4oQxxeclmTxqF8351nggcfWOEbWlH/I7a+4g=;
 b=DFKxz7SQTnEX1Mvs1aj+tIT1Kxwfvm58kHW4aXIxr2PrKn8MCBf780sn+9MJW0Hk+K8dPA
 kNU/yalPyFNwfJmTHBma35Dmtq/7paiLfUEYqxAZ1vs4QBIMj+uD03teKr+oAO3HT0VL7i
 eY/DVJWZGUPWl8QjnfBx2vZXQJ9b1jF5ufbtoCxwziFU0lEHT58niC08jHjaOe24RAlyeN
 mWpaSMBtqex4bkPyYHDg4bIe3Pb0e8zg3Yzt+wr4gEktIKbOs5J1yU2Gp0ivDCP6Hs7nGT
 nMCOP+fYtm7irioa+1FZTaV6vl2WEvH1DBt/jjyNtDse/BQN+U1B3ccMB90iZg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Hai Pham <hai.pham.ud@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] arm64: dts: renesas: Update reset IDs on R-Car Gen5
 R8A78000 X5H
Date: Fri,  8 May 2026 01:23:33 +0200
Message-ID: <20260507232424.304154-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507232424.304154-1-marek.vasut+renesas@mailbox.org>
References: <20260507232424.304154-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: oro5epu7nr7przum1mknc1bf6w8o4gtx
X-MBO-RS-ID: 7b0f83209fd995fa121
X-Rspamd-Queue-Id: 4gBSyZ55NXz9tX0
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

The current DT reset ID encoding in R-Car Gen5 R8A78000 X5H U-Boot DTs
is inherited from downstream BSP. New reset bindings for this SoC are
now submitted and under review [1]. Replace the DT reset IDs with the
ones used in the new bindings.

[1] https://lore.kernel.org/all/053c312d07445517d8f9c84bfe3cc8fb72d4cd9a.1776793163.git.geert+renesas@glider.be/

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Clément Le Goffic <clegoffic@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 .../dt-bindings/reset/r8a78000-reset-scmi.h   | 38 ++++++++-----------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/include/dt-bindings/reset/r8a78000-reset-scmi.h b/include/dt-bindings/reset/r8a78000-reset-scmi.h
index e0d10caa589..3d84bfb073a 100644
--- a/include/dt-bindings/reset/r8a78000-reset-scmi.h
+++ b/include/dt-bindings/reset/r8a78000-reset-scmi.h
@@ -1,33 +1,27 @@
 /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
 /*
- * Copyright (C) 2025 Renesas Electronics Corp.
- *
- * IDs match SCP 4.27
+ * Copyright (C) 2025-2026 Renesas Electronics Corp.
  */
 
 #ifndef __DT_BINDINGS_R8A78000_SCMI_RESET_H__
 #define __DT_BINDINGS_R8A78000_SCMI_RESET_H__
 
-/*
- * These definition indices match the Reset ID defined by SCP FW 4.27.
- */
-
-#define SCP_RESET_DOMAIN_ID_UFS0	202
-#define SCP_RESET_DOMAIN_ID_UFS1	203
+#define SCP_RESET_DOMAIN_ID_UFS0	0x60
+#define SCP_RESET_DOMAIN_ID_UFS1	0x61
 
-#define SCP_RESET_DOMAIN_ID_XPCS0	316
-#define SCP_RESET_DOMAIN_ID_XPCS1	317
-#define SCP_RESET_DOMAIN_ID_XPCS2	318
-#define SCP_RESET_DOMAIN_ID_XPCS3	319
-#define SCP_RESET_DOMAIN_ID_XPCS4	320
-#define SCP_RESET_DOMAIN_ID_XPCS5	321
-#define SCP_RESET_DOMAIN_ID_XPCS6	322
-#define SCP_RESET_DOMAIN_ID_XPCS7	323
+#define SCP_RESET_DOMAIN_ID_XPCS0	0x30
+#define SCP_RESET_DOMAIN_ID_XPCS1	0x31
+#define SCP_RESET_DOMAIN_ID_XPCS2	0x32
+#define SCP_RESET_DOMAIN_ID_XPCS3	0x33
+#define SCP_RESET_DOMAIN_ID_XPCS4	0x34
+#define SCP_RESET_DOMAIN_ID_XPCS5	0x35
+#define SCP_RESET_DOMAIN_ID_XPCS6	0x36
+#define SCP_RESET_DOMAIN_ID_XPCS7	0x37
 
-#define SCP_RESET_DOMAIN_ID_MPPHY01	344
-#define SCP_RESET_DOMAIN_ID_MPPHY11	345
-#define SCP_RESET_DOMAIN_ID_MPPHY21	346
-#define SCP_RESET_DOMAIN_ID_MPPHY31	347
-#define SCP_RESET_DOMAIN_ID_MPPHY02	348
+#define SCP_RESET_DOMAIN_ID_MPPHY01	0x64
+#define SCP_RESET_DOMAIN_ID_MPPHY11	0x65
+#define SCP_RESET_DOMAIN_ID_MPPHY21	0x66
+#define SCP_RESET_DOMAIN_ID_MPPHY31	0x67
+#define SCP_RESET_DOMAIN_ID_MPPHY02	0x68
 
 #endif /* __DT_BINDINGS_R8A78000_SCMI_RESET_H__ */
-- 
2.53.0

