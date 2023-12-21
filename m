Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F43C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 09:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E83E877C8;
	Thu, 21 Dec 2023 10:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b4n7gcy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 700A58784A; Thu, 21 Dec 2023 10:54:48 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B769877A1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 10:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-28beb1d946fso512107a91.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703152484; x=1703757284; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d4bvRIP5WUsdsl41BDM+Ut37kWRxyvyvfNFHKjaLh8A=;
 b=b4n7gcy7wc3uij2LkzrPH+cPVKKmamBEwZJywhdu8uD+w/hz4l4gIsHJyEPNxPNTAc
 lsBhVOuBTAZL0vuq4gsO9ORq1SRoVib13plCux3ocQBBpgqqCnABusiZoRTBeS4GEhW0
 X1t9JhOKbcgUEm2kAOHaI8koFJY20YVmU//g9e7E93wOqqEu8k2JB5Ka35qH84kBa5P6
 NGzXQxTd6TSb6OKTxmFBdSXX/JfcjXyva80Mw8LkDw1m8xI3I1hI+s2DyEci1cfkIiLB
 mInVrOkTRWcPG5HYpLmk1TOMsUFAIWbiCUTwI1s2M5INBcu//87YktJ9md2N7CEAjWsd
 r7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703152484; x=1703757284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d4bvRIP5WUsdsl41BDM+Ut37kWRxyvyvfNFHKjaLh8A=;
 b=wNOLD2cvaYefA8Yx3mP5vYA6WRzJWWZkrP6fHs9O0T+hH1htCLQURSdxID2OgXJA3K
 9YQsMVJYLWNy23QGbCw3sM3r585hKEJfbLUIdGhiZ3YbQ/MDhy7hglaLmWcn5YOnbTXL
 ho8/qK2uQCEmBvCPCHS7ocuOHfXDOJUsJAy+g65LCLRQfxd36V6BevdBWSnwDfkC+nd5
 AwzymJ46wOVkko4yUIUtzTyKR0n7qEDK825SUQtv8aXVBGViAyUxK9m33RFgZDzr83R7
 vTOykpsXJjxPDLMB0sL709Kk4ml5benzHwAYhXZngpUDWka9qBKLqMgaR+jH0OMh5VgK
 +3Kg==
X-Gm-Message-State: AOJu0YzkUVJutWaX9m84/ayFJgelbZYNWdZBsa/gYTfWwtQuIFTzfJWc
 yqeInhA3XfANLdqDakLHDVCmihaFPvILL/OZW9s=
X-Google-Smtp-Source: AGHT+IFcIkAJOmYib3jBxZwQK/deFEqdMPxB7QUCWKe9nbfdsAb5TY3D4lZ3HHxY/4tz156bOdnX/Q==
X-Received: by 2002:a17:90a:ba0a:b0:28b:ecdf:3267 with SMTP id
 s10-20020a17090aba0a00b0028becdf3267mr530146pjr.85.1703152483719; 
 Thu, 21 Dec 2023 01:54:43 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 l10-20020a17090ac58a00b0028bf196fdb7sm921986pjt.57.2023.12.21.01.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 01:54:43 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 0/2] fix FMP versioning for FWU multi bank update
Date: Thu, 21 Dec 2023 18:52:56 +0900
Message-Id: <20231221095258.592275-1-masahisa.kojima@linaro.org>
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

The current FMP versioning does not work when CONFIG_FWU_MULTI_BANK_UPDATE
is enabled. This series aims to support FMP versioning
for FWU multi bank update.

[Changelog]
v1 -> v2
- update fwu_get_image_index() function to return the dfu_alt_num
- store firmware version into the array of fmp_state structure

Masahisa Kojima (2):
  fwu: fix fwu_get_image_index interface
  efi_loader: support fmp versioning for multi bank update

 include/fwu.h                 | 13 +++---
 lib/efi_loader/efi_firmware.c | 80 +++++++++++++++++++++++++++--------
 lib/fwu_updates/fwu.c         | 32 ++++++--------
 3 files changed, 80 insertions(+), 45 deletions(-)

-- 
2.34.1

