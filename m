Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEF0C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 11:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB5487B1D;
	Wed, 17 Jan 2024 12:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OPllF88f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D9EB878A5; Wed, 17 Jan 2024 12:14:09 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB61F87B4B
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 12:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-559d3fbed6bso653611a12.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 03:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705490045; x=1706094845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N7qR7G8jxbuhXJvLrnLDcnLZUW70OemVGd8EFOoAGM8=;
 b=OPllF88fnhS2sg3gTQL8cVbw79iHM7fKbFDdCmiSSLBvnSKgen5wu1QuluA/keLOp1
 Lc7Gkt+fvXs84uhdMBNmEAL7jS5Pf/PbdinbUwiNM9xGAqZLQJoQ4APvil3faMduUbrF
 igsavCGyAua9e37xjMhMOUbWywzJh+AKRH+B84KVsSZ8XliMqbakGBzdByTZJ83AcDQo
 6SnlDZE4RiSfh1IZT6Ujt/EB66dXmT7GU4zbxmprRKzdy/IGnooBUiVNaMFmV6v3RHA5
 G8LFpNJLzr1xI4MbGS9Qcins07wv5uMobTKbhXU279Z/PBI5mT/fjxolejB9VZP9/IW8
 AVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705490045; x=1706094845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N7qR7G8jxbuhXJvLrnLDcnLZUW70OemVGd8EFOoAGM8=;
 b=EpMEVIBhDLPSBpJYRzdhvHarlxbpaubj5U9NMYkGrBrnxYvoN0cx04TSj3oyHPk3Tk
 CMQQVuvPrnCciPuuB0Jv5XrleCOA3EurDa9rL9t1KNkT1J+BtgLK9qrLemA5RvsWuJX4
 OvlYsUJujwZXVqDnU+vNDczPNmsSAmalpSkyvdVXKXc5JyhPBsqb60UYsoX0uWG6YQbm
 4/izY9iWpCP/zOgB28VZF5mGNppQEMpP9vIhwB7615R0lA6RL0fbF0VPr1dJhYsecftX
 UUhWSbWgpMhhnppetkZ8eRZunT0plsuzRjAQESsASkEpU/AJlPjmvacWeXRZN/TSeTga
 m7mA==
X-Gm-Message-State: AOJu0YyOgMkWlGBInRbmRwvg9xOadpodwtsXOAHSBaNrSwJc7BzjJwHN
 q9Gb3VRalqYMkMJe/rgsI4k=
X-Google-Smtp-Source: AGHT+IFLJ7xleaVPHW40knX8EI09i3FIVADd4jF2C0XoIYwCXt48L4fqQACrgWTfdhVFPDbFFCnLcQ==
X-Received: by 2002:a05:6402:f81:b0:553:7a3f:3d63 with SMTP id
 eh1-20020a0564020f8100b005537a3f3d63mr2686342edb.18.1705490044976; 
 Wed, 17 Jan 2024 03:14:04 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 eg42-20020a05640228aa00b00559b1b070a6sm1794111edb.32.2024.01.17.03.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 03:14:04 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@denx.de>,
 Thierry Reding <treding@nvidia.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/2] ARM: tegra: move to standard boot
Date: Wed, 17 Jan 2024 13:13:51 +0200
Message-Id: <20240117111353.219772-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Drop the distro-boot scripts and use standard boot instead.
Most of tegra boards should support this as is, those which
does not are adjusted.

Inspired by:
'commit 7755dc58af7b ("rockchip: Move to standard boot")'

Passes buildman for all tegra board without errors.

Svyatoslav Ryhel (2):
  ARM: tegra: move to standard boot
  board: tegra30: switch to standard boot

 arch/arm/Kconfig                    |  2 +-
 configs/endeavoru_defconfig         |  2 +-
 configs/grouper_common_defconfig    |  2 +-
 configs/transformer_t30_defconfig   |  2 +-
 configs/x3_t30_defconfig            |  2 +-
 include/configs/tegra-common-post.h | 30 ++---------------------------
 6 files changed, 7 insertions(+), 33 deletions(-)

-- 
2.40.1

