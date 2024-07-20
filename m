Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023D6C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B147488C97;
	Sat, 20 Jul 2024 14:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tH5oEM+T";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cAePDhUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB21988C8C; Sat, 20 Jul 2024 14:43:55 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11C3D88C37
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WR5nh60yqz9smn;
 Sat, 20 Jul 2024 14:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cNJoncxghKuMpzQEDZhqTIKOe3fnDSvXLM1J9douek=;
 b=tH5oEM+TXRGns09NKIX5dS54Mbz9viyGpI3fBmznlI5VWnZ8vLxcE9kp++ldzFyERzP+r3
 KCWmr5HG/ZWfU6iJVRDnT3FPEiWQeWJjxaE/fZeu0R+V8QGkXGQTVR6OIFHMeokI07Vm5T
 e6vLWb6RSG4lm0lt2+aqagixuZxA8njy3qNl4ZBDH8rUo2jI+VNRb7vbeDdkwf8TzSQfbM
 F407tdqrB052rLjeLQbwmQzfV6pYJZt3QSnbQeFThhp6+6ngaiJjpYX+rCfg+RW3XoZKSE
 1qE1y4ofbCyjV4kRdkHLq/KPZK2tTMuaSX+60taH6UAQFN/uDRb5K0NlDScG/w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cNJoncxghKuMpzQEDZhqTIKOe3fnDSvXLM1J9douek=;
 b=cAePDhUIc/HWIMoXVnSO0Po/qNBeifw/7Fl+172ipqrk25zcCwaKQ2sRiTTHJjFda+CI1w
 1TO8vCX14VAeaWT5TX2fR2jS4eSPqlIWimt5d3GmJViJn/+JuByMvDfKIsxRgxAVHyl16n
 9YxjVjygY7FN/cX0CBqy7azFUWW1LMkRCIlRgmasXc0SdVJkfR3KssAQU+k4pccTgyrmc1
 wB7QEZkwwkJCCHbTIb3dLKbvauQs3uTSQwDg+YK2/rrA4JaDGIgvp5o7j+wOScGHZo5okt
 PmFlo1cgM1WDJ8U2jHol7FuSVmSD2OAPtdX+0oFFOL449PCXRGDBxd3pACCwDQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 22/40] drivers: phy: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:47 +0200
Message-ID: <20240720124239.7553-22-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f9cf3cdc804965df6af
X-MBO-RS-META: 6htp5rpmx8tjmb1euktsdmze3axyrp1m
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/phy/marvell/comphy_a3700.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/marvell/comphy_a3700.c b/drivers/phy/marvell/comphy_a3700.c
index bca325d1996..2a1646cb2c0 100644
--- a/drivers/phy/marvell/comphy_a3700.c
+++ b/drivers/phy/marvell/comphy_a3700.c
@@ -389,7 +389,6 @@ static int comphy_usb3_power_up(u32 lane, u32 type, u32 speed, u32 invert)
 	 */
 	reg_set(USB3_CTRPUL_VAL_REG, 0x8 << 24, rb_usb3_ctr_100ns);
 
-
 	/* 0xd005c300 = 0x1001 */
 	/* set PRD_TXDEEMPH (3.5db de-emph) */
 	usb3_reg_set16(LANE_CFG0, 0x1, 0xFF, lane);
-- 
2.43.0

