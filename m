Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01076CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 17:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B06983257;
	Mon, 11 Aug 2025 19:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SdMd3kJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 737F9802C1; Mon, 11 Aug 2025 19:03:43 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89E8283214
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 19:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-459e7ea3ebeso17531065e9.0
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754931821; x=1755536621; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9Do0POzyZZg4lMKLzlKLp9MsH1IahBn5zUldm22Is3A=;
 b=SdMd3kJ0HpnBhALwbyhuDaEyoJ7ZPIzHNMVIUH49cCCwEPUkGWWasDf5rlulQpox4q
 XuNtgaQ8UFMsZwc0w9Qn9TqI2RH6CL39JTYS3ezwrdY5fWS3jepzTvQYCBp+nnLGm0NC
 y4426zp2E4mKSPUw9ZROkKHye7AMISkY3Z2genL0O2idjaQvRm7OiVREa4t/P1ulPguq
 olc9eQnDpprLtL/5DfiY61V8IBwbkF4MuWhX+shrmfyzrNQ+roHZKp3v3UrScFa5biVS
 PNHKHi4CNHzGmTCf7OUgYlZ+L35JqxjU6LXmg1tY1yqbu3UfQt9Yg1reqnj1xL/EnEi6
 l7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754931821; x=1755536621;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Do0POzyZZg4lMKLzlKLp9MsH1IahBn5zUldm22Is3A=;
 b=Su523omkfofytyOo/6b3bI/KST4xGdx3lJnuMo33W8D0Zc4Z2sfcaxjRbWQqoseMYz
 YY6Yg/9cprOJOBwT8pYk5cra68JA0S6gR+mKvjtMNNCZlwl6t0FBm2/5E7HHnHVE8bYX
 UYF6p/Ld5q36ZXYj4Oj+nDEjUwNCiqISBL01WpIGYtI1QrMwsFP1ie0ZCarTGJahirEt
 /oM5CE6VK15IbZA4IqZfLVqpuDz4fYbMh8LCBlhFPVr65sT4iJCbAg/GBsOT6CnieD/J
 81mG3ibQsaEFiCfpOjJCayDetrJKfz6osApX2bkXhMmEPazatOFxVsLDeEw1mINkBWLQ
 73ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj+QIy+S1gX/9eQiHtha1Fnyekp4H53nLwMisro7XXwJ81PM4yp66PBQET2LeQPZWtoErxfLY=@lists.denx.de
X-Gm-Message-State: AOJu0YxUdbMMp/ts+vpr39Zah2WPF8nR5y/m0/w49smprkET+vbX07t5
 BhevTxL1C3pn5t24aHr0JoK3ahp4zVSlL0c/sCf0UC/9ThvfVsMoE5g/b1srXbcmVaQ=
X-Gm-Gg: ASbGncu8zOF4gQDi0sNE44+xtb22Xrx2ULtQWVU+hddpvTqWAwk8W2SBFkimd6FPs0/
 pyOlHRgBNBPo86WKRccpOz3VUysmTa2/CwZalIYjyOYthWlLIiJcNDDiCmyDoCMk6ZKGScJYqDW
 YCf6CxmqTX1MKKkh6nu+xAUpx8Rsy+u7SAGVJqUKrbnPr6HyF0qI21MLjgsXqR0o5YwTBWnB5z2
 0qUiAQdke4fNX+GdsRVqQBAO443agJRX9QyIyyXP5NJ44l0JXuEqx/k37Fr4/AAwpOsto9qgvVS
 Qg7A1rx/2MNc4us24WZYLVuBEvbpdsaU0xKsPCOWAxGo1eoEkRZhMvlTkXbqSTrTjmOdhMOnQUB
 r1B5Nt5iRuZ2yak5+2XDpjI/SJnEJoyvYWGupiebnJslm+Ydxqf8=
X-Google-Smtp-Source: AGHT+IGEbzp3MrgIO/t78zbCguv6/WryAMALyaj72zC8YqCCombWwN+6/tUHwuMuyY5YBWMnFjPqQQ==
X-Received: by 2002:a05:600c:c493:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-45a10b9b154mr4104655e9.7.1754931820872; 
 Mon, 11 Aug 2025 10:03:40 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:3e73:96b1:418e:3053])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c45346asm41215266f8f.39.2025.08.11.10.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 10:03:40 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 11 Aug 2025 18:03:39 +0100
Subject: [PATCH 1/2] serial: msm-geni: Detect error from get_clk_div_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-serial_msm_geni-v1-1-4499179491bc@linaro.org>
References: <20250811-serial_msm_geni-v1-0-4499179491bc@linaro.org>
In-Reply-To: <20250811-serial_msm_geni-v1-0-4499179491bc@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

In msm_serial_setbrg if the call to get_clk_div_rate fails then there
will not have been an assignment to clk_div which will lead to the call
to geni_serial_baud using an uninitialised value.
Check for an error from get_clk_div_rate and return an error code if so.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/serial/serial_msm_geni.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index cb6c09fdd09..33016f0cb53 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -252,6 +252,10 @@ static int msm_serial_setbrg(struct udevice *dev, int baud)
 	priv->baud = baud;
 
 	clk_rate = get_clk_div_rate(baud, priv->oversampling, &clk_div);
+	if (!clk_rate) {
+		pr_err("%s: Couldn't get clock division rate\n", __func__);
+		return -EINVAL;
+	}
 	ret = geni_serial_set_clock_rate(dev, clk_rate);
 	if (ret < 0) {
 		pr_err("%s: Couldn't set clock rate: %d\n", __func__, ret);

-- 
2.39.5

