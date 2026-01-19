Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38343D29C4D
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 19:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2324B8389A;
	Mon, 19 Jan 2026 20:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U4HN80wD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D7A83A83; Mon, 19 Jan 2026 20:07:26 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C68B88313B
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 20:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 984B360135;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F7FCC19424;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768849640;
 bh=dHfia6EKsEISrDG205tOfoFaxG/GwxaoYF+rzo634iE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=U4HN80wD0AStPSokNxPvXJIas474R8/QfIJAdLHUZnCw/owmBhnozn+BrIoJk8uyC
 HbASRYoy3X6ds1rlT+fDylNdTanh6sivYWHaXzHUmE5uSmT3LRINiJDQ5D0mwIUcr2
 G9/b0YNJMdTe0Vyi3lc9gdBij9ZFp4b1JqPQ8T7cuod1V+vsMJFcwfgaYHCTiL/KQK
 oYo46kSobNb45tCL361NOeEAVVkmADgUlxl74Q+aF1d0KR3sgjyAKZjOxFSiLxHb7S
 aBWfVTKVOeOHWCNCB7B9dEr1sGh3fANlfbKhBrBvW+NvKOP1XUobaO1X+Q3YjlF/Yj
 1FkE9aAWpI5Fw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5BCCF2DE;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Jan 2026 03:07:18 +0800
Subject: [PATCH v3 1/6] drivers: core: device: set new parent when old
 parent is NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-clk-reparent-v3-1-0d43d4b362ac@outlook.com>
References: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
In-Reply-To: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768849639; l=969;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=OkZuox6Z1IbENHdSA3AsovLwcHU5OVol0g+5GscgV+U=;
 b=0dzAguuUjbQMz7yawY5OA4wG6fUnDbvwJAUEfhAhT35dlYvGQZNAOGRe6dGPNRXWpVWhPswpI
 n/79eTFy/8zAI92dM36ScNrKTIqrvgIZ4XHW1I6BJcuWY83ftFBc6Pc
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

The current logic does not update the new parent in device_reparent() if
old parent is NULL. The behavior is not desired. Fix it by setting the
parent in this case.

Fixes: cfecbaf4e768 ("dm: core: add support for device re-parenting")
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/core/device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index 779f371b9d5b..0ae09f5a4e33 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -285,6 +285,14 @@ int device_reparent(struct udevice *dev, struct udevice *new_parent)
 	assert(dev);
 	assert(new_parent);
 
+	if (!dev->parent) {
+		assert(list_empty(&dev->sibling_node));
+
+		list_add_tail(&dev->sibling_node, &new_parent->child_head);
+		dev->parent = new_parent;
+		return 0;
+	}
+
 	device_foreach_child_safe(pos, n, dev->parent) {
 		if (pos->driver != dev->driver)
 			continue;

-- 
2.43.0


