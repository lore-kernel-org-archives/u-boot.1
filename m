Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A016C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 15:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F57B841F2;
	Thu,  2 Jul 2026 17:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="Eetx8BaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 568E98469D; Thu,  2 Jul 2026 17:10:09 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 510A48407E
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 17:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8DDE4B005A4;
 Thu,  2 Jul 2026 17:10:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783005006;
 bh=WnVdRXEBQUNH9yKkKoLu3nT109nFln0Y02u95ScskmU=;
 h=From:To:Cc:Subject:Date:From;
 b=Eetx8BaQUipJXovP3oQ1uXNdjYsvlGyb2OGQMYCV18okMIhiqRD9h8ejH7PST6q5L
 Se3bfXaaIfhAtl1fpWP1X7RKIhcd4TxuhZB+bNn3770rzX1l7Dqk/bw0BUtQVZBi6E
 2+WPo1gHTkguQBvImc5AP3BMg0M+mBJO9z+eLuNNwAXmoSbi3cFuX/OMBX5r2nIfYo
 YBM4Gv997S60YKZxO+gdJ+J1xMZRqUcok1EYzOdBQv5y81R5zo2+YGeGMnJJgpt8vH
 zKTHM00R8p3ee5R9uP1dTWCTIQ+Crg6wAfFnX39FqXX9si/Z/Bs8rBiEhiF5mVnsg9
 FqgWzSyvtuJmQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] gpio: mpc8xxx: add set_flags/get_flags ops
Date: Thu,  2 Jul 2026 17:09:49 +0200
Message-ID: <20260702151001.1600397-1-vjardin@free.fr>
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

mpc8xxx_gpio_open_drain_on() / _off() helpers can program GPODR
(open-drain enable) on QorIQ silicon, but they are not called.

The open-drain capability is therefore unreachable from the GPIO uclass.

Adding a set_flags op for the GPIOD_OPEN_DRAIN, plus a get_flags for the
reports of state by reading GPDIR and GPODR back.

For existing callers, it is unchanged: direction_input,
direction_output, get_value, set_value and get_function still drive
the same registers as before. The new ops only become observable when
a caller explicitly asks for the GPIOD_OPEN_DRAIN flag (or queries
flags via the uclass).

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 drivers/gpio/mpc8xxx_gpio.c | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpio/mpc8xxx_gpio.c b/drivers/gpio/mpc8xxx_gpio.c
index 709d04017d1..40646407369 100644
--- a/drivers/gpio/mpc8xxx_gpio.c
+++ b/drivers/gpio/mpc8xxx_gpio.c
@@ -171,6 +171,58 @@ static int mpc8xxx_gpio_get_function(struct udevice *dev, uint gpio)
 	return dir ? GPIOF_OUTPUT : GPIOF_INPUT;
 }
 
+static int mpc8xxx_gpio_set_flags(struct udevice *dev, uint gpio,
+				  ulong flags)
+{
+	u32 mask = gpio_mask(gpio);
+	int ret;
+
+	/* The QorIQ GPIO pad supports open-drain only; open-source has
+	 * no silicon counterpart, so reject it rather than silently
+	 * pretending.
+	 */
+	if (flags & GPIOD_OPEN_SOURCE)
+		return -EOPNOTSUPP;
+
+	/* GPODR is per-pin and meaningful in both directions (it stays
+	 * latched when the pin is re-purposed), so apply it before the
+	 * direction change.
+	 */
+	if (flags & GPIOD_OPEN_DRAIN)
+		mpc8xxx_gpio_open_drain_on(dev, mask);
+	else
+		mpc8xxx_gpio_open_drain_off(dev, mask);
+
+	if (flags & GPIOD_IS_OUT) {
+		ret = mpc8xxx_gpio_direction_output(dev, gpio,
+						    !!(flags & GPIOD_IS_OUT_ACTIVE));
+	} else if (flags & GPIOD_IS_IN) {
+		ret = mpc8xxx_gpio_direction_input(dev, gpio);
+	} else {
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int mpc8xxx_gpio_get_flags(struct udevice *dev, uint gpio,
+				  ulong *flagsp)
+{
+	u32 mask = gpio_mask(gpio);
+	ulong flags = 0;
+
+	if (mpc8xxx_gpio_get_dir(dev, mask))
+		flags |= GPIOD_IS_OUT;
+	else
+		flags |= GPIOD_IS_IN;
+
+	if (mpc8xxx_gpio_open_drain_val(dev, mask))
+		flags |= GPIOD_OPEN_DRAIN;
+
+	*flagsp = flags;
+	return 0;
+}
+
 #if CONFIG_IS_ENABLED(OF_CONTROL)
 static int mpc8xxx_gpio_of_to_plat(struct udevice *dev)
 {
@@ -255,6 +307,8 @@ static const struct dm_gpio_ops gpio_mpc8xxx_ops = {
 	.get_value		= mpc8xxx_gpio_get_value,
 	.set_value		= mpc8xxx_gpio_set_value,
 	.get_function		= mpc8xxx_gpio_get_function,
+	.set_flags		= mpc8xxx_gpio_set_flags,
+	.get_flags		= mpc8xxx_gpio_get_flags,
 };
 
 static const struct udevice_id mpc8xxx_gpio_ids[] = {
-- 
2.43.0

base-commit: f605dcee103c897b6f1a8873549a36949bd4e2a1
branch: for-upstream/gpio-mpc8xxx-set-flags
