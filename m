Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC95C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2DB80A08;
	Wed,  5 Feb 2025 02:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BTDZh+nM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8534F800B3; Wed,  5 Feb 2025 02:57:42 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA6D8096D
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-726819aa3fcso1688107a34.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720658; x=1739325458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=239TVKGtgb9IN+UJIrt3+Ij9J9AYZffv7DMM689suik=;
 b=BTDZh+nM7HOzomsoo685qqknyygTK0lLLfewCD1g6HOm7TgbAghaJREVb/bHHMFOuR
 fATtN3QSZg1fVj80xZzWTtHL9LTjwYSZBG7hGjqwH/dm6vh1SsdR0iJLp82P+KuFNqi8
 y3d+TRzt9l47IRRbdxyoH/3SvjYaDniD0JICg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720658; x=1739325458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=239TVKGtgb9IN+UJIrt3+Ij9J9AYZffv7DMM689suik=;
 b=qf+d5RrBLN9IPj1hF/T0nRkXEWXBz07iHIbhW7NJnXAHl0IO7Rloq6h50T88DCVJNW
 1ldwkj6Jr06LqE/88TJsgIKc10C7DXREkCYHw9cBcudmpNqigT538QKehHn6cytziOuT
 /U9EyAU6UkZBI4dJkZC7UwioGbDMJaR+ogYXolQEGJVRzvAmnPp1OeMmgaosLORbhDCe
 Jtwuly6IsRUSNIKA/nkjfdc9zK842ZOzQpuuXOQVhLbxtOSCkr1SoxY3vcggysvEADOm
 +/U0FLI35W+KptU4ZpU6MzzPOFeUYSBY2IDM+1MIBerQG3/pkOFtycdZyb9xfwUH6QDH
 M+Gg==
X-Gm-Message-State: AOJu0YyPIFm6aGElbShr5RXZnKPoPbpOmyCnJ65f20jk4DiQ2kRtkTr7
 ZK9T+wdrje1RmZy/YO3uE3oksFVvHd+RYpyF/5lpwQvztOL32E/Pz//scT12PPfZ0td5oXZ96Ls
 =
X-Gm-Gg: ASbGncvo8Y3uNFhxcM3u4CG101lysr8UtwvBP4BOCZ93r/2DQTZn7oFBvXsqwPVxnal
 gxXSSf1AuZySje/w8dnRRL/7wkl55zbgJt/+VNOCAmyj7fESLK/xWIstS5e8OgDmHtZHAi5VS4P
 jRyeuQR8G64XrHWS9OfZa8y/Z98Sr/HulnRz9KZ0jxbXu760aEfNzF3gkMu+jty+/bTjy/QeNCX
 iHX3XRGGU351QXMI+K9u68VKNtp6RYuaVsdLrnQ1WHJt01/XjIGspLbvlNOhpto6GDT/B5CsVsR
 xumWkIyj4yFhxHc6+85/xHdRb8wsA/qV1k1Z4qY49jTfh/WphBiW
X-Google-Smtp-Source: AGHT+IEpmKBX1KeNpnxTpMEcaqmCKJguiOt1TLBYWTdWJ/PyPFfoHxCeLIinCNiBe67TdMhAG8XWAw==
X-Received: by 2002:a05:6830:6303:b0:71d:b6a9:7489 with SMTP id
 46e09a7af769-726a41870c6mr925902a34.7.1738720658533; 
 Tue, 04 Feb 2025 17:57:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 23/29] rockchip: Adjust rk3399 TPL-stack to the same as SPL
Date: Tue,  4 Feb 2025 18:55:13 -0700
Message-ID: <20250205015606.2686149-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

There doesn't seem to be a good reason to use a different value for TPL
than SPL. Change the TPL value, since it allows a 256-byte bloblist to
be safely located above the stack in all phases.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-rockchip/rk3399/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
index fc55b498111..8064b6286fc 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -159,7 +159,7 @@ config TPL_LDSCRIPT
 	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
 
 config TPL_STACK
-        default 0xff8effff
+        default 0xff8eff00
 
 config TPL_TEXT_BASE
         default 0xff8c2000
-- 
2.43.0

