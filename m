Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0DDC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 16:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F57830E4;
	Fri, 11 Apr 2025 18:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m8C0uOIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 723D883F15; Fri, 11 Apr 2025 18:15:23 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A25882C10
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 18:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1c6ff8so3914728a12.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744388121; x=1744992921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B82T6hTq1hpiLL619M0lvAUvNB79dDXvEfvWCAV78iU=;
 b=m8C0uOIeDfpkfUxBJTuA5SGlqXFc9keP6wOw34/DHDdVIQmJk2OHEzkx2HsWMxBdNe
 NeVwVspw8YSmXDRfJHcz4V9qaMZFcMkLuxmKxy7lEsdOUMSEg/CSBQHpAFcVc34aKbR5
 F904P2QhgET8kvId1KsmdfPXzAXl2V+9ZSzCdvLqd9i+/S/3qNVsbx+ew+uox7LWiq95
 pcU5Ku/zXQVtEvxELT3t+bFqvd79G2JnRlUn014rgl8PT+AHwyhns+4yTji7M04BkXFq
 B84JS/WsAM2E9KPj3vFPFxT6EUoI8U/NAPkdrvfsakakubP0BI3F79pW1I00VnPYlpbl
 fyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744388121; x=1744992921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B82T6hTq1hpiLL619M0lvAUvNB79dDXvEfvWCAV78iU=;
 b=n2o6sh1vlOTyUxRi8a67FbNqemk+A78sJ5wo0jx6YibsxLVUDC9BSmltR0O49urVUF
 93JJ429VG/P66suk+Z4753Ko5gpmAqNWYoKbjPTAAZ2/jIpeq37Ze+lhYVjA9RKhs/I9
 0Zz2z/F+nSLNLyFxXDuWL3JQCLSHeiGMZN94iPk9MQl50V1ADV/dHkSH+TF3mXxia//U
 LpniWhFaXr9Bb8pCR8htRRzsh5o5jU9Pp6rk5HCC03MOa6JHyGFUigHyR822Ac4Ljt8k
 FkMskDqfeCIpH6l+dPbCwOmdsLsKSCRxI/KZRVbU3bMPc5f3w+lTIN/v6MaX4YByt8Do
 jtcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrEznLmU2OaqrElT+rUlHAh1T8Se6SV4AXD8Y12apr/4e8rDjYCzx4/HhYRq/cCtODxDVTJXo=@lists.denx.de
X-Gm-Message-State: AOJu0YxPbdriVSYnMAVOTYl5q71Gj26sAtm78z263whgTSe7Rgktpw+S
 8Fp11C58TYii142iUSaVOmhtFnBoM+qSRbwBMc4GiKmEeUPmXytV
X-Gm-Gg: ASbGncvdMN2OX/iqijrCv8erji2SNRACMOanq3S2lt/vKeEWYIk+uFT/VMOi8WpweEg
 nuOOM47keNpxAujAR9KSE0R3nFah19IJJDTeZYuITIHJ3A8tYXB5PuIQUIOk+KrBNFar7frqDxK
 +IhLGOC2Tz9aP3uXAJfb2diCnfN24U+NcMavm4HGNDeM61cN9nhIKdZswxQ6PSjDSWVDwS/xxoy
 CK1eSynFt9NPY5VZe7Nto6AXGgW6Zyj4jYjfuXLe5tXHpohnxtDt15SYML7vV8YyIxg8SxeNufW
 ihTb1v2wfQdfyHQ+IPPA9Y4JeUxFE+vYd2gYYyPxBkKQslU1QfgvKEcIWg==
X-Google-Smtp-Source: AGHT+IHZJViaxeqVafycWAgWlTemVq3b4nQ8w/rJUTay+2pLVM9l8CR+QSyv/Be/fCnA5kzma/FppQ==
X-Received: by 2002:a05:6402:42c2:b0:5ed:17d9:91db with SMTP id
 4fb4d7f45d1cf-5f36fbaaeeemr2725083a12.12.1744388120556; 
 Fri, 11 Apr 2025 09:15:20 -0700 (PDT)
Received: from localhost.localdomain ([80.90.89.143])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f36f526da3sm1136246a12.67.2025.04.11.09.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 09:15:20 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: jagan@amarulasolutions.com,
	andre.przywara@arm.com
Cc: trini@konsulko.com, macromorgan@hotmail.com, uwu@icenowy.me,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/5] sunxi: h6/h616: consolidate DRAM code
Date: Fri, 11 Apr 2025 18:14:34 +0200
Message-ID: <20250411161439.4743-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.49.0
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

While working on A523 support, it became obvious that newer sunxi DRAM
drivers are similar in many ways, so it makes sense to share some code
between them. Let's start with DRAM size and ranks detection. There were
many fixes for it in H616 driver, so make sense to unify code interface
and split out h616 part into separate file and reuse it for h6 too. This
will probably solve some DRAM size detection issues on h6 reported
through the years.

Patch 1 adds more error reporting in case rows or column size is not
correctly detected.

Patches 2-4 bring h6 code close enough to h616 so code sharing is
possible.

Patch 5 splits out h616 code and reuse it on h6.

Note I'm currently not able test the code, so if anyone else could do it
I would appreciate very much.

There are further possibilities regarding code sharing in the future,
like:
- memory controller is pretty similar for H6, H616 and A523
- unify config and parameters structures

Best regards,
Jernej

Jernej Skrabec (5):
  sunxi: h616: Panic if DRAM size is not detected
  sunxi: H6: Remove useless DRAM timings parameter
  sunxi: H6: DRAM: Constify function parameters
  sunxi: h6: dram: split dram_para struct
  sunxi: h6/h616: Reuse common DRAM infrastructure

 .../include/asm/arch-sunxi/dram_dw_helpers.h  |  22 +++
 .../include/asm/arch-sunxi/dram_sun50i_h6.h   |   9 +-
 arch/arm/mach-sunxi/Makefile                  |   4 +-
 arch/arm/mach-sunxi/dram_dw_helpers.c         | 160 ++++++++++++++++
 arch/arm/mach-sunxi/dram_sun50i_h6.c          | 180 +++++-------------
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 145 +-------------
 .../mach-sunxi/dram_timings/h6_ddr3_1333.c    |   2 +-
 arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c  |   2 +-
 8 files changed, 247 insertions(+), 277 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-sunxi/dram_dw_helpers.h
 create mode 100644 arch/arm/mach-sunxi/dram_dw_helpers.c

-- 
2.49.0

