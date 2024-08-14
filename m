Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D23C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49FBB889BD;
	Wed, 14 Aug 2024 13:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2366E88A77; Wed, 14 Aug 2024 13:02:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0976C88A0D
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E2D2DA7;
 Wed, 14 Aug 2024 04:03:14 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEE793F58B;
 Wed, 14 Aug 2024 04:02:43 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 27/32] test: cedit: use allocated address for reading file
Date: Wed, 14 Aug 2024 16:30:04 +0530
Message-Id: <20240814110009.45310-28-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814110009.45310-1-sughosh.ganu@linaro.org>
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
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

Instead of a randomly selected address, use an LMB allocated one for
reading the file into memory. With the LMB map now being persistent
and global, the address used for reading the file might be already
allocated as non-overwritable, resulting in a failure. Get a valid
address from LMB and then read the file to that address.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Don't use the API version with flags parameter.

 test/boot/cedit.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index fd19da0a0c..923ddd1481 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -7,6 +7,7 @@
 #include <cedit.h>
 #include <env.h>
 #include <expo.h>
+#include <lmb.h>
 #include <mapmem.h>
 #include <dm/ofnode.h>
 #include <test/ut.h>
@@ -61,7 +62,7 @@ static int cedit_fdt(struct unit_test_state *uts)
 	struct video_priv *vid_priv;
 	extern struct expo *cur_exp;
 	struct scene_obj_menu *menu;
-	ulong addr = 0x1000;
+	ulong addr;
 	struct ofprop prop;
 	struct scene *scn;
 	oftree tree;
@@ -86,6 +87,8 @@ static int cedit_fdt(struct unit_test_state *uts)
 	str = abuf_data(&tline->buf);
 	strcpy(str, "my-machine");
 
+	addr = lmb_alloc(1024, 1024);
+	ut_asserteq(!!addr, !0);
 	ut_assertok(run_command("cedit write_fdt hostfs - settings.dtb", 0));
 	ut_assertok(run_commandf("load hostfs - %lx settings.dtb", addr));
 	ut_assert_nextlinen("1024 bytes read");
@@ -94,6 +97,7 @@ static int cedit_fdt(struct unit_test_state *uts)
 	tree = oftree_from_fdt(fdt);
 	node = ofnode_find_subnode(oftree_root(tree), CEDIT_NODE_NAME);
 	ut_assert(ofnode_valid(node));
+	lmb_free(addr, 1024);
 
 	ut_asserteq(ID_CPU_SPEED_2,
 		    ofnode_read_u32_default(node, "cpu-speed", 0));
-- 
2.34.1

