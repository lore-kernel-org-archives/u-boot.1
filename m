Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92D8CF64B0
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 04:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61F9983FD9;
	Thu, 20 Nov 2025 05:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Jsv4WfGd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ID+PSy4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84F2783FF8; Thu, 20 Nov 2025 05:15:13 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D8B983952
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 05:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dBlPS2w38z9tTR;
 Thu, 20 Nov 2025 05:15:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763612108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=naKLK0nkQIf6qJW7FIZQ8gqsm0iuE8tEj11BXtGXQnw=;
 b=Jsv4WfGdTbKhk2OWre4yeJR0j/XafMRuLsBmLQWwkcPAnipAcAQmus0vI6Vb+dFPi/lEGB
 foEvjJd10dr6Rc4pdqlFw6OOkUW+X5W6dZtNY9zz077HdXute11vOm+v9xhsPjQPs1bFbH
 3RiAn5JLKNf7gho4U3uSsL462SvX0V5ag9Pg+xwCZy9MiSOx1SbMfoDNu9sS3SGpKPmLJC
 Eguytb8Tuv5jlej0FpTHZvch1k24mX6iBF61CU8ThWVIUdvYbaOqkp5smXVm2z99iOUaoS
 2LJF8hStBRDzkeSe73uA913/6Aa3SIQMU4UQ22V/19xuVkZzLHDxKsVSjZ0uhg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763612106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=naKLK0nkQIf6qJW7FIZQ8gqsm0iuE8tEj11BXtGXQnw=;
 b=ID+PSy4wy0ZtdlHtrKY8/9Er7X4T91zZDnxcx6T45S8jWccfTbZxhEaGTpiQAnfnMGXHwG
 RYh113IsRjVGtjY6jnc04mj9A3UVoqi7qoMCM0+7cmCskKCKMSUslPghD+1FkQJP6pn48J
 AjWmCI51yAv4Xy8DRGhYBtB6W1sQhm/teihiy2ZPVGE8quT+CavoV3f0oFXIpMxD+vxW91
 jBtw6i/QL1J+ODvjtGQmaXl2Y4pfXKpR960YsLPtT49fo1Aa4pDS2M4HP1kpeg0KsyW36j
 4Re5UDSAzwPVFKpj3svo3Rl0njyZZn17TTAzsNlz5y/qFP881/RrXGcdzLWMlw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] gpio: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Date: Thu, 20 Nov 2025 05:14:47 +0100
Message-ID: <20251120041504.817264-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: t7h9p33u8b1tiiyj5kaw3dc1n8ksrex8
X-MBO-RS-ID: 893fe9a46d8a768e709
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

If CONFIG_OF_PLATDATA=y , then the udevice has no valid OF node associated
with it and ofnode_valid(node) evaluates to 0. The dev_read_u32_default()
call ultimately reaches ofnode_read_u32_index() which invokes fdt_getprop()
and passes result of ofnode_to_offset(node) as an offset parameter into it.

The ofnode_to_offset(node) returns -1 for invalid node, which leads to an
fdt_getprop(..., -1, ...) invocation, which will crash sandbox with SIGSEGV
because libfdt can not handle negative node offsets without full tree check,
which U-Boot inhibits to keep size lower.

Since gpio_sandbox_probe() already calls dev_has_ofnode(dev) and assigns
uc_priv->gpio_count to CONFIG_SANDBOX_GPIO_COUNT accordingly, add matching
dev_has_ofnode(dev) check into sandbox_gpio_of_to_plat() and do not call
any of the dev_read_*() functions for devices without valid nodes there
either.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/gpio/sandbox.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/sandbox.c b/drivers/gpio/sandbox.c
index f5be2781443..4f35fd2f4ee 100644
--- a/drivers/gpio/sandbox.c
+++ b/drivers/gpio/sandbox.c
@@ -327,13 +327,14 @@ static const struct dm_gpio_ops gpio_sandbox_ops = {
 
 static int sandbox_gpio_of_to_plat(struct udevice *dev)
 {
-	if (CONFIG_IS_ENABLED(OF_REAL)) {
-		struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 
-		uc_priv->gpio_count =
-			dev_read_u32_default(dev, "sandbox,gpio-count", 0);
-		uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
-	}
+	if (!CONFIG_IS_ENABLED(OF_REAL) || !dev_has_ofnode(dev))
+		return 0;
+
+	uc_priv->gpio_count =
+		dev_read_u32_default(dev, "sandbox,gpio-count", 0);
+	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
 
 	return 0;
 }
-- 
2.51.0

