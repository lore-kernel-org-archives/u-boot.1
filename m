Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164F6CF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8501488ED5;
	Mon, 14 Oct 2024 04:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MDvrO/2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D7B788F03; Sun, 13 Oct 2024 16:32:55 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E385F88F3D
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 16:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c91bf96bdaso675815a12.3
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728829969; x=1729434769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQ7+6wUVml1F1nrj+/F5LF75lop65H9uIc/wS2NCTtQ=;
 b=MDvrO/2p/o9sg3BAFusYRSHZrWx5uvZSDm4IjODWGM7hL7awuhiKuYYy9z19jb2iMt
 tQMs9eyBu2TIN5TGCCKfb88GrZ2fICmXU2YN/oDgxJPYDl87IYBmryQfPrFItWADXDa1
 6A6oWKuUH8VHZ9IvI6m+p8M5zg08Hb9GfzeOsdfxmFuCOfZeFxU1Z3VkOt0zhNEVAR0T
 pn+oITGpinKhAp3T+RhRR8Bd+G/NuMou1XnHg5XqCOTGMhNqHdWQSyw7bOJivxfEvpL6
 bB/cBGIE16eAEqTGVizybjyBYPMl2nId7Gt+MC8RQoLEFpk3XSt3xiQWeIUBO3ucXdnZ
 x6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728829969; x=1729434769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQ7+6wUVml1F1nrj+/F5LF75lop65H9uIc/wS2NCTtQ=;
 b=vQnLduE+hKA9bKXZR//K4xT0A5E0Z7p2rSasYLABu7xcIQHDE+cymtixNX0/Pai/Yr
 vwk+U21L+qrUnkiKQ3qoerMHlTzsmFkK2qHc9MidD1NL5awyctJy6UqZ77zX/eFIZjKz
 lgbJHh/l3DFtac23T+R+aIwMFBsAEyPSRsnPX/wCIxNYfkPqNgCWZeeRC3iur7h+l0so
 a2/bakCpau3Q4zW8OF7wDpvCBs4N4l0gSZXerNLjZP4LDj2SSUlguI7mpEQe4SLtfWb1
 AxGS8e//yqTXqFRjypUvS95+ZYZx4XnqZcEoGvpacjnjEdOVp7IaO3KLtApApmQMB8je
 0NQw==
X-Gm-Message-State: AOJu0YzrZDsae4UXRZly6aZOdx/btDfKGMdgJsMtO7swxIs+zGctUqGa
 CD3r0vpWeeNMdpJcqe1Jf2Fg7PNJc5cvucF1/PSIbVbxhzHb3MiRycej0g==
X-Google-Smtp-Source: AGHT+IFRqnE764Td1acwUt/2aPjBK/JL4TG4qKWhfHZZo+vPz4wHZViqmi+alA5jxMrRmol6fN+ujA==
X-Received: by 2002:a17:906:c105:b0:a86:a4cf:a197 with SMTP id
 a640c23a62f3a-a99b9314885mr286630766b.5.1728829969216; 
 Sun, 13 Oct 2024 07:32:49 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99efcf15d1sm189886266b.102.2024.10.13.07.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 07:32:48 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com,
 Lothar Rubusch <lothar.rubusch@enclustra.com>
Subject: [PATCH 10/10] ARM: socfpga: update function call to modern API
Date: Sun, 13 Oct 2024 14:32:32 +0000
Message-Id: <20241013143232.2090645-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241013143232.2090645-1-l.rubusch@gmail.com>
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Oct 2024 04:44:22 +0200
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

From: Lothar Rubusch <lothar.rubusch@enclustra.com>

Remove arguments in the function call. The call's argument list differs
from its definition, which breaks compilation. The removed arguments are
obtained from device-tree declaration.

Signed-off-by: Lothar Rubusch <lothar.rubusch@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/mach-socfpga/misc_arria10.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index c442af0288..1e20f77773 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -214,8 +214,6 @@ int qspi_flash_software_reset(void)
 	/* Get the flash info */
 	ret = spi_flash_probe_bus_cs(CONFIG_SF_DEFAULT_BUS,
 				     CONFIG_SF_DEFAULT_CS,
-				     CONFIG_SF_DEFAULT_SPEED,
-				     CONFIG_SF_DEFAULT_MODE,
 				     &flash);
 
 	if (ret) {
-- 
2.25.1

