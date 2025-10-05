Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24229CAC5B8
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 15:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD36835B0;
	Sun,  5 Oct 2025 17:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="lTqWHtLJ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="YaDZEqDh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ED0D8206E; Sun,  5 Oct 2025 17:46:33 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0432808AF
 for <u-boot@lists.denx.de>; Sun,  5 Oct 2025 17:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrian@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1759679099; bh=Qapvlf6U6fdhyA7/aBIMTJh
 o6LLGw1s+UYUVcUq/iw8=; b=lTqWHtLJZZqxha78TKETmsrilk0JMMwacvQUxBMt5A02T+4noX
 KmPSma1cyDoUC+oAv8+VORpmtoIPpEwhjHmzQP5C6KngfzGwK5/lXndRySNERlpIsNShWKyLauo
 y098rAImGbpi7KFvsxA3pdJgM/8sbnmeBJVBJRcVvetFEKo0rvXfmssnI0zmDnR0difePv6V9EU
 JpDpxb00BNLMvPox+PzDjAs6hb67Cf7q4L5lqC+aeGuywRrlEDHjnOJm4EHVhHESuFj3452bQe4
 XyqyrVSq+x+VEQAEOuRhZYi233ET5Q/AfSDc6EMPbkcEGrJ+/GdZHO5wDRSDw7zbh5w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1759679099; bh=Qapvlf6U6fdhyA7/aBIMTJh
 o6LLGw1s+UYUVcUq/iw8=; b=YaDZEqDh0PjG+7ZDc1SHz0IClEe7ltBrHOqOfN3uMC5STmBSba
 GqpASkLVmxxhy5aZAEY4VEre/E/8u/j2GTAw==;
From: Jens Reidel <adrian@mainlining.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Rui Miguel Silva <rui.silva@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Jens Reidel <adrian@mainlining.org>
Subject: [PATCH] gpio: qcom: qcom_spmi_gpio: add compatible for pm6150l
Date: Sun,  5 Oct 2025 17:44:43 +0200
Message-ID: <20251005154443.71477-1-adrian@mainlining.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Oct 2025 17:48:18 +0200
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

Add support for the GPIOs in the PM6150L to the new driver.

Signed-off-by: Jens Reidel <adrian@mainlining.org>
---
 drivers/gpio/qcom_spmi_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index 22c8072534e..69222b4df55 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -743,6 +743,7 @@ static int qcom_spmi_pmic_gpio_probe(struct udevice *dev)
 }
 
 static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
+	{ .compatible = "qcom,pm6150l-gpio" },
 	{ .compatible = "qcom,pm8550-gpio" },
 	{ .compatible = "qcom,pm8550b-gpio" },
 	{ .compatible = "qcom,pm8550ve-gpio" },
-- 
2.51.0

