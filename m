Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FADD68BFF
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 18:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07A2C88901;
	Sun, 24 Nov 2024 19:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yIAbqEYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DD5A895A9; Sun, 24 Nov 2024 19:38:44 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D9A895A0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 19:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539eb97f26aso4154886e87.2
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 10:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732473521; x=1733078321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Djcnt4zRb4tK6dxCtXwg5cfgPTfFiViYeaFFG+OS6IA=;
 b=yIAbqEYCMfTh8qLVbALwr81Oy3nhN0HTy908CffZOqySoILrk4sjE3cRBmWkwwfXTt
 BMwjhTv994VMnXUvALNrvXKoTh/N0t6Jiu3ZAKwJeLrPj92OzyGCIrF1r3g8aROgoyh6
 yT/XAcj7Kho7pFp6g20SKfWm2UXMCF+r5qoEt5w3HvBImXRr1tKcCRYsqbtRT79DzeR9
 I9Bivq75YXh7KYKNBpxEm3vwzQbCUPQrj5h89SlbRxq+fKuwUAQiXr9+6CN56F3WYiqd
 8JM3ziJN1odTRLvDl7E1FrJaWfvdU1HucYktlK0WOoNYXRc8xEPUkGdzoft6m1PsRWFC
 aUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732473521; x=1733078321;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Djcnt4zRb4tK6dxCtXwg5cfgPTfFiViYeaFFG+OS6IA=;
 b=dhZAQOdcmn7b658V0hzl6RcUZpGu6o8ZPbfMrdMgeP3u38j2slkKiXb3yBVoc7og91
 zMVe2djOdE/AqVWXRKjv7P/VfmjU0X1EvmDvC9L2pUoUyFGqKFu1GI9j9ocQKiXyMSyh
 /RKc/khXDgxAWCmOdLKPgWyxXWQUjH92wg+bhFKXMErFVutLlyue8JTZDXx7TgORXwq4
 yDYoel+EosHyJLXq/6VAkdWOIbHRp7aUxeEWRkjEADK7/PtGTB/lV0J9g1UCsLQMDkaF
 Gvtae3pNge8oYVhd+BEzK9BnNZCDiMHCMDPYIye2+3/lVG86Cd3/mRac20HHQh9n1DVf
 Z8lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXpgqW1xqBYxTbOnA5+9cH6nYcisZTTFBW6dizRMXhgUZTWodV77RJxibB8xgoB7R4puizXQY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywh+jLCvLbx2ZIlh5AsyR4agcycmdqgfplvzcvz9xa8qdkZCbuG
 IFS7JI62PaACI3r8HcOZD/tCwkmT7DN9UfeOTMtehON3FsfH76legjpL5iLxfHE=
X-Gm-Gg: ASbGncv6BNn+8O7v8pttAfMfvVufoI03b0c1Rq5/Xok3MfykTc1rP+rx2c3RzwuH61e
 3tgJsnAqd+F45Zun4AXKscP2SRmNoayXCI8f+5JYjqsJNlD/oESezY2ILIdyNrV2836o9GIW1g8
 5b1ErE8SntOLbq+OrW+mURYSaS8Q0XZTcmQ+YUcs6c0IrD5wlRf4jCoyDC99J/QciJjTad/5eJV
 /SOsmv+TbEJBvUFfGE1mKEND1UxH+KEhXsBKqBe4H+z0nhYRamdr9R2Fc3eIGubZ0lDDSde32KU
 i2iqDo9A
X-Google-Smtp-Source: AGHT+IFgxSBO8EGTH11zMjrwhQ/Cp6twzTqekFxfyJAISyGHEao6nfX2gUTGo+Y8Dg7HILcjXRJbaA==
X-Received: by 2002:a05:6512:12c2:b0:53d:dd7e:338e with SMTP id
 2adb3069b0e04-53ddd7e33dbmr1801452e87.16.1732473520485; 
 Sun, 24 Nov 2024 10:38:40 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b344fccsm371392566b.86.2024.11.24.10.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 10:38:39 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>, Simon Glass <sjg@chromium.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] common/board_f: init malloc earlier
Date: Sun, 24 Nov 2024 19:38:29 +0100
Message-ID: <20241124183832.2476928-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

Currently the early malloc initialisation is done partially in
board_init_f_init_reserve() (on arm64 at least), which configures
gd->malloc_base. But it isn't actually usable until initf_malloc() is
called which doesn't happen until after fdtdec_setup().

This causes problems in a few scenarios:

1. when using MULTI_DTB_FIT as this needs a working malloc (especially
   for compressed FIT).
2. Some platforms may need to allocate memory as part of memory map
   initialisation (e.g. Qualcomm will need this to parse the memory map
   from SMEM).

Move the initf_malloc() call earlier so that malloc is available during
fdtdec_setup().

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index 98dc2591e1d0..bddfa6b992b9 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -867,15 +867,15 @@ static int initf_upl(void)
 }
 
 static const init_fnc_t init_sequence_f[] = {
 	setup_mon_len,
+	initf_malloc,
 #ifdef CONFIG_OF_CONTROL
 	fdtdec_setup,
 #endif
 #ifdef CONFIG_TRACE_EARLY
 	trace_early_init,
 #endif
-	initf_malloc,
 	initf_upl,
 	log_init,
 	initf_bootstage,	/* uses its own timer, so does not need DM */
 	event_init,
-- 
2.47.0

