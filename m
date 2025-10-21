Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED41CCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 18:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A58802C1;
	Tue, 21 Oct 2025 20:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="loNJ3Tct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAD5E807C0; Tue, 21 Oct 2025 20:17:19 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4967380107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 20:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-87de60d0e3eso22751986d6.3
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761070635; x=1761675435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z5kVEHBkHIHYlDByejC1sJHPm6rvS0/1XjbMBx41jaU=;
 b=loNJ3TctIV5hR4UvS+93gtbcPCgpnkU88vQ4Z2O2pH8rXcF+7F5b7BTAJ4iKlgQmxO
 fLp2e04o89kpmL8TzUMy17PVioT8NJ1/NIokzwADHgmQZ/cQ8ykjOmBMvqS7Yt5exkrb
 zYLwQSSe1hIoq5yYF9QUehdg9qcj2NWlwMV071NVt7SVIlSEcJMS3q/AWzfSGG5V308k
 tv3RReG8fAI7nQgAjtamb9u+eqykb6zEO20gvPfumhNfD023mvYNVcFZYuEtwOZsNVmQ
 1BXkjUbdIhuY5n/kF1Q8XAJtvHK5CPr2wUmNkzynFVyJpNzNVuJsNQECUdd5lDijvzK0
 loAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761070635; x=1761675435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z5kVEHBkHIHYlDByejC1sJHPm6rvS0/1XjbMBx41jaU=;
 b=kc2+2IzBErh+Lqs6NyisSvpMR8WCtUkbwwtIEq6113AReOIzhjxLQ/4bXgzOfK1ASS
 KmYrokc8ZfivtDvOrT05x1r9quAIkQ1FbdIInmbFwRh9BI1jdDoCb53/e+RpjL3NZvgc
 gFHX28gc0rDltSxnsBpCw15Sf90cKUP+HHnVUFN7vzQlN6agIrmwYHbTPceI5stEgZ1t
 O1W8xONaqv3AzL6qCVGQTXt25Zi6uj6znJVHdtan2a5327HLoqO5qCVVN387t2KlpTyl
 hpdEaMorSe/V8I1aBU0XXztjx+2p2sTfsRFPgN5xugBYHUC4u5ERgLBkBMPOcgcjiuDb
 0WeA==
X-Gm-Message-State: AOJu0YwwfHrl03FwO4v5DNvqQ9Mi7pXpjLCHduZOWjoTQe/k8ETWvZ8F
 j4bTdbx9RC0HgnCFaa60XSaMgVfu+5V6a/fOOYo/0dUHbvBzTl1x4ditCIQxg6pNMmsogoVJXJw
 eF1eg
X-Gm-Gg: ASbGncs1uhGGOoizubI+Tvr9xCiDUQ23VLZwBFGTrua9Svcc+9rMNGulL/aqrdvGAZ7
 wyOnhlNUxqLjx+zDfYf0XPPq3RgdONwz9fxwfNQh7vBnPjWmXENbGTL3tfbNlZoZ0Nm63g7hR7C
 MRsOPewejPdk31R0fTrYdFeqfCQEvyEDQBDIpGX+0YIzJ28yU6E7c2EEKnLmF3PhsQ4wbm6RNkg
 1Ye+wqbQgpTGev2Jmthfwbpu/uFZhI4nSZjLh/Cnp0oSCe7/FnA2Akq5P/9N9jYCOlTPKYHKUH5
 MU71mBQ079QTCvbS+YgGPOpj1Jl1Cgqoo0gnXcCB9qOM5fZQOZASkNZAc42tVN5IzQHQb/CL54w
 c4xd/r+Smm28htlg5INrreEFeBhQxzUxeYtNMSv1aUNrA2A3u4ylCaH6mlzew8yV0ZnOh6ol40G
 COJst8gbVCPsFNrBHB6sMRwtYP00K+6kaRnNiwEw==
X-Google-Smtp-Source: AGHT+IGWVYM/cDsE22l/YswislJ/fYnv8aDFaiJQb5iFO/wfcf/DNwoTfHnPnDmetvkSFlJCQyJcjg==
X-Received: by 2002:a0c:e010:0:b0:87c:21db:cbbd with SMTP id
 6a1803df08f44-87c21dbcdeemr161898056d6.29.1761070635374; 
 Tue, 21 Oct 2025 11:17:15 -0700 (PDT)
Received: from localhost.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d02884878sm72831526d6.31.2025.10.21.11.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:17:14 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RESEND PATCH v5 0/5] Enable Firmware Handoff CI test on qemu_arm64
Date: Tue, 21 Oct 2025 11:16:53 -0700
Message-Id: <20251021181703.598342-1-raymond.mao@linaro.org>
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

Raymond Mao (5):
  docker: add OP-TEE and TF-A build for testing Firmware Handoff
  pytest: add test script to validate Firmware Handoff
  configs: select CMD_BLOBLIST for Firmware Handoff testing
  ci: check existence of bl1 and fip in the test script
  ci: add test entries for qemu_arm64_tfa_fw_handoff

 .azure-pipelines.yml                   |  18 ++++-
 .gitlab-ci.yml                         |  21 ++++-
 configs/qemu_arm64_defconfig           |   1 +
 doc/develop/pytest/test_fw_handoff.rst |   8 ++
 test/py/tests/test_fw_handoff.py       | 108 +++++++++++++++++++++++++
 tools/docker/Dockerfile                |  40 ++++++++-
 6 files changed, 189 insertions(+), 7 deletions(-)
 create mode 100644 doc/develop/pytest/test_fw_handoff.rst
 create mode 100644 test/py/tests/test_fw_handoff.py

-- 
2.25.1

