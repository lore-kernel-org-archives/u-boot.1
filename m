Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A836CCD192
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 14:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51ED08313B;
	Wed, 15 Oct 2025 16:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V2p+kPm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6614832BC; Wed, 15 Oct 2025 16:19:08 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8CF5800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-795be3a3644so52853856d6.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760537944; x=1761142744; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NGjUCu4WV2t2gTJdWz5MII0PATxl4FhRtaTawBTSw2M=;
 b=V2p+kPm03jBIx24ECc+N/peqoGYy8QEO6Clkoa1JZU4Y3JR7CpWCjYl8zibjoTDsgU
 KBse/BJLewF6o7Z+W7mReHk/eJhv6v9JMBlpfsSOKPwRnnytM7rs4cv2Xssrz+3d94Cm
 LLP0M6ZE8+VdeRDPtRegM7YzFaAlqkYLDqaWvXxNB6DWAyhKcU2llyN/DzqGtFGD77uv
 H1f4YDrVMtEP5S5kM2Ol/8g7PdRTlQkNkxwuO8nGjQomT2FXDDFXUqByw9wrOUwWozAm
 mN9EaG4bKvoBBCWt8kqAm92TroZLKR8EPm+MIPP2tMDgB62SjJ2armVodjzqxEYyCPKw
 1E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760537944; x=1761142744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NGjUCu4WV2t2gTJdWz5MII0PATxl4FhRtaTawBTSw2M=;
 b=M2lTxW8Ng7LXwwpEZlRHR618t+q2ye/+OCMiQ17CB7sF2BmIY7qnMJGregM9A+K3VU
 0Myc4KGWYcEsHgQKipqxDCxrjStaGPKur5MDNm496QgJZCvbQTRsKRfiPPaMxI1pTyoB
 BBE1+FPJ6D8oyxX9Z1NuuMLmQKxHt0HAR4gWnIJErInubTWsyprISYYrzpzggbeH3usy
 yR5ocBnpQEOq5JmfkpjHxpjrAiWV/QWZzAHWl9MkRZ4tk17ByuRpqFTYHdUt/nfXi8ad
 Qd8bGn4v0iafIMZgFVnBA56XIx0B3Xwpje1d6l8KjCrCwO9Brgz39q7Pv0rmcEDYv7lN
 ngGg==
X-Gm-Message-State: AOJu0YwW/1szMw0DfkB0uXbm/Zvi2OZZbfEQ+iAFqGRb1d0b183MbgSP
 nNw3up3VxDS6pysj5k44LnhVWrhUpA9ctDo72halclfCZAbtTmW+ZIRihhZGv0ty43kPpebMus/
 Phfa3
X-Gm-Gg: ASbGncsLRt42MPg3Ck8SUuvf480saBmEyS9SDaWHQL1xf9d812TUB1eXDNz3C0sdeT5
 DuH9mbzbUPS7GYVjqi2sDnMZ93gOQpF9tpcLc+enYLLGrZyVHx6Yh3p/lpisrO6zzilEr7bIeLV
 akWJij/d7E3BvZjLGWnOYiw7/Lmal1LkMVtfaXbABHjkP6Tj90gDSazXpchy7CN1IytZoxbxo+3
 zQ2evGnYlRqJl6hRJsD7LrijGIwpPnHHdrVKLxdxZLENZgUrBd9pqLnLKYpX5PJ81TIWpp7AahY
 nhNT26G5WiPjaIVa1GenMK40LkiVL3/QWuyLkCNBFVTKbNr1YnFs6ubSqcj63lEBjWtFHtmgBgb
 4dV3xl1Y5UKSsjhfXGBTE7XwCv/kOKVe8za77qSSpxsOWWtNMRx84JR766ScUvc7dRqVr
X-Google-Smtp-Source: AGHT+IEXxY7mqyP6Pe8n4R8hgYk7lcVist65yg4e808LruKx+OIPuVL+KGtU/COWMYw9g2rGsp1RLg==
X-Received: by 2002:a05:6214:2a84:b0:71c:53c0:5674 with SMTP id
 6a1803df08f44-87b20feda87mr405030786d6.7.1760537943857; 
 Wed, 15 Oct 2025 07:19:03 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c0120c20esm19337466d6.5.2025.10.15.07.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:19:03 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 0/6] Enable Firmware Handoff CI test on qemu_arm64
Date: Wed, 15 Oct 2025 07:18:44 -0700
Message-Id: <20251015141856.4168612-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

This patch series enable Firmware Handoff [1] CI tests on qemu_arm64 by:
1. fetch MbedTLS (v3.6), OP-TEE (v4.7.0) and TF-A (v2.13.0);
2. build bl1 and fip with both Firmware Handoff and Measured Boot
   enabled;
3. pytest to validate the Firmware Handoff feature via bloblist by
   checking the existence of expected FDT nodes and TPM events generated
   and handed over from TF-A/OP-TEE.

Pre-requisite u-boot-test-hooks patches [2] are required.
A test pipeline is triggered at [3] with hacking docker image [4] and
test hooks [5].

[1] https://github.com/FirmwareHandoff/firmware_handoff
[2] https://lore.kernel.org/u-boot/20251003191918.767698-1-raymond.mao@linaro.org/T/#t
[3] https://github.com/u-boot/u-boot/pull/818
[4] https://hub.docker.com/repository/docker/raymondmao20200915/uboot-ci/tags/latest/sha256-bff18c1f2488d350e9e6e51c9987e24c36b3bfe110079aa0682964c815dd285a
[5] https://github.com/raymo200915/u-boot-test-hooks/tree/eventlog_handoff_v2

Raymond Mao (6):
  docker: add OP-TEE and TF-A build for testing Firmware Handoff
  pytest: add test script to validate Firmware Handoff
  configs: select CMD_BLOBLIST for Firmware Handoff testing
  ci: check existence of bl1 and fip in the test script
  ci: rename conf.qemu_arm64_na to conf.qemu_arm64
  ci: add test entries for qemu_arm64_tfa_fw_handoff

 .azure-pipelines.yml                   |  20 ++++-
 .gitlab-ci.yml                         |  23 +++++-
 configs/qemu_arm64_defconfig           |   1 +
 doc/develop/pytest/test_fw_handoff.rst |   8 ++
 test/py/tests/test_fw_handoff.py       | 108 +++++++++++++++++++++++++
 tools/docker/Dockerfile                |  38 ++++++++-
 6 files changed, 190 insertions(+), 8 deletions(-)
 create mode 100644 doc/develop/pytest/test_fw_handoff.rst
 create mode 100644 test/py/tests/test_fw_handoff.py

-- 
2.25.1

