Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19A0C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC58387C6E;
	Fri, 15 Dec 2023 19:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eYEvpJMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF5CD87C56; Fri, 15 Dec 2023 19:29:00 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 608A087C5D
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6B47DCE2F6F;
 Fri, 15 Dec 2023 18:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89DC8C433CA;
 Fri, 15 Dec 2023 18:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702664934;
 bh=OUovCpskf3sjR88V7uRl9KTZC43ZbpJtQSn38lTvjqk=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=eYEvpJMUAnqJNQlE2bpaWgwnfCeP52DIo6zvsq+QSPYPCs/lCmPuCl3RcXcORyEy8
 Gz+C38zQjmPhBvxXduwOTSYAUkBkqRRCsHmlTtT9CkHTmkZQjO6v2p0j56TRKHV7Ie
 6uwDY/qF+m94HBnMLRU5KvocIKzwCzt+FTT0TV74sYoTjeKRhlz7osdR7iWPvE+BQZ
 Y4a2D8ZWaM5uDa+7HvBtG+/VdrxQvzGivhyYsjPj3IIBUf6CR7t3+pE0pPEl0E7I88
 NwxWNlrDEzB4gDF4UEl0/YaUCGPjz12YSr1Jc5dkDL9DnZjUtA7hfARRAtURyy72+L
 dmWFUIbY/ADXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4BFC4167B;
 Fri, 15 Dec 2023 18:28:53 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v3 0/2] clk: ccf: fix enable_count mismatch
Date: Sat, 16 Dec 2023 02:28:50 +0800
Message-Id: <20231111-enable_count-v3-0-08a821892fa9@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOKafGUC/32NQQ7CIBAAv9JwFrOAra0n/2GMAbq1xBYMtETT9
 O9Cbx50b7Ob2VlIQG8wkFOxEI/RBONsArEriO6lvSM1bWLCgQuWhqKVasCbdrOdqGxLACZ4VbO
 SJEXJgFR5aXWfpVGGCX0+PD125rV1LtfEvQmT8+8tG1ne/ihERoGW0HQHANk0Wp3dPA3OPfbaj
 SS/ivyfzpPOAcWR1xWAKr/1dV0/Bg0eXwIBAAA=
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702664931; l=1401;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=OUovCpskf3sjR88V7uRl9KTZC43ZbpJtQSn38lTvjqk=;
 b=tkgiV1QT1VUw06eQuTJ0AKBio9C1QAt5nKD05m0lnxNHrBb+gcB7+5CZgZKBsIcST2q0X3XNt
 KhSVzoVzENlBP7Hr8TgX6zSH2xLHR1jHg/8TCIOrPwbjlQLnOHgs3bL
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with
 auth_id=44
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

As described in [1], enable_count is incremented by 2 when
ccf_clk_enable() is called. This series of patch fixed this issue and
added a testcase for that.

[1]: https://lore.kernel.org/all/SEZPR06MB695927A6DEEEF8489A06897396A7A@SEZPR06MB6959.apcprd06.prod.outlook.com/

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v3:
- move i2v_root in front of devm clocks. So that clk_test driver needs a
  minimum modification
- squash patch 1, 3 and 4. -- Suggested by Sean
- rewrite commit log for clarity.
- Link to v2: https://lore.kernel.org/r/20231111-enable_count-v2-0-20e3728600b5@outlook.com

Changes in v2:
- add missing SoB in patch 1/4, no functional change
- Link to v1: https://lore.kernel.org/r/20231111-enable_count-v1-0-509f400a99cb@outlook.com

---
Yang Xiwen (2):
      clk: get correct ops for clk_enable() and clk_disable()
      test: dm: clk_ccf: test ccf_clk_ops

 arch/sandbox/dts/test.dts      |  4 +++-
 arch/sandbox/include/asm/clk.h |  1 +
 drivers/clk/clk-uclass.c       |  2 ++
 drivers/clk/clk_sandbox_ccf.c  |  1 +
 drivers/clk/clk_sandbox_test.c |  1 +
 test/dm/clk_ccf.c              | 14 +++++++++++---
 6 files changed, 19 insertions(+), 4 deletions(-)
---
base-commit: 3b913c148249a2b9d12ff25517ec311646e83bee
change-id: 20231111-enable_count-ad5001326815

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

