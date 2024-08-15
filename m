Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE173C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 19:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C154C88A8B;
	Thu, 15 Aug 2024 21:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bJH4dSG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E12D488AA4; Thu, 15 Aug 2024 21:58:06 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CBD488A82
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 21:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5d5aecbe0a9so791528eaf.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723751878; x=1724356678; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C5dbNj8ist01rO0V2SspYB0k2wx84Dec0gHNzliDTVU=;
 b=bJH4dSG1+57+XXIvghsMIVfj8eOowIXBFSShzwxLQKESli7ddqNbBSgDw9W4M7zpYr
 12pGpl7tF0pM6+YIghrFcEtXQ8qXp/eElpofMlXXcU16pAvwz4xgDijT2h9ihGm7c+B4
 777mj3uDDbnjmIE0aw4ksvLCEzb/Xpy4VFmHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723751878; x=1724356678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C5dbNj8ist01rO0V2SspYB0k2wx84Dec0gHNzliDTVU=;
 b=fFD9tTyjQoblLFvmi9JXlTlqMBaopj+wmE9L2YxqkgJxiWJMJjNyCIKlfT2tu5D5eu
 fx0vapieTYMi2b7Et2L5iBw2XlyEtXVXNnSVWXLL0TcLlcYck2INnWwLMpd64OYEcxw0
 Ed2s+bSk8GaEUE3lqVjiJYXLEFr4K0GjKys+fUt4RiS4c2bDX/L4Rh4E8INoLGtYvHt+
 BMcECIqpLW2eDgcW5eKLY1x7GKhXgRcr8IjvThkDdxH1Vtw7NchyOx9Ez7S645WKmzKn
 DmSOUwkOdOvhuq5HCStyYmeSwqksguo0dfDrsMQqiUYdgwD57usWDsIFemsI9p1MopZW
 ZZag==
X-Gm-Message-State: AOJu0YxW9QW4FeDsysrviAXhEPw7xTTVcBF5u71ISQzuF6nK31UemxzY
 xCCB2acK4cm4fv068Hn375f3RNjMV1HUizv1VfJlcfE8AaYkVDOfWiYErLlFfRljHa2/XhEfNyZ
 MJQ==
X-Google-Smtp-Source: AGHT+IF47tPhhmbXU3Q7sbOtg3iJTiJYUTyQ2Wv3bnjfuy7HCtFq8ZBjAZUifOIVSjSr7nks6WkCGw==
X-Received: by 2002:a05:6820:810:b0:5d8:e69:846f with SMTP id
 006d021491bc7-5da98046b89mr1040005eaf.8.1723751878086; 
 Thu, 15 Aug 2024 12:57:58 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ccd6f3e3f2sm697372173.100.2024.08.15.12.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 12:57:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 0/3] This series adds a few patches to make it easy to use
 the system dtc in
Date: Thu, 15 Aug 2024 13:57:43 -0600
Message-Id: <20240815195746.749042-1-sjg@chromium.org>
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

buildman. It updates CI to do this for world builds, to save time.

It also includes an old patch which is now needed again since:

   e13fcae3fce Revert "buildman: Always use the full path in...

Changes in v3:
- Drop patches previously applied
- Add dtc patches

Changes in v2:
- Fix 'envronment' typo

Simon Glass (3):
  buildman: Support building within a Python venv
  buildman: Allow skipping the dtc build
  RFC: CI: Skip building dtc for world builds

 .azure-pipelines.yml            |   2 +-
 .gitlab-ci.yml                  |   8 +--
 tools/buildman/bsettings.py     |   3 +
 tools/buildman/builder.py       |  27 +++++++-
 tools/buildman/builderthread.py |   4 +-
 tools/buildman/buildman.rst     |   3 +
 tools/buildman/cmdline.py       |   2 +
 tools/buildman/control.py       |   3 +-
 tools/buildman/test.py          | 115 ++++++++++++++++++++++++++++++++
 tools/buildman/toolchain.py     |  31 +++++++--
 10 files changed, 185 insertions(+), 13 deletions(-)

-- 
2.34.1

