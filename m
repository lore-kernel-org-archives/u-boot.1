Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F25CF34C0
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FAE883F50;
	Wed, 19 Nov 2025 15:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uv3n1VQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88A7183F30; Wed, 19 Nov 2025 15:50:33 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AD4683968
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so5293600a34.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763563830; x=1764168630; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JwD9zFqAR8oaWxQ0Rtd88or5u7+x1FbLArxwalSSDeg=;
 b=uv3n1VQzY0poRbwZRjhPKKuZB7XDvNAYjEJnIPwV4/1EtjNGSQv69dwgZ6O2fJ0zOe
 kKnaNa4YCB09MjUHa04ho5WvwMsb/tvl6clBMBsKEH4jZxlJ8dGRWpjuqAVHw3CDmkWT
 B1tfQIpy83DTK0Z3RqNN2fPmbKYPhQWcSsR5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763563830; x=1764168630;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwD9zFqAR8oaWxQ0Rtd88or5u7+x1FbLArxwalSSDeg=;
 b=vVLW4eb+UdEh9ja8MXbKdz7XPRLblhmr8DArSw6C5qiUG8ivWXhzcGuXXVMR9Abidc
 9B1CU+qu9pPsXoy/phcQH0XqY+a0sd8p04CYhaVC2C3naHvDq1vBR9F5FhgvMXuivacJ
 IMqTo4nQHzM3SNslbjx+9CAkERG/uaeoDE+FnLvy/1V93ROiNZKWJMnTlYBnT97epNQV
 tbPj07JsXPqklaVYha0JOo5vly4da1O492lDmLqd4lvyu6UFcnITbMWcOWwCV/k1ArNg
 ZtG9upWsYjOhBamXeSMYPtkssnDgjL7ex8QiZy9DXU2WvgV7e73cP0extmtyygXuYGWR
 eIpA==
X-Gm-Message-State: AOJu0YyFicGDNpz7Lqtb9F6dOjegn+BvsU/7K2Ms80HKntKVHk8WVtvB
 iuPIhR+qu7wXUWHauRnmpri4IGKXAxKFE0/zN8R7YTs0eeJ5TDyGx0kLiIHA9oyexK0KGzcuLIp
 vqcwKcLyTag==
X-Gm-Gg: ASbGncun4IAF9Oi+zbldLIf4PLTRZD9YBHJ1I0uK4LM4sQLi1ivJf2LY1d8qPifNnmI
 GH1/4T0RrYcTlCKJvIWOLUeaBGpw38lYgwoDseqp1qBJ23JVkKxrn0hqkKwumOAzYyHdq9TpS3k
 xe6vPX5+OdOZAF0aFIrGrul7WQs2rmmNj5ZOcgbQVnpsg3L/SGTtvDiwB9ijtRptCtT//5AFvxN
 inkOA3L5dxVxob5WPxBClhqOFxDyfFxUiSP+UanvaKFBH5/Tr8j4MxLU+PQAQ+Juhfgf2KxUtvN
 5PMS6dbN2xur9bPBIEMYdaFwE5xxxHYTLfeCWZ3HN+iwKyLMbAR84whz94zBEoDLo6G8Z35JnnV
 Blpw0/+1rLbzi0dNTKhyoFOha4jA/DDukYJOQFj4SlTQxBMO/0iZmOUyimUYy4n9niMc7Qwe7bn
 j9HeZFKuBRA/9XjPFP7/vfoymNG25hl1triTYYdbnFuAxHHN5f0dGP
X-Google-Smtp-Source: AGHT+IEwioI/+zn1H1h0sokhu7HRNyzTr6DWQKrS7ZLN96d2gE9OoXe6TaGEH7YN1pNwYpaIZ68QcA==
X-Received: by 2002:a9d:6146:0:b0:7c3:e07f:568f with SMTP id
 46e09a7af769-7c7443d2faamr11781927a34.8.1763563830196; 
 Wed, 19 Nov 2025 06:50:30 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a3bd060sm7749898a34.24.2025.11.19.06.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:50:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] imx8qm_mek: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:50:28 -0600
Message-ID: <20251119145028.842128-1-trini@konsulko.com>
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

Cc: Peng Fan <peng.fan@nxp.com>
---
 include/configs/imx8qm_mek.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/imx8qm_mek.h b/include/configs/imx8qm_mek.h
index 24e7aa96ec13..5776c8ede750 100644
--- a/include/configs/imx8qm_mek.h
+++ b/include/configs/imx8qm_mek.h
@@ -29,7 +29,6 @@
 	"panel=NULL\0" \
 	"console=ttyLP0,${baudrate} earlycon=lpuart32,0x5a060000,${baudrate}\0" \
 	"fdt_addr=0x83000000\0"			\
-	"fdt_high=0xffffffffffffffff\0"		\
 	"boot_fdt=try\0" \
 	"fdt_file=undefined\0" \
 	"initrd_addr=0x83800000\0"		\
-- 
2.43.0

