Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABEFC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 19:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA9984C95;
	Mon, 13 Jul 2026 21:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BqJO635/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CECE84C4F; Mon, 13 Jul 2026 16:25:24 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6F4D84C06
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-474560436c3so2462386f8f.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783952721; x=1784557521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dT7SdhkQObwvMb9hax2hJvxNacWw2SjZUrJ5sGT7XPQ=;
 b=BqJO635/UhsftXgO2YfEgHjmiMf8FjlBx/L5NoSRH7hZSxDrvpq7AIvRDUUUVAoVGB
 hk8IaJXnDPhpMd+BoneLd1K/nqD60zsD9M3ITRsCv2wsJ2HCvCfQnhVJVCZnZMtXhlO8
 9dCHl7bC4RqlIdAL4e8J/Ufo+4l1kAIp0RvsMwIEbFjGeLSSShvnXaNUw3EgVQN52U+q
 77fBcbE0YtBzWT2CKGWq8Z6LmZ07hiC6bEl+34VAgNtVcmE7zsYpVjxBmxdFPCiTjc/J
 OWN2zHwXhqoPNqyc+asarANi1Rklhw2w73jV/5mtPjhr62LGgOSo6jbTRJcWfidEGPrd
 Mi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952721; x=1784557521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dT7SdhkQObwvMb9hax2hJvxNacWw2SjZUrJ5sGT7XPQ=;
 b=o76wUYwv/B73tTNCu6zAh3foqwoXcUF/Pl4K/M9dDsaOriskwgyunyjGEMzf7xMNZ2
 GeQzAfC+7lnGd+/ZjVv+XRUmNMU+BS+f03R0hnN9ppG9n4FVJ+sFMcV/oo5C5XqCZtOT
 fWd3oIcr2EKW+qRt83eSE9nfrzVErHZyQF0/Boc5HYlk1m3xwusFyXuMr79m4S7W1G00
 +hSvsIDXdrcdPqJvsespA/+LZuRSZPlCqYKUK+bs8WLPeaWKU6JptBhOmFR49ZBlPtS2
 1pI3wjiiq8N+Cs0sZeqWJyMhgDkfTfX+NeGPOb8/taJJ/Y5pkLKWkBl4xe8GDZLHwKwV
 rmWQ==
X-Gm-Message-State: AOJu0YxZY9d9NyXcP/2rQLPg0PHIB/PRLglTJLoAuL3et5JsjjY7R6ED
 cnQAagr4KFXo34dreJoV8hRBTp4xFwBO3Rlj5qB6w3Evu7rxFxTGPkO0J0HkBPmx
X-Gm-Gg: AfdE7ck+66I8FCGVlNcgkWKwZlP7wKRB8g6PJGncuJ9+8zM6GggFY1Au1SSQCwBUs8Q
 buGKOEzYH5QvGVbuzAcmwnFGWCUf8R1KyFm9nTPlin3Pi9C9UBb5Wyy+4e6BVDeFwOuMkoVpsWD
 4gDvQw9jukAQeoNevK1v8RqzssxZ0+B32W18D3ZfFs/UusFIHz7p0ngENlbAD9kikpnJ24EV7pa
 Mz4tYQljjMrv251h1uGps0kMpgDveDcULzb7WykFHWxWVu/YbrMSWCsl+10llJsMXYbXvrm3Y07
 3YgZRtBvkyvFiprcLOCaSeZ+8okneXZafUY8w+WwkCka3p0LfqkVewDm1yKwlzP2Mfc6PKdgu2w
 FZrKPV3z+cv8YCl61K6wRZoOqqDqYQMn5Py5wF5Z1jrwgd1KfIhBKJvWI8hdp4u4K+vSptMQbh9
 TBtvHLip5obi1v3UIjf4xEwR7jsQ4OuBOiXeeT2y2I/UY7xSUSq+VSJxp6hduNQ1KOTjx0LpcnM
 WxaJKIqLhRI1p3bS7olFUpTnrDs1CLkDanMuI+vY9JDrdgSQOxCluKEqvKOIVe3Y8z+qcf/jM+9
 GRvW
X-Received: by 2002:a05:6000:604:b0:47e:12d9:1c79 with SMTP id
 ffacd0b85a97d-47f2dccb793mr10888733f8f.27.1783952721123; 
 Mon, 13 Jul 2026 07:25:21 -0700 (PDT)
Received: from thinkpad-t15g-g2 (82-64-82-74.subs.proxad.net. [82.64.82.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm83691562f8f.13.2026.07.13.07.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 07:25:20 -0700 (PDT)
From: Allan ELKAIM <allan.elkaim@gmail.com>
To: u-boot@lists.denx.de
Cc: Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Allan ELKAIM <allan.elkaim@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 0/3] fs/squashfs: fix symlink load failure on large images
Date: Mon, 13 Jul 2026 16:22:41 +0200
Message-ID: <20260713142420.2618339-1-allan.elkaim@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 21:59:35 +0200
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


sqfsload fails to load a file through a symlink when the squashfs
image contains a large number of inodes (e.g. a rootfs that includes
the tzdata timezone database).

Root cause: sqfs_read_nest() resolves the symlink by calling itself
recursively without first freeing the parent directory's inode and
directory table buffers. This causes a temporary double allocation
that can exhaust the U-Boot heap. When malloc() subsequently fails
inside sqfs_read_directory_table(), the error goes undetected and
sqfs_search_dir() is called with a NULL pos_list pointer, leading to:

  Error: invalid inode reference to directory table.
  Failed to load '/boot/Image'

Patch 1 fixes the structural problem (temporary double allocation)
and plugs the silent NULL pointer path in sqfs_read_directory_table().
Patch 2 adds the missing return-value checks on sqfs_dir_offset() that
turn any residual lookup failure into a clean error propagation.

Patch 3 (reworked in v3 following Richard Genoud's review) fixes
pre-existing leaks of dirs->entry on the error paths of
sqfs_search_dir(), by centralizing the cleanup at the 'out' label.

All patches are independent and can be reviewed separately.

The bug was first observed on U-Boot v2024.01 and is still present
on v2026.04. The patches have been tested on a Raspberry Pi CM4
running U-Boot v2026.04 (Yocto Scarthgap 5.0.17) with a 325 MB
squashfs rootfs containing 22 517 inodes. The symlink
/boot/Image -> Image-6.6.63-v8 now resolves successfully.

This series addresses the bug reported at:
https://lists.denx.de/pipermail/u-boot/2026-May/618533.html


Changes in v3:
- Centralize dirs->entry cleanup at the 'out' label instead of
  freeing only on the inode lookup failure path, covering the
  remaining leaky error paths (suggested by Richard Genoud)

Changes in v2:
- Free dirs->entry and reset it to NULL in the two error paths
  reachable while a directory entry is held, so a lookup failure
  no longer leaks the entry (reported by Richard Genoud)

Allan ELKAIM (3):
  fs/squashfs: fix heap exhaustion during symlink resolution
  fs/squashfs: add sqfs_dir_offset() error checks
  fs/squashfs: fix dirs->entry leaks on sqfs_search_dir() error paths

 fs/squashfs/sqfs.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

-- 
2.53.0

base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
branch: squashfs-v3
