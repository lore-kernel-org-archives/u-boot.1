Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D891C87FDA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 08:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE9EE839CA;
	Fri,  1 Aug 2025 10:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fpP4TInb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 175D2839D7; Fri,  1 Aug 2025 10:12:59 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E09C78398C
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 10:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4560add6cd2so13349575e9.0
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754035975; x=1754640775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KOAIvMkHBNcoDy/3i5WryGZyAmm7xfYe7HcqMubbeDw=;
 b=fpP4TInbbIFw3RLqeG1gIJ1rvAY793vMj9ShtSAAQGclxN+BqoE3BTIzbafwRNwI56
 ZMh+BaROTQvBtmADFFwfd4zSxV20aSZnMjmySetFwWN0WGDjJ2hSgco0c8h0jhrrR0R6
 z/rCZiSkbODBzoBBbC8ZWkwyLqAGcQ+S3Rrp5fPwz76GXEUwfQEwdKYAYGdnWeW2plFc
 BColsDL+rok9yjaHu5cM2RJG5yiDo/enTH3TYO2I/NIilZYXX20SZPDezjLx6mK8bECL
 Q/Ff55ElsCnt32i2yGG+zC2ptu0vej5y3fLfvCpV25YSXWHXPu1wyj/zf0jhzk/Koxmt
 8LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754035975; x=1754640775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KOAIvMkHBNcoDy/3i5WryGZyAmm7xfYe7HcqMubbeDw=;
 b=UgVAiONT8uzbdRuZLnZsU/GmkD+PPUjwlmVF1/B2uxJ5mVnE29qZBaq68u4aEZ4dCI
 b4ziRJfNPp+Er18j/bfCliF7YNfcZQ9oczF+/VO2kuWiAqsedQAyJy8hp8AfLOnLhuy7
 fpbLJLjUhwftl5uVRJGcsAQPJCrwUyTSVo7Volwz0PoxxFcRkonUgtgOf5+Ni92wr1KK
 0ddqy4HagkS7FtL/I6VMkGuIATk8TkJVEt+dkPRXnCCEdg/JW04jZPzF5Ryk416w1P8S
 yyGKr4VuX+cG3jkAvt+X6ZbL72qdixSr+NKOr7eMU/319pMYA5XN9AUQlDaKvvpgToa+
 x7Pg==
X-Gm-Message-State: AOJu0Ywh+Ah0ElLM6zo/KsoECLQtbp0se7+cVrP3BNY6c3uaMdbw9aoL
 wAPrI5RG4auU062nMWi2xGqfQJUlBtnB897371ozSC6gCbpg4WquNz0QBqaDUCai4mmK7SKsiFP
 LKiRX5Ck=
X-Gm-Gg: ASbGnctfi94NIM7q5Sm6+0tl3y38AtX64nBcz9ZdLlkbeUBoSso3AWMIzeu41ar9lFB
 JGpqZvGaYzzhJUMRsT3xcoiY5K9LEp6MAioVaTE3rJBdn0fyng82mJmiFxoga/d8k18jd3hh6oU
 NXNhMcFuFk6CeMuEcvOfBvUEoOzHjv9VFNiP5PrRxOYCjrcHvKImMcO82l+TcvFutESyxb72xNa
 Vsc8bYwo5oYCy5TO8AxtkoBtJxa8jh9w/iMBZWouUfI5syQVFbGQ/mR4Mzhg0IMUmcA+4Vh11rS
 Kb2JXWV104TQTrUHI+axeNlQylOfzkcvhIV1H7TgqrQmW8JdOZCuq/s3oIrLGECeUF4q9F+SoI/
 5XeIoOnWwM14IaRIhuK1XYTjXLA1M2C0=
X-Google-Smtp-Source: AGHT+IFNE0NLou3Jkx3TZWMTmjLWB+5JYDt9c4KPF8ecW3RqCCg+pNNESSBJg4nezn1GtpZtNr/U7A==
X-Received: by 2002:a05:600c:4e4f:b0:455:f7b8:235c with SMTP id
 5b1f17b1804b1-458a232ff87mr52966395e9.14.1754035975074; 
 Fri, 01 Aug 2025 01:12:55 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:5122:d5bc:21eb:7895])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eaeeesm101645295e9.25.2025.08.01.01.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 01:12:54 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] lwip: sntp: remove redundant sys_check_timeouts()
Date: Fri,  1 Aug 2025 10:12:20 +0200
Message-ID: <20250801081234.1553867-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Now that sys_check_timeouts() is called in net_lwip_rx(), there is no
need to call it from the SNTP receive loop. Remove the redundant call.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 cmd/lwip/sntp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/cmd/lwip/sntp.c b/cmd/lwip/sntp.c
index ae02bb11040..608345c873b 100644
--- a/cmd/lwip/sntp.c
+++ b/cmd/lwip/sntp.c
@@ -79,7 +79,6 @@ static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
 	sys_timeout(SNTP_TIMEOUT, no_response, NULL);
 	while (sntp_state == NOT_DONE) {
 		net_lwip_rx(udev, netif);
-		sys_check_timeouts();
 		if (ctrlc()) {
 			printf("\nAbort\n");
 			sntp_state = ABORTED;
-- 
2.43.0

base-commit: f5e968a28e7cdc2c4365f5a382e02f074ee03fac
branch: sntp-remove-redundant-sys_check_timeouts
