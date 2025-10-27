Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732A1CCF9EE
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131A983946;
	Mon, 27 Oct 2025 18:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jjOA+wCt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lY4nZopL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC28D83952; Mon, 27 Oct 2025 18:08:29 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1743F8393C
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwKhq6CF7z9tQg;
 Mon, 27 Oct 2025 18:08:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wDmD4+lflB/HWmsOCAa3zbExRp6CcvEVp1er5BE/d7w=;
 b=jjOA+wCtOdUoesaAA1DtYoBCHqCau+HXPOrefoev3PSNd1USAzUl4LaNjTPxb6MigZP4HO
 vjlABBuK3ALEHhJi+bPM4COHH9/UDr2GHvc6m5hwd3BlzC3vwdydINdlgIhGZtpdtjQ25u
 Qfa+SCIEto8JRIhQEWoDvtsMAN4x2XbeLY/UQdVbV2YmJQ2BAP8cXideWHywFETIpP496F
 0BJS2hPFX7Og7dmWlORdHYiAx4EjmeqB9m8AQ3EXUpvvLt3MJ0ojXRS4riYsJ4w/aX6Gi6
 Qhz8hix0ob6AFDDQIeqjdTugtidy5xdQ3mRWamRI/CbglAi+9ZzrvpEsQ05CYQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wDmD4+lflB/HWmsOCAa3zbExRp6CcvEVp1er5BE/d7w=;
 b=lY4nZopL36hLnOfdsC7zTeRQMTnBdhX1Z8cD6NNTvRbrHrQQUQOW23bythOZO5o6JDKKDO
 XAkXuR/3r5/fK+LrGs/ZhK1yatP++dIlzCal5VbLK2YdUs4RkMYNO+E2et+Ciip2YDJeA7
 CcHVO/78L98bE4k2XylYyPfeAqaroAaeQROH9c42yZErKvvT/4SPv/L+X9i+kE17/SC7DZ
 hXBca7xI0soL0VRa6XWitXz/R5rmbEslmLJ1JlFHYzB76Uq2r4rdf7aJDHISsOUAbyPl/C
 xsX9lEhwlYMYOlM6K77nriY7Lr0JFBxRuihcwKeUJgoo6NWvbsEA4mvzE9AYGg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Use BIT() macro in R-Car Gen3 header
Date: Mon, 27 Oct 2025 18:08:12 +0100
Message-ID: <20251027170822.29425-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e3e518d2f5398add0a3
X-MBO-RS-META: 1hpud71sy7cfwz18g67p6s3wfzembuix
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

Use the BIT() macro consistently in R-Car Gen3 header.
Fix indent with spaces to tabs at the same time. No
functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/include/mach/rcar-gen3-base.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h b/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
index 7b4f5f0c651..0b1fd017f04 100644
--- a/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
+++ b/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
@@ -73,11 +73,11 @@
 #define GICC_BASE		0xF1020000
 
 /* PFC */
-#define PFC_PUEN5	0xE6060414
-#define PUEN_SSI_SDATA4	BIT(17)
-#define PFC_PUEN6       0xE6060418
-#define PUEN_USB1_OVC   (1 << 2)
-#define PUEN_USB1_PWEN  (1 << 1)
+#define PFC_PUEN5		0xE6060414
+#define PUEN_SSI_SDATA4		BIT(17)
+#define PFC_PUEN6		0xE6060418
+#define PUEN_USB1_OVC		BIT(2)
+#define PUEN_USB1_PWEN		BIT(1)
 
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
-- 
2.51.0

