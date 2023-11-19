Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9041DC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F32F6871A5;
	Sun, 19 Nov 2023 16:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mqfs0DAK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D4887186; Sun, 19 Nov 2023 16:36:20 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C196286A43
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7a66aa8ebb7so152173939f.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700408173; x=1701012973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=360U9Hc3UE20eyx5EJCVl8N1/JiIWuHzS7lAz9I4kRs=;
 b=Mqfs0DAK7qa5g4pDmQHsM4xTaYaKzBMMVv1dfy0OB8qkBqJzo1X/RPN0o98lEwXJNw
 rV0ERfM7vdFAi0K9RRPAREYp0ljOice5GKo9lfVFGBJv10gd4zxeuBzqEQO7cSBvXwcI
 yLa7t3CLBYRnrvX5jO66f4nCm7c5F/50f39Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700408173; x=1701012973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=360U9Hc3UE20eyx5EJCVl8N1/JiIWuHzS7lAz9I4kRs=;
 b=QWGTOQwyDnEgpderalkgwaFvXYM2mU9IzpyQKESHqiIoMIP/4aDVA6H4k6/7reIT0n
 5AKeQmmDAzWXAG1oq2aqHj/tE8/qxNVcKC0IIPptI5f9KDveoF65wpaIVZmS1RZzQQVi
 tuEdJFYKEDUOL0KfpDHM3sdNWsJDQShbOYNuySWDsiyzfa6Mawc4OS7egvhKZ3huykUF
 28KShjOOpkIu/uwmpp0fOS0VsKFty1zjtlq/+rihRXa+HvkD/C0df+dR6l5mZziOeynW
 NWxG1nTslezEJfkbhSuiYQ47QF5VORmlhb7agxuDK8BwNXF110n+Ld5WzdYNie7fc7QO
 Dsjw==
X-Gm-Message-State: AOJu0YxPI8CLiq7vjcvaBOhQhsdeQ+kt9op/uguvTkchktFsLjC6ziZp
 Y36kjGhuN0JyLVJEktgaLc3yo3akf96MVY3j9TemHA==
X-Google-Smtp-Source: AGHT+IHOv9ak9R5QY2Br3s1mASyQH54LV6pmVUbUGnEjyMN/7C0UV/8a+F6k41cqIP4ndiW5n8cdBg==
X-Received: by 2002:a05:6602:47c8:b0:7b0:ae77:36ec with SMTP id
 ea8-20020a05660247c800b007b0ae7736ecmr3524708iob.9.1700408173238; 
 Sun, 19 Nov 2023 07:36:13 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 19-20020a0566380a5300b0046456924383sm1466712jap.73.2023.11.19.07.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:36:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 0/7] doc: tools: Tidy up toml files for a new release
Date: Sun, 19 Nov 2023 08:35:59 -0700
Message-ID: <20231119153611.639252-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
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

This series corrects a few problems with the generation of pip packages
which showed up during a recent tools release.

A new release has been completed for all tools with a new version
number of 0.0.6 so this series reflects the changes there.

It also updates the documentation URL to use the u-boot.org domain.


Simon Glass (7):
  doc: Update documentation URL
  u_boot_pylib: Correct readme formatting
  tools: Keep test_util and patman test files in the pip release
  u_boot_pylib: Correct files used for pip release
  tools/make_pip: Add mention of u_boot_pylib in tool list
  patman: Update the run script
  tools: Move python tools to version 0.0.6

 MAINTAINERS                       |  2 +-
 README                            |  2 +-
 doc/build/documentation.rst       |  2 +-
 scripts/make_pip.sh               | 14 ++++++++++++--
 tools/binman/pyproject.toml       |  6 +++---
 tools/buildman/pyproject.toml     |  6 +++---
 tools/dtoc/pyproject.toml         |  6 +++---
 tools/patman/pyproject.toml       |  8 ++++----
 tools/u_boot_pylib/README.rst     |  2 +-
 tools/u_boot_pylib/pyproject.toml |  9 ++++-----
 10 files changed, 33 insertions(+), 24 deletions(-)

-- 
2.43.0.rc0.421.g78406f8d94-goog

