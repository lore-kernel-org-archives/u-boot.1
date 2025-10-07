Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10545CCD184
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D3488392E;
	Tue,  7 Oct 2025 10:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="HNGjC5tH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F204D838C7; Tue,  7 Oct 2025 10:18:27 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30FA583881
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ADCBDC9A50; Tue,  7 Oct 2025 10:18:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1759825105; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=nSC3CSmSGApcR7sQxQez1MhbnJY1Lh2uN88T+up+LR4=;
 b=HNGjC5tHlcRQc9J0Th6cpwSChLmJMF0iK0ch2ORpGkFEzfLs8pP8ZKxtx3UsDbUg6ufqx9
 ymw5sqLNTpdkFPCa10zTTplut0HRSBpEmdHnbEJdZxrDqtSmURfTQLz2xsjKINW2Go/LYG
 LYLJsaLesX2qmAMq9egia6sKPT2Bz6l+L9EAaX7ercLeoiN1I4NL6EUaqETwZ3OYAMBG5b
 HZoYlNXWm+lSjLox+BZSeUzCzInkMrjD/qDadLyXYjlwuGb1la04I8YMIQSsoyK0wIJ5/q
 S9a6IqcyWoflNQOKeQjHvhIebyai4VLxpq0kmwpH02hOc31yAFh5zCmwWyoF/g==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH 11/13] imx: kontron-sl-mx8mm: Autostart fastboot if booted
 from USB
Date: Tue,  7 Oct 2025 10:16:08 +0200
Message-ID: <20251007081640.61772-12-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081640.61772-1-frieder@fris.de>
References: <20251007081640.61772-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This is useful for development and manufacturing setups as fastboot
can be used without requiring any user input on the device.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/sl-mx8mm/sl-mx8mm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/kontron/sl-mx8mm/sl-mx8mm.c b/board/kontron/sl-mx8mm/sl-mx8mm.c
index cf71a4cf367..220c9701ca5 100644
--- a/board/kontron/sl-mx8mm/sl-mx8mm.c
+++ b/board/kontron/sl-mx8mm/sl-mx8mm.c
@@ -167,6 +167,11 @@ int board_late_init(void)
 		env_set("touch_rst_gpio", "87");
 	}
 
+	if (is_usb_boot()) {
+		env_set("bootcmd", "fastboot 0");
+		env_set("bootdelay", "0");
+	}
+
 	return 0;
 }
 
-- 
2.51.0

