Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A90CF9C68
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE7988413;
	Sat, 21 Sep 2024 04:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d3VK6kxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD0F48785E; Sat, 21 Sep 2024 00:51:43 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0780880D8
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 00:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3780c8d689aso1644644f8f.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726872700; x=1727477500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=av+MX+BpEgVKMHQYpGvG3EAXJTNNvBt8UrXp3tcQ5v8=;
 b=d3VK6kxWofZGOU9YQhWPvDjR7zPy7PmxK0Jm7mmJn+b48pwzhVBnq++99R7XevrqXd
 yvJmEOxOcFEWtNvitQF+sXok9KuDaDWOTeHEca7Rg56viGgEFXNESdTHxK1qmG39Gssh
 YNmSTzUCsl5bXDSMGwAiPnrn4f8T1ShM00YUn+SWIP4LUm/AObd4Rk+Kqk6xdXdVeVZj
 /AYM4FxIt0xj04YeByXpqdbuoQjEMxS62NClQPw06BGSV6eVnSO6iLrQaGIgWL67l+Ob
 tisVnJ/kCpLYbuoHTv2qeq9VgqMhvtj9ezy/D/Jp5/YR/PXCT/cFB8LgY+dUu2Yi+8DA
 SAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726872700; x=1727477500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=av+MX+BpEgVKMHQYpGvG3EAXJTNNvBt8UrXp3tcQ5v8=;
 b=hFVJjXPTd+qF5+p3uKRDOiUJ2+zCdm7ipfcEjHU3JAEy2hk9hAQSlx6pLgJKT7X2w1
 NqcsWX6SlKaKZzXF1+zGIYDpeAr8iNgqxMR/GUKeW3k0uwzHxOvft15uhwDmGO8ddh3N
 XT/9k9fLeIh5yDX2XiPtGSHvJ3bZ6NaXw+fb86hxv89HlAdzowiOA01/6cOi2b8wDDA6
 3PsyF+JJmN11xAeJZnn+ZVQI8NLuqAaaNhh7rvULQc4aecrmGVwoPQf/kXtJWjsnksqm
 iR0UgC8BOmmefNuPi8fIOamF2MEnyIhMvtVD06Hy4Uwfj1u+v3DqA4R6nw8oCqslXerJ
 beeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHVIXT54ytL/5zir/aqgdxG7hJSAdFRbT7wXg4t7ixRnCCXzY7ZT25artESZQz3AyFP+Qd4qQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxkGD96m+OFn2OqR+Ozyrd7lOkiz4vj5zvXSaEmVk2sHk4LO29k
 BlW4WBL7mSyvuhOSP4KoR5diQruJ3nKa9rBhDvo0c2YqBcN+Mh2G
X-Google-Smtp-Source: AGHT+IHV25nYcZHpnMngueqKgIhx6qZj2tqTAz5Eix2iOXdpCSd53n6jvYW2let5wCGZqkgZW5/VSg==
X-Received: by 2002:adf:f7c3:0:b0:374:c4e2:ee00 with SMTP id
 ffacd0b85a97d-37a43197e18mr2418814f8f.53.1726872700019; 
 Fri, 20 Sep 2024 15:51:40 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-378e73e837csm18850516f8f.27.2024.09.20.15.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 15:51:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v4 01/11] led: toggle LED on initial SW blink
Date: Sat, 21 Sep 2024 00:49:54 +0200
Message-ID: <20240920225101.2008-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920225101.2008-1-ansuelsmth@gmail.com>
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Sep 2024 04:37:11 +0200
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

We currently init the LED OFF when SW blink is triggered when
on_state_change() is called. This can be problematic for very short
period as the ON/OFF blink might never trigger.

Toggle the LED (ON if OFF, OFF if ON) on initial SW blink to handle this
corner case and better display a LED blink from the user.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/led/led_sw_blink.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
index 9e36edbee47..9d9820720c6 100644
--- a/drivers/led/led_sw_blink.c
+++ b/drivers/led/led_sw_blink.c
@@ -103,8 +103,16 @@ bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
 		return false;
 
 	if (state == LEDST_BLINK) {
+		struct led_ops *ops = led_get_ops(dev);
+		enum led_state_t curr_state = led_get_state(dev);
+
+		curr_state = ops->get_state(dev);
+		/* toggle led initially */
+		ops->set_state(dev, curr_state == LEDST_ON ? LEDST_OFF :
+			       LEDST_ON);
 		/* start blinking on next led_sw_blink() call */
-		sw_blink->state = LED_SW_BLINK_ST_OFF;
+		sw_blink->state = curr_state == LEDST_ON ? LED_SW_BLINK_ST_OFF :
+				  LED_SW_BLINK_ST_ON;
 		return true;
 	}
 
-- 
2.45.2

