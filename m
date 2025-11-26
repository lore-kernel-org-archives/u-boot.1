Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60083D10F21
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 11:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB7D841B1;
	Wed, 26 Nov 2025 12:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bppHMuWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B2F4841B9; Wed, 26 Nov 2025 12:05:39 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF96836D3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2980d9b7df5so80923245ad.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 03:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764155135; x=1764759935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LH3EaEp5GJiAGyhI+udxxDHbC2SWDVwTuioej5VU64k=;
 b=bppHMuWHnPAH0WOniA9SlN7WZPw8kaU+WgVaINqQh7D/ygx5OIB4eWDMd6+Hvbub+h
 +7DZyudLsX3ja/N5eNfspyz0p6KcsJlJZCiWH6vJJ00irCfimWivOGiTFRYqxurU7HM3
 VclinVPm9s0+Fd2aUKsRvmBsogVbuynamZcP4JxnV/jIKkr7FPLiiMFILrskEHbcWlUC
 GmlYEQbYn6ieoZtqiL2eSnjI5Aq+57fw/vbMJgLjDiLscvvAA3sBiH+X5iboRk40U2+L
 rb8fQip7Mkax09X3RnCjyx3YPlRszp+Yljgtm2Tf6+ZN7jd+DXoYpE2igFAKkvOJFQby
 CxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764155135; x=1764759935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LH3EaEp5GJiAGyhI+udxxDHbC2SWDVwTuioej5VU64k=;
 b=gmSz0QzlDxKUw1a81dzhzcAyBInPDYnIBlGqmHFEjhIQQmq4Zr39PiTDcyXdGotxWV
 Ql43NxW7FzlhKI2NJV5I+HEV4ID5pg787QWM6OkGUIUfUAramlwAkrQpe7umQQ8vDn5S
 +mCI9ZrYEr5PpLirNI9DW3bynf++Iz80yoA281CEAg2NHN/bFaW4qQelndEd2Mr9kHks
 tNNxw7S/rgrKKQA/oFK+90fWOKCi1cHjj+ciA54NQlkRZXoBcurxoz98OkasELMQJ6Xd
 sDcJmaC+rZ6nLeUISBCUG+VCuV/7iLVdxeSnpy719B2aJg1ZVHGpDOTrgSxuy1BEE915
 fVlA==
X-Gm-Message-State: AOJu0YxCJaPm40B7dqc7MDxIuAqxgF09X22JeJWlncx0kIgjHe7TG7QG
 ZS1TNxwROUM5iR/Hs2L3mKub8C0bBgP97t0lQU/1Ndlghcrti2MGRlrtz+15hAGC
X-Gm-Gg: ASbGncuqzotBgjbejAJZo9VJoanJ5oy3wIHdFF76yNahWoZc3U7fIMpYMzTRm6rsVZ+
 jqd5/O8TSIdeXreAYT6GQuhk07qv81wScjUEtBt5d4vWH8YRpolQVOvqT48kk9QfnUWyWCmukgS
 6YccN/eg7O6M6LeJjZ+A6c9JNK0TlxBriYuLiZ/oG59u2dFNHlIJLrr3sqTU7bHQeyUmdimWkbQ
 FaI8Fhll5fR19knIEXcH4n6FpP0QefEqvv38H9KnqLDhLWBN4qjdiIskkNY2BpRjvNrwLUhN1TU
 +ZJR/CRE3wB8GnmbYef0miQ9Jq2YuPmxstttLUhK7BNEChxL18kuIB7fPqhQSknHSv/xKq2QknA
 M0kHNEccNyaj2Zk+uBYNRvFmmP+AFj7+1Vh3WXfvoG9cVXuVX4DL/LWMPRFtJAcSTFjuUMJ6Aau
 70rid7T5yqcUSfwGQGQqdCZV8=
X-Google-Smtp-Source: AGHT+IFT41BsMbFZ0US7OAwabrKZwaC3MSlsqX7ZYuEL1m/2WnN/cZirzgv0li8jmmhzKrNj3rGwQw==
X-Received: by 2002:a05:7300:bc83:b0:2a4:3593:6461 with SMTP id
 5a478bee46e88-2a7191414e4mr13903122eec.17.1764155135221; 
 Wed, 26 Nov 2025 03:05:35 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:86e7:697:5952:7538])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a6fc5b122dsm71217575eec.5.2025.11.26.03.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 03:05:34 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20251126
Date: Wed, 26 Nov 2025 08:05:31 -0300
Message-Id: <20251126110531.2307363-1-festevam@gmail.com>
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

The following changes since commit c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9:

  Prepare v2026.01-rc3 (2025-11-24 09:27:35 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20251126

for you to fetch changes up to e2c435bd0aafa87d15c066cf45ca53c50981ffca:

  arm: dts: imx8ulp: Disable wdog3 until DM watchdog support is available (2025-11-25 21:54:53 -0300)

u-boot-imx-master-20251126
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/28502

- Fix i.MX8ULP boot regression.
- Fix colibri-imx7 fdtfile overwrite.
- Fix some i.MX91 pinmux macro definitions.
----------------------------------------------------------------
Alice Guo (2):
      arm: dts: imx8ulp: Ensure mu@27020000 and lpuart5 availability during all boot phases
      arm: dts: imx8ulp: Disable wdog3 until DM watchdog support is available

Ernest Van Hoecke (1):
      configs: colibri-imx7*: set 'fdtfile' generically in PREBOOT

Francesco Valla (1):
      imx91: fix pinmux macros for ENET1_TD3 and I2C2_SCL

 arch/arm/dts/imx8ulp-evk-u-boot.dtsi        | 12 ++++++------
 arch/arm/dts/imx8ulp-evk.dts                |  4 ++++
 arch/arm/dts/imx91-11x11-evk.dts            |  2 +-
 arch/arm/dts/imx91-pinfunc.h                |  4 ++--
 arch/arm/include/asm/arch-imx9/imx91_pins.h |  4 ++--
 configs/colibri_imx7_defconfig              |  2 +-
 configs/colibri_imx7_emmc_defconfig         |  2 +-
 7 files changed, 17 insertions(+), 13 deletions(-)
