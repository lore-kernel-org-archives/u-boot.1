Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAE0EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 22:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D5386B86;
	Mon, 21 Aug 2023 00:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="JIWG+7T+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB83F86B7E; Mon, 21 Aug 2023 00:03:22 +0200 (CEST)
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net
 (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3EB486BB2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 00:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:mime-version:to:cc:content-transfer-encoding:
 content-type:cc:content-type:from:subject:to;
 s=s1; bh=NU6qtZ1EZGYS3MDXoL9SQWFel89XqnNqwf/+febGscA=;
 b=JIWG+7T+DDtEPcgFrdwNgINGl/i/+qA+qckRiS6UZltPFIf867oTDe3GkmPmKTyAsofQ
 Siw9NvZT1j4FVhT8cgL7pebsYANkKyFqDXYVMdm3QceRLOC4cuGa7qeguXyPvgmJEWIClv
 xX7tq0gdkvNANss7he1ZYB7ZCIr88sNr5Y4L4FF/79O22a0nQJ6EgGdcckZRelzRcBVcuW
 vpYzRlma1mxqjJPdwNEoUjb94fSwXO/yZqeAzoGcksFwA9C6sn5lETj9m6dxOhwPNSkBzI
 Tm/Am8kHE6ZH5qP3IIyVGHXX5R5A7tKm6UtTebcF8jEtxbaerURi8xKnJX/6vjpw==
Received: by filterdrecv-d7bbbc8bf-nzpnk with SMTP id
 filterdrecv-d7bbbc8bf-nzpnk-1-64E28DA6-2C
 2023-08-20 22:03:18.486924057 +0000 UTC m=+8807005.431115623
Received: from bionic.localdomain (unknown) by geopod-ismtpd-8 (SG) with ESMTP
 id J3VR7207RKePWscx8uOr6w Sun, 20 Aug 2023 22:03:18.098 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2] dm: core: Report bootph-pre-ram/sram node as pre-reloc
 after relocation
Date: Sun, 20 Aug 2023 22:03:18 +0000 (UTC)
Message-ID: <20230820220316.3517102-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h=2F=2FwZoAdzh5=2FzxlrK?=
 =?us-ascii?Q?JCxyG5B5Hj0VWsr0f53+1EaNjwHPncgbaBuoRyY?=
 =?us-ascii?Q?53fZnyxGgU7Yfq7rhw+Fkzj4+NlJhDp=2FHopx=2FKt?=
 =?us-ascii?Q?AHwNcHsxLr7tycY8wL3nkiU0UdTY3FsGu=2FdukQz?=
 =?us-ascii?Q?gXr=2FBEf5h7bE0ywOUwruZ2Sr5eoX53pq1lm6Pa?=
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

Nodes with bootph-pre-sram/ram props are bound in multiple phases:
1. At TPL (bootph-pre-sram) or SPL (bootph-pre-ram) phase
2. At U-Boot proper pre-relocation phase
3. At U-Boot proper normal phase

However the binding and U-Boot Driver Model documentation indicate that
only nodes marked with bootph-all or bootph-some-ram should be bound in
the U-Boot proper pre-relocation phase.

Change ofnode_pre_reloc to report a node with bootph-pre-ram/sram prop
with a pre-reloc status only after U-Boot proper pre-relocation phase.
Also update the ofnode_pre_reloc documentation to closer reflect the
binding and driver model documentation.

This changes behavior of what nodes are bound in the U-Boot proper
pre-relocation phase. Change to bootph-all or add bootph-some-ram prop
to restore prior behavior.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- Drop use of !! to convert into bool
- Update documentation for ofnode_pre_reloc
- Rewrite commit message
- Collect r-b tag

 drivers/core/ofnode.c | 2 +-
 include/dm/ofnode.h   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 8df16e56af5c..b1e94b2d60df 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1353,7 +1353,7 @@ bool ofnode_pre_reloc(ofnode node)
 	 */
 	if (ofnode_read_bool(node, "bootph-pre-ram") ||
 	    ofnode_read_bool(node, "bootph-pre-sram"))
-		return true;
+		return gd->flags & GD_FLG_RELOC;
 
 	if (IS_ENABLED(CONFIG_OF_TAG_MIGRATE)) {
 		/* detect and handle old tags */
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 0f38b3e736de..13700f8266d7 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1198,15 +1198,15 @@ int ofnode_read_simple_size_cells(ofnode node);
  * determine if a node was bound in one of SPL/TPL stages.
  *
  * There are 4 settings currently in use
- * - bootph-some-ram: U-Boot proper pre-relocation only
+ * - bootph-some-ram: U-Boot proper pre-relocation phase
  * - bootph-all: all phases
  * Existing platforms only use it to indicate nodes needed in
  * SPL. Should probably be replaced by bootph-pre-ram for new platforms.
- * - bootph-pre-ram: SPL and U-Boot pre-relocation
- * - bootph-pre-sram: TPL and U-Boot pre-relocation
+ * - bootph-pre-ram: SPL phase
+ * - bootph-pre-sram: TPL phase
  *
  * @node: node to check
- * Return: true if node is needed in SPL/TL, false otherwise
+ * Return: true if node should be or was bound, false otherwise
  */
 bool ofnode_pre_reloc(ofnode node);
 
-- 
2.41.0

