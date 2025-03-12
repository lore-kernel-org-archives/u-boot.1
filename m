Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8748C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7C081CA4;
	Wed, 12 Mar 2025 19:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aze98nmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1978F807D7; Wed, 12 Mar 2025 19:08:14 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C6B88141D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e5c9662131so80818a12.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802892; x=1742407692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHa9uOP3A4Re4okTZg4tPMUZNtKHHlmPbt5M2GKG/V8=;
 b=aze98nmWkwaJ+SmNzVaEDwxzZrb+rTqIwentOO9sElfFsLiU8x7lPkHTSoV6SxdaOx
 KvP1sLglOxb7OFfkuYmb+jTA56D/Mf/MNCKqcKvtrIOukzomEOgszJrG0BcdXPJd93fk
 /CvILQbJ0W11HMTwbb28E+hLFZN22WfARPHPVA3EOj6VquzQrtLuFXvY78IySnkOW8Bp
 +9xj00wUHiN2UwsW1cUX8EGyMQC+SAV1sqTaByxQP/HDSM7B6IkubdEmod4CK+eTamID
 4D2gcrurCuA5Jq3pRsQ/OEURYengOlIH11EemHQgOPAeP0ierFhdiljCkEv4/VKiwjwS
 muwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802892; x=1742407692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHa9uOP3A4Re4okTZg4tPMUZNtKHHlmPbt5M2GKG/V8=;
 b=GbO6i7yk7chA33+TaOjHKI4YO6/wR84+cWeJNTygvS9hfnIKPR6vzRC2/LKdmuuovm
 qmOgYI1wfUL2DJt0/n8+OvO2zVqa2j61Cx9KYB4VVbMKCLzkDWLwjl4tvKc6aZ5oGqeA
 XyNx4wCUhFTUy/C+J1YIz1FkIH7g/wyab1lDxknmVzfQ6M14yx/jM3q8eJQFpzQc3HLp
 Yr1IEugFTrMW6hmkVfbJunvKY2u49i7NO8kdMEHJu7PvvEXRK0EM/vNJW73rTYkd+fgh
 31d6rZz9EUW7wMHsm6J73/Yeb8QlNe3zdzYlfiExvgPcuI9Z7L9szKTr4Ni9UWW1lA9a
 dtqA==
X-Gm-Message-State: AOJu0YwBM6BJGJ7pQ8AUKkqetSwpPUQW/+Begz+DJ5BbrKuGyjDB5M4q
 nHqDyYHnqHC0dpegGCntq1Uu+u+X1FijzSPcSv78JNrNNcV346VK
X-Gm-Gg: ASbGncujnWUVpgKKUnN6y6JgEUHLhehlOxLULL7yMnxe+POoaorNN0cYpIdqDKC8OBW
 wchScHHq3u61K/hDlo9j7ofGpLMUDKVRa8OHLHv0LuC1DdGVfE82qjxWGOl1qTzv1HDh2tfsUYn
 WAUBCHAcoEiq6CvShdQAyZaM4jR//H6mqgDmh0ZP44EAkwGCLf32ZAkuAU8z5cFRsMcnG3CHzXy
 JWpaCr82k2r+CV7b+uXaKkPCXuysCm8UhSAk29alovCuA2rGVehMqYitpcD+W1UQgqhtEHoXGl8
 xXjBQBBXkf+qFEClUzYTY3cSd50gSz0+Opc3
X-Google-Smtp-Source: AGHT+IFMdrsPFvPxl9+gpiZHl7Rip4c201XOpF/mGa3QiV1X9CVNTj/Nxn/HYIlZHstbORsQCdlf7Q==
X-Received: by 2002:a05:6402:5204:b0:5e7:c438:83ec with SMTP id
 4fb4d7f45d1cf-5e7c43895c2mr3567799a12.6.1741802891545; 
 Wed, 12 Mar 2025 11:08:11 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:11 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 05/13] video: bridge: tc358768: remove need in clock name
Date: Wed, 12 Mar 2025 20:07:46 +0200
Message-ID: <20250312180754.120946-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312180754.120946-1-clamor95@gmail.com>
References: <20250312180754.120946-1-clamor95@gmail.com>
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

Bridge uses only one clock and enforcing name to be set may
cause issues in the future.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/tc358768.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/bridge/tc358768.c b/drivers/video/bridge/tc358768.c
index 6f1b057c208..358004f30f2 100644
--- a/drivers/video/bridge/tc358768.c
+++ b/drivers/video/bridge/tc358768.c
@@ -951,7 +951,7 @@ static int tc358768_setup(struct udevice *dev)
 	}
 
 	/* get clk */
-	priv->refclk = devm_clk_get(dev, "refclk");
+	priv->refclk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->refclk)) {
 		log_debug("%s: Could not get refclk: %ld\n",
 			  __func__, PTR_ERR(priv->refclk));
-- 
2.43.0

