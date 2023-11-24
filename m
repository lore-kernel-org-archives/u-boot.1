Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F9FC61D97
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 11:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1096870FF;
	Fri, 24 Nov 2023 12:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="PlPdmqH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9045870FF; Fri, 24 Nov 2023 12:37:07 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF42987008
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 12:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-332d2948170so1174905f8f.2
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 03:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700825825; x=1701430625;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gWEkxmn5EHY0SoMdhCztEAs6D1sXq5lEaG83vA2MUlY=;
 b=PlPdmqH/gqVrb/W0zydE107xR4lPRl5Q3vEHQGvKBB9lNcCBAOMgyK7lX2LcrztX5L
 TNr6y6C3Z509IOEchRnpoiusWyQVH0eGBUT4DmduM8vyGhcAVMycLO3eyBpwmZ1YgM2M
 TE9BQShY3WarvMimWqEUSducEsCGwmlKqsxVEtxPBIBEbcaWOQE5T1e6YhM03iB5i57A
 LkUVNTMoZ/GoAr9SVjCYncfFPX2cRv8qISPaxlquoWxGGVJwY6rRQy0q95CrRnK7b6Yn
 eZ69GTqdM3ek1FRvcfD8gfRTDAX6lb6n855KsA3hniRyHeEWlBgZIont2/OPVOfLFPxJ
 /ZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700825825; x=1701430625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gWEkxmn5EHY0SoMdhCztEAs6D1sXq5lEaG83vA2MUlY=;
 b=BIinbaEz4J+jls5KZW31jL9MKTtDLvmdgf74aQ6cxjM0DSaLCH368KAOT4zWckpy36
 mz52hI/rIjSadycY5QkBxlI28slMC4Bk4euWFGlI6d89DeZ2Q6FUUOFe5Dm2RtMZZRaI
 JDOfMDBl/HbUWDyp6oQJltiVlGFSXVFA2tY88hJBEj93NFT5pxAh4P7oP6/UIOVrLuLY
 ZgOn80Ea12MZxhS/a0qL5DF8zFA1dYYuvNnvLHEr8M1CeU/p8hBKdP7BrpgpLKbttuWJ
 Ng2Snp5HKyQQFxSC3H/6s0j4t6EMYt1wZwkBsuC3ZuWK29kNHbAybf0sjEObxqPuz0nz
 NsXw==
X-Gm-Message-State: AOJu0YyG6ENeHEva50ZKwAQP+ea1NHYCMHTag+la3RjG201WummKIr00
 AhzEKyY2GBU+FqXN3fYHSaXJyK272PMgXHebcH3NDAxK
X-Google-Smtp-Source: AGHT+IFfWMLqGmh3UFnfNB22b8u7i+9JasAMTzvLHuQwEmzY5x584OPlvPRblkDSvaGLHJeeZ1TNpg==
X-Received: by 2002:adf:edc7:0:b0:332:e61e:43c3 with SMTP id
 v7-20020adfedc7000000b00332e61e43c3mr2024965wro.16.1700825824558; 
 Fri, 24 Nov 2023 03:37:04 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 o8-20020a5d6848000000b0031980294e9fsm4052093wrw.116.2023.11.24.03.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 03:37:03 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Akash Gajjar <akash@openedev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 0/3] efi: vars: Implement SPI Flash storage
Date: Fri, 24 Nov 2023 11:35:49 +0000
Message-Id: <20231124113552.112243-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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

With this patch series we implement SPI Flash storage for EFI
variables.

Changes in v2:
- Refactored efi_var_file to move common parts out as requested
- Changed ifdefs to use CONFIG_IS_DEFINED
- Fixed typos

Shantur Rathore (3):
  efi_var_file: refactor to move buffer functions
  efi_vars: Implement SPI Flash store
  defconfig: rockpro64: Enable SF EFI var store

 configs/rockpro64-rk3399_defconfig |   2 +
 include/efi_variable.h             |  26 +++++++
 lib/efi_loader/Kconfig             |  25 ++++++
 lib/efi_loader/Makefile            |   3 +-
 lib/efi_loader/efi_var_common.c    | 109 ++++++++++++++++++++++++++
 lib/efi_loader/efi_var_file.c      | 121 -----------------------------
 lib/efi_loader/efi_var_sf.c        |  91 ++++++++++++++++++++++
 lib/efi_loader/efi_variable.c      |  17 +++-
 8 files changed, 270 insertions(+), 124 deletions(-)
 create mode 100644 lib/efi_loader/efi_var_sf.c

-- 
2.40.1

