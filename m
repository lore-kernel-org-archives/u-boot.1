Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA882C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B1887508;
	Sat, 18 Nov 2023 23:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="vC9OoOAd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A18AC874FC; Sat, 18 Nov 2023 23:10:17 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532BB8749D
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A3F1FCE009E;
 Sat, 18 Nov 2023 22:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1C36C433C8;
 Sat, 18 Nov 2023 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700345407;
 bh=cIJV6B09g+7Xx319ac9aHiH8ENi3eVyuNM0Ph9jsENg=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=vC9OoOAd8v3rAIh4UEyiFI22SnLS4kTovReTeyXaTlJjCEHAFYftoKScKtjz8w0ge
 h0XsW1YsMRR4Yp3Y8pYcqgKvk1pQAvnXuXBT6gg8+ltAI8vw8ej795yZ8zBkY83Yz0
 e/2Iotms9XdFcI9Y+QkmDxgRpGy9ug0oqmBIyi45jkQmNdBpAdrZRJDHyOLEq1zqjc
 Vb0l3vlCxYCfKznrLA25lbToEFCeoPkKnFoNkzBDGAXVG97PFSYuscnKwyOb6quD+l
 nbNM60BG8V84bcXz1+2i0SmrgOvRNxyQXmIvOZzR100rsR79F+5X5+IDym7i6x2ACl
 oEA3vXShp3eWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C0520C2BB3F;
 Sat, 18 Nov 2023 22:10:07 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v2 0/4] clk: ccf: fix enable_count mismatch
Date: Sun, 19 Nov 2023 06:10:04 +0800
Message-Id: <20231111-enable_count-v2-0-20e3728600b5@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADw2WWUC/3WNwQ6CMBBEf4X0bM22iBFP/ochZlsWaYSuaQvRE
 P7dwt25vZlM3iIiBUdRXItFBJpddOwz6EMhbI/+SdK1mYUGXaocSR7NQA/Lk08S2wpAlfp8UZX
 IF4ORpAnobb+dRoyJwja8A3Xus3vuTebexcThu2tntbV/DLOSICuouxMA1rU1N57SwPw6Wh5Fs
 67rD9hGnM7DAAAA
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700345405; l=1251;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=cIJV6B09g+7Xx319ac9aHiH8ENi3eVyuNM0Ph9jsENg=;
 b=QTRVdx+VB8iyOPawZnuOQ0CkwnJbwR98lmbst7ZNbdyFqfAixe74NULSP5AKanre/V63seBmw
 bIxdMuCnptNAX7dVCfVFCgNW2cyGUh1G66Ysnu8JEJw/6tR2b+28yi0
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
Changes in v2:
- add missing SoB in patch 1/4, no functional change
- Link to v1: https://lore.kernel.org/r/20231111-enable_count-v1-0-509f400a99cb@outlook.com

---
Yang Xiwen (4):
      clk: clk_sandbox_ccf: assign ccf_clk_ops to .ops of the driver
      clk: get correct ops for clk_enable() and clk_disable()
      clk: clk_sandbox: get devm clock i2c_root
      test: dm: clk_ccf: get "i2c_root" clock from &clk_ccf

 arch/sandbox/dts/test.dts      |  6 ++++--
 arch/sandbox/include/asm/clk.h |  1 +
 drivers/clk/clk-uclass.c       |  2 ++
 drivers/clk/clk_sandbox_ccf.c  |  1 +
 drivers/clk/clk_sandbox_test.c |  5 +++++
 test/dm/clk_ccf.c              | 14 +++++++++++---
 6 files changed, 24 insertions(+), 5 deletions(-)
---
base-commit: 3b913c148249a2b9d12ff25517ec311646e83bee
change-id: 20231111-enable_count-ad5001326815

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

