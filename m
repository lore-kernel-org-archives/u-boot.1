Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ED6F483EC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB80384297;
	Mon, 23 Mar 2026 20:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tXeb9jNo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D2658423F; Mon, 23 Mar 2026 20:53:09 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24748841FA
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso342053fac.1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295586; x=1774900386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fa0Kn/I3RpqwP/Fg4WTdqm4TP39CXFcQci5iXHcuNgg=;
 b=tXeb9jNog8MmrKPVnvgTW7DAFDkAdKZGSNLM8EKC00vEPKqVnkIlseIurJE3ElioT8
 fUCrno1o+55Zk4l9RzHqz7pfIb4+BM6he8pn3BmPl7AQxCca3FNzkpLreduyb7GSa+HG
 /wgKv6rgSNXgBGNywNa2uFA6i5vgfgwSzLlHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295586; x=1774900386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fa0Kn/I3RpqwP/Fg4WTdqm4TP39CXFcQci5iXHcuNgg=;
 b=BwDpGDQsRFkqTm3ZFj2+Xn3PDHmpAAxVYOZeKpmnol5joqmZBdbs/LPCpnZ60gQr7e
 /o7GHZpLAU9rrJ0hNLoYjL/8Mu5dwbanwmOolzW6T0WdB3RZHsXL3rSFFGZJ5UN2H6b9
 BLGrpBG0eoDM/Yn8kdI+vS57oIAB9+GbKpWxIjkk/wZEiWmMIXE+PoEkjitkaNyL7zNF
 DtZxu4knYthUnsvA+wuWZbZ0JpWt6qQzMayHPZN7qVwVCaMbLficCQL8ri39F9lQ4tlA
 aykYapy7GOGGNLeKdEgjrJIlYNNgbtUsUeSNfiLMvJtCfLopIsc8VnT45mm5wNmoLEnD
 rg5g==
X-Gm-Message-State: AOJu0Yxp8inLYik3/VyGhxZLUxCMarud5wbOasrDzuQ2Mzus/5l5ytLX
 9se4Vza5rnz+rnkrsSWzegjXkNqvzKKQRxQs0LmBcFyufu26kg1cytd7AGndj/t4d64US+UFJmy
 vEPDSQ6g=
X-Gm-Gg: ATEYQzwhZq27bCDXafPlM7bj7md1hiXQOZRbYxsILB/BEl5VuXvlEpnLHbwxIUF47m1
 ht9u2GP+aowAXhth66pxfu7wUIL/DY7W27kP0TYM318w9j2/HcJxPuuzNVyo5v/QyiCcJQ58NNG
 0XZMWYYQ0pYzW4/UlFicajVVU3tR95GNw81LTNQ/ORmpwQizWIJY9+7VHpZTd14nsm8E2fU8CKy
 wE0xs1rwvG2S3oNfmwGJMZk/qch4hzoZQIRwZ4U9m9slNvCqEXFHF5LKcXRHMx1rGlxPl6zKWLq
 DEjjzlgLdFYdgoTU5FfjJPtmTW+hqvc0PoAnzZ3vJEWTz4tEfRBmAQ8Ppzw8ZFfxWLyjUFeM5Rk
 pw3owuYysuRfSwT8/MAzaCwwSJI0WopYymeAhU9KBSwy/Mmc85LxookmTRZjQZVq21JwPOyWGkg
 /XL8brZoMpsLzBXrd57M54TuRr8fw2kkALAGf/dRFVKYjJHD/U/kKPdLOsUbuAXccLR9GzRxyZJ
 bT/XBq+X7RPZae8S+eKcn+8C9MGEFWSFM0YYexIstgGFxyC9/I=
X-Received: by 2002:a05:6870:f61f:b0:41c:3fbf:431 with SMTP id
 586e51a60fabf-41c3fbf0ce1mr5330401fac.17.1774295585823; 
 Mon, 23 Mar 2026 12:53:05 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c149103b0sm9575424fac.5.2026.03.23.12.53.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:53:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] serial: ns16550: Fix an "unused" warning with
 SERIAL_PRESENT=n and OF_REAL=y
Date: Mon, 23 Mar 2026 13:53:04 -0600
Message-ID: <20260323195304.2363593-1-trini@konsulko.com>
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

The definition of our ID table is guarded with OF_REAL however the
U_BOOT_DRIVER that would in turn use the table is guarded with
SERIAL_PRESENT. To avoid a potential warning we must also guard the
ID table with SERIAL_PRESENT.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/serial/ns16550.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 2f24f47badfd..10271f46aa63 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -586,6 +586,7 @@ const struct dm_serial_ops ns16550_serial_ops = {
 	.getinfo = ns16550_serial_getinfo,
 };
 
+#if CONFIG_IS_ENABLED(SERIAL_PRESENT)
 #if CONFIG_IS_ENABLED(OF_REAL)
 /*
  * Please consider existing compatible strings before adding a new
@@ -603,8 +604,6 @@ static const struct udevice_id ns16550_serial_ids[] = {
 };
 #endif /* OF_REAL */
 
-#if CONFIG_IS_ENABLED(SERIAL_PRESENT)
-
 /* TODO(sjg@chromium.org): Integrate this into a macro like CONFIG_IS_ENABLED */
 #if !defined(CONFIG_TPL_BUILD) || defined(CONFIG_TPL_DM_SERIAL)
 U_BOOT_DRIVER(ns16550_serial) = {
-- 
2.43.0

