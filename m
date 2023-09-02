Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1DCC001DB
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 14:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCEF8644F;
	Sat,  2 Sep 2023 16:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sstfdH/C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E74D186467; Sat,  2 Sep 2023 16:53:18 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E38E8643B
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 16:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c5c06e8bbso2554891f8f.1
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693666395; x=1694271195; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2Xu5siSjrpl5CLNKrjnyqzHgjEZUEXoDH/RPkAhG9+0=;
 b=sstfdH/C1G9fnUK8sir6viq0W+LkPb2I5255hnU9QYzMTK7ETguEwVKdgnuyj2tq5M
 THE7ft53oMu0ztIU/YkDtOigrSN83sR6hyLbNlGkhq5WHZ5gWtyxTSnf7s6FH9Zr+xBc
 6ryvmoq36mITGnk81dHfFj2ehocBJ7tUAYNUWN0ZKCMeUv9xBEKHXj5IqEr3fPqujk6L
 iMVn1PtmlQM8lwnhO6OkC3Ei3GUE6lPJVfmcVuA1pUl42S1qvLuPhB3sw+JVEa9dKnKF
 Ai3eYZ82iPh0a/Qe0YhSqBgomaZl7h4IMbQJQfOUNTp4OaZqHlziLrXTQYId5GhW7K71
 lDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693666395; x=1694271195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Xu5siSjrpl5CLNKrjnyqzHgjEZUEXoDH/RPkAhG9+0=;
 b=TRFp1W/TBN/24+pnZWqQm9yHzq3HXUDvPOyf4dAntcGXUxNU+gU9/o3/g1E6hp14Z2
 8nCXkz3j9EgiL3XxdhRvNwJtxuAdCMMCpOUijkiaW9HxiixLpo16SBG4PfMMiYTaXVtx
 QFevyh2V0/YSWRm1XhXfp5Gkdm4n+rTOeTrOJbo003z1zirE4KVd7aNXQ+74E2Iq8yAg
 r5+4HEufIM/jfaVP4dBiaEUGQZ+k3cwiJZwVIPABot1k/LT4OKL8PYiUD0rSsP79jIoc
 wT3tWH3QrR23vD9cxUhNeE8d8Shs0Hn87rS5XYrJGb7U2qBODPG6ugl2aAnAagronJhR
 P+LA==
X-Gm-Message-State: AOJu0YwV5xVu6D6aURV63a49+I9n0SND2rZ1f8L53YXYYVtCgr7wj/x9
 /ChRhFf38C+k9Eoy/SID7RHyoLDWEoKKfPo1
X-Google-Smtp-Source: AGHT+IH6LnpRVvKryz2KYaD2s4Kt9Zk2bWaH86/2mARIcLwkhjz+7eoFQNuHxg5N4I8EjrAbO7UCPQ==
X-Received: by 2002:a5d:428d:0:b0:319:52a5:569f with SMTP id
 k13-20020a5d428d000000b0031952a5569fmr4111182wrq.11.1693666394939; 
 Sat, 02 Sep 2023 07:53:14 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 cc11-20020a5d5c0b000000b0031f34a395e7sm2385449wrb.45.2023.09.02.07.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 07:53:14 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v3 0/7] Port gen_compile_commands.py from Linux to U-Boot 
Date: Sat,  2 Sep 2023 16:53:03 +0200
Message-ID: <20230902145310.107054-1-jmcosta944@gmail.com>
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

Changes in v3:
- Add documentation to index and fix syntax issues
- Add reference to documentation in doc/build/tools
Changes in v2:
- Add compile_commands.json to gitignore
- Add documentation

Joao Marcos Costa (7):
  scripts: Port Linux's gen_compile_commands.py to U-Boot
  scripts/gen_compile_commands.py: adapt _LINE_PATTERN
  scripts/gen_compile_commands.py: fix docstring
  scripts/gen_compile_commands.py: add acknowledgments
  .gitignore: add compile_commands.json
  doc: add documentation for gen_compile_commands.py
  doc: add new section to build/tools

 .gitignore                         |   3 +
 doc/build/gen_compile_commands.rst |  47 ++++++
 doc/build/index.rst                |   1 +
 doc/build/tools.rst                |  13 ++
 scripts/gen_compile_commands.py    | 230 +++++++++++++++++++++++++++++
 5 files changed, 294 insertions(+)
 create mode 100644 doc/build/gen_compile_commands.rst
 create mode 100755 scripts/gen_compile_commands.py

-- 
2.41.0

