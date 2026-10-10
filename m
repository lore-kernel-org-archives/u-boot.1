Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2211CA9EC5
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9176608E6;
	Sat, 10 Oct 2026 13:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nnZk_z86bSVo; Sat, 10 Oct 2026 13:15:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4BEA360A68
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791638105;
	b=Hrr76L3Zd+26ZDqg6qyCAo4o4B+939PTEyVUxQcAo71g2BBiijOCwudmI2c8JWMqLBSk
	 rGXAR5PhE47sBzIZ32EvI0i+8HyhICtZ+lT96cmUNY4H5P0S+xC93UnafTn6tiz9h4ZDx
	 654JRLHtOAmY7XAhOnZ2bPWUK6634lWMNge87s6ZURJWNX/3JxxeqElDjRQaXdCQVfpmV
	 OTlWhSupRjpgkpm1vB09rb0aohKI4i+QX/nT4fgq5Jhw/hitOHgE21jagkjNuG9i7o1Ne
	 LI64iY1Yeus6XwAEf0AgfwxSKwdvLRDmZYxW6jo5W936NacGb9afA1cFq19dcwd64RA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791638105;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=7OUqf20FMCeBO4LfEKZ8qAizLYVDrcH3Aca6Trn8WvE=;
	b=FJbAkmFG/1+dyA92wCYP/cuB82S7zkvGIpJac0tYE3TK3BaSNCmQulY3tolG2dDw9Fyf
	 dkqSgLbo6e8Q7OPoFVOLx9wzIJlGDgKBGZaRxmeS2xMQqoe9v+kjgoNxGe0zMyqVevwOu
	 9comYunAYdYvrq5/kJ2HTKDGH02ZBDqaXn8blY0JgGilm7O5EHfbTRZvE6BbRsJGq/Yt3
	 uRIqpcO3yOljqIdM9GHiDWEqMhLmvB5KBAmUmMakQKNDhFVqEkwUEX3YoVW0l6ZQW6z2H
	 zPBrlsUKCQg1C2O12ocxraARMNrnzMjPDtyxdDG9S4Cc5+FpPUCAp0n5iH4pI5bFZzQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791638105;
	bh=7OUqf20FMCeBO4LfEKZ8qAizLYVDrcH3Aca6Trn8WvE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=00tjbdeAbrw62iI4RKYFzn1fMm0GhKqhgXAxjAziNFKuaAyYWc9T1FvyVw6XNN1Ie
	 +3xh5WI7P+juHmW6YB/DegHxUWucEs3dXGXY802GTxOD3mh/cOQpKYWkPB6f49IgR1
	 T52AF1AaeK4EG93CT9wNUKEq2nm765HaJxC4Rwv4W6xoJY/nsU9NzW7QBXmUdllpRq
	 E0NUUJ1FmdsedPjpLJqVnMovmuP1svYR/TLFqDcYT/1zvreZa9j81Sqqy5A4JPcemp
	 hewyB2hLQWhipRi9P3n3gIyar7IYk9oFoCsaBPwbNTiy7us1kC+7CRy2zNiPqKP9zk
	 qHowkX0XRbNrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BEA360A68;
	Sat, 10 Oct 2026 13:15:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9441A317
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A44D40004
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CivWoWu2-S9j for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 12:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BE38640098
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791636175;
 b=fgFc2OOFWVB+utIWKhiuP8f5ky4FV/XNouakR0QtwZt0qro+h9Ds+KSu/6AldS7xiqVd
 SQ7XeUvEPkqAUxt/6VDZ96YetdJiYXCUyDqSZ/Sp6Vbw3E+2YdMhdM/jBN0d77Ri+Ocas
 eCgshh+G1Cy3n09HPJx9YutfvnKoPJ3hFUHGmTGxvxBuPT/YmEKLW1xkyyQjjEUFLNQUL
 1voRpz79KykS7TM5iynl9JofoplkFeuJU5jER9o5MLOxwv3l+6SJK+gYktVFjtM5ASjwR
 2hg6rHstm4WJbWn03Sg8gkzKGbtJZN9eiNe8R3uJpnX8we3vBaI/RX5IDP+7jzA00Bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791636175;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=7OUqf20FMCeBO4LfEKZ8qAizLYVDrcH3Aca6Trn8WvE=;
 b=qcH8Tn7o6aPdUDtFhnkgfx3mgetuZ69s8FB3Yh5uC9N4MSTtsCGcJxrCfGCvK/OZJHJp
 6hlPAYACOj1uswUSeOKAbjSrT3zETLYkwwOnjSNEJCpxAyOoRL7XyvVyxsD7XVYj1EIC/
 YxYcKo6eIde3hcR3T7Z12j6QV4pas0R0bAPsr/t8ijbEucVixjbg4F1CU/bTRl4zNNLJs
 KXPWuKfRhqYiFIGeIjgDmG+xHyPtM6ZFPXVM6BPU3k37pSscWMptFzVWq0cg4ktXZHC50
 dBCbNFmvsF4RWz1q9GLQ8+XHLzzCj8HNgoN1m1nZwNK3t0rXnuLB+/945Sdj5fYiHIQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QhMDnuXE; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=QhMDnuXE
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE38640098
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:42:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 83D0460211;
 Sat, 10 Oct 2026 12:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39027C2BCB9;
 Sat, 10 Oct 2026 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791636172;
 bh=cog1XQRlr12qq1Hed6erDjMGCRSbOjJwxy/KFQx9sEQ=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=QhMDnuXEI+Qq3Advhio2cYAWyM7vE4QLVIzDmEAhkhbTEVrSRn+TUHxauQWoVuKCD
 7hLaOp2F2LWR6gX8Yf6/FUIqY5yaiVndDtEelH5d2Q0aVdZePzG141xxNDeOvEiy2U
 Cc+zG2e3MRL/RYRuAdhaOwYruSmcapanqzpXyi0Ha6UIN/SQHh86hZThlfYrA54EUd
 31BMn7jwxg5Pxmvsmqosllh1e9eSWJlPrUYdAvcIBi0P0Olef0kW1ZCOajr2chjN/w
 UOOayfm0S0r2g+VtpdwbAcbTm28bxiPGzgsLXO5WReRS9yLkjmrsnBSLIK8l1LPT9k
 NOsojxTvctKZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA8BCA9EC3;
 Sat, 10 Oct 2026 12:42:52 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 14:42:50 +0200
Subject: [PATCH] button: adc: implement get_code()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-button-adc-get-code-v1-1-843d04f5dfd5@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6DIBBA0auYWTsJWHHRqxgXwIx2ugADaEyId
 y9tl2/xf4XMSTjDs6uQ+JQsMTTovgP/smFjFGqGQQ2TVlqhG9EdpcSAljxuXNBHYlRmWh80GkP
 WQov3xKtcv/G8/J0P92Zfvje47w86ab67egAAAA==
X-Change-ID: 20261010-b4-button-adc-get-code-056f3d455daa
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791636171; l=2505;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=3KI/kvEwA0ViY04Mj8sAkRCRRrffZQyJxYwgsHuQjVY=;
 b=9rqicsTEMwo0Rb6Tmd5GPbW0zmW38NIyC0pELcUW/5gEz+uNvzuCkmhvGmY+TgFYFIYevAbE1
 qH8MU15PuvjCzmt62TxNQC/5gzvKRl/I3qPcVKyPXACNsFpDYTduIb8
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 13:14:42 +0000
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

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
The keys on PinePhone Pro are not registered as Volume Up and Down
as the keys are not wired to normal GPIO but to ADC and use different
resistors to tell them apart.

However, button_adc_ops never sets .get_code unlike button-gpio. As a result
button_get_code() returns -ENOSYS for ADC buttons.

The patch reads linux,code and returns it from .get_code mirroring button-gpio.
---
 drivers/button/button-adc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/button/button-adc.c b/drivers/button/button-adc.c
index da7ddf2a857..681f3f7c09a 100644
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
@@ -93,6 +105,8 @@ static int button_adc_of_to_plat(struct udevice *dev)
 	}
 
 	priv->channel = args.args[0];
+	priv->linux_code = ofnode_read_u32_default(dev_ofnode(dev),
+						   "linux,code", 0);
 
 	/*
 	 * Define the voltage range such that the button is only pressed
@@ -138,6 +152,7 @@ static int button_adc_bind(struct udevice *parent)
 
 static const struct button_ops button_adc_ops = {
 	.get_state	= button_adc_get_state,
+	.get_code	= button_adc_get_code,
 };
 
 static const struct udevice_id button_adc_ids[] = {

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261010-b4-button-adc-get-code-056f3d455daa

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


