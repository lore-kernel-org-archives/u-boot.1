Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3C5C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1373381113;
	Fri, 28 Feb 2025 13:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A+ZzwayR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D30F810EB; Fri, 28 Feb 2025 10:53:45 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23CB8807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 10:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-390e6ac844fso1612441f8f.3
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 01:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740736421; x=1741341221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9508mspW/mpsEk2hTtuv8CpF5cwRruuGByMcpihOhMM=;
 b=A+ZzwayRL1eVBAOiRdjWBGJCHTk9N0A8eA78tBMxQi2UDRlBTCfV6xRzj5k/X3yMdz
 PYa6RV+xaBHIaU/vjGwZ9sEvaJXsFJBaerFT+hmra1zr78p31ofE1pRrMXhC60B/rgrV
 uZmZvXCPHcfWrFpkvmx6LncKO0/nGh6g+dtN3F4n3yVPIMAVd4DYd/V98KUh1WPMsJA/
 9qs5GSh/7Y37llLunbdi3S6pds51o7WVCXHjSSZ2RhLsHiOph04fE00kgWXNwMhh/JhC
 EHFcJ4TlFbI+Fn+qXhSTt0jOXnTAJ+8iEZO/Yw1CDKg/9bh94Hkc+k4ncVsEe0NIdSlN
 bsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740736421; x=1741341221;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9508mspW/mpsEk2hTtuv8CpF5cwRruuGByMcpihOhMM=;
 b=n8d5gu9Lk8Hi2WZf61l7eddwHxOHA9bY5DyMrVtK0owaqqQ74WD+LvxEBNNGsZobVq
 RGG4o30NC0feUAdV/ALPcpOIBy9Pzij7id8PORY7kSSVkms080zi+tqNjMggg1q9Qdq9
 eeey+j7u1uyRkxIEdmvICqDTyQZ8kfn7G5YljqdIfF/mRIK5EbgLeA5fwXxfll15o9ws
 lufOFggfd+ac3rssldbVxLPTutTKkJSpvx+FZXCjBp6gIV/icTJap+Alfx8sY78B4cwh
 a6IbMreH9GsT3jSHFVvCPMwIohznPFUNm0plIuHGRs9K80RM/YHdO8Au7a09x+cYzeAH
 Eteg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2YPJM9DFKMAB+kmVZSsl8Mk1VjTt3Q2Obz6HREiildXNUDSS08i33imiaTL2KaEuZQjTntoo=@lists.denx.de
X-Gm-Message-State: AOJu0YwJQZv4SsdUpotCV4Pcsz24ypJgvfA0N5fPeTEq+DYnJ8PEkTo+
 LTX8mHrOhsL9sNH38Op8AEp+adX+cJO3EOJ2juywdV7mhlpebBTm
X-Gm-Gg: ASbGncsJ6XnjZIO8vrtg8lMLwXE/4g/Ex0ARwEP+aEtpIHd99gNZkOt6udsoB0ccgtu
 44Ey8jKfgHqa5wWLBNECaUD4a/Xn0p8XG3iAJDfxD5d0GOIPxtBlctk2xcD6QtGN+isuPwEVtKI
 /A0cAQ5nkrthLH1MQREjejvoFiX8EAJaz8EZJkE5DhPzPR4bcWYkE/QWwDWmARHCYHlZI44FB+H
 C77zFhZtNOTWxscBJQTpQehNzU/wR+9bvY2/XicnZi9ZmneMVMAPO/nqpX4qc4srcSwYC4Z1rov
 sMLTgeb7RcsHono7hs9ybTes9iE7uBb0ZYwLpGFl8KjXitKOCCP1UiKQf3Hig680EELq6Q7mndZ
 2ENYa
X-Google-Smtp-Source: AGHT+IGvz2XT7/a0NaMuJcbfkCThnct7g42AgDmv05/plqoKVHWLhM6PvXfY0AqGjWNMCCAW2/j7wA==
X-Received: by 2002:a5d:6d09:0:b0:38f:2a7f:b6cd with SMTP id
 ffacd0b85a97d-390ec7cc305mr2152776f8f.20.1740736421241; 
 Fri, 28 Feb 2025 01:53:41 -0800 (PST)
Received: from ernest.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e46f580bsm4667401f8f.0.2025.02.28.01.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 01:53:40 -0800 (PST)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
X-Google-Original-From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Parth Pancholi <parth.pancholi@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v1 0/2] Support Apalis/Colibri imx6 v1.2
Date: Fri, 28 Feb 2025 10:52:52 +0100
Message-ID: <20250228095317.621037-1-ernest.vanhoecke@toradex.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 Feb 2025 13:45:41 +0100
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

Apalis/Colibri iMX6 V1.2 will replace the STMPE811 ADC/Touch controller
which is EOL by the TLA2024 ADC and AD7879 touch controller.
To support this new version, we detect the presence of either the
STMPE811 or TLA2024 during boot and set a new environment variable named
"variant". This will allow us to select the correct DT easily.

"variant" environment variable behaviour:
- Empty or absent for all versions below v1.2 (STMPE811)
- "-v1.2" for all versions starting from v1.2 (TLA2024 + AD7879)

This behaviour is then used by the PREBOOT logic:
preboot=test -n ${fdtfile} || setenv fdtfile imx6q-apalis${variant}-${fdt_board}.dtb

Ernest Van Hoecke (2):
  board: toradex: apalis/colibri imx6: Detect new v1.2 SoM variant
  toradex: apalis/colibri imx6: Select correct DTB for SoM v1.2+

 board/toradex/apalis_imx6/apalis_imx6.c   | 31 +++++++++++++++++++++++
 board/toradex/colibri_imx6/colibri_imx6.c | 31 +++++++++++++++++++++++
 configs/apalis_imx6_defconfig             |  2 +-
 configs/colibri_imx6_defconfig            |  2 +-
 4 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.43.0

