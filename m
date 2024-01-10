Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94326C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 18:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC9487710;
	Wed, 10 Jan 2024 19:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d1XoYRBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36C1C87A99; Wed, 10 Jan 2024 19:46:15 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E3387508
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:46:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67f9fac086bso31366296d6.3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704912371; x=1705517171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kEpHJtHCYbu5GAuz0bxVHOexP6UI3RzUT9w0G2geuoc=;
 b=d1XoYRBG737Mrk0UWctu9jqkdS9NKxU9E0+C52hO7xcJj2mbvZTyqP2ywPipxuvhJY
 DSkCmH0wzN3Eo1DfArUaDEaK2fcqo45iqa+Bza2jj9MMjzEfQaSY/YjrJ0xg/qb6Ku3C
 v9Yjlo9qGN4xSKg1NdHbSfmSo7Xh4+fe5Y4Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704912371; x=1705517171;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kEpHJtHCYbu5GAuz0bxVHOexP6UI3RzUT9w0G2geuoc=;
 b=WtJoUNugDQmEgtba03ss6wniMOhULgccKIWLOYrlx4YDj4BDyisFUBkB/rnG81ZMgR
 hDXjMXFBCb2/F7z9mTE0KN1MVgloluHpA2Y5plNI1UH50d3ebjwhxriRc8fAUVYriBHU
 8/hdvrEzWHydujbSWmu/0DQ9GUIDtRLcV0jBct7lR/YLdoQW3TdrSHUuEYb8SQm6Yn0n
 yycyLAb2lxU+SJqDkP0ybYgOvT6ANFEVn7KRKs0fB27Qmo3KGR/TSNZqHf53XYV1rZWC
 hGLYtG4tDqVORvB1V3sST/XzhhgGMcwxIjO86M2LTW7ouVIFvJ9einN9c5PyQ3YrnFYx
 aNQw==
X-Gm-Message-State: AOJu0YyGML0guk/X8FrZl7JKhZvyDcPa4l4lSfB9fkQch74BqeukCAhX
 iOwvBZchqClGlt4cBEBmU/kJyHMG3XjJoZ3npTMbnMFhwf0=
X-Google-Smtp-Source: AGHT+IHT8kyD2iX3TN5wCnkPV7y1/hjvAkdIaKeEv/DK4ax48dq3AfUDCHIoRJnywNYrfU9305TY5A==
X-Received: by 2002:a05:6214:4118:b0:681:e6:63cc with SMTP id
 kc24-20020a056214411800b0068100e663ccmr1615684qvb.73.1704912371535; 
 Wed, 10 Jan 2024 10:46:11 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 v12-20020a0cc60c000000b0067aab230ed9sm1887979qvi.21.2024.01.10.10.46.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 10:46:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/5] omap3: Make SPL_OMAP3_ID_NAND depend on NAND_OMAP_GPMC
Date: Wed, 10 Jan 2024 13:46:06 -0500
Message-Id: <20240110184610.3909763-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

This specific bit logic is used to determine what NAND chip is present
on a board in order to then know what revision of the board we have and
so what DDR chips are present. We can only do this if we have a NAND
chip, and so we will have NAND_OMAP_GPMC enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-omap2/omap3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap3/Kconfig b/arch/arm/mach-omap2/omap3/Kconfig
index bd524f8c9f95..850ee76746ee 100644
--- a/arch/arm/mach-omap2/omap3/Kconfig
+++ b/arch/arm/mach-omap2/omap3/Kconfig
@@ -144,6 +144,7 @@ endchoice
 
 config SPL_OMAP3_ID_NAND
 	bool "Support OMAP3-specific ID and MFR function"
+	depends on NAND_OMAP_GPMC
 	help
 	  Support for an OMAP3-specific set of functions to return the
 	  ID and MFR of the first attached NAND chip, if present.
-- 
2.34.1

