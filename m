Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628FCC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 10:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71C788134;
	Mon, 15 Apr 2024 12:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="pAcWRa76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E4B487E91; Mon, 15 Apr 2024 12:50:36 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7151787D40
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 12:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a44665605f3so314984766b.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713178233; x=1713783033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJY4+C6JJ0C4dPkkZrjQsiYcAOgeqNPFQKO4dtpw7Dw=;
 b=pAcWRa76I+c49R2jTf2q99OocFxiiHsSeatuelSFfT4XGe1MdOPBscmh/1uT8K0GlZ
 28GgeuOHP0jZGFU9A4thDGfWCHXhs80gtd0Pz0+D1NRLhLsHZzKJvZD4CV2PvapKm6yF
 yFDg/jKgK0Xl28KnmlFb7kFBbn2Z69q4jM4ChikRoPCdfg3MnXtFpJM3J5P8i/sbllDn
 lBReOANNksEuB2Ef8BRhia+tI5xZrXwSZc8J14YPDpwCihJF5w6fcpZ4ofzhfulpVwWk
 36Rc/+RfB7+aowNxaheAOpaNClTSmBxUeV1s6KQQ72Zb5ewgQg+dGC+Ikiv87XHEbD15
 67Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713178233; x=1713783033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJY4+C6JJ0C4dPkkZrjQsiYcAOgeqNPFQKO4dtpw7Dw=;
 b=RxmeN/f91Y6BhqIag9f7f+NlzNOCD0m3W7SLdxDQ+RksEquVJv2DSRuR3YLYSOkVeR
 hRpWIfZPxFF6v6nyNcUfrHJa4ubw+tIRmYvclsTG4SPNTcTsKjgiOVCcIPaVcBm2QN5d
 pLkQiPBhBvbLM52tRkBG8D1m7gCp9ptm6d0IjP7IOcGSSkLmJXdkoxEd/SObybbeMpQ8
 4eXViihhgccd6kKCH22Ll4UgaGiaIeokI48qCFt0VuAcjw08oZv0I17Z6DfJCG3PZv9y
 dg3YIE6SHHkbD9JSB7owFsCBFPZW2v8DxaMM8xF1c+YesT/FE8LtSgJbw015aKxHeq+/
 Q+OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5RlVN3KlnN6+dZIPzCnQI2xkrAgUM2M9Y6ezwK7s5C8EQ7Y+lFC1gTll9JRol+1MVQmmby605vQsZPTzHZxc8O3tCvQ==
X-Gm-Message-State: AOJu0Yx0Ated4lx7ZK982h/f8RjSK+0v75USvMUikQUoltgt496Bj5kp
 ZwzVdg/rS842xvnRC5gIfFdNMawk+YJwYHt+NFwGVxYuU4y3CUxF17fhgFKbqF0=
X-Google-Smtp-Source: AGHT+IHyxUmG97vKpGuGYPyEENzEwY1Qc1jllFdBAci8mrCbq1x8ziAyjUpl4Jw8yWriLhEW0bIDOQ==
X-Received: by 2002:a17:906:c9cc:b0:a52:387b:8391 with SMTP id
 hk12-20020a170906c9cc00b00a52387b8391mr4764056ejb.34.1713178232803; 
 Mon, 15 Apr 2024 03:50:32 -0700 (PDT)
Received: from fedora.. (cpe-188-129-44-155.dynamic.amis.hr. [188.129.44.155])
 by smtp.googlemail.com with ESMTPSA id
 ox2-20020a170907100200b00a522bef9f06sm4745378ejb.181.2024.04.15.03.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 03:50:32 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, sjg@chromium.org, bmeng.cn@gmail.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 3/3] serial: msm_serial: set .clk_bit_rate in debug UART
Date: Mon, 15 Apr 2024 12:49:27 +0200
Message-ID: <20240415105028.432404-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415105028.432404-1-robert.marko@sartura.hr>
References: <20240415105028.432404-1-robert.marko@sartura.hr>
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

Currently, .clk_bit_rate is not being set in init_serial_data for debug
UART, but its then used uart_dm_init() and this breaks debug UART on
IPQ40xx.

So, lets populate .clk_bit_rate for debug UART as well.
IPQ40xx requires special value of 0xff, so set it if ARCH_IPQ40XX is
selected, otherwise default to the same value that regular DM UART
will use.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/serial/serial_msm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 8044d38518..80069f5cfb 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -242,6 +242,11 @@ U_BOOT_DRIVER(serial_msm) = {
 
 static struct msm_serial_data init_serial_data = {
 	.base = CONFIG_VAL(DEBUG_UART_BASE),
+#ifdef CONFIG_ARCH_IPQ40XX
+	.clk_bit_rate = 0xff,
+#else
+	.clk_bit_rate = UART_DM_CLK_RX_TX_BIT_RATE,
+#endif
 };
 
 #include <debug_uart.h>
-- 
2.44.0

