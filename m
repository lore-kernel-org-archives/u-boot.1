Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD3EC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 07:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5054C88896;
	Tue, 30 Jul 2024 09:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49341887E4; Tue, 30 Jul 2024 09:09:43 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2544C8881F
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 09:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E7E1720140A;
 Tue, 30 Jul 2024 09:09:39 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B8A0E20140D;
 Tue, 30 Jul 2024 09:09:39 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 1C9D51800318; Tue, 30 Jul 2024 15:09:38 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org, marex@denx.de, lukma@denx.de,
 seanga2@gmail.com, xypron.glpk@gmx.de
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv4 04/14] test: cpu: add test for release CPU core.
Date: Tue, 30 Jul 2024 15:29:53 +0800
Message-Id: <20240730073003.28892-5-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add test for API cpu_release_core().

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
V4:
 - No change.

 test/dm/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/dm/cpu.c b/test/dm/cpu.c
index acba810599..8af25316ce 100644
--- a/test/dm/cpu.c
+++ b/test/dm/cpu.c
@@ -43,6 +43,8 @@ static int dm_test_cpu(struct unit_test_state *uts)
 	ut_assertok(cpu_get_vendor(dev, text, sizeof(text)));
 	ut_assertok(strcmp(text, "Languid Example Garbage Inc."));
 
+	ut_assertok(cpu_release_core(dev, 0));
+
 	return 0;
 }
 
-- 
2.17.1

