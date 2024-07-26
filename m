Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0BCC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 14:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 708368860C;
	Fri, 26 Jul 2024 16:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nWHC+xO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E018884CC; Fri, 26 Jul 2024 16:55:05 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30B4F88614
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 16:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b7a3b75133so5401126d6.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722005701; x=1722610501; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Z1Noaf+5YfhJ1DbnHQV5c+hiosZaxX6eWJ09qrmqA8U=;
 b=nWHC+xO8pKmma3sKLGGkbhfFbvGCRmlHjTPeC1SwuYd9WTezHl/v1ZR0m4my70IYj8
 4FFeKkQ2aaUA0lUKqshVwnWF3APIkaZ50wLsyy0cdeTVSKioDjs0flStbUNBBhjBWyvH
 o88upWXTR65pHbLkp+atL7PG9vZsk4OCacuwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722005701; x=1722610501;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z1Noaf+5YfhJ1DbnHQV5c+hiosZaxX6eWJ09qrmqA8U=;
 b=DyaKnZxi+592nyuYNHol1kxWkq2yqipudXYzxS3MfKtzttnJnyo+LOue1z/YabEHBL
 bykazdw69rVVN5L6JA3rubq0Uun1bppCKFi3Fa9xs02kkRd0AWKHEhwRJ0g0C87iJL4H
 GZRbacjYYVrW4HEgbMQnwNaUwR2oGZN4B4gPExIa+QGu7xGi0JcMjYxGUA/2dpOJVplB
 h49JUo5L0RDW2jpmy8RGHtgc4/1VO6PiS0bZx0kn6sCH9goXTdKNyKIk+qCrZ76OCB+k
 Q4b6qcKH70pqrl/jwgX8SKd76AtzRXfNuWjkeZ5DYmAUIsCPKZBrmmLv0xjvBtUK6YX3
 er3g==
X-Gm-Message-State: AOJu0YwfWls6MxrlEPyW5Z+hWWwG/KzpCZlKgiOEdXas9xsSXXOMW12v
 I3MVDHNx3MfuQlyXBZq/TZz+Vmmhblunx7gJQblrkyBuXjBVfgeps8w4y6PK9buQj4BNHLjT29Z
 O3tfbm3nzs5voCVsLoYS3ulxhMxUg8X8s9aHjEVlyK1gG7cQ=
X-Google-Smtp-Source: AGHT+IEUEP24ZhyQgZK6uV4OcNkoTjBA6dTaT+q/sbK/jkW3MLNDFcDJsX7Y4Ha0KbF0UF8+/lJuuU2Y8m/KmdvFkqc=
X-Received: by 2002:ad4:5ba4:0:b0:6b7:a32b:4427 with SMTP id
 6a1803df08f44-6bb55ab7c1fmr253786d6.52.1722005700906; Fri, 26 Jul 2024
 07:55:00 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jul 2024 08:54:50 -0600
Message-ID: <CAFLszThGWecZAzEEzopkCbJF36R_gPoFcJFu-qh-BqL2eUiSGw@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/21781
https://dev.azure.com/simon0972/u-boot/_build/results?buildId=65&view=results

The following changes since commit f4e163ece454bcf949a9b2005de3b70392ca05d1:

  Merge branch 'qcom-main' of
https://gitlab.denx.de/u-boot/custodians/u-boot-snapdragon (2024-07-26
07:49:36 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-26jul24

for you to fetch changes up to e8effc385496d76a6cbaf9683dfede96ac634f72:

  buildman: Show board list with -x (2024-07-26 08:01:06 -0600)

----------------------------------------------------------------
buildman minor fix
qconfig refactoring
patman fix for Python 3.12

----------------------------------------------------------------
Andrew Goodbody (1):
      sandbox: Fix LTO to work with STACKPROTECTOR

Brandon Maier (1):
      tools: patman: fix `pip install` with Python 3.12

Simon Glass (25):
      qconfig: Fix pylint error in read_database()
      qconfig: Drop the try_expand() function
      qconfig: Make KconfigScanner a function
      qconfig: Tidy up some pylint warnings
      qconfig: Correct format string in do_imply_config()
      qconfig: Rename the doc link
      qconfig: Move arg parsing into a separate function
      qconfig: Move arg checking a little higher
      qconfig: Move arg checking to the top of main()
      qconfig: Move getting the colour to where it is needed
      qconfig: Move checking directory to the top
      qconfig: Move converting config args to the top
      qconfig: Move testing into a separate function
      qconfig: Add a return value to do_scan_source()
      qconfig: Move imply into a separate function
      qconfig: Add a return value to do_find_config()
      qconfig: Move all move_config code into move_config()
      qconfig: Move commit code into a separate function
      qconfig: Move progress output into the class
      qconfig: Move the last two operations into their own functions
      qconfig: Use the Color object in Progress
      qconfig: Drop col argument from Slots()
      qconfig: Move operation check into parse_args()
      binman: Update cbfstool
      buildman: Show board list with -x

 scripts/gen_ll_addressable_symbols.sh |   5 +-
 tools/binman/btool/cbfstool.py        |   3 +-
 tools/buildman/control.py             |   3 +-
 tools/patman/setup.py                 |   1 -
 tools/qconfig.py                      | 387
+++++++++++++++++++++++++++++++++++++++--------------------------
 5 files changed, 237 insertions(+), 162 deletions(-)
