Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C7CC3DA58
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 17:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E1586B9A;
	Thu, 17 Aug 2023 19:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JYrwBjfp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E65286BB4; Thu, 17 Aug 2023 19:04:21 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D78E486B98
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 19:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 46E2A61589;
 Thu, 17 Aug 2023 17:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6C02C433C8;
 Thu, 17 Aug 2023 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692291853;
 bh=HRI1qmWbSnnmrsMMWS7kDsrErXlHhOstH6hcX+XwmEQ=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=JYrwBjfpVt+2PcDnK4/4YBMq/9fIsT5QMmF7Qql+fmzz3rkX0F/ro0UozRrrsFYVr
 JyjeVCOA+S3XXoA2fSpvHZs1G2hjRKV2o65oCd3VLA1XF51ajWzX0QrLBS/EJXR729
 +2eJOthkzm/r8cElnAG0xundVmj9ReOXkYNmoF5avSnAZqlsoDZuvzJMKfmRu4kNtQ
 +RunMqDRq68F80k9fsVsJisAAuTS8Gea0oyoQt8a30iOtZ7cO+27NfzZ7IqTxZ9b5p
 Jo7xC2JA3hGpS56C9I4GnSsJj06YFzIGOiMlzvRLlkuOWYCjxcUbdQYZ+oYrGCzzmo
 jAyYGXdAMoutg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8E769C3DA54;
 Thu, 17 Aug 2023 17:04:13 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RESEND 0/5] clk: A few bugfixes/enhancements for CCF
Date: Fri, 18 Aug 2023 01:03:59 +0800
Message-Id: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692291852; l=867;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=HRI1qmWbSnnmrsMMWS7kDsrErXlHhOstH6hcX+XwmEQ=;
 b=qLjGHFPLpOBZwAplfku45AOn8a5U62PY551kdldrABgrJoHMi4bEclii61twB/JoOqa05Rxsm
 TM8yPof8cXDAnPGu4+XfSdMalaXc8CLY/J6MzDyrJycCOJV5rDeS67H
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

They are found during my development for HiSilicon clock driver. Details
are in commit logs.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (5):
      clk: export clk_register_mux_table()
      clk: call log_debug() instead to avoid console log printing
      clk: also handle ENOENT in *_optional functions
      clk: promote clk_dev_ops to linux/clk-provider.h
      clk: ccf: call clock provided ops directly for endisable()

 drivers/clk/clk-uclass.c     |  5 -----
 drivers/clk/clk.c            | 16 +++++++++++++---
 include/clk.h                |  8 +++++---
 include/linux/clk-provider.h | 11 +++++++++++
 4 files changed, 29 insertions(+), 11 deletions(-)
---
base-commit: 580eb31199be8a822e62f20965854a242f895d03
change-id: 20230807-clk-fix-17e895f79817

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

