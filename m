Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FD6CF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFFCE83FF5;
	Wed, 19 Nov 2025 15:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jyQwnkk1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 742B683FEC; Wed, 19 Nov 2025 15:55:41 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C9618004F
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-450ac3ed719so2119863b6e.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564138; x=1764168938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BTv1dOqE4FH2zUF+yx7TBXQs8c7xNl0OHNhUnGB5LU0=;
 b=jyQwnkk1hGmNCGFZSLHaRnlan6vCIMCZvQCYMZexGUA8WWKGRnC8AfbGPmyv6dMAUg
 HUnkXFsi85m9JuzTWo52bJdgChWacODv3vN2BM0kJ172oEDLZfq7BJYc40ZsY/zZ8me5
 AK7lvgG3NSRgeg3hlCD89eJ52D4Bw/H7npLqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564138; x=1764168938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTv1dOqE4FH2zUF+yx7TBXQs8c7xNl0OHNhUnGB5LU0=;
 b=lVvdhDUh+sw3jqG/WQEYg9xJKXrHIq+VbzAs29DyMMhhcn2g3lCXLtlaOGtU59PAay
 Gfv0OnFS4wbBwzY36KFrUCE+3l1iQ7oBsxSUouM8zTkRxdnJwy82cOTWvcRuIn4qvNAR
 Z/rnAqBf1NPVEQ8p1wfUO9qxIUI0JGobZ7iYNq82nIl3R+5OpCJVeHavSuYbm242S03N
 6xDzqFCfXdRn36uYCYQiyKa1ONhiDPiak4CcMSeipB1pPYaQ50PJHoSgpnd7x33ZQJNB
 ukc2rMlr7V/gJCfaU2MXNgurhcS++MbS/qXjs/Ui9Iv/6/Yo+/XR/EBaP1mWu7wxwAbn
 1MhA==
X-Gm-Message-State: AOJu0YxJWLbK13ZGl3b+RJHXsEN612SSzVREID7o4u6lVrs7O0WxwRHY
 n5TyX9atIJMVxqfdx5uLabsBSeWXpHHLNNklv9CtnqshHg/L6f4+mBP7y39oEG/FaoMcAFdh3Nc
 EN/oouZI2Aw==
X-Gm-Gg: ASbGnctZcI2ofTe3DKczJlQOJ+InqW8bcMq9HgMfSYhYbZrBHW2TDvxkFHTlSeiZlL7
 IWZoMd/reyBeeO2m87II2qPzD6ZXKcckwB6kLXO29p4HKQCeTo21mrDHrfPgooS/KDz++JP8sHx
 TxAGAgwRrOP9U5qr6ikbEl0Lv1wL/RLOGKIaqM3gfrZSlcplRJ8HyUCPoftlLbYi8FkIgimEaKG
 SXUT6egw7hBoGlctRGlg+I5EgSbyxQEHrFIfocQEMhvn3h8LlY1Ja5lDO8VnyVz1xfMojayqiic
 WQ/eRRhifUdg4+zhyWIboep8a5jokzB2vRG13+AJkAPFqGY1F50Iyee6Eil8yOngaSmlrX/86U8
 SN4/hBWwR1lhaSQ+CfXxpAZf2DAQUclJuT1buPcJMuqh+c3Rj+9Vfyp7v5yN1t2H6pPc9j5Giom
 2S8+BU2cpmV0vA6CSwAjDWiwd2H6u3w6Xt/B4/z1cT9/e5t0Kg/oNS2PCnz+GEriU=
X-Google-Smtp-Source: AGHT+IHbuOWGFtalc1dpfeszMNswcWe5rzv71YkOGuHGkiglSNL4vghR7hPJwPgS0yZB7DosBOUcdA==
X-Received: by 2002:a05:6808:3a16:b0:450:d1ba:151b with SMTP id
 5614622812f47-450d1ba30c6mr3913320b6e.29.1763564138136; 
 Wed, 19 Nov 2025 06:55:38 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6575441939bsm2918170eaf.16.2025.11.19.06.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>
Subject: [PATCH] sifive-unleashed: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:36 -0600
Message-ID: <20251119145536.843408-1-trini@konsulko.com>
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

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atishp@atishpatra.org>

 include/configs/sifive-unleashed.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/sifive-unleashed.h b/include/configs/sifive-unleashed.h
index cd8d0438ba67..862c24570245 100644
--- a/include/configs/sifive-unleashed.h
+++ b/include/configs/sifive-unleashed.h
@@ -37,7 +37,6 @@
 	"name=system,size=-,bootable,type=${type_guid_gpt_system};"
 
 #define CFG_EXTRA_ENV_SETTINGS \
-	"fdt_high=0xffffffffffffffff\0" \
 	"initrd_high=0xffffffffffffffff\0" \
 	"kernel_addr_r=0x84000000\0" \
 	"kernel_comp_addr_r=0x88000000\0" \
-- 
2.43.0

