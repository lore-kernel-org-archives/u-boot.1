Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC9DC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 19:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B77D187750;
	Fri, 10 Nov 2023 20:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rg1cmvJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F59A87654; Fri, 10 Nov 2023 20:20:02 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C544587754
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 20:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DF31C61AC6;
 Fri, 10 Nov 2023 19:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABAA8C433C9;
 Fri, 10 Nov 2023 19:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699643997;
 bh=VPe+oV2DEeTiE+iWuNlng3t5tsNG+NcrczJS0uRiVpo=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=Rg1cmvJeBtSa0+/eUbCS/wnx/l0f0R5rse9ZgzKkhFjX2NS17WIhodXkfHc/rMnHT
 RTg6vqWxVknsfZSFjBiVdwIJiKYwSA3omiXuwNcd+yh5Pm+ejA+n/jBPb2SLpMRM2k
 GY6CHLRCf4bQDs+SyVTlbx5ymApT16SUvDg+Uo6ZRclEcxriZs0LN6REzBXtP/Grbq
 BX0ts+a8ut6AW36kvaESNq+blGy6mCmgVPG4ecD8XRXRMNQCQbGLzu9wNe3NCups8u
 aTXwTx1+ghh2hk+ShzVthzCB2lfNdQWOI+V3jptbh05SHE4Gg3+rJpBm7PClfJh68/
 F81/AlfVjwKvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF3BC4167D;
 Fri, 10 Nov 2023 19:19:57 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 11 Nov 2023 03:19:52 +0800
Subject: [PATCH v2] clk: check parent_name in clk_register to avoid
 confusing log_error() output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-clk-fix-v2-1-0b688e21fb4e@outlook.com>
X-B4-Tracking: v=1; b=H4sIAFeCTmUC/z2Nyw6CMBREf4Xctde0VdLiyv8wLEq5SMOjpK1EQ
 /h3WxJdnpmTmQ0CeUsBbsUGnlYbrJsTiFMBptfzk9C2iUEwcWGKSTTjgJ19I5ekqrKTleISkt3
 oQNh4PZs++5MOkXwuFk/JPy4edeLehuj853hceU5/49V/fOXIUDHVNprKK5V0d684OjecjZug3
 vf9C4qsuOm5AAAA
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699643996; l=1981;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=EhPK7ucNW+E0Yp0KcbIofxN1hvfnmLx5BFY4JsVqXag=;
 b=S31tMR/BIpt98MPWMGFJ0J2158bMKoiQnokSn5QZnWzECAor7fwieaaK7ukdTHbymTDHxmTYN
 UCNEyQRJpi4BPW9YnuTRTPlSSxjn5XOs3GQrC/WH9v4JXHAEQvfS/ba
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with
 auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

For some gate clocks and fixed clocks without a parent, calling
clk_register will print an useless error message indicating that parent
is missing. Fix that by gaurding log_xxx() with an if-statement.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
Suggested-by: Sean Anderson <seanga2@gmail.com>
---
It's found during my development for HiSilicon clock driver.
---
Changes in v2:
- drop the commit which exports clk_mux_register.
- drop the commit which is already merged
- drop ccf enable_count fix as it'll be in another patchset
- use Anderson's patch for clk_register()
- Link to v1: https://lore.kernel.org/r/20230809-clk-fix-v1-0-808dbae54e5e@outlook.com
---
 drivers/clk/clk.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a5a3461b66..6ede1b4d4d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -18,17 +18,19 @@
 int clk_register(struct clk *clk, const char *drv_name,
 		 const char *name, const char *parent_name)
 {
-	struct udevice *parent;
+	struct udevice *parent = NULL;
 	struct driver *drv;
 	int ret;
 
-	ret = uclass_get_device_by_name(UCLASS_CLK, parent_name, &parent);
-	if (ret) {
-		log_err("%s: failed to get %s device (parent of %s)\n",
-			__func__, parent_name, name);
-	} else {
-		log_debug("%s: name: %s parent: %s [0x%p]\n", __func__, name,
-			  parent->name, parent);
+	if (parent_name) {
+		ret = uclass_get_device_by_name(UCLASS_CLK, parent_name, &parent);
+		if (ret) {
+			log_err("%s: failed to get %s device (parent of %s)\n",
+				__func__, parent_name, name);
+		} else {
+			log_debug("%s: name: %s parent: %s [0x%p]\n", __func__, name,
+				  parent->name, parent);
+		}
 	}
 
 	drv = lists_driver_lookup_name(drv_name);

---
base-commit: 580eb31199be8a822e62f20965854a242f895d03
change-id: 20230807-clk-fix-17e895f79817

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

