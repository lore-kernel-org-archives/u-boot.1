Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68915E6749A
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 11:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD95183E83;
	Mon, 22 Dec 2025 12:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="A9+VsmtU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5A2083E8E; Mon, 22 Dec 2025 12:44:44 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 075F483D3C
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 61A553FEDE; 
 Mon, 22 Dec 2025 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766403882;
 bh=5GyecDZRN0627q8MGheVFhilE8IyLk/XVMEJK7B/cLk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=A9+VsmtUQxXLKVBMraiu/C1a9KAejVRux20ZIoJ+O6IvXg1VyLFvxTFn0Sur73Cp2
 Lonbi1GHMh7JsuYYDlTpgt7dyQq/C+RP+lmC20XYTlad/iZV1qKl7o3NWCRe7z/ycW
 K+ATru8F91MmMPu7uJJlrbYRYXVexjTiSmMFS50zRHo4+K4LCaRhzzVKO2C2yWTw0C
 bP2JxmaIK8+wgqzppwX73K5Gx6XjYCuT093Wuyfo3GdWqmOuALE8QBK4E5wzGgAvfT
 L6aJUtTq64Pr5/Pcm8/uMginXVb2Q4kPQB74Hzyp6NgxP4vC72kDDPgU5kxmYKwbgo
 itzEfizGBF0JwCS8jGB33SNTjWQp3BLiRkC/R1ob74KkxBNsyamEQCYo1/8pYtP2vQ
 zsTKheqCpMlOxbNMSpZ/mpPFLVSnCJsN1jlXfRJbP4OCbM4uo7St1tOUvBuqGg1HEQ
 Joaz01th/mcxUAf/zTAeFmuaIFPrzQzO6EfpKsmuN45SY3+m/reT6adRR0L12PPuqV
 Y/VuE4yCmeEcHl/nq3wjPfFPruOtA0eJsfQbx2rxgO9+bxIZJGeBSkS/ZYkeShnft3
 Q7bf8iQx3dXgHaQBoqtgVErs/h6ltdboOp1H3Kf82051VJOuDy4GvcFGyGSK8Tz+8M
 yY6QyK/Zx/RgsxJta2VowOKY=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] cmd/bdinfo: LMB and device-tree are not related
Date: Mon, 22 Dec 2025 12:44:38 +0100
Message-ID: <20251222114438.18990-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

The usage of the LMB library and the device-tree source are not related.

Remove the dependency in the bdinfo output and adjust the unit test.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	correct typo 'adjuste' in commit message
---
 cmd/bdinfo.c      | 9 +++++----
 test/cmd/bdinfo.c | 8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 20c8c97f0cd..8e2bbfa9c20 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -160,11 +160,12 @@ static int bdinfo_print_all(struct bd_info *bd)
 #if CONFIG_IS_ENABLED(MULTI_DTB_FIT)
 	bdinfo_print_num_l("multi_dtb_fit", (ulong)gd->multi_dtb_fit);
 #endif
-	if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
+	if (IS_ENABLED(CONFIG_LMB))
 		lmb_dump_all_force();
-		if (IS_ENABLED(CONFIG_OF_REAL))
-			printf("devicetree  = %s\n", fdtdec_get_srcname());
-	}
+
+	if (IS_ENABLED(CONFIG_OF_REAL) && gd->fdt_blob)
+		printf("devicetree  = %s\n", fdtdec_get_srcname());
+
 	print_serial(gd->cur_serial_dev);
 
 	if (IS_ENABLED(CONFIG_CMD_BDINFO_EXTRA)) {
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 2b4866a172e..3005c85d4a0 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -191,11 +191,11 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 	ut_assertok(test_num_l(uts, "multi_dtb_fit", (ulong)gd->multi_dtb_fit));
 #endif
 
-	if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
+	if (IS_ENABLED(CONFIG_LMB))
 		ut_assertok(lmb_test_dump_all(uts));
-		if (IS_ENABLED(CONFIG_OF_REAL))
-			ut_assert_nextline("devicetree  = %s", fdtdec_get_srcname());
-	}
+
+	if (IS_ENABLED(CONFIG_OF_REAL) && gd->fdt_blob)
+		ut_assert_nextline("devicetree  = %s", fdtdec_get_srcname());
 
 	if (IS_ENABLED(CONFIG_DM_SERIAL)) {
 		struct serial_device_info info;
-- 
2.51.0

