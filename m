Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDC6CAC594
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 13:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0AB98340A;
	Sun, 14 Sep 2025 15:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="CtDP1rDx";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="O1H6Wmn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04ACF81E13; Sun, 14 Sep 2025 11:44:50 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 228E780B9B
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 11:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david.wronek@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1757842981; bh=auEfKmJy6fsSVfb/5KIymXN
 nlHJceSc07zyJmR000sE=; b=CtDP1rDxQshYvrEkvChwAw3yWUu+DLaUcZqH3TiK/AESxVOFuP
 IGsM/cF7Dk2k5lcuTy3rQ/ypsWWpTjszn/Ih9mpzoFxjtaSQ8MnoXCWz+ApXSekfXU5RZ7GChio
 b/1FexxAzikVcaLY7ptC5quKmtd6VXPQ/DQxwrARyNOssmoQeXeAo5njUQ4VgACaw86KCt+X+zm
 2e37X0TonmikqwCdvA1oz0JEPAQtluBFcsMguOGMElOItnIBrGmEAgRK077iBNNdcLV/0j0jDut
 /SBoTCxn8IOtJFVvABh4DnZ5GEQBf0kpZ7okWySKh61KDokOL2kR8A+99tmXr+u+y3Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1757842981; bh=auEfKmJy6fsSVfb/5KIymXN
 nlHJceSc07zyJmR000sE=; b=O1H6Wmn/feILCoyz2Ufjyr3Un+eixi9o2LAdP8qbBZEj9Ev5d6
 8vSUGI4UdkWgJCQQFOb+BrwXQKCHsmUD84CQ==;
From: David Wronek <david.wronek@mainlining.org>
Date: Sun, 14 Sep 2025 11:42:36 +0200
Subject: [PATCH 5/5] gpio: qcom_spmi: add pm660l
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-sdm670-v1-5-a344024062ab@mainlining.org>
References: <20250914-sdm670-v1-0-a344024062ab@mainlining.org>
In-Reply-To: <20250914-sdm670-v1-0-a344024062ab@mainlining.org>
To: Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>, 
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 David Wronek <david.wronek@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757842979; l=775;
 i=david.wronek@mainlining.org; s=20250914; h=from:subject:message-id;
 bh=FKeFJ+ifFXnwJxPAZODBL8w47V1gnnvUWCrP1/3PC7M=;
 b=xb1oXMNsgpGDvmD/tVpy1hezDiNRAc26eeWkM+5Ax+Zgeg4RcICaQQChEYVWEzSyVFC/P1tn/
 gLUP3YXwm27DBEsL4KzyTzhym1y8yTzYK2RD90J6QAq/v/3bAmWpiK8
X-Developer-Key: i=david.wronek@mainlining.org; a=ed25519;
 pk=NtKhS1PfXjRIaJwWcYTu7JS0cX3GEmccZo+a6erVTfU=
X-Mailman-Approved-At: Sun, 14 Sep 2025 15:13:36 +0200
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

This is used for the volume keys on some SDM670 devices.

Signed-off-by: David Wronek <david.wronek@mainlining.org>
---
 drivers/gpio/qcom_spmi_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index 22c8072534e9188445f0aaef5336863fd1da7a75..220b77dfa9338498cd44353050ff8b12a1769a82 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -743,6 +743,7 @@ static int qcom_spmi_pmic_gpio_probe(struct udevice *dev)
 }
 
 static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
+	{ .compatible = "qcom,pm660l-gpio" },
 	{ .compatible = "qcom,pm8550-gpio" },
 	{ .compatible = "qcom,pm8550b-gpio" },
 	{ .compatible = "qcom,pm8550ve-gpio" },

-- 
2.51.0

