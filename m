Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751F3CC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 16:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D09F5607D0;
	Tue, 13 Oct 2026 16:48:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JMqPbieOamSm; Tue, 13 Oct 2026 16:48:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BAE9F605E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791910111;
	b=Q30M/EZmlHdddCnzBNFo82v1FbOu2jC/ynFeYJekj6WIk3Grzm/68nFbNPd/VjsKRLvU
	 7izAVbjI4q529ZkWR0yob7rWaJcBqsXFgLdYGr8HEOPjllqpBq4QTdm7zBHt2yQI4x0nc
	 cYWXKgC/VtaK7BXL+okPWcfpH6M5FXiFukPp+ovOCPe/tDPSeXe85RiTZLh/SLznvOte0
	 x7xp7E/IvAdTTC9W1uyfyvi8FIbaFpvfmJt8BwjsToZvoYauhSsfihhDnQLKRxeC3SmFj
	 1YmPykokT4R3BOMrPdW/8k9pELS8x4RV+nLdQKGGfQnOd/ruKMBHXCiXkU1/4dqGjCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791910111;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=XUtQaHC8yRyNhylbWZsyPsb7ZA3WsNZEOIcPgiv/Q10=;
	b=VFwXRiJUBhd3Wc+60unbf2YeMSQgy160xw8wHso/m1T1TzVTr1fbOlO6wQELMRr/7IRh
	 smfLWL6eNmdqbjw4/xQtooJ/yN359xsxRSRNYnlZbUIWE6G4SKPXRdAKrgKwSPftXS8Nw
	 dC6E8kOTXqPBwq0QYAULPPFZwtd0ErrXQR7nT0nRDQTEzvLcf0QFnaaBMcP1/cxibMqm9
	 /LQ1yMboAOeNXDuennbPh5ccSLE+kuLdWK0082VJR8fHG7AXTsJltt/HbsGGO9My9uGjh
	 te1RVr26MfReYaXbAsO5UiAvozFHCKVq1eatLVod7FtTyX1nKWBg+LrVHyDgpVeIkAw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791910111;
	bh=XUtQaHC8yRyNhylbWZsyPsb7ZA3WsNZEOIcPgiv/Q10=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=VMdITMyRG+Fz0wcpMAZ4f7bh2GH1m0OzGHLs3g/72cqAPjPenYCRjOgJvwqAg/DVa
	 2C1fggoSbp/sOyekjqHR9vpsR1Isy3LRxRHLvDHB7nYWblrve0X8WXHHwFTGahcKI/
	 /dQy+AE+/JWF7230Y6+mL5QmFEtT0JZOPuv4b+9HoyIAtUndIzNkG2NqRRiTtihk9Q
	 y2T2szV3R72eXaRmab9/hP7yBtdk6OTs+8FuXzNu0CktaQdzKoHCQdwDfDQM/9aQe9
	 +3oxf/QM1xieeXRlV9uXzbwCri9ALNKc5XFvxytDspRS22fqOD5qWBnzs2woNvYB4Q
	 OGCw6L6LzX9dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAE9F605E5;
	Tue, 13 Oct 2026 16:48:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A662FDE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CAB3404F8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:14:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GX4EGNXat-ge for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 16:13:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BF7A1404F7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791908039;
 b=BS0Z4OGVjjlhBBlVj/wBrWlzWy4Kw595DpzkcsM3sbWD3H2ZeXSYvyxv2gP5rdj6rZpc
 kVmFBZXEp+W8ipCfQPFtLJR2u6Jn4FGH9Rltvk+IuRsaiEw+tkRnfU4ido6m55/OLq52y
 EyoZdNTWN6tSVxsa8fp+xq3y31LdxH58YLsx4Lr1/2esyh+VMDvJ0XmpD+g3FJ/Wje9Ot
 /uXmM0nkQoW8bt939jVO+Vmj5I96p0hGXJNseh24YE/O88QQPTYJNaxm8bVIXnvI/deex
 bZ8qQYf83QPNGVKP58BmZTFEnss6iqJDxmxvCnNyM1nz1V97QhyvgN6EYtjCMercZ0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791908039;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=XUtQaHC8yRyNhylbWZsyPsb7ZA3WsNZEOIcPgiv/Q10=;
 b=g1j9Kbu8qHLv9Ib9FAWIRTAiG0YPVuoZm8jq9nJOJF80jb7qE83DCVfPUgS90jjvYEjK
 REfftc5iowx/lcjIRkAhOcT5vQfvi21OnWTRUE70HY5rC6mFmO4ct0iMr41Ri7UCtFpju
 vL+4GrBJrefrMs9kdxFBMlfBxcvAnD+GqZ4jxHSvFZgtO7vrbZW5Zl59JiQWy05QIvh/D
 xWocGPPHyFfhAKRBbFWIzSWptgAnm3K8hvvFnx+X8XnRwD0U2XmUv26x1nSs0zCMTgf+e
 clyKg/TgUUOrylIJG5KmXOUdDcxGxzg0ftwAhkVGnLt9Ccm4jCQ2CLdJfNtPN53Y8gQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=D5CyeEOg; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=D5CyeEOg
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF7A1404F7
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:13:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A11ED42E92;
 Tue, 13 Oct 2026 16:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F2EFC2BCF4;
 Tue, 13 Oct 2026 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791908038;
 bh=T12O1T2MHkq2RSTRx2IbJ2K4MkiOauWq+Pxi6sKlsAg=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=D5CyeEOgvJHmGxLjU5ScM3vXflldLIDPX97tebyzjHttMTtjcHRrC58XnjOrqT52h
 2MyLUBJGVhik+5xd3BXSbsKzoSHjkXMPwjZEXwUZf0mWNyna4OVXo9m1RYYwZsPoGX
 C8la4zngWi9xapn8JZqjhLlqH4cGGr21TQWPtHfn276zi5QGxo46Qkw+2yrbZ6JUaz
 6m0WaLpEfqHo2fkiTckwDRntMnJiDhuPIxybnr/pVX/pZkSOJSkdoTrwaUiZIX3s1M
 R625tXrVjlPd+H+BrKUKtUmbymOiZo+iUdVYCXSaM9p97Uvl4lgnUE6KqChlvU1ejH
 KXA3d3B06ET+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7F0CC6B19;
 Tue, 13 Oct 2026 16:13:58 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Tue, 13 Oct 2026 18:13:23 +0200
Subject: [PATCH v2] button: adc: implement get_code()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-button-adc-get-code-v2-1-72a1352d5965@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6DIBBFr2JYdxpQME1XvYdxgcygNFUMoGljv
 HvRHqDLl7z//sYiBUeR3YuNBVpddH7KUF4KZgY99QQOM7OSl7XggkMnoVtS8hNoNNBTAuORgKv
 aViiVQq1ZHs+BrHuf4ab9cVy6J5l01A5jcDH58DmfV3F4f09WAQJuskIurUKL6jEHn61Ru9fV+
 JG1+75/AfA7oXnTAAAA
X-Change-ID: 20261010-b4-button-adc-get-code-056f3d455daa
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791908037; l=3672;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=9JePnEKjXiJ/W2mAz2OuQbRVLmFiWrSIiKO5Q6MgnM0=;
 b=8Ei60eMDseMoth/TDkrO13G6fAyI+8z74Nm81uT7Tm1lR6tktBMC0CtC0Bydw15TWpNDD+xaH
 N+rhn3GNc3xBaH2dUKUSqLSrMcmm7oaBDzXXQTFi6zEpChv3z6qqdyT
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Tue, 13 Oct 2026 16:48:30 +0000
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

Implement .get_code in button_adc_ops and add linux_code
to button_adc_priv.

The consumer in this case is the PinePhone Pro platform with the
volume up and down keys for selection in bootmenu.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
The keys on PinePhone Pro are not registered as Volume Up and Down
as the keys are not wired to normal GPIO but to ADC and use different
resistors to tell them apart.

However, button_adc_ops never sets .get_code unlike button-gpio. As a result
button_get_code() returns -ENOSYS for ADC buttons.

The patch reads linux,code and returns it from .get_code mirroring button-gpio.
---
Changes in v2:
- extended the sandbox test for KEY_F3/F4/F5 in 'test/dm/button.c'
- switched to dev_read_u32_default() instead of ofnode_read_u32_default()
- the commit message now lists the PinePhone Pro as consumer
- Link to v1: https://patch.msgid.link/20261010-b4-button-adc-get-code-v1-1-843d04f5dfd5@protonmail.com
---
 drivers/button/button-adc.c | 14 ++++++++++++++
 test/dm/button.c            |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/button/button-adc.c b/drivers/button/button-adc.c
index da7ddf2a857..2f33d36238a 100644
--- a/drivers/button/button-adc.c
+++ b/drivers/button/button-adc.c
@@ -20,12 +20,14 @@
  * @channel: channel of the ADC device to probe the button state.
  * @min: minimal uV value to consider button as pressed.
  * @max: maximal uV value to consider button as pressed.
+ * @linux_code: linux,code devicetree property for this button, or 0 if unset.
  */
 struct button_adc_priv {
 	struct udevice *adc;
 	int channel;
 	int min;
 	int max;
+	int linux_code;
 };
 
 static enum button_state_t button_adc_get_state(struct udevice *dev)
@@ -49,6 +51,16 @@ static enum button_state_t button_adc_get_state(struct udevice *dev)
 	return (uV >= priv->min && uV < priv->max) ? BUTTON_ON : BUTTON_OFF;
 }
 
+static int button_adc_get_code(struct udevice *dev)
+{
+	struct button_adc_priv *priv = dev_get_priv(dev);
+
+	if (!priv->linux_code)
+		return -ENODATA;
+
+	return priv->linux_code;
+}
+
 static int button_adc_of_to_plat(struct udevice *dev)
 {
 	struct button_uc_plat *uc_plat = dev_get_uclass_plat(dev);
@@ -93,6 +105,7 @@ static int button_adc_of_to_plat(struct udevice *dev)
 	}
 
 	priv->channel = args.args[0];
+	priv->linux_code = dev_read_u32_default(dev, "linux,code", 0);
 
 	/*
 	 * Define the voltage range such that the button is only pressed
@@ -138,6 +151,7 @@ static int button_adc_bind(struct udevice *parent)
 
 static const struct button_ops button_adc_ops = {
 	.get_state	= button_adc_get_state,
+	.get_code	= button_adc_get_code,
 };
 
 static const struct udevice_id button_adc_ids[] = {
diff --git a/test/dm/button.c b/test/dm/button.c
index f05f4ca27ce..59431c8eb2b 100644
--- a/test/dm/button.c
+++ b/test/dm/button.c
@@ -123,10 +123,13 @@ static int dm_test_button_keys_adc(struct unit_test_state *uts)
 	 */
 	ut_assertok(button_get_by_label("button3", &dev));
 	ut_asserteq(BUTTON_OFF, button_get_state(dev));
+	ut_asserteq(KEY_F3, button_get_code(dev));
 	ut_assertok(button_get_by_label("button4", &dev));
 	ut_asserteq(BUTTON_OFF, button_get_state(dev));
+	ut_asserteq(KEY_F4, button_get_code(dev));
 	ut_assertok(button_get_by_label("button5", &dev));
 	ut_asserteq(BUTTON_ON, button_get_state(dev));
+	ut_asserteq(KEY_F5, button_get_code(dev));
 
 	return 0;
 }

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261010-b4-button-adc-get-code-056f3d455daa

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


