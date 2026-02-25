Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98ABEFD45F1
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 22:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C268366F;
	Wed, 25 Feb 2026 23:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uxu84EUY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF76A83AA9; Wed, 25 Feb 2026 23:50:52 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B635082A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 23:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-899a917a4feso4055196d6.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772059849; x=1772664649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mk9IMXnrmJAPiQZbDu9Ir17XellGE4E5ZSQNskcfz1s=;
 b=Uxu84EUYBDUUdk1v27iA4LyR+1erG8HZh6KullKcMEn/VGNqbdFBR4o5ykE7xtRdyd
 MhFP6h5FIqAb3doWUI7sV/cm7jRTpbuoGXAU/aU4JISHDmx6NqHw+LVw87oDTv/sBFdv
 8c65olbcXWQo431HPsUI5FdA2MPc0dUom8cjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772059849; x=1772664649;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mk9IMXnrmJAPiQZbDu9Ir17XellGE4E5ZSQNskcfz1s=;
 b=sw2Co/QrzNOd00A1Gy7Gd+m+Nv4KVKPqjA4v8SWOMFG36roGR5nLmDNyAud8A8mJwK
 uFfjbiztjW6Pfjqqi+WIxYGuSfJ1juzvfeuSZCFT2YXFaUBq9CEiMZh3B19cUZbMjl4o
 Mjy1uHW5PLaFMmqUW5/PfMdBiZXmNwBH2OWhNPkUGf3oQZp4qK4TJBZD3ZuToNYjX+y5
 osIUg1qS6Q3peo9XIsF9vowlFdxdhH05Qeehumxp64uxPFOmdVGcT370lCI5ubQ9ZH6R
 5xaQ2jzg+JX8OL88xRRBHXhj1OqfX5uZ7wBcnA5ZD3ENPkDFQsfxTsSvDqqTOvXZf2aC
 fsYA==
X-Gm-Message-State: AOJu0Yw0YWdg2UsUS74e0iW/KnL0GL+65vmRsvvGaACAhXm+MSSM3rhZ
 ZF/XuEOaw9LhSOVtAH+BLeNb1uxIv+geAONmKOvtXfM+yaahq3LekfJVOmD+ti7YAHNTmIWeHP9
 Z6sI=
X-Gm-Gg: ATEYQzx3Ms8C8t7uSJ7HyFpSpbwbJ+2IdgdDrpkbyqA3Cj2tmX5MIAIZRWps9sSgpke
 eAYfYkuCiyM93D9QB8k3pUdmrCS6Db+wTzrdocYEzOOHAM2IzG0M7rHJE1MRfOIAO6fNJggHDcx
 wUoAxL7Jtd79nFkmtyzSmEw/Fy6T1LpVdRPAz7VcaJpKCBvvRbuUMs46tzZ/YnDAHifRYvJiHeK
 4H6bexzBRvpVModgBoBVXZpK2MZz1khhfUW3lPHIfoBNo/emneSr6ZwsvcxQt5mjg2geA3ozvjD
 oYf+DauPVpL++iB9j2aYtsCUwdHp+M7lWJUomJsTCfuMR8MwLYMq/BiENeZzPNwqS+bbBDJWkLh
 RZmEXoXDshnRRYS/Hqj8OZ3OJllMkN/6Ul9r3dgDl+JNRLEDpM6682W/YghQTR2WW9Vm2N2Nu2c
 pCbFhXVxep8ui4rou5FDbyKcFliLPs
X-Received: by 2002:ad4:5ccd:0:b0:897:2b23:3a7d with SMTP id
 6a1803df08f44-899c13b94c3mr32207106d6.2.1772059848951; 
 Wed, 25 Feb 2026 14:50:48 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf72e21bsm43730985a.44.2026.02.25.14.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:50:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>, Alice Guo <alice.guo@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 0/6] binman: test: Fix iMX8 coverage and test-numbering
Date: Wed, 25 Feb 2026 15:50:29 -0700
Message-ID: <20260225225040.2568118-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

A long-standard niggle with Binman is that the iMX8 integration does not
have full test coverage. Recent work has made a significant improvement
but there is still a special exception for this code.

This series adds some extra tests to get to 100% code coverage.

It also tidies up the test-file numbering, which has rotted a little.


Simon Glass (6):
  binman: test: Renumber duplicate test-file prefixes
  binman: test: Drop the number prefix from non-dts test files
  binman: test: Capture output from tests with warnings
  binman: test: Fix code coverage for iMX8 and cst bintool
  binman: Remove the coverage allow_failures list
  binman: Drop the allow_failures parameter from run_test_coverage()

 tools/binman/ftest.py                         | 156 +++++++++++++++---
 tools/binman/main.py                          |   7 +-
 tools/binman/test/339_nxp_imx8.dts            |   3 +
 .../test/{225_ti_dm.dts => 351_ti_dm.dts}     |   0
 ...g_phony.dts => 352_ti_board_cfg_phony.dts} |   0
 ...drfw_imx95.dts => 353_nxp_ddrfw_imx95.dts} |   0
 .../binman/test/{347_bl1.dts => 354_bl1.dts}  |   0
 ...> 355_key_name_hint_dir_fit_signature.dts} |   0
 ... 356_key_name_hint_dir_spl_pubkey_dtb.dts} |   0
 ...car4_sa0.dts => 357_renesas_rcar4_sa0.dts} |   0
 ...ize.dts => 358_renesas_rcar4_sa0_size.dts} |   0
 .../{350_nxp_imx95.dts => 359_nxp_imx95.dts}  |   0
 ...ngine.dts => 360_fit_signature_engine.dts} |   0
 ...s => 361_fit_signature_engine_encrypt.dts} |   0
 ...ts => 362_fit_signature_engine_pkcs11.dts} |   0
 ...63_fit_signature_engine_pkcs11_object.dts} |   0
 tools/binman/test/364_nxp_imx8_csf.dts        |  26 +++
 .../test/365_nxp_imx8_csf_fast_auth.dts       |  21 +++
 tools/binman/test/366_nxp_imx8_imagename.dts  |  27 +++
 ...40_dummy-rsa4096.crt => dummy-rsa4096.crt} |   0
 .../test/{340_openssl.conf => openssl.conf}   |   0
 .../test/{340_rsa2048.key => rsa2048.key}     |   0
 .../test/{340_softhsm2.conf => softhsm2.conf} |   0
 tools/u_boot_pylib/test_util.py               |  15 +-
 24 files changed, 212 insertions(+), 43 deletions(-)
 rename tools/binman/test/{225_ti_dm.dts => 351_ti_dm.dts} (100%)
 rename tools/binman/test/{323_ti_board_cfg_phony.dts => 352_ti_board_cfg_phony.dts} (100%)
 rename tools/binman/test/{346_nxp_ddrfw_imx95.dts => 353_nxp_ddrfw_imx95.dts} (100%)
 rename tools/binman/test/{347_bl1.dts => 354_bl1.dts} (100%)
 rename tools/binman/test/{347_key_name_hint_dir_fit_signature.dts => 355_key_name_hint_dir_fit_signature.dts} (100%)
 rename tools/binman/test/{348_key_name_hint_dir_spl_pubkey_dtb.dts => 356_key_name_hint_dir_spl_pubkey_dtb.dts} (100%)
 rename tools/binman/test/{348_renesas_rcar4_sa0.dts => 357_renesas_rcar4_sa0.dts} (100%)
 rename tools/binman/test/{349_renesas_rcar4_sa0_size.dts => 358_renesas_rcar4_sa0_size.dts} (100%)
 rename tools/binman/test/{350_nxp_imx95.dts => 359_nxp_imx95.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine.dts => 360_fit_signature_engine.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine_encrypt.dts => 361_fit_signature_engine_encrypt.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine_pkcs11.dts => 362_fit_signature_engine_pkcs11.dts} (100%)
 rename tools/binman/test/{340_fit_signature_engine_pkcs11_object.dts => 363_fit_signature_engine_pkcs11_object.dts} (100%)
 create mode 100644 tools/binman/test/364_nxp_imx8_csf.dts
 create mode 100644 tools/binman/test/365_nxp_imx8_csf_fast_auth.dts
 create mode 100644 tools/binman/test/366_nxp_imx8_imagename.dts
 rename tools/binman/test/{340_dummy-rsa4096.crt => dummy-rsa4096.crt} (100%)
 rename tools/binman/test/{340_openssl.conf => openssl.conf} (100%)
 rename tools/binman/test/{340_rsa2048.key => rsa2048.key} (100%)
 rename tools/binman/test/{340_softhsm2.conf => softhsm2.conf} (100%)

-- 
2.43.0

base-commit: 8fd76675efbe7af785ccc1ba1ac8b9f7e10f6715
branch: binh-us
