Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB8BC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26ADF88540;
	Fri, 21 Jun 2024 22:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mL0UfS/C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02B9788528; Fri, 21 Jun 2024 22:46:42 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D541A88059
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 22:46:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7ec07f4170bso96545039f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719002798; x=1719607598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5xIqVfaovVhIr7rx9GIQFmTB6LWJMritBGm4zaJlaUs=;
 b=mL0UfS/Czx6MKQ1iQbLEYSDFJUODncNNl0yctOv1WEAXtxDkedGAb2iwisdj338VdF
 5TAPM0nEA5hfpWWWKuHWJ71uVo3J1F9Ul0D0PZ9Wdt93BT/6AaEcYomEqhDTR6LIkizp
 DGlbAbwywAZ53W4vXOwMtx3L+B6altIxlidrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719002798; x=1719607598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5xIqVfaovVhIr7rx9GIQFmTB6LWJMritBGm4zaJlaUs=;
 b=fb92aHaHetk3Ax6e8r/BSu6teDZsX+6jZwlk9deqBUjXqs92GfnrvX3K3bk+skp80a
 P9dhOw8QOw9eOZz2ZjVc+BIWwTuDwAvU6rjto5n7RM8D56tP/uKujNMa0AxjroHX/77W
 cI2I0Dy/c27WN7Z7e4vlv4WEKz3B+9AvC4KvfQ0LhpWChOArw3Vp8kSXjD1eb2DkDWPF
 YEVSwQC4KYmxKPu5KHTZ9E2hU8XHBdk6lgj+xIG/pHyM1+QYv/J3IY0nsYFtAiuAPAm3
 YvJ7kb9OsF/ueuy4S3yKddbFsKbmFjo95rGwkNH+tfipsWAy829OhMPRtqXbkMlFdWxk
 jiRw==
X-Gm-Message-State: AOJu0YyruKTEIXuiOQkZ03WOFHJSBc1Y3EvNKH9Uawl1wKlWI5QGSJZu
 YoU5qwBS1SrUfvymhqzF78WCn01xJ+wlO8J3oqaNTb9B31KDo2e3UxpSuCF8/6Vs6BajkLwEVoS
 kJw==
X-Google-Smtp-Source: AGHT+IG+NWO8kPM3PTMNSxnYnRch86Bsw6oTu2CtCj9SCgl5qfdy+CWppR6ZAKYdmVJokg1SSLi1rw==
X-Received: by 2002:a05:6602:13d1:b0:7eb:9a46:c743 with SMTP id
 ca18e2360f4ac-7f13eddeccdmr1067357239f.7.1719002798379; 
 Fri, 21 Jun 2024 13:46:38 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203ec51sm50698939f.53.2024.06.21.13.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 13:46:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 00/11] Tools updates for Labgrid
Date: Fri, 21 Jun 2024 14:46:21 -0600
Message-Id: <20240621204632.2706813-1-sjg@chromium.org>
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

This series includes patches to update buildman to support Labgrid
better and some minor binman fixes.


Simon Glass (11):
  binman: efi: Correct entry docs
  binman: Regenerate nxp docs
  binman: ti: Regenerate entry docs
  binman: Update the entrydocs header
  buildman: Make mrproper an argument to _reconfigure()
  buildman: Make mrproper an argument to _config_and_build()
  buildman: Make mrproper an argument to run_commit()
  buildman: Avoid rebuilding when --mrproper is used
  buildman: Add a flag to force mrproper on failure
  buildman: Retry the build for current source
  buildman: Add a way to limit the number of buildmans

 tools/binman/entries.rst                | 115 ++++++++++++++-----
 tools/binman/entry.py                   |   2 +-
 tools/binman/etype/efi_capsule.py       |  40 +++----
 tools/binman/etype/efi_empty_capsule.py |  22 ++--
 tools/binman/etype/ti_secure.py         |  45 ++++----
 tools/buildman/builder.py               |  18 +--
 tools/buildman/builderthread.py         |  44 +++++---
 tools/buildman/buildman.rst             |   8 +-
 tools/buildman/cmdline.py               |   6 +-
 tools/buildman/control.py               | 141 +++++++++++++++++++++++-
 tools/buildman/pyproject.toml           |   6 +-
 tools/buildman/test.py                  | 121 ++++++++++++++++++++
 tools/u_boot_pylib/terminal.py          |   7 +-
 13 files changed, 465 insertions(+), 110 deletions(-)

-- 
2.34.1

