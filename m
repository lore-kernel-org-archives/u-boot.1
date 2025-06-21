Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2EEC7115C
	for <u-boot@archiver.kernel.org>; Sat, 21 Jun 2025 10:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B332A80C83;
	Sat, 21 Jun 2025 12:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fEXP8f/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A138382D4A; Sat, 21 Jun 2025 12:54:23 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9892F809A5
 for <u-boot@lists.denx.de>; Sat, 21 Jun 2025 12:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 93C9BA4D3BD;
 Sat, 21 Jun 2025 10:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F7B6C4CEE7;
 Sat, 21 Jun 2025 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750503260;
 bh=Kr1PMFMv+JN+0XmDqx/X45C5BEyo9RXyrT7a22SKlgE=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=fEXP8f/gQ5xhne2MFWScQpYtIHiueXmSumaqHjNLUWkYaRI7dLC+6OXARoZCPctOa
 WDdoLwVDgWDgklBTLEU43RHktZrx37FRghC+VKhtgsbmIfJ5ymHBXL6Fg0AMifsjjT
 bNCtlO2IU9ao1LTAzT8GZcN81FGtVipVaiiIDNphNv2avfFc/rnVQxlBbSURDTyhQ9
 BCvX848JJosefbozvQH/5Tiiyoop7hCmfi+vYM/PlAhp91G1QFR4UBBZWWS267ZoNw
 zSrVLY62+HQR9EEIfZhNTrgBwMSvUx5hx0LP+fFS60/xMvKgHHZFT1yS1FrsCEfTMx
 fTQ/AkvExc3Nw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 305E5C77B7F;
 Sat, 21 Jun 2025 10:54:20 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RFC 0/3] clk: support arbitrary clk_register() sequence
Date: Sat, 21 Jun 2025 18:54:17 +0800
Message-Id: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFmPVmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyND3eScbN2i1ILEotS8El0LyxRz0zSzRItUA0sloJaCotS0zAqwcdF
 KQW7OSrG1tQC96b0OYwAAAA==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750503258; l=1543;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Kr1PMFMv+JN+0XmDqx/X45C5BEyo9RXyrT7a22SKlgE=;
 b=ZJ9Jd2KUh17Kt6cHU2G3Pc8ks2gIVIIUm10ruOh1X7mskFWALArzUdZUulDcnUBLXiTCbAxGY
 0dmzedxsuDhBE7j85wL8HLmkw/t1MwjgF6FwGRuA9azbxuXSOYBCBSK
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

Currently U-Boot clk framework mandates the sequence of registering clks
to begin from root, and then its children. This is an addtional
requirement that doesn't exist in Linux kernel, which makes clk driver
porting more difficult.

Let's handle this entirely in clk framework and give driver the freedom
to register clocks in any order.

This is done by assigning the parent "lazily". It will cache the parent
name in the core clk struct and try to refresh it when clk consumers
call clk_get_parent(). It's transparent to clk consumers as long as they
only use APIs provided by clk framework.

I've ran `ut dm clk*` and verified these commits does not break any
existing testcases. Though no new testcase is added because I think
existing testcases already test the logic very well.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (3):
      drivers: core: device: set new parent when old parent is NULL
      clk: allow assigning parent lazily
      clk: sandbox: reverse the order to register clk i2c_root and i2c

 drivers/clk/clk-uclass.c      | 47 +++++++++++++++++++++++++++++++------------
 drivers/clk/clk.c             | 14 +++++++++++--
 drivers/clk/clk_sandbox_ccf.c |  6 +++---
 drivers/core/device.c         |  5 +++++
 include/clk.h                 |  2 ++
 5 files changed, 56 insertions(+), 18 deletions(-)
---
base-commit: 721eecd9cbf2cc59c5230abd37d02d4a02f75cc7
change-id: 20250621-clk-reparent-89d75f6a8e09

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


