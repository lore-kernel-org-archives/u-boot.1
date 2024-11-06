Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDC5D59F73
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 21:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A798902D;
	Wed,  6 Nov 2024 22:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FbsSWQQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5EB988E26; Wed,  6 Nov 2024 22:10:22 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 468CB88DDA
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 22:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 121655C0148;
 Wed,  6 Nov 2024 21:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72E58C4CEC6;
 Wed,  6 Nov 2024 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730927418;
 bh=n/3JI5xKGf+0A93NRsu52l/dTr3zxXlrZHfyMEpuNCM=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=FbsSWQQclHkc2ejQEf6rSq+B0wh7Eueezwd5mOv4w6rlWZ0PAYAVIUzOu3/u3Vi62
 9u2gu1UBmN5cy5nbqAZxFkxainNhgLGs4E7SuK7YQKM06BokbniVdUsj8PrtJXuRZe
 jQQrouITrQx4fQSgnYUILdPYRaP77cbczuoS8o0vj6FB32B39UfMYTSPt8iOsXcPKl
 QOipaDmLddlx/Li2/QPZOJWdYDkeFiYWj1JeNQH96fLzgu0KSqi+HceebGbU17dws5
 YiTmS3s+gbd8kR4ZsFjl7cBlAcDmk7LYcVWlDlSEC4+Uj4lKLwNcRwdFvsCGqiWW4e
 7zorSIVqlmr0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8FDD59F67;
 Wed,  6 Nov 2024 21:10:18 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH v2 0/4] Fix IOVA allocation in Apple dart iommu after
 global LMB mem map changes
Date: Wed, 06 Nov 2024 22:10:08 +0100
Message-Id: <20241106-io_lmb_apple_dart_iommu-v2-0-0580f4bdb023@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADDbK2cC/4WNQQqDMBBFryKzbkqSBsWueg+REM1Yp2gSEpUW8
 e5NvUCX78F/f4eEkTDBvdgh4kaJvMsgLwX0o3FPZGQzg+RSCcEFI6+nudMmhAm1NXHR5Od5Zba
 XZaVwqPmthLwOEQd6n+WmzTxSWnz8nEeb+Nn/zU0wzgZUXW0qZVXVP17GObNeHS7QHsfxBcZy2
 XC/AAAA
X-Change-ID: 20241101-io_lmb_apple_dart_iommu-dc2674ef9036
To: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=n/3JI5xKGf+0A93NRsu52l/dTr3zxXlrZHfyMEpuNCM=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnTt2xZWBseXzbj9Y1/Ju93r+uMTMnn3TYvVfTZzVUZqZ
 neqqFpfRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgIkc/sHwPzr94x7Oe6Za/+7a
 lfNuN7AQLDy63VV9dcrC9Gl/zK9cmcTIcJH9bM6L2Ftl5yeV/3oW+vlP9tlPE3d/O/vAz/pWSHr
 UYyYA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The changes in "Make LMB memory map global and persistent" [1] break
mapping DMA memory in the USB xHCI driver when using the apple_dart
iommu present on Apple silicon systems.

The IOVA space used by the u-boot driver (low 4GB) and physical memory
do not overlap. The physical memory on this systems starts depending on
the SoC either at 0x10_0000_0000 or 0x100_0000_0000. It make no sense to
manage these distinct regions in a single LMB map. In addition every
device has its own iommu and IO address space so sharing a single memory
map between all iommu instances is not necessary.

To fix this issue restore the used subset (add, alloc and free) of the
previous pointer based LMB interface with "io_" as prefix.

To ensure that low level lmb functions do not use the global LMB
variable reorder lib/lmb.c so that the variable is not visible.

Tested with patches from my "Fix device removal order for Apple dart
iommu" series [2] to fix a separate issue.

The cosmetic commit has two checkpatch warnings in existing code which I
ignored.

[1] https://lore.kernel.org/u-boot/20240826115940.3233167-1-sughosh.ganu@linaro.org/
[2] https://lore.kernel.org/u-boot/20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net/

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- added io_lmb_teardown() and use it in dart's remove callback
- removed leftover from copy-n-paste in io_lmb_setup() documentation
- added Tom's Rb:
- Link to v1: https://lore.kernel.org/r/20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net

---
Janne Grunau (4):
      lmb: Do not use global LMB variable in _lmb_free()
      lmb: cosmetic: reorder functions and global LMB variable
      lmb: Add basic io_lmb functionality
      iommu: apple: Manage IOVA separately from global LMB mem map

 drivers/iommu/apple_dart.c |  18 +-
 include/lmb.h              |  51 ++++
 lib/lmb.c                  | 614 ++++++++++++++++++++++++++-------------------
 3 files changed, 418 insertions(+), 265 deletions(-)
---
base-commit: 1d147b74f437fb0e85821e8271fe52bc5fd30194
change-id: 20241101-io_lmb_apple_dart_iommu-dc2674ef9036

Best regards,
-- 
Janne Grunau <j@jannau.net>


