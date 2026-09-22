Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8D9C982FE
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 14:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 810BE40814;
	Tue, 22 Sep 2026 14:28:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YEavpcoM-sAG; Tue, 22 Sep 2026 14:28:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 319344076B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790087322;
	b=thiB/t7YFCEO1JLYP6GYFbwcV4K0oqmEV+azFUZUhMuYO//h2qHEXXkOZnpep1DdmPQ0
	 SXrue7NlCB1r74OF98ldyEssJwqGWhM8kMiIhusbI7shZT0OGOcr4O9R1/9oKscQh9ElL
	 wE+fPJjaIHrHXDAll+QxOHtwAXHmJExy0ctLMWBLQ46GYcQzHLbmzCrsFNPOr6gsGxXtZ
	 xonPk013DB9ko79LlcpAa0M6PD53t0vOyZCMOtvVpHiYbwN19yNGMVTtYclDHYNCwlsa3
	 NpjoKoOMP5mMMR5v7M1qcze4Anno+9ccjINA4rqTAr2xSssUEmw3dGoxWjY9jzowcHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790087322;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AJqjcTm9OBVpDlP/K7FyO6ZNnNDnAl8xevAMtVK/gck=;
	b=deJujwV1gWUNg5e+XGH3d+VfKGFRbz6h7zIRIWdw3Au5SXfJse9ybJl7fTeXaCTz4fiM
	 Q9X4+8YI6A0L8aj3rNlqrJzJ+gxiwOaPvyAY6wQNsOOSPygzzZLfELKcEBTVsBrPhdSn+
	 CzHE3FcYR9ScKykasa+SVl4nSpROitx7Acg1hTnPEBvH7LHoZGVn5cHpU7DWY2mqEobWU
	 QYOrgBzvh71wLepay7CzHfnQbbxgUo77KuDAm5mEmOTFEuxRAr6nbS9BquEGn4dccZx4o
	 XAk4gTpfcudmNxtoBGxFEsYC6qopnsbprSJiKi0ks9IGPyUjqMGULgBI/6NSJwdkSPA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790087322;
	bh=AJqjcTm9OBVpDlP/K7FyO6ZNnNDnAl8xevAMtVK/gck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aJ1BRo2dANjcACC2iY/xw6dliqna/Xm1NW3cnsyD6r04h4tFIDldAekdQi2yMgRwv
	 yRXvWrZAD3FSYpgo0kx2M5YiYUFfBtZrWC8JDZW6FE0hYv32F5ERgGfko8PVzEhW2O
	 p5YBxDjQlA9I/42Jr1Zhy8zedXFf38VGYqKL5xWvWIxlXd9CJmrPSM8QqG3cpbqfaF
	 pNf3DdflmA2cBeahGDFgsYCcaUUSs14prjax8aZKfcdJtDr98dQvajol3JuB2W0UmB
	 Azi0gNyK9hBNl6RcOSrPk4n9CWA9i5giGnNGtMpERkccpmlK2BRzsueKYjuZvzfGyh
	 F5Kq0vCxoPHcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 319344076B;
	Tue, 22 Sep 2026 14:28:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D9A35D1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF70880E37
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:16:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kMLmpBLYHA-q for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 14:16:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7E61380E2D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790086611;
 b=pdv1b4qyh4V7u+LAZOcO+mYw5E8U/8/V1DfG1fMCUnLsR3hP+FLy976sfK5hs9XN4Drp
 PZVLJJ2t3RLLdvvYItyhTywT60IaKk1ItTcSQxFso/Z1kP/hnO7wJD9NIADvAYlAIq6Hj
 RCFrujx9pmW4wQZu6iI8v1Fu702MhwPNkDXe5jqTSGVwCSsRm3VEdf/eriNupL/nBrLZ7
 7yMWlseuQJ3tG5bzz1/9k6Te7QoLcDyF3Yb0X1lMq/7YADiuvdmtztjlnQcSGQA3so7HU
 FMHF2MeVDi8ZFtNXlx3uvZDG5QzWPcNENPRD1OSgc58q88a5mZCCec7Fp5IloqgvtMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790086611;
 h=Received-SPF:DKIM-Signature:Received:X-QQ-mid:Message-ID:
 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=AJqjcTm9OBVpDlP/K7FyO6ZNnNDnAl8xevAMtVK/gck=;
 b=H0kipwXoVy772Lp14aFnjTV3YjIdec+c2yN6JWgoO9YAcOCTobVT+vsz7y4o2NHm6vSB
 sxdO1LVy3PLpiUInkRmjB1KUYfg4rx7uBJA1vAR4uvNs6KPX9TE7lmFHHgiz0TdCdEmlK
 xSKt1DLLsbV2z9I5OCZguquJiLxA55iBzGvEMIke48OoARZ0/tHv0jZyqb4WGEJuy01UF
 fCXu75XVYBou9YeDCxkF4cAI+zf4vEew9hj5NAiEL30Dayt94VEl7BY1/5hoYXzZGakQs
 ibqNUng/J9nDKypsDtL0NNFgQ4RcXQ5HZPCrY3DnGD6zf4PytzcKpkxZUgasn/PsWPQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=qq.com; 
 dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=wol8xZ5m; 
 arc=none smtp.remote-ip=162.62.57.87
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=162.62.57.87;
 helo=out162-62-57-87.mail.qq.com; envelope-from=3305708832@qq.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=wol8xZ5m
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com
 [162.62.57.87])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E61380E2D
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1790086605; bh=AJqjcTm9OBVpDlP/K7FyO6ZNnNDnAl8xevAMtVK/gck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wol8xZ5mdH6XXLbNeItZXoEOkAk0oNEqELVefK5OkbrPRdkc98xkEzMwZPsB0CxkI
 lQszGnNLHvXpOLJMKjSXDl5LlHRw/ueIqomm8iVzUqS06OOk6av8CSl9O3fMoyUdUX
 dGzAe+5sV/sfwzlIvQ+6prCQL5EvP5YZjyC6qKrc=
Received: from kongchen-VMware-Virtual-Platform ([221.238.4.182])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 4298ECDB; Tue, 22 Sep 2026 22:16:41 +0800
X-QQ-mid: xmsmtpt1790086603tos37lkun
Message-ID: <tencent_945BB774784698678ED0EEF498C60A17E106@qq.com>
X-QQ-XMAILINFO: Npv5yIQT4nxMglWKpK/k68CDokbbxgX5f6fpLHL4HkkwJluO+cTTs5yJ6GqJ+F
 mwnpu+K6BVsmRqHEku9ZulmjrwPiy0Rb+bwvMXBWNN9LY9HVBE5mh2ywIR4jdSWnjnmrj8HKAmnz
 8PK1N0VTnw249BCeTmpXRq26xvvRN0Vg0MdbkeFDusBPaJbzaY4+yeFfJGr72pHRPgOMawVMembK
 S6K6GONqzylE2NtyKJsCijCFvj1kqkJiRlisIXIpERZ+O0WaRIrWXOp+V5lNk/4T3fpbJWBzY/Us
 qKBuvgPSlUagpd1253FT93+TvHs5rK8DwKlGCZL3Hu/JeNcMfBh0IPiatyPH5zf11dra/uNFAMns
 fvqDaXBPnIqK4ihH1CzSOw8/MfHL/8xZB61PJCfxeePuaiiG80TUTdFYKqbYDvyhtHEzbNJqmden
 PZsIqDkAWkjh88T5z4r+UB8PyvJCY95huygux0FiULgqx0EUgskY2cp+W0yP6qUQx6Av01V+e2RY
 GE81G4/NK6YxeAgUitQHgz8JS9X+AtvB/AFAlkMjPElYHpxQ288oVWlG1krmXxL3UC08xQQqH2X5
 9tMOgp6InrPDnInUWIHQYoh+AfUZHDhcZ5ID+duHPImibwWg6vsQ8rOmnLIhZPlTQUWvcin3rmK5
 RFxVQYPReASh2UM+A0p7MNDiwr74bDVedXl9RYAwOQ4Ch5KanzHJr/26yKcTbSP+KeeK5Cn1QY9Q
 3BC9p8LRe6Sonq/A09XfAatb+Fumvi2BSlDiMOubQRpsSWSQQlrzQLWVBJFqHLpCyPbex7HH0V0N
 fjvnOvg8HaiYtWC0jrv+r3ArV6GgOE3t8F0vd5rhnzRXX7PXluXUkYNjfeQ5GgNUnUQpy6Olhn5G
 vSAE3Qor73UAk1hyR3WSUCe1cirTlCaVgOvlT4Vquf9WeLTWZVuwYH8O6fvOd3AJYrI/V+phUsn/
 fZBHfrMUiuK5/t3p5j2B0Njwd9B9yXw/1CmO1nGXRRpQWZUq3WlmeFIvJQGPJbYjtGTvnJcF81eh
 QwZWCP9wat2vQewrEylaP71loxIudZRSgLmBAyEnsmOG/TE8StknBLZIzWhiH7S2+PW0zw7rIH4z
 It0u2a
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: kongchen <3305708832@qq.com>
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com,
	trini@konsulko.com,
	quentin.schulz@cherry.de
Subject: [PATCH 1/2] net: dwc_eth_qos: bring PHY up before triggering DMA soft
 reset
Date: Tue, 22 Sep 2026 22:16:40 +0800
X-OQ-MSGID: <20260922141641.8624-2-3305708832@qq.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922141641.8624-1-3305708832@qq.com>
References: <20260922141641.8624-1-3305708832@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 14:28:39 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

DMA_MODE.SWR resets the whole MAC core and only self-clears once all
of the MAC's clock domains are running.  On SoCs where the RGMII RX
clock is sourced by the PHY (e.g. Rockchip RK3568), the RX clock
domain stays dead until the PHY has been brought up: PHYs like the
Maxio MAE0621A need a vendor-specific init sequence (crystal clock
mode plus analog tuning) before they start outputting RXC at all.

eqos_start() asserted SWR before phy_connect()/phy_config(), so with
such a PHY the reset never completed, eqos_start() bailed out, and the
PHY was never initialized -- a structural deadlock (raising swr_wait
only delays the failure).

Move the SWR, together with the us_tic_counter programming which must
follow a successful reset, to after the PHY has been connected,
configured and its link is up, just before eqos_adjust_link().  This
mirrors Linux stmmac_open(), which runs stmmac_init_phy() before
stmmac_hw_setup() (containing the DMA reset).

The i.MX8M Plus GPR[1] interface-mode value latched by SWR is written
at probe time and is not touched by phy_connect()/phy_config(), so the
new order is safe there.

On a Rockchip RK3568 board with two MAE0621A PHYs the old order always
fails with "EQOS_DMA_MODE_SWR stuck" and no link; with this change the
interfaces come up and pass ping.  Moving the SWR block back to its
old position reproduces the failure.

Signed-off-by: kongchen <3305708832@qq.com>
---
 drivers/net/dwc_eth_qos.c | 51 +++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index e7cf68d011c..f370593649c 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -702,21 +702,11 @@ static int eqos_start(struct udevice *dev)
 	eqos->reg_access_ok = true;
 
 	/*
-	 * Assert the SWR first, the actually reset the MAC and to latch in
-	 * e.g. i.MX8M Plus GPR[1] content, which selects interface mode.
+	 * Bring the PHY up before triggering the DMA soft reset: on SoCs
+	 * where the RGMII RX clock is sourced by the PHY (e.g. Rockchip,
+	 * with PHYs that need a vendor init to start their clock, like the
+	 * Maxio MAE0621A), DMA_MODE_SWR cannot complete until the PHY runs.
 	 */
-	setbits_le32(&eqos->dma_regs->mode, EQOS_DMA_MODE_SWR);
-
-	if (eqos->config->ops->eqos_fix_soc_reset)
-		eqos->config->ops->eqos_fix_soc_reset(dev);
-
-	ret = wait_for_bit_le32(&eqos->dma_regs->mode,
-				EQOS_DMA_MODE_SWR, false,
-				eqos->config->swr_wait, false);
-	if (ret) {
-		pr_err("EQOS_DMA_MODE_SWR stuck\n");
-		goto err_stop_resets;
-	}
 
 	ret = eqos->config->ops->eqos_calibrate_pads(dev);
 	if (ret < 0) {
@@ -724,13 +714,6 @@ static int eqos_start(struct udevice *dev)
 		goto err_stop_resets;
 	}
 
-	if (eqos->config->ops->eqos_get_tick_clk_rate) {
-		rate = eqos->config->ops->eqos_get_tick_clk_rate(dev);
-
-		val = (rate / 1000000) - 1;
-		writel(val, &eqos->mac_regs->us_tic_counter);
-	}
-
 	/*
 	 * if PHY was already connected and configured,
 	 * don't need to reconnect/reconfigure again
@@ -786,6 +769,32 @@ static int eqos_start(struct udevice *dev)
 		goto err_shutdown_phy;
 	}
 
+	/*
+	 * Assert the SWR first, the actually reset the MAC and to latch in
+	 * e.g. i.MX8M Plus GPR[1] content, which selects interface mode.
+	 * The PHY is running by now, so its RX clock keeps the MAC clock
+	 * domains alive and the reset can complete.
+	 */
+	setbits_le32(&eqos->dma_regs->mode, EQOS_DMA_MODE_SWR);
+
+	if (eqos->config->ops->eqos_fix_soc_reset)
+		eqos->config->ops->eqos_fix_soc_reset(dev);
+
+	ret = wait_for_bit_le32(&eqos->dma_regs->mode,
+				EQOS_DMA_MODE_SWR, false,
+				eqos->config->swr_wait, false);
+	if (ret) {
+		pr_err("EQOS_DMA_MODE_SWR stuck\n");
+		goto err_shutdown_phy;
+	}
+
+	if (eqos->config->ops->eqos_get_tick_clk_rate) {
+		rate = eqos->config->ops->eqos_get_tick_clk_rate(dev);
+
+		val = (rate / 1000000) - 1;
+		writel(val, &eqos->mac_regs->us_tic_counter);
+	}
+
 	ret = eqos_adjust_link(dev);
 	if (ret < 0) {
 		pr_err("eqos_adjust_link() failed: %d\n", ret);
-- 
2.55.0

