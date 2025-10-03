Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35470CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 19:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B479183826;
	Fri,  3 Oct 2025 21:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iwVZOFot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 173A383855; Fri,  3 Oct 2025 21:22:43 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4B28381D
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 21:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-938de0df471so211994639f.2
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759519359; x=1760124159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vYndtdyOjagLbHpYpDRX8NDxbvSojibwIfZSDUMT8JQ=;
 b=iwVZOFotC4mpHTSYpN1+gqGalXf+DxUoK3ozDmE7AQDX41LTB1Xuf6TrmGLfgyqlIV
 NHc6CD3cgazUCU+/2MF0NSNTUXNVbBZNaazq3ohAwLNj+G1Ze7l64XpHZ2pf+kxFGBFy
 sBeJBC8dsoOfQEQgG8D5tXHR3F43qdWjyGQKh0M4qSQNA2qubxPfTmb2g9XV+0KqFVoS
 Z125nnptzoWLGaM30rAkhTxYIcbnp0nf5CPA7ORSEpLJs0wzTU0Qu0JAgdmvCTov0w3K
 E9JU1aCfdfx4g/5dh+/frpu/V4mrn13nYxxGH/Bt7jh+bhGLJ4IWcIN7YhTgr8oEGriH
 BQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759519359; x=1760124159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vYndtdyOjagLbHpYpDRX8NDxbvSojibwIfZSDUMT8JQ=;
 b=HQsv4B0UYipb7aMgJxYa7SaHsXYiHRkKSRdtoG2389vmG4T71eQ+gzp3qFP/5Bea4L
 tyoeRUTo3PGOM57K7QIwu3M4HQW2+VyS9LjA0G3md/yiBW+jAAcXp2DLhuQpv7p94lkN
 WEK+dTOuHs5xEgXQxNeMv5gQLksVEVVfUGRhPeVsoboLiE9eT0vXqWzNQtsHhKiL39G3
 rIa1vdFAvLZFmgU2FGf/xq3DVZ8cMv4jPm5suD9MJOZBNSk2KxehA/Y0sBxen3hwKBaS
 5jE0PpbDmUs2hfwYGcLre+r6XolX1EvyTBQtn+yXRZb7MhmVCRHWz/a1kf/huS9tCPvY
 Uu3w==
X-Gm-Message-State: AOJu0Yx7SxXoXVSxM8evF+lFE2o99u9iN12d+yzkxMEfFgO8JRVm7GmU
 Dm75JPT4bbkfpgLvdycwknnKTn3yYvcJ7wTDNbJsyoku2/NDCyh5SLGxLt/yGsCnM9CjonhTcwI
 lhgFh
X-Gm-Gg: ASbGncuJJHwmL1n/tL0eJ1LqhnojVPHOVD0LaFKS+FmxQnd7AJN0R8FIJjcUQSQ1OKY
 /WXZUs3vZbQtsMXKqNOTFO1BEHiBf5wiCwwAk/sVSezX0xd8Vt7IgkdhHzbDpyE/RUeQ6b6AfU2
 IoJHU3a75XtYnYbusBS2tudYNKimp8FHcKL5F2J/MlSZUEAUsSqpwXtBzNh0ubGCIKuTqhlBpFU
 9qLzGoX+Ii+dvZ7fahvP9ddhX0t8r3Pc/CxT4MptyYCejKQ4OmOyhPBYQ6lXoiK9xW9rQQwTv2G
 STs0Et+uxE3TD5b0OmlxliniGOZ7ontDfvGKJ0v/tjrMRfNwVA16qkCqIZqv1+/KZdVpcoRQLFq
 RkAZgORWJ5bVmprlI+szHkpFg1E/o6WOd7audEmuFUiC7Kgwu5xpIs8KHPiDGnxohNa5fQNPfxw
 ==
X-Google-Smtp-Source: AGHT+IFEMpZe22/iFaxHzagCB4X4/V9BvWGHb/iH5kBcJ6UP4QEZreECDVFxzPv6QT+QipZHBiZ21w==
X-Received: by 2002:a05:6602:640e:b0:938:6d80:960e with SMTP id
 ca18e2360f4ac-93b96ac2844mr555925639f.17.1759519359048; 
 Fri, 03 Oct 2025 12:22:39 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a7d81bf16sm208975239f.4.2025.10.03.12.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 12:22:38 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v2 0/5] Enable Firmware Handoff CI test on qemu_arm64
Date: Fri,  3 Oct 2025 12:22:14 -0700
Message-Id: <20251003192222.767882-1-raymond.mao@linaro.org>
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

[1] https://github.com/FirmwareHandoff/firmware_handoff
[2] https://lore.kernel.org/u-boot/20251003191918.767698-1-raymond.mao@linaro.org/T/#t

Raymond Mao (5):
  docker: add OP-TEE and TF-A build for testing Firmware Handoff
  pytest: add test script to validate Firmware Handoff
  configs: select CMD_BLOBLIST for Firmware Handoff testing
  ci: check existence of bl1 and fip in the test script
  ci: add test entries for qemu_arm64_tfa_fw_handoff

 .azure-pipelines.yml             |  18 +++++-
 .gitlab-ci.yml                   |  21 +++++-
 configs/qemu_arm64_defconfig     |   1 +
 test/py/tests/test_fw_handoff.py | 108 +++++++++++++++++++++++++++++++
 tools/docker/Dockerfile          |  74 ++++++++++++++++++++-
 5 files changed, 215 insertions(+), 7 deletions(-)
 create mode 100644 test/py/tests/test_fw_handoff.py

-- 
2.25.1

