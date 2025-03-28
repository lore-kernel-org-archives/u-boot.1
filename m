Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A648C36013
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C09581273;
	Fri, 28 Mar 2025 14:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q1yhjGcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42F6E81DCC; Fri, 28 Mar 2025 14:02:23 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08CB4810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-85e1b1f08a5so54508739f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743166939; x=1743771739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LxGaykgy9TMc/GagbFr0VvRPNyZZwTej+GnxQFeSSvw=;
 b=Q1yhjGcbvd1ry9dOZEYaUIgK/2s19zP1yWMjgUiiDLwbYMmRVE1na7YL4eZJzBFSyA
 8rIfhtcvnBPciH3jbC0T0AMtMdXTGA/i/rCzz3tOWX5c9pXsMEVQIzmIm67syv6LfMvV
 pm9q3mAJVJtaBQwc99U+ovvei2jHKx1qwq8Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743166939; x=1743771739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LxGaykgy9TMc/GagbFr0VvRPNyZZwTej+GnxQFeSSvw=;
 b=vgQki/Fv5s2COzIZ6cdzQ1chEyaUemv1z+J7gRhjvp1pngyzbvIxuB8JU1EqcKOKLp
 AW+qN5+zRgNmsil2H0WUwQbGEuELlKYH3JSRjK+oM0giX7bPyjBz25+7Izom10QCEgpm
 W8/uWkKOniX2vV7/rxMt2yxnYb0Ui235MIF9/rg5hK786a9aFVm5/kB6UOEEEThyn3wF
 ZRW5P7loXDX8lNTkxO9sxAyGpXomuNqqEiELyWZQLn0LYpghSPPXpIO7PIXxm4yJIMN0
 6UqMY9ateZnx8vu5bg4WwEji4hoR4vjFywZ/2uXKZ3idzNzED7FzzVNGsw8nc9mF2s5n
 cH+g==
X-Gm-Message-State: AOJu0Yz0vl6WXYLikrcl2P63tY5+2ImZYmrmbAASPA5F+XjV1YRGK4hw
 qe/p6uRu1LKpZ90wrkhxJp2OGaOsTk4QvWbv75LNDM5WB/PDvm0x+19wdQv/C9pXpT3RYCCFg44
 =
X-Gm-Gg: ASbGncuzkiH50/XD4ln+fJrQ3hI4b1OmclepoOBnqNfHGT/CArJe1DeWc3cdou8liB3
 WGcYSokYw25qcwN1yM+PyvxRGrJh0zTrdmt9rvznwqwn0Sl5qdIAOMIYSiLNSv6r5+P0WHv08oF
 Wy38qcLVfw4N6Q8MyB7cA9q4AvcnIS/a8JanzspA7twDA4GIZ01KS54bgc+Lcb0ni9jD4nQjJw7
 4P62uNfNG7IkHPasnq867HmfbpcMl2GF3lSwstSiCzp9RYU63+OMuRynHoqqVAO8fYrEiVMD6XX
 JuVxgNjQi96We3u7RiOdctUb+yDGwbfUSX2TVAKVPEq3vhNCJZmnC6afW1+HuoxgjHaHoNQrMAp
 ARAucDSNd1qzThirV
X-Google-Smtp-Source: AGHT+IFFhfcdkXsmNzKPr/PTRySauXB9Fcr2lJ29/HCErZX0/a2kdYyR5HUtX6gHUC75QlAiKX4hWA==
X-Received: by 2002:a05:6602:3a0b:b0:85d:b054:6eb9 with SMTP id
 ca18e2360f4ac-85e8216740emr1051865939f.14.1743166939047; 
 Fri, 28 Mar 2025 06:02:19 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85e9027bb90sm35903439f.45.2025.03.28.06.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:02:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] binman: Fix a typo in elf.py
Date: Fri, 28 Mar 2025 07:02:08 -0600
Message-ID: <20250328130214.2607633-1-sjg@chromium.org>
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

Fix an 'EFL' typo. It should be 'ELF'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/elf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/elf.py b/tools/binman/elf.py
index c75f4478813..6ac960e0419 100644
--- a/tools/binman/elf.py
+++ b/tools/binman/elf.py
@@ -28,7 +28,7 @@ except:  # pragma: no cover
 # BSYM in little endian, keep in sync with include/binman_sym.h
 BINMAN_SYM_MAGIC_VALUE = 0x4d595342
 
-# Information about an EFL symbol:
+# Information about an ELF symbol:
 # section (str): Name of the section containing this symbol
 # address (int): Address of the symbol (its value)
 # size (int): Size of the symbol in bytes
-- 
2.43.0

base-commit: 794124b3258831768a6b8ef069253374b877d59a
branch: pat
