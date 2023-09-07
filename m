Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5E4EC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F010686B3C;
	Thu,  7 Sep 2023 18:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PtLpjA3k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE9C869A3; Thu,  7 Sep 2023 18:00:29 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD8B5869A3
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 18:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-795547f055fso47772139f.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102425; x=1694707225; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HnkgKwfJFYLnApd4bpjWnfdLgFiX/yDnFI16+vIkmRw=;
 b=PtLpjA3kvEvHEpbeI1H6jUF2RsRVaN/qz7Mpxo7qcArpxDkJeYxQvRtHdY+Fo7Ek3+
 76Q4/dhgliR5uEdk3fnR4xaCbuy2P+RkmihjnIPGFu5iXyWp/dyxIT2fRu3uuQjVsYTX
 ppPvmIqeThjEa3E7YnLh8zeonj2+BtCLuH0I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102425; x=1694707225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HnkgKwfJFYLnApd4bpjWnfdLgFiX/yDnFI16+vIkmRw=;
 b=mDrgAFAwA61QgqTgox9XiLRibg0teehtPYvAYp2F8tYxYD3jhXpd6CgkO5QWg9PUyw
 hn7dGoZqzV8fHV5R0/TjQvFrDsCatAmpPa1x/rpqC+zP4UKsqn4sBMmtzUHqq6LkUJL4
 xqApTJD/Pqcfhf4maqcQPjZ4tRUlXN7m3PMuPfK09WE0jdGqC2eJoX26YJ/2JNU03FjM
 oC/XIImDOcN3r225iTmjP0mVShjGSTi0Wq1hQbsz0AfFhYaI2y9yp5vRUeeQ6NJmrMCY
 2YYA+oVQluXPbhXeAdh/ZHgHqEIJYE2tV1mZW9Q1V9ft5notxCzvO/bRCKgNJOuMUirO
 mJIA==
X-Gm-Message-State: AOJu0YzHUrFI3As+SCMeCLwxzCr4yxsIQfzrIJmL1qtRtXoO5RtnCAjD
 VqqIrN94HzF6mX6xw5Gk7DCFTfi865w+AI7uW6U=
X-Google-Smtp-Source: AGHT+IEwpOkfWaMTVz0Dzhotr7jEXm3J4FSE4xSBWFIKJ09FuJzmI+2htchR9Y2FtkxQj5nv2rYZVw==
X-Received: by 2002:a5e:8812:0:b0:792:2b7a:e3c4 with SMTP id
 l18-20020a5e8812000000b007922b7ae3c4mr76532ioj.18.1694102425587; 
 Thu, 07 Sep 2023 09:00:25 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a02a805000000b0042b39b2289asm5699209jaj.102.2023.09.07.09.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:00:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/4] Attempt to collect standard extensions for build output
Date: Thu,  7 Sep 2023 10:00:16 -0600
Message-ID: <20230907160023.49339-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
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

We would like 'buildman -k' to keep the build outputs. This series tries
to do this by adding more common extensions to the list.

It also includes a few minor fixes.

Changes in v2:
- Redo patch based on dropping the binman restriction

Simon Glass (4):
  buildman: Keep all common output files
  buildman: Show progress when regenerating the board.cfg file
  buildman: Start the clock when the build starts
  kontron_sl28: Use u-boot-update.bin instead of u-boot.update

 arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi |  2 +-
 doc/board/kontron/sl28.rst                        |  4 ++--
 tools/buildman/boards.py                          | 15 ++++++++++++---
 tools/buildman/builder.py                         |  3 ++-
 tools/buildman/builderthread.py                   | 12 ++++++++----
 tools/buildman/control.py                         |  3 ++-
 6 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog

