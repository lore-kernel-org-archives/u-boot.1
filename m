Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2344CC2BA1A
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 20:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6239687DD3;
	Thu, 20 Jun 2024 22:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rD05TN6N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0183688385; Thu, 20 Jun 2024 22:15:38 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F07F08780E
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 22:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso133145366b.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718914535; x=1719519335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=li5mHXyyyfT2dIQ+nk2Zca4tMZrlGBLbgHWF17J1zIQ=;
 b=rD05TN6NdzOy0QjJl1fVG3fjLTJY0pMT1dx0lrxAUOxHsw2kzcZT8o0wzX6F0I7yQe
 Z+GPYvOqjKSBCqnmnvC7UDleM64MfyqwIrS3iYMrR4VpOQtc1rpXxlXx6QwG8s8P9dkK
 O891adAoMLxvFNEdnudzMxzKv4P0Ne9WYJaAIj5Dvvf89MtpQ2BVysFwR6B/kVyDfuJN
 qUXP8ukHKakS5jHvUZFT9tKNjZ8pZxWk9G6nMCbQpJXibNscqVD9ha52V5X0hHKmnhCW
 mc40EqXjo7fJdSuoLIUQxb/PbtkQ4+sXIdETi+aq7WAEQ+eHWZmb6CCKE/9Sf6vjb+wE
 oG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718914535; x=1719519335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=li5mHXyyyfT2dIQ+nk2Zca4tMZrlGBLbgHWF17J1zIQ=;
 b=w3/svZKW82fCmKyKsc4X7ZBl1ZmORAFkabcrkasU5yf4N2cjz4a1JSgYecAjEZ1Eit
 SghVMcyp3z0IIcL6kp9av4Rx//CeixA0qY+/DUwDjYCsONhSF9kUQFA/B2wuzx66u/TI
 91i0gT8zrH+cKrCzgIOtxTP7pzGeLAg6XGv7snDsrWRS2BXEyxq5zlPBK7y4xyqg6Uu4
 vUvr4QjBhGXkP1xGZ89LjgEWx8xrfbJaWm0vb43pyki4PklBXvBCWYwkWvi0y//OV/dg
 xvqrp07OFZo2beuXar4flg64F6gFNY2QXM2TDckRHoE7hSpjzt179+h9bL4CZzhkfjvB
 fcUw==
X-Gm-Message-State: AOJu0YzxKefCY+h247HCA5ZRVYnT7g2ofy8wCS+J2kiEcmuDrzgwZ+Oi
 wICVKalrVSvYMRpoBkb+QxVLOwoCLpIp3q2Q0rGTmcgWMA2sy0ULmFaIfcUyLEo=
X-Google-Smtp-Source: AGHT+IEb8p0RxbWypGy6uxoYGg2o2EzyDfmOESHujFmO8dSxRP2ULhg69wyMYldd29Cf94i3aOyJ6Q==
X-Received: by 2002:a17:907:a707:b0:a6f:b08b:86cb with SMTP id
 a640c23a62f3a-a6fb08b8da5mr291120966b.56.1718914535180; 
 Thu, 20 Jun 2024 13:15:35 -0700 (PDT)
Received: from hades.. (ppp046103020130.access.hol.gr. [46.103.20.130])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf560668sm5900866b.167.2024.06.20.13.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 13:15:34 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	jhumphreysti@gmail.com
Cc: u-boot@lists.denx.de,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] efi_loader: adjust config options for capsule updates
Date: Thu, 20 Jun 2024 23:15:31 +0300
Message-ID: <20240620201531.321110-1-ilias.apalodimas@linaro.org>
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

EFI_IGNORE_OSINDICATIONS is used to ignore OsIndications if setvariable
at runtime is not supported and allow the platform to perform capsule
updates on disk. With the recent changes boards can conditionally enable
setvariable at runtime using EFI_RT_VOLATILE_STORE.

Let's make that visible in our Kconfigs and enable EFI_IGNORE_OSINDICATIONS
when set variable at runtime is disabled.

Since EFI_RT_VOLATILE_STORE needs help from the OS to persist the
variables, allow users to ignore OsIndications even if setvariable at
runtime is enabled.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index ee71f417147a..6006e845cb1f 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -220,6 +220,7 @@ config EFI_CAPSULE_ON_DISK
 config EFI_IGNORE_OSINDICATIONS
 	bool "Ignore OsIndications for CapsuleUpdate on-disk"
 	depends on EFI_CAPSULE_ON_DISK
+	default y if !EFI_RT_VOLATILE_STORE
 	help
 	  There are boards where U-Boot does not support SetVariable at runtime.
 	  Select this option if you want to use the capsule-on-disk feature
--
2.43.0

