Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A13CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1BD8839A8;
	Thu, 11 Jun 2026 14:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KbfmgaDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ECFE83FEC; Thu, 11 Jun 2026 11:45:02 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97715838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4905529b933so82363155e9.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781171099; x=1781775899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ye7IeiGW4eMeeRb7j8xwAIe1CsY+DYclG65OV7P3mDA=;
 b=KbfmgaDbbpGVzdyq9VrqE/+nJa8IruofNg/Un4vSHASNr1Oq1oIzQP9sx0wg8mcAaz
 lBurTLXe6XxpRYe+UeO6NRqUQWiyOpnW9L/m+je/u+sUySroHYk7EaxFog57+dxDQbQ7
 Ndrm8XXgqk2gXpmOdbQL0vkQhMG2FoXn4BEuwWanmBLyRdHe2Kafmuuk6mIIZ7xbf2ao
 ruICS1XF+YK7BZZJgOGjehBWv9HoZ/mFJCM56LrQCFH4RXoB0ZS6ElJmXtxYaY0Tb6/Y
 ruxlGOcp9l/gNsLnrA1E6ZhqsTADls31EoFS8QE+seY9Q3mW07vdqqO0AdQg1D3Wg/4V
 I6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781171099; x=1781775899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ye7IeiGW4eMeeRb7j8xwAIe1CsY+DYclG65OV7P3mDA=;
 b=eIvO9marWIRt6BJPlsV1icIosqzXphr8dvTck1/pyVRcuQ8IXgDDRuohw2P5XzGI+i
 RlVVIpQgzW/qLJnj8wMFu6bZiqPgjmFkJ8NxOLOyaFS6Eb/ntGyEJayQn93D05geyzZn
 lK6ybo7GFhVbbYu2mtl50wact9qZGBZVKz9Smok9BH4hV72SvJB12bUwPMzoZ7r+BsdU
 qi2NyewHk7COyFDkOSBB556CVsDq63ongEiIFlN+wnd/5hO8EhoIaqbbwLOjv+lCEOoz
 cd4vaIbuGR2qSV7QjQHL/3xmfKC7qfOBxUwleSb7NlooQA/AGmgNdUl0HbFA95sLKpfY
 XolQ==
X-Gm-Message-State: AOJu0YxnF4ZAGh9+H6vKxxMTtoSKb98Ct0c4zsMJfodyu0YHidWJdErZ
 29/GhfLHnaPtLhuzb7OMfXPKtkxAKxjxy6u60KfLriPrjh9rSdbKg43lmjiId1D5ZQI=
X-Gm-Gg: Acq92OF9KUxLbFjz+evQEyZyriE/uc7aWgsmxoO9ah/gT6K3ggX7IQ3sPunMy+ynRoG
 BaI1Wa2pi2YnzK/1QBsivN+xjtRv61bljBKNTFM4XzQX1ohiyVPR5tEb1FLsD/nzPWPSunwDsqi
 +4JY2QTNjs2Qjq1NxqxVVmTRE73o3XxXDzLCr2P/dA4cR76DY9IQjJJp7TIE7FdnU22kJ0d9w4e
 lwY7gDsunIvNWJvf9FhTJpszvTPHCXBsPxAyIaQMok3BT1JUHbUMZ9Jul0VkFr2CC/mON7A0R1V
 gRLm7bDMBxUX/IEi+71PKn1dslIdtE7lEOZoSHVq1SfWADiIQ4FvkHHJPV6wwtRdjtbATDy7MLU
 SF+ndqfRGNyMknP3zSDFbv74OlLQXQUaL0tWKb07w5qnZCtMKRWfkuJwDW5eEqRiks/Frjq9Qq8
 OYWQG7iGvW6in5plXgvO1t77bd/eR+7xu6zWoW+0GuYvH1J2jVKQpJDayrwjoWrPpYzWX3kmvph
 0bNIu7YuO75QLqDavFz9ljbDpHlzdUszMYbh7bR2KeCybLlxQIXq0RBoGHUOR1YoPFWTdBca0xQ
 akewQOeN+CtTOKslF8vQN30NgZ92oNIlC0whEqgR0kCgxbsLaT7Fy3ta5SO7WA==
X-Received: by 2002:a05:600c:c093:b0:490:b28d:a6f9 with SMTP id
 5b1f17b1804b1-490e55d4a5bmr24632765e9.8.1781171098762; 
 Thu, 11 Jun 2026 02:44:58 -0700 (PDT)
Received: from thinkpad-t15g-g2 (lfbn-idf2-1-525-203.w86-246.abo.wanadoo.fr.
 [86.246.224.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2ca21f4sm51499075e9.7.2026.06.11.02.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 02:44:58 -0700 (PDT)
From: Allan ELKAIM <allan.elkaim@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Allan ELKAIM <allan.elkaim@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v2 0/3] fs/squashfs: fix symlink load failure on large images
Date: Thu, 11 Jun 2026 11:43:44 +0200
Message-ID: <20260611094353.722555-1-allan.elkaim@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 14:43:41 +0200
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

Patch 3 (new in v2) fixes a pre-existing leak of dirs->entry when
an inode lookup fails in sqfs_search_dir(), spotted while addressing
the v1 review comments.

All patches are independent and can be reviewed separately.

The bug was first observed on U-Boot v2024.01 and is still present
on v2026.04. The patches have been tested on a Raspberry Pi CM4
running U-Boot v2026.04 (Yocto Scarthgap 5.0.17) with a 325 MB
squashfs rootfs containing 22 517 inodes. The symlink
/boot/Image -> Image-6.6.63-v8 now resolves successfully.

This series addresses the bug reported at:
https://lists.denx.de/pipermail/u-boot/2026-May/618533.html

Note: this series supersedes the single patch sent earlier as
"[PATCH v2] fs/squashfs: fix missing error checks causing Synchronous
Abort" in the v1 thread; please disregard that email.

Changes in v2:
- Free dirs->entry and reset it to NULL in the two error paths
  reachable while a directory entry is held, so a lookup failure
  no longer leaks the entry (reported by Richard Genoud)
- New patch, fixing a pre-existing leak of the same kind as the ones
  addressed in patch 2 (suggested by Richard Genoud's review)

Allan ELKAIM (3):
  fs/squashfs: fix heap exhaustion during symlink resolution
  fs/squashfs: add sqfs_dir_offset() error checks
  fs/squashfs: fix dirs->entry leak on inode lookup failure

 fs/squashfs/sqfs.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

-- 
2.53.0

base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
branch: squashfs-v2
