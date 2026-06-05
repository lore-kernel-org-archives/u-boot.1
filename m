Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B19ECD6E75
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 00:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20093848BF;
	Fri,  5 Jun 2026 02:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s0L6OPt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48655848BF; Fri,  5 Jun 2026 02:09:39 +0200 (CEST)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2E0684874
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 02:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-963b7d9bf68so485468241.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 17:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780618175; x=1781222975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2AwzzXQv54Fez7TGKlAVNV0/OkZeliWORpZXArmsT4A=;
 b=s0L6OPt3m2U8EjDFr/mf1IW/zqfu2oZp39PvIxK4r3r4ItBdD90pj+fU7y1hmaDTFF
 Q2JVl+xTORO2YIColyeHJyXw0X1bM5Qk8Cydd4MYu3EHDA7Ui6a+NsPo64+JQZNMAY5f
 IDX3Pu6ar3R+3EVvkTk/W018tM80PU2j2RmvW09Mj1RX45EpKazgwgiT9rll6+eHPwMq
 bvvGgF7IdmKSS9VTtX0EAZl7k7uGcnI2PS9DAbENWLu39CzJfH3k3uL5sKfqp/1DtXod
 CK4ehFHlH51ouu5ZkpmKvWAmXW8oirXxmFGJZINxET8spuzsI2RAuIo65MSy9bZ289Sp
 L5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780618175; x=1781222975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2AwzzXQv54Fez7TGKlAVNV0/OkZeliWORpZXArmsT4A=;
 b=gNG9koKE4jkH5MmksdZ0UydG13KkWpZfWzZDUybuEoBRWxzjuc9Ii052CIZXiR/EIi
 d2qZ+a2AGVoaV4V15cWHC5KxecudCEjidTzvVvDxTmwQiLfpLOa66jtOER1cfkmtiz3N
 6ExfB2M7i7Sjnc30Ic8WL2tRJy3euQh7mNBEovb5ajktJ0ribmEadQyWnCMRw9xgk5aT
 l0+zZyuO48hnJDgkrEhKUVdHVa+a7C5iRU0FXDxYCoB9lxE4sC1L3TorwTRUHcIwDGnb
 WnWYii7Im5W6VThAm4uYg0IU4V6Apd6kqAeTswB1qzjnZgiD3wu50IDpOHHmdR4iQvRI
 MKnQ==
X-Gm-Message-State: AOJu0YzlqvRtCN1LJrJf5HKeLGbtE4jXHhfLvNV7YO4/wjac8XMEplcg
 NnEFYjb+YT/PUpdol2+L9My8PiexpfoleqTEHC7GfkieRXG+jCTP31zp/lEAkQ==
X-Gm-Gg: Acq92OGBp4CCEBEAy9jQ9BvoMLS8zgGME1v68QUTInGEoUYUswYJGzS7HRKQfjGfBeO
 dkdVMcb6+BMvyGrXXYML6pEs3Agx8JSuH1AQAk/0HNvlX/igyUNYD5iifXm/Peaq5T6kbcKpnqJ
 AklsbQAWJIEz6lcq3Rcu5dt6rmkQu5t0bbVb2YxP54eb6Y7VhyQ97MIgGUG0xAaz1LYzX9nXqFt
 s8ESrNfudf9d6xRf8TFWQBIGiTwRPCB9KyPtjzvLJzutT6EXU8qurB0irgBSwfnw0Tfd5tvoAq3
 G0NVeO5YWQlFpop5OQ4yq+sVWtxjjoDT9ufhLbJQK8fOBQ4P0P5bGh2Qy/T14dS2GruODOLWK09
 MP9skpYaqu0KeQjRh+w/6Qz7CJ6d52qmxb6BGoVVQtUHhaas356GxQ7k/B02UkFhRf0xElGCEwz
 Hz5/dqN0ju9qibDaR1q1/TU/+QUo4gA2kJH4rXh8+teIvSuim8fcbi8RAu/gcefhLYTu/Y8Hm6x
 K/O9lM=
X-Received: by 2002:a05:6102:149a:b0:6ef:db57:ed3f with SMTP id
 ada2fe7eead31-6ff080ca2f7mr546376137.29.1780618175408; 
 Thu, 04 Jun 2026 17:09:35 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a803:5a2:541b:fe8d:21bb:2750])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96413d48caesm6081746241.0.2026.06.04.17.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 17:09:34 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20260604
Date: Thu,  4 Jun 2026 21:09:30 -0300
Message-ID: <20260605000930.542278-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Please pull from u-boot-imx/master, thanks.

The following changes since commit 74007f24a3aca13b70da6a2c098b830ad9e60804:

  Merge tag 'u-boot-nvme-fixes-20260604' of https://source.denx.de/u-boot/custodians/u-boot-ufs (2026-06-04 10:06:42 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20260604

for you to fetch changes up to 0fba623e4fd421bbea6e44156ea15a135d08576d:

  tools: imx8image: Fix FSPI alignment to 4 kiB (2026-06-04 17:27:17 -0300)

u-boot-imx-master-20260604
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/30353

- Fix RAM size calculation on verdin-imx95.
- Fix boot from SPI on i.MX8MM.
- Fix boot abort on kontron-sl-mx6ul.
- Fix the imx8 CPU market segment report.
----------------------------------------------------------------
Emanuele Ghidoli (1):
      board: toradex: verdin-imx95: fix ram size check calculated addresses

Frieder Schrempf (1):
      imx: kontron-sl-mx6ul: Enable CONFIG_DM_MDIO to fix boot abort

Marek Vasut (4):
      binman: imx8mimage: Handle nxp,boot-from = "fspi"
      arm64: dts: imx8mm: Generate FSPI header using binman imx8mimage
      arm64: dts: imx8mn: Generate FSPI header using binman imx8mimage
      tools: imx8image: Fix FSPI alignment to 4 kiB

Ye Li (1):
      cpu: imx8_cpu: Fix CPU segment information print

 arch/arm/dts/imx8mm-u-boot.dtsi                  | 13 +++++--------
 arch/arm/dts/imx8mn-u-boot.dtsi                  | 13 +++++--------
 board/toradex/verdin-imx95/verdin-imx95.c        |  8 ++++----
 configs/kontron-sl-mx6ul_defconfig               |  1 +
 drivers/cpu/imx8_cpu.c                           |  7 +++++--
 tools/binman/etype/nxp_imx8mimage.py             | 14 +++++++++++++-
 tools/binman/ftest.py                            | 14 ++++++++++++++
 tools/binman/test/vendor/nxp_imx8m_fspi.dts      | 18 ++++++++++++++++++
 tools/binman/test/vendor/nxp_imx8m_fspi_fail.dts | 18 ++++++++++++++++++
 tools/binman/test/vendor/nxp_imx8m_fspi_pass.dts | 18 ++++++++++++++++++
 tools/imx8image.c                                |  2 +-
 11 files changed, 102 insertions(+), 24 deletions(-)
 create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi.dts
 create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_fail.dts
 create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_pass.dts
