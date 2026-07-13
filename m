Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C7DC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:23:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8595084B7A;
	Mon, 13 Jul 2026 15:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="UO8y/Ln5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4442584A4B; Mon, 13 Jul 2026 09:46:01 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6371B84A48
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 09:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liulhong617@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fv
 yhptfiHJWLtCur8aVRK5hVx1BdwGrLPIp5wZxf1ys=; b=UO8y/Ln5mwod9B1EpM
 B9ehMBfCyGPKJmgvuVG8nivziOwIKSC9lAqH/gkFoGXj65ywz632a+ppBihfrLtO
 lB5qtVOt1sl+/QQTYge7nEpx1LOl3ENKW/Gn3BlFRK1oqLyPU8vzrVrHxIDslRhf
 0H3SuZrBrauqyMTLYF+QXJTxc=
Received: from liulianghong01.hobot.cc (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3n_Gjl1RqtnlWJA--.34828S2; 
 Mon, 13 Jul 2026 15:45:40 +0800 (CST)
From: lianghong617 <liulhong617@163.com>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	lianghong617 <liulhong617@163.com>
Subject: [PATCH v2] Makefile: depend on OF_LIST dts sources for fit-dtb.blob
Date: Mon, 13 Jul 2026 15:45:39 +0800
Message-Id: <20260713074539.32875-1-liulhong617@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3n_Gjl1RqtnlWJA--.34828S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1xtFy5Xryfur1ftFWDArb_yoWrWr4fp3
 sYvr48Kr1kJFWrtay8Zr4xua43K3sxtryjkF95Jr10yr45Gw1xuFsakayjqr17Jwn7t3yY
 vrs2v3y3GF45Wa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRb6p9UUUUU=
X-Originating-IP: [39.170.101.209]
X-CM-SenderInfo: holxzxxrqjliqx6rljoofrz/xtbC+gS+GWpUl6TzcAAA3X
X-Mailman-Approved-At: Mon, 13 Jul 2026 15:20:59 +0200
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

When CONFIG_MULTI_DTB_FIT is enabled, fit-dtb.blob is produced by
mkimage with one "-b <dtb>" argument for every entry in
CONFIG_OF_LIST.  The make rule, however, only listed dts/dt.dtb
(i.e. the CONFIG_DEFAULT_DEVICE_TREE blob) as a prerequisite:

  fit-dtb.blob: dts/dt.dtb FORCE
      $(call if_changed,mkimage)

Because FORCE is PHONY, if_changed ignores it and rebuilds only when
any-prereq or arg-check is non-empty.  Editing a non-default dts in
OF_LIST rebuilds its .dtb (tracked correctly via fixdep), but that
.dtb was not a prerequisite of fit-dtb.blob, so $? stayed empty; the
mkimage command line was unchanged too, so arg-check was empty as
well.  if_changed therefore skipped mkimage and fit-dtb.blob kept the
stale dtbs.  u-boot.bin, which appends fit-dtb.blob, then shipped the
old device tree and the dts change did not take effect.

A previous attempt to fix this added every OF_LIST .dtb *output* as a
prerequisite.  That is wrong on two counts:

  * Clean build regression: the OF_LIST .dtb files are produced only
    by the recursive dts/dt.dtb -> arch-dtbs sub-make descent and have
    no rule at the top make level, so listing them as prerequisites
    makes them rule-less/intermediate.  After a from-scratch rebuild
    (e.g. `rm -rf out/.../build/uboot`) it fails:

      make[1]: *** No rule to make target 'arch/arm/dts/<of>.dtb',
               needed by 'fit-dtb.blob'.  Stop.

  * Incremental two-build race still present: the .dtb outputs are
    written by a child sub-make, whose mtime updates GNU make does not
    re-stat in the top-level process (GNU make bug #58734).  if_changed
    evaluates $? (prerequisites newer than the target) using that cached
    mtime; when the stale fit-dtb.blob mtime is newer than the stale
    .dtb mtime (the normal post-build state, since mkimage runs after
    dtc), $? is empty at evaluation time and mkimage is skipped, so the
    edit still needs two `make` invocations to take effect under
    parallel make (the `bdm uboot` flow runs `make -j33`).

Depend on the OF_LIST *source* .dts files instead of the compiled .dtb
outputs.  The .dts sources are found via VPATH (srctree) and never need
a recipe at this level, so they do not break a clean build.  Their mtime
is set by the user's edit rather than by a child sub-make, so it is
always fresh in the top-level process and any-prereq fires mkimage in a
single parallel make, sidestepping the cached-mtime race entirely.

This fixes both the clean-build regression and the incremental
two-build race without serialising the target.

Fixes: 6f59fb07f497 ("Makefile: Build additional binaries for dtb FIT blobs appended to U-boot")
Signed-off-by: lianghong617 <liulhong617@163.com>
---
Changes in v2:
  - Depend on the OF_LIST *.dts sources instead of the compiled *.dtb
    outputs.  The previous version added every OF_LIST *.dtb as a
    prerequisite, which broke clean builds ("No rule to make target
    'arch/arm/dts/<of>.dtb'") because those .dtb files are produced by
    the recursive dts/dt.dtb -> arch-dtbs sub-make descent and have no
    rule at the top make level.
  - The source-dep approach also closes an incremental two-build race
    left by the .dtb-output approach: child sub-make mtime updates are
    not re-stated by the top-level process (GNU make bug #58734), so
    $? stayed empty and a single parallel `make -j` invocation still
    needed to be run twice.  .dts mtimes are set by the user's edit and
    are always fresh, so any-prereq fires in one pass.
  - Add the Fixes: tag.
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7d83ce16721..a9aa51b2108 100644
--- a/Makefile
+++ b/Makefile
@@ -1212,7 +1212,7 @@ fit-dtb.blob.gz: fit-dtb.blob
 fit-dtb.blob.lzo: fit-dtb.blob
 	@lzop -f9 $< > $@
 
-fit-dtb.blob: dts/dt.dtb FORCE
+fit-dtb.blob: dts/dt.dtb $(patsubst %,arch/$(ARCH)/dts/%.dts,$(subst ",,$(CONFIG_OF_LIST))) FORCE
 	$(call if_changed,mkimage)
 ifneq ($(SOURCE_DATE_EPOCH),)
 	touch -d @$(SOURCE_DATE_EPOCH) fit-dtb.blob
-- 
2.34.1

