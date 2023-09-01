Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73726CA0FF3
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 20:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4371086564;
	Fri,  1 Sep 2023 22:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JgYAFgUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 343998657B; Fri,  1 Sep 2023 22:04:11 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9C8C86177
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 22:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fee8af9cb9so23646225e9.1
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 13:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693598648; x=1694203448; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BAFUvmIzj9ZfpE7E3kcEWrONn2WbA2lYUbZTHV8ZNEM=;
 b=JgYAFgUZ+28VZZ/I4rs6wBWV43bai4E2MU/GH8e7YhKw1aBcTx5pXJSjptsWOzoOUn
 JPr7sGlk0kvBnk99X1t/VaHXvt6fqbpUtjyCVi777tdX9+BUnK5k4KDr93DjrJ96VTNo
 PUfaWVPnNf8B0qiEnrmdkN7XLazY9/ZDl9NvfRWgyIMB9kLy4QwcRpAEs8vDoY0CWHXN
 vkeCm/8p7O0FUlK73vHjnl1JNKhFgamvnyM4NOwqG/WTz9RqzL/RFGjrrT6l2UbGu0IK
 6bRhUd9UO53snUTYCkWlgZCSLZayV1fZ8RDrwlygKQY8K1KhPMJoAiIHXrjZA2Jjcg9a
 +jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693598648; x=1694203448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BAFUvmIzj9ZfpE7E3kcEWrONn2WbA2lYUbZTHV8ZNEM=;
 b=UjmXvy874K0VJxQpUrmxCJBs9IIpYoJduyQmDalgR+ia9Y1Mx5bxMVaJuSm7wW6RN2
 7FhYcfHza5qTQ1rfYDF2Ku9RwVnFCqLevQPY8KzGr2xWI/HTJchmFYtdaookJV1uRSlx
 bu2dq96SL48ca0KnDf6D2ec1GsJrJVXo6gOyG3vW3vcpkEwQ5VwnvL3A9NZoZzED8gk1
 OvV9POi7mhURcZiB4E5/bqiablxXDvgUkstxQ8RraFWaMaygdWQ8vESUaSzQc21cOhjw
 jdtcfBih5plK07EWJkDOg1c1MiFSWvWDIRHcuUSQM1ofpHB93AL/r62gEgKL1qWSEN9I
 wKAg==
X-Gm-Message-State: AOJu0YxaNXclJYsunxo9V0kTiLHiWQUVyDAVyfM7t9Wr9bozsA+ftOsm
 Ur5Gzw9cxKM38td7HsSQJippjcD6zf0miE6p
X-Google-Smtp-Source: AGHT+IHBlsLji3SLeUzeiUXefX57sV/7Mr/No0rlBfL/+/CkEwRc/6Y92tn+MM/Tv9+K6FjYk4o53Q==
X-Received: by 2002:a7b:c45a:0:b0:401:b0f2:88cb with SMTP id
 l26-20020a7bc45a000000b00401b0f288cbmr2400073wmi.31.1693598647311; 
 Fri, 01 Sep 2023 13:04:07 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 l4-20020adffe84000000b003176eab8868sm6207849wrr.82.2023.09.01.13.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:04:06 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v2 0/6] Port gen_compile_commands.py from Linux to U-Boot 
Date: Fri,  1 Sep 2023 22:03:47 +0200
Message-ID: <20230901200353.90290-1-jmcosta944@gmail.com>
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
and analysis. The series consists of six patches: the initial script
import and the necessary modifications for U-Boot compatibility.

Your feedback on these contributions would be greatly appreciated.

Best regards,

Changes in v2:
- Add compile_commands.json to gitignore
- Add documentation

Joao Marcos Costa (6):
  scripts: Port Linux's gen_compile_commands.py to U-Boot
  scripts/gen_compile_commands.py: adapt _LINE_PATTERN
  scripts/gen_compile_commands.py: fix docstring
  scripts/gen_compile_commands.py: add acknowledgments
  .gitignore: add compile_commands.json
  doc: add documentation for gen_compile_commands.py

 .gitignore                           |   3 +
 doc/develop/gen_compile_commands.rst |  46 ++++++
 scripts/gen_compile_commands.py      | 230 +++++++++++++++++++++++++++
 3 files changed, 279 insertions(+)
 create mode 100644 doc/develop/gen_compile_commands.rst
 create mode 100755 scripts/gen_compile_commands.py

-- 
2.41.0

