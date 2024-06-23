Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C38C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 476FA88600;
	Sun, 23 Jun 2024 19:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="djRdf+hO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E154588551; Sun, 23 Jun 2024 19:56:28 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B16508857F
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-376211b3a4fso13105555ab.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165385; x=1719770185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jXqXWuLPw5MizKDqGHaLd4O1HfeMkOmtc530iZwHTUw=;
 b=djRdf+hOLXRZVEogMZlj56FbB7mtC5e4b9CVQySb+XlwqdHC+p4dabqMdFRexq7Y1e
 QAyEyN3Poti2hzPs/OGLOCQMPQ7Gw5upmTzpBExPKWIHjLvPJzRj4D4D0VtEtXqxYoaH
 7g4NCAmaVbfO7OopRMHDU4l4Ul9r3vUuqUYu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165385; x=1719770185;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jXqXWuLPw5MizKDqGHaLd4O1HfeMkOmtc530iZwHTUw=;
 b=cXO972diiYmmOMryzZtxME+cCJjBZxvWsgQcTz5RwTUMpI8fkEd4IuEFnw47DZ3xZi
 e1YEmCfgmzq0LV88aMRnR+7RCIWGDEnXYrbhWhi6de+MI3JGYvSHlPsXdnaS1T22q783
 ybUv+X666ydIEYYLTAKJ2RB1f8S7FQQHMWzQE8I5fs3kRkfhdfVgWytSJamtPecrq3hv
 onswioTyj655I0hznnfs04U1SRBkKt0BLbdWj2WgjGK1jnR7GQ2BXbGNXRqTesdSz14d
 ZR7aAdWTE3wsdzkluSaLxlQRf/DtabRRaL72nWLvu+gd/dShkCI9HVZLEAB8PLnlb7MK
 kh1g==
X-Gm-Message-State: AOJu0YyXHhglRnwMRaYBuUIUmXJdqs+FuMHS28D60uiYDHTWftevafDr
 WYCi6fluA/IWh91l1h2ubagstjHSRcQqS3YO3NMYW1ChjvAttqSblcEOriCgthG2FuXxPbpseTt
 Zpg==
X-Google-Smtp-Source: AGHT+IGl6pB32sPfzISSluKc9gd7fVGLb+j6JGcWAM3dGcpgHRZWnA8H8VM157pJvHFP/D0G2UVXug==
X-Received: by 2002:a05:6e02:1586:b0:376:47f5:d0ae with SMTP id
 e9e14a558f8ab-37647f5d368mr3238165ab.17.1719165385331; 
 Sun, 23 Jun 2024 10:56:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3762f2fb1bbsm13551465ab.12.2024.06.23.10.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:56:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 0/6] Add Binman code-coverage test to CI
Date: Sun, 23 Jun 2024 11:56:16 -0600
Message-Id: <20240623175622.1468600-1-sjg@chromium.org>
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

Binman has 100% code coverage to ensure that future changes and
refactors do not break existing entry types. This is a critical feature,
given that it is relied on to produce images for all sorts of different
SoCs and vendors.

With the NXP additions the 'binman test -T' step was missed, so the
Binman coverage test is currently failing.

This series provides a means to close the testing gap. It cannot be
applied until the tests are added, which should happen before -next is
applied to -master

Changes in v3:
- Drop the PATH modification altogether

Changes in v2:
- Add new patch to fix a few typos in toolchain code
- Add to azure also (oops)
- Add to buildman requirements instead

Simon Glass (6):
  buildman: Add python3-coverage
  buildman: Add python3-pycryptodome
  buildman: Fix a few typos in toolchain code
  buildman: Always use the full path in CROSS_COMPILE
  u_boot_pylib: Use correct coverage tool within venv
  CI: Run code-coverage test for Binman

 .azure-pipelines.yml            |  5 ++-
 .gitlab-ci.yml                  |  4 +-
 tools/buildman/bsettings.py     |  3 ++
 tools/buildman/builder.py       |  5 +--
 tools/buildman/builderthread.py |  4 +-
 tools/buildman/cmdline.py       |  2 -
 tools/buildman/control.py       |  6 +--
 tools/buildman/requirements.txt |  2 +
 tools/buildman/test.py          | 75 +++++++++++++++++++++++++++++++++
 tools/buildman/toolchain.py     | 24 +++++------
 tools/u_boot_pylib/test_util.py | 11 +++--
 11 files changed, 111 insertions(+), 30 deletions(-)

-- 
2.34.1

