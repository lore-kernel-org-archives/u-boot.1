Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9C9CAC599
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 13:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 651268359F;
	Wed, 17 Sep 2025 15:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dpmsfr2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E766F835A2; Wed, 17 Sep 2025 15:33:45 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C13F833D0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 15:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-32e34f472d9so2302416a91.3
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758116021; x=1758720821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wLypglnM4hMb1fTA87xiOAKovdjsdgyGoGY4fe6K+Cs=;
 b=dpmsfr2W10b54iTsAT9eilKzqX12CZuEOHtsLYmJklyMftr7uXK6w5bmVogD0cGB9/
 YHH+l7Dx4ylsdvYzH/pv6UcuCCbc8OIpf5JY1xzWTHrL6eaAM5lE3UOEmFBHW6uqtvJB
 9Msi7dEc9W/dWf6J99GWWfW6J2HEw9VhxcjbRsy9jV0r2tDivpZ8xJHzvFJ2GXJr1BSr
 GFOPWQ9pyMmMZZgEw+t+EJoTAsbqfkV2SeW0s9bl+Yb1STxyiRH9I+cwjun3W2cyYmQI
 U2vawB6j3TONlQAh3kuPBybQIrGuT1IFndjhSoNkLPLmPTJHzxQxIVVDzA9HHa3SuAcH
 8VlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758116021; x=1758720821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wLypglnM4hMb1fTA87xiOAKovdjsdgyGoGY4fe6K+Cs=;
 b=AHI5r1r1WzqPMquWYCFFxuLe2E2erd/1Q6VY8dOWQELBtS64csRuOOGhfVCTQARF/9
 4gbwKvHXtKbFgMM98VCYRDnYEH/fDnNa6p/PUlEtILFWHeC2Rg7ykGETLlnr2NgANlZM
 938kNZkrOJAvZdVgbG1EHIKDAcm4iTj0+W1s/8TDGl2vPASrCy/KRaFs54GYA8sXWFpM
 djD85gflsvb/gThLOL6mOQ/hnVIW8wV39CVx4dfyafm9DxLWKB9AKdx14ZPrsJAdAJhR
 +pjJlrSNjMoDNnYtwqFPzcEIaHIqddPIn9B3Id6BGMuvcRRHvDjNyRsojAw/JR5RtvGe
 DP1Q==
X-Gm-Message-State: AOJu0YyHs2RoAdIBiGba+LvFg3DkDiRMn8ALhflgiLcwUgVD8vtHT7iV
 jd1HZUdWSZV8fpFetHNlTpFVQbkOTr2Ejx/Uw9rXMDeInSecTcQNjWa6
X-Gm-Gg: ASbGnctaWd+JeFZIf8VQ+OrSUakl9Ezqpd+lOIX13nTDM5vbsHs2K7OQ6iJY1siEOeK
 5dlKYkTPsUsO+XM6yedz6kVXZsJvrBK2Vmx/FadOxw2+RybeWLLd4r0fCY+WCaBDgYKLMWEid5L
 O2qxmHAP+V9R2d/hL7a3EjdNGHX+Rm/KaUiBRaNj13J0GPYCzyCe7oiqomU0FzfNaJ2QupBotbf
 1J+FownaE3x1ejA38W1IP/TmReWzaClHWYIqy07lazbMW27PmJAY7spLRmmrex2GfSkF2UfUk3I
 Fs9rabDrYP3a4W7ttt+hlh9Pn4zlvxFmFu7gA7/mUfVrjhRuSDC8q6SI25dUeCf3WXKyHP/SdKW
 m+VoZkL/1luPpUUX5ZmtAwnNC3FbmIV/9mZ1q/ovE1DG3+Gk=
X-Google-Smtp-Source: AGHT+IE73Ar5ur28dQRNFSKOLBRQbvNbESP9jCXCVV6OBfvDZjsFZfUcCiME/QnYd8rPtWweGP664A==
X-Received: by 2002:a17:90b:5145:b0:32d:d408:e86 with SMTP id
 98e67ed59e1d1-32ee3eb72b8mr2821491a91.7.1758116021308; 
 Wed, 17 Sep 2025 06:33:41 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1bb1:cfbd:5f3f:850b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32ed2689ac2sm2580731a91.7.2025.09.17.06.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 06:33:40 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250917
Date: Wed, 17 Sep 2025 10:33:36 -0300
Message-Id: <20250917133336.7975-1-festevam@gmail.com>
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

The following changes since commit b82fa9d752b025d3b5305b5b07debe6808a5d027:

  board: starfive: visionfive2: deprecate mixed-case product ids VF7110a VF7110b (2025-09-16 10:16:54 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250917

for you to fetch changes up to b3bbbf5fee21c7e4535cf24676609cfe64ff17fc:

  imx95_evk: Restore support for i.MX95 A0 silicon (2025-09-17 08:16:05 -0300)

u-boot-imx-master-20250917
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/27660

- Restore the support for the i.MX95 A0 silicon.
----------------------------------------------------------------
Alice Guo (2):
      binman: add a new entry type to support .bin file generation for the i.MX95 platform
      imx95_evk: Restore support for i.MX95 A0 silicon

 Makefile                                  |   3 +-
 arch/arm/dts/imx95-u-boot.dtsi            |  44 +++++++--
 arch/arm/mach-imx/Makefile                |   5 +
 arch/arm/mach-imx/imx9/Kconfig            |   5 +-
 arch/arm/mach-imx/imx9/scmi/container.cfg |  11 ---
 arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  16 ----
 board/freescale/imx95_evk/MAINTAINERS     |   1 +
 configs/imx95_19x19_evk_defconfig         | 153 +-----------------------------
 configs/imx95_a0_19x19_evk_defconfig      |   2 +
 configs/imx95_evk.config                  | 150 +++++++++++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst               |  42 +++++++-
 tools/binman/entries.rst                  |  12 +++
 tools/binman/etype/nxp_imx9image.py       |  89 +++++++++++++++++
 tools/binman/ftest.py                     |  11 +++
 tools/binman/test/350_nxp_imx95.dts       |  25 +++++
 15 files changed, 378 insertions(+), 191 deletions(-)
 delete mode 100644 arch/arm/mach-imx/imx9/scmi/container.cfg
 delete mode 100644 arch/arm/mach-imx/imx9/scmi/imximage.cfg
 create mode 100644 configs/imx95_a0_19x19_evk_defconfig
 create mode 100644 configs/imx95_evk.config
 create mode 100644 tools/binman/etype/nxp_imx9image.py
 create mode 100644 tools/binman/test/350_nxp_imx95.dts
