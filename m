Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D50D1BDC0
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 18:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6202288DEE;
	Mon,  4 Nov 2024 19:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MnbNDDRh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1BCA88D4A; Mon,  4 Nov 2024 19:36:51 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6393988CBA
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 19:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2887326be3dso1982571fac.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 10:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730745407; x=1731350207; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m4SWiyeBFOySyOiWZIF67DqmDPQdUC8NGvzH+nRI+Zc=;
 b=MnbNDDRhi1YBtYcyfuDAd4o9WkUbZrg9xWu5BdK11d8euNvKwUHBhBtSCZd3aszSGd
 ZLTWxhxwabttzDvPLPbjrAaevHS+hxx6HbXiQJkh25nPZjqtr9RLJeXUxeZydiSQXHhO
 YEX/bINwgoYZyxWbZtrYBQldV3hg3sLuPSlQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730745407; x=1731350207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m4SWiyeBFOySyOiWZIF67DqmDPQdUC8NGvzH+nRI+Zc=;
 b=CAxsYlfUK2SkZuI5J8N8buXlFZrzag+tzVM4ozFRvM6tivoa3ZKxO7hGvFJvPSAkNO
 D59KRy3/tVZnni7ekw1CMt+wBkZ0VPc/nu5Vxvq52uy3n+epuQmvIq2LR0a5I7MdAM3v
 0m1KhACYbrqTEFI8Bp/VMC8NTgPpT8V6PpifX+rBY2yXU8rCyhoJeSNJY1vBijvzP0UN
 Dd48iHNZnCTK0VZekmSAcP9seKjJK2w67ColAWGtcfpgmIHGVDNvcR+ZUCHKZHfJstTK
 xRkYumm6fKzfyPXJSfxxIFbzbiJQAqyd58l0bzsCRJKlCF1ybofrZtt3pbpyNX66F2UW
 XDAA==
X-Gm-Message-State: AOJu0YxiQ4kQcGCBbxaj0Q5x5By8auMzpehVQERfewNgj+Kc1/0ea8gj
 qx1/IL4Jj7xIdDgl8CctkTUB9RipHUev2nBprgAsR0Epm2TggPf1YdKEgA7BwCgY0afxavEJHUc
 =
X-Google-Smtp-Source: AGHT+IFVlohjU5OsfyccFRAZoevgNk0RDxaJu4up8jiNrjOVdPfK0WY0On7El2KT+M1/jsxJBcxmcg==
X-Received: by 2002:a05:6870:46ab:b0:288:71a6:482b with SMTP id
 586e51a60fabf-294846d2a06mr11815361fac.47.1730745407170; 
 Mon, 04 Nov 2024 10:36:47 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048e372bsm2030285173.74.2024.11.04.10.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 10:36:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH v5 0/3] Add support for Labgrid
Date: Mon,  4 Nov 2024 11:36:40 -0700
Message-Id: <20241104183643.1116385-1-sjg@chromium.org>
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

This adds hooks for use with my integration for Labgrid (called
Labgrid-sjg). The only existing hook that really does anything with the
target, with this integration, is the 'console' one. There is also a new
'getrole' hook which looks up a role to find various things about it,
such as the U-Boot board name.

Changes in v5:
- Use Labgrid-sjg instead of Labgrid
- Use LABGRID_SJG to indicates the 'Labgrid-sjg' integration is running
- Update commit message and cover letter for Labgrid-sjg

Changes in v4:
- Use an environment variable to select the Labgrid hooks
- Add new patch to add .none scripts for power off/on
- Support pytest fully with dual-build boards like Beagleplay

Changes in v3:
- Fall back to conf.${board_type}_${board_ident} if conf.all missing
- Update scripts for latest version of Labgrid integration
- Add poweroff.none and poweron.none
- Provide -n flag when querying board info
- Target the grpc version of Labgrid which is now in -master
- Update README to cover the changes

Changes in v2:
- Make use of the common script (only) to set bin_dir
- Make use of the common script (only) to set bin_dir

Simon Glass (3):
  Create a common file for test scripts
  Add .none scripts for power off/on
  Provide some basic scripts for Labgrid integration

 README.md                        | 51 ++++++++++++++++++++++++++++++++
 bin/console.labgrid-sjg          | 42 ++++++++++++++++++++++++++
 bin/ellesmere/common-labgrid-sjg | 46 ++++++++++++++++++++++++++++
 bin/ellesmere/conf.all           | 24 +++++++++++++++
 bin/getrole.labgrid-sjg          | 25 ++++++++++++++++
 bin/poweroff.none                | 22 ++++++++++++++
 bin/poweron.none                 | 22 ++++++++++++++
 bin/release.labgrid-sjg          | 22 ++++++++++++++
 bin/release.none                 | 22 ++++++++++++++
 bin/u-boot-test-common           | 36 ++++++++++++++++++++++
 bin/u-boot-test-console          |  8 +----
 bin/u-boot-test-flash            |  8 +----
 bin/u-boot-test-getrole          | 38 ++++++++++++++++++++++++
 bin/u-boot-test-power-off        |  8 +----
 bin/u-boot-test-power-on         |  8 +----
 bin/u-boot-test-release          | 26 ++++++++++++++++
 bin/u-boot-test-reset            |  8 +----
 17 files changed, 381 insertions(+), 35 deletions(-)
 create mode 100644 bin/console.labgrid-sjg
 create mode 100755 bin/ellesmere/common-labgrid-sjg
 create mode 100644 bin/ellesmere/conf.all
 create mode 100644 bin/getrole.labgrid-sjg
 create mode 100755 bin/poweroff.none
 create mode 100755 bin/poweron.none
 create mode 100644 bin/release.labgrid-sjg
 create mode 100644 bin/release.none
 create mode 100755 bin/u-boot-test-common
 create mode 100755 bin/u-boot-test-getrole
 create mode 100755 bin/u-boot-test-release

-- 
2.34.1

