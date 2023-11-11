Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A85AC4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 15:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF7C786F6E;
	Sat, 11 Nov 2023 16:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ez2Z1DMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E98286F6D; Sat, 11 Nov 2023 10:10:31 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B970486F56
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 10:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=iuncuim@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c50fbc218bso35737971fa.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 01:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699693828; x=1700298628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3O2O4V6CSuG1Cqy5yAlLpJ562+hBN/VHyn3y1h4olQI=;
 b=Ez2Z1DMwdyoSeqqFjlqmTZJaJE3ZmGDffoW9xV7TBAhi+kdc/CZNqzhIpmwJdxn4du
 5P5azNql8tdnicSNeyQzRlpnJ3ce4JO/MNVPvOHPjM71aX27bAltqq2l0l+95x0ZGaZm
 YR4acSbIDGg8eqrDNBbhcWx4ng2LSluLw5tzTJ5WfUG4i3Nrf5KM7HXUrHAmdl1lUWwg
 n+lw76ysh9URJndEz1u3bjiLBkfxhTWVjGEfSh96Qsug2EUzjKJp/WhHM8VC5jVAp7kw
 FJ3wxCZNvDc6+K96G7cynGbhyJcneMZaBuTTegkTkq0NNykyxkghSvMx5E8KwzPoXqTj
 ehiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699693828; x=1700298628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3O2O4V6CSuG1Cqy5yAlLpJ562+hBN/VHyn3y1h4olQI=;
 b=DujTyjW2vcJUC6IGBLM1L436IX9Rg4IgaLryv3PEN4+olMuXX7UhblMjsMCBtPLIzf
 PnrF1oJ4wrC4p3OXIP0YDok59VI/NJ9bW0amgfJv5H8o3jfQROsaCibVItJLQY8dNfpw
 DGTC+7Nf3neU4Pf46rmP0sEOcaR2cx+1dmVMmyWmuv9UTi9Ir+vS9YZ0KGGhcTZ6lChX
 GWofgZ+0k4UTXZSNfee/xW7wJ90IUqgFHVCC5xDL9+VyyA9l5yeh12OBEjklMoK68wJU
 aSu4dm8kk3eDJUPfFenapuutenM4jMZxqW3hd6GWzMdNcdWt/BFhLYEK7uYl9PJtQnrF
 h/fw==
X-Gm-Message-State: AOJu0YytvYc1X8LdY5x/1kr11wawdxYdi7zQw0U56wCowg9s3e3cIHON
 2i3NafpnmwLA2V/tzOg7JeQ=
X-Google-Smtp-Source: AGHT+IEjkUxk3YCUC5gJw/on0YjXqIZNTjERhsEj2TSdJ/BvqH5Sclz00kTveH8YykY9v83K1k0c7w==
X-Received: by 2002:a2e:5c88:0:b0:2c6:edfd:658e with SMTP id
 q130-20020a2e5c88000000b002c6edfd658emr1095867ljb.52.1699693827594; 
 Sat, 11 Nov 2023 01:10:27 -0800 (PST)
Received: from SerialExperiment.lan ([193.34.225.90])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a2e864b000000b002b9e20d0356sm180866ljj.114.2023.11.11.01.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 01:10:27 -0800 (PST)
From: Mikhail Kalashnikov <iuncuim@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v4 0/1] sunxi: H616: add LPDDR4 support
Date: Sat, 11 Nov 2023 12:09:59 +0300
Message-ID: <20231111091000.26744-1-iuncuim@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Nov 2023 16:35:46 +0100
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

From: iuncuim <iuncuim@gmail.com>

At the moment, the driver only supports DDR3 and LPDDR3 memory.
Add support for a new type DRAM.
These changes have been successfully tested by me with orangepi
zero3 4GB (DRAM: Rayson RS1G32LO4D2BDS-53BT).
This patch should be applied after this:
https://lore.kernel.org/all/20231014170236.16211-1-andre.przywara@arm.com/

Changes from v3:
 * added LPDDR4 part for mctl_phy_read_training()
 * added the new part in mctl_phy_configure_odt() as LPDDR4 specific to
 avoid possible problems with existing devices
https://lore.kernel.org/u-boot/20231104062248.32938-1-iuncuim@gmail.com/

Changes from v2:
 * added default value for TPR6 parameter
 * added panic for unsupported DRAM types in switch/case conditions
 * added new line at the end of the timings file, changed the description
 * added a few small missing parts obtained from boot0
https://lore.kernel.org/u-boot/20231016053441.3197087-2-iuncuim@gmail.com/

Changes from v1:
 * replaced the phy_init array with one compatible with opizero3
 * added DRAM TPR6 parameter
 * adaptation to new mctl_phy_configure_odt()
 * added timings for the board orangepi zero3 4GB 
https://lore.kernel.org/u-boot/20230729111331.173768-2-iuncuim@gmail.com/

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

iuncuim (1):
  sunxi: H616: add LPDDR4 support

 .../include/asm/arch-sunxi/dram_sun50i_h616.h |   2 +
 arch/arm/mach-sunxi/Kconfig                   |  17 ++
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 218 ++++++++++++++----
 arch/arm/mach-sunxi/dram_timings/Makefile     |   1 +
 .../dram_timings/h616_lpddr4_2133.c           |  95 ++++++++
 5 files changed, 294 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c

-- 
2.42.0

