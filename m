Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807C4C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 15:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33AF283F93;
	Mon,  4 Aug 2025 17:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CLBB0GEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF1083F86; Mon,  4 Aug 2025 17:11:43 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE3783F86
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 17:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-458ba079338so15028635e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754320300; x=1754925100; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XOas086oe2TCtah9FRYxzkw/Yp4gvWhttm7iT4Nqz/0=;
 b=CLBB0GEzi9AqJ0OWUV/pZiedeTyIJqmZ7qw9WWTFg1axiEtdNtJDnz8HPNf2tTGZOY
 DkznLGRpzvtNG7p+3crzeiG++n2G4hBeFQg5qHRnv9RUnNGr0ROm5AIJy/4a7FNheDQN
 CLffENj7/YCqGS1q9AIzBCdflql8Za6m85ynj+bSK30QMJZd9N5vI3iONEKvfIxVGjWK
 SmLklPwlQ8BDxnNGLGByFvpJoOQaq6qPGFShqIjNxOPul7W6vooQ9fF9ztwFKJTRFLrD
 n05pHyGNuDeqf9wOgvJLMZFDlecM9oSMaoTezbBzyfmeb9i1pMTE0YVHimjbyiqDRxBT
 05bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754320300; x=1754925100;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOas086oe2TCtah9FRYxzkw/Yp4gvWhttm7iT4Nqz/0=;
 b=dAC3auQipNWHqYMbRvoGw7WpQGqHNERhGeQ8kKCtFTkapaphWLxVkFSD3EUlIc+vEN
 j/DGlVawavTbmydy4DzstwHpGY0oZ5c9h0PHXLDAXbGvpBn0Dvp0z4JE0zCgJ0QFjWP2
 MpqqQZpgBIr4L15kBdNGsMXQiaVh5HR0J97msHc65uGIKhqNQUQ8GGnvnNCIFezg+Kzy
 9eUEsAnrsAFYUek1ANt9iXiMMGw9wYB/4IqjGpZbi7596mv1VfLUB1G8CvVQ4Mnh8n2h
 56x5ypx0pqs1ghDibzAd5EKIek8f6RgjKQd7Km+j+DJFeE0OHP4O72KrMO8X8VZ/SqWc
 NvcQ==
X-Gm-Message-State: AOJu0YwV11l3t3EPgT85M5g+y/1HRXn5dxAsEg0Flx/Y2MA2Zq2e8bs1
 Zi/NtGi9a9wayfBygC8WCgwM7lxWrPdclQhAHB6e1QJn3H2COb/RbgF5WwVWhm/Szffda4nk9Dl
 Vo1A8
X-Gm-Gg: ASbGncvPOEs4co+rwf4SYRNeHHmOmi1ayr6gJLN2JoWKVozl2ZClmLgbsYJfH17IcEJ
 lWoLoqKff6KLmidQfIn9OYZnbGoq0LriXgv5WR0t8o6ohlqRXny4rqBam1T6ysbkjjv0px2/99g
 BqId0nFih5IiRDT9pJJ2tC1k3KcUAyD6i9b8xfEWfOooXUMsYixxAMUtHQbFJ1FGr+rJERAWqQ7
 O5hnjiC+rlYpy2BDQS/pbngUk253XmoF+X9PV3evwboKi2Vytc96ZM9e9KB+u77axbu/efinusH
 tqUUZQgZEMASbNlOZgY2gqV4tm6hKwLNHC+Ns7fTztxhJ/oQPa7sz6z+elL/6Fh+k+Er0oJ4YZG
 pntvX72xp84Y/jgwNA0XQSkYTfLLSDWiOwCEcYaZIkbdwENVXsXyHFU5kB0mECg==
X-Google-Smtp-Source: AGHT+IHFYW+Rfi+d9eoxHog1RuPKr3fVhBd5RvBbq3q575DQOk5WeGwdnScT0gdkjjSe5sJpYe4Qwg==
X-Received: by 2002:a05:600c:4f89:b0:459:d9d5:7f2b with SMTP id
 5b1f17b1804b1-459d9d58249mr37354095e9.16.1754320300232; 
 Mon, 04 Aug 2025 08:11:40 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b866392csm63586455e9.2.2025.08.04.08.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:11:39 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 04 Aug 2025 16:11:38 +0100
Subject: [PATCH 2/2] net: dwc_eth_xgmac_socfpga: Remove always true test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-dwc_eth-v1-2-d2a652a69fcd@linaro.org>
References: <20250804-dwc_eth-v1-0-d2a652a69fcd@linaro.org>
In-Reply-To: <20250804-dwc_eth-v1-0-d2a652a69fcd@linaro.org>
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

In dwxgmac_of_get_mac_mode there is a test for mac_mode which will
return if false. After this point mac_mode is guaranteed to be true so
there is no need to test for this. Remove that test.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/dwc_eth_xgmac_socfpga.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dwc_eth_xgmac_socfpga.c b/drivers/net/dwc_eth_xgmac_socfpga.c
index c89c8a188b7..f72f16b50ab 100644
--- a/drivers/net/dwc_eth_xgmac_socfpga.c
+++ b/drivers/net/dwc_eth_xgmac_socfpga.c
@@ -39,11 +39,9 @@ phy_interface_t dwxgmac_of_get_mac_mode(struct udevice *dev)
 	if (!mac_mode)
 		return PHY_INTERFACE_MODE_NA;
 
-	if (mac_mode) {
-		for (i = 0; i < PHY_INTERFACE_MODE_MAX; i++) {
-			if (!strcmp(mac_mode, phy_interface_strings[i]))
-				return i;
-		}
+	for (i = 0; i < PHY_INTERFACE_MODE_MAX; i++) {
+		if (!strcmp(mac_mode, phy_interface_strings[i]))
+			return i;
 	}
 	return PHY_INTERFACE_MODE_NA;
 }

-- 
2.39.5

