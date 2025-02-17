Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB37EC0219E
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 11:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D5A180F6F;
	Mon, 17 Feb 2025 12:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IbWzamja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4250680F98; Mon, 17 Feb 2025 12:18:24 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2016480F68
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 12:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 80B195C4316;
 Mon, 17 Feb 2025 11:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B153C4CED1;
 Mon, 17 Feb 2025 11:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739791100;
 bh=hQHrYzA3B9bUZvVhA0XXiCxR23i6//RyPU2CAKUMkWk=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=IbWzamjao8cs9kxZ2FZ+79SVOphzqXkvI9MRSLBOH13625/Upwr4hAcVOVlpm9xxa
 tCRCJD6X3tAGqK1jWrSoVzGeQG3RYrl6jAcSmgSzlfVpTHeK8CLAZ71TEcuUMcHkDs
 LN4pKcqiFhvnNVTLe9ea0B9iyyG2VEnrw1xYHHMCH6+yLApqvYQLp+TuWJHqMb0wmC
 cZI3P3OvxQyPzb3jlezm8Y9I+zadMVwESCTHrlZGIZm6wI5vRQykgke/XXdBjhSxNg
 zr7XNiRbPxEDFtdKGVOJc3zCJcv5u0zdc2HNxszDtb0LTx9cEEMWhuFkltqUo2uSEm
 nG0ahlEGHJv+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBACC0219E;
 Mon, 17 Feb 2025 11:18:20 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Mon, 17 Feb 2025 12:18:03 +0100
Subject: [PATCH] gpio: 74x146: depend on DM_SPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-dmspi-v1-1-58d2a71dc9f6@posteo.net>
X-B4-Tracking: v=1; b=H4sIAOoas2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0Nz3ZTc4oJMXSMz81Rzc/NEE0vjRCWg2oKi1LTMCrA50bG1tQD05F3
 9VwAAAA==
X-Change-ID: 20250217-dmspi-267e777a493a
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739791099; l=1167;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=25ZfUZoVl66vrXVOeP0VBOYoBI6N1iF4HWWpjTXnQtc=;
 b=CEkdF4YsCvw+erpQVrar3184FI4TXa+1gdfy+htXtJpt4fC+1eWsMFQirmgKCxmrdrBtr0mkL
 sbPSy4FfpZvCoK6HG6YorW50rIkmauoT1kbMur4VHLqMCl27IkO8dsO
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

Currently, Kconfig allows building CONFIG_DM_74X164 without
CONFIG_DM_SPI, which results in linker errors because this driver
actually uses dm_spi_* functions:

drivers/gpio/74x164_gpio.o: in function `gen_74x164_write_conf':
  undefined reference to `dm_spi_claim_bus'
  undefined reference to `dm_spi_xfer'
  undefined reference to `dm_spi_release_bus'

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index f4a453e1cdd57702eb3944a23b92ab0b6dfbcc71..21361f56e69c829ca87bddba77e8b2201407bafb 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -516,7 +516,7 @@ config ZYNQ_GPIO
 
 config DM_74X164
 	bool "74x164 serial-in/parallel-out 8-bits shift register"
-	depends on DM_GPIO
+	depends on DM_GPIO && DM_SPI
 	help
 	  Driver for 74x164 compatible serial-in/parallel-out 8-outputs
 	  shift registers, such as 74lv165, 74hc595.

---
base-commit: e62df6169eded226d02240eac54d60be8e9da960
change-id: 20250217-dmspi-267e777a493a

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


