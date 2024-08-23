Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112C0C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 19:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFA0088914;
	Fri, 23 Aug 2024 21:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PlTwveOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BE8688915; Fri, 23 Aug 2024 21:12:13 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15D588580
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 21:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-201e64607a5so17243255ad.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724440329; x=1725045129; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dy/aVmNSINf9juxN2HE8vg58gxKvwA4sKgVrm37iF4c=;
 b=PlTwveOBkP3oHZ2Fw8s2ErPw9a4Lonse+mib/C+7jFkScxk22s7gE/7K9mRfVcSkeo
 ZdlH5jbjS/LyyxBLrxkDkd4YkQnPKk/Nkz+0zPkSwvyKopJSo/5s+KIQ3vVNTfvDbhsn
 vhWvBfNFBuCxIx0yWfMeTcrIGwR9EjmspK69a4iqA6HgNQx185yVWGE/7ydgFSihgPve
 KEk5HfiS3KVGC13kjqXB0qF060WyzViJtC2ja/SfEu72uQf5TWBVyYY+EnU8G8LwBVgg
 klO5lp8sEyafKd6rgbOMZWLAeqCv+Yaprm/+qQaWADYXYoMtB1OO2KmdN0MpbJmmgD5Q
 ErBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724440329; x=1725045129;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dy/aVmNSINf9juxN2HE8vg58gxKvwA4sKgVrm37iF4c=;
 b=pYHwClwEXp/HuucgFyN6xm4DGYPkOzDydEOV9kawKH2qI/wd5mkVYsigzyfPY0i/Em
 KntgvAyihy0iMRoQAHxMmnTy4uU7F6by7fzE+htYAmLfd2ShsHUCeLgNNpctALzdv11/
 qZGoQvmM6CbYp238DJ0BH4ilDQsc5XA0FnZ6P7XpVmseR+dmnG6mlO6B/8DMrpFThOjT
 fB7/OPRx6Z7NtDZ751NsLyeesUG5uk+CspbOjmAKJFB9BhoB36shxhWjAp7pPymkFH2Q
 /eDJuUco8dXEfQqMJjA2zTMhSxZV2dZqPt2WLNMwsrpgqVl/NUH7/BOgUZyY9OPomX7/
 5JrA==
X-Gm-Message-State: AOJu0YyuPsW25CgrGpr8iXkqMZi5mW1aNclQNWpP8TiYGfQqf4+sfcUx
 CUvgdDX+UOcMgNt/AN+K6y8I7yjIJFTfaLiAornsbYMYWiUOQOKzJdihRA==
X-Google-Smtp-Source: AGHT+IEqu5JFCkns3ETk3wfXqMS1SWYqrhMkUYxnZgStjnTjW8nP1QayHmVOYaplVKrkhzfTPMgGuw==
X-Received: by 2002:a17:902:d508:b0:203:8db4:4442 with SMTP id
 d9443c01a7336-2039e4e84cbmr37171375ad.45.1724440329039; 
 Fri, 23 Aug 2024 12:12:09 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:7a3d:a1bd:2192:9908])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203859f00fcsm31845495ad.247.2024.08.23.12.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 12:12:08 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240823
Date: Fri, 23 Aug 2024 16:12:04 -0300
Message-Id: <20240823191204.3974463-1-festevam@gmail.com>
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

The following changes since commit e93d343cc7d2886b1148d885aa137d46bbce0570:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-samsung into next (2024-08-22 08:15:04 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20240823

for you to fetch changes up to dda8444832ce32e0bdb9a05e2e90a7dc9f8663ca:

  ARM: imx: Enable cat and xxd commands on Data Modul i.MX8M Mini/Plus eDM SBC (2024-08-23 14:53:53 -0300)

u-boot-imx-master-20240823
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22098

- Add BOOTAUX support for apalis and colibri imx8 boards.
- Cleanup tqma6 board by removing unneeded board code.
- Add support for booting from ecspi3 via bmode command on imx6.
- Add a script to ease updating flash.bin on imx8mm phytec board.
- Enable cat and xxd commands on Data Modul i.MX8M Mini/Plus eDM SBC
and use USB SDPS as fallback option.
- Fix critical temperature on imx9.
- Add Cortex M and bootaux support for phycore-imx8mp.
----------------------------------------------------------------
Andrejs Cainikovs (4):
      board: apalis-imx8: add reset code
      apalis-imx8: enable i.MX specific BOOTAUX
      colibri-imx8x: enable i.MX specific BOOTAUX
      colibri-imx8x: enable i.MX specific SNVS configuration

Fabio Estevam (5):
      tqma6: Remove non-DM board code
      tqma6_mba6: Remove unused defines
      tqma6_mba6: Remove UART board code
      gw_ventana: Remove unneeded comments
      mx6: Expand bmode to support ecspi3 boot

Lukasz Majewski (1):
      config: Add 'update_bootimg' command to update flash.bin on Phytec's imx8mm

Marek Vasut (2):
      ARM: imx: Use USB SDPS as fallback option on Data Modul i.MX8M Plus eDM SBC
      ARM: imx: Enable cat and xxd commands on Data Modul i.MX8M Mini/Plus eDM SBC

Primoz Fiser (1):
      imx: imx9: Set correct critical temperature

Yashwanth Varakala (2):
      board: phytec: phycore_imx8mp: Add mcore support
      configs: phycore-imx8mp_defconfig: Enabled bootaux command

 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi          |  16 ++++
 arch/arm/mach-imx/imx9/soc.c                   |   2 +-
 arch/arm/mach-imx/mx6/soc.c                    |   4 +
 board/data_modul/imx8mp_edm_sbc/spl.c          |   5 +-
 board/phytec/phycore_imx8mp/phycore_imx8mp.env |   5 +-
 board/toradex/apalis-imx8/apalis-imx8.c        |   8 ++
 board/tq/tqma6/tqma6.c                         | 126 -------------------------
 board/tq/tqma6/tqma6_mba6.c                    |  35 -------
 configs/apalis-imx8_defconfig                  |   1 +
 configs/colibri-imx8x_defconfig                |   2 +
 configs/imx8mm_data_modul_edm_sbc_defconfig    |   2 +
 configs/imx8mp_data_modul_edm_sbc_defconfig    |   2 +
 configs/phycore-imx8mp_defconfig               |   1 +
 include/configs/gw_ventana.h                   |  31 +-----
 include/configs/phycore_imx8mm.h               |   8 ++
 15 files changed, 53 insertions(+), 195 deletions(-)
