Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFC7C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 10:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA93835C7;
	Tue,  5 Aug 2025 12:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qoPFHztD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 424C6835EA; Tue,  5 Aug 2025 12:52:05 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5941C835AA
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 12:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-459e210bd2dso1981655e9.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754391122; x=1754995922; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y0O5D+coKNAIZaHWowBvFGyxvBU/CbD9hrIJNYXQ+0w=;
 b=qoPFHztDlyD3i3rcxbIaPEm5SUuAO5VrCZWZxU1d9J/jHoCdUOOXPA9XrwZn5RxHuy
 DG5HKzzXH0xe9PjuNcUI3G0o54Vu9ae8S+Jh8BBo7+T8fwj86Ti9pfg6gOS7/CQnHDcd
 04KVHMp3v8ED5MWHyNVMLmf09Kl9014Tin9/0B3MVf70xFy68/Ee+dY+tpqrpthk27K+
 LrEBjw9WMWqJ6xugOum1JYSX9CNeHFGHOotUXSV0yfXOFiNGnJexgEutHHJlbKZeIXJJ
 aHr25kd5u4O0RJD+9+I+bI+aOm2nORgkcXK7U3rxOqxSelw01sqViPKTyMC+2N1sRCRH
 ebAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754391122; x=1754995922;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y0O5D+coKNAIZaHWowBvFGyxvBU/CbD9hrIJNYXQ+0w=;
 b=PLKQcDWjvnMjUPxoZi1bFcYSWWmDk5W91QBAiVhEij8sMWyw/bODKrE2wBcwB1nahp
 j3M+aweMDIW2rusnInYV+uTjc3uJOAP3wH5NGd8FHktHcwEp6iPzicr9J2P8hVosQrG6
 U2UlF4dzMoQtrzcsYvvtzMdt8Wp9uK/xBe4a1pRY7K3i3bsipobstBbeW1JDFtpPtl7o
 YkH7lxHyc3Gl4Ovrs0F9VE7gQJo4eUiuic/fooxLhe14vWHJUfKZLOKrbIUFb00+5tUt
 gaa8oTOEqKt4lnUXgN7yormmJJ/wSwNucdQo5V5BNKuMd09sKhlC65sZXrdqJ5mN169Y
 J+nw==
X-Gm-Message-State: AOJu0YyGIIYTnSS4k7gUuTb+l9gr+SuzpoYMx8RRTJRsQzVp132WZqQy
 +donWLRU9ivj8M7Bd1HaDwBXOcxcPmqAkaPUBYAxXATnaOmxL8J6ilOqHSvtJ7ppI8wTm4sJn3K
 o+iXn
X-Gm-Gg: ASbGnctLyLkIhy9VpfNutyyZ7RMbawI4eY3Fc3Z1+S6W5Tsqnaeu3kRw6lO6L5Quc2t
 lyreCJxU0lMqzuQytPg23i0Cxa9Pmr+CX4mi2rig7q8Q7FDvl+sibMwKJoGNjBdA+8EnV3ekMRU
 QZWYqeUdReJ4iCNZbCBNIvQwn1FuuhJj+Ym4YrFSkZHqDYttKIE3l1fPQpOtsqMOyXabUQAuVGJ
 CB0B90jEaI4EYLcFJu7UL9vPARIEzzoNP7Uo2P9Byf8HHngvOG38d/wOA1dRnic1W+YWYSLh342
 3h3/to/QebcrkySNuTBncTEVBm5Tz144T/qMnfSYGu8yT3SJ0oUKRhlxlEXHqBHY+rWWQ2iIQFM
 datPI68rr4CJ3569nXeCBLyYIQ5gU8lsUdHgq75RZXxx7uqIwkH0=
X-Google-Smtp-Source: AGHT+IFCW/pPrD8h2HH/BIX+LgnQnZwr5uvE0Zz4T6YCriGIQzqIUPC3uqJ7UM56seG8r9t0pU4ZDA==
X-Received: by 2002:a05:600c:5009:b0:458:bf15:689c with SMTP id
 5b1f17b1804b1-459e0cbf62bmr27120075e9.2.1754391122449; 
 Tue, 05 Aug 2025 03:52:02 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dfa64da0sm49988875e9.3.2025.08.05.03.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 03:52:01 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 11:52:00 +0100
Subject: [PATCH] net: ldpaa_eth: Fix buffer overflow in memset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-ldpaa_eth-v1-1-7b5708536351@linaro.org>
X-B4-Tracking: v=1; b=H4sIAE/ikWgC/x2N0QqDMAxFf0XyvEItKM5fkTGSGteAdpLIGIj/b
 vXxcM/l7GCswgZ9tYPyT0y+uUD9qCAmzB92MhaG4EPjO9+4eVwR37wlFyMRhe5Zt+ih+ITGjhR
 zTNdjQdtYr2FVnuR/R4bXcZxoDE6sdAAAAA==
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In ldpaa_eth_open a memset is used to initialise a struct to 0 but the
size passed is that of a different struct. Correct to pass the sizeof
the struct that is being initialised.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/ldpaa_eth/ldpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ldpaa_eth/ldpaa_eth.c b/drivers/net/ldpaa_eth/ldpaa_eth.c
index b72198ca530..94e62748239 100644
--- a/drivers/net/ldpaa_eth/ldpaa_eth.c
+++ b/drivers/net/ldpaa_eth/ldpaa_eth.c
@@ -458,7 +458,7 @@ static int ldpaa_eth_open(struct udevice *dev)
 	link_state.up == 1 ? printf("up\n") : printf("error state\n");
 #endif
 
-	memset(&d_queue, 0, sizeof(struct dpni_queue));
+	memset(&d_queue, 0, sizeof(struct dpni_queue_id));
 	err = dpni_get_queue(dflt_mc_io, MC_CMD_NO_FLAGS,
 			     dflt_dpni->dpni_handle, DPNI_QUEUE_RX,
 			     0, 0, &d_queue_cfg, &d_queue);

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250805-ldpaa_eth-ccbbb28916a0

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

