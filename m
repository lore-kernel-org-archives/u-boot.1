Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB229CD6E7C
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 17:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B190849BC;
	Fri,  5 Jun 2026 19:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="THnUYf9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C138484981; Fri,  5 Jun 2026 17:09:23 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CD1C8495B
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 17:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+petr.hodina.protonmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CE037438A4;
 Fri,  5 Jun 2026 15:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3AFEC2BCB4;
 Fri,  5 Jun 2026 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780672158;
 bh=C8mUzmX2BzwAFXvJ9e/+t0DOKCq7LZ1fiW5O/u8HuMA=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=THnUYf9aCKYSpIXMdhHwqQmI04E/jFNCu9eGPvqJVA4tTf20727fC2wR6bLs9UlGM
 PQkr0eODqP+UaMGYOSiw5YwXgFeWPZrpgf617LixFuzpehAVcxdrdH7lm9KcreAl27
 NOpKuo2RluXsHlRHsMRTpxZPvI4QkMxgeHJRgG+6dZZpGrcbdP7MTlWbSWJHu8x4qu
 rXOEKYCk5921LqXjZom19nz1M0ekkQWtoIIq9fgJ0VEV3PMZ3wHw4b93tRTVD5N0VJ
 WEJyntQwCm3qvHrXNV/jPoyl5ehbxa1kdT6IRlnivytG+MlXmYm9Zz80SBb3maerzr
 5IVE4G1SXJGkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8F61BCD6E7C;
 Fri,  5 Jun 2026 15:09:18 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 05 Jun 2026 17:09:07 +0200
Subject: [PATCH v2] gpio: qcom_spmi_gpio: move PM8998 GPIO from legacy pmic
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-qcom-gpio-v2-1-c34093041c66@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAJLmImoC/22NSw6CMBQAr0Le2ppSAdGV9zAs+nnCM0KxrY2G9
 O4W3LqcZDKzgEdH6OFcLOAwkic7ZRC7AvQgpx4ZmcwguGh4w0v21HZk/UyWnVpsa6mEaKojZH9
 2eKP31rp2P/YvdUcd1sBqDOSDdZ9tFsvV+9eNJeMMRaW0UYfaSH6ZnQ12GiU99tmCLqX0BRMxw
 NK5AAAA
X-Change-ID: 20260601-qcom-gpio-98e85ab22647
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, phone-devel@vger.kernel.org, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Jens Reidel <adrian@mainlining.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780672157; l=2955;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=f1sNnGIfocv/L5Gx2f4Rimv78qhXAQcS9qTF8ZwCfwA=;
 b=ROFiNlQ48fEd7xr/1wgsG6is9rlRXOcx+sP3Vjf2g9P5XF+s5BNIUloDn6Pwit+cCzMZRvrf0
 D4GxUPEvHi8CjoD9/PU03B0rS0jgZvwDfESBF/KOUu0a7EABlnPyqIf
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Fri, 05 Jun 2026 19:15:22 +0200
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

Move the "qcom,pm8998-gpio" compatible from the legacy driver
qcom_pmic_gpio.c to qcom_spmi_gpio.c. Enables on PM8998-based boards
(sdm845: SHIFT 6mq, Pixel 3, OnePlus 6, Poco F1, Sony Xperia Akatsuki)
the Volume UP gpio-key.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Move the "qcom,pm8998-gpio" compatible from the legacy driver
qcom_pmic_gpio.c to qcom_spmi_gpio.c. Enables on PM8998-based boards
(sdm845: SHIFT 6mq, Pixel 3, OnePlus 6, Poco F1, Sony Xperia Akatsuki)
the Volume UP gpio-key.

Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Reworked per Neil Armstrong's suggestion on v1: migrate PM8998 to the
  modern qcom_spmi_gpio driver instead of extending the legacy
  qcom_pmic_gpio.c.
- Dropped "gpio: qcom_pmic_gpio: implement standard pinconf parameters".
- Dropped "gpio: qcom_pmic_gpio: don't reset pull on direction change".
- Replaced with a single qcom_spmi_gpio.c patch that claims the
  qcom,pm8998-gpio compatible.
- Link to v1: https://patch.msgid.link/20260601-qcom-gpio-v1-0-e24bcdb35da0@protonmail.com

To: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Rui Miguel Silva <rui.silva@linaro.org>
Cc: Petr Hodina <petr.hodina@protonmail.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>
Cc: David Wronek <david.wronek@mainlining.org>
Cc: Jens Reidel <adrian@mainlining.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 1 -
 drivers/gpio/qcom_spmi_gpio.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 4458c55cd3d..6215f794e09 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -344,7 +344,6 @@ static int qcom_gpio_probe(struct udevice *dev)
 static const struct udevice_id qcom_gpio_ids[] = {
 	{ .compatible = "qcom,pm8916-gpio" },
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
-	{ .compatible = "qcom,pm8998-gpio" },
 	{ .compatible = "qcom,pms405-gpio" },
 	{ .compatible = "qcom,pm6125-gpio" },
 	{ .compatible = "qcom,pm8150-gpio" },
diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index 1a7c7c48dfc..8c3323b23b7 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -751,6 +751,7 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
 	{ .compatible = "qcom,pm8550b-gpio" },
 	{ .compatible = "qcom,pm8550ve-gpio" },
 	{ .compatible = "qcom,pm8550vs-gpio" },
+	{ .compatible = "qcom,pm8998-gpio" },
 	{ .compatible = "qcom,pmk8550-gpio" },
 	{ .compatible = "qcom,pmr735d-gpio" },
 	{ }

---
base-commit: 1f89ddd61cd8c27a3dc1fc7edbeccb55d424eb72
change-id: 20260601-qcom-gpio-98e85ab22647

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


