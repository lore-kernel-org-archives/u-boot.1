Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DB2C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 13:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EFF388535;
	Thu, 20 Jun 2024 15:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FN5zYBpW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F1488516; Thu, 20 Jun 2024 15:19:53 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22FB088385
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 15:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-375d22e537cso1809985ab.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718889590; x=1719494390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zGxUmDSG76BTUjAKe7t1tQPXAgfXJOH0apox96lDzM8=;
 b=FN5zYBpWrpy+GwRQZeNJ95gRb+jBdWNTqHZhgYJzgUhFb3UZsTrcB5S7zlxGYh+UOk
 hfGK5TBLIX0AVIjF41tJvdX34BiAKB7Et5XA/Rs8a1ufIBM+Wx/xG7xlEKwttWLs8HK/
 sEgf1F/5AQgQdHb33ffwkVSezlQ0gb8/XDCXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718889590; x=1719494390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zGxUmDSG76BTUjAKe7t1tQPXAgfXJOH0apox96lDzM8=;
 b=D7YH/uT9Im1kqRKQVLxIzagzfmXEedGLzMNMKrWGkTl8tdgENojJ1s42hXgbvRYdEN
 RlrxwIbHjrXCKIey7JbU8tH75wjf2V+YjOzgi+X9CwVLCC0IJjpRJ0GF+cTyuQBA8Gsu
 seo+zvrYPQYvOZgeE496VrtvJodxbM7U+sz3kR4yAq99GFxmlrup6l+yAnIZUzASH5SM
 aue+z1npkv6TSNNyPWBAZMxtgmsyOh83i1uhxF5FBF08Pt6eqL5mLFKSEr0ARvRnsgD3
 3v1bnRUYkwNwkAslNAtrnlxUDor+4NKjYQ/x3s0EA3hSxESoDOgmofkl5fKbxXes7aNe
 VtmA==
X-Gm-Message-State: AOJu0Yw4giIgR/MpawPCSZf3dVSi+t01BUoQNGGtJUbHLEczhCnOBvur
 IOOexDYGFK+PGIUejJCPWznHYn+6uGVBAT5YeHaHijqRlglGaS/LZ+zmaicCn6gESxbQWa3ADqp
 w0g==
X-Google-Smtp-Source: AGHT+IEQWDB1UgPVTMiUxkrzrJ+/AVcdcjPW50tEmbWcSQivvakakWjt5+7g39rAKkNndE5iNRgUqw==
X-Received: by 2002:a05:6e02:190b:b0:376:1c71:1e1d with SMTP id
 e9e14a558f8ab-3761d6b3d4fmr65510585ab.12.1718889589722; 
 Thu, 20 Jun 2024 06:19:49 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375d866e260sm31807865ab.7.2024.06.20.06.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:19:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 0/5] Add Binman code-coverage test to CI
Date: Thu, 20 Jun 2024 07:19:32 -0600
Message-Id: <20240620131937.1130446-1-sjg@chromium.org>
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


Simon Glass (5):
  Dockerfile: Add python3-coverage
  Dockerfile: Add python3-pycryptodome
  buildman: Support building within a Python venv
  u_boot_pylib: Use correct coverage tool within venv
  CI: Run code-coverage test for Binman

 .gitlab-ci.yml                  |  4 +-
 tools/buildman/bsettings.py     |  3 ++
 tools/buildman/test.py          | 83 +++++++++++++++++++++++++++++++++
 tools/buildman/toolchain.py     | 31 ++++++++++--
 tools/docker/Dockerfile         |  2 +
 tools/u_boot_pylib/test_util.py | 11 +++--
 6 files changed, 126 insertions(+), 8 deletions(-)

-- 
2.34.1

