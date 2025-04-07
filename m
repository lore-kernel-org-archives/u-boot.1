Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA3FC36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ACB7830C0;
	Mon,  7 Apr 2025 22:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBt9Ux4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40CA782E76; Mon,  7 Apr 2025 22:02:40 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF9083086
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso3758926f8f.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056158; x=1744660958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mOUBRote2YI3pSatWFEQ422yBmZ2/9Oq3/QkjbevFFU=;
 b=RBt9Ux4oBkPXQ2WVewC4jFMoAGkvyNa6WdpOXiI1G/mcc7AYxTq0nf20z5NPW0Fxgk
 wClEjEOOqweeQ0iMNwuxZnwZjStswrXy51SVcme5ZsL426epGa7ttM7h+IhTpvN0U+ov
 VlyvTia5dAjwgij241D7dDZ3Qt3pVC2hS+qkpi6cRpWJu+gnbB8AdtLl7E/OiZomzotT
 RaX6sV8UNSUj7g1hRXWB/WH6ZWtd4wAV8MMDdFeuRd48WLlzkDzAavESfzg8lvlUPUCD
 cxE+4psXQI6Eqio1DrAO9ES9xeRxoEpo+KIIMZPu/YkuJ8ggIO9+dXIoi+eO/zb00qs7
 heOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056158; x=1744660958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOUBRote2YI3pSatWFEQ422yBmZ2/9Oq3/QkjbevFFU=;
 b=LRPCqtT2OjksWZtb3R/RZ+EuP+uNLnqOa5R96h+ix32gibY4Zyycmpp8xQW9GnjWiu
 uqKJF6qKBTceXUnShKZUiJ+/iqvKiUj1HJYNgUBXReF0OtC4lAk3skb/sYwPOqgVWuRN
 s/3oBgi2E+gjquCTNRW1QJLrzO2JCgJjLJ0TrsZWnAOaDUI/Z3TJcn3y6d8gDGzYlvr3
 G+jWM9JAONJ0RiVdKrs3ZEwW3DmeXUPBtaryN4tkFo8vpE8gF8eZflxispVMhMtIeAjx
 Do5nftKXbTdblkDTKG6LhoZjAMOcZyjjVGKh4ZlAxkY7t2+UfRcopMJu7bmpEbEmVvl8
 xXqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJr4hnm5cEI+OZ+5GI72TGPXP3z/X7j8wfRyfHsSuU//521z9ez/UM6Ywv3wOqmenmYGgNxdI=@lists.denx.de
X-Gm-Message-State: AOJu0YxIeFujq4do91pnWSWuAgrpQAcd2N1afGZL3MABF5eZsi/4DCDq
 LVqGqyfKL/RSjRcbDewMeu9aaAxyx6y+y2Si1lPJsdsyl2lbPNyJ
X-Gm-Gg: ASbGnculTnWZGoHhsgRY63F4yXJdyZGi3J8F2cti7V54wyEnbqXkmhTgO23196rwlVR
 uGgJ4Dnauxsl8m1ETdtwbBFitcLV0YjEkadRiOQ7TGOJ4YK2tKX3nIzg4twgPPK6mQ8NSs7Rl3k
 vLQS+6IOWDJ5/11MPoSlZgdklymrM9QU6l+xlQ726dLtDhaECDqJ44oct4sg4/CG8Z31h77Jrwq
 75i0soY/lLG9f16lW3c9z4WvqihzNIwPPFjiVp2BWTyI9kyUGQp9jN2O/OnV7FrDE9KAKS/zbcT
 piLu052m1SQHjtWZGGR3axT9lCS41Q6OlPu4s/rK+InPzY4W466SykoSCaU+mFSw9eXDukD4h4V
 mkC2ThXMKr3l99Q==
X-Google-Smtp-Source: AGHT+IEOjQCj68R/SNx9tjI+qfASxu/vs4Tfh19X/yq5jFoxj+EcMSS5jHY6634P1fZ3jLDjvmlnsg==
X-Received: by 2002:adf:b642:0:b0:38d:e3da:8b4f with SMTP id
 ffacd0b85a97d-39d81f68c06mr538503f8f.0.1744056157613; 
 Mon, 07 Apr 2025 13:02:37 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c301b9d55sm12723354f8f.42.2025.04.07.13.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:02:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 03/14] airoha: Add Ethernet config to defconfig
Date: Mon,  7 Apr 2025 22:01:47 +0200
Message-ID: <20250407200208.25594-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200208.25594-1-ansuelsmth@gmail.com>
References: <20250407200208.25594-1-ansuelsmth@gmail.com>
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

Add Ethrnet config to defconfig to enable Ethernet support.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7581_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index f09b5b603a2..f5bd647cb6e 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -76,3 +76,4 @@ CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_SHA512=y
+CONFIG_AIROHA_ETH=y
-- 
2.48.1

