Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800EAC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 05:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D15B8792C;
	Thu, 11 Jan 2024 06:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FmWfGhmK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2390387869; Thu, 11 Jan 2024 06:37:41 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0281F871DA
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 06:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2053f5e97b2so3078959fac.3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 21:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704951457; x=1705556257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cv2+6W2sbiPBSZLS6DXdEt7FKMbh8KHE6XDwGMhoy8Q=;
 b=FmWfGhmKVnhPvdD57Dlmk+MKsIpiaFZuyV3SJvFCGCUJkQuNiixJo9h9X6Sf9Iwe8u
 8DXG8nLME0ScayNkIxypkKIdoFjyFA13s31mhiDTGKwvudOjA/beoS4zmXf0G82rvJw2
 Q2/T61kQse5ISiqI1cp4PkQ/bc7HznbUMUzPBbmBAYC3uwOGR1cAgTl0lkmFTsmfAbdW
 Oqak52yKd/O9dG7FuYeSyf3WP11OgN2YcCaj+0eCmmiXfQKQdcPeBMu9RqLOC3Bj9hUW
 CUn/2A3/sCoRBW8E1ym2InDfTW7WP+yvdM+PEYqchntduNfdm32xkqevpxOjmaT4tNvw
 mJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704951457; x=1705556257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cv2+6W2sbiPBSZLS6DXdEt7FKMbh8KHE6XDwGMhoy8Q=;
 b=kawdVbjlt+qvy3hTEQpgTQeRw75JysvUO78lKPI6aPobsHkn5Py+1fqJY0ncLByfWw
 sOvkcHSg6CLks3rt6hlV5TZyYxfPAUU9VzQiLs7OTqGEitViPlr4+FLuH/3mSsFAqylJ
 GabEQWqFHhuw2RGPzpePQw64z0Vy/bx1Fi+cjoj/RGlCB5dunTFnEpMDz4PiF021GHFq
 4QBvTO5UqTE34CPXeg1WFSLCPLZ18b8WjKg67Nn5SSGpN3PNZ+ssHgjH7iSVoUnVDdsp
 Pi1IBjCqBAnsYN9bBeYBDgiMd5ea0XDg/1MdHJnLHRx0SKPP/qskNOLF4Uv34Liqlf69
 //Vw==
X-Gm-Message-State: AOJu0Yz/nsrFKr7cLM41XY/j1sK84/yisTNqzM+lEHtW2ZntrjAilJMV
 +JgQQ+RHZTE9TTvW+bnLioTpVBP0OePVIkYqy2ft8lhvUXE=
X-Google-Smtp-Source: AGHT+IGlnl+10Euzy1e06ZyAX2NhTKhsujVzyzViNez/zCWFyRQEVP6Xodeii5svJkGAZM4/jNwY3g==
X-Received: by 2002:a05:6870:8196:b0:203:eee3:caca with SMTP id
 k22-20020a056870819600b00203eee3cacamr946513oae.80.1704951456902; 
 Wed, 10 Jan 2024 21:37:36 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 c185-20020a6335c2000000b005cee9115cb3sm312918pga.0.2024.01.10.21.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 21:37:36 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 0/2] fix FMP versioning for FWU multi bank update
Date: Thu, 11 Jan 2024 14:35:38 +0900
Message-Id: <20240111053540.899997-1-masahisa.kojima@linaro.org>
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
v2 -> v3
- add comment of ignoring GetVariable error when set FmpState variable

v1 -> v2
- update fwu_get_image_index() function to return the dfu_alt_num
- store firmware version into the array of fmp_state structure

Masahisa Kojima (2):
  fwu: fix fwu_get_image_index interface
  efi_loader: support fmp versioning for multi bank update

 include/fwu.h                 | 13 ++----
 lib/efi_loader/efi_firmware.c | 86 ++++++++++++++++++++++++++++-------
 lib/fwu_updates/fwu.c         | 32 +++++--------
 3 files changed, 86 insertions(+), 45 deletions(-)

-- 
2.34.1

