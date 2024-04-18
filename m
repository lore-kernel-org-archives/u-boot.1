Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D3CC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 364F8885E0;
	Thu, 18 Apr 2024 19:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="znJR8xeN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 288D8885E5; Thu, 18 Apr 2024 19:14:07 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B480988134
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a519e1b0e2dso108961266b.2
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713460444; x=1714065244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C/LQ4zptVs7VDGrhdxgT99tg9mHYX/KLING+izfgZXQ=;
 b=znJR8xeNVw/ECCKIJwBKgRY9pfpjK4NsT/bKb4XDU3GIOOJa1b/U8vy2fjYnze3Zlk
 BBwLgSnDyX6aEb2aODu2CtoiHFURS3dDaXIPceffLfZLArC5OnKYY3V+CInI0RN5sRPj
 fVaF1I1R3T4kBdsDEx6NF90JYp+rVpnjr/JHViJ+ZvIZvfzyzd6uunsBMl0fRxQ4qMl7
 Di9HX/QfFTRcHe3gStst3lqT0fK5TSLkb73eVhqnkypzCmTSHTZzTT6DrSZHWoQ7TP38
 phKMMcH+eSigU9PQH9HitYNyij8Wmdanrg8Rw6huZXOia4gswv7e5Tk0kEhPZ+x31rF/
 SLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713460444; x=1714065244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C/LQ4zptVs7VDGrhdxgT99tg9mHYX/KLING+izfgZXQ=;
 b=l0pDF8bDFJT2lpAUXhIaZo7lvyH/C6O/9oYoxWu8q/h705l7sPt4QAyHH9JnZOWvi8
 VwQLjfxWsP7IDjZwJvNw6x2IRKHjKzg12Tb5lAxk4cXU0BNU0wPngRf6uIugb+N53xNp
 QNh+ygwv4CuOiP1fUJRiqUISTJ2AO73/eyQOEwk845SJ0I0/RdOG/n231N2QUBQRxp3E
 fHe5WQqLs7jV0tyzl9NTq5ndqCXEwPxQhl8dw4LkMtjkzljtNmNCFjJD+IdRv3TMnFzC
 ffnzV+fhuBS9m8usliepP/xLPKOwy7kpq4l2r3y/2MFX4zguv58u210SBLBo6Gx2J9bn
 ix4A==
X-Gm-Message-State: AOJu0YyeeMtsODhR0d6dMm4+8+k8FL7HFzPu9lewqTcTza6Ie9FIMb3l
 t2Hh8HC4aibbfnnTh38nhsrddwbPR0BDndP53UknI8HYPBwqSTPh4+DZx9DPBhaXxBrSsMUULYp
 Qzgk=
X-Google-Smtp-Source: AGHT+IEkrm70m2qi2Jvd4/okWjMXY7H0q68JHOGAT5yeeLRPEYk2fVFy8m2+KGEuvixx93iRx9Vo9A==
X-Received: by 2002:a17:907:1ca2:b0:a52:56e7:e9c0 with SMTP id
 nb34-20020a1709071ca200b00a5256e7e9c0mr2700637ejc.7.1713460444098; 
 Thu, 18 Apr 2024 10:14:04 -0700 (PDT)
Received: from localhost.localdomain (ppp176092141112.access.hol.gr.
 [176.92.141.112]) by smtp.gmail.com with ESMTPSA id
 gf26-20020a170906e21a00b00a51b3c951b6sm1132821ejb.191.2024.04.18.10.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:14:03 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: igor.opaniuk@gmail.com
Subject: Pull request for tpm-master-18042024
Date: Thu, 18 Apr 2024 20:14:01 +0300
Message-ID: <20240418171401.4742-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

OP-TEE fixes only on this PR, no TPM related ones.

The following changes since commit 2c3fa4b8add3cb6a440184ab67debc6867d383c0:

  sandbox: don't call os_close with invalid file descriptor (2024-04-17 17:06:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-18042024

for you to fetch changes up to b905599b36e3d8158c5cd045c26278416909b422:

  tee: remove common.h inclusion (2024-04-18 16:04:48 +0300)

Igor says:
"The problem initially was in the TEE sandbox driver implementation
 (drivers/tee/sandbox.c) and it's limitations, which doesn't
 permit to have multiple simultaneous sessions with different TAs.
 This is what actually happened in this CI run [1], firstly "optee_rpmb"
 cmd was executed (and after execution we had one session open), and
 then "scp03", which also makes calls to OP-TEE, however it fails
 in sandbox_tee_open_session() because of this check:

 if (state->ta) {
     printf("A session is already open\n");
     return -EBUSY;
 }

 I had two ways in mind to address that:
 1. Close a session on each optee_rpmb cmd invocation.
 I don't see any reason to keep this session open, as obviously
 there is no other mechanism (tbh, I don't know if DM calls ".remove" for active
 devices) to close it automatically before handing over control to
 Linux kernel. As a result we might end up with some orphaned sessions
 registered in OP-TEE OS core (obvious resource leak).
 2. Extend TEE sandbox driver, add support for multiple
 simultaneous sessions just to handle the case.

 I've chosen the first approach, as IMO it was "kill two birds with one stone",
 I could address resource leak in OP-TEE and bypass limitations of
 TEE sandbox driver."

Link: https://lore.kernel.org/u-boot/CAByghJZVRbnFUwJdgU534tvGA+DX2pArf0i7ySik=BrXgADe3Q@mail.gmail.com/

The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/20414
showed no problems

Please pull
/Ilias

----------------------------------------------------------------
optee fixes and cleanups
----------------------------------------------------------------
Igor Opaniuk (5):
      tee: optee: fix description in Kconfig
      cmd: optee_rpmb: close tee session
      cmd: optee_rpmb: build cmd for sandbox
      test: py: add optee_rpmb tests
      tee: remove common.h inclusion

 cmd/Kconfig                        |  4 +++-
 cmd/optee_rpmb.c                   | 23 +++++++++++++++++------
 drivers/tee/broadcom/chimp_optee.c |  3 ++-
 drivers/tee/optee/Kconfig          |  2 +-
 drivers/tee/optee/core.c           |  1 -
 drivers/tee/optee/i2c.c            |  1 -
 drivers/tee/optee/rpmb.c           |  1 -
 drivers/tee/optee/supplicant.c     |  2 +-
 drivers/tee/sandbox.c              |  2 +-
 drivers/tee/tee-uclass.c           |  1 -
 test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
 11 files changed, 45 insertions(+), 15 deletions(-)
 create mode 100644 test/py/tests/test_optee_rpmb.py
