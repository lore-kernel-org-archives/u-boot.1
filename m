Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7485CCF2C4
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A2B581426;
	Fri, 16 Oct 2026 21:01:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8gHsPSq3-Xoq; Fri, 16 Oct 2026 21:01:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD9CC813EC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792184494;
	b=s1OnnGsiidmppVByGciGDavmt1wOCKCWix0u6DFVI2CBbhlapA0LsZ3KKeb6p+4l7tzT
	 dKcmoF4CLD4BelB2i6qj4xIWmD2LtUfQX36hfYWLRjN5YxrFs6aF0XUfAuqfOSAz3pK7q
	 wiAhRZ8ENLLMyFcvlS4erYM6aXPU05Akyyyii0SwFx28SjvN3v/eJAxJBFLcSqm5JVC2k
	 kp4GzxX91U8TJeqvJsWW3GU8SfxyfB7pKB3VJc86b+rOyVMr2y1KnbFpV2flYUpqxCy9B
	 gfKmXXDwXHTPvQFZV0pIOSwwecTScYCJAMxgDIlMPsl54ydgmYaB716lNaGcNZPVFXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792184494;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=qlZ3+ZUfVbp4u+SW3UaqPnZBF/dYk44C7YJyT3z349U=;
	b=Hgi4mZY0xMq7usyUZE0rvuWN5nBcE3EfaoGemCbpHIsZqnk8JifatB0yrihNpfj0Gw3S
	 /8V8IEEzcZYmkG7nkPWXRy2f6mBo24+JzGKFW3dvSa75XhT0GEpjhgGEwVKLcpW4pvPOT
	 t6srFRM+dGQ0wovxQU5VhAs9jqhr/E1P8QdZlS2C+R4fXif0E1LJjlUZ/2be01FvUonsX
	 1qF39sRfzKp84h7EM0wnMmTBvEVMG6nPmyAXR6+CYZI13ZPXdL0gLGGVBcMcWSmCjg8Hn
	 h2JqDNxXeqEEtZGlC9LqHPnKx/bBUOt4wp/BQI7Wfcv+PKzqrXr8YLkdSxsoEMcYecA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792184494;
	bh=qlZ3+ZUfVbp4u+SW3UaqPnZBF/dYk44C7YJyT3z349U=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=dtcmc9DvA+9Ctvc5mH45cnm/UmGdvZ8YPQ/If40bBXKFjA8rHF20Cv2hVDRu3j7aQ
	 FenIMQ2iEGo5lv6jSMV60jt2EIgqMPK9ML9ZEpZkFn4TFHtAxdmzCnV7pS4P11Xuj+
	 ldKr1qLD6G9PNydu0JFq0/8GpLXbGGDbE1LAHw/C/Aq1bkLchQq+RAQV+7AydPZL3d
	 U1/11ndJalXde4OfnCK4sMtma+rASzNXbTmfuLO+aHzA1Foy8/+bwLEdjENPylgMO2
	 x2IrkZpWORf19UprOGMCn44wg0e3E4MJ7xxkwZbLIM4xmrhpCmsFhzfcgXFt2MaOXd
	 3yRh6N1MCviDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD9CC813EC;
	Fri, 16 Oct 2026 21:01:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E92D7AD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2502060BC6
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:55:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZRC5gB6FeeGD for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 19:55:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3C87760B4F
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792180522;
 b=fH71zQQ2g+iTcaJU2pA8qrsC47yhP4CeC/h7H7nq+gZjHyFy8jZnuSX8Oo2otbsfv05j
 x++OZ0nc2J93piDf6PQdtKlUz5cXCUJoIqbYw4TZSKVfb0c14qhyFMJitXNIczj0mHosu
 wpT7yBPcdX+U9XwOkdeUK6Tew0Krlx1sGT/Jkzx5HOvtH4ty6f06L7t3egPcecmlCEJ4g
 DkaP2a0OSxDonGIraePXCDoeyH+Rvb6m3WcZ0yd/Ista0v20HSNi3t73XvZxnXiS+ZL3w
 mZxCYrxSwDOrQO97ihdNVQUO9Ie3dh3Novx8x6CKNGyPu5ffA/rn7kXyo/LJx2InPvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792180522;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=qlZ3+ZUfVbp4u+SW3UaqPnZBF/dYk44C7YJyT3z349U=;
 b=NMQR0TW43rpQuDR5kEthVnUBUs6dSdVFNo3/Ec0hkk8TqR6UwTbyIueGZ8vbGMIwhwWo
 SEdNaZpex+1M97JwKG040fpHKdzWIcftlhhfXsIg6glhGM+tBpm5hwWClMaWEeRoFVIot
 yG+uauihUyaCp0mNnvxNy7XouKD/rI2VzucE9ad9nn8dTsqS6it75lUFUBlvrt3Hcrzpd
 AiQPl6YpdbyN33JwkQ9ijY6/u0hcrGQOl7c/CYvALSL7OK6KEhF8qwtQ3K0ud1kIUxWF7
 UOkxXO2NxmT2zELp4vpW0WNR2c858hj550BOFBK1XH2YgpCLM14Nky05Tt7xf9IGchQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Y9pFz2+3; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Y9pFz2+3
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C87760B4F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 19:55:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B4C96022E;
 Fri, 16 Oct 2026 19:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27800C2BCF5;
 Fri, 16 Oct 2026 19:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792180519;
 bh=euHzoV9iA9LLYTTcPphT/uAxxbrNsQ48awlnDp2k29U=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=Y9pFz2+3HOCtfZ+6gmfAj17rHSk3tBuCnrHsa1OQ7nGXhubODqG9Tk6K0iq1Jmf2I
 ayHtuLON8nssMgBcwOGpgA3kLEAE6TT4/0IrFjsHeJ4it8nroYNvtt/bQD2p80mY6l
 Asmixk6RqceHb85AEv+Z44ILm6CMN8LGoWNorXq09LyzOOHnroCkxe/t6RBRuDXrOD
 y2v2lNUGekvdzh4+F4yTR75bpvbHGBzdcZSp958vRDCTAJ3gCgZ6GcKhqrlcyyCv5+
 VjpuHWq2qZWTyP7Fp8YKFfbqSFaBgFwnIiOy75ccC5FMiQqZNjvSrQ2ZvD26n2ZR3K
 TkWp2K1LdcJBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 02A44CCF2C3;
 Fri, 16 Oct 2026 19:55:19 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 16 Oct 2026 21:55:06 +0200
Subject: [PATCH] pinctrl: qcom: implement get_pin_muxing for 'pinmux
 status'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-msm-pinmux-getter-v1-1-586760fcf01b@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrDvgBEmhVyld1PirU0gqmVgE8
 e5N6/JbvLeTISuMbs1OGR81facKuTQU5meawDpUk2udl1Y89x1Hi7xoiuvGE0pB5tHhOkjnJAR
 PNV0yRt3+2/vjtK39C6H8XnQcX+Wv0jx4AAAA
X-Change-ID: 20261016-b4-msm-pinmux-getter-f2e7d1421cc6
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792180518; l=2751;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=EnIZcxXLwtPjMWjmTK3tdxGThpLrYGDGwylS3p7h6E0=;
 b=ED/de8ZT0F+CRwDNl2QGun5fVH0/S5DTPiLIRw39XvYF11JiZ63KBz5u7hA5omWsTJNxdLK42
 VyhPBeYEvCRCnT9Syxp8U+LRj5isWr7HWLoinaw7DlIsCFxWwFHCwlu
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Fri, 16 Oct 2026 21:01:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Implement the get_pin_muxing op so that 'pinmux status' can show which
function each pin is currently muxed to.

Reserved pins are reported as "reserved" without touching the register
as some of them are TZ-owned and a non-secure read traps.

Special pins are reported as "special".

For any other pin the FUNC_SEL field is matched against the SoC's
function table, falling back to "func N" if no entry matches.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
When bringing up a new Qualcomm board it is hard to tell which function
the bootloader or firmware left a pin in and 'pinmux status' prints
nothing useful for these SoCs. Being able to read that back makes pin
mux problems much quicker to track down.
---
 drivers/pinctrl/qcom/pinctrl-qcom.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index c95db56bc47..014082bec8e 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -18,6 +18,7 @@
 #include <linux/bitmap.h>
 #include <linux/bug.h>
 #include <mach/gpio.h>
+#include <vsprintf.h>
 
 #include "pinctrl-qcom.h"
 
@@ -232,6 +233,38 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 	return 0;
 }
 
+static int msm_get_pin_muxing(struct udevice *dev, unsigned int selector,
+			      char *buf, int size)
+{
+	struct msm_pinctrl_priv *priv = dev_get_priv(dev);
+	u32 val;
+	int func, i;
+
+	if (msm_pinctrl_is_reserved(dev, selector)) {
+		snprintf(buf, size, "reserved");
+		return 0;
+	}
+
+	if (qcom_is_special_pin(&priv->data->pin_data, selector)) {
+		snprintf(buf, size, "special");
+		return 0;
+	}
+
+	val = readl(priv->base + GPIO_CONFIG_REG(priv, selector));
+	func = (val & TLMM_FUNC_SEL_MASK) >> 2;
+
+	for (i = 0; i < priv->data->functions_count; i++) {
+		if (priv->data->get_function_mux(selector, i) == func) {
+			snprintf(buf, size, "%s",
+				 priv->data->get_function_name(dev, i));
+			return 0;
+		}
+	}
+
+	snprintf(buf, size, "func %d", func);
+	return 0;
+}
+
 struct pinctrl_ops msm_pinctrl_ops = {
 	.get_pins_count = msm_get_pins_count,
 	.get_pin_name = msm_get_pin_name,
@@ -242,6 +275,7 @@ struct pinctrl_ops msm_pinctrl_ops = {
 	.pinconf_set = msm_pinconf_set,
 	.get_functions_count = msm_get_functions_count,
 	.get_function_name = msm_get_function_name,
+	.get_pin_muxing = msm_get_pin_muxing,
 };
 
 int msm_pinctrl_bind(struct udevice *dev)

---
base-commit: 71433ebf2aed1be5fbd2b1d497eae670ab9b9962
change-id: 20261016-b4-msm-pinmux-getter-f2e7d1421cc6

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


