Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCCBC4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 17:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF5987CFA;
	Wed,  7 Feb 2024 18:19:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i+qwQmZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B388789B; Wed,  7 Feb 2024 18:19:29 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACA3687CFC
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 18:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9E697CE1AA4;
 Wed,  7 Feb 2024 17:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDB51C43394;
 Wed,  7 Feb 2024 17:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707326363;
 bh=mx3cfVJoxWot51jdf+PyK+pgSMZ6c3A85Q4+djVs3CA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=i+qwQmZyyoaA8loMLMueuUimJM41zwkgr/8oujzg1ch9+D5cHGss1M4UKuWNuBqO6
 /TY3y7Z7jXFCm53FSghZ1rxrxGvVQXAoCWqEug2xRww34Vsdtf4lI1nXgh4ndXFCPV
 O503p+uYvae/YP2Fl5lnYhTX+9jqTTpIc2YFr+kmw83fn1OiGueii0s0jqNhJmc4iE
 1iXGpIqpUuA1SAeejpp9Ef4YucI4ht1u4zknWz7tqcKbg5zJgm5vEuIxCcue0yVvAR
 HSw2thJpCBQwkgksmb2hxOvY/9J2TT5hT8+IQUFublLQl7eeHIIkTtxt4/88/05VKB
 DT23OJMqYx5yg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C7EC2C4828D;
 Wed,  7 Feb 2024 17:19:23 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 08 Feb 2024 01:19:21 +0800
Subject: [PATCH v2 2/3] test: phy: test generic_setup(shutdown)_phy_bulk()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-ehci-v2-2-6bf084b7ffac@outlook.com>
References: <20240208-ehci-v2-0-6bf084b7ffac@outlook.com>
In-Reply-To: <20240208-ehci-v2-0-6bf084b7ffac@outlook.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707326360; l=1136;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=OKbYdfeAfoB1ENsDPSA3px1Y5YCpK81TWIY83hgQ/SQ=;
 b=jv8MRHQ/4vlPRVo9IVd0yFrkGFp4Jxl3ZCBl2yk+PUKMnnqTTNUL0myH3nzZZZTQC9aKcmei4
 XhGvj32EbsNCjiKKANPev54CZgRwo/p/xmsXS7FJfiwsW+LtEdfkQh3
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

add unittests for the newly introduced helper functions.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 test/dm/phy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/test/dm/phy.c b/test/dm/phy.c
index 0cf3689fde..cb16844a0a 100644
--- a/test/dm/phy.c
+++ b/test/dm/phy.c
@@ -159,6 +159,8 @@ static int dm_test_phy_bulk(struct unit_test_state *uts)
 	ut_asserteq(0, generic_phy_power_on_bulk(&phys));
 	ut_asserteq(0, generic_phy_power_off_bulk(&phys));
 	ut_asserteq(0, generic_phy_exit_bulk(&phys));
+	ut_asserteq(0, generic_setup_phy_bulk(parent, &phys));
+	ut_asserteq(0, generic_shutdown_phy_bulk(&phys));
 
 	/* has a known problem phy */
 	ut_assertok(uclass_get_device_by_name(UCLASS_SIMPLE_BUS,
@@ -171,6 +173,8 @@ static int dm_test_phy_bulk(struct unit_test_state *uts)
 	ut_asserteq(-EIO, generic_phy_power_on_bulk(&phys));
 	ut_asserteq(-EIO, generic_phy_power_off_bulk(&phys));
 	ut_asserteq(0, generic_phy_exit_bulk(&phys));
+	ut_asserteq(-EIO, generic_setup_phy_bulk(parent, &phys));
+	ut_asserteq(-EIO, generic_shutdown_phy_bulk(&phys));
 
 	return 0;
 }

-- 
2.43.0

