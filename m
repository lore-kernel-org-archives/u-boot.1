Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB030C52D73
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 05:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA8B882BE;
	Thu,  8 Aug 2024 07:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NUV5Dwy6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 618AA888F8; Thu,  8 Aug 2024 07:57:34 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D63F87E96
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 07:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5af51684d52so659035a12.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 22:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723096645; x=1723701445; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bPiAoXpK0JdsQyNpaN7hZCrHpa0VhsUUiY7QeEceZ+E=;
 b=NUV5Dwy68fC3uuMJLzOET8dNXHnFNwQcNf8cc+gKxJPwScyeh5eDMyJRAZqOpRE2ol
 E3LNtT1kRFJ97jlLA0qzbMiGehfqKCGm95RBxPts3rFXyMGXWSGfec815i1FQ6Hpj5kn
 PvbOBRxXr8NEf4fsrnLloR2oWD7GLtvHOzLEOnofQmFnXHPOgSRxsoA3kSjfpvGAcUqw
 V/V/mh4OFBMIQ4zi38grrItT6SAzjh2q8PSMIEY7MbxNr8mQi2nxkhuSGToloWRYnHMI
 5TmU8JLikwhN8kJCczf+B1gaJzT0vXCYW7Y8xsXm234nUAzLN/XzQr3aepMtOp48B2nM
 io8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723096645; x=1723701445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bPiAoXpK0JdsQyNpaN7hZCrHpa0VhsUUiY7QeEceZ+E=;
 b=YgEr54y1Ejt+Qu86Z4MZkDLoYyYNfODlBSR8GMhIdGdzuelssEBV/1OQXs8dHD6A7L
 5AJqBUMsy4U97/5ro8ePFepBKFFtPdYqonXN4G5oacSGaKOgz/+zTmQMYw2DwB13nzS3
 AmKR7S9beLLrYxUbm4EdyJwwIJiZIEQ7vlxfJFMIZ+lF7bvZVJjvLWMUHNigPCdS7Cqe
 Z01swMcSMjmI2tm23c+BRHZRswvSQNInAVDvUgMT/FacxOjuzMxbzkwKyvLZKcuIu8g8
 V0gf80Oey5a95e1riwc8W334ubs+hVCWNz2Nc9eC8RpeTGgvdKY2BWyQhx9Ev4COrd/b
 f6Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjZg5awe3PZNvZIYgx279zYTIk2pZaR+PckFa9AoPIbhWT3Dy1xZdKQB0vF2WYpPe1wLe/Xkh3zbf3ZBCI94iQB6bwfg==
X-Gm-Message-State: AOJu0YytGlr07E7UduciT68uj9j1TXOaf10ShU1hYxvgVBs5X777mtQL
 WwoZJfzhz9trZe6AkF6iFYOQuMedkkxyxxhlNmH0DFDNARoYpCu3xmaizQ==
X-Google-Smtp-Source: AGHT+IFOK5O6efGExDbiRRC8zbPf8APmGN3SBFAmHarWVs0d/h+onpCcwSHzigQsOOkJQdmzBFsYXg==
X-Received: by 2002:a17:906:d249:b0:a7a:8cb9:7490 with SMTP id
 a640c23a62f3a-a8090e4e094mr42616166b.47.1723096645018; 
 Wed, 07 Aug 2024 22:57:25 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec8cc7sm704287066b.215.2024.08.07.22.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 22:57:24 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>,
 Miquel Raynal <miquel.raynal@bootlin.com>, devicetree@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] MAINTAINERS: Update path for U-Boot environment variables YAML
Date: Thu,  8 Aug 2024 07:57:10 +0200
Message-Id: <20240808055710.19292-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

This file was moved to the layouts/ subdirectory.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
I missed this MAINTAINERS change in the commit 1b3f5b88c541
("dt-bindings: nvmem: convert U-Boot env to a layout").

Srini: I believe your policy is to rebase your tree and send PATCHes to
Greg during merge window. Could you fixup above patch with this change,
please?

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 760cb3966643..e299bcabe2e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23444,7 +23444,7 @@ F:	drivers/media/pci/tw686x/
 U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
-F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+F:	Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
 F:	drivers/nvmem/layouts/u-boot-env.c
 F:	drivers/nvmem/u-boot-env.c
 
-- 
2.35.3

