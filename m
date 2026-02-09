Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208B5E7E0BC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B325883CEA;
	Mon,  9 Feb 2026 19:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XErB67T2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA83483C67; Mon,  9 Feb 2026 19:07:33 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 013BE8397D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-38316d0c26eso28831761fa.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770660451; x=1771265251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOGpNJRqO1ATftXqjAl1DbuOo29nyl7/jhXwcpyfDW0=;
 b=XErB67T2nLkRsDYCeblyL9NbHK7ZWjVe/V1nTmARrxvI1MN7P4ofVTq/sWlxdxmWuP
 Hr/1Dvi/hwrZ98cPo6ML1kEi4srDYcJ7oFb8MYqOmc92seJnvnk2AyirvOnEnssmZAn+
 06Wbut36Za9xNUg4lhPEvGy9fD+aiPeKTPVNbdp/CXtgwKdaNlwUnlyZ9LblpnfG28VJ
 AWQcptwtytEUxHDBkHop3dFfpalNNvm5lyrLPL4kWPB3XjufaBnszAe7BIyg/aMQHkLV
 geBTCM1OYJXuFrOHhNC/BbKY+jDHHMP+5T528XF0hwbWixTmKt9A+kktGg6m5SjpdosB
 b5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660451; x=1771265251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OOGpNJRqO1ATftXqjAl1DbuOo29nyl7/jhXwcpyfDW0=;
 b=Q4hXF9XLl0r1/XhooZXGENIElRzyupAB+XMKlTrIX8R2QNOXEUck8/asqy0iUlxAtQ
 a4haM5psN0qJ51ik7P8OnTqMXHMzFTFwuyeWSXfPJhjEkhLO6n0delHkTvcbEzpxRVBm
 2SEMY0lLKpEGn4gRg0GN/hqGKC26USSOLrb5xCzDT010GmbYALlJWIUFmJPVum/fgD7Y
 u+6bWsshWnSp7zbogX+GoOC+iG7TcpGm7va71de0xapwxsR56GOkA6vELvr9bcgCPEJm
 YV/Df8PG7YcfoFY3ELZGx5HKSq4sgsAAj2xjTWsKvQ/9WcwBuTnFqxqVxg5BckmZHCf6
 LDCQ==
X-Gm-Message-State: AOJu0YzBbVflIhnXRMIGv7/2uy/hV2EvQcuU4IbY1DiQDMgu6+QYGhrm
 oNdulY/3Uj2nMoDxJeJRINv+eQO9Bj0x1iymdJOpblCZ00Ujh9uvzw+J
X-Gm-Gg: AZuq6aKu/nybem98GHcylyIUkj0I34rwylY6QlMHT4+Oo4/XJoGYTrEUuZt229MdMpI
 dDd/CFW2F4Am/3Chh9OoVTX3E4z+4prMejaCs+YiteRgPARZfju02cc4iT0Lgykhnjkd+ydHPl4
 /sHF+NiMK23ZBwLexkzbXF26UR3RmCozFAHJByU2RNb26TjU8yisFHwHSSQMocka4PzuLT0d+iR
 FwegrjnbRY4i2fC68fLFkxk3MA6IxJbae6+MimObhpY8bfuqf2vTDTLYGCL9IQGdtOjj+HkJqoC
 de2q1Wf2rZJlZTsHAWIkKiuowVEvFgQ3CXVkf5Ilij4ynz4GEVZ/1T/2y2j+sjBVuUkS3u2Oyf8
 jpyjW4Uzdc2FxvW5IPO/YPwqiQEiNSbDIQm8I3uZIgm6TL2O114AML2DdvhvIsPuEjN/OOIMh7J
 Hs
X-Received: by 2002:a2e:a984:0:b0:37f:a216:e473 with SMTP id
 38308e7fff4ca-386b4ba660bmr32846181fa.0.1770660451114; 
 Mon, 09 Feb 2026 10:07:31 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-386b624d4afsm27397751fa.17.2026.02.09.10.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:07:30 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Ivan Vozvakhov <i.vozvakhov@vk.team>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] led: led_pwm: fix active-low behavior
Date: Mon,  9 Feb 2026 20:07:18 +0200
Message-ID: <20260209180718.32451-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209180718.32451-1-clamor95@gmail.com>
References: <20260209180718.32451-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

In the case of active-low behavior the Duty Cycle needs to be set to 100%.
The PWM driver takes care of this but the LED_PWM driver does not take
this into account. Adjust LED_PWM to take into account polarity of PWM.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/led/led_pwm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/led/led_pwm.c b/drivers/led/led_pwm.c
index 15dd836509b..7edfa286468 100644
--- a/drivers/led/led_pwm.c
+++ b/drivers/led/led_pwm.c
@@ -34,7 +34,7 @@ static int led_pwm_enable(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	ret = pwm_set_enable(priv->pwm, priv->channel, true);
+	ret = pwm_set_enable(priv->pwm, priv->channel, priv->active_low);
 	if (ret)
 		return ret;
 
@@ -52,7 +52,7 @@ static int led_pwm_disable(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	ret = pwm_set_enable(priv->pwm, priv->channel, false);
+	ret = pwm_set_enable(priv->pwm, priv->channel, priv->active_low);
 	if (ret)
 		return ret;
 
-- 
2.51.0

