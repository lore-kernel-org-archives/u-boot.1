Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276E6C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ECA188AE5;
	Thu, 18 Jul 2024 19:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hd/Pw0fj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9832E88B7D; Thu, 18 Jul 2024 19:36:51 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9799088B23
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso5226845e9.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324204; x=1721929004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XG8EvHpulFYX6YSxtFrVLn2/ViuiFFIxmpQmiKUbFXQ=;
 b=hd/Pw0fjixcQm4vgZKDhlVVQMjcQFRoOMYMZY1XbXSWo2KyhlurZscK62K23iRxdgM
 YMGiPmpsBadb7hg6C3bJa63IfiUVRoKThrgtL7bpnkoInEqvQY++MPW8iGd8tELd+1gr
 lQHmmaoSiwuuamnt/OIhHEX/d03ae8vmP4l/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324204; x=1721929004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XG8EvHpulFYX6YSxtFrVLn2/ViuiFFIxmpQmiKUbFXQ=;
 b=D6XznfdTBlY8KGr70wCOxhIwQ/NY+HAsbkhpkKjlqSTzUSzaT3mcodNHd7I1WJEAyo
 cpUtTwbyHepiAETqfxCn4zQTGDhxLtczOkdMMtaTvhaDM+q0ORZ3bmCxzV9dFdf+0/+B
 Dg0eY2N3qiqsNOHq4IiE8mgQJSOV1QnLSp9BD7f3Cq8c2Vh2oKUPPhF2IJRUxxXsXEbC
 wowRlMrhLTxXwFx66H3j2U3Kslkt+kO9VUTtrL7urwBqwPhEQklBJOtL6476dRuXXuRu
 1X6LpYqsAJwanEJzVeWIKjShWbx1USTlFUksJnmfZBmMHXAh65ViQU0ejsvCHFKN08nJ
 4kig==
X-Gm-Message-State: AOJu0Yxwu3ci/sOsmFlgnZ3DHX+hMsQlLE45bwCz1euCpYz3LLbwTXN6
 yWMZq2D0YNZX/YS6U6j8imOS+J8jMA0IM/SyLsfSQAPRwo2d2PAgDJ9OrNS6UanpiNIdmm/iiUA
 =
X-Google-Smtp-Source: AGHT+IGtmngmQOrBwlydYieqzi44lhYPfcSHCz5q3xV04oASGdGRn1bpgrvQXsGMDDyaT0UzGkDQZw==
X-Received: by 2002:a05:600c:35d6:b0:423:791:f446 with SMTP id
 5b1f17b1804b1-427c2cc9898mr37212245e9.7.1721324203997; 
 Thu, 18 Jul 2024 10:36:43 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Michal Simek <michal.simek@amd.com>, Niel Fourie <lusus@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 11/20] keymile: Remove use of legacy I2C
Date: Thu, 18 Jul 2024 18:36:02 +0100
Message-Id: <20240718173611.4014274-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Drop this old code to permit removal of legacy I2C code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/keymile/Kconfig         |  3 --
 board/keymile/common/common.c | 69 -----------------------------------
 2 files changed, 72 deletions(-)

diff --git a/board/keymile/Kconfig b/board/keymile/Kconfig
index 18ef689b334..3585941470e 100644
--- a/board/keymile/Kconfig
+++ b/board/keymile/Kconfig
@@ -11,9 +11,6 @@ if VENDOR_KM
 
 menu "KM Board Setup"
 
-config SYS_I2C_INIT_BOARD
-	def_bool y if ARM
-
 config HUSH_INIT_VAR
 	def_bool y
 
diff --git a/board/keymile/common/common.c b/board/keymile/common/common.c
index 9358c25dcb0..5aa7c4e5383 100644
--- a/board/keymile/common/common.c
+++ b/board/keymile/common/common.c
@@ -129,75 +129,6 @@ void check_for_uboot_update(void)
 }
 #endif
 
-#if defined(CONFIG_SYS_I2C_INIT_BOARD)
-static void i2c_write_start_seq(void)
-{
-	set_sda(1);
-	udelay(DELAY_HALF_PERIOD);
-	set_scl(1);
-	udelay(DELAY_HALF_PERIOD);
-	set_sda(0);
-	udelay(DELAY_HALF_PERIOD);
-	set_scl(0);
-	udelay(DELAY_HALF_PERIOD);
-}
-
-/*
- * I2C is a synchronous protocol and resets of the processor in the middle
- * of an access can block the I2C Bus until a powerdown of the full unit is
- * done. This function toggles the SCL until the SCL and SCA line are
- * released, but max. 16 times, after this a I2C start-sequence is sent.
- * This I2C Deblocking mechanism was developed by Keymile in association
- * with Anatech and Atmel in 1998.
- */
-int i2c_make_abort(void)
-{
-	int	scl_state = 0;
-	int	sda_state = 0;
-	int	i = 0;
-	int	ret = 0;
-
-	if (!get_sda()) {
-		ret = -1;
-		while (i < 16) {
-			i++;
-			set_scl(0);
-			udelay(DELAY_ABORT_SEQ);
-			set_scl(1);
-			udelay(DELAY_ABORT_SEQ);
-			scl_state = get_scl();
-			sda_state = get_sda();
-			if (scl_state && sda_state) {
-				ret = 0;
-				break;
-			}
-		}
-	}
-	if (ret == 0)
-		for (i = 0; i < 5; i++)
-			i2c_write_start_seq();
-
-	/* respect stop setup time */
-	udelay(DELAY_ABORT_SEQ);
-	set_scl(1);
-	udelay(DELAY_ABORT_SEQ);
-	set_sda(1);
-	get_sda();
-
-	return ret;
-}
-
-/**
- * i2c_init_board - reset i2c bus. When the board is powercycled during a
- * bus transfer it might hang; for details see doc/I2C_Edge_Conditions.
- */
-void i2c_init_board(void)
-{
-	/* Now run the AbortSequence() */
-	i2c_make_abort();
-}
-#endif
-
 #if defined(CONFIG_KM_COMMON_ETH_INIT)
 int board_eth_init(struct bd_info *bis)
 {
-- 
2.34.1

