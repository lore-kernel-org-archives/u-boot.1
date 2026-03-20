Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9081099B30
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 330A7840C1;
	Fri, 20 Mar 2026 21:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SAC04yyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E108413A; Fri, 20 Mar 2026 21:53:53 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CABB83CF5
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4be94eeacso2478417a34.2
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040030; x=1774644830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=tDz/0RYWV7Q/+m3iWSEaRUNozRbRuR0FIj4M7oCbOLA=;
 b=SAC04yyD/XtKCD+TJWZCMwNvs5lyii9NApEMnDo2OqcBH9cyaIg9XvEkTMYXgUSk2U
 WS6qLPMNWqNZNfAnG2IWhAu5sRKJmQHrhpiEnJuZjBsHgJYq0bvl+cTnNgxnbCin9qmU
 TaEZXTHo9iSs9rzGfc8nYewGGwnwadc/4erR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040030; x=1774644830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tDz/0RYWV7Q/+m3iWSEaRUNozRbRuR0FIj4M7oCbOLA=;
 b=q+Tybtz9AUG5aXrtYUGK4+z2zhVZWY7KwoK5ppd2xhLXMyEx1TWJeIxCC3z7zjpESu
 JBbX6rkX25TaEKVnJm2GV9zykdefHATJ6Ov6lwKbgPgx0XZwBygrMzjTLE678tW2dki7
 VM6icMhkeeAydly899kGvQXB/vu1KHc3LY9M9oW3EwZ9Dz2jtQoccAWRtszru57LTkrM
 3caUIFbZdRy51XmCShAgJgkrwd3Le4CIji7QRGowEwscnBm0zqXalBSZEwr5n8rfU0pm
 d9iqGOBsJn3ufyJZkiqpgEJoivA4NOW72UcbY3Y6zTApYCjs2/fKJ2TdGGkrSxP2YAOq
 Bjgg==
X-Gm-Message-State: AOJu0YxrBv8XoxAltCRxrdvpvx0DAdoaCvNTeHwHxOimhdPA2yY7me6Z
 S+04mu3nPIattEoXeiDU5WCSFxvXhJdmgXtEcfRs7/g75trOQAS5z9pJH2jPXA+osKaQOErhJa/
 i8wKxI9o=
X-Gm-Gg: ATEYQzwXTCl72IsrmYuAXvXRM8SQk+l1JdkS76+ZJ8YJJ3OV4eFmQ+oFx2AdSEX7hqf
 im0Vt73TG651VJQHDoe1c23rmKR3aAaK4OizvU0GwxmqD4HhlUMONOV3CRMhCe/Zbl7VIpMRKB4
 TxLRLf8TZdeKWhowr3blGxbYrI/Ka4QWdFWqH1Jdm/UTP9rmZhj8Gxwl6AC/r4urE0XxxtTWTvh
 08QnKZrirt4quKokz71RlYw+r/hnPinnW6Mg+9C5UOoyuy4Idh5R1gR3fXzdmHQuflho1LYchfr
 lt88Qfuqh0WNeULKArcY0qdyiLVeeVoBnCd822kbz5WmTyVDxaZ6XGhYwqBeYVaKxtK1nhgKzus
 4+fwqdsvmo5eZdTqeuAYW3jmMLpNgU3MyRNcFuFAepR2+LwrpZQcH2gRsVsqTOcsb7X1bqVVkSR
 VIgH0MC8LpJXDAV5F7fxUheY4i02derRQHkcXbULuCNxxiknjzuR2bb05Me90avGOHX8qo0bW9O
 KsGwGapQ6InZ2qwTdsZ/ATx0JRvPoC35FWYpm1ICnDaQoK+LIg=
X-Received: by 2002:a05:6830:4408:b0:7d7:cc76:ff56 with SMTP id
 46e09a7af769-7d7eae42935mr2558401a34.5.1774040029751; 
 Fri, 20 Mar 2026 13:53:49 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7fbee2c6dsm506147a34.1.2026.03.20.13.53.49
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] gpio: Correct dependencies for legacy CMD_PCA953X
Date: Fri, 20 Mar 2026 14:53:48 -0600
Message-ID: <20260320205348.3789079-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The legacy CMD_PCA953X command can only be built when the matching
legacy driver is enabled, add that dependency to Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/gpio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index f69919abc05b..1484dd3504c1 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -383,6 +383,7 @@ config OMAP_GPIO
 
 config CMD_PCA953X
 	bool "Enable the pca953x command"
+	depends on PCA953X
 	help
 	  Deprecated: This should be converted to driver model.
 
-- 
2.43.0

