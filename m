Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D13CE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C5C86996;
	Sat, 23 Sep 2023 21:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="agm9yIqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163298477A; Sat, 23 Sep 2023 21:44:32 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0C98477A
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34fc7f51441so12931265ab.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498268; x=1696103068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HrIyEQRA0TNpYpOhmEgaftWCZ6mFlh3pxGjY/lFC7xk=;
 b=agm9yIqCzfnK9M9Zz+GFS87YCRd7O6Um77oGKzISwJyowi4xcjSYi8VOSIzuJZqWea
 9ehByS8NQ50xLyz79/lTUxxFX6i7yfo4S++rPT8hBPD35jAy/82pv8JKDhut9O+ju3N4
 j8ymcEMyYc3cq56O/5ZOqWvL1x/5BYKx14gF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498268; x=1696103068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HrIyEQRA0TNpYpOhmEgaftWCZ6mFlh3pxGjY/lFC7xk=;
 b=AtHpT24Wyn+VaWeu67KDd8ibtUooaial35TGoZF9Dq7PRHE1hLkXm8RL9hUwqUYxSC
 1B0z2mzEdQ6q5tQsv/lW+4s8zFI65jcAlWRkFu9T3Uq0QgjQgrq6hDyw+4ljQTheFvxz
 S43h0UydaBHG81HQnsPOOafm8IDxl5hZom4p0JoqK5ZzrNvuQM8HnqUB7T49pr31Frbr
 fm7kXvMW0oSAZ5QYn+A4frU4ofK2XGrYhs7SajNgGlRjmy/s2RfhIcnDaZthEVS0z25u
 8Axt92qpqWiquyn/uE3dSHF8U+akmAKRejNQO/At8tnYPfQdJ6xylvh44dbKp4YcmQaU
 F47Q==
X-Gm-Message-State: AOJu0YwxqsGOQWjVUFKweKfLKAAp9nJ5fCe0fOYNn7t8oJNJ35kW7MnV
 9UOdaN4YEnoZSH5OcUIXNaTT5uiLiT39n+q6K+I=
X-Google-Smtp-Source: AGHT+IGpW3KSxtfdqwdAbsdTiqvdg54qhICeOXYfdISwBlL4KW7bnYrSxRPLmQOZRBSfGnD7YK6NaQ==
X-Received: by 2002:a05:6e02:1aa8:b0:351:13a6:c3b0 with SMTP id
 l8-20020a056e021aa800b0035113a6c3b0mr3672546ilv.32.1695498268388; 
 Sat, 23 Sep 2023 12:44:28 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 00/27] moveconfig: Drop old code and tidy up
Date: Sat, 23 Sep 2023 13:43:49 -0600
Message-ID: <20230923194424.1739224-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
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

This tool is designed to move CONFIG options to Kconfig. Since this task
is complete, some of its functionality is no-longer needed.

This series drops the old code and tidies up some pylint errors.

It also improves the output by only displaying failures and providing a
summary at the end.

Finally, the tool is given a new name.

Future work may provide a way to integrate the search functionality with
buildman, to permit building boards with a a particular combination of
CONFIG options.


Changes in v3:
- Fix 'Supress' typo
- Update based on Heinrich's comments

Changes in v2:
- Reinstate the -C option

Simon Glass (27):
  moveconfig: Drop -H option
  moveconfig: Avoid deprecation warning for setDaemon
  moveconfig: Correct ordering of asteval import
  moveconfig: Drop unused cleanup options
  moveconfig: Drop CONFIG-moving code
  moveconfig: Drop check_defconfig() and update_dotconfig()
  moveconfig: Drop suspicious boards
  moveconfig: Correct some regular-expression strings
  moveconfig: Correct parameter-type warnings
  moveconfig: Use f strings where possible
  moveconfig: Correct unused variables
  moveconfig: Correct non-snake variables names
  moveconfig: Correct use of members not declared in __init__()
  moveconfig: Correct list-comprehension warnings
  moveconfig: Use an encoding with open()
  moveconfig: Fix misc pylint warnings
  moveconfig: Only show output when there is a reason
  moveconfig: Reduce the amount of output
  moveconfig: Avoid showing progress at the end
  moveconfig: Use u_boot_pylib for terminal colour
  moveconfig: Show failures in progress
  moveconfig: Show a summary at the end
  moveconfig: Drop the initial output
  moveconfig: Move summaries to the end
  moveconfig: Rename the tool to qconfig
  qconfig: Rename the database file
  qconfig: Update the documentation

 .gitignore                                  |   4 +-
 doc/develop/index.rst                       |   2 +-
 doc/develop/{moveconfig.rst => qconfig.rst} | 160 +---
 tools/{moveconfig.py => qconfig.py}         | 894 +++++---------------
 4 files changed, 272 insertions(+), 788 deletions(-)
 rename doc/develop/{moveconfig.rst => qconfig.rst} (59%)
 rename tools/{moveconfig.py => qconfig.py} (65%)

-- 
2.42.0.515.g380fc7ccd1-goog

