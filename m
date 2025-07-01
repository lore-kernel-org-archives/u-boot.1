Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E880EC7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 13:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7534582FD4;
	Tue,  1 Jul 2025 15:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nDUMas3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C1CC82F83; Tue,  1 Jul 2025 15:45:38 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2053082B18
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 15:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ae0c571f137so1098068566b.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751377532; x=1751982332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l3HkYuo0A0f3jmI3Xqkqb7cupbSLIHKiQ5F0CYGbKBE=;
 b=nDUMas3fxpWVnPHDCDn8GTmVzZo+PnNUW0yKExeDFMm1306v4/fsLWsNvkW6ScuLvV
 Wmlom2XF9F32xqk03QauHsNVukl6glJcGWEco1eSG7E9Z+OAUnwUhMRQWzUE5e2jfYvB
 KKXTs40LBfbptSDA/QOeIjuS63Qg+D6qf/G/+Ab7xFXnio0bOD7mM/wVxeRobXnr7NeL
 3jMYtcFXRH+egLH5O8UKWeGi4WLmu48gtNmlow1rnYAfrBUUtd17eed+B1vVT7JYXDmb
 xXJYhmnFzQ1zT8hkMiwKTId/kv72Zsd5Ef8sUITpTkdTIW3sOBb+NVZSVcGEm0uLKgw6
 zyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377532; x=1751982332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l3HkYuo0A0f3jmI3Xqkqb7cupbSLIHKiQ5F0CYGbKBE=;
 b=RPEHhyW225cuGT/lmjseTCcb6yhv7EC9W3tOmhtK6+x2VaMZHjV83AKgpsMunLB/d0
 1nUBPg18sG1IO5GOkWYgZYJPLmoErYA6qLhVQ8186xAhg3Kmuw8RgPryIz+9mY1ru+ED
 Ki0UwqkErtenlbkGc9onQUXY8HuxUIryyYHh6EkOQL1BweDCHOsfLMG/vbgx8M8s2b8N
 F49Mfl+JBZUXyBQBEnYSL4f6l+zWAS6H2+oyNuWKmfUN7OpjkM/M26dGcK1GZr0II7io
 M6yLAK5zZ8Ou6QYEtsStM4B8API8koDCT16hlNY0MwMfK7evUIGpxwE7mBpgA7an0ff6
 wFTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwEKhG77zbprcTTmkH6vLJBlsn2rGLVcM8hK+aBUYqKeiyl2WoA//9aVN5UM0eriw4kkznJmY=@lists.denx.de
X-Gm-Message-State: AOJu0YwwrU0Ra0QxK4YzWr+qe32hwNo/aLiMCBeh2XSr866ggGbVmrkM
 aRBTKptk9FMHjTmXM5oQina8bfCPYhVBkPhXTwjTHXWSCca3u8mNpVYAdSI4qw==
X-Gm-Gg: ASbGncsbbGAzSHJp9rJ4rSmraCTiTUK0kb58Jqw7XMemxndUiSmGLUs8+nmyLrOBmh0
 10GGLplUmk83ZpdTcie+lxMSzso8UIOH8t965gpTosyG4Y+JD0heaxIC5O3M+bbADXKEnYZlAdw
 VWOVCXZKRcNAEXBORKqyK8tAjyv0sOZHldcAyI5ayiW4BaUNahQHwGdGw991GG5nkS5DpN5pfLy
 AuBlYQUQerXPsXv+lkFP2OF0zsNr4X2/O66H/nSqCYwesrSBS0ELqk+RywZoeHPjs+NlzxSdgPI
 qHosbFZkVeryvuMsh+BUXozFeHR3JAqAMxm9c9wAc1en+lsTzOwdYpc8YlJ5Q/JSZOZ2GiIzIK9
 y9kFQpZNo0DJjJ942
X-Google-Smtp-Source: AGHT+IFPgYD03VIIEk6EPhxHFpmqIoHH6NBk43eMaOwTie6YGBK4hoZKbG0etJLATr+j4LqtjNHv4A==
X-Received: by 2002:a17:906:d256:b0:ae3:bb0a:1cd8 with SMTP id
 a640c23a62f3a-ae3bb0a263cmr46870966b.19.1751377532230; 
 Tue, 01 Jul 2025 06:45:32 -0700 (PDT)
Received: from emanuele-nb.int.toradex.com
 ([2001:b07:aac:705d:6d3f:7f26:74f6:c076])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae39ec1146csm288232366b.185.2025.07.01.06.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:45:31 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: 
Date: Tue,  1 Jul 2025 15:44:55 +0200
Message-ID: <20250701134504.1076115-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Subject: [PATCH v1 0/5] Enable RNG support for KASLR on Toradex arm64 i.MX SoMs

This patch series enables RNG support to automatically populate /chosen/kaslr-seed on the following Toradex arm64 i.MX System on Modules (SoMs):
- Verdin iMX8MM
- Verdin iMX8MP
- Toradex SMARC iMX8MP
- Apalis iMX8
- Colibri iMX8X

This improves kernel security by supporting Kernel Address Space Layout Randomization (KASLR) using a runtime-provided seed from the hardware RNG.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
Emanuele Ghidoli (5):
  configs: verdin-imx8mm: enable RNG support for KASLR
  configs: verdin-imx8mp: enable RNG support for KASLR
  configs: toradex-smarc-imx8mp: enable RNG support for KASLR
  configs: apalis-imx8: enable RNG support for KASLR
  configs: colibri-imx8x: enable RNG support for KASLR

 configs/apalis-imx8_defconfig          | 5 ++++-
 configs/colibri-imx8x_defconfig        | 5 ++++-
 configs/toradex-smarc-imx8mp_defconfig | 1 +
 configs/verdin-imx8mm_defconfig        | 5 ++++-
 configs/verdin-imx8mp_defconfig        | 1 +
 5 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.43.0

