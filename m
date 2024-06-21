Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E052C2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 13:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E76568854A;
	Fri, 21 Jun 2024 15:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G0cefMh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91B3F8834D; Fri, 21 Jun 2024 15:14:30 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D57E87073
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 15:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7eb6aedcabcso75058639f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718975667; x=1719580467; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UdNhHTEAmrLcjgF8azV+gEoVNsLDTZGctxGIssVKUmw=;
 b=G0cefMh4o9E+1DnlAkn/i1nM6WxasxKjW05QKRCchf8FUBYadFmJHfZ68P66oanT76
 XNmI/cV0tCqc9UYMXM6NuU9I0PwNYhZwx2rz0BopRiiXpcyg5mDq6V3MQpOzWqcx9+DO
 RaJfBUwCejziOBU6z3Y9eZpjG//hNiQ8ounFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718975667; x=1719580467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UdNhHTEAmrLcjgF8azV+gEoVNsLDTZGctxGIssVKUmw=;
 b=wTngZOBQFvJ0EEnH24pxxgcTJcfWgSBA/b/YpyixOfAVUN6fCCnWiC4ltCkf/R7jFJ
 Pra1gfHK1EbSkzKqk5fHEMOiwJPGMxaNEvSzdVw74y8rdVESmn2bosXObWtlP1gFgivn
 udfd2T5b5mWYWuonlNynVSdwmiXFco7/MXMb9uDf2RiNsdz5qrYRzKr2Z+d7y+Kh1BIH
 8VpZnrnGwvIMvDdi3o3nH61TwuQCApU/uINniWvHpOlm+74o/04nQEsiaU+CHOcuOVgk
 N1NmxPtU2ZZ6arB7Cdig/X39H6zXn+1R4yFJXQxsIHXO5f32/kCUqWeFD2NDFb/yY1mz
 esAA==
X-Gm-Message-State: AOJu0YzmHbXOGCijrKbiu/T9hOCCefH8lY5tS5WySjb4GuU6M9US0wz4
 ReTOBGKMQHLez6gY/gi2u0AmGUqWisHu+LlBQIIsFVPv7HRrGLnhkT1e1Uw+kHnAFZCQoML/Jv/
 qBg==
X-Google-Smtp-Source: AGHT+IFEw7N0jpBDeO86qwarj45c18GotVC31xOXFXeIhzXGXd0r+uHLGD9YYiw5mAwv6TLvg8/U/A==
X-Received: by 2002:a05:6602:2dc1:b0:7eb:f3c8:c59f with SMTP id
 ca18e2360f4ac-7f13ee26cc6mr915556439f.11.1718975665939; 
 Fri, 21 Jun 2024 06:14:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d12496fdsm346881173.163.2024.06.21.06.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 06:14:25 -0700 (PDT)
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
Subject: [PATCH v2 0/6] Add Binman code-coverage test to CI
Date: Fri, 21 Jun 2024 07:14:16 -0600
Message-Id: <20240621131423.2363294-1-sjg@chromium.org>
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

Changes in v2:
- Add new patch to fix a few typos in toolchain code
- Add to azure also (oops)
- Add to buildman requirements instead
- Fix 'envronment' typo

Simon Glass (6):
  buildman: Add python3-coverage
  buildman: Add python3-pycryptodome
  buildman: Fix a few typos in toolchain code
  buildman: Support building within a Python venv
  u_boot_pylib: Use correct coverage tool within venv
  CI: Run code-coverage test for Binman

 .azure-pipelines.yml            |  5 +-
 .gitlab-ci.yml                  |  4 +-
 tools/buildman/bsettings.py     |  3 ++
 tools/buildman/requirements.txt |  2 +
 tools/buildman/test.py          | 83 +++++++++++++++++++++++++++++++++
 tools/buildman/toolchain.py     | 35 +++++++++++---
 tools/u_boot_pylib/test_util.py | 11 +++--
 7 files changed, 132 insertions(+), 11 deletions(-)

-- 
2.34.1

