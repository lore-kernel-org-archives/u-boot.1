Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2777DC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B34088692;
	Thu, 18 Apr 2024 19:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wZbcJh8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8014B886AA; Thu, 18 Apr 2024 19:26:34 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F05A9886B7
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-415515178ceso8874455e9.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713461191; x=1714065991; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y6a3GLSxUNj02BzbfG0Y6SJymgdyRdvu3NJTVnfUdoU=;
 b=wZbcJh8O3LrGSD7qh9C9GVxph6SORlbb7VpjpSmQ03Ftmzx55pjxRLFuFmTwgFJB8l
 HYs94QY1Jt9+Rl7Ey2gLva/2iIvsBfU4aHJc8+boYtcpm0AoXysClYv8MPoCRz34GFMl
 sY6ay0sSEzOVXMstySYCZLkJOYi+rvC5zbyCC2H4Psy5u8wgTh6h0FkBxD2FyaaDKrlN
 hm9LyPs1iVJ31oC1NxioWWs/o5Y0w1A0KGOSH/KdWz6Lm9UTFhwc3LKJvxGEgjMTanJU
 SXuDFDaZo307xnQnczjh6cbAysTm3Iu8j371E/CBBQ2aTAhPULPhXLJzBgF2gCY4nJZ4
 9JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713461191; x=1714065991;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y6a3GLSxUNj02BzbfG0Y6SJymgdyRdvu3NJTVnfUdoU=;
 b=QHIDwbjK9EQwrNWnE+wAJUlVsZ/yXHwaq3qc5OzUTUIKR7zhJpZk5EV63GX0TYB4Nd
 JaQPhTHYv0A+aa4vQvDWfs+60idFSqZM1bVYIhJpGRyJCwnZYLozE/+eVl29DGhoemgt
 lannsu/gsZRZER9I0Sij7pNRFItm3mJI8Vdpo6cxI2H5ZX5Z2zerXyZTYsvbhpWGlkhz
 nhAJ/A16+01zFUKoHmugMQgdwEyRqG2TwrglP31asU9Qiqi6yGcplMeR4m4s6hEEneZV
 vogtuRqa86DMtMqAMYospu6i3SbXacSH25mNjLobTytv3vw/qNu1aQY51Lc8ClQJ62aY
 gvTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3T3/eiIul++d64M0ue8uC52uhXcSB2Esbd5OdQn4Y7N+VZ8RnA4YWbzzoPPskZjRatFNrQYHNexBTjJIH+SaB+pkfIQ==
X-Gm-Message-State: AOJu0YzPnYtOWsd+BFthB8Qxlp0srRlhwdO73YGEauN8ZACcCueWRWi+
 /bFblnzhaopN7Y8aBjKCyYiw7lMU0N2SNWAc4dygJV2aXC60ushnhA4tiAJoFIo=
X-Google-Smtp-Source: AGHT+IGXbOpV3Iq0gX0xzdgYIRGPA0Ck5jFgc5xeNNIqvMp1nLs671u4En3VFHMJycxjNxcRyttl1w==
X-Received: by 2002:a05:600c:34d3:b0:418:ea1e:39fe with SMTP id
 d19-20020a05600c34d300b00418ea1e39femr1437491wmq.11.1713461191534; 
 Thu, 18 Apr 2024 10:26:31 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00416b163e52bsm7166057wmq.14.2024.04.18.10.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:26:31 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 18 Apr 2024 18:25:51 +0100
Subject: [PATCH 8/9] qcom_defconfig: define safe default SYS_LOAD_ADDR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-qcom-rbx-fixes-v1-8-f5f19d52969e@linaro.org>
References: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=798;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=1V1Gh5aVu/+gXh20VBp/jcaLhsPFs2yDJS0tddNqSqA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTF8H3xzmcrWiR774n8Xlb97+vJoIxL3wwifkSv3HlLx
 Y4xZYp7RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZiI/XqG/6kLPlpaRT6adtg2
 U1Of+59S9e58Ka4d/vfclvmoBqs2n2D47373/ZSln2cW/JNfWLvG/tsro+MuMk9Sc7jCInQrDm7
 UnggA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Defining this as 0 results in bootm causing a null pointer exception...
Define it at a safe default which is valid RAM on most qcom boards.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 209a7ba324d0..41545fd72fcc 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -2,9 +2,9 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
-CONFIG_SYS_LOAD_ADDR=0x0
+CONFIG_SYS_LOAD_ADDR=0xA0000000
 CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y

-- 
2.44.0

