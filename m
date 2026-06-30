Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3E7C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 14:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8CFB84A51;
	Tue, 30 Jun 2026 16:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ck1tK3rb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A110A8486A; Tue, 30 Jun 2026 16:01:06 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0EC084A49
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 16:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c126b50724aso16672966b.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 07:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782828063; x=1783432863; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ivVOrhKXxvuY37SNsY2AXwsZ7viITMmF8twAlK+6P7M=;
 b=Ck1tK3rbGlfIwNRtlfom6YCNQEAhy2gL7szp6YYz7wOiwWiNN+CWlTLiHLAimTm4t6
 7NC4IdjwXnTW56IRWye+gzoBUubEUgjGnBafSeX+40KXrA5nAq2c1g9x0i9YGkY3x/ie
 srivLK1AVtLWyzAM/z+JiHJdJUhveVauH7ngzzXcRopSNgoCVnvPDi16kTjso9QFP3Fk
 iu4YvDdBSFmz5wPG/TKAIoBlJfkfpwvRdl2mGXqjRA4A5JF2ig26M3GTNOs2OhF2KPPe
 So7IMysNDECZ+NDmBXpoo/gtLygOjuiuS3RNhbC1bOvR4Q/UqO2Yb4TAEBB63T3vwm8j
 HLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782828063; x=1783432863;
 h=content-transfer-encoding:content-type:content-language:cc:to
 :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ivVOrhKXxvuY37SNsY2AXwsZ7viITMmF8twAlK+6P7M=;
 b=JxvfwJnoF7UlZd2flDbP/TxaKmAE8gI8upJp8fiKNZbMfb6koBI5pH3jcCEri/f/Ls
 ff3cKT4MbEO7DQLnF4sWqEOUY7uyxCo7QNsl51xQNLDA5w85VtQgGujKy+qRT+Jun0fV
 P3Km5AwztX80CFX4mwIabHlYdFgLKHKslHB1Fi9g0xdZ/0O5NhLwwIoOTOe0MnR5BIJe
 5RvL8iu3XNYM5Wlk2/WmMo6SOdDZSADnygjr9ZbNUnI/3vDtQRm7HE35INI9tTo2q+In
 rYRR+xakcYf9dNd3YzeY0eKVyFIkIru7lxqsxcQgliiUrnJPpfKPRbwWixpdu+wUDmbN
 XtrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8G6YIjl4fp86ypq+3X4Bf7R/v1Hj7T7IYDz64+fUw44ZmHrkXTfd7nPbODL2oKXw5Le0elq0Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yyuy4+xj/veoqd1yRlp8VIvrFzZ9FEZ1pQjRsotMzlEexW+uo8w
 AvqJ6mepOXGQSmrOY5BlM8aNy+yfHvNKqQ+OgxYK0DkWddn3cziQkesi
X-Gm-Gg: AfdE7cnieJK50+BXm3gRL30lXcXQMR1ZEJIIg3RL0Aiyr2KD/gNiSt89nRpDKmmV+eo
 eQQv3zhdzi2dpuyByCe1A5nDLQqSNY4+TJAXLLFQyCYPo27UDQ1/6/jfofFAr9QMWWkPdxW2Efw
 YZHDeeKlgwmyargpHa2g9b7E6RJZ8gcQ5VZ0dRzpHrYJPQq65ceQutJz3SoDWWu5Y2Ew/nmdV8K
 +1tsILW7sNx/om0LjOjZZHjzhME4JLwUiK72EhL8QampR0numMUuzZTs/aTmtRQbj94Nu7P8a7Z
 B+FKj7SVH4ehdpOxI5081C0I7VOLR7Q6c1CpD62um6CQ6KuS/lGriKWlSzfnTaSVzGlo2a5ua61
 1nhGZYWm2jFErT3FZNLGiCbjab2jz0A9rdRFCiNRcPUBvnkld7Gn0j/ThzIUuodLMdZgomFi3jr
 mIHjW82kcad4oRfDW9fyxuN4UEt+xs4jqyJ2YwhQzb42q6LJbXBA1Da38AaabkqQ==
X-Received: by 2002:a17:907:6d27:b0:c12:7dab:8b9b with SMTP id
 a640c23a62f3a-c12872dd6e5mr105853166b.5.1782828062012; 
 Tue, 30 Jun 2026 07:01:02 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1288f46dccsm137546766b.48.2026.06.30.07.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 07:01:01 -0700 (PDT)
Message-ID: <d0f7ce27-ad87-4910-be25-e867b5af4956@gmail.com>
Date: Tue, 30 Jun 2026 16:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] rockchip: doc: fix typo evb-rk3288-rk808_defconfig
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Use correct defconfig name for evb-rk3288-rk808.

Fixes: f339d6a9c3c2 ("rockchip: Switch remaining rk3288 boards to upstream devicetree")
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 doc/board/rockchip/rockchip.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index a31ee7100b9f..7adaa2c1489f 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -248,7 +248,7 @@ To build rk3288 boards:
 
 .. code-block:: bash
 
-        make evb-rk3288-mk808_defconfig
+        make evb-rk3288-rk808_defconfig
         make CROSS_COMPILE=arm-linux-gnueabihf-
 
 To build rk3308 boards:
-- 
2.39.5

