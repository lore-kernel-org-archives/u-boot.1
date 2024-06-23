Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52444C2BBCA
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 11:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60FBB87D70;
	Sun, 23 Jun 2024 13:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LikSyI0f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8FB887DC7; Sun, 23 Jun 2024 13:48:46 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9604987572
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ec4a35baddso29747621fa.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 04:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719143324; x=1719748124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GlQQOyrMokxqv2lQupenwp9x4YQ/x3Dy8M1cu1+dZmw=;
 b=LikSyI0fcajyGeNBXPBXVTnI2TDJFqdZCXs/EEUNR42ajeGZHvIpr1Wzedb78BHopM
 HmTR17oTakwxMyJxL/0kLbiD7FkHjCvaiKdJ+fuisbo3fUF03GpGmYoa1FbVx/GXU+UU
 bPWhzG8QxnlXPsIm8xsVQtIuCYdMfSipVFVuptl0NHwRwczk42Aa2ECXyQcwHOVAkYYh
 m8xvYnrOu1UrJqP6PNsFpxo2er/1+xZXHuzb5Hd4DQxLjHNeaSGEM7Gx0UXw7p6V2ZGE
 G/UfHVzzfRo8JelvgCDmg3sXd3TGibmY+m4xuMn6sInsKaI3WfTYiUbyKL9SmZcdYF/N
 JlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719143324; x=1719748124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GlQQOyrMokxqv2lQupenwp9x4YQ/x3Dy8M1cu1+dZmw=;
 b=Vrjk46cvQm8Gqg4mLfPFwmBVVgES7X9ry2hQPK+WUQj7WfNSBr8Evx3o//Ngb3D99Y
 n2BzKbIPLuEXTUa85NXn8mpH0rXGBS8Vnn7680eqbaIHskhWmpZiGtDsUPcObJwfqHO9
 V1x4FdD0nh8ueUghC0QoSdW1goB+IVkEygst/f3jspXXNboCsMbIxIdOH1YHu31qmeeq
 rVsO5U/BmcQ17agjaFpFPaaU/JnowME+cBtawV6FIwy5JhDRY/VT0G3YNoyLFUTsaIsr
 rRL0X5/XGCpVJVOFWbyAFH2NJ+2iZbIKwbIXEkwga5AmAcQXNJrZ1QexUcC/i4a5D1fW
 syBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbIzdEfC9WsWnfCqnW/89wQpff75ub0VocqtBJPKuITHE3Ye4SKfOI4wzW8vgSR5rQmb99ALEbWhYiT0UXzA0suQ6qJw==
X-Gm-Message-State: AOJu0YxZxrkO09Qg63A5xr3Y+tAA0tRylhGRXoBWdPEykEj+YIdhFtgO
 1Cn5i1BKRxfTJYYiWBSCDNR4moRISr8ThkxtBA69HaXSTLDxd4D14RurYef3eow=
X-Google-Smtp-Source: AGHT+IE98wwr8UZ+W6+S6emDB7oy+Lnomj1wcJKzPaC8w+/2vpFPDN0X1lBwkMQFEm1su7zcq8qPEw==
X-Received: by 2002:a2e:9996:0:b0:2ec:58e8:d7a2 with SMTP id
 38308e7fff4ca-2ec5b337346mr12157291fa.16.1719143323431; 
 Sun, 23 Jun 2024 04:48:43 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d30534ffasm3402053a12.60.2024.06.23.04.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 04:48:42 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH v2 0/8] The great TCG deduplication saga
Date: Sun, 23 Jun 2024 14:48:10 +0300
Message-ID: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Hi all

Apologies on resending so fast. We are close to the release and some
patches are needed. This is v2 of [0]

Not much changed, since v1. The major change is that I managed to split
the code and headers file moving around as Heinrich asked for easier
review

Changes since v1:
- Added a comment on why we return EFI_INVALID_PARAMETER on failures
  while EFI_DEVICE_ERROR would make more sense
- Fixed some typos
- split patch 4 to 2 patches
- collected r-b tags

The testing was ok again, and comparing the eventlog between versions
had no changes -- aprt from PCR0 which is expected

Ilias Apalodimas (8):
  tpm: fix the return code, if the eventlog buffer is full
  efi_loader: fix the return values on efi_tcg
  efi_loader: remove unused TCG algo definitions
  tpm: Move TCG headers into a separate file
  tpm: Move TCG functions into a separate file
  efi_loader: remove unneeded header files
  tpm: Untangle tpm2_get_pcr_info()
  tpm: allow the user to select the compiled algorithms

 boot/Kconfig              |   4 +
 boot/bootm.c              |   1 +
 include/efi_tcg2.h        |   9 +-
 include/tpm-v2.h          | 388 +++----------------
 include/tpm_tcg2.h        | 348 +++++++++++++++++
 lib/Kconfig               |   6 +-
 lib/Makefile              |   2 +
 lib/efi_loader/efi_tcg2.c | 129 ++++---
 lib/tpm-v2.c              | 767 +++-----------------------------------
 lib/tpm_tcg2.c            | 731 ++++++++++++++++++++++++++++++++++++
 10 files changed, 1262 insertions(+), 1123 deletions(-)
 create mode 100644 include/tpm_tcg2.h
 create mode 100644 lib/tpm_tcg2.c

--
2.45.2

