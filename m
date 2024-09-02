Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821D1CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 13:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11CAD88B4B;
	Mon,  2 Sep 2024 15:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sLQsORMR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 441AD88C39; Mon,  2 Sep 2024 15:25:44 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53F7B88B49
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 15:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-374bb1a3addso1502755f8f.1
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725283541; x=1725888341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2YqgAKzPcZIp7cigAi39MJ60yMHP2xJr5ZWvqMJCk9k=;
 b=sLQsORMRGW0PqfLSG0JPx86+Or/wuAqCbh8bWQq8IjaJTYdKoI9r6gzSllQpLRInEm
 /tYhZlAt9dIumRZ4go5YJ9dS1k9LtbLMkZyiO+EvAg8NmuwjUSiDx7Zp/Uc7fDwnY21j
 vGmwFjeWGBh13HyupLvsARqrtE09MD2Rj+FkzIQPDoyU/f+1c8st2//ZEPK4q6OUIvVr
 8P4rnC8v8FXR0s86qGIH4FjXI4oPBjUAOSxL58CxM/YTsxWt9ymSdndlCwGS8OvliSrK
 u8GbpksPqNNVv/JtMuH3WO2aR5EABKlhFWmZarfMxYiIwCkLnjo2OFPTScOgONmgSNeJ
 SA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725283541; x=1725888341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2YqgAKzPcZIp7cigAi39MJ60yMHP2xJr5ZWvqMJCk9k=;
 b=CgfZ11tgZQv9KZmZLZtApRfmNjOvNwCy9N7mlkAICPL7VU0VeAR+Ti7cYNr+9NE6fC
 MG1iIR3k7m0/YSLCm9U8D4b000Dp/vxDBW+HmRKAq0uXIALFpf2GJvOKXaVAvOdeKnFi
 eoWPB6gzkaZqxOjTT2RaX2M0v7PNnjT0o8BpZjPslTdOAx1UIf4eRT0aWTjuAcCtnm/E
 UOAhXbgALtaiS2pTcyiHUUwjNkCaiXu+O/Q7wwK2cCnlIQGprs/sC6J2et8LiI4ns12V
 1E7baLIQuvQOZtv9kwxq8RAoxoEIQ1+VrCyYn9DNv3QSPYiAX1ZhOyIijE3jX7hKg+Wk
 JyJw==
X-Gm-Message-State: AOJu0YyVmPlj1ae6EOuyVI7q/HJQNtnrVeOL+i3aaO6p9CdFyJd/QkOT
 pIfFQRxgjAzxREUEEBwurX5VeVmUBrVYfArZHrObY7o0xMlGTqhwrqCGAWLSCmqTyp5sHrSaIN1
 wJb18Nw==
X-Google-Smtp-Source: AGHT+IEslZ5mDGytOBNCeOFEDiQOKN14kDOTZtHdcagvNgrWzuG5RBaHqa2qgurDjBj6zZWozU3pFA==
X-Received: by 2002:a05:6000:18a1:b0:374:cd36:8533 with SMTP id
 ffacd0b85a97d-374cd368862mr2227988f8f.54.1725283541377; 
 Mon, 02 Sep 2024 06:25:41 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee5080asm11723512f8f.18.2024.09.02.06.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 06:25:41 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] net: guard call to tftp_start() with
 IS_ENABLED(CONFIG_CMD_TFTPBOOT)
Date: Mon,  2 Sep 2024 15:25:11 +0200
Message-Id: <20240902132511.148683-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

net_auto_load() cannot call tftp_start() if CONFIG_CMD_TFTPBOOT is
disabled.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/net.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/net.c b/net/net.c
index d9bc9df643f..1e0b7c85624 100644
--- a/net/net.c
+++ b/net/net.c
@@ -334,17 +334,22 @@ void net_auto_load(void)
 		net_set_state(NETLOOP_SUCCESS);
 		return;
 	}
-	if (net_check_prereq(TFTPGET)) {
-/* We aren't expecting to get a serverip, so just accept the assigned IP */
-		if (IS_ENABLED(CONFIG_BOOTP_SERVERIP)) {
-			net_set_state(NETLOOP_SUCCESS);
-		} else {
-			printf("Cannot autoload with TFTPGET\n");
-			net_set_state(NETLOOP_FAIL);
+	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
+		if (net_check_prereq(TFTPGET)) {
+			/*
+			 * We aren't expecting to get a serverip, so just
+			 * accept the assigned IP
+			 */
+			if (IS_ENABLED(CONFIG_BOOTP_SERVERIP)) {
+				net_set_state(NETLOOP_SUCCESS);
+			} else {
+				printf("Cannot autoload with TFTPGET\n");
+				net_set_state(NETLOOP_FAIL);
+			}
+			return;
 		}
-		return;
+		tftp_start(TFTPGET);
 	}
-	tftp_start(TFTPGET);
 }
 
 static int net_init_loop(void)
-- 
2.40.1

