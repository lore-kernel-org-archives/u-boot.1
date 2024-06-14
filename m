Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126CDC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E90AE889CB;
	Fri, 14 Jun 2024 14:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="YZH/B728";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43038889C3; Fri, 14 Jun 2024 14:29:25 +0200 (CEST)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A992E889CB
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
X-Envelope-To: contact@jookia.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1718368161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhFgUpU4SVnaa0eeSX6lLCCeXmugWNMRdj0wvUi6sKw=;
 b=YZH/B728AITxAWXNPwLm8F0XsWV+MydweMbF08SHWpSF7xp82pSJ2+hZ30q82xWj7Pedcv
 adEo8QInzBB2TqqjSI6dejFia1iWlWmTtlaYM3CiM66Td2Ngv86JqrPg6Q4qX+9xbOwYCR
 4O6rYiiAlQGvWhfiIRDYqg+WiQedL1fEyG7/A/fHY8pnK18k9dPatEOzgPah1FocpITcpD
 P+Nms00Kc+Pa1M1y32FeH6XmLjRt/WXaTDvh3h+4l+VsYU/mtqNaelKH/s+ScJD5ICUuS+
 5Xtb8yJ6NL5v+m+GIgq4jDqI0IOEi6oKTT8l8B+NOJ2c4hfX3sj6U+r9r+PCmQ==
X-Envelope-To: trini@konsulko.com
X-Envelope-To: andre.przywara@arm.com
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: jagan@amarulasolutions.com
X-Envelope-To: agust@denx.de
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Date: Fri, 14 Jun 2024 22:28:45 +1000
Subject: [PATCH 1/2] sunxi: video: Properly invert hsync and vsync polarity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-sunxipolarities-v1-1-15bbbf57dfff@jookia.org>
References: <20240614-sunxipolarities-v1-0-15bbbf57dfff@jookia.org>
In-Reply-To: <20240614-sunxipolarities-v1-0-15bbbf57dfff@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Anatolij Gustschin <agust@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1718368132; l=1019;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=GVrnIgL5jQO1s8+kktJVoJG5mMY0W6DQmvub8SZNbws=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAFrHZnDhWrM/ZJrlBNCGAm/7
 f2TsAVGBoB+LLQb2MpqHOb7acDmwc4MGcsAk3OXgSfOGnC/uhbiyKxyJ0YbInBQUAAP/g
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:/gEvgms/9HpbgpcH+K7O4GYXmqkP7siJx9zHeEWRZTg
X-Migadu-Flow: FLOW_OUT
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

The current code assumes hsync and vsync are active high by default, but
they are actually active low by default. This results in panels being
driven with the wrong sync polarities. Invert the check to fix it.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/video/sunxi/lcdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sunxi/lcdc.c b/drivers/video/sunxi/lcdc.c
index 73033c3b85..4fcea6050a 100644
--- a/drivers/video/sunxi/lcdc.c
+++ b/drivers/video/sunxi/lcdc.c
@@ -133,9 +133,9 @@ void lcdc_tcon0_mode_set(struct sunxi_lcdc_reg * const lcdc,
 	}
 
 	val = SUNXI_LCDC_TCON0_IO_POL_DCLK_PHASE(dclk_phase);
-	if (mode->flags & DISPLAY_FLAGS_HSYNC_LOW)
+	if (mode->flags & DISPLAY_FLAGS_HSYNC_HIGH)
 		val |= SUNXI_LCDC_TCON_HSYNC_MASK;
-	if (mode->flags & DISPLAY_FLAGS_VSYNC_LOW)
+	if (mode->flags & DISPLAY_FLAGS_VSYNC_HIGH)
 		val |= SUNXI_LCDC_TCON_VSYNC_MASK;
 
 #ifdef CONFIG_VIDEO_VGA_VIA_LCD_FORCE_SYNC_ACTIVE_HIGH

-- 
2.45.2

