Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1339E748ED
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 10:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6864870AB;
	Sun,  1 Oct 2023 12:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ixl18i1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A67AD870A8; Sun,  1 Oct 2023 12:00:47 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C18D386EFF
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 12:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so15452197f8f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 03:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696154445; x=1696759245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+bVqx+CdOHpztM75DI/HJNX+PVb40Ib+4lfVw0jaCwU=;
 b=ixl18i1sj6kJOETp/dTkZRCrkwqYGsRCib8DF7sKiLnlwb3zKeRdZcGnyMWM+TT4om
 b0zJvKkQLjNZ2y6wn+VFpMm7O83Nrh/cRIJGtlAsjcU3YjVIwaXvVri1puohg1uxsBpX
 R3/3jpwRMo9/4A9Mb7+P/5WR1TD1Re5qOmV36PXF0husKUvE1NpJWf9CrHoeC/hTyfzR
 p7dPnr9aFOW1WOJGjHr7+Gz0FOvNf1n1Zb+n/0BX1BQ6ZW2omm8FMOHd0gsZ9MXJDujw
 Uqq5fCWnXdHuZiwJulRAVSi33esOo19KVU7VKCO9C/xHq/xOk5tHESWN+4zbnMeEJ3hI
 nwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696154445; x=1696759245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+bVqx+CdOHpztM75DI/HJNX+PVb40Ib+4lfVw0jaCwU=;
 b=Ou5yg9yts+5u8ZIvS/xglihZookpvegYBWvLDDTz+FoowqbPLEIiXfhHfuizUN5kFW
 +ISQ/Ul/DU+HWy+6R5Mzu0N4umAgBZ8LNoWsYkIkQtscd7AhJETvxVo+jTTyLF6ljHlr
 CwzXohR6uPL1VHFBpijNx6efhqmC9mv9QuJyPIJ+AtYC/vZvjg9QO05b+aY+zDiJSyWR
 otP/xwTenOPgzOAqnm3+6+wTqM7RwZP3id5uSP/bCaxBUOW7a1/Nn8GSZj4WlqAoma3R
 YetxIZp3Dpf22qF3067eNbUCiUygzKNZpoNgiwHkvkRXAHXkfT/317ine4G3j6BfZTZ6
 i0WQ==
X-Gm-Message-State: AOJu0YxBdmXqMCwpcQBXZUMEWiaYDXxK4b1UVNucr89FCx8OeVevWtwq
 AgD+6Rk5HOtztLLZtROPIzXKkI7UFfsRw2jn
X-Google-Smtp-Source: AGHT+IF6jagrTASIjdwSntF/7BBYxTxKzwWbmSTRty/mo0kAcPNYzQYyqJAgMnhUXpBsymJ7zlebYw==
X-Received: by 2002:adf:f001:0:b0:31d:c3d2:4300 with SMTP id
 j1-20020adff001000000b0031dc3d24300mr7255650wro.71.1696154444556; 
 Sun, 01 Oct 2023 03:00:44 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b00326f5d0ce0asm3087135wrw.21.2023.10.01.03.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 03:00:44 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, Y.Moog@phytec.de,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v4 0/8] Port gen_compile_commands.py from Linux to U-Boot 
Date: Sun,  1 Oct 2023 12:00:28 +0200
Message-ID: <20231001100036.34936-1-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Hello U-Boot community,

I'm submitting a patch series that ports the gen_compile_commands.py
script from the Linux kernel's sources to U-Boot. This script, originally
located in scripts/clang-tools/gen_compile_commands.py, enables the
generation of compile_commands.json file for improved code navigation
and analysis. The series consists of the initial script import, the
necessary modifications for U-Boot compatibility, and finally some
documentation.

Your feedback on these contributions would be greatly appreciated.

Best regards,

Changes in v4:
- Replace "Options" section in the doc by "Usage", as it is simply a reference
  to the script's usage message
- Replace 'kernel' by 'U-Boot' in the usage message
- Replace label by :doc: link
- Instead of adding a chapter about integration with IDEs into
  doc/build/tools.rst, add a new file (i.e., doc/develop/ide_integration.rst)
- Replace the doc's heading (gen_compile_commands) by 'Create build database for
  IDEs'
- Add a section listing some of the compatible IDEs and how to set them up
Changes in v3:
- Add documentation to index and fix syntax issues
- Add reference to documentation in doc/build/tools
Changes in v2:
- Add compile_commands.json to gitignore
- Add documentation

Joao Marcos Costa (8):
  scripts: Port Linux's gen_compile_commands.py to U-Boot
  scripts/gen_compile_commands.py: adapt _LINE_PATTERN
  scripts/gen_compile_commands.py: fix docstring
  scripts/gen_compile_commands.py: add acknowledgments
  .gitignore: add compile_commands.json
  doc: add documentation for gen_compile_commands.py
  doc: add ide_integration.rst to doc/develop
  scripts/gen_compile_commands: fix usage message

 .gitignore                         |   3 +
 doc/build/gen_compile_commands.rst |  84 +++++++++++
 doc/build/index.rst                |   1 +
 doc/develop/ide_integration.rst    |  13 ++
 doc/develop/index.rst              |   1 +
 scripts/gen_compile_commands.py    | 230 +++++++++++++++++++++++++++++
 6 files changed, 332 insertions(+)
 create mode 100644 doc/build/gen_compile_commands.rst
 create mode 100644 doc/develop/ide_integration.rst
 create mode 100755 scripts/gen_compile_commands.py

-- 
2.41.0

