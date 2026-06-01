Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42613CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBB9184A5B;
	Mon,  1 Jun 2026 14:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qxe2n6yo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F34B84895; Mon,  1 Jun 2026 13:52:42 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160668487C
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 13:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+petr.hodina.protonmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AA20A4440B;
 Mon,  1 Jun 2026 11:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84359C2BCC7;
 Mon,  1 Jun 2026 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780314758;
 bh=1cAXN/8NSFvlQndwP5JVvcMwpNoZkuVnSJTOyzanONw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=qxe2n6yoEby0i6aGFEgxU5+5g6OYZgBLOcwss3bdG8ftgeQ2crTqZKuSCb4M3tESD
 5+o4CJF4zpJrQE5DKvKJTZ6md2IvAYf3keMGNg6KKYTMb16H3Esyz2WdPBMEwIJnsE
 lZ1uMU07CsJ+RX8yWdYQXDO4Pmc+stlpTEoz3BsV35xFZXxkH7at7ljEANLPLZF0oF
 YudWicESKrHIqirYVS6DFixkpBIpWG4utI8OGmgsYDcvGj9MYB6nBTyH14t3F4SRM2
 LHqt3TQhd6YxE8RN58DXFEY/TcyHJpYOumlLy4XD/3ffYcOd8DdgXz8VfYxnVOYvLM
 9FZxdxpNVBuDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE82CD6E65;
 Mon,  1 Jun 2026 11:52:38 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Mon, 01 Jun 2026 13:52:36 +0200
Subject: [PATCH 2/2] gpio: qcom_pmic_gpio: don't reset pull on direction change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-qcom-gpio-v1-2-e24bcdb35da0@protonmail.com>
References: <20260601-qcom-gpio-v1-0-e24bcdb35da0@protonmail.com>
In-Reply-To: <20260601-qcom-gpio-v1-0-e24bcdb35da0@protonmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, phone-devel@vger.kernel.org, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780314756; l=884;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=gfww1vaKc2KBXsBrPUOGZ84bFFgF2PKWqI3AaBSBrPE=;
 b=jHHTaHG0AoqAD11uxsXZ2qXBg7gbZWuiLEJuhvUIu5J3HurRf7TK/1pdnDlixgQxt7DjLdlka
 DXk7gj+VN8LC3etU4cLgl4lWhV7Q1QbUJHsd9+qhRp0giKVqImH4Bb/
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Petr Hodina <petr.hodina@protonmail.com>

Fix for pull-up/pull-down/disable as that's independent of the direction.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/gpio/qcom_pmic_gpio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 71cc76fef2f..e67e138ede2 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -129,12 +129,6 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned int offset,
 
 	_qcom_gpio_set_direction(dev, offset, input, value);
 
-	/* Set the right pull (no pull) */
-	ret = pmic_reg_write(plat->pmic, gpio_base + REG_DIG_PULL_CTL,
-			     REG_DIG_PULL_NO_PU);
-	if (ret < 0)
-		return ret;
-
 	/* Configure output pin drivers if needed */
 	if (!input) {
 		/* Select the VIN - VIN0, pin is input so it doesn't matter */

-- 
2.53.0


