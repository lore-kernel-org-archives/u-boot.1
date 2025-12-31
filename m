Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA1DEEB56D
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F9D841E2;
	Wed, 31 Dec 2025 20:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KLBJ76at";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 112EE841CC; Wed, 31 Dec 2025 20:52:55 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E801D8419E
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AE77560008;
 Wed, 31 Dec 2025 19:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63A33C113D0;
 Wed, 31 Dec 2025 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767210769;
 bh=mSu9TmXAvfG7agAICGA9sCQanawvbrUqjTizOlYNKFw=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=KLBJ76atxMgpELxIdvrxwR5A6PPwEyaiczx/gxkxNo56JlLLsUKw7J5qQQUd8DKFg
 YRamhUZg2VuJIDOcw5oLBCUEnP5dUO3yDvuvztq2xXQTOkh1dBmb6ltFhkJSZ540Kf
 YvtQPf8TfotsxERo0tpoSBR4zClPUlyzG4JomBftEQ7u7j6y2Yf9yJWO0f+zq/TUSs
 Hj0iCEwXl6OO4up0NDEe8eWhMMgmbn1cblKfZ1BcHscf3IXKEM/FuTMTi7FJhr/JwR
 WUymD37ax5/BA1Jei3ClFryB7d0gYO1G5LM2sO8PpAk19TQNBbg3zH9imfD0W3G2aR
 v8o2t4Y0XiHow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 52ABFEEB56D;
 Wed, 31 Dec 2025 19:52:49 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v2 0/5] clk: support arbitrary clk_register() sequence
Date: Thu, 01 Jan 2026 03:52:46 +0800
Message-Id: <20260101-clk-reparent-v2-0-3eb42b78c7f1@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA9/VWkC/3XMQQ7CIBRF0a00fywGUFroyH2YDgj9WNJaGkCia
 di72LnD+5J3dogYHEbomx0CZhedX2vwUwNm0usDiRtrA6dc0JYzYpaZBNx0wDURqcZO2FZLpAr
 qZQto3fvg7kPtycXkw+fQM/utf6DMCCVXqTvL7YUZoW7+lRbv57PxTxhKKV8RirxsqgAAAA==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767210768; l=2298;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=mSu9TmXAvfG7agAICGA9sCQanawvbrUqjTizOlYNKFw=;
 b=JmGI2ZSWzxrd2RKgBTV0fgd/wT6gStN1GmbjFfD1ZplWdsiMFtjiDKcGvYLg4SH4qVy7w2Ani
 Mg2VqwcpZnmBkIC22M+wvDwEX9FExyhjTLRypPnPopxkaipgsdmGWcp
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

Currently, the U-Boot clk framework mandates that clock registration
begins at the root and proceeds to children. This creates an additional
requirement that does not exist in the Linux kernel, making the porting
of clk drivers more difficult.

This series handles the dependency entirely within the clk framework,
allowing drivers the freedom to register clocks in any order.

This is achieved by assigning the parent "lazily". The framework caches
the parent name in the core clk struct and attempts to resolve the
actual parent when clk consumers call clk_get_parent(). The process is
transparent to clk consumers as long as they use standard clk framework
APIs.

I've run `ut dm clk*` and verified these commits do not break any
existing test cases. It also passes the new test case.

This feature is disabled for xPLs by default. I have not found a clean
way to enable this separately for xPLs without introducing a repetitive
Kconfig entry (e.g., xPL_CLK_LAZY_REPARENT), which looks very ugly.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v2:
- tests: add a simple test for this feature
- clk: restrict this feature to only U-Boot proper, excluding xPLs from
  support (Tom)
- clk: some minor tweaks that should not matter too much
- Link to v1: https://lore.kernel.org/r/20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com

---
Yang Xiwen (5):
      drivers: core: device: set new parent when old parent is NULL
      clk: add uclass id check to clk_get_parent()
      clk: use clk_get_parent() helper in clk_en(dis)able()
      clk: allow assigning parent lazily
      test: clk: add test for CLK_LAZY_REPARENT

 drivers/clk/Kconfig           | 12 ++++++++
 drivers/clk/clk-uclass.c      | 72 +++++++++++++++++++++++++++++++++++--------
 drivers/clk/clk.c             | 14 +++++++--
 drivers/clk/clk_sandbox_ccf.c | 10 ++++++
 drivers/core/device.c         |  5 +++
 include/clk.h                 |  2 ++
 include/sandbox-clk.h         |  2 ++
 test/dm/clk_ccf.c             | 29 +++++++++++++++++
 8 files changed, 132 insertions(+), 14 deletions(-)
---
base-commit: 721eecd9cbf2cc59c5230abd37d02d4a02f75cc7
change-id: 20250621-clk-reparent-89d75f6a8e09

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


