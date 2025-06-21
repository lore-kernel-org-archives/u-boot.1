Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A5EC7115C
	for <u-boot@archiver.kernel.org>; Sat, 21 Jun 2025 10:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A69682D06;
	Sat, 21 Jun 2025 12:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TR3j3iWn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECBAC809A5; Sat, 21 Jun 2025 12:54:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE93882CCE
 for <u-boot@lists.denx.de>; Sat, 21 Jun 2025 12:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1CE0A5C4A20;
 Sat, 21 Jun 2025 10:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D145C4CEF1;
 Sat, 21 Jun 2025 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750503260;
 bh=fefn13fOFRbn8sA97ASWptiBWflI6IjJSaAKSIFHnlc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=TR3j3iWnjaY37dmaV1/u7Rw7A7mLcCGWj5Wj77Kwdcuj18gPblaVsvKC7Xi1wYzEu
 7i4ZQsD67em/J+lwluoUsTouUy7mIRP/Y3xdXN94fyCoqHvYwAMUlsDZKNrgAseeWg
 3l3E7lAnelQ60+eefusWPuNx83Lzz+MROLflKlyTBqLCHebzfaXptPq5FS4KxtomAS
 pfM0EJ8LwYItMekfQn6YlN3WQtDjjkGA4xPWgXJBqmElQhAhEBbgUaauHko4Qj6hQn
 kKEbn7uni/5OPI3ZF2MjsITEfGhppQlLODahWVOUxSFZrrNb0LGxwtV5JxAQvNsHWU
 qiBCpT5Havmhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3DFC71157;
 Sat, 21 Jun 2025 10:54:20 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 21 Jun 2025 18:54:18 +0800
Subject: [PATCH RFC 1/3] drivers: core: device: set new parent when old
 parent is NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250621-clk-reparent-v1-1-48a7f2f31c59@outlook.com>
References: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
In-Reply-To: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750503259; l=839;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=rhy+xV0NM53o9DGwPd5dEg228yNd5agLsWCZl6AQrlQ=;
 b=JguQ/lYhzykbkwtJhNhk0SybJMgcu07+xWoxHAKji4qpklmRgVu0MMJhnEp54PpQisJ9k47+D
 bVNY1Yo4lRCA+X5PYjGsiI+vlMBzrkWluLnVT4mvhtTGOoOStkkSTYg
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

The old logic does not set the new parent in device_reparent() when old
parent is NULL. It's not desired. Fix it by setting the parent in this
case.

Fixes: cfecbaf4e768 ("dm: core: add support for device re-parenting")
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/core/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index 779f371b9d5b..497c32befde7 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -285,6 +285,11 @@ int device_reparent(struct udevice *dev, struct udevice *new_parent)
 	assert(dev);
 	assert(new_parent);
 
+	if (!dev->parent) {
+		dev->parent = new_parent;
+		return 0;
+	}
+
 	device_foreach_child_safe(pos, n, dev->parent) {
 		if (pos->driver != dev->driver)
 			continue;

-- 
2.43.0


