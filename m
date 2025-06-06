Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B47C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A7C8803DF;
	Fri,  6 Jun 2025 08:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ieuzU1K4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7D22803DF; Fri,  6 Jun 2025 08:42:31 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC758291D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so1276069f8f.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192149; x=1749796949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GiMb6lpF+cIBQYf2XfKqg059f/V2imKKT8BcFLCJwQ=;
 b=ieuzU1K4tZkQMsoy/YeNjVG511tNzkSDcv0TELKWaVhFrH0eMtPCkMbW3nZkkpxZws
 e2vn4Kl/lidqKhccmby3/2zmjJO2/jxEeDldrcc/nTpoCPLazWG4BjKl7RSC+XWrbObz
 sQ+eRnH7vCSJENS77N/BMABt8vJcPkKK4cPWp2ttSsMF7RjLbWGn5dIusu8wF/KVD/uU
 Y9UKrjcfhB4lFCKvgYCqKJA/W1Wm6VdsPW9Ssvrra3gdeidmYeeSaf7ob8WMlijTeSRF
 mXLF5GMAhOeotU7oh0y1k/Hvr2Su6RbB0GdDQHgnk23UBvKpJBDWKaC/OQ2MIbIoembO
 HoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192149; x=1749796949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9GiMb6lpF+cIBQYf2XfKqg059f/V2imKKT8BcFLCJwQ=;
 b=IRa547NHLJsDwq4CmTArm5nhQEOZK10xHL0okFduqlAzQUUcHw8mRMg+nj7dwQYxpd
 tu540MBNw5s3N5VKQ50VIGr5Av0U8xxjpGlBHXR9jLGpl2Gz5AcWbdAlo5PonkIJtpDe
 4RjhNRt8qbgFO9anj9lchyW8q/QXpX2reakylngGm/sTER1MFXeTkgG2oQzCyjd5cbT6
 D3K3GdWCO5csKtIc3ZXLqNxNWluPWIxpGhtGGqlxoriAbku6TvO53lSyo+ReUsaJBG/D
 YRPckeXZOm5yKN07DtyYfe3Vk2Y+QWBsEePxrAlYTCtde8NXfM4L91bbPmhT41SPnv/9
 2iZg==
X-Gm-Message-State: AOJu0Yxt6orTIGI8XQmhS0x1rKBrT5oyNxrgmTsA3nQLY+HOJ9LmewrB
 obhuQHEouPzsUhsPJ0pXTs4QD60RCRLbYL1LVlX9QR5RtDqk8vUnXhMOBQFcWHyJmUeTmPSFTd/
 bckV7
X-Gm-Gg: ASbGncv6tfDX8bKi+ZkySZxT7pGtNFjhmhLaWT79eQz/vYFSlCeftHduzGkSmBJj+s5
 TbyBrk2HQHkTioVUSQqV+azSzZyb4I/XQ7F9PB7ExL3adv9W0fVzrvglhgPaZJRXH1jLXccFeq9
 5jnlWPuNI9B+FpLMAdALe8aolyZ1dqQ2ur0UIdyiZC/Rs387KhBtAAVl5xDaN8P6TXq2OCxU0Pj
 B6WM4V0h6Y4OFK6mQEUK5Q1Aj8gKiiQlKkC/qWTg4fV6Z9wPLRQYyWUshfmXeM2YZssUTNgbcec
 dx3treKlYs9lFziimmkO5id12+wDDshhANGTyPUbO+JvyMSTEA5ezYYh8kz3yFQ9lKyNrvk=
X-Google-Smtp-Source: AGHT+IGToo+GBpHn+XGZO00+QmtUqRg7KbmoAVQpdDa6onWS2cFZXCLEsqeGNE40vJa25J4cYiN8YQ==
X-Received: by 2002:a5d:5f88:0:b0:3a4:d79a:3599 with SMTP id
 ffacd0b85a97d-3a53131de7amr1971882f8f.11.1749192149126; 
 Thu, 05 Jun 2025 23:42:29 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:28 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/13] lwip: dns: do not return CMD_RET_FAILURE on
 successful resolution
Date: Fri,  6 Jun 2025 08:41:42 +0200
Message-ID: <20250606064211.3091237-7-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606064211.3091237-1-jerome.forissier@linaro.org>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
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

The DNS loop checks for a non-zero IP address after DNS resolution, but
the address is in fact never copied into the context. Fix that.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v2:
- New patch

 cmd/lwip/dns.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/lwip/dns.c b/cmd/lwip/dns.c
index be57a4d1b88..b757638cd1e 100644
--- a/cmd/lwip/dns.c
+++ b/cmd/lwip/dns.c
@@ -38,6 +38,8 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
 		return;
 	}
 
+	dns_cb_arg->host_ipaddr.addr = ipaddr->addr;
+
 	if (dns_cb_arg->var)
 		env_set(dns_cb_arg->var, ipstr);
 
-- 
2.43.0

