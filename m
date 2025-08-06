Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52339C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 11:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2EE5833F9;
	Wed,  6 Aug 2025 13:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IX8JVrOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF048340C; Wed,  6 Aug 2025 13:30:11 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD6E83303
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 13:30:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-459eb4ae596so2217955e9.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 04:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754479803; x=1755084603; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X0P1p/VrCTvqQ8FH9u5Cl5fCqlcnnTXT05TmRP5U4A0=;
 b=IX8JVrOWlpHdPD11XJumHF+RItIa2GtgKimml18MMPeS/9HqHfz/eIiNatVnuUkdxS
 brgdZmaeEWB9iKE5F1DRV5giVBsKcu4D85H3BKvWTa6sZjPDbhiIL0IHjHiSkdVbOdD+
 Z8KFzlbYdiArIOIyySBr6NJ8eoJGA3ArtwYEJbE2m58g+qjXL1MdU72P+u+f8h2t8Xn3
 hvKnUIt3qlC5AhOwi9MsUSNnHuC1r57UZWI7qncCzLS/TLrDPc9NdMxIXEMKf8ByLN+X
 hL6jbjke7AoV8OQOKfHPkcN/WaA8EHgQXJ9z9puYbo7Puspux06Yfmj8IXEff8IerI5C
 81cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754479803; x=1755084603;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X0P1p/VrCTvqQ8FH9u5Cl5fCqlcnnTXT05TmRP5U4A0=;
 b=mwzbK2NSsMsNr64g1cLHZFTzogUeOby3axaNKC35pzPfHXxGeR94WvaHSwFQ0faUI4
 vBhxI2ZeXV6onhGsIFtBbjDMg4eZm7SB9jZx2QEp2c1NPsN+U+McmNVMnE+zuVpIRUvO
 PsWRMkpH29w9XXBGa8xpK/8x92M3dMtGhQJ52db1ZoUsvOL8dpDjI4idOIAbO8ZtU78Y
 eWjERNi8BVtLaVeE0qrOd2XEJ/uE6LeXMu++zCyQ/cpDoRh7BnnTadZP4NeQcF8PvI61
 jlJhafM/+50hzqWnbZ7+Uyw82X+6nZ6HU6SNKIA81D9/tsinX1yxukOB4OEnJy+ptSrS
 4QOQ==
X-Gm-Message-State: AOJu0Yyov1IJudCk4/DjfZzuVkh1ubHWCyAdnGIhunzecjFO42r1x///
 wwm4lIGVP5RXoFU3H3MtV34znsD//AVqU2VYkK4zCtb6pLT9hWpljF+Uwkjc0UQwTZJfHpjTSc9
 zMptx
X-Gm-Gg: ASbGncsaxdIKO1oY9oumuKxFl4nxqKeYTcXEImZQ5rPfvUP82J7zhioDbscLoFb6z/z
 HlJspojRfD1+6RvSonRzwb56g00iinopR3m5tP67+N7JE64ONi8TNARTejh5B9a+BPLuo/VDBai
 AcJ6VbseVTxzyGLw0neN1EcMnCw7wjV3d45pWEj6fVgHWDzefarN2VCgdV34tIn0G+YEp1T3Ao9
 ivhb4wN0xdyu5GNgpNbG+FhlHl63bstfXASLK6t3121c7EOGBzc9TzDrb4FsooCQwPW6GhHmNmq
 fIc0+J972j/4H8EgBuoIIOjmwf8HlndKn/4eouDWoyW3e+VFi0w97lojy2IIWzL6yS7nNS6yG91
 oKPezmdqDIh+NuuHcRGW5qWEFuYkd7kmK25/DE6h/+Xr6S2Uk9t4=
X-Google-Smtp-Source: AGHT+IHfDrp1hMEMLnE0SJjmnfLtxvY+/5o8gHhgCOZ/SwcprSD/o017zF8Jm2Q0iIThW42UdwcJoA==
X-Received: by 2002:a05:600c:b90:b0:459:ddad:a3bd with SMTP id
 5b1f17b1804b1-459e742a118mr26950305e9.15.1754479802941; 
 Wed, 06 Aug 2025 04:30:02 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c469582sm22325568f8f.52.2025.08.06.04.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 04:30:02 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 06 Aug 2025 12:30:00 +0100
Subject: [PATCH] pci: apple: i needs to be initialised and used
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-pcie_apple-v1-1-1a99f83d3cc5@linaro.org>
X-B4-Tracking: v=1; b=H4sIALg8k2gC/x2NUQrCMBAFr1L220Damli8iohs46td0Bh2RQqld
 zf1cxiGWcmgAqNzs5LiKybvXKE9NJRmzg84uVemznfBDz66kgQ3LuUJd2yH2CPEKZyYajCywY3
 KOc178mL7QHdRFJMs/8vlum0/9PkxnnUAAAA=
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In apple_pcie_probe the variable 'i' is declared and then its value
printed on an error but 'i' is not initialised nor is it made use of.
Add an initial value for 'i' and have it incremented in the for loop.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/pci/pcie_apple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie_apple.c b/drivers/pci/pcie_apple.c
index 6a8e715d4b6..216b6512af1 100644
--- a/drivers/pci/pcie_apple.c
+++ b/drivers/pci/pcie_apple.c
@@ -335,7 +335,7 @@ static int apple_pcie_probe(struct udevice *dev)
 	struct apple_pcie_priv *pcie = dev_get_priv(dev);
 	fdt_addr_t addr;
 	ofnode of_port;
-	int i, ret;
+	int i = 0, ret;
 
 	pcie->hw = (struct reg_info *)dev_get_driver_data(dev);
 
@@ -353,7 +353,7 @@ static int apple_pcie_probe(struct udevice *dev)
 	INIT_LIST_HEAD(&pcie->ports);
 
 	for (of_port = ofnode_first_subnode(dev_ofnode(dev));
-	     ofnode_valid(of_port);
+	     ofnode_valid(of_port), i++;
 	     of_port = ofnode_next_subnode(of_port)) {
 		if (!ofnode_is_enabled(of_port))
 			continue;

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250806-pcie_apple-41863e56f57a

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

