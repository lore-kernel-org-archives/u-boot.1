Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A22D3F29E
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 21:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79D8888DA0;
	Fri, 18 Oct 2024 23:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=balister.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VBlrcgY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B2FB88DC6; Fri, 18 Oct 2024 23:20:06 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF89A88D61
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 23:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=balister.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip.balister@gmail.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e2903a48ef7so2643470276.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729286402; x=1729891202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=5zlkslus+ar7PpbF1b/wpfHmHSbUY2CK6PS+f55Vqrk=;
 b=VBlrcgY8YagBeMkgHfnoXG05QqZwu1+fgG2ZXZBH5VoJmt5fOkYmNfRWrEb0q9yja8
 xsbEJPYgvRm/RruurfFeid47foQGWRZUl8iUjgtAiUc3Z25IsvTFjEHf05na8+IFxN8s
 ZHeajwR+PIWkNioHJXrkgShoviAlEGHbkXFpdisvs94fxnwBW7i7gJkswc1qCHqi7ysF
 PhHmvPFFuTOmawX1d4Mu3WCFXzE2wQ1n9G29l3BVpjD2/5hOZX63rzejWfEOUiI1hvoC
 u0Gc+w2ZqRbexl/A464jfjsoLnXAKvsYuqhNdHTPnzWSFiQczce9tP6ky6SlaRfB7LYo
 rPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729286402; x=1729891202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zlkslus+ar7PpbF1b/wpfHmHSbUY2CK6PS+f55Vqrk=;
 b=rryDt4jY7SzjUCPN9vY2HLI/3jCrequ0ydb8gsYo9qzDcaNl6ZPt88GIItgMId4g/p
 OzEzbgbjhpn+Azfi/EMqQ2prLZCIaqVDKJ9brfXm1Z/kM3CIx6nxU3ADoCjaklWs1Vz1
 mg5B+hR8RnI+QZByj6AWBBwPRP4ZKKoNh3RvcdGsx5zcMksB7LWN6vH+m9lWMyhfuii6
 yLuW/ZF3ieW2Enfd1PyF7h7bLBft9gGdmq+NwRm4FFoe3pJgk9khJjLFbP4PMpklXE8H
 MF4O6yEefD/nIirLflba8cSJ3D40eCim36M7JkR1ezWTmWP8APTzNRB1CdYNWot+Kul9
 E+ag==
X-Gm-Message-State: AOJu0YwtJToxaNumchkNUQUyB4DjhRXfnd4rAiANZn+zWK8G5k5gjrGj
 CaNrcuM6hiXmpRRyKtfA4612whwXHF03DZHUDO/i4UvxgsK+6FdjUEe2og==
X-Google-Smtp-Source: AGHT+IEHRMbqWQuwX73NxHmBkijXVIsonSVP/BQNOdCOYQjZN2WfexPyC+YG3YzMwqd8P2XAwZnvMQ==
X-Received: by 2002:a05:6902:2d08:b0:e28:f402:cc6f with SMTP id
 3f1490d57ef6-e2bb1697364mr4132136276.46.1729286401948; 
 Fri, 18 Oct 2024 14:20:01 -0700 (PDT)
Received: from dublin.hsd1.va.comcast.net
 ([2601:5c0:c200:483f:d85e:cf85:5150:cedd])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460ae94759fsm10858691cf.19.2024.10.18.14.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 14:20:01 -0700 (PDT)
From: Philip Balister <philip@balister.org>
To: u-boot@lists.denx.de
Cc: Philip Balister <philip@balister.org>
Subject: [PATCH] mcp230xx_gpio.c: Add a missing include file.
Date: Fri, 18 Oct 2024 17:19:57 -0400
Message-ID: <20241018211957.163051-1-philip@balister.org>
X-Mailer: git-send-email 2.46.2
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

 * Fixes a warning about implicit declaration of udelay.

Signed-off-by: Philip Balister <philip@balister.org>
---
 drivers/gpio/mcp230xx_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/mcp230xx_gpio.c b/drivers/gpio/mcp230xx_gpio.c
index 42e7fe9d474..b6f533b1306 100644
--- a/drivers/gpio/mcp230xx_gpio.c
+++ b/drivers/gpio/mcp230xx_gpio.c
@@ -14,6 +14,7 @@
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <linux/delay.h>
 
 enum mcp230xx_type {
 	UNKNOWN = 0,
-- 
2.46.2

