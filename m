Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3ACEDE9B8
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 12:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3731986413;
	Thu, 14 Sep 2023 14:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="PEnlibq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65D286459; Thu, 14 Sep 2023 14:21:07 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B21A863E3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 14:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c336f3f449so7138505ad.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694694063; x=1695298863; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4mfVS8FefDWPzR/RB67cntePdu9LEGQvoVeCV9HdgT8=;
 b=PEnlibq/fX4fmZ6sGpL2/dmYdaNhIjMIAXKEBRBokGpbIZxeuriJy3rHnHv1HBZFK0
 GFsBBqVaoFCm4OilLlmPlz0yeVWo88CKBuqbsowPpw/8Tt2R4+MdJ/UsCh6KrtkkyfyD
 ntDxFnRKtY1G1K2g5xPjHcixZxlu665NbKGzqKOSe6E+Sri1b9zaMJ1PiMSbZkYdcsx/
 xHUOTiDFMz/wDYzc7E+HWXUUJPY2mEV3j9+gA8FVWW37tSBJMnltWshMoBl+Gl8RbLvn
 /Q1NWkmvL7C4HCWwPjLJHgScvsYxCv6IpXB7gxEbaUW+Qj5sliQIngddRrqTBLcWgH4A
 3EbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694694063; x=1695298863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4mfVS8FefDWPzR/RB67cntePdu9LEGQvoVeCV9HdgT8=;
 b=gn6ctnPfNis4muAz1udPGpNVYM9FXDzQyYv6Or2YCL11sKEM4Oz5CcyM7J5Xo81Oqe
 PYJKHMEL81nc/oEJY91KdfDzbOpN6PSUBfsN74tpDm/zESKaPor8VEbJpz3dkSKEYhZI
 HGJzARC/tFXoOzjrGoJbdlg1EcgUPnHS6SVMH8EZ6ixHCVxnl7phaF/ijBTesSntsVO8
 HZSN9kzOGLyL0eo2hMsuUxwoEuHSmM8oLi2V+Wx60uUYeX514X29jnozTg5qw1hS48vp
 +x0sTTKDsMJAimfxTh9immGRkA3oftVmczb2nrsjAvAWkvXxJK3NSmMhe+6G3pd+4pgD
 r4gw==
X-Gm-Message-State: AOJu0YxJWdg6Wfs5dWNuZwARb8wwA89RxtCrL5W0DL0jGnLB4m4Yh6mm
 Y37LgOO0xRt29Tu31cRUmi6j6kaJO3DPUCgKFJ+3CQ==
X-Google-Smtp-Source: AGHT+IGUcdZcIpHeczh2aQmLGSa53aPbkm+HlXj1WNwRVKDkNWIBK3BEPTHI0hMqL08q7rtR5OdZig==
X-Received: by 2002:a17:902:d2c5:b0:1c3:5d5c:cc99 with SMTP id
 n5-20020a170902d2c500b001c35d5ccc99mr5576313plc.36.1694694063449; 
 Thu, 14 Sep 2023 05:21:03 -0700 (PDT)
Received: from mchitale-vm.. ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 t17-20020a1709028c9100b001bdb85291casm1447796plo.208.2023.09.14.05.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 05:21:02 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/2] SPL EBBR - EFI System Partition support
Date: Thu, 14 Sep 2023 15:38:19 +0530
Message-Id: <20230914100821.755904-1-mchitale@ventanamicro.com>
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

This series adds support to locate an EFI System Partition on a disk and
boot the next stage from such a parition if found. The next stage image
is expected to be under the FIRMWARE directory as described in the EBBR
specification [1]. Also update the spl_blk_fs and spl_fat drivers to
prefer booting from ESP and fall back to the configured parition in
case of a failure.

These patches are built on top of the following series from Sean Anderson:
https://lists.denx.de/pipermail/u-boot/2023-August/525665.html

[1] : https://github.com/ARM-software/ebbr/blob/854ba0e68590102667b84a5ba4e0b076a3f5f2cb/source/chapter4-firmware-media.rst

The patches are also present in the branch below:
https://github.com/mdchitale/u-boot/tree/mchitale_spl_ebbr_v1

Mayuresh Chitale (2):
  part: Add a function to find ESP partition
  spl: Add support for booting from ESP

 common/spl/Kconfig      |  7 +++++
 common/spl/spl_blk_fs.c | 61 +++++++++++++++++++++++++++++------------
 common/spl/spl_fat.c    | 34 ++++++++++++++++++++---
 disk/part.c             | 16 +++++++++++
 include/part.h          | 10 +++++++
 5 files changed, 107 insertions(+), 21 deletions(-)

-- 
2.34.1

