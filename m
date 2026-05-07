Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A5DCD37AA
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DD2E84C00;
	Fri,  8 May 2026 00:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SNXUioD3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r/cZIvMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E022D84BE5; Fri,  8 May 2026 00:05:59 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 017DE84B86
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBRCS1Gl3z9tkg;
 Fri,  8 May 2026 00:05:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xk7PwbfpaeDn2vR+pP3hiDLLCzUVD0xJ8A0CsJq9gSg=;
 b=SNXUioD3o/TjbdBJlHAmkfyy1qKba7ajE0cwPwIm8VqmFeV0/lneUkMSJHvYGLv04TR2pk
 r1kb+4JEkZ+aG3IkcmmrsHhKD3zL+aA0DYS5U9BDo4UEjNoB86xwR1nhdgjdNfr8Wwux+2
 K2QVDM9hbEsfezCPZopWGevAEPYfVWXBmEYL95GObNOghSwA8qR5TBFDnh2CdJ9R/xkkaH
 vKaMsd+VzK0esGGjUsYXF8NmQcOjU5I/UouS/7jesWONC6Aqi32l4jEHH/pPj8kSw0CNj2
 ZzcmgI+FkcsuT4kmszKasZ1krRaBx78kGu/Y0fh9KPpeEuBU9PIGxiIlE3SyYA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xk7PwbfpaeDn2vR+pP3hiDLLCzUVD0xJ8A0CsJq9gSg=;
 b=r/cZIvMSb/i4jCBAxdgH+/2UKDxwMyndsovRuwHlL2GC0wW1v4xLDK2BS89i9UnxAC8KTQ
 fJymHp6MHzRTBxA5J2HQAWKkcgi2MJyclqYILAVr+QrhCVKOaiz6BcjUaWXrDfECS+194D
 Ba9Al8l+tCAK8y+JXQP47uXiYLE5rKPdsEpQ6pX7Wp4A4TyY4OITBcq5ocbT5WLBrcG0NR
 g/NCjq6D+uYj5w0+ERvUahLBBqvBv/JvyLyoZbdRK5+myDummICFdMZ+ih0tsjD9MesTmx
 7wx1cHq4KdK4JUwnYxpt0LPCXDS59F1vpE2R3wi/mPnCWrOrBgdi1HbAb1RsMA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH 1/2] gpio: qcom_pmic: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:05:31 +0200
Message-ID: <20260507220549.209113-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: objc9a1tn5oim563ue5cu1samcenkzn7
X-MBO-RS-ID: 2970294a7dd0209f390
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rui Miguel Silva <rui.silva@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/gpio/qcom_pmic_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 4458c55cd3d..3cabb7df88c 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -410,7 +410,7 @@ static int qcom_pmic_pinctrl_generic_pinmux_set_mux(struct udevice *dev, unsigne
 	return 0;
 }
 
-struct pinctrl_ops qcom_pmic_pinctrl_ops = {
+static const struct pinctrl_ops qcom_pmic_pinctrl_ops = {
 	.get_pins_count = qcom_pmic_pinctrl_get_pins_count,
 	.get_pin_name = qcom_pmic_pinctrl_get_pin_name,
 	.set_state = pinctrl_generic_set_state,
-- 
2.53.0

