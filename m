Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A33CCAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 16:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9779A8318E;
	Tue, 16 Sep 2025 18:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gD3/xl4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2409D8318E; Tue, 16 Sep 2025 18:14:37 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1050183071
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 18:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-417661ecc5eso28259925ab.0
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758039272; x=1758644072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/yXX4/1EriHYweiFeFODNrJK+VPks5IcwDUDyX2/5nc=;
 b=gD3/xl4SN0iQ1wqYwsTIbv1UlOexTcFYnFNc3NT99/SnOlXwUTdDO0yWS7k1oTg4gy
 vGQMStnRjRW0eEkTuCwTJUejdy6PJvNGkKWe8HiUcsWERpA7xrd/XuDvaSZ9qDey41Ab
 /jA9Lo+FczqmF6VkOCeTOsji6rrFee87PYEqTvBTc9fBuRMEU1E1dVqIP0fieaP23ZRG
 Y9aBbxtEWEWMzqSbabnhfNRm17ysc+MNrnUrhz0JjkKi9SAYqLsIVjPdSVl6v5J9Q/dh
 HjDpQFq8Z+krf89U8/1tq9G0LcTaFjbKVmTSJ263XiGqUQmCOrhoiXAqhJdGMOJJVZTP
 POnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758039272; x=1758644072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/yXX4/1EriHYweiFeFODNrJK+VPks5IcwDUDyX2/5nc=;
 b=JZpJo+xMpvf6iN1lBk5Vn2Uqexg1TZvW8XMVbZpgm/K0jDLSna+4CJ0q930UrPgCGH
 7CHneJUE8E/DIgaI6EjoomwXsLkIzSO+LPrYPJWPJit9UGrC31I8SjVxRheHJgFS6Ep/
 +pzFgt1bDmQJmlh2exAERfcOE9/dO+MnPK1Ko5zHJrSPebYIECPCVXPc4W3OP/8mOXsQ
 ColM0eVjYBcqLMOOipYyDsj9sh+C5IR6jhejYkmIbqAcWuTWQrlUcDDtKCodoDmKWjc5
 H/7Uvs6ni2h2lLPNfl2nIN4q1vFtPPE0VAKg8+W7Lll1BWL4i03eGwk305mCFRaP7HKZ
 Q+Ew==
X-Gm-Message-State: AOJu0YxSh3GO0uIiX+xzLmxIq++KpzGWNjN+6oq2Kp6fMJ9RqIOX1fus
 O1ETwo73eTdOzBBdMAWTgDg3ZfYWlZ7Mpv+9/pNmUO2itmhoG7k8XlC2tzAZfwMC/E9g9rX9boi
 /Xq7X
X-Gm-Gg: ASbGncvh58XeEfs1zJxLDCu8e7BIiGG1V02jOVUPUBjZlsdpUZYgxsnrMoOYLUeAFIH
 dUGj5KUjtE9rJzHk6PNOzqxYKx1G+13NDWRT1ShFqNAn2U+uHTOEjcAgeydJrWslma5GvgkDFvr
 7ljxnF3EjtkGdxtMhVezNiIiX7kqATQjFGl6xYqsTrCLyeZud8fRlFkDZ70kJwFDmG8bLLIhfE3
 xIv2Rq1RBQYJ8CwkhJiiSVR95Kf2NHHVm2fw1CVepHOey9+3uwOdFH3e7bZ0Qm8W8wM8bqiKTyu
 aRsPlf4wqRgv1j+ByUNLyWkUOBkqfl7IjFuNlMw0kObf5bB/2tr/mdnS7r9q5xu4ak2a40Yjwne
 SaYnAL45WoLqeib8S+QN3rDDXK8oorecG2V2W1wyljG2FxQr8k9ZAk8yGfPxTV7KK5ycuDVlA6I
 R66+6BA+5RLw==
X-Google-Smtp-Source: AGHT+IEcnZUowbBYYo+vGfFX0L+o9PH4EzlnjylKB2wI5cInKl5JyQWq5hrzqmRbX7Wwdfduti9arQ==
X-Received: by 2002:a05:6e02:2162:b0:41f:8265:40e2 with SMTP id
 e9e14a558f8ab-420a53aedbamr169358325ab.32.1758039272394; 
 Tue, 16 Sep 2025 09:14:32 -0700 (PDT)
Received: from ubuntu.localdomain (209-227-169-220.cpe.distributel.net.
 [209.227.169.220]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-41f0ea1bdaasm68433615ab.39.2025.09.16.09.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 09:14:31 -0700 (PDT)
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
Subject: [PATCH 0/5] Enable Firmware Handoff CI test on qemu_arm64
Date: Tue, 16 Sep 2025 09:14:16 -0700
Message-Id: <20250916161426.32259-1-raymond.mao@linaro.org>
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
2. build flash.bin with both Firmware Handoff and Measured Boot
   enabled;
3. pytest to validate the Firmware Handoff feature via bloblist by
   checking the existence of expected FDT nodes and TPM events generated
   and handed over from TF-A/OP-TEE.

Pre-requisite u-boot-test-hooks patches [2] are required.

[1] https://github.com/FirmwareHandoff/firmware_handoff
[2] https://lore.kernel.org/u-boot/20250916161230.32140-1-raymond.mao@linaro.org/T/#t

Raymond Mao (5):
  docker: add OP-TEE build for testing Firmware Handoff
  ci: add post-buildman script to build TF-A
  pytest: add test script to validate Firmware Handoff
  configs: select CMD_BLOBLIST for Firmware Handoff testing
  ci: add test entries for qemu_arm64_tfa_fw_handoff

 .azure-pipelines.yml               |  5 ++
 .gitlab-ci.yml                     |  8 +++
 configs/qemu_arm64_defconfig       |  1 +
 test/py/tests/test_fw_handoff.py   | 94 ++++++++++++++++++++++++++++++
 tools/docker/Dockerfile            | 77 ++++++++++++++++++++++++
 tools/post_build_tfa_fw_handoff.sh | 87 +++++++++++++++++++++++++++
 6 files changed, 272 insertions(+)
 create mode 100644 test/py/tests/test_fw_handoff.py
 create mode 100755 tools/post_build_tfa_fw_handoff.sh

-- 
2.25.1

