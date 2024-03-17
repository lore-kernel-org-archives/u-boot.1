Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B63C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 23:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5DC087E06;
	Mon, 18 Mar 2024 00:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N3J5eMx1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DEAC87E0A; Mon, 18 Mar 2024 00:34:28 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B8A3879F4
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 00:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c3868b42daso105978b6e.0
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710718464; x=1711323264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u+y6XdrqmVrlIMfvEcSAH4lntHEuV/Me2yMqne2JMEg=;
 b=N3J5eMx139lLc+lQSuspX3rxQETL5aCDnt6NyaPF/5+8mtfXZsvvh0qjKLd4oF+fdB
 nT3Oh19ml7tjEmhkkDGCtuEs8ZS4BiXGlbi+mHAXUBzpohiKwBgwcUacaPccV+EFeq2v
 fW6nvcT93QzdRYma/Zum1XeVXrYFob9NmJPQUOdZ7GHK+Bx8IGLMPA6lj5l/VbXz0EXc
 Y9/PgVpHDVjUqIfshoTJBKApE8qxm8VTwoL2xBK9q9ImkxsjcLZ3SbuL+ZuFczUaiwtI
 yab5oYXbvR/XjGM/a8vQWYCrqvviQ+SUMIBj+KmOqr6MrGA55U1JdXNJkojbJOKffKpp
 dsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710718464; x=1711323264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+y6XdrqmVrlIMfvEcSAH4lntHEuV/Me2yMqne2JMEg=;
 b=a8n/Ai/S4QtSHzndY2ejgQHAgwJCoCzt6J2NpXI09SVYVuJC/ubF1GNDEa4L2LsLlF
 5Yg3Wrqbv1x2Wyp8foWNUe+PLXiWQdZZg2gce3fc5XF2nbUanXE12s88OWWVBH46UbG7
 oOZGAUpd90wJ4XTltWgbGU5JLu7j0Vv946VvDUYSphfOIgrHrS2WjeWHxSanfiV3oOmx
 uqHpmj1Hw7zcq2AJndvyH0fx4l/e5/p8dDf9eNnAjPQxF9UhJ3PAiE6ijH+ZxJh1wqqA
 S2PmwHA4il4mEI/yBJphNJ+YtfwTEHbDpaGkm48MBe10cfXhxLcopD3bfP774yrsg96o
 ftkw==
X-Gm-Message-State: AOJu0YzYx4fHFudcpbrBDLLHJw9f5YME+cmWNHaotG+V0GRVNoZtMkjW
 FgLtN8z69Ku0lJJf+BuK5ew4wsGUDky/L4zNDmQVVjOoNwjfBUDNvGoSDBWs
X-Google-Smtp-Source: AGHT+IFsCRNbeeMXbNnwVjmRTBYOrZ6tH6Fh5MWdvPh6T5iPL5Gl58FycH3Gx7mfUOgte9Zgs7e1Vw==
X-Received: by 2002:a05:6359:458c:b0:17e:bbaf:4060 with SMTP id
 no12-20020a056359458c00b0017ebbaf4060mr7155896rwb.2.1710718464463; 
 Sun, 17 Mar 2024 16:34:24 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1857:6918:c59e:afde])
 by smtp.gmail.com with ESMTPSA id
 h27-20020a63531b000000b005dc3fc53f19sm5960001pgb.7.2024.03.17.16.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 16:34:23 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240317
Date: Sun, 17 Mar 2024 20:34:20 -0300
Message-Id: <20240317233420.330902-1-festevam@gmail.com>
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

The following changes since commit 86fd291a7990af84e96808f48eff2219dd4ef496:

  Merge tag 'efi-2024-04-rc5' of https://source.denx.de/u-boot/custodians/u-boot-efi (2024-03-13 20:39:46 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240317

for you to fetch changes up to e648c4a3455a4d1880efe121602ed90a0bc9b53f:

  arm: imx: imx8m: soc: Fix NPU/VPU fdt disable fixup (2024-03-17 18:00:04 -0300)

u-boot-imx-master-20240317
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/19974

- Fix build error when SoM detection on Phytec board.
- Fix sc_misc_otp_fuse_read() error check on colibri-imx8x/apalis-imx8.
- Fix NPU/VPU fdt disable fixup on i.MX8M.
----------------------------------------------------------------
Benjamin Hahn (1):
      board: phytec: define get_som_type also when SoM detection is disabled

Fabio Estevam (2):
      colibri-imx8x: Fix sc_misc_otp_fuse_read() error check
      apalis-imx8: Fix sc_misc_otp_fuse_read() error check

Vitor Soares (1):
      arm: imx: imx8m: soc: Fix NPU/VPU fdt disable fixup

 arch/arm/mach-imx/imx8m/soc.c               | 18 ++++++++++++++----
 board/phytec/common/phytec_som_detection.c  |  5 +++++
 board/toradex/apalis-imx8/apalis-imx8.c     |  2 +-
 board/toradex/colibri-imx8x/colibri-imx8x.c |  2 +-
 4 files changed, 21 insertions(+), 6 deletions(-)
