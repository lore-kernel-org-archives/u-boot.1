Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0646C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78665828C2;
	Mon,  5 May 2025 14:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V+DF6yE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 072C381FAB; Mon,  5 May 2025 11:17:18 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 042B082076
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 11:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A2CBB4A5A6;
 Mon,  5 May 2025 09:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28B9BC4CEF0;
 Mon,  5 May 2025 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746436632;
 bh=wC21rofKIP9GFsJSRyBvXCD4OjXior4xQWGfO3vJzno=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=V+DF6yE/PPw2cTF9wLc84VVT0OMmG94uM/CVLnE+sXOqdm8RFRKpGwLQQJLwmLoI0
 gDS6U06R2UzQ9z8OlxpsZzl1h1XYHIdnvtxiBJzQXdOdLsL/5g5N2ypEyfseFH7KeS
 JAZn/tAhQKpJNyxPphqf0AQeHA+tJrp49W5oMpBS1OKNWa+yBltD89iALDiybt5703
 o4+Z+4Q5mMuoLbBSX5bIceKNsoqGMDX72CrGCoF2daxoprKYEIxzrUI9LLFELo3XAf
 m6zfeOYAmquDMciLLATTg+QHVPAvGTc8J/Uo5Pa3VjmEd0FfQ2vBcjo6bc2o1eOtxT
 MNSEeLGnqbJYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1C16CC3ABB6;
 Mon,  5 May 2025 09:17:12 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Mon, 05 May 2025 17:17:10 +0800
Subject: [PATCH v2 2/5] mach-snapdragon: Enhance android image handling
 memory footprint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-android-boot-v2-2-92dcb5bf59c8@gmail.com>
References: <20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com>
In-Reply-To: <20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746436629; l=1349;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=hPXXw+rnIPfVlYotkqpo3tRExQpyYTqNNoYtAyejW30=;
 b=f5nSWTA9QujEEjvboolNlC2Z3mcVknzLAHa19Wy+2yf1kkfh5jzuKnGaoJ/M+PdonSr6iV7hk
 yIYLpGYuM1IBW0uhHjMHMMU47jSKNIesZK1trpy77fgeDhDQf9pE0iK
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Mon, 05 May 2025 14:37:34 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: George Chan <gchan9527@gmail.com>

In order to unzipped kernel from androidboot img, extra memory for
loadaddr is needed. So once fastboot is enabled fastboot memory also
share with loadaddr.

That can balance with memory constrain soc and android usecase.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
 arch/arm/mach-snapdragon/board.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index deae4d32378..3ee0933d962 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -500,8 +500,12 @@ int board_late_init(void)
 	status |= env_set_hex("ramdisk_addr_r", addr_alloc(SZ_128M));
 	status |= env_set_hex("kernel_comp_addr_r", addr_alloc(KERNEL_COMP_SIZE));
 	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
-	if (IS_ENABLED(CONFIG_FASTBOOT))
-		status |= env_set_hex("fastboot_addr_r", addr_alloc(FASTBOOT_BUF_SIZE));
+	if (IS_ENABLED(CONFIG_FASTBOOT)) {
+		addr = addr_alloc(FASTBOOT_BUF_SIZE);
+		status |= env_set_hex("fastboot_addr_r", addr);
+		/* override loadaddr for memory rich soc */
+		status |= env_set_hex("loadaddr", addr);
+	}
 	status |= env_set_hex("scriptaddr", addr_alloc(SZ_4M));
 	status |= env_set_hex("pxefile_addr_r", addr_alloc(SZ_4M));
 	addr = addr_alloc(SZ_2M);

-- 
2.43.0


