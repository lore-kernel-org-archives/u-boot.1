Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A747C3DA58
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 17:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09A3B86BB2;
	Thu, 17 Aug 2023 19:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rbx5eyDN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E1A786B96; Thu, 17 Aug 2023 19:04:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA4D86BAF
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 19:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D801F659D6;
 Thu, 17 Aug 2023 17:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E91FFC433CD;
 Thu, 17 Aug 2023 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692291853;
 bh=ZULwSv0gZmvFfkxtGPegKfiNmBml8BrmAmSw/dE6joU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Rbx5eyDNKsC7UiGTHRl9iJhZa6y2vcCKy4zw6putTZcIGyLXd2iDzpKXgkYiOpmxQ
 5/6+doY7NyazN4ydc+cZ/92sXBOfS/l42MSyJlkCZR2sHfiyHo7phUPy1r5p19/x7o
 u9w2XVLz39f8TB1h9avrJ3jysfecdMng5S3SdfhDuPg4xuM6vdYTXdrOGmUEvXoniH
 ADbqJtme4S3tAjjbQIG9VoFMiyjsXBm26RCYStz5KNhwtoDdg7wtgrGLOnic5jVjjA
 cYfAqyDy/2cznSz+q8yrPWRoD6V8EfYN6CFwXwcGOfIDtcA9rdVLW+yCOA0PJwr6oB
 axkWwzAmdRMzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D80E0C3DA58;
 Thu, 17 Aug 2023 17:04:13 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 18 Aug 2023 01:04:04 +0800
Subject: [PATCH RESEND 5/5] clk: ccf: call clock provided ops directly for
 endisable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-clk-fix-v1-5-49ec18f820bf@outlook.com>
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
In-Reply-To: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692291852; l=1348;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=TgVT16K9zaLUEOhpgO1T2uH2QBfAht6D9ePnHRxlfEs=;
 b=DgxbdUdSnGi1NsOABYobcfpgqoPIRuaxcRMH33Z9D5YGn1+EOVWzdrQuvdGCaY5J1AAJkZjEp
 VZlKJsqB6xkBGJvGyStWO4qGzsdikE7DMIUOcA9GVbTjKcVk7YwKmyn
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
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

Calling into CCF framework will cause a clock being enabled twice
instead of once (clk->enable_count becomes 2 rather than 1), thus making
it hard to disable (needs to call clk_disable() twice).
Fix that by calling clock provided ops directly.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/clk.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a38daaac0c..00d082c46f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -14,6 +14,7 @@
 #include <dm/uclass.h>
 #include <dm/lists.h>
 #include <dm/device-internal.h>
+#include <linux/clk-provider.h>
 
 int clk_register(struct clk *clk, const char *drv_name,
 		 const char *name, const char *parent_name)
@@ -115,11 +116,20 @@ int ccf_clk_set_parent(struct clk *clk, struct clk *parent)
 static int ccf_clk_endisable(struct clk *clk, bool enable)
 {
 	struct clk *c;
+	const struct clk_ops *ops;
 	int err = clk_get_by_id(clk->id, &c);
 
 	if (err)
 		return err;
-	return enable ? clk_enable(c) : clk_disable(c);
+	else
+		ops = clk_dev_ops(c->dev);
+
+	if (enable && ops->enable)
+		return ops->enable(c);
+	else if (!enable && ops->disable)
+		return ops->disable(c);
+
+	return -ENOSYS;
 }
 
 int ccf_clk_enable(struct clk *clk)

-- 
2.34.1

