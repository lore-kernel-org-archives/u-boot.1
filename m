Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D6AC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 16:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B8083FAD;
	Mon,  4 Aug 2025 18:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TzhZS6gD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D88183FA8; Mon,  4 Aug 2025 18:04:02 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0494683FA3
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 18:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so30459385e9.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 09:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754323439; x=1754928239; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i4LFyto8R/aOF0HvVo4Mrm6ojQS7YwXopL5wUryHzRU=;
 b=TzhZS6gDwR2dQHLEHKbh5NZBrEylcsy9VN2nSveoOIK5863iW+qdvCakzB/1sLwpsX
 9REt1rAcDO+L0fjr4Adhe1rlJgUHRHt/OY5/U1NGrkJXVkVAIg9jcKSyRTaqabLcjDwx
 XNR4M4KCh77G+2F4+CYFnjn/Kf8VpicMMpUWpyVUEqZMs6ia/RwjkvakbZh5e0Ld7xcl
 do8uy/PGVU9eLLUrIZx7iGfzao/FHrqGhyfxa9rKAkXoMSlOx2hXwWsRIXJb6KBffCaV
 QHfNCy1CUNz7vE4cEUSqzvogOv4Vzf+mx8NqV/kKAwmAbfj3KP99GyV8/wZTpKogCM0i
 fJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754323439; x=1754928239;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4LFyto8R/aOF0HvVo4Mrm6ojQS7YwXopL5wUryHzRU=;
 b=Ud8htXydkMP7xJ9JE2sV7Q99oDhgapIcERftgzsyEsPaYp0LCIKd+u3B+O/jFKq5SG
 5vRG3hda2uyl4HXQbSDT+b3eZEe3FtcDpBkOjHHwyDKlZZI96DnDaRYywBNas8Xslk3V
 pxfZtWITs5QXHrrjUCwPCjrfDmPsJCVOUbMyrwPYvzCfsGn/GMhggnWvr1AMEEhmCpTN
 uSk01Mp70BW5zK2kpREGIs473tAf4eTaPwBHer4SplPRzTQ7NUNwZ2q4doiYQl9Td6PZ
 dpBxqfzc/sJFD2n9sPNIoKvqk3RDx2Q/QLoumDjweIx8fyWPA8jp7m7WdJ18G8/3Xv+/
 WZaA==
X-Gm-Message-State: AOJu0YzchtoYKJknkXQ3DFhABPUWp9hlAqxn3pFR4NxPAXcOwb5WbC3C
 kx6/m+VSpMd5HbSRloSz697CVRWquW3L5HHzy/2gJ4Nt6+VrTGEsoG7S9cQYbgkP91I=
X-Gm-Gg: ASbGncs+8f/7Bn3kOuXm9t122nqXcch9613XdL2CaHzShk7Ym6UqhWs2cOIBB5Pv+Et
 6xjhhE6B47VFU7RQDhc1W2HOQrhNzaa0boOJ+JpvzAfRsSAU5rtAygiYVSqWTjOa9qXZMbvbOix
 vGqjqgc37+aNafUcgF58AVIcx+U+umBVzqUEqr4I+donbtGMGiT/q1ozYaDeIVLgxbsH3N883PH
 QgJR24K5VOPsIM8/TeiWo7I9TZO8m3AYWybATiMcp8WLojo7cWmRX7zeCorJxlh+kFm6Z1XDQ9B
 zWWBsuCN9zUBTXgWjkM01qK1BIaElvc45PLEcGzcZJhxFYLy3fOD74kEUQnzbsr4zZVp0VMEgK/
 Tz2OHZMSaVh/XjQLq+gKUBYi4BEz8Dan2sDlciitXEeFwXrpZQ/Q=
X-Google-Smtp-Source: AGHT+IHP8PLBqaxcd7yh0hNPREYUYPEe1e6OykDhl1xck87qUwF8dp+/rOPSxclGkyldh7n6wg88jQ==
X-Received: by 2002:a05:600c:4f89:b0:459:d9a2:e920 with SMTP id
 5b1f17b1804b1-459d9a2ec83mr33985135e9.4.1754323439336; 
 Mon, 04 Aug 2025 09:03:59 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac036sm15901598f8f.15.2025.08.04.09.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:03:58 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 04 Aug 2025 17:03:57 +0100
Subject: [PATCH 1/3] net: fm: Correct test for timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-net_fm_eth-v1-1-994a4652fe17@linaro.org>
References: <20250804-net_fm_eth-v1-0-994a4652fe17@linaro.org>
In-Reply-To: <20250804-net_fm_eth-v1-0-994a4652fe17@linaro.org>
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

In bmi_rx_port_disable and bmi_tx_port_disable the use of post-decrement
on the test in the while loop for a timeout means that timeout will be
equal to -1 on exit in that case. Adjust the test for this expected
value.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/fm/eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
index 63fe4b2d33c..c83b789693a 100644
--- a/drivers/net/fm/eth.c
+++ b/drivers/net/fm/eth.c
@@ -169,7 +169,7 @@ static void bmi_rx_port_disable(struct fm_bmi_rx_port *rx_port)
 	/* wait until the rx port is not busy */
 	while ((in_be32(&rx_port->fmbm_rst) & FMBM_RST_BSY) && timeout--)
 		;
-	if (!timeout)
+	if (timeout == -1)
 		printf("%s - timeout\n", __func__);
 }
 
@@ -199,7 +199,7 @@ static void bmi_tx_port_disable(struct fm_bmi_tx_port *tx_port)
 	/* wait until the tx port is not busy */
 	while ((in_be32(&tx_port->fmbm_tst) & FMBM_TST_BSY) && timeout--)
 		;
-	if (!timeout)
+	if (timeout == -1)
 		printf("%s - timeout\n", __func__);
 }
 

-- 
2.39.5

