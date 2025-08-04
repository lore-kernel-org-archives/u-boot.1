Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B0BC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 16:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E169683FAC;
	Mon,  4 Aug 2025 18:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eZiHU+IL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45AF183FB0; Mon,  4 Aug 2025 18:04:05 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D7783F9B
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 18:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-459ddf8acf1so5720995e9.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 09:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754323441; x=1754928241; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LP991muNl3sUVqvs1fubDd4ZFYCIOC3T3fhZ7J9unHU=;
 b=eZiHU+ILWFbowTMvD+diEXE1yF5fj+kseEXlZqpxE+qh1XqOMywPWFM4hF54hhAEWj
 H6CnEFeWccDapke/KaSZsYF2L1W88dvzQBOXl9ThIf5WZO9dmbybEcqoTgOPZhsuzmqz
 99MD7M1SNMQ9vz4RgZFXUNx/zoWTHCSCOWo3zv1LUOiZSL5TbyLgRRCtEglQUF7Hu5AZ
 XHUc5puilDppIK54YhM13OYlUI1JiOfNJH5ru5aI1WsjL8MWDdHZWA34q6ApyZFFsp9V
 hwOp9Hfb5CTM9XWyHE88bM70XmF3sq+KZdj/W9FOlOgv9AxvA0Fg/ak9OY4cegPuuIz7
 rT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754323441; x=1754928241;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LP991muNl3sUVqvs1fubDd4ZFYCIOC3T3fhZ7J9unHU=;
 b=mKRN5h7lfJBYZNp2XLjsGEC7yoc0XT+pmCEJaMg57fqZeKKNKQTsPEgl+6MSnCEIfE
 HYiTIZoLOm7T81oLV1G5Dnb5h0Yo4TXc1EtwsvTzh0MU96YX6eVwMnUUgrp79S8YLm1B
 I7NVDkUfmwf8N9otYx9QNDffoITza5sRDL0V8NV7nADHNc5iqmKyx6fw80GestNtNlr5
 jpIz91gU2KUm1+OQg8g7dtH3fEtGUi2n56Sc9t1kvfAcz8jC4SWqGsCCuwXw/Ac41gdp
 uyeQ/Mwi6dqmQhT7+B/Ec5LVRuG14KEvDXW3kdnGpC6Ns76o0aaJp+dwRWyriCliEnaM
 BQZA==
X-Gm-Message-State: AOJu0YyTFlkits4TOtea3lR57mnqv1czljrrAQT1f+Ef2bNhGEJ+RFdz
 sYGNW1qgUU5Cvbc5RZOq0i+7K/LurIMiRRQPVhLn+Hsop1A5jhGmA+ONWalovK5Gxr7Zaua8D+9
 xoTo4
X-Gm-Gg: ASbGncu6xv5VH3AjFCQfN/qpGtTBUiakRhP1onK+Xbr1IHswU1lx2Vjy5MbIJmOvt1g
 aMjifqeTuSHPO6Fajy3aPKV/K5wTLnnjx5fwMDD9oFj7NXvpGoOEXfsLsyslzt3nla9Ccl4GG6Q
 o4TdcE/Rxu2uqKBHi0e6I9ALFN/REt4MYOlFEhk5m9KbV/ok3txYunqgODOoB4lcV22svPKwKaI
 EY7G98NiBQVr4TVE3Je2qyfkyziokKIiOwZvXWnX0+oshcrLgFrekw0xC6weJzv0V2Fl0+5LqM1
 Lkz29cJSjQj44MBit1U1Uyt6j61f8JQiRO0qEWBd7HxLraYcG4SKpDXJFlLPNVOLMtF4AoWPLh8
 6VBBwPCv7BVdB45JlLoerVOixvBo8kYyWdQM0yZbC5yxdOxAYEu4=
X-Google-Smtp-Source: AGHT+IEWKyCflWVVMIPsJvQniOTwqI8C2DpUWpSNL2GTzumktXFFJj4YOA3fkIcbPESFWC/rwyyiuA==
X-Received: by 2002:a05:600c:4ec7:b0:456:1b8b:b8c6 with SMTP id
 5b1f17b1804b1-458b69dbe47mr83823775e9.14.1754323440869; 
 Mon, 04 Aug 2025 09:04:00 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac036sm15901598f8f.15.2025.08.04.09.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:04:00 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 04 Aug 2025 17:03:59 +0100
Subject: [PATCH 3/3] net: fm: Correct test for timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-net_fm_eth-v1-3-994a4652fe17@linaro.org>
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

In memac_wait_until_free and memac_wait_until_done the use of
post-decrement on the test in the while loop for a timeout means that
timeout will be equal to -1 on exit in that case. Adjust the test for
this expected value.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/fm/memac_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fm/memac_phy.c b/drivers/net/fm/memac_phy.c
index 26425d94ae5..1ad3c053593 100644
--- a/drivers/net/fm/memac_phy.c
+++ b/drivers/net/fm/memac_phy.c
@@ -46,7 +46,7 @@ static int memac_wait_until_free(struct memac_mdio_controller *regs)
 	while ((memac_in_32(&regs->mdio_stat) & MDIO_STAT_BSY) && timeout--)
 		;
 
-	if (!timeout) {
+	if (timeout == -1) {
 		printf("timeout waiting for MDIO bus to be free\n");
 		return -ETIMEDOUT;
 	}
@@ -64,7 +64,7 @@ static int memac_wait_until_done(struct memac_mdio_controller *regs)
 	while ((memac_in_32(&regs->mdio_stat) & MDIO_STAT_BSY) && timeout--)
 		;
 
-	if (!timeout) {
+	if (timeout == -1) {
 		printf("timeout waiting for MDIO operation to complete\n");
 		return -ETIMEDOUT;
 	}

-- 
2.39.5

