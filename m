Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C72CEE349
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 302E683DA6;
	Tue, 18 Nov 2025 19:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iLUVHs0O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8CE383F9D; Tue, 18 Nov 2025 19:04:27 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1678E83CB9
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3e12fd71984so3106302fac.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489063; x=1764093863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uDNC+U+wB0ZqF84U28nxQJmCwdP1d2WKitFry058/vk=;
 b=iLUVHs0Os45CIQQo/ekmOpA88+F1epEa+3KxvJ2zGuawpw4UNqwRCbMJa3nhXWUkeZ
 hPitzm2hw8FRyCT5bO+0nPbPyZ8e2eNn2M1MHAVton4WXLAYxvBcXoFd75b41WIqCCLD
 yy5Kyuo6lraxbNfoduY4C/kc1AQbm08Qw9a28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489063; x=1764093863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDNC+U+wB0ZqF84U28nxQJmCwdP1d2WKitFry058/vk=;
 b=Li2Kpdc0XSjrSz47dE5nG4Cvo3BMJbb3ALZa72R0rjJr/SCJT1ZSm6VSjrJbnzHDd6
 x0X/76Z6oKhi32fy2iHgav8YL44vJOMpeAYHRvXoZyCw6QQgudoLAE3Edz/cDA5aVPiQ
 1LHiuA4FlEIBF6Wuzg7+sz518ht1R4abB5Mq8/0rWOrgntjfCIwnuhhm6OSmiWmiqYqg
 Z2Sb20IXYQqeA1Hu4vs91mYu964CMncHP7iSdRxNzMaG8BMBNe4oJCJp6GRJaUl+X2tZ
 KVEVXoPtg+I0j3BZV5y7J06gvI+qjgNhy2ffuNjcn0QGUqyVkyMGIdTIfPxS4Lsazr3m
 rASw==
X-Gm-Message-State: AOJu0YwkO20BdhpQI1n5q0Z2Ymx/o1cvwGBhPpLtTKVY3NvHaJ00imKq
 VHjZ2lP5LaLIEUhNFvCA+hqrV9ndMazRbhHWxYtGspNWPka4QlxmBjhTyfmUftgBKRifW91m1Q5
 YwTFuLlK/lg==
X-Gm-Gg: ASbGncsaQ02ho9zymSOhWeoVanZFX9ck9zs3JOFrawZ/lefznYGJdBaLcQbcOXuwzyM
 PpuKavTh5sPDfxFW0ONyeNMFIACkc04urOlu5dn4ojpGSlM0hAX2DFVbBJ6rVrigXNo9arDOk4l
 a9ZA75NxmLxD1EuIqAjqSGQjjvA0hI90JM1hEWM5awR2rDatm6xb6DGJfoPJEEIg6176VPFtlD8
 ca4Vu+Ct+lW/TWvxQF3gJ1YTukyNfvOryaMBZjxm/b3lS7syPkjjV8gwAkcQM7F+K/GWj6kclA+
 HD9V2lTFTCsO+EksvCFs19E/X7+7orqAIU21KyweBLfw4FoXL4uWdgeEb4GrrOsGWFA+/UjDjWt
 RavrkgyfXHRQihbluLdnhDEvJd+VO5CQgqpkNGgU9PSA1dzIl7ww3eeQoSN7/ykco5A290AIOBf
 OzPfMN8lx6oW0lmm1BnOz3m6A15EcKw1TdeKfCPxQu1EDNY1alJGt6fK+A0Byf/lUmr1iajnLm5
 A==
X-Google-Smtp-Source: AGHT+IF5YQDXM4T4ulLq1/0Y2W0s+xm3v1j3QCuIpR6VojACOfoGjoJkTHSbbEi3QQ5vgbkB37eUeQ==
X-Received: by 2002:a05:6871:2b89:b0:314:b6a6:689b with SMTP id
 586e51a60fabf-3e86913ef62mr8201307fac.47.1763489062855; 
 Tue, 18 Nov 2025 10:04:22 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e85206082asm7274497fac.10.2025.11.18.10.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mx7ulp_com: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:21 -0600
Message-ID: <20251118180421.591316-1-trini@konsulko.com>
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Fabio Estevam <festevam@gmail.com>
---
 include/configs/mx7ulp_com.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/mx7ulp_com.h b/include/configs/mx7ulp_com.h
index 139536547de2..d27e9d2eaa14 100644
--- a/include/configs/mx7ulp_com.h
+++ b/include/configs/mx7ulp_com.h
@@ -31,7 +31,6 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	"image=zImage\0" \
 	"console=ttyLP0\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_file=imx7ulp-com.dtb\0" \
 	"fdt_addr=0x63000000\0" \
-- 
2.43.0

