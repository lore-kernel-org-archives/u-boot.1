Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914B606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u5Z6xJFC;
	dkim=pass (2048-bit key, unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=JEOQ2Qn/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9D1980E4C;
	Sun,  8 Nov 2026 08:06:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hz6v8e0oUJOk; Sun,  8 Nov 2026 08:06:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 67AC280E3D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794125170;
	b=ACqCPlyksc5ABniI72iAw8bhlgIRxoUTgzwQcUhMYb+ofsHZUTjBS1VmYfa6j/TZ2KV5
	 zkIenRvlkZdM5Dwu6fonLxiEqgyG8M9nbKNuh3hKq0wkfcP+2gCs1NkwlXxl6NyBtTBNi
	 Ac10yzAJp+v7EtIQlip3asOlIUTmY6kEQkZC/8jp3GjjrPJrGR0qx/51KcQ44eM+NnIUi
	 XXA32FWs8ZbzV4yuiVZfPWCIMxLIh5NWkL5PxEAclbTQfjXeyXWSQNGXDY0eDnXCjDW8M
	 +u3CfoQ4h+V/UPMOmejHGoVeS9ZdIqRlZ7lz/wpm6DtfePawA7e9JjELW4u/KXERbkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794125170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 Mime-Version:X-Mailer:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+EXnZ/5B4ggWMq+vK+GcHXBgbS8c5wR8tg6VUJQVa4Y=;
	b=PO/H8K6HoLRfprF93CI+ah3K1Kat6KcPPzteNTTF/dP9KSBSOj9AWH6OoBcUDjnJjJRr
	 QzGQaVNTCPh1A+uQJEHfhQtvnfhv1MeVrhRK+iUThQn8xAURgmnx11B26FrM5pzJSj98D
	 NyBeVsgT783+B9FagCJtMX1uCM2B056FuqSKaJXETsivb/iHFGY5CWvmOW5Bn4KS7VUw8
	 7WxsmEo+Mzu6OGiYKAsKA9TlFKPiNB31xcchWIgBkWpYsxPOnK/v2J42xfe/gE8SJbSHt
	 cFAlyMiEk7ffRhCwjDuM/hmpALG1QyI5Cv0mxf9SLLkwsW62qcen4sp/2CAN7eggFog==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794125170;
	bh=+EXnZ/5B4ggWMq+vK+GcHXBgbS8c5wR8tg6VUJQVa4Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u5Z6xJFCJiKfn9jocx479kgh/99/s7Ou8U9x/Bx2rphubq6FaEAe25iqhDwnlncco
	 LEYEUbfPAtQghiOy6zIfz5woolMeEISo7aKrxpCCaAhFu/z6uGe0Jph0z326cKujou
	 u6Ctc2dt04O+ikD95OoaS7sz9PI8WpxPNehVWwjNELi3a6rVUEe8uUgGaz7jTgX+Os
	 yV8HUc/gjk/JbVV5q7tDmtUN1cRpthOrny5MefVyn5WUJjdIzczt4N8RKqdei5WXzp
	 icc0eWyNvyGpQLqEp0kNM9DooybynsEDuo1WnpaBG9SIfTnUxMrw/uJCWXbd1L8Zpy
	 JSr12QWNnF19g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67AC280E3D;
	Sun,  8 Nov 2026 08:06:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5469A235
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 08:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 452DE60629
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 08:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IFOP0R3WrEbF for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 08:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4AEA360601
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a02:598:64:8a00::1000:9ad"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:598:64:8a00::1000:9ad; helo=mxc-2-9ad.seznam.cz;
 envelope-from=tomaspaukrt@email.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256
 header.s=szn1 header.b=JEOQ2Qn/
Received: from mxc-2-9ad.seznam.cz (mxc-2-9ad.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:9ad])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4AEA360601
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 08:06:05 +0000 (UTC)
Received: from email.seznam.cz by smtpc-mxc-59f7fd7d85-mvz87
 (smtpc-mxc-59f7fd7d85-mvz87 [2a02:598:64:8a00::1000:9ad])
 id 4432c107bac673ad44bc4f1f; Sun, 08 Nov 2026 09:05:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
 t=1794125154; bh=+EXnZ/5B4ggWMq+vK+GcHXBgbS8c5wR8tg6VUJQVa4Y=;
 h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type:
 Content-Transfer-Encoding;
 b=JEOQ2Qn/AFGnFS/xBZf+HaossrdndQZDAl9LtJM+oxQAjcu3x//I1zRLcnwfwWheZ
 ks4zABLnjJm8r01QnhRRbTaLu0aaP75Iq0VuoDxaXrpKt8+8R71j5uZOiA6TPk3lWx
 +TATZkhlqtrXl7iRJrtW5o9Ndtm+p3V+nw2eKXVm+IPZjfKlSXkM58YlPOXH3Xq0ar
 k6QFTfRr7ZnLN3MPGxo1MckKIg7FT3OdJfAUUeg67RfjDIBaSIw+/nTPPljkGuBAw7
 zPszKz46RW+z6S94CpymGhSVY5UBAdhMQG7I6HMCjTE0sCjepyeHT5Vso1EwFQAIGg
 3buYNRpnQaoaQ==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-email-ebox-5.1.30) with HTTP;
 Sun, 08 Nov 2026 09:05:48 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.u-boot-project.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Honbo He" <hehongbo918@gmail.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Sean Anderson" <sanderson@brivo.com>, "Johan Jonker" <jbx6244@gmail.com>,
 "Peng Fan" <peng.fan@nxp.com>,
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 "Mehmet Fide" <mehmet.fide@screeningeagle.com>,
 "Marek Vasut" <marex@nabladev.com>
Subject: [PATCH] serial: lpuart: add debug UART support 
Date: Sun, 08 Nov 2026 09:05:48 +0100 (CET)
Message-Id: <1B}.ZqLi.7bU8WuTOrTk.1gy2rS@seznam.cz>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (szn-mime-2.2.19)
X-Mailer: szn-email-ebox-5.1.30
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the debug UART to the LPUART driver for the LPUART
found on i.MX7ULP, i.MX8, i.MX8ULP, i.MX9 and i.MXRT, so that e.g. the
output before relocation is available on boards which skip the driver
model before relocation (SKIP_EARLY_DM).

Move the baud rate calculation of _lpuart32_serial_setbrg_7ulp() into
a helper taking the register base and the clock rate, so that it can
be shared by the driver and the debug UART.

The debug UART is also used by SPL, where debug_uart_init() may be
called before the clocks and pins are set up (e.g. on i.MX9). With
DEBUG_UART_SKIP_INIT the UART is not touched there and the output is
dropped while the transmitter is not enabled instead of waiting for it
forever.

Tested on an i.MX91 board with and without DEBUG_UART_SKIP_INIT.

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/serial/Kconfig         | 10 +++++
 drivers/serial/serial_lpuart.c | 70 +++++++++++++++++++++++++++-------
 2 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index bcb0c865437..9ebc251d891 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -429,6 +429,16 @@ config DEBUG_UART_MXC
 	  will need to provide parameters to make this work. The driver will
 	  be available until the real driver model serial is running.
 
+config DEBUG_UART_LPUART
+	bool "NXP LPUART"
+	depends on FSL_LPUART
+	depends on ARCH_MX7ULP || ARCH_IMX8 || ARCH_IMX8ULP || ARCH_IMX9 || ARCH=
_IMXRT
+	help
+	  Select this to enable a debug UART using the serial_lpuart driver
+	  with the LPUART found on i.MX7ULP, i.MX8, i.MX8ULP, i.MX9 and i.MXRT.=

+	  You will need to provide parameters to make this work. The driver
+	  will be available until the real driver model serial is running.
+
 config DEBUG_UART_SANDBOX
 	bool "sandbox"
 	depends on SANDBOX_SERIAL
diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart=
.c
index dccd0974150..00de1926023 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -233,22 +233,10 @@ static int _lpuart_serial_init(struct udevice *dev)=

 	return 0;
 }
 
-static void _lpuart32_serial_setbrg_7ulp(struct udevice *dev,
-					 int baudrate)
+static void lpuart32_set_baud_7ulp(struct lpuart_fsl_reg32 *base, u32 clk=
,
+				   int baudrate)
 {
-	struct lpuart_serial_plat *plat =3D dev_get_plat(dev);
-	struct lpuart_fsl_reg32 *base =3D plat->reg;
 	u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
-	u32 clk;
-	int ret;
-
-	if (CONFIG_IS_ENABLED(CLK)) {
-		ret =3D get_lpuart_clk_rate(dev, &clk);
-		if (ret)
-			return;
-	} else {
-		clk =3D get_lpuart_clk();
-	}
 
 	baud_diff =3D baudrate;
 	osr =3D 0;
@@ -302,6 +290,25 @@ static void _lpuart32_serial_setbrg_7ulp(struct udevi=
ce *dev,
 	out_le32(&base->baud, tmp);
 }
 
+static void _lpuart32_serial_setbrg_7ulp(struct udevice *dev,
+					 int baudrate)
+{
+	struct lpuart_serial_plat *plat =3D dev_get_plat(dev);
+	struct lpuart_fsl_reg32 *base =3D plat->reg;
+	u32 clk;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK)) {
+		ret =3D get_lpuart_clk_rate(dev, &clk);
+		if (ret)
+			return;
+	} else {
+		clk =3D get_lpuart_clk();
+	}
+
+	lpuart32_set_baud_7ulp(base, clk, baudrate);
+}
+
 static void _lpuart32_serial_setbrg(struct udevice *dev,
 				    int baudrate)
 {
@@ -582,3 +589,38 @@ U_BOOT_DRIVER(serial_lpuart) =3D {
 	.probe =3D lpuart_serial_probe,
 	.ops	=3D &lpuart_serial_ops,
 };
+
+#ifdef CONFIG_DEBUG_UART_LPUART
+
+#include <debug_uart.h>
+
+static inline void _debug_uart_init(void)
+{
+	struct lpuart_fsl_reg32 *base =3D
+		(struct lpuart_fsl_reg32 *)CONFIG_VAL(DEBUG_UART_BASE);
+
+	if (IS_ENABLED(CONFIG_DEBUG_UART_SKIP_INIT))
+		return;
+
+	out_le32(&base->ctrl, 0);
+	lpuart32_set_baud_7ulp(base, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);=

+	out_le32(&base->ctrl, CTRL_RE | CTRL_TE);
+}
+
+static inline void _debug_uart_putc(int ch)
+{
+	struct lpuart_fsl_reg32 *base =3D
+		(struct lpuart_fsl_reg32 *)CONFIG_VAL(DEBUG_UART_BASE);
+
+	if (!(in_le32(&base->ctrl) & CTRL_TE))
+		return;
+
+	while (!(in_le32(&base->stat) & STAT_TDRE))
+		schedule();
+
+	out_le32(&base->data, ch);
+}
+
+DEBUG_UART_FUNCS
+
+#endif
-- 
2.43.0
