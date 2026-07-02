Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724F0C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D414284832;
	Thu,  2 Jul 2026 19:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="BcBuoKAY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F7484A0A; Thu,  2 Jul 2026 15:21:26 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D0A84A04
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 15:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liulhong617@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1T
 EWlg52hH1QMNqc3HkDyYEGvYzbhHFN7G31etx8xlo=; b=BcBuoKAYt+vZQnQKlQ
 Ez4tTGygQoa22DOxc8gp4A02PYCtr3ZqDjFgsRr6YXioIPsnhotpu2sJBuA6Rxwp
 YXoWHQwWPQ4Qji1t/H0eqYcT9SwtEV0FufonSfEqaSjNCMkAgfKfC1VzwpRcAPUy
 3JmRMIS6oZBK7IHyJ71aWEwps=
Received: from localhost (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wAnhCWzZUZq4MJFGg--.58672S2; 
 Thu, 02 Jul 2026 21:20:52 +0800 (CST)
From: liulhong617@163.com
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 "Cooper Jr., Franklin" <fcooper@ti.com>
Cc: u-boot@lists.denx.de,
	lianghong617 <liulhong617@163.com>
Subject: [PATCH] Makefile: depend on all OF_LIST dtbs when building
 fit-dtb.blob
Date: Thu,  2 Jul 2026 21:20:51 +0800
Message-Id: <20260702132051.237299-1-liulhong617@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnhCWzZUZq4MJFGg--.58672S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFW3CFyrZF13Aw17tr1xGrg_yoW8Zry5p3
 savr48K34ktF18tay8Ary3ua43tr15tw40yF98A348KF4UGw1Iva1F9w4jgF17Kws7J3yv
 vrs7urW3GF4UGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMQ6L-UUUUU=
X-Originating-IP: [39.170.101.209]
X-CM-SenderInfo: holxzxxrqjliqx6rljoofrz/xtbC+RSyDWpGZbTP4QAA3B
X-Mailman-Approved-At: Thu, 02 Jul 2026 19:22:54 +0200
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

From: lianghong617 <liulhong617@163.com>

When CONFIG_MULTI_DTB_FIT is enabled, fit-dtb.blob is produced by
mkimage with one "-b <dtb>" argument for every entry in
CONFIG_OF_LIST.  The make rule, however, only listed dts/dt.dtb
(i.e. the CONFIG_DEFAULT_DEVICE_TREE blob) as a prerequisite:

  fit-dtb.blob: dts/dt.dtb FORCE
      $(call if_changed,mkimage)

Because FORCE is PHONY, if_changed ignores it and rebuilds only when
any-prereq or arg-check is non-empty.  Editing a non-default dts in
OF_LIST rebuilds its .dtb (that dependency is tracked correctly via
fixdep), but that .dtb is not a prerequisite of fit-dtb.blob, so $?
stays empty; the mkimage command line is unchanged too, so arg-check
is empty as well.  if_changed therefore skips mkimage and fit-dtb.blob
keeps the stale dtbs.  u-boot.bin, which appends fit-dtb.blob, then
ships the old device tree and the dts change does not take effect.

The usual workaround is to wipe the whole build directory and rebuild
from scratch.

Add every OF_LIST dtb as a prerequisite, mirroring the -b arguments
built for MKIMAGEFLAGS_fit-dtb.blob, so that any rebuilt dtb triggers
mkimage via any-prereq.

This changes incremental build behaviour only; a clean build is
unaffected.

Fixes: 6f59fb07f497 ("Makefile: Build additional binaries for dtb FIT blobs appended to U-boot")
Signed-off-by: lianghong617 <liulhong617@163.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 503ac59e65..5b074fb17d 100644
--- a/Makefile
+++ b/Makefile
@@ -1475,7 +1475,7 @@ fit-dtb.blob.gz: fit-dtb.blob
 fit-dtb.blob.lzo: fit-dtb.blob
 	@lzop -f9 $< > $@
 
-fit-dtb.blob: dts/dt.dtb FORCE
+fit-dtb.blob: dts/dt.dtb $(patsubst %,arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) FORCE
 	$(call if_changed,mkimage)
 ifneq ($(SOURCE_DATE_EPOCH),)
 	touch -d @$(SOURCE_DATE_EPOCH) fit-dtb.blob
-- 
2.34.1

