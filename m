Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AE5D29C4D
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 19:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 389FB83AAB;
	Mon, 19 Jan 2026 20:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="chLSZsYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FA9E8313B; Mon, 19 Jan 2026 20:07:26 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0D9883A1E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 20:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C88E60054;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FD58C116C6;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768849640;
 bh=/X92dXFD7JRPJEjwp/o703wKHBTDwYjM8O7J/qb/TmY=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=chLSZsYm+itplZ6sM5J+ZNvSOgHp1HZeaPP2GCmJpe+yCusNNvlfYNyh4A6c3lUkA
 m8KCUxdjbKoa2RMtotGNmF03aoMR1yI8mYuCw/WKqYokxKNvD8lI3ToiofKF3tIyoF
 CYlGjy23i0izytpMFsFzUBoYjllISNWWyGpGnsVUXJARd7ePefDVgp6F6IIyysDB6T
 e7DY1DK2iZkgupZPpHIj/oJOdGABEA1tEABMYPMVQgBqk7ZwT7o/Tevc3ksFVLBfve
 aC0maRDzvp5k1nhuRTjYjDCVAM3RTIpe+f6amsgyn9ATjjQqWn7vvMilLCD1khqdBZ
 bM4ApGOBvvQow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC68D29C4D;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v3 0/6] clk: support arbitrary clk_register() sequence
Date: Tue, 20 Jan 2026 03:07:17 +0800
Message-Id: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOaAbmkC/3XMSw6CMBSF4a2Qjq1pL48WR+7DOCjlVhqQkhYbD
 WHvFhIHmjg8J/n+hQT0FgM5ZQvxGG2wbkwjP2REd2q8IbVt2gQYlKwCTvXQU4+T8jjOVNatKE2
 lJLKaJDJ5NPa55y7XtDsbZudfez3y7f0TipwyWkglDJic67I+u8c8ONcftbuTLRXhwyvG2S+Hx
 HNsCmiE1MLwb76u6xsyDN+G6QAAAA==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768849639; l=2889;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=/X92dXFD7JRPJEjwp/o703wKHBTDwYjM8O7J/qb/TmY=;
 b=qOTwUHpmQ6KBfnwpx3+NV+jTXZY+Qb4z+hxRP2Ni/Rvhh1XWLHHbzPMYuianXUGgLrrtFirfX
 IoFH7emPsvpBzkS5Pb2WLd/Ji6dSg8e6ZT69agWY4tW8f/n0LlAJJGC
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
Changes in v3:
- dm: core: drop Simon's rb because the logic is incompelete and broken.
  I forgot to add the child to the parent's child_node list which fails
  the test I've written for the dev_reparent() change. (Simon)
- test: dm: add tests for device_reparent()
- test: clk: rebase onto master, clk_dm() -> dev_clk_dm(), add required
  CLK_ID() macro.
- Link to v2: https://lore.kernel.org/r/20260101-clk-reparent-v2-0-3eb42b78c7f1@outlook.com

Changes in v2:
- tests: add a simple test for this feature
- clk: restrict this feature to only U-Boot proper, excluding xPLs from
  support (Tom)
- clk: some minor tweaks that should not matter too much
- Link to v1: https://lore.kernel.org/r/20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com

---
Yang Xiwen (6):
      drivers: core: device: set new parent when old parent is NULL
      test: dm: core: add some assertions for device_reparent()
      clk: add uclass id check to clk_get_parent()
      clk: use clk_get_parent() helper in clk_en(dis)able()
      clk: allow assigning parent lazily
      test: clk: add test for CLK_LAZY_REPARENT

 drivers/clk/Kconfig           | 12 ++++++++
 drivers/clk/clk-uclass.c      | 72 +++++++++++++++++++++++++++++++++++--------
 drivers/clk/clk.c             | 14 +++++++--
 drivers/clk/clk_sandbox_ccf.c | 10 ++++++
 drivers/core/device.c         |  8 +++++
 include/clk.h                 |  2 ++
 include/sandbox-clk.h         |  2 ++
 test/dm/clk_ccf.c             | 40 ++++++++++++++++++++++++
 test/dm/core.c                | 34 ++++++++++++++++++--
 9 files changed, 178 insertions(+), 16 deletions(-)
---
base-commit: 6b2d05748cf3cd6ba417a96c00602b0122e10af6
change-id: 20250621-clk-reparent-89d75f6a8e09

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


