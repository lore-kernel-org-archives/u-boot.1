Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D296AD3B7DB
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 20:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4233839A8;
	Sat,  6 Dec 2025 21:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UpqOo550";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7FA9839AC; Sat,  6 Dec 2025 21:01:33 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D98D83957
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 21:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-29853ec5b8cso41393185ad.3
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 12:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765051284; x=1765656084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YamJCf/iLMC8QgIRfmQXBAgT3Wq2bfqoj7aNEK/EibM=;
 b=UpqOo550s2GxahxTfw8mhKBWwXZS4W9iQh53gu0q6lTEIuuM1hBqtDxsXw1aRrL7kn
 P/eFGJWxWrEvLXddfcdwDCinS+kBNr1l9SGaXVkNZuH7ZprkCRvtBFf2ReugxPFWo6n7
 tSuzfdBaRUg/or6DHyTiPNWAubPDa5c+/VCesTeS8tfbt8+qN7fF4mVb6LCLmfymtA06
 n0lW+fEh1kE6JOya43B1Ygj7fyB7vAz8gXEBuj72Z5DSUqg+egr5M6w7CD/pmxUsSZNv
 PLxtWvKFUr169o2nRfk25HpmAkQ57ct+MfRhbTn7AjbI+eqHBRSa9hvmcnpRTEmtG1JV
 f+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765051284; x=1765656084;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YamJCf/iLMC8QgIRfmQXBAgT3Wq2bfqoj7aNEK/EibM=;
 b=YQ69mzFLMEMGOO2KGvQZGvvMrlDvz++TrMlKQLAzO6E2EbMm6j/JgrHUl0WEmMCmxl
 eHswnH93TRDrEprcwWMMh6OkAJ14+xPxT9q8u/OdPDRwJym4jZUbZkax20iYQ6xxsuCR
 M3xkn5zwbZKDIjX/CNn4T1SvZz8AesfKra/0cAeC/mB7ZuEadHIj8o3HHe/tKt53X7ET
 pOiTknVb2FA4JJW4Z4dkC5Jl1cZgZTRTlmWNLOteVycUZ/F7kgf1bmCk4qgbtdu9cpFi
 yX/pKK0i3caFf/lUMOTESlGh9SBaU9sz5T5Bo/O7dL0p6qbUV/TwmI0xDNmif9uiXNZs
 hH7A==
X-Gm-Message-State: AOJu0Yxo4wOI/mvOl+zEAZw8iytKmLOAPAJYkFKGOup8cKFpHqbC/Fy7
 WcD9lCZAbMhRv7jkC86R7XEOCKuhExsFAn07S5XjniIKAyU9LNq4/D+D
X-Gm-Gg: ASbGnctBBf9pnFGse2hWlqlZegnZyZf93O/3i7PhyrABS5Q42phMDVcraT1QiPkoKwX
 dV/jg1gBjJ5sSdi2BOCDTxuYkOiNIiC84TeAqdbTPYI155PKTH1Ee2fvBuRl+vwNPK7wnY4W5bP
 kmfCUFuaaTB/fVLjHwZLRAcI98EFh+Qh5M7j6JUQ4JjA55sQ65ICAdOfrNwLLinkAHWJq9DcaSu
 Ln8i8sDDbA2OkGfD70ca1rK5D9Rfb55uwXsIDSWpvY2eTSrZcRpOkXOU1xK1YKxZvQp8Bfvn09D
 Uj81c1LdI0MGGHR8VsyIkcdGxAeAtOQvBMhckfvGWnWgUt+qDSAxMK7JaHwzHx1CPqN+H7mHUp4
 wvRK/IXHe5C5hkgrw/0rKNEM7tTfDa8JAYIylvWa/SlfMU/xyQHinsrdvjosF9rM95vxitkowjU
 4UZkFi6sPmCKItrvAL/PKZ0VgLig4o559p4aA=
X-Google-Smtp-Source: AGHT+IEvzKwpTUqboqRPv0bK/mBJCHmEH38FsGU+QgeVTkDQdVKh0Vb3b+VxhzR+7egUCrVfvBTnlw==
X-Received: by 2002:a05:7022:62a2:b0:11a:2ec0:dd02 with SMTP id
 a92af1059eb24-11e032d429bmr2569180c88.33.1765051284240; 
 Sat, 06 Dec 2025 12:01:24 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c3db:5009:3dd4:f543])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11df7552defsm33445728c88.2.2025.12.06.12.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 12:01:23 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20251206
Date: Sat,  6 Dec 2025 17:01:19 -0300
Message-Id: <20251206200119.272104-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Please pull from u-boot-imx/next, thanks.

The following changes since commit bc1819331ece7aa4e7d0573c9cdacdb8efbdb067:

  Merge patch series "clk: Return value calculated by ERR_PTR" (2025-12-05 17:03:36 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20251206

for you to fetch changes up to 76948dd22d7ef5c4b5edaf09e29c422ce7d288dd:

  board: phytec: phycore-imx93: env: Add required uuu variables (2025-12-06 15:26:07 -0300)

u-boot-imx-next-20251206
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/28658

- Fix the i.MX9 USB instance number for revision B0.
- Add nxp-imx9image etype for binman node.
- Use default for SYS_MALLOC_F_LEN for apalis-imx8 and colibri-imx8x.
- Switch phycore-imx93 to standard boot.
- Update the nitrogen6x maintainer.
----------------------------------------------------------------
Fedor Ross (1):
      imx9: scmi: soc: USB instance number change for silicon revision B0

Jérémie Dautheribes (Schneider Electric) (2):
      imx93-u-boot: move binman description
      imx93-u-boot: use nxp-imx9image etype for binman node

Max Krummenacher (2):
      configs: apalis-imx8: use default for SYS_MALLOC_F_LEN
      configs: colibri-imx8x: use default for SYS_MALLOC_F_LEN

Primoz Fiser (3):
      board: phytec: phycore-imx93: Switch to standard boot
      board: phytec: phycore-imx93: Set boot_targets dynamically
      board: phytec: phycore-imx93: env: Add required uuu variables

Simon Gaynor (1):
      nitrogen6x: change maintainer

 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  16 ++++
 arch/arm/dts/imx93-u-boot.dtsi                | 125 ++++++++++++--------------
 arch/arm/mach-imx/imx9/scmi/soc.c             |   2 +-
 board/boundary/nitrogen6x/MAINTAINERS         |   2 +-
 board/phytec/phycore_imx93/phycore-imx93.c    |   2 +
 board/phytec/phycore_imx93/phycore_imx93.env  |  70 ++-------------
 configs/apalis-imx8_defconfig                 |   1 -
 configs/colibri-imx8x_defconfig               |   1 -
 configs/imx93-phycore_defconfig               |  10 ++-
 9 files changed, 92 insertions(+), 137 deletions(-)
