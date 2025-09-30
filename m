Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BE0CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 16:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFDEB82998;
	Tue, 30 Sep 2025 18:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ATKrvRN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401A2832AD; Tue, 30 Sep 2025 18:43:50 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D57802C1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 18:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e317bc647so40061045e9.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759250628; x=1759855428; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bGyiRW8lm9uoLSR+w+MaqXaOt1fjuFE4l9LsREL/dUg=;
 b=ATKrvRN5WERDm+9nIeyBJIEFawDrWjr9Dg4RlUTm13PvTm9cUZ/a/cPGXfjohQu1Sd
 iEypdRngLoWOBUJdYWtdCNL0XYn18n+HTJjEKKfg6N0AOu18wSegd5VHOCBVO01VeJZ7
 eICnrvN/9/73gMYWbvSSZ/CbRqnP7sok4jUmCfNkh+hJ0wmVda1qMQNCJOKt6juk4STK
 tnLXVOgwFG2Ctf33yy3PxDkeYcH0lspVH52WYdREUYWaSoSlepWmd4RjIlcf137sx5bR
 o4A9rB8Xz11sDkSko1T78lz0qN8pF3sHj+RKoNykc3Wqo/IgkI1LSQNtLR493AllwY+t
 qX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759250628; x=1759855428;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bGyiRW8lm9uoLSR+w+MaqXaOt1fjuFE4l9LsREL/dUg=;
 b=BsuGqGhEpvHdGqXyFXCe67Oebv4GbU3zueDpYxDvM8DK0Uv09l+xVMt4MUwDRHWrum
 XlrrpM7vp0Tyxs1L7yV3zAN9Y+V97jX2iZ/tVeaQCYfCfXor5hEMY3MjBEVjxVstfemk
 qRs07E94drcP0taNCiAdToEGrSJh57pe6p9u0RI6/SAFc2dUKCZzlUkd0Wd57m/BjEYE
 MDd5isorKU0SgSgCNdrG/xdgSZEglRAdDt5uWCJhiJIGRLyJmXZYPSVDYPmSHW8bb10E
 yMbXGZvLmSZOb0tALwZOkVuV4DHy2hP+CeVFOKFUrXYa2xfx4ghWeeWFTBgj3Wiiordf
 Om/g==
X-Gm-Message-State: AOJu0YxCQhdEBNOte5OD5zDGS7ny/osGUNLCO0z5O7057sDgPTvJqJ5J
 6cgZFvQ+sb3ph0aeZnU39r8ycRPlt2+YeuGUp7ZTNPNX1FcFasdeh05coHnBSrfditjHWnAPA5H
 iAl7D
X-Gm-Gg: ASbGncvumteR8646i8qE/zaitbKo/BKHS6DeRfJTMx0/lXUEWziyzohnbe1ybBCMpSu
 FM2UelkmGBJNIQm2ZWWfxLD9VMtbZCkz2+jC+8JOR3iUmce7owqFWwHic/CaAHdygDZ6m9RK/BK
 D8o4bKVoURBvn94aqNfAiG/pw3B6JH5kJjBa8lm309GwJ7qfKB3UQSYQR/mlAZk2jNrPhC7k9vn
 ZrAwGH0qMFBMX/aa51DPPV8IGUwCJCKNPVQI9TscRHr40PTMFyzV4ns4ApMFCB0n4OG5HEwResT
 zkyGcY+cWh2/LNfatw/CraD1hB0Ur/zfIVqXOOpe+FXhTD9W7yDQzf1i89KCV7hh1RJyujVAqlL
 078UR2G8jH8t1WCPHxHjicNF+pFTD5YrPYs5H/bUJL0IYtnlWMZYTXP8U4AJD2SPj5mnAwKHXNS
 Nz/vhlff/N
X-Google-Smtp-Source: AGHT+IEkshvSw02DXj52jYgt/eHmqNyY5edJ2AO/u2NM8VXCF7Mv0cReKruhZCM2MbwzMyNSMUZpXA==
X-Received: by 2002:a05:600c:8114:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-46e612dadeamr4647975e9.31.1759250627689; 
 Tue, 30 Sep 2025 09:43:47 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:aed:2018:ed42:d786])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a16e13sm830825e9.15.2025.09.30.09.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 09:43:47 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 30 Sep 2025 17:43:46 +0100
Subject: [PATCH] video: exynos: node variable should not be unsigned
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-video_exynos-v1-1-c29d1bf0eecf@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMEI3GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS2MD3bLMlNT8+NSKyrz8Yt0UM0sDUzNTAzNTE1MloJaCotS0zAqwcdG
 xtbUAVQYO8F4AAAA=
X-Change-ID: 20250930-video_exynos-d69056506545
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

THe variable 'node' is assigned a value of an int, tested for being less
than or equal to zero then passed as an argument to a function that
takes an int so 'node' should not be unsigned. Fix it.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/video/exynos/exynos_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/exynos/exynos_fb.c b/drivers/video/exynos/exynos_fb.c
index 0407a3f51b0d0b3dbb43e2979055208540d5549a..1cc1bd92e5712a8d3b43ac6fac61a4543e4bcca3 100644
--- a/drivers/video/exynos/exynos_fb.c
+++ b/drivers/video/exynos/exynos_fb.c
@@ -350,7 +350,7 @@ void exynos_fimd_window_off(struct exynos_fb_priv *priv, unsigned int win_id)
 void exynos_fimd_disable_sysmmu(void)
 {
 	u32 *sysmmufimd;
-	unsigned int node;
+	int node;
 	int node_list[2];
 	int count;
 	int i;

---
base-commit: 9710d98e8942151fc0c62d54100d9d27e8263d04
change-id: 20250930-video_exynos-d69056506545

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

