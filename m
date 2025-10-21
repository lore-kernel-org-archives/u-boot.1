Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE33CCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 15:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5335180107;
	Tue, 21 Oct 2025 17:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OsxULi8h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16260807C0; Tue, 21 Oct 2025 17:34:53 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E56800D7
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 17:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-890521c116fso703148985a.3
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761060889; x=1761665689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HKTd4RsLw5hQak8/LdjkrGMmCq2Dc8Qt5tWqIIcoTR8=;
 b=OsxULi8hTamDrVlqyIbsJeR1qh8Xi/hxVdBsrOsW79EVveTedzoZAk87hxLNzR3zme
 FF3VdCUY4YbzfUoyeXWG0MpppJmsFx19RwiRB1iS9zBO9Xo85e2jCCJA/QD68bbVm2Eu
 4yigbWFPrMtWrBx3pD5xKULwK8Bcxqn4AEBUwOYaw6jbQdJHl98nz3AaOWELhnoWfBNh
 4z1RdqhmRRu6lekoGwRb1l533O95d7RQYK16ZlBmO4ZkgtULNRtzwvOaQ6OLRi0Gb7Bs
 Hek+xyCCeKZTwO8zIEKEIG4twfyj2Vk8CRQfWM9qWtr2F+OFrfAXOwZ3evzUlXFheAwW
 2PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761060889; x=1761665689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HKTd4RsLw5hQak8/LdjkrGMmCq2Dc8Qt5tWqIIcoTR8=;
 b=FDQr2QY8AGqjU9dskpa05XBcZ0zH+xAM64Zp8yfn7QDw6V8SrsoB3uxFaTeIKDyqdi
 kodXX//rD6hteW4N6phLuiTAb+JuSCi6w0fQsU0Wm+IUzAOMPFgMK1+W8oUIXpzdr/10
 egBKQt2ewVXFBhxS5TzR9RVIEwaQ2GaDT+9LgM9onk3TVckDIyYp5MIOyNUPMd0LA9/B
 +Ta/p+AS18gvRuzEfuGEVL0pDamxBNioZQxf76LmWXzA4LIaWk8kXyz207Dm1JCyW7e5
 qw7BWDuVsrY/5RyNI7Ky60Z6FA+A8gjlNgl7XMfuT+IklyC1Hsb2EBeE871eO8zDoyoc
 IUdA==
X-Gm-Message-State: AOJu0Yz08mTvPjUZkUQ8d2Z9oxx2RROXx1NbX6T9drviaV9x15etC6vF
 wco43giAGTZkTraDG4hsu4oGhOBdj6UqpA2Hvbj1LwLbWUYrmYKgE71zyiIRKY8WLHQp72vT6eB
 vFL9i
X-Gm-Gg: ASbGncvO1OhsOmzO5z0Jnk8ahGelF9Bj5enYaXsRrRFbAgLKml6vvyGMOuekwyMQPmy
 QCDoY2h+CtJLKyBjS2tLwBKB+9ZuoycfcxEkRH6bxp4v/8jUCwduepHpO7o/Y3iLYccSUJ75cul
 di3gwPMsBHYeADXrk5PulivEhm2oi538NsbFfHZOYr/dhDOPtm+bA2QNIfZWD92gPjywthPRJPt
 zV7tlLBTeFVrgHwM6S0jzUViHnv0Or/A6HSx8lrj3Ley2LiY6U7RQpA/4/rQl64kJA2LrG03bp9
 wUVVFfMzdJpb1xrjL5I1sRNf+WVEMz6yG31HCuDXSjN6/epAfNKDMDb8Xl6CAk0Ed6vXrwrZsyP
 CMvh9qMi3NpHqO4Fz4Crhe+aLU0b6xt2myB0jPt8JkaAyMVbnqOMVpm5PyQNL25jv1dpRiA5OZM
 cVaeLzIuJY/+oLNnJ22STfSlM3KbY=
X-Google-Smtp-Source: AGHT+IHLbyp9hj9D493FQG0/jfc8YDF01TXVneXJ1HBa00E5ZKJJbCGv63/CjD/YRaGpHd4d1FJ48Q==
X-Received: by 2002:a05:620a:408a:b0:892:a186:6b43 with SMTP id
 af79cd13be357-892a1866d96mr1113467885a.80.1761060888967; 
 Tue, 21 Oct 2025 08:34:48 -0700 (PDT)
Received: from localhost.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cf58e7bfsm777910085a.50.2025.10.21.08.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:34:48 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v5 0/5] Enable Firmware Handoff CI test on qemu_arm64
Date: Tue, 21 Oct 2025 08:34:32 -0700
Message-Id: <20251021153443.219326-1-raymond.mao@linaro.org>
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
 tools/docker/Dockerfile                |  38 ++++++++-
 6 files changed, 187 insertions(+), 7 deletions(-)
 create mode 100644 doc/develop/pytest/test_fw_handoff.rst
 create mode 100644 test/py/tests/test_fw_handoff.py

-- 
2.25.1

