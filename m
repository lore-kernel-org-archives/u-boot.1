Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F258C5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 21:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19A4488AAA;
	Fri, 23 Aug 2024 23:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sr6YFOmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01FDC88B9E; Fri, 23 Aug 2024 23:31:32 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29BA688AA9
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 23:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81fe38c7255so146211539f.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724448688; x=1725053488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rNBG6U9L26f/tIP84GkYgZtKXVpW8DQTzcsKc4SWDEA=;
 b=Sr6YFOmBDvMIJBc4aaiRC8YUVcJWwR0U3apiamb4pvPcC+Ci71mI1mmbnyJ+F9LA4e
 QJlhirE/LmjC5tv/UKd9CmtPlD6cQ6x+qXSPnWmoA+hIsykBDATLdnMAudKZVauFDPmt
 3EuD8DQxsAdqIgT+3Y4eljgR1OUrkeSwbyUxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724448688; x=1725053488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rNBG6U9L26f/tIP84GkYgZtKXVpW8DQTzcsKc4SWDEA=;
 b=WUFpVHjwIbDwkCxfUxa3M0ombZSoT688CtfnlJi8I7Z5PjEJou+MWGsm0WCr72EfW0
 NGNt0FTV0E9+MOcsrUi+UeLQNV0ruAtASokW9egalerQ8+EEnvK2wXmIXfprvYeRQaOc
 P0LEup2r4/DIU1ep+kOVTcSX58a63r9xpSaNeJ3Q2qaJtdMSq9mmGzQPtZm/5+HG1lJA
 MAusu5eylQYOsz0jbQQ2syjMZcB/JGDDjec6iecCWouPug9iUudigFtOhk1kGJ8e7Zui
 +zw6zSMXpMh12XCtVY4tvTwbrgONrOD25ihNry+A+BkT/uBiV59HZDhNRFAP+ChRchyG
 vUMg==
X-Gm-Message-State: AOJu0Yw0R60r2dmeKrl33OJPZdAw8zKmVfLx6M4NC9WEKMst4FPR95pL
 MPvhwyHFrgWhEDzy30HFSmqzuOI14azuzRU0M4Ye432iCfs3rEnaJMtueSWkCQN2Rg9Et53XLwY
 =
X-Google-Smtp-Source: AGHT+IG/nH9yJ6AgOsRo5HuNdKghuuj2TZV9XlhnczmjdcaKLa92GA1RG21fl730Tjd4WepAtInvXA==
X-Received: by 2002:a05:6e02:178f:b0:39d:37de:4196 with SMTP id
 e9e14a558f8ab-39e3c9c0d48mr38809975ab.18.1724448687671; 
 Fri, 23 Aug 2024 14:31:27 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce7106a1bbsm1101042173.97.2024.08.23.14.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 14:31:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH v3 0/2] Add support for Labgrid
Date: Fri, 23 Aug 2024 15:31:21 -0600
Message-Id: <20240823213123.487227-1-sjg@chromium.org>
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

This adds hooks for use with Labgrid. The only existing hook that really
does anything now is the 'console' one. There is also a new 'getrole'
hook which looks up a role to find various things about it, such as the
U-Boot board name.

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

Simon Glass (2):
  Create a common file for test scripts
  Provide some basic scripts for Labgrid integration

 README.md                    | 37 +++++++++++++++++++++++++++++++
 bin/console.labgrid          | 42 ++++++++++++++++++++++++++++++++++++
 bin/ellesmere/common-labgrid | 32 +++++++++++++++++++++++++++
 bin/ellesmere/conf.all       | 24 +++++++++++++++++++++
 bin/getrole.labgrid          | 25 +++++++++++++++++++++
 bin/poweroff.none            | 22 +++++++++++++++++++
 bin/poweron.none             | 22 +++++++++++++++++++
 bin/release.labgrid          | 22 +++++++++++++++++++
 bin/release.none             | 22 +++++++++++++++++++
 bin/u-boot-test-common       | 35 ++++++++++++++++++++++++++++++
 bin/u-boot-test-console      |  8 +------
 bin/u-boot-test-flash        |  8 +------
 bin/u-boot-test-getrole      | 38 ++++++++++++++++++++++++++++++++
 bin/u-boot-test-power-off    |  8 +------
 bin/u-boot-test-power-on     |  8 +------
 bin/u-boot-test-release      | 26 ++++++++++++++++++++++
 bin/u-boot-test-reset        |  8 +------
 17 files changed, 352 insertions(+), 35 deletions(-)
 create mode 100644 bin/console.labgrid
 create mode 100755 bin/ellesmere/common-labgrid
 create mode 100644 bin/ellesmere/conf.all
 create mode 100644 bin/getrole.labgrid
 create mode 100755 bin/poweroff.none
 create mode 100755 bin/poweron.none
 create mode 100644 bin/release.labgrid
 create mode 100644 bin/release.none
 create mode 100755 bin/u-boot-test-common
 create mode 100755 bin/u-boot-test-getrole
 create mode 100755 bin/u-boot-test-release

-- 
2.34.1

