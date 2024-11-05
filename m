Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D60D2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F430891DB;
	Tue,  5 Nov 2024 17:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Aoz+ilu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE72F891D0; Tue,  5 Nov 2024 17:07:47 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B054A891A6
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:07:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-83aacecc8efso186819039f.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730822864; x=1731427664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=50oBfzhFKAiQ8EY0OEIrH+zLVdhNb6Lz5Cog2IUp8Nk=;
 b=Aoz+ilu6nFMYMMoUlfUMetMdtkUNPw/+MGLwsVeUqrvjXyuaavbI53jpBvjKidn85j
 6DmtHdxGJQ+0bCM1VdoX6HIW+tX9lqZ7P26x8x8CePm5H9pxkr1TJlHGTnsw76A+w/+t
 /ekpspzumPEWtsMEUFi7v62XNp2GnToBTva6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822864; x=1731427664;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=50oBfzhFKAiQ8EY0OEIrH+zLVdhNb6Lz5Cog2IUp8Nk=;
 b=DQk1b4MlR3Va17J4DVefgk/VZyO9rlckJvpT8y8AcfEJxkoerxGGfbYdJzKn9fJuE5
 QNU0Xd4j9m5HagZSFU0v+RZmk6gbQ/am5eSNq7TOA7dhJ143PSimo7F4RAu+RHqFmM8J
 nbLVP76D4Hfdu2mgmHO5IkoVOYQ9yMaMd5kJdGupSv3+2cprNv9MMJuVuus6RraagYy9
 eOQjmRIenGLktaDSvtOPWInXqA96lzBsNacKvTs4Mi7ZbbVrCnNkM+7KFk9UBGD18z77
 EqkvEkvscFzqGfczb6r2Ni6uQKoKiyp0MNZgrbdiXoH3MBEmPOI2xESRU0h7gCoFeWAt
 t9lQ==
X-Gm-Message-State: AOJu0Yx2ntXqdxDwB5qegNRiwHrzoKgdloWxqanDSAcBCkZQpBfdWUal
 l6+iwoT/uCtWiS/BmP40Yct6hwttCa38C2fU1uCeBMXW7YvYvJwOgktfzaWDnE/zE3goRvc36rQ
 =
X-Google-Smtp-Source: AGHT+IF4GSCRbnpT04rxfJ9c3iInXBimg3J2NTanX8PYyv/40DK93se59rH6a6TWftZBwXhyl4bSpw==
X-Received: by 2002:a05:6e02:2168:b0:3a6:c6d1:8c4b with SMTP id
 e9e14a558f8ab-3a6c6d18d07mr91369575ab.3.1730822863845; 
 Tue, 05 Nov 2024 08:07:43 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a99ccbf5sm29640285ab.44.2024.11.05.08.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:07:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 0/9] CI: Set up for an arm64 runner
Date: Tue,  5 Nov 2024 09:07:29 -0700
Message-Id: <20241105160738.3795497-1-sjg@chromium.org>
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

All gitlab runners are currently amd64 machines. This series attempts to
create a docker image which can also support arm64 so that sandbox tests
can be run on it.

Changes in v2:
- Drop message about EFI_LOADER
- Use '\0' instead of 0
- Update docs also
- Add comments to the ARG variables
- Swap order so that amd64 is the exception
- Expand commit-message to show the problem

Simon Glass (9):
  sandbox: efi_loader: Correct use of addresses as pointers
  test: Adjust print_ut test to use unsigned char
  docker: Support building for multiple architectures
  docker: Adjust packages for arm64
  docker: Drop grub for arm64
  docker: Drop tracing for arm64
  docker: Drop coreboot for arm64
  docker: Fix LegacyKeyValueFormat warning with PYTHONPATH
  CI: Add platform variable

 .gitlab-ci.yml                        |  1 +
 arch/sandbox/cpu/cache.c              |  8 ++++-
 doc/build/docker.rst                  | 16 ++++++++--
 drivers/remoteproc/rproc-elf-loader.c | 18 ++++++-----
 lib/efi_loader/efi_image_loader.c     |  3 +-
 test/print_ut.c                       |  8 ++---
 tools/docker/Dockerfile               | 45 ++++++++++++++++++++-------
 7 files changed, 71 insertions(+), 28 deletions(-)

-- 
2.34.1

