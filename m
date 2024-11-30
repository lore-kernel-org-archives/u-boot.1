Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E1AD735FE
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 11:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C9988F45;
	Sat, 30 Nov 2024 12:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A2ofPqUm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DD9C8945B; Sat, 30 Nov 2024 12:01:52 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4752688F24
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 12:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-215666ea06aso1329295ad.0
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 03:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732964508; x=1733569308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8X7pHcN6AgMrb7+wXSYzp7N/hLPXxoAFPu9nHYCzXqs=;
 b=A2ofPqUmnL2Vp28luvOJKe6/flaAGlvJZrRryGUHrqDhSTw3l1MlrBHgO6meJSw2B/
 srivzZyjxS9LKd0qVYXzio2xnlHiCzdDtha9PXbwI5yvTgPbIyAfaKZHduC76pfbYWHv
 Ql9QNWWqYQYkwoCYS5HBa4nLnIG+9kN3TDS3mDkTWCyDEav27xEpYgSXXqmEH5XL4WeR
 0ZR6inH+G/M1Coy//2eqdgg6gzAOqVmkXq01KfI2ZUf7+gbA1ae4ezIIAJHfiMrobJPG
 LwFz72pSzZihvTedeW4Z+pFex+Z921AIfpdX+kjI/Kzn1nZT2QNOXxFywXHD5OEYHCjA
 E5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732964508; x=1733569308;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8X7pHcN6AgMrb7+wXSYzp7N/hLPXxoAFPu9nHYCzXqs=;
 b=TyXQVR0NIJasaza0UqLlBUxmCIBgRRx8DNpjPRON+9PDv2cYB9cVdTxgoGt1zsmXP1
 1FqME0RYg3VWwwoYOkSEKc8csFeqfKBvEtdykrIb44tcSY9kTrvq9n1u1JquY6LW66Iu
 bmuzSwOaPFgKjFTfszVy5uWCFHz4qEtU5NcoC7+bcuqm+Ut/abgaroCR8Yx0vasNnMpJ
 HoEImwoZ1+6GQE+oXXb7v2mnrrGePGJITGsI17RBveq7Gha6NeAxHK9yMcsGTw+ZzoKV
 9gtRk7ZikMwOTFStnjtouBLuCeZWQPf0sP+aDdPbXbpwr6J1NFUDsbwOwUi1s5zA6pYf
 sfPQ==
X-Gm-Message-State: AOJu0YxfgAhCg+4rwe5u92hfQaseymK424b/8Hvvby2EnTN6VHjam+pg
 02JZHzHN7/MowzadLOwRdg+veSlSK/hUoXKPboMk31psvQDh3sv3Qn8O1A==
X-Gm-Gg: ASbGncuoq528xMtPzvSp4tGko9sT86dPw77D9eWTvLpLKVPlTKvvh9z+XBw/885kdmp
 ktjN+Kr9vg17USqP9cbTVoosUdJXWBREpPm5G3XDa1RIWoH9+iPAW0w0HMMNKl8IOpRt6TSXKh+
 GTyrLkKo7wLQdJagL5X9j4A+ehseFj/M6lFtw5VpC0e7ScROR3efL7b8qWDPNYTfOlRUUxdb5Pn
 J8NQ0YtDiLv9hVXEiHXKh+fy0YKmRdr9ZR9mE7nEKA1W3WeKu8mCQDO+2ymBxWC
X-Google-Smtp-Source: AGHT+IEiVp0XoGXOKMAU4VoE+b0NrXTQJVxVpMTHJuUBzsBg5wCkfToLuSdGmGgMg5HMdTLsvVuynw==
X-Received: by 2002:a17:903:41c2:b0:215:5a82:3f99 with SMTP id
 d9443c01a7336-2155a8241a6mr30579785ad.22.1732964507626; 
 Sat, 30 Nov 2024 03:01:47 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:369b:92c1:68b8:393d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21521969fb7sm44341025ad.155.2024.11.30.03.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 03:01:46 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20241130
Date: Sat, 30 Nov 2024 08:01:43 -0300
Message-Id: <20241130110143.318222-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit b51b97e9be1c0674345497a173e7b693866985f3:

  Merge https://source.denx.de/u-boot/custodians/u-boot-riscv (2024-11-27 07:34:17 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20241130

for you to fetch changes up to 4835efca7a004fab62853f3e6bbd2854d1df503b:

  ARM: dts: imx: Enable PCIe and NVMe on Data Modul i.MX8M Mini eDM SBC (2024-11-29 09:20:47 -0300)

u-boot-imx-master-20241130
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/23643

- Make DRAM coding GPIOs available before relocation on Data Modul
i.MX8M Mini/Plus eDM SBC because the DRAM configuration GPIO straps must be
accessible in SPL and before
relocation because the GPIOs are sampled both in U-Boot SPL as well as early
on in U-Boot proper.
- Pick safe DRAM size on failure on Data Modul i.MX8M Mini/Plus eDM SBC instead
of failing with hang() or panic().
- Replace YModem with SDP on Data Modul i.MX8M Mini eDM SBC SPL since SDP
is much more flexible.
- Deduplicate Data Modul i.MX8M eDM SBC defconfigs.
- Perform plain boot in altbootcmd on Data Modul i.MX8M Mini/Plus eDM SBC.
----------------------------------------------------------------
Marek Vasut (6):
      ARM: dts: imx: Make DRAM coding GPIOs available before relocation on Data Modul i.MX8M Mini/Plus eDM SBC
      ARM: dts: imx: Pick safe DRAM size on failure on Data Modul i.MX8M Mini/Plus eDM SBC
      ARM: imx: Perform plain boot in altbootcmd on Data Modul i.MX8M Mini/Plus eDM SBC
      ARM: imx: Deduplicate Data Modul i.MX8M eDM SBC defconfigs
      ARM: imx: Replace YModem with SDP on Data Modul i.MX8M Mini eDM SBC SPL
      ARM: dts: imx: Enable PCIe and NVMe on Data Modul i.MX8M Mini eDM SBC

 arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi |  25 ++
 arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi |   2 +
 board/data_modul/common/common.c                   |   3 +
 board/data_modul/imx8mm_edm_sbc/spl.c              |   6 +-
 configs/imx8m_data_modul.config                    | 221 ++++++++++++++++
 configs/imx8mm_data_modul_edm_sbc_defconfig        | 267 +++----------------
 configs/imx8mp_data_modul_edm_sbc_defconfig        | 291 +++------------------
 include/configs/imx8mm_data_modul_edm_sbc.h        |   2 +-
 include/configs/imx8mp_data_modul_edm_sbc.h        |   2 +-
 9 files changed, 326 insertions(+), 493 deletions(-)
 create mode 100644 configs/imx8m_data_modul.config
