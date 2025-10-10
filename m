Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD0BCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89806843C0;
	Fri, 10 Oct 2025 16:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s80cIrZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F758442B; Fri, 10 Oct 2025 16:45:29 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0B6084258
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-79a7d439efbso20695316d6.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760107525; x=1760712325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VfPIon2WWksGSkZvQ+lQ+S/wZ7ZrPEYFZ/SX+Kit2sc=;
 b=s80cIrZgif8ZrNPU7RErPGRhUp8sVChnqM+6aI5rJ80BQVIfRXnVESI+cr7PnLRzQt
 sJrkHnAgfTF5ump7WW0zdBrIA57we3oNB9isSbrhvFv7GIYknGICnBYr5EbJd/e+IXFL
 R01tA4FB3M1tb8zBs1LKOUMYJlien2SkghlVtaUcl+DPh3D1rh0dtcEDpSBQALGTyFKn
 UlshfCHDDJ02WmgKIoZxCQJSR7Kjk+cplicplJpMkRd43rFMtCXvFt/dCDrlFTrHGf2w
 dq+GU0hzLHxVxuLTvLyaKmsD3XTAjr6HqVcp1klxME3OZkvxsgGWReiPjYaJDvF6e34S
 6xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107525; x=1760712325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VfPIon2WWksGSkZvQ+lQ+S/wZ7ZrPEYFZ/SX+Kit2sc=;
 b=knkZ1beGFpBKxYbHJyyJu51Z4YfNwUBMBJVq5UYY0bMkMErLFXJn88Lv/eDEuPTMpN
 D3fjFE6WzM7BQlmX4oD4LRq2Zo5WKPTFX2Wnjt5fBBAbaHGowHMfW0I1NukwKi0oUqb7
 z6wdLcU0gyZryzIX5nLHTlax/bgH47efJgrT12s5lZ46RH5yMnX4NpsXUXRodJO5eMOy
 EksFfEeFn8ncwkAijEvM/I39n12zTeQWun139TFvQBexiD6ff4MdtEcP0qa+hx4seAnS
 YPrB5Rq/hZL4vtyMfEocp2Nzq33EmntqC1fzFNW7SbWEU6ndUSYgT83ealYtiaXvzEaD
 zoQw==
X-Gm-Message-State: AOJu0YwEsaeBw83fDOktccFZZzaW1tyZQOpghdD3XhDlavEIf9B5hcw0
 WBCI4QgAZ0IZe+CyY+p+ntKx2lchidsbv0Y2V0VEGng3EzjLAxbd1LSNFNw9AtIc7RxroUUNb8j
 +FuKm
X-Gm-Gg: ASbGncuY3uba+BczO6XpNGSSdJdIHH+mpV9xYi/cHCFEyR35oFuJi6vfBTkEiOo5bU2
 WGhw+5w3YW01tiUrSD4h5SEJStRrDJE7ZIBDuUU0DudojBJz8wXxr1LyGWYIgiwgkqNV7aE2PxN
 HjNjGVoWz/Am40A1TbNC5JaZcbtPrCk0HT6jKxyc4ZQTLEzEFUBRI/r272iZ4ytDv7+V1ybWZk3
 N/GmFP6G24twfnq6B2nQH8fcv+nRVBgemsmz8K8B+9iy2pDHgrtwSTcHXVtGu8JVQ47EWdQVyCv
 D7l2YF9Frfzm+nkIlQo1QZadlD92iGk1uSo1xOxCczPBq9DLl7MD8oCHy57GQ+FDWRsIWVNTSNr
 7+cEWQh1u6yTvjGIwvcf3T7sLOeOeZqNQ7sKX/YNh2twKNaxdbkT9Rp4qoGx7ylS2kLETfbYSmI
 W2vOM=
X-Google-Smtp-Source: AGHT+IFEqrxgWG91Z8WAetulF9gJFUp69GqoCR8VjPyAeqk+kFqxUavM5suayD+C3c8JaiTSyR4bvA==
X-Received: by 2002:a05:6214:21ca:b0:810:e12a:48fd with SMTP id
 6a1803df08f44-87b2104ef39mr180446966d6.7.1760107525208; 
 Fri, 10 Oct 2025 07:45:25 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm17686306d6.17.2025.10.10.07.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:45:24 -0700 (PDT)
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
Subject: [PATCH v3 0/6] Enable Firmware Handoff CI test on qemu_arm64
Date: Fri, 10 Oct 2025 07:45:04 -0700
Message-Id: <20251010144517.3573014-1-raymond.mao@linaro.org>
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
A test pipeline is triggered at [3] with hacking docker image and test
hooks.

[1] https://github.com/FirmwareHandoff/firmware_handoff
[2] https://lore.kernel.org/u-boot/20251003191918.767698-1-raymond.mao@linaro.org/T/#t
[3] https://github.com/u-boot/u-boot/pull/818

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
 tools/docker/Dockerfile                |  44 +++++++++-
 6 files changed, 196 insertions(+), 8 deletions(-)
 create mode 100644 doc/develop/pytest/test_fw_handoff.rst
 create mode 100644 test/py/tests/test_fw_handoff.py

-- 
2.25.1

