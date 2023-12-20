Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEEBC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 18:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AA5986A81;
	Wed, 20 Dec 2023 19:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bTRZ8kkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C99F7875E9; Wed, 20 Dec 2023 19:42:24 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 698D086A81
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 19:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6cdf3e99621so1040755b3a.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 10:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703097739; x=1703702539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vK44QkMAOAAvN8DltD5Q3TC7qnrMqJjjE66GdB8cb5A=;
 b=bTRZ8kkc5kGhyALRSjJkGLd4KzGktWG949nmgp0dJhDptxvbsQL1cufWBSOEm2zooE
 /K7CCP9aTPpjWWzhA/vJwIio23uPX1Q+jz9xjcNmh/ZBVYekDlmq5SbsvMRZS1USHlRr
 EqLTrxP3Cdu858UNO6gJ85/60elMX4OH70aCxw+B71WfxiItdG6mZywoleJoUgi9YkMr
 Os6bdTSKxfnWluvpgAn98avy0T4mwi4OBuwcLsN5CmT7o9bvnTBxOqzcuRAwwOuGnXaJ
 i+HEXknmQZZAoK9QgGcbD2LlJppXu8OFTsuh7hZe477kx6L5k3Gj0k7FzAh0EQOZ88rj
 PU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703097739; x=1703702539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vK44QkMAOAAvN8DltD5Q3TC7qnrMqJjjE66GdB8cb5A=;
 b=rMdJww878dcjUVXlSyCryXrXB734fw5d12SQdW/i5XtG9hfe+V4ciIZRTJd+YeZJye
 hXVScu7TzeaYQqaa5enCPsJzj5NH1TEHQHfuWmIpKXFWlLf2exIp+w4d5lmDwg5UPbD2
 Xcs/vljl1A334mcTRmeKLApHzPBfjBEkR+/D+tXpFqPSRuhP7nYk9mybKkwnrDBQJZKC
 LOVFTl05ck2n66YB8NcWmnggcXJbrLixOEk0cbndKSjlhpqrsqOJGf9sFadGngP5DSmO
 PcU05jsgTISPwM7KmpCvdDFjsFXPyvg+nJUSMg5NdUxIu7JOBS7FzAh0FFiKuDTimuaO
 z4eg==
X-Gm-Message-State: AOJu0Ywr/khjmTH4kVoKHGilE7LkSvJdPdmAhMxG85SO0K33wv+aD0tU
 WMZVgVhmoFlJVdnSaDaZd4g=
X-Google-Smtp-Source: AGHT+IFfnc1fy+TUkgee2vVrbF40bxur6am3wHz39jWT9xOlfJmAlDXlHDUEt3tQDtfkFdKKgZXRqg==
X-Received: by 2002:a05:6a00:4b4a:b0:6cb:8347:c8b1 with SMTP id
 kr10-20020a056a004b4a00b006cb8347c8b1mr43048537pfb.1.1703097738680; 
 Wed, 20 Dec 2023 10:42:18 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4f39:a3af:6ee6:81ee])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a056a0023d000b006cee656cb3fsm87823pfc.132.2023.12.20.10.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 10:42:18 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: sbabic@denx.de,
	marex@denx.de,
	u-boot@lists.denx.de
Subject: Pull request: Please pull u-boot-imx-master-20231220
Date: Wed, 20 Dec 2023 15:42:13 -0300
Message-Id: <20231220184213.1448425-1-festevam@gmail.com>
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

Please pull these fixes from u-boot-imx, thanks.

The following changes since commit 3ac22891cfc0dc6d8eec25d2b0fbdd2eb8f3d3ed:

  Merge tag 'u-boot-imx-20231214' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2023-12-15 08:22:31 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20231220

for you to fetch changes up to 1f25c75619d7fdacbaa8c2c9c152ebc9aec807b3:

  ARM: dts: imx: Power off display output on Data Modul i.MX8M Mini/Plus eDM SBC (2023-12-18 20:25:57 -0300)

u-boot-imx-master-20231220
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/19007

- Make DRAM stable on i.MX8MP DHCOM SoM by using FPWM mode and updating
the DRAM timing
- Fix display artifacts when booting Linux on i.MX8M Mini/Plus eDM SBC

----------------------------------------------------------------
Marek Vasut (3):
      ARM: imx: Force DRAM regulators into FPWM mode on DH i.MX8MP DHCOM SoM
      ARM: imx: Update DRAM timings with inline ECC on DH i.MX8MP DHCOM SoM
      ARM: dts: imx: Power off display output on Data Modul i.MX8M Mini/Plus eDM SBC

 arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi |  49 +++++++
 arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi |  48 +++++++
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c  |   5 +-
 board/dhelectronics/dh_imx8mp/lpddr4_timing.h      |   6 +
 .../dhelectronics/dh_imx8mp/lpddr4_timing_2G_32.c  | 130 ++++++++++--------
 .../dhelectronics/dh_imx8mp/lpddr4_timing_4G_32.c  | 149 ++++++++++++---------
 board/dhelectronics/dh_imx8mp/spl.c                |  33 +++++
 configs/imx8mp_dhcom_pdk2_defconfig                |   3 +-
 configs/imx8mp_dhcom_pdk3_defconfig                |   3 +-
 9 files changed, 310 insertions(+), 116 deletions(-)
