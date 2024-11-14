Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80E6D68B29
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 14:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08AC2895EB;
	Thu, 14 Nov 2024 15:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G1EZHFMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8474B895C9; Thu, 14 Nov 2024 15:29:26 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 240EF895AC
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 15:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb56cb61baso5137581fa.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 06:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731594563; x=1732199363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+ZKQ8GXO8x6Nz17B2GQZy1jFMfkUvyujZeaj0wCbMuI=;
 b=G1EZHFMgeHYeJZhlV7zI6C+QBp8+Fw1z0oFMZCYnNAUv9sgoz25jvG5rL25pwZRVaI
 uRmgGApurFUX9vDz25Zylab4YfUIhjdy+tu2/7el5e9DU3pU5dRXDF1yE2TfntsYxStW
 NM/UbzRuzma1u9eUs3x0yF8MAhVyhhnil94JPpDkbnMd5MEAI2UkjF586b6G6r1ZcEWS
 MzVRng9kVSG/YoQnPKUPwo/qcQudDNcT3kGnQqXLcuyWb4E1MDLptBDMtvYsQiPEMURQ
 OHB30UppZtV93tjC+GB5ORWJuagLi9Deb6yCShp7aCJB+zPZoN53sLvxcb2xsKa9/GOv
 VpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731594563; x=1732199363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ZKQ8GXO8x6Nz17B2GQZy1jFMfkUvyujZeaj0wCbMuI=;
 b=qo2g39tEqwuOZMQERjyrGhH09AzIqaVaVtnWJQd+sdgwjHhlNNVVdNVob0a3vrWZwa
 DXTwe/KOtLWIyYAWgFH1uC/zsyzk0u0qaDRJNrtXNUn3nKM4jW/ZnXFF8MzNYplKBWmd
 ywrSdm0fHpLuqTXzcYT0rulCBtvwM6EhdhCsWf/Yp/g6NUcvycOcKnJxrgrBCa19+y1b
 uE8C4j9QNpYkF0AefNrDaBtqglKN4Wdc5GK3XFe+bP8pM2uUIr/KvKMbSiwCA5mySM1H
 zJ1FrrdJzTyzledGkx6vn03zhyMWCEiKSflyNxMHI1NQrT2rre1PGYeB1f4mPU7hX+0S
 x66Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnr19dmNSKOEpvlInE0gOd0JLqdHm3f+sW/197B1Rd4a5HHyUPqdt9NlkGd3p0jt9YPgtBLnc=@lists.denx.de
X-Gm-Message-State: AOJu0YzetyE6l462lyGb+Q0zaWeNYtnJF96D3OFRUZGn6vYDEcbPOqil
 za6waPmI70DflTs2lWFqF3RynfOykwh3fV8L6E4RA6f0gLXCRO6zI5VBcQANt7c=
X-Google-Smtp-Source: AGHT+IHfdVrxpANrzAkGpvdPkkCW6PVlULCICoc+dNo6Phlo7RsDc8hjtwJfvCsiNkCIQhYxKHAwDg==
X-Received: by 2002:a2e:bea0:0:b0:2fb:44ca:801c with SMTP id
 38308e7fff4ca-2ff4c633543mr41840251fa.35.1731594562909; 
 Thu, 14 Nov 2024 06:29:22 -0800 (PST)
Received: from localhost.localdomain (ppp078087235066.access.hol.gr.
 [78.87.235.66]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf79b89bcesm615806a12.3.2024.11.14.06.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 06:29:21 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2] net: lwip: provide entropy to MBed TLS in one go
Date: Thu, 14 Nov 2024 16:29:15 +0200
Message-ID: <20241114142917.481564-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

We currently provide entropy to mbedTLS using 8b chunks.
Take into account the 'len' parameter passed by MBed TLS to the entropy
gathering function instead. Note that the current code works because len
is always 128 (defined at compile time), therefore mbedtls_hardware_poll()
is called repeatedly and the buffer is filled correctly. But passing 'len'
to dm_rng_read() is both better and simpler.

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes since v1:
- Update the commit message and title and picked up r-b from Jerome
- v1 can be found here https://lore.kernel.org/u-boot/42870ab3-1621-491f-a221-8ced932ed703@linaro.org/

 net/lwip/wget.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index ba8579899002..4fd552fd306e 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -42,7 +42,6 @@ int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
 			  size_t *olen)
 {
 	struct udevice *dev;
-	u64 rng = 0;
 	int ret;

 	*olen = 0;
@@ -52,12 +51,11 @@ int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
 		log_err("Failed to get an rng: %d\n", ret);
 		return ret;
 	}
-	ret = dm_rng_read(dev, &rng, sizeof(rng));
+	ret = dm_rng_read(dev, output, len);
 	if (ret)
 		return ret;

-	memcpy(output, &rng, len);
-	*olen = sizeof(rng);
+	*olen = len;

 	return 0;
 }
--
2.45.2

