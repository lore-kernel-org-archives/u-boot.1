Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1D5C369D5
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 23:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDC4E81F30;
	Tue, 22 Apr 2025 01:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=paulsajna.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=paulsajna.com header.i=@paulsajna.com header.b="cuD5ikgL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5007B81E25; Tue, 22 Apr 2025 01:20:31 +0200 (CEST)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D2CF8082A
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 01:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=paulsajna.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@paulsajna.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paulsajna.com;
 s=protonmail; t=1745277628; x=1745536828;
 bh=cl2TpHxdHmn9k+jqz/SjzbgK+XpoP1vXZVUk4UxH8Dw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=cuD5ikgL1opb1aLhI6naD2yfcx+0LzEUM9cw8ICYiFqgQKPpGC4St5uOn8WH5LVtw
 Ma55tgjemH1Jtaayz9MOStqywOCoqcTdf8hw5UDLQxBfP1cOP17WxxvFpz05qzUz1h
 69YTZifVXys3noePYE8xiHy3eEylPeJZdnO11PM+VZAINr2KCbsp4mmUKdFgHfED+o
 Fuo8Gy1IfYx6Q7D8EGXq3tcT1VxOdN7VHsZg+CttNJmaFrddml2Ml/Nc1l7EMr68TV
 lHZwpaMQ4nUENzFcYFdnpQoOWXvh6fMM2Cg7i9TvwVEr9EbsHsRRh7XK/cACd3+buz
 +linmpLNCeCEg==
Date: Mon, 21 Apr 2025 23:20:22 +0000
To: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
From: Paul Sajna <hello@paulsajna.com>
Cc: u-boot-qcom@groups.io, Sam Day <me@samcday.com>,
 Paul Sajna <hello@paulsajna.com>
Subject: [PATCH v2 2/2] watchdog: qcom: improve driver with more functionality
Message-ID: <20250421-b4-qcom-wdt-v2-2-b2250efa0f39@paulsajna.com>
In-Reply-To: <20250421-b4-qcom-wdt-v2-0-b2250efa0f39@paulsajna.com>
References: <20250421-b4-qcom-wdt-v2-0-b2250efa0f39@paulsajna.com>
Feedback-ID: 29073965:user:proton
X-Pm-Message-ID: 42a7a10b8c9c63a5d256cc03700c0b8dd613ebdc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

- add the ability to start the watchdog
- add the ability to reset the watchdog
- remove the automatic disable in the probe function
- use log macros for errors

Signed-off-by: Paul Sajna <hello@paulsajna.com>
---
 drivers/watchdog/qcom-wdt.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index a7ce31ef811c717fd16700aa7d984a000763a93e..88e5fc7906825ac258393495682=
a75a5010473b0 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -4,12 +4,14 @@
  * Copyright (c) Linaro Ltd. 2024
  *
  * Authors:
- *   Caleb Connolly <caleb.connolly@linaro.org>
+ *   Casey Connolly <casey.connolly@linaro.org>
+ *   Paul Sajna <hello@paulsajna.com>
  *
  * Derived from linux/drivers/watchdog/qcom-wdt.c
  */
=20
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <wdt.h>
=20
 #include <asm/io.h>
@@ -50,7 +52,16 @@ static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum=
 wdt_reg reg)
=20
 int qcom_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 {
-=09/* unimplemented */
+=09struct qcom_wdt *wdt =3D dev_get_priv(dev);
+
+=09writel(0, wdt_addr(wdt, WDT_EN));
+=09writel(1, wdt_addr(wdt, WDT_RST));
+=09writel(1, wdt_addr(wdt, WDT_EN));
+=09writel(1, wdt_addr(wdt, WDT_EN));
+=09if (readl(wdt_addr(wdt, WDT_EN)) !=3D 1) {
+=09=09dev_err(dev, "Failed to enable Qualcomm watchdog!\n");
+=09=09return -EIO;
+=09}
 =09return 0;
 }
=20
@@ -60,29 +71,36 @@ int qcom_wdt_stop(struct udevice *dev)
=20
 =09writel(0, wdt_addr(wdt, WDT_EN));
 =09if (readl(wdt_addr(wdt, WDT_EN))) {
-=09=09printf("Failed to disable Qualcomm watchdog!\n");
+=09=09dev_err(dev, "Failed to disable Qualcomm watchdog!\n");
 =09=09return -EIO;
 =09}
=20
 =09return 0;
 }
=20
+int qcom_wdt_reset(struct udevice *dev)
+{
+=09struct qcom_wdt *wdt =3D dev_get_priv(dev);
+
+=09writel(1, wdt_addr(wdt, WDT_RST));
+=09return 0;
+}
+
 static int qcom_wdt_probe(struct udevice *dev)
 {
 =09struct qcom_wdt *wdt =3D dev_get_priv(dev);
 =09struct qcom_wdt_match_data *data =3D (void *)dev_get_driver_data(dev);
-=09int ret;
=20
 =09wdt->base =3D dev_read_addr_ptr(dev);
 =09wdt->layout =3D data->offset;
=20
-=09ret =3D qcom_wdt_stop(dev);
-
-=09return ret;
+=09return 0;
 }
=20
 static const struct wdt_ops qcom_wdt_ops =3D {
+=09.start =3D qcom_wdt_start,
 =09.stop =3D qcom_wdt_stop,
+=09.reset =3D qcom_wdt_reset,
 };
=20
 static const struct udevice_id qcom_wdt_ids[] =3D {

--=20
2.49.0


