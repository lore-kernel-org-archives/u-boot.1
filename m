Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6A5EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 08:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B268645D;
	Wed, 23 Aug 2023 10:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i1Dw0hHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0F438645B; Wed, 23 Aug 2023 10:38:18 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BA448645D
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-26d4e1ba2dbso2987789a91.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 01:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692779894; x=1693384694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=feWBhUg70hsjbWqqXmkimIjEPAl8pc9IYvGl9lM1iMc=;
 b=i1Dw0hHVJRhBj3kpkCRjipVqDK+iYyLHskD72dM3qN1rlZqCQ8xmaWMrh+te6lGFYJ
 sD2D3MWlsfAIR/eocqTz9GudqMXVh6v7gJePrXayWhRdJkixG+DKVAfnfC3N/POZcHHa
 qNDi+P5UPWCbz0dF1JeNTBmuCPHIY7vsdmIdY+vUkyDpnGAX2aVADjvmCWppWIhDWdsm
 e23ivb1rhL3WQVFShmXOSehB5obEHVmn/LkqLWGuWjkPqZEdAVxs5jYjf3/4B3ZyBpKG
 pm2+tfJQwzS8vEI7uCQVBtwAF9DyOsrNByGczC4A672OvTJPy289FOTtu6XI8o48YhGx
 VLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692779894; x=1693384694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=feWBhUg70hsjbWqqXmkimIjEPAl8pc9IYvGl9lM1iMc=;
 b=Ycf2bLo1Zj4VShfuekNpLopYIwu/8mB+L15K9mlvcOEcWdELeF5O4xC6KRkbyYUWj5
 ESoKcaAlLUcfJ7S8Vp20pM2MmCBxXW3/UuG2ORbvfHm4kOiq9vq/fvb+wFusFR11PhBU
 2Q+j2Pv/s3UWOKqdpqbKcPEa4H+2Y+MTA/wxRgXCF/XxjppWB5r2ZBZH0zPRr8T5WqXP
 cBmBx2+irkChO+2U6gVA0+C0gwTHGP2we3R66iM0cT6+btK8cAiVp6/KVQ7I2vKCSCzY
 laJymTySUxEPvMQEU296+4IuDZ9Y/J4qDm0mGEQJ7GGL1SUOrgpLeKN7den/RwDMXHHH
 6zww==
X-Gm-Message-State: AOJu0Yw5+21Kz0yccRz5e+oJ2r9XuXKR9BAuT7u6/pWelyl+/yYFHBha
 6JalH8NieM1VwHLDYMvaeSYeZ2roi+/K0RGfvPs=
X-Google-Smtp-Source: AGHT+IGV5jCnnOL/BgpiOqX6LHiAofZG7ahvy+IIBMF0zrqNVdyIP2Kqbw9VlYETlPuqzJC3GXKrXg==
X-Received: by 2002:a17:90a:4e48:b0:26b:5ba4:4948 with SMTP id
 t8-20020a17090a4e4800b0026b5ba44948mr8515506pjl.12.1692779894186; 
 Wed, 23 Aug 2023 01:38:14 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 l12-20020a17090a660c00b0025bdc3454c6sm10845338pjj.8.2023.08.23.01.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 01:38:13 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 0/2] Add EFI HTTP boot support
Date: Wed, 23 Aug 2023 17:37:18 +0900
Message-Id: <20230823083721.1318097-1-masahisa.kojima@linaro.org>
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

This series adds the EFI HTTP boot support.
User can add the URI device path with "efidebug boot add" command.
efibootmgr handles the URI device path, download the
specified file using wget, mount the downloaded image with
blkmap, then boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).

To enable EFI HTTP boot, we need to enable the following Kconfig options.
 CONFIG_CMD_DNS
 CONFIG_CMD_WGET
 CONFIG_BLKMAP

On the Socionext Developerbox, enter the following commands then
debian installer is downloaded into "loadaddr" and installer
automatically starts.
 => dhcp
 => setenv serverip 192.168.1.1
 => efidebug boot add -u 3 debian-netinst http://ftp.riken.jp/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
 => efidebug boot order 3
 => bootefi bootmgr

Note that this debian installer can not proceed the installation
bacause RAM disk of installer image is not recogniged by the kernel.
I'm still investigating this issue, but drivers/nvdimm/of_pmem.c in linux
will be one of the solution to recognize RAM disk from kernel.
(In EDK2, the equivalent solution is called ACPI NFIT.)

On QEMU, I can not make DNS work from the QEMU guest.
The following commands work on qemu_arm64(manually set the http server ip in URI).
  => dhcp
  => setenv gatewayip 10.0.2.2
  => setenv httpserverip 134.160.38.1
  => efidebug boot add -u 3 debian-netinst http://134.160.38.1/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
  => efidebug boot order 3
  => bootefi bootmgr

Masahisa Kojima (2):
  cmd: efidebug: add uri device path
  efi_loader: support boot from URI device path

 cmd/efidebug.c               |  39 +++++++
 lib/efi_loader/efi_bootmgr.c | 213 +++++++++++++++++++++++++++++++++++
 2 files changed, 252 insertions(+)


base-commit: 4e73b0153cce064e10dee4722cb2b6833361c227
-- 
2.34.1

