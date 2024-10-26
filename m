Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055CAD0C604
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 16:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01A5389079;
	Sat, 26 Oct 2024 18:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXfWLCJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46F088D94; Sat, 26 Oct 2024 17:52:46 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8BAC88F71
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 17:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c8ae7953b2so539208a12.2
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729957961; x=1730562761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjVoD9/CTtJU/ySaACYp8fPZmq0/kiL5U/FpyKtN5LY=;
 b=WXfWLCJHoJafQp2qoGikCjmN+SnB/MuB8PwXvmamojAScgU3kWh65ZbjIWDlTuN0PY
 /uvNCJKH83XrBulBNiq2pMqoKBf+ZyUm10GmK/h81eyFmaOneXslrb8vM51PraP+ftob
 Gw8gPuKsCeqs3H9BNCLvMzkTMckEmVvKQNZ6g7t1qMDl7MsPA8z/i+cDTbb3lyYydKLg
 cTvIcWfytMdueEuVrOmMdEHWHCyZ1RiZLHz75EZ1uXIZN6rcAQBerkHypRKM3LoB9J/N
 XTqKIPqeRFAOr2dAeSg8qlvTkHE/geQgexQB0ljoMHXv3bRLYw0UMiHZKoVdQWX13MOH
 Gv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729957961; x=1730562761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjVoD9/CTtJU/ySaACYp8fPZmq0/kiL5U/FpyKtN5LY=;
 b=Yovh4s1iuJg1wi/dcGlMw3L/vY8+17VTwCe9pw6M83ekGaMZrJ6Sve4+KFIqzjjupV
 K7EuDqEr2jfyBf1jnnZkGUtsMNN0fyfFRjx/SbhYtfJR2werMZLIgX56ZPzCr7oLY99t
 hLVTB9uq8W3zhU9RMj0o2D4uqAIApAcimCzRUK/Lp1SRgI7TQQ8BK1Mmcq+pbVSo4g0P
 6f+/iVci+rTMqfae5zvhjG7/R2kbqS3fYXoahJhLacf8inuuwYin/DVoRqzW70rb0ZG6
 hQVmResrd3gbEUXboTIm2zyQ8HBN84M+x/wTq0ZVcO1+OfxFu988MiC07IOUxK9KT4cK
 /Ahg==
X-Gm-Message-State: AOJu0YxtucT58QPJrLpVkA5Dft4pRzAyQ1GgHMD0zO8E2OdCBMGONWaF
 zvYk62pzt2S0i4ChMOcFWgfO9ZPqlyehSWXNFfxMxlfuw5Oet0Uh+5A7wA==
X-Google-Smtp-Source: AGHT+IEePPeLs8ff0lj+ZevPEmhkBpCPpQEPnd5LmDKU59qffemWKQjuboXcIoDTy0mZ/jgSe46kCw==
X-Received: by 2002:a17:907:6e8d:b0:a9a:2a56:b54 with SMTP id
 a640c23a62f3a-a9de5f279d1mr76428266b.5.1729957960771; 
 Sat, 26 Oct 2024 08:52:40 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb63197casm1620179a12.63.2024.10.26.08.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 08:52:39 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 07/11] misc: atsha204a: update kconfig description
Date: Sat, 26 Oct 2024 15:52:16 +0000
Message-Id: <20241026155220.26300-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241026155220.26300-1-l.rubusch@gmail.com>
References: <20241026155220.26300-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 26 Oct 2024 18:16:43 +0200
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

The atsha204a crypto chip is not only on the Turris Omnia board. Extend
the description of the atsha204a kconfig to cover also other boards. As
an example the Enclustra Mercury+ AA1 SoM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6009d55f40..90fa8c9eae 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -73,7 +73,7 @@ config ATSHA204A
 	help
 	   Enable support for I2C connected Atmel's ATSHA204A
 	   CryptoAuthentication module found for example on the Turris Omnia
-	   board.
+	   board and Enclustra SoC FPGA boards.
 
 config GATEWORKS_SC
 	bool "Gateworks System Controller Support"
-- 
2.25.1

