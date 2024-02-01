Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA8DC4828C
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 13:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 015A587C2F;
	Thu,  1 Feb 2024 14:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HEcBAPTy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 442E087BD6; Thu,  1 Feb 2024 14:16:20 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDB2C87BF2
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 14:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B84BCCE0D85;
 Thu,  1 Feb 2024 13:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01826C43390;
 Thu,  1 Feb 2024 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706793373;
 bh=mx3cfVJoxWot51jdf+PyK+pgSMZ6c3A85Q4+djVs3CA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=HEcBAPTy7WQMv4TTDMJGqkjVpaiVJovc6+hIIPhoOwiRwByDwJj3JCjQh6At8Kck3
 m9m9vQuU3ZLJsmeP8yWrTauZKpOKNlkH/KopyRQ0GaDyV3zWyfqjX4/RIFngbmXSja
 /1VEdoPmV/UOZhz/huphlWI7VRYRmZCGSy0a0xDvAsSZXCwUdMNysO55NJBSieNB7G
 UZwJThStO+e+MYGdN9ouoDznGpuyGb9KXamLoMB45BIFw/rGGs+202PFO3N5pU7tfc
 dpmaB0nLLuS+MqDuie3zw0zgFsBJqrFhGDqWAOOeRxNrKVsJF7Wc7g0hba3h4nJ6Pe
 YDS46fv+PAm6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E14AEC48291;
 Thu,  1 Feb 2024 13:16:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 01 Feb 2024 21:16:09 +0800
Subject: [PATCH 2/3] test: phy: test generic_setup(shutdown)_phy_bulk()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-ehci-v1-2-bb506cb0f64d@outlook.com>
References: <20240201-ehci-v1-0-bb506cb0f64d@outlook.com>
In-Reply-To: <20240201-ehci-v1-0-bb506cb0f64d@outlook.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706793368; l=1136;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=OKbYdfeAfoB1ENsDPSA3px1Y5YCpK81TWIY83hgQ/SQ=;
 b=7xmLBh+dObuVnzZ+BfM67XzkHrIpjUGmngcKMvmtWmCsyPRrwdw+RSaZaBvuPrGSqeytwiNWE
 sd9mCFmrQwsA5PaRYsmRTXhZmtigKJLdXlAoHtxzLYCFM12JiO52U9f
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

