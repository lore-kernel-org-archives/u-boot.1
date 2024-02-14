Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B16C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 18:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B45A8787C;
	Wed, 14 Feb 2024 19:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="G2RaFYAd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D10108787C; Wed, 14 Feb 2024 19:34:55 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A88D80E9A
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 19:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5639c8cc449so74741a12.2
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 10:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707935688; x=1708540488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Br7QgmtL56EB3uwKhAEV+FUsJQbv18oNuillspPtMaI=;
 b=G2RaFYAdZAKimvjvfkFYNnmePY0bo1jJEA/9NkLagtquMm59FzzU7LBx2ochnKph3m
 uMx5mAlDMgOZKCz39GJk/NNSjv6/MHYV7g2bn1j3sZ1/ngBVvbbZ4bpXLh0d2oDstS6L
 9YlCMI7jtrMppfSUHi1r84ela+pAw1NeiqIx1Gs1JLvgtfGLHLPW4Ee1vXBDOiXMPYgq
 VH/A7Nwy1/sytxJin0LWNTUGc+cq62yK81hTjUiGwvb/YgqKX5fn3c8VyC7qI/uuo/61
 hP9xnvUvcvX3ylIllFenGYtHi+4n74/GihbZnUcZww14nUQOsDQllWzBtUPDl1wTpiia
 Is6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707935688; x=1708540488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Br7QgmtL56EB3uwKhAEV+FUsJQbv18oNuillspPtMaI=;
 b=LXiAjlXYqjEsc7kRavZLszwx6yJiVGosL8XVJdTEDipcUS5cZMBxJQKZIpf70chcWv
 zFtr09+/pqgxCuPhI8tqSvp5vSai6V3yqL61v85usUT6nGrG8TYeCSZLsVIJF1HwHD3T
 izdsQUBKmcWne+hGr/PqgEo6ykYwRAaR9jMObJEKw0HRkn+yBCFD3S6MTf4s/W98kq7X
 oeR4PjlxPpjec6FM+3MDC4demS5mi3UZiJNpWGUu/RGYixe0mE9thOIZ1n9eJt7qZBzB
 rS2lMKT/wfns4s7xi349MiI8/O9oM94U3g1UVLnSCINHhjVpgJWFvKJHvIKcka1ndwjP
 xO4A==
X-Gm-Message-State: AOJu0YwUTDYDpT1WB3wiMPotoNNtEuGaY71iqhIcrbsfxFpipb0RnHXl
 bW2H6VIED7+NjzAYDK9Nw9WPW8PKNLn9nnHeqFSI2jhWtUOK0/EPQtQadqv68WdfwCj9IU3KZJB
 BjHg=
X-Google-Smtp-Source: AGHT+IH0Z4BXrkpD5RixXne4YwXchVL2RqmqLqDWYd03M4dKEpaRvaK1OOVSqijgxpUcRRMjtDR8/A==
X-Received: by 2002:a17:906:5a8a:b0:a3c:b36d:dffb with SMTP id
 l10-20020a1709065a8a00b00a3cb36ddffbmr2175306ejq.16.1707935688562; 
 Wed, 14 Feb 2024 10:34:48 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Y3ySDEcGgHC7LeRim+hoA3Bh142v1dMANCHNYCAnt4qesX9FdHIH/593qW/Bs+STDV00HAdDLep00SdeUUvNznNbLCjNDHaJQYpwXbeWRR/pwxDs0vJgx2jVv/psIW7dXvGY+tJ7DieXOKqPSeHDH0mkCB1mfSHEf8X8OwiMFZ+zSNz2/TBHR2T3qCDBfNTa8O8i3Td8A91fSjdlPBCoM5d9POmlxIxGduFTm+qm3AeFp/zhlZbYC1FDXbwnGmFHUijmS+WeK3PTUUvPcqskMH0RU42swpjpVMwFbxh6UUd7giHbLmnC/ckf2VcFzm4bmtloFRvBiJ3I7P0N92A0mP2R7faH/Rm+SDLYvG4QnlS9FeqzyFGH6YnjBz4JJqV0b4FT8q/upaWuBDGtGsW4GyU5viQwDSNz9x6hVGMpWRGpmX8kAGwassxgFvTcdCcHMLYixmQpWS2haKbmcBm2MB/fku5uRqWHHT/xSb/hG+NiWvJ4k0NTaefMo2+45sdgjZPBI7oW/AVuehro/+Ask9Bmp6vZDHlaC3BuEe/k1AsB/lbtFEZUijSjcB26E83edAV+ZCSMYTLczoeqZyw=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 qo3-20020a170907874300b00a3d03a5f7acsm1863543ejc.65.2024.02.14.10.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 10:34:46 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
X-Google-Original-From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/5] TEE: minor cleanup
Date: Wed, 14 Feb 2024 19:34:39 +0100
Message-Id: <20240214183444.493629-1-igor.opaniuk@gmail.com>
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

- Address some spelling errors and typos
- Support CMD_OPTEE_RPMB for SANDBOX configurations and add python tests
- Remove common.h inclusion for drivers/tee

Igor Opaniuk (5):
  tee: optee: fix description in Kconfig
  tee: sandbox: fix spelling errors
  cmd: optee_rpmb: build cmd for sandbox
  test: py: add optee_rpmb tests
  tee: remove common.h inclusion

 cmd/Kconfig                        |  4 +++-
 drivers/tee/broadcom/chimp_optee.c |  2 +-
 drivers/tee/optee/Kconfig          |  2 +-
 drivers/tee/optee/core.c           |  1 -
 drivers/tee/optee/i2c.c            |  1 -
 drivers/tee/optee/rpmb.c           |  1 -
 drivers/tee/optee/supplicant.c     |  2 +-
 drivers/tee/sandbox.c              | 10 +++++-----
 drivers/tee/tee-uclass.c           |  1 -
 test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
 10 files changed, 31 insertions(+), 13 deletions(-)
 create mode 100644 test/py/tests/test_optee_rpmb.py

-- 
2.34.1

