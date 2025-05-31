Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C39C5B549
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 13:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D5B82116;
	Sat, 31 May 2025 15:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SaDgKSLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E8A82B0F; Sat, 31 May 2025 15:10:24 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB2CA82B07
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 15:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7A5925C552A;
 Sat, 31 May 2025 13:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17206C4CEE3;
 Sat, 31 May 2025 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748697021;
 bh=J6wkmFfInW7sCuAc23x3i6ek8Bjdyzz/1bK11sB27nc=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=SaDgKSLWduBkPmd6uX16CuOrWzDT2vx6CHGh45frDoZoEoZ1FAJiKF3GPbgrJOHMZ
 iEvS/5BeW7szqoscKax64Go9/Bt01k/DHoMrs7+JUnnP8BzxrTw87aSEMKv3XvBqeY
 eXG+T8dU14GUVq7fdY0ZB7Y4T8Tb/0J79uoWHRqbOVhu2ZtVclbVgTXNBAIB9ZpIqB
 DOVh7iXC++Nwz1/81UeMZwVOsjQKI+yQ1eEPIwGC6KLIEOnSkAn+ocStZrqr9NYIpA
 +aKCRfbPRUxLNszXc1AVXP4dSRBFjJpzsTrm2dXb5TWnby7yf53nI8wBQTNdTaVwW3
 AxhVCbE6bZsIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4CC5AE59;
 Sat, 31 May 2025 13:10:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH 0/2] arm: armv7: fix a bug that prevents CONFIG_BLOBLIST
 and CONFIG_POSITION_INDEPENDENT to be enabled together
Date: Sat, 31 May 2025 21:10:01 +0800
Message-Id: <20250531-pie_blob_fix-v1-0-7b4a37987dbc@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKn/OmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyNL3YLM1PiknPyk+LTMCt1EM0MjI8tki7TkZDMloJaColSgMNi46Nj
 aWgD34gdsXgAAAA==
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748697019; l=599;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=J6wkmFfInW7sCuAc23x3i6ek8Bjdyzz/1bK11sB27nc=;
 b=mJa2pGoYHUF9D8ixQXjkTEDmNwABLppxunfYU5k59XybeIAMVyvVOeks4zWxYsNIbforoBURT
 CXf28k/4RSoB3jZ6376k/PTiOfG+Pal0q1BDvE/UhBZb0A494c19+DW
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

This patchset also enables CONFIG_POSITION_INDEPENDENT for qemu boards
to avoid similar issues to happen again in the future.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (2):
      arm: armv7: restore section to .text after saved_args
      arm: qemu: Add imply CONFIG_POSITION_INDEPENDENT

 arch/arm/Kconfig           | 1 +
 arch/arm/cpu/armv7/start.S | 2 ++
 2 files changed, 3 insertions(+)
---
base-commit: 93905ab6e7564089f5d7b703b660464d675e5ab0
change-id: 20250529-pie_blob_fix-a61229c8fcc6

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


