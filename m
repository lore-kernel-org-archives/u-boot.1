Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6393C36017
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 13:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9ADB81F0D;
	Wed,  2 Apr 2025 15:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="euk70jZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7678081F0B; Wed,  2 Apr 2025 15:36:16 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BA5E80FDA
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 15:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso3557227f8f.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743600973; x=1744205773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9ohSw1opzq1FjwvGns6aVl6Z+kZj0ElHoWZxxViCU3o=;
 b=euk70jZc0EMLukieqF0d4sO8aTvKjtNaWkumxhr/4XirNi4rVrTjuQ6HdTAa3b11dp
 UxeFN2FL5Tvx7PxBVLjH5gBp+PotPEMtighCq/lRoNuVfc2Q/2vdsminrniSZyvQJbCY
 GRnnF1QV2wTAxPRtBoaMALPIzgQXU1GMsJXFpgPCeT1gmjzQAlC2PSB6oX2OooznpLHC
 bI/JWcj0fjejo1b4Gii2Fy0ieGIUB34WRiIWhuHf5OIoDouq4Uog0zdwYB305I2pqAcT
 5OXTayLUKSPtR2Tgd/Z0nOLQPZfHb0maOlwLYFHp/OIlZIO3qpb+2HEQkb+4kPQhJiO9
 8oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743600973; x=1744205773;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ohSw1opzq1FjwvGns6aVl6Z+kZj0ElHoWZxxViCU3o=;
 b=SiuG1MltY6OJ3x9XGAfQm59fz93PKP4G04RfxRuA31/5YatmgWzLrC3vSUB/WTgWNn
 RFwitiRw9RtFzxkbBhY0sjJsHMXVc3Ly3nozMfESaYB+dhZuAobfY/9DiPqUBUH5Gz4k
 8bKo9lNB1q8xpKq+B8WgQ14t1OAZT/raiN5jCMjbOUhEgqL2cKVD8vYFxVqw/xrN7/2+
 81VacDZsGMxhvWW1FMwG9kPuc2LpL/IsR+72rmqZDC6v1giO0K28TahjJOwvvldM7255
 8TeydwpDYDyQGDjGAagFll4rt8kmG2L4AV4HRUQML4fufYzKVTfdB97Bxn4FojJ+GFJ3
 YnKw==
X-Gm-Message-State: AOJu0Ywqok3dFH7Xz0mPTwVrHe3d9tbkCD5WkGHIpqioS4plKf+U3uby
 /Sa6J+E8/UnFGxp8jADZPW+j/kMByVUkEHMKa1oEIxT+jgx7mwmeGpL8/uJGIMy3OAPH9NYRWlk
 b+q7tpg==
X-Gm-Gg: ASbGnctedbnUrLrKplsoJJndAzvfhWsqCm1ELeybu49UtMqxus8GPtzo96Ik0x51VJd
 j9aC5f+HZtIa2YvglH2/SePL6STnZnPU0DnG+efVjfJnDKSG/QVXOmiEoaUrbYE2fWI/rd5rI4m
 MsZa8dg3C/4NuNZf6j1wwvhhEO4RpMG5VdSkhOlDtjcUHmDtO2via0OZRPUshh6CzrWnWmh4M2h
 gn0EEzcj+y9s1Dbbe8v0LptUEzgspqQSMrtF95WHQuJg6QTkoGLke+7513x+/7PayllqwRmlR2F
 NY8kwusDt1pI5Qx9HlksRbBme17pVUimTKS1x/Go3nrqNNUIqiCIog==
X-Google-Smtp-Source: AGHT+IE3kbWXdGHSy5QwmjABnQLRlPHh5AJmm4/b4fdEBJX6wkAMewrpktk0tvD/R/DpxzLYCdn7MA==
X-Received: by 2002:a05:6000:4210:b0:391:481a:5e75 with SMTP id
 ffacd0b85a97d-39c29752ecbmr1935803f8f.22.1743600973498; 
 Wed, 02 Apr 2025 06:36:13 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1e67:7bcc:e97a:7477])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66a991sm16928961f8f.49.2025.04.02.06.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 06:36:13 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 0/2] NET_LWIP LMB fixes
Date: Wed,  2 Apr 2025 15:35:54 +0200
Message-ID: <20250402133557.2079137-1-jerome.forissier@linaro.org>
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

Two small patches fixing issues with tftp and wget when the network
stack is NET_LWIP and LMB is enabled.

Jerome Forissier (2):
  net-lwip: wget: add LMB and buffer checks
  net-lwip: tftp: add LMB and buffer checks

 net/lwip/tftp.c | 45 ++++++++++++++++++++++++++++++++++-----------
 net/lwip/wget.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 74 insertions(+), 19 deletions(-)

-- 
2.43.0

