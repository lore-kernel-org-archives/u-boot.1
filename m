Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7474BC25B47
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 06:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64E7E87A61;
	Wed, 25 Oct 2023 08:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cye8bE+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 959BC871BB; Wed, 25 Oct 2023 08:52:31 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1091387A77
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 08:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b1ef786b7fso5086209b3a.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 23:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698216745; x=1698821545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X8mB3PGPNWPRXoUA0Ul8BgjnO/0mo6winCiNfeY5vL4=;
 b=cye8bE+GogwvLSriqyLSylEY+LYvrOgDQ7GWYXLmFRtNurI85R06ZAkombRn1MMZUB
 lpYMPRN3Wocei8fR4CFwUzWsVpi4tgtxGFhoCNP6wHBh6bOH/f6bwirYs0t0FURbIkqI
 7A+BOu23INuAJSDeDtmJgnxMmXNWSWr30l9tNBjb2vAExpbplkPTW4i+f7DhfDFDxU6H
 1b47LP4VHEvlkuZcbxtNLAij5zdavkXHIjgF7wys+fiY/BndeHPpzkuLwjJ4fIAaCYFJ
 qP2dGlNT0y06bAk9ixDvcfClMZMGX6gXKsovgeRnL3fS4Ip6Fg57S4sThX+kYbX/6iMx
 7hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698216745; x=1698821545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X8mB3PGPNWPRXoUA0Ul8BgjnO/0mo6winCiNfeY5vL4=;
 b=BUYyos/8hcVLjF8pK1eucs2P/MigD483yqwff5jCWaxFL0K0A35AAkbV4KbWHuN6EN
 41WhYXFLUzLL+Qz9C+7hMrRRkNBLMGmhPjPjbhJPnW41ZCEMwZnUgNXQL62QVJl/0iwf
 lSEveexPkNUwEa6hRNPkFLOEBCuNXonShLGhlghGEU8pvkROEwzTyRWrByy9zeg2Tud0
 F23wj7B9i9AbxTI1/xrHUKPH64S5rYCfohQX5ff8MxQ5ynJpy3IaU0WY0HqftWuESgyM
 NQCTNoyms8YAGs8uCx8O5sYqQaRxTD8q3W0OWHgct+t2KfgQhvSbykEr2hxrabeHl/cg
 ZbaQ==
X-Gm-Message-State: AOJu0Ywrm1tUeZreTxMhrllq0SnJYrzUPq94I/iw1x+B7k5N5nraaTE+
 pKVtIWRK2Ky9pZWOw9QEHGhYIcqGq3fxhwWy2vc=
X-Google-Smtp-Source: AGHT+IFzZQUmKERxbWDtLsZ1vuFlzNJVZUj7ChfYfIxSEHvXTHrzNeDBi8cInYA8ata3KwO6XwXPeA==
X-Received: by 2002:a05:6a21:3d8a:b0:138:2fb8:6a14 with SMTP id
 bj10-20020a056a213d8a00b001382fb86a14mr4504867pzc.3.1698216745613; 
 Tue, 24 Oct 2023 23:52:25 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 q12-20020aa7842c000000b006930db1e6cfsm8686560pfn.62.2023.10.24.23.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 23:52:24 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: jaswinder.singh@linaro.org, ryosuke.saito@linaro.org,
 sugimoto.yoshio@socionext.com, ilias.apalodimas@linaro.org,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 3/3] board: developerbox: update flash rawwrite binary size
Date: Wed, 25 Oct 2023 15:51:03 +0900
Message-Id: <20231025065103.3101666-4-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
References: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
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

Current documentation limits the firmware size to 1.5MB.
When the fTPM and StandaloneMM-based RPMB secure storage is
enabled, firmware size is bigger than that size.
Let's specify the A/B update bank size(4MB) for flash
rawwrite parameter.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 doc/board/socionext/developerbox.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/board/socionext/developerbox.rst b/doc/board/socionext/developerbox.rst
index 596cf9f908..46712c379b 100644
--- a/doc/board/socionext/developerbox.rst
+++ b/doc/board/socionext/developerbox.rst
@@ -212,8 +212,8 @@ can be installed via NOR flash writer.
 Once the flasher tool is running we are ready to flash the images.::
 Write the FIP image to the Bank-0 & 1 at 6MB and 10MB offset.::
 
-  flash rawwrite 600000 180000
-  flash rawwrite a00000 180000
+  flash rawwrite 600000 400000
+  flash rawwrite a00000 400000
   >> Send SPI_NOR_NEWFIP.fd via XMODEM (Control-A S in minicom) <<
 
   flash rawwrite 500000 1000
-- 
2.34.1

