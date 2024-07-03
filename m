Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39A7C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 10:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21BC4887E7;
	Wed,  3 Jul 2024 12:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="FLHWiCIc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD9E8881A; Wed,  3 Jul 2024 12:13:07 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF188887E7
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 12:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6E0D6148A8EE; Wed,  3 Jul 2024 12:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1720001584; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Au9DHATw1ZusFCSmgNz7KIqFvvHVGrdmdDnM6ps2Swc=;
 b=FLHWiCIcdOQMt0AShDzskDAEfsd0Tr0zJU1vJw1pGdao39NpppTpR8TXsB0xvgERzFt2yH
 jCqGrpAox+4ksjqzWqeCC/f8pW4yDY1eAvJtQzmxdD/l2YlvbPXfoICmB07YvO9ENghpXd
 /iHikdW+y33n0YMKsr1YFQMuPRrIdnHb4cum6+L4wj510O8Y59tLAFTRfyjP4XpHAU5590
 OjUvB/i9a3ndJquuf1kCQM3geCRRmqqtHV1NR+j66ip1McCjVwhw1hsObwi9TM936aJtok
 RvGKUuwVFy8V2t65tYYvWpUScvKQqy1tNSHF5gdUYpMs2dq04zccsjGtZtn+8w==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Heiko Schocher <hs@denx.de>,
 Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/4] fs: ubifs: Fix crash and add safeguards
Date: Wed,  3 Jul 2024 12:12:54 +0200
Message-Id: <20240703101258.1670825-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hei hei,

filesystem handling is different in U-Boot and beyond that UBI/UBIFS is
different from other filesystems in U-Boot.  There's UBI and UBIFS code
ported from Linux (quite old already now, maybe someone wants to update
that?), and there's "glue code" or "wrapper code" to interface with
U-Boot scripts, commands, and filesystem handling.  The fixes and
improvements in this patch series are for this U-Boot specific glue
code.

I'm no filesystem expert, but after days of debugging I'm quite sure the
bug is in U-Boot since UBIFS support was added in 2009, and it was
repeated in 2015 when generic filesystem support for UBIFS was added.
So please review carefully!

The crashes were not easily reproducible, only with boards using the old
distroboot _and_ a boot script inspired by (but not equal to) the one
proposed by RAUC [1], which basically boils down to:

  ubifsmount ubi0:boot (from distroboot)
  test -e (from distroboot)
  ubifsmount ubi0:rootfs1 (this time from the boot script,
                           triggering a ubifs_umount)

Crashes can be triggered more easily, if patch order is changed and
patch 2 (resetting pointers to NULL after free) comes first, or if patch
2 is applied on its own only.

The fix is in the first patch, and on my boards I see no crashes
anymore.  I also tested all kinds of combinations of calling `ubi part`,
`ubi detach`, `ubifsmount`, `ubifsumount`, `ubifsls`, `ubifsload`, `ls`,
`load`, `size`, and `test -e` and got no crashes anymore after the fix.

The three additional patches (2 to 4) are more or less safeguards and
improvements for the future, and come from me trying and my debugging
code done on the way, more or less optional, but I think nice to have.

Greets
Alex

[1] https://github.com/rauc/rauc/blob/master/contrib/uboot.sh

Alexander Dahl (4):
  fs: ubifs: Fix memleak and double free in u-boot wrapper functions
  fs: ubifs: Set pointers to NULL after free
  fs: ubifs: Make k(z)alloc/kfree symmetric
  fs: ubifs: Add volume mounted check

 fs/ubifs/super.c |  8 ++++++--
 fs/ubifs/ubifs.c | 31 +++++++++++++++++++------------
 2 files changed, 25 insertions(+), 14 deletions(-)


base-commit: 65fbdab27224ee3943a89496b21862db83c34da2
-- 
2.39.2

