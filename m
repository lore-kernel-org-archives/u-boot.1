Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA3DC3ABC9
	for <u-boot@archiver.kernel.org>; Sun, 18 May 2025 12:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A96E9828BC;
	Sun, 18 May 2025 14:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HbUl0iXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21DDE80584; Sun, 18 May 2025 13:16:48 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C3A8081A
 for <u-boot@lists.denx.de>; Sun, 18 May 2025 13:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A8D7B4A506;
 Sun, 18 May 2025 11:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 660D6C4CEF3;
 Sun, 18 May 2025 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747567002;
 bh=Au5kfYDykZWh4tNdGwZufZx2916XKZWMNFUmrwMpFtA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=HbUl0iXqqZB2r0QWlrueQ8TlEb15950+fzijFGrOqSSBQtMIdlqvrYysdPuUtrI+W
 Fm1jCXsyO0u07Cm1aWYDtwjcVnJule868ncfAFjhvJEWh9u8ioovCy9RS/2NwXxN/U
 54uuV+l3goNSokydwnFJ8/V4cSQNEB/gv2tMNEZz+DK15faqnir8oU8Q8tu4SkUVNN
 Sz6ICGZDAmKn+mctt/HYKLX88YW/IYOemFqKO3eAu3FTXBNzxAAqmYH1uvZSmQchM/
 gmuEvcb06foweDEC1fat1GNJGfT2esNb4NxbCTEWt9FeXlu8Jg2DzhpgZKSa0p2dY8
 hP+aW54/YwPmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 57F8BC3DA6D;
 Sun, 18 May 2025 11:16:42 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Sun, 18 May 2025 19:16:20 +0800
Subject: [PATCH v3 3/3] mach-snapdragon: Enhance android image handling
 memory footprint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250518-android-boot-v3-3-02c8768e131f@gmail.com>
References: <20250518-android-boot-v3-0-02c8768e131f@gmail.com>
In-Reply-To: <20250518-android-boot-v3-0-02c8768e131f@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747567000; l=1406;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=5MqcY4oWRA3jIaJEq5nkPbwYGfD84Cne/Fh6c5pNYFE=;
 b=kM72fwbnxGSS+CWmwN35xxVHn79/0cZdm5Qx9v0mUjQRuuK5Q0s8xvdzV37FMnZ9lsyfgsDuJ
 VZ3EXYjZOcRAV3mApE/fcLZj+LZka7PR4yhSymp5wAO9Eo/DBhQbwiy
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sun, 18 May 2025 14:45:03 +0200
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: George Chan <gchan9527@gmail.com>
---
 arch/arm/mach-snapdragon/board.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 3ab75f0fce0..e39973c62f6 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -499,8 +499,12 @@ int board_late_init(void)
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


