Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F6ACD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D283848DA;
	Wed,  6 May 2026 14:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TziJydoz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C5A5848DC; Wed,  6 May 2026 14:36:06 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407C8848D8
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 14:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 875D242AC6;
 Wed,  6 May 2026 12:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BB8C2BCC4;
 Wed,  6 May 2026 12:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778070962;
 bh=lTnHaOQcsWOnAuKtW8Io4vrC0JDZOZDoom1Y1F/UPeY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TziJydozeYbnRWFrVxtEwdpUMnpEnTWJGUFuKNZ0YfQjG2hbwe+HzhsbliYEIeyNn
 1hBifkDrutsQ3XAmxiPxHtkwYi4V5kbaZeuO4sQrCzqJO503HWvlhckwZSjm7qKjEr
 HE8LRt7Upw5qN9AU7B/uHGEl0gyPfoSVwMPLGRRaUDXU5IdfE0nMsYLA3ZEvpTLofd
 iAKf2tma6YodRvc4R+avRPqV5VN02CE/OxIWQPqA7DFh0tsSFmoW4AXQR4UKEECXG3
 lqrWvH5ATaG7DsW/7Miftft5tC6Gn9PppNOb5aCzfE3+4K5Pp0hZtEAEQWbiPYLnQP
 hdJIjZb1lx7+w==
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 01/11] powerpc: fix call to cpu_init_r
Date: Wed,  6 May 2026 14:34:10 +0200
Message-ID: <20260506123507.2081751-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506123507.2081751-1-mwalle@kernel.org>
References: <20260506123507.2081751-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Commit 6c171f7a184c ("common: board: make initcalls static") broke the
call to cpu_init_r. That is because PPC is already defined to 1, see:

  powerpc-linux-gnu-gcc -dM -E - < /dev/null

This will conflict with the CONFIG_IS_ENABLED(PPC). Change it to
IS_ENABLED(CONFIG_PPC).

Fixes: 6c171f7a184c ("common: board: make initcalls static")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 common/board_r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_r.c b/common/board_r.c
index 5d37345ca09..9b6ba9d8e56 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -687,7 +687,7 @@ static void initcall_run_r(void)
 	INITCALL(initr_flash);
 #endif
 	WATCHDOG_RESET();
-#if CONFIG_IS_ENABLED(PPC) || CONFIG_IS_ENABLED(M68K) || CONFIG_IS_ENABLED(X86)
+#if IS_ENABLED(CONFIG_PPC) || CONFIG_IS_ENABLED(M68K) || CONFIG_IS_ENABLED(X86)
 	/* initialize higher level parts of CPU like time base and timers */
 	INITCALL(cpu_init_r);
 #endif
-- 
2.47.3

