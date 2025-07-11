Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A41C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 546EC826AA;
	Fri, 11 Jul 2025 17:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WA//HLAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F35DF830C8; Fri, 11 Jul 2025 17:20:16 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63F582063
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c27166ab3so1304976a34.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752247214; x=1752852014; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gxucfbkl/3WQNHXRWTpCGehYVd0LHUUUXQGd6OrVmzU=;
 b=WA//HLADBkO5C6mVoTUJ66tp1fgyHt+v38E6kh+YBoh9ItxbNauHIZYrwjmkSYkPKh
 B6OWWNqfc1HoDqESU5+RW7U79enX00jxCNABb6mAAo5qpwBFdD0Pwj5+/O9fGW70N09A
 h46WTE89VjZxMAwhNOb4RGWRLNp4j56pNLp2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752247214; x=1752852014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gxucfbkl/3WQNHXRWTpCGehYVd0LHUUUXQGd6OrVmzU=;
 b=kkM73VpToPaVJjzTZrI86eR/VlD4N2YPwz1DkpOtnpvMUF1TAKgvnC4ShvADkCHlt4
 f241aC+d8Tx9U8DTEQMP1RoTasBjrpaB06FIWkKLR2bqRHcLcK1wMdHzi4dtH96XPMl9
 R0PfTg5+whwLt0tTuaI6K8xLfkqsClEOot5EOrzDW4c0rpyayeL81qiyd/sBBUkQd/Py
 Mw55K6kvX4TJDucoKzZKKfX4Ns+8TCpxBVn0+HGTQXydxlu5sbSp/G8HjW5gYGASk7uH
 8f0+T8sqT8JtSt1UITemexJOl7e7Tg4ttjXjhQZ84c+ZmLMtA5H+2q2xv8C5v/xQtFYf
 aaOA==
X-Gm-Message-State: AOJu0YwM1rnrVp7PUeBGUzke/pCYHkCV02jTpySq8v6vjj7VF1f+hGT4
 FN/fO38ZccGliuHjQfa2DxxdXny/gXBhxeLHzS3xysXJ0Vv8bUtx2kX+24+XbFV/0ouY1t5lorw
 j9ZKvrmE=
X-Gm-Gg: ASbGnctyWVZQ4hgvRy6rBXJltPYT1YLurC0MuEtXO1iL3f5bQiaHXV7oVJ3UgM2oNTE
 G+xS09nFPbb8Nt3wUr5eb46ovAlIr99qV87gsfHmfGMlPADdvC5jZhaohvKcgHyDp2N11LLCXnV
 InlHmDsRdbsF3MICPKL90bbQeSPNeJ++fibG3X3NfR9j21Am+S9/jh9s3Msm38zbTVYDqiksZhc
 QRXHnyuj4Z5p4cB1fXj7kO4kjCZuqYv3KUvtKzOt9yvLKmwg9EnH3ORys0n7/fTVJJHap4BfqnL
 iHV4WjgXk8pl5Sp1DT25utXn42dMaAnuji39Quhl/7Nj3DZTNvl5w7obcpk6/gTJBn+2j5c8pL/
 EE/3+l4gzcJ4EIX3fRdN3kUbeX5ZOB8W0oGPOkbVHYxicun2TvYWnxf03z8s=
X-Google-Smtp-Source: AGHT+IGDEHRYf/Tkbx2OXhKX8Z1rToVdfk0aUcx+6vdSUCetxLgSyjugyjX8MZ+DfiQRKZleokDmCA==
X-Received: by 2002:a05:6830:43a7:b0:73c:d48f:6c6a with SMTP id
 46e09a7af769-73cf9ea0795mr3465389a34.8.1752247213709; 
 Fri, 11 Jul 2025 08:20:13 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf127258dsm590760a34.34.2025.07.11.08.20.13
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:20:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] input: Tighten dependency requirements for TEGRA_KEYBOARD
Date: Fri, 11 Jul 2025 09:20:12 -0600
Message-ID: <20250711152012.2225465-1-trini@konsulko.com>
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

This driver requires headers which only exist on Tegra. Express that
requirement in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/input/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index c09f0ae795ed..47ce0ea690fd 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -98,6 +98,7 @@ config I8042_KEYB
 
 config TEGRA_KEYBOARD
 	bool "NVIDIA Tegra internal matrix keyboard controller support"
+	depends on ARCH_TEGRA
 	help
 	  A matrix keyboard connected directly to the internal keyboard
 	  controller on Tegra SoCs.
-- 
2.43.0

