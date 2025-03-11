Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAA4C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 17:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79FAE80FB9;
	Tue, 11 Mar 2025 18:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MpfcRO1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2994781197; Tue, 11 Mar 2025 18:55:50 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0575481197
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 18:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-307c13298eeso1109561fa.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741715747; x=1742320547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vw6RdTew8zK/8TKpiB8G4gxajnJPLx/zZyA5rbgrZIs=;
 b=MpfcRO1L3/FQ04NHB2qXFF8C8th9KLwYwvF4o7WRdBHk82U7tMKt1io8J/FqUhyxBT
 TOlCsQfyoQbR5QASgPmHOWj5FTw0PuorKkG/aB/y7+ca4V4IjUq/66bLcEQc8XL5R2gq
 qepoUXCfkzusz8eFz4fEVeuqW3yGesYl7SO8TXVY7m6Bk9lbMmvTV+QyRgEz3/G+DsGW
 OfNJfE2bE/z3wtpwhg+RbaXeQ3a3YpMzHsjeSwVmp/tDMMmZ1HpY5+urKwdmmULsBIUf
 aaDxuIcmsMnApCQ1v6uii8U8bbpJRgiGYQdA9VUnE52T8iXvV7Ck5CQOjjrQd6rWUgQY
 Cv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741715747; x=1742320547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vw6RdTew8zK/8TKpiB8G4gxajnJPLx/zZyA5rbgrZIs=;
 b=pGywhCSlBt9XlzHUFHn19vLVeGXrSWhFzM4bLXTdNN2PXlJ+4QZNMvvhxnPByd3pUM
 y/CN7li7ewRaMHxe3UuO1dxYNaAx0TZ3w6MpwfRGWZa7owInyM30k2KT1UzqJoSE2A/p
 ca6B738Sfcn1JpOubKMRAaqL2hHumPX9MDCxsID+WxtQ/baryJ0LhbjqT0K7ATih41bO
 9Co7Ksh9RwoyVv3Uq60q5x5iqyKYmDcm2amDVoIv2WGHeLZ9lON4D+6mL6Opv53t69oJ
 fQ6hgWpy+k3vXEMmMWuML+RpInHshOOlxcS6zg9l4mGBumOy+0WrW/cA8FMg3G+dMcUx
 naLQ==
X-Gm-Message-State: AOJu0Yyd1jFLS1uHKHf2Y9dr0tu1Z3yVdKRrmVljZ73k+uVZ9hLll7Lf
 dNCxI+FhuH/HQwYy4X/6xxHs+Bcwfe2VKo+Gb/VuKF2+bRgKqfDq
X-Gm-Gg: ASbGncvbDUSOvLzWBMv3XHbm5HeQob9/+5gpnkVQhfLZjPCAYOIKL2M5fw2cZj9xfFi
 bGk5kF1YAxmLZkKU4drwAP9qOP/qIpIYChr8HDqV4jhZ5gwJW9XAb/uKFnp2VyJ3+gj7nQbujNq
 6dIj0LYXfFBzGvVkbdlWJmnEWn1+17I/FPJFiO9ehgzt1+NgZd0S8H3N8yz2ia9X0fSKAIy/one
 W3Rwdz3YZeoFAdzL68o/Y78X2CAy70Uob8gQMUt9s9dsG7cp5Rt10lWfMjtZfqZkES0EydmOZ67
 EGiw9OCKQOGdNmW4zRssq+FVL1w6dKPsVmMltJQ7FWlb3ko=
X-Google-Smtp-Source: AGHT+IF8d1F77jeJdnanHPcz+WTEBtPXyrT6Pu2vyLctqkYMoJyT+codvms61XeH6z033+CUVlL9LA==
X-Received: by 2002:a2e:b8c3:0:b0:30b:fc16:d482 with SMTP id
 38308e7fff4ca-30c20e3f100mr21948461fa.3.1741715747052; 
 Tue, 11 Mar 2025 10:55:47 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30bfceebd49sm15542811fa.60.2025.03.11.10.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 10:55:46 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/6] configs: endeavoru: add 3 second delay before power off
Date: Tue, 11 Mar 2025 19:55:18 +0200
Message-ID: <20250311175522.120018-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311175522.120018-1-clamor95@gmail.com>
References: <20250311175522.120018-1-clamor95@gmail.com>
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

Introduce a 3-second delay and an informational message during boot to
enhance user experience.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/endeavoru_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index 1d1f1042291..cc8777e4d83 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -21,7 +21,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan; poweroff"
+CONFIG_BOOTCOMMAND="bootflow scan; echo 'Boot configuration not found... Power off in 3 sec'; sleep 3; poweroff"
 CONFIG_SYS_PBSIZE=2084
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
-- 
2.43.0

