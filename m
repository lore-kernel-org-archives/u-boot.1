Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56166EE49A5
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 19:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82015869B4;
	Sun, 20 Aug 2023 21:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P/rNHdp8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD558684C; Sun, 20 Aug 2023 21:04:21 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BB37869C5
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 21:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fee87dd2a4so8694225e9.3
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 12:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692558258; x=1693163058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YhJyu3E4aRSXDx1+u9swKY+5fU0aWIBOMPEw+r6uwnI=;
 b=P/rNHdp8g9tnoh1Kd2SklN7YowTxNX2M6WJLL1iYEIGWxUJ17KKi1WUNLR8Xpo5bp5
 JYjXDVof6L6W6PsXEtKp0d9/mdHd/jeEa2MHavAF65y67XFrrauwcpGVdrFJPhvvl6SW
 CMahM/KMU4Ot/WkNAL/aD9nK8TDWBedrr93QSGc71RpuqEmSor6ROmhQ+6X5l8JiRjwI
 Mc08lSw7UgyxIawjQQZi3isMbAbokvxRK1EPmSVUkNrhUWNvKbLFo8kusLaWwjl74V+r
 fGBiFSm7PL+QvmyCfSZ7iJPe3R9i3iv0WOP28/MgJAkluPyKjhIakjDkuyhNFYQnv0E0
 n40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692558258; x=1693163058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YhJyu3E4aRSXDx1+u9swKY+5fU0aWIBOMPEw+r6uwnI=;
 b=jvjYD2rCOeLP60bVNsYBzoCKzMKc3Cw1RFoPgdsQhT+kH32WbZ4azynStjqFaNsFhV
 kJpsbWoxW0xq/qe0XdcxZav0UZWz2BgLGdVTHfSLcjpi2vg11/jMtQhUkeUXPnjNKvbi
 cPouQ+leIeovPqR/lcQ3IBiu8TbSPLLnNaTuAWeyb2VK1DzetpbEbawOmFle4sCAKcAn
 f2d1RO4ZqKTALCyQkdK556xdQHskPvkib4JW1ucSOZQc5wgE1ZOOQYPEbUPZSgb+7a9B
 lemgWVoPf8mqLRF1SscdnX8dgJTUXJfKT9GVH6EcHACrZN3rD6BcROpaOGIfi/l0J2AC
 JWkA==
X-Gm-Message-State: AOJu0Yzqk3s1/RVkt6MP75qUKZki6ak9ykrU6YmajTA9Jp35vfgc2j7R
 e8/zBWELjmfLF9W5gDABSZrj3iRB6dxWPKAy
X-Google-Smtp-Source: AGHT+IEGhtwKCYZm9NLMJmZuIzQB7wOLTK1JkzZuk2ZCnK4SdsTb2utWqL6wnr4ToiTkdSFDMl2Z+A==
X-Received: by 2002:a05:600c:208:b0:3fe:dcd0:2e0e with SMTP id
 8-20020a05600c020800b003fedcd02e0emr3692452wmi.1.1692558258195; 
 Sun, 20 Aug 2023 12:04:18 -0700 (PDT)
Received: from fedora.. (cust-west-pareq2-46-193-56-152.wb.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fed78b03b4sm8253797wmc.20.2023.08.20.12.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 12:04:17 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v1 0/4] Port gen_compile_commands.py from Linux to U-Boot 
Date: Sun, 20 Aug 2023 21:04:08 +0200
Message-ID: <20230820190412.21266-1-jmcosta944@gmail.com>
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
generation of compile_commands.json files for improved code navigation
and analysis. The series consists of four patches: the initial script
import and the necessary modifications for U-Boot compatibility.

Your feedback on these contributions would be greatly appreciated.

Best regards,

Joao Marcos Costa (4):
  scripts: Port Linux's gen_compile_commands.py to U-Boot
  scripts/gen_compile_commands.py: adapt _LINE_PATTERN
  scripts/gen_compile_commands.py: fix docstring
  scripts/gen_compile_commands.py: add acknowledgments

 scripts/gen_compile_commands.py | 229 ++++++++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)
 create mode 100755 scripts/gen_compile_commands.py

-- 
2.41.0

