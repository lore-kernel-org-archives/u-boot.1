Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A6BE92FC9
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 23:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE4A86BDF;
	Fri,  6 Oct 2023 01:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GptpDXJ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B80586C2F; Fri,  6 Oct 2023 01:08:45 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D999F86AB3
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 01:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-352308c0799so6222635ab.2
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 16:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696547320; x=1697152120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KTTlwcuq7oz/hnR9jBdwuqizbLOus3krmkoDrF9Pqls=;
 b=GptpDXJ4LLLlyhOb073kzJWcLJdESn2gSr2cJ3N4Xwrxlv6RApB1ceZogYZwHdgxSp
 dCnQNEqBxTqQhaqU5C1zHaO3uJSCekw5h5PFp+JTm8ZApo+aJQNFmFONncAmePwZSnlt
 0DF6AVW3WayrTMtEtGq/tlk+xN7qX36T56Wu9UlqOnZ2vKLO8TIoq+PnuHDesJEbZthR
 T9JkCPWg4drfepeJm3+4lcqo6JkTirIe24K9fXs7XuhUByD4cSs543pjwiZS9COQLYQT
 vHK73lIrQW5EWlfXTUDhV/+v72uBTeexeY5Wcxakw6TAu2GGiIDVfD23dufuZM6+8+/h
 P9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696547320; x=1697152120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KTTlwcuq7oz/hnR9jBdwuqizbLOus3krmkoDrF9Pqls=;
 b=EslC2lWVX5MXP9kWqmpktceOLCEvqMre/eptiheBJVqIjyBoV941j3LHpb7VaaisVf
 k22IwLQSJkBxvNCKuiI7mNoC05TjNCo1UoqLsaqHgSpLByRELitNUDJpM5PImpeUe00b
 5wLAk4a6+kzfpmtozktcp6786e9KcqivH3Z51vwVLJYAl1/v5l9J0rvJLpW+AJgsSol9
 OSeXm/J03wYPhQ2D0Rh2C/5L+tMluuEDSZZxTKJOCY0EZ/UqgVOA1QCKexVX0JYnwfMK
 uXZoMJ8n6wWGOUxcvCsuLiRtNLTD0+GOB/AWc1oxey6D0vdtydXP87iZcY0BvFP+hjLb
 3fqQ==
X-Gm-Message-State: AOJu0YzPBiFTpkF1JiL1zVVlE2xMCyS8Ed7l9YafFoaRMLMZbATCJoP4
 oxLxS9UHCwRWEZJ/Ojy8Wcs=
X-Google-Smtp-Source: AGHT+IGoHaeAgi5JFEdLLNn6CY/RzmE08Et4tYif/MeWDaK3Gvl93i0NUmYjB0ao1FGu93s6NSWnKA==
X-Received: by 2002:a05:6e02:2165:b0:352:609f:e4af with SMTP id
 s5-20020a056e02216500b00352609fe4afmr7255363ilv.24.1696547320314; 
 Thu, 05 Oct 2023 16:08:40 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:9b88:f219:40c8:60fc])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a922811000000b003513b7613f3sm709974ilf.3.2023.10.05.16.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 16:08:39 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Schocher <hs@denx.de>,
	Simon Glass <sjg@chromium.org>
Cc: Kyungmin Park <kmpark@infradead.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [RFC PATCH v2 0/4] mtd: ubi: Enable accessing RO filesystems in UBI
 vols
Date: Thu,  5 Oct 2023 17:08:27 -0600
Message-ID: <20231005230831.4032070-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Hi list,

This is the second version of my RFC patchset to treat static UBI volumes as DM
block devices, allowing users to access read-only filesystems (SquashFS, EROFS)
contained within such volumes.

This is a rebased and updated version, as requested by Heiko.

Previously, we have agreed on a syntax, which my downstream is now starting to
use:
=> ls ubi 0:rootfs /boot
=> ls ubi 0:2 /boot

This is still not yet ready for mainline inclusion, because the actual UBI DM
access is happening in disk/part.c, which is not "clean" with the way the
DM/legacy switching is currently plumbed. I'm still looking for guidance on how
to name/implement block functions for looking up a *subvolume* block device by
type+parentidx+{name,ID}.

Changes v1->v2:
- Rebased onto next post-2023.10's release.
- Fix NULL dereference caused by passing NULL to `blk_create_device`
- Parse UBI index/volume numbers with `dectoul` instead of `hextoul`, to match
  Linux's behavior of treating these numbers as decimal.
- Do not treat a valid decimal number as a volume name, even if the volume ID
  doesn't exist, to match Linux's behavior of always treating decimal numbers
  as volume IDs.

Cheers,
Sam

Sam Edwards (4):
  mtd: ubi: register UBI attachments as DM devices
  mtd: ubi: bind block device driver for static volumes
  disk: part: fall-through if "ubi" requested but ubifs not mounted
  HACK: enable access to `ubi 0:volname` block devices

 cmd/ubi.c                    |  11 +++
 disk/part.c                  |  69 +++++++++++--
 drivers/mtd/ubi/Makefile     |   1 +
 drivers/mtd/ubi/ubi-uclass.c | 185 +++++++++++++++++++++++++++++++++++
 include/dm/uclass-id.h       |   1 +
 include/ubi_uboot.h          |   5 +
 6 files changed, 264 insertions(+), 8 deletions(-)
 create mode 100644 drivers/mtd/ubi/ubi-uclass.c

-- 
2.41.0

