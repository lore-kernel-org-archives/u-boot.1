Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9D6EEB56D
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:52:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D419841C2;
	Wed, 31 Dec 2025 20:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jbaGuI2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D574D841D2; Wed, 31 Dec 2025 20:52:52 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89168418A
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B8DE560017;
 Wed, 31 Dec 2025 19:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70B96C16AAE;
 Wed, 31 Dec 2025 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767210769;
 bh=wKVEn8DnXmfY+0ZysQLJSWDDrDqVjDT6ZxkMCZKgQuA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=jbaGuI2bKoOXg9UtfuqHE0KTuExHKEe+LVxfCnhXbSRgZ0kBgfEq6mF1wQRQY0ZPF
 F47kiZvgEsD5rKQCXLxLj6KDaRxx9bjh1DKZ/la3flqfhGWMtZS9LCHWioDEjy1zLv
 ynmYJrmO5OoHfdppcCSeCLpEnObQEiDH1NtAGnuAC/ZpcPtv8BInrtv+OiMVbLe5ev
 qxl2FnDT/MhOLEO1F5kEEyY76S4F+oI47kH5rCF+8aas9wxwjyLex1Vt8WmpHvSxAr
 VjL0Phf9Z7y8E5WjgZrvvGOUuoexr1Ir3OWghA2hpIdS9C+OHuFbcom/+2n09WdJMV
 kLGTro1lrlBwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 63910EE645E;
 Wed, 31 Dec 2025 19:52:49 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 01 Jan 2026 03:52:47 +0800
Subject: [PATCH v2 1/5] drivers: core: device: set new parent when old
 parent is NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-clk-reparent-v2-1-3eb42b78c7f1@outlook.com>
References: <20260101-clk-reparent-v2-0-3eb42b78c7f1@outlook.com>
In-Reply-To: <20260101-clk-reparent-v2-0-3eb42b78c7f1@outlook.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767210769; l=855;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=XznkdepdWTVh+68VXRGyyBWqop//US/HHAe8lwYVuMM=;
 b=R2eFXeJFU4R3n1BMJZs/m97jSSTKFD6b+J0aTsOtjJVl3Jvezy+3JRvwo5JOhnxu4InxuuI5L
 GFh8l1rurxwAwdbmi0skhR7yExbx2xmnKLwSfNfCM+PZygoJsRLKSGA
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


