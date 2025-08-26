Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6D6CA0EFA
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 07:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5E283071;
	Tue, 26 Aug 2025 09:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OQF3qnk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF148307F; Tue, 26 Aug 2025 09:35:23 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A627828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 09:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45a1ac7c066so32943965e9.1
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756193720; x=1756798520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OzzNEYbnAchd2jpBi7UzajvH/4yOYpnTnWQhPw4irYk=;
 b=OQF3qnk2+xsvDgIVG07z32pY4RkFEjb+bDmBvGZqe2K1c5S9WAb1XrSqCpJ8WCoQfL
 ADkKUY6KIDRfuhp7MS9pw4yPgjO7ehKbonf+6RYpXdjAQyk9hXdGyNGDUOhi6kjxApBF
 SXgILGFI5Or2n9BCtSfQGsKVzIaL+byiGt+M09HRJpeQ5QFNKobBAtGnncawTNo/qjON
 fhyMbmvvQOgX0xUjPfIUcI+1p+TZGryeyiDAci6fhJJtPWFEPCWqrxPEAbLZIoqYtTwF
 yL/DJa96mbrs9F3AmTo9+PRoU95+FXVBo8YV/Mn3kocbX347haa/DzFYgGUKVq1AQFnP
 6KiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756193720; x=1756798520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OzzNEYbnAchd2jpBi7UzajvH/4yOYpnTnWQhPw4irYk=;
 b=LPq4reVKsb2hZXUoxIF+gw7I3gIHW45VhhyfVJ1v4L1xWQAEcK0Gx17v2yFyeD061t
 b1KeuFVg6aYh7JyIZSpTrpkt/5UFaOlaiN0ABr7mqb9hTnpP/egJmkUsQ6ByIgS7XA40
 pekVFHkh6JnpwYHAzHrXolGKIh65Z35A2iADWyqKm5yW/VIzhpJQWwiswScFcWqp1fxH
 nCqcC8nbMEIcY6a8x0tbYKS4ejsH/etVJvbrsWb2lZKKEsF7T6Xf1zNCZAbiB/PphoIi
 fkT/JKcSY6cZGCD/Ohz9iQWkgxxb6Qop1mWnvy/MOcpV17rxbhZKK6lzLaxC5CkhYcl2
 7qhw==
X-Gm-Message-State: AOJu0YyfLCO3UXMFL5R4Rg6Bit4u1+AilnEKzuglxY3W41yB6UR3atqw
 l5Ijyhv8ncFWa+9wBhkv5cbOr0tgSKaQm3guZQ7cVLM5dGrpxy+Q3WkwiH95rF9556f/7t7WK4u
 fXMXD
X-Gm-Gg: ASbGncsiWActRGDpqpWnXJ7kOM7yOZZbhE17Y05w9rKjUdlxZGZTdc4bFkum9UguDY6
 d//sZ4ChnDhnrq1Iz7ODayLnJ9eLdoMxfE2kUWbqeEJzFwTtV+urHLSZMnTlpe88nfMPr8LFw56
 hocLwGtpb8ZLYeb4tr+IEzEwp7P3kok6lg2IxFYxSH92YhnENpFYDSCeQPMIbKx29h3gduYqFa6
 0OxU5cO5t9uIdJyjpSBnsTex/EOTvgTEW1N398/8f6O106sVXN9vcnyQl3qDrFLMY63gkkRYCzF
 Y+cngPmIz3QTfn+oQJbKu+rv1n0hVkeZBQ5STTTXfz37+lpQLHcz0144N6AuoqiMC7tlZBF7hUD
 bpDZDIPk2ncq7CRa4jCRiOOtWZ/NsksHmbZcIBJRtC42ulScVPKut0bmlLOAcimTiIMElq4YyuA
 fCGRG+uqyFi2tbc5iOK9A0IhebNUR7RhrQ4Pj9qp9Olx+tKW6upBFJPZ3Of0lJ8Vyze2wdU1Ulc
 Sw0AR/m2wl4h76K7aNV3GMjXCJQMaeC1+w=
X-Google-Smtp-Source: AGHT+IFkLoD42KffRKGPgYe7nRXk6WUaOMOKUNs5YhTFxy4ungXcrknPc4/lHgCD9xtKvkamUdzOdg==
X-Received: by 2002:a05:600c:6298:b0:458:bade:72c5 with SMTP id
 5b1f17b1804b1-45b6870dde7mr5282145e9.8.1756193720417; 
 Tue, 26 Aug 2025 00:35:20 -0700 (PDT)
Received: from hera (ppp046103010177.access.hol.gr. [46.103.10.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b5757477dsm138769535e9.16.2025.08.26.00.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 00:35:19 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Subject: Pull request for tpm-next-25082025
Date: Tue, 26 Aug 2025 10:35:10 +0300
Message-ID: <20250826073510.357157-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.50.1
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

Hi Tom,

The following changes since commit 51214ffcc543dde83ad687c35cb2de61a34e0602:

  qemu_arm: Select CONFIG_SYS_EARLY_PCI_INIT (2025-08-21 13:27:59 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-next-25082025

for you to fetch changes up to 73b23838c44b152deef68b7c22d923f0ca7a563f:

tpm: tis_infineon: Cannot test unsigned for being negative (2025-08-25 13:04:21 +0300)

The CI seems happy https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/27461

Please pull!
/Ilias
----------------------------------------------------------------
Tom removed an unused TPM driver and fixed a few prints to include
the 'z' prefix for size_t declaratiuons. Andrew fixed an unsigned int
comparision against < 0 in the tpm infineon driver.

----------------------------------------------------------------
Andrew Goodbody (1):
      tpm: tis_infineon: Cannot test unsigned for being negative

Tom Rini (3):
      tpm: tpm_tis_st33zp24: Remove unused drivers
      tpm: cr50_i2c: Make use of 'z' for printing size_t
      tpm: tpm_tis_infineon: Make use of 'z' for printing size_t

 README                             |  11 -
 drivers/tpm/Kconfig                |  18 -
 drivers/tpm/Makefile               |   2 -
 drivers/tpm/cr50_i2c.c             |   4 +-
 drivers/tpm/tpm_tis_infineon.c     |  10 +-
 drivers/tpm/tpm_tis_st33zp24_i2c.c | 545 ------------------------------
 drivers/tpm/tpm_tis_st33zp24_spi.c | 674 -------------------------------------
 7 files changed, 6 insertions(+), 1258 deletions(-)
 delete mode 100644 drivers/tpm/tpm_tis_st33zp24_i2c.c
 delete mode 100644 drivers/tpm/tpm_tis_st33zp24_spi.c
