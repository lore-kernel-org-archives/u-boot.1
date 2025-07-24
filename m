Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47346C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 08:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38BA58367B;
	Thu, 24 Jul 2025 10:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HYbmtzan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E3883678; Thu, 24 Jul 2025 10:34:58 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A3B83678
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 10:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso4576055e9.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753346095; x=1753950895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACWp6GY66lq+ZhZz+p5/+LN6BPkTQSS9yGRmMsm2NVY=;
 b=HYbmtzan35SmxAuOxWuWhu5VUriKHZnKm6fj21GTFddXgh7XrVbJbY/3n4+Q6rcsB9
 j+0upE0s2AU1TEYqBPgO8CtKdjFieMJeJ6jexEI9NP8+jucFM7ynriSDwvMRpsrEho99
 vwlS2yA4UyG7wW8LFqcanOSyUmT2G8x3BkoZxEbhtP4HzRuww5LtjXVeWQEMRRhtU2oB
 KG039WMPKOblEoRaMekmyxOMc/NbHJ9xgWd7MUoBKSYfkf63/MJi7a+gc93tfUT71Rhs
 wDUPFCFvh0U5e2htlpw07/96hoXHVhV4Gu5LEMLSuN+VVydt3V6yjpANBmb+rp5yfdpc
 mbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753346095; x=1753950895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ACWp6GY66lq+ZhZz+p5/+LN6BPkTQSS9yGRmMsm2NVY=;
 b=R+AP/Ii//VY/HEhTGO697GCOmMTlY4pthA0GWKQvUX6QdjizgIJsKrdEhe1J8Sgr2a
 TdAG0biVR0QWinYYgz6OplXoTstDDrugjNvYJrOlzPh5vj+4Pe5mqUVFG65o5CMqxRJ1
 +rAGs+/XP1tp90tpakWZ9tof5pPeCp8hX9HmLt2Y5TLOsiw/3XnvI0jh9T34S5lRHaHu
 VHzc0TaCKiZ1T6WUlMjddsvR47d4dp6ASH3D1/Em6bV7hb3OOiehCflDmZkpisvupRoA
 qVFqgsoo9G4yogHx4qRgOQWayVLSzg1sKNlHNTVWccq2SGdo6EeI2emqgm8xrkzPOOIA
 XrRg==
X-Gm-Message-State: AOJu0Yy0EjUt/2/xEJU3kufuBL9eumeG7f0fN745dTlycau68fBu+imG
 xNsowuEsI9E8mQ+4PVrnqB8QREGuqn4jguy6WFsFLi2sKxC1OCJSTl5mDdERbXSKmxsZcfxT8yL
 L4ak6PhjFzQ==
X-Gm-Gg: ASbGncuPNSq/tNXx7NCLTAa8+yV7S5QIQaay/Y4fP3pxQHkQj+iDPKxkZkd30VLGHZ3
 4TuSNfvgh4XUXotBjktSjvzMIfj0Ue07VQh1vc1GOwxrFueR56HZAJzHd+1RguOISFkTfxso7d+
 8Jl2FJKyDKXysVyEnPIp9sjLgljCo61by6wr/mQBYXFXbzTiuYRcesybMfT7yqPOpUbfKu3t8Um
 te8Lze344RCn/mzwQqZ+GNOinDfsJNtpSnu78aME7qFvs/QOC+ZteezvnvLDL+6imTzQRQaOA3m
 MmH7Rx4bcUfj4Z2TZ0fKHW5KBx2X8emGOkCfGiiC500Y2jjaLetYPVpcp5xoQttDl6/gmvyBV4X
 6/yJeyMtLD2eakZEVMTLnfAyevwzZ9A==
X-Google-Smtp-Source: AGHT+IFbf9pQNMH5bymSHMb5eeifprjglP85g8rk2UdCu7SCdeFZMiWdkkRp5nVHv5s5m3DClyyecg==
X-Received: by 2002:a05:600c:1d1d:b0:456:1b6f:c888 with SMTP id
 5b1f17b1804b1-4586b8f7675mr39029175e9.23.1753346094997; 
 Thu, 24 Jul 2025 01:34:54 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bcf7:2df7:a82:bef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870577af8sm10962605e9.32.2025.07.24.01.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 01:34:54 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] binman: bintool: use apt-get instead of apt
Date: Thu, 24 Jul 2025 10:34:20 +0200
Message-ID: <20250724083433.57867-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724083433.57867-1-jerome.forissier@linaro.org>
References: <20250724083433.57867-1-jerome.forissier@linaro.org>
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

The 'apt' command is not meant to be used in scripts or tools. Please
see the man page [1] for details. Therefore, use 'apt-get' instead.
This avoids the following warning:

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

[1] https://manpages.debian.org/bookworm/apt/apt.8.en.html#SCRIPT_USAGE_AND_DIFFERENCES_FROM_OTHER_APT_TOOLS

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 tools/binman/bintool.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 81872db377f..f46bb52a7b3 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -421,7 +421,7 @@ class Bintool:
         Returns:
             True, assuming it completes without error
         """
-        args = ['sudo', 'apt', 'install', '-y', package]
+        args = ['sudo', 'apt-get', 'install', '-y', package]
         print('- %s' % ' '.join(args))
         tools.run(*args)
         return True
-- 
2.43.0

