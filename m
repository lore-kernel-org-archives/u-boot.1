Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD1AEEAA7A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F40D865FB;
	Fri, 15 Sep 2023 02:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fbPr2n1Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6509D86660; Fri, 15 Sep 2023 02:22:43 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54E428648D
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-77acb04309dso53832939f.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737360; x=1695342160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4pTCxKNZ1fEdOx3Q8WFjNEyLJejEfZh8vFBtt6CVTYg=;
 b=fbPr2n1Qg1S7DENyZT9BfJmw8pA1mgOCSMkCmEof/7x5s71evVDzdvXAh1VlTYyd1+
 b4HKXyhZADkKNiH7Vvc2VrBvR3Ebg9jz0GpjXgE3rR04SgLWjHjl4rHNZwYSUslUmuB3
 FMWcMOYiw+RywupOdLskxj/suqukQ/YFwrhJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737360; x=1695342160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4pTCxKNZ1fEdOx3Q8WFjNEyLJejEfZh8vFBtt6CVTYg=;
 b=eidPK8MXbn6YvYruF/XK77SFCNtklWNsHcZ7XR9AOWODLlGvPp39c9dePelnPdEieM
 OlFqsoYOMydlwOCaOmpEuUKuxVIO0Oje74ubmgn6bTatmBF1SYwTGhpzHuJm+Ug0R4rZ
 7SNu9zGZ1pjungfIituf/pL/CGpxHXJxjZpJzLU4WW/KretXOZhLa479hbNq4o3zg1j4
 XaTLUPpuiHTL3zZrboy8koD1f9VUZ/jYQxO9HBKX0Afh9M3gRotkIbsBBZ6uT9jA2Jr5
 B8/JPAh2MDeeGEYVzTjkszoG7gv8PjpvoIk6d4ALKxwOlRrrr/4Xh/SAg03r3IQPD+eU
 rfLA==
X-Gm-Message-State: AOJu0YxDUgOL+HKK/l43F9qz/pyVzTxlHSJ8O3qiBO+DlcSsX8ZjqIwA
 2E9AB64qkoKK6IT2OiOJ7G1dcsmiZHDeQMLpNds=
X-Google-Smtp-Source: AGHT+IG3Gon31DrC4B5Vuf8th57rz01qD3Uf/pqTArJ50kl7DzvgeayCqBo12RkVaCwNx6u7xqXTXQ==
X-Received: by 2002:a5d:8b93:0:b0:798:3e95:274f with SMTP id
 p19-20020a5d8b93000000b007983e95274fmr29614iol.19.1694737359954; 
 Thu, 14 Sep 2023 17:22:39 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2 00/27] moveconfig: Drop old code and tidy up
Date: Thu, 14 Sep 2023 18:22:02 -0600
Message-ID: <20230915002236.798760-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
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
 doc/develop/{moveconfig.rst => qconfig.rst} | 144 +---
 tools/{moveconfig.py => qconfig.py}         | 894 +++++---------------
 4 files changed, 263 insertions(+), 781 deletions(-)
 rename doc/develop/{moveconfig.rst => qconfig.rst} (61%)
 rename tools/{moveconfig.py => qconfig.py} (65%)

-- 
2.42.0.459.ge4e396fd5e-goog

