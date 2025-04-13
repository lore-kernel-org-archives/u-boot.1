Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79689C369AE
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 20:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D7382917;
	Sun, 13 Apr 2025 22:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Q3/mFQKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9012982AAF; Sun, 13 Apr 2025 22:00:06 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA3B828D0
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 22:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b5c5=XA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744574402; bh=8VlmQLHVZAehP0eIoS79OCe7QsSd3EnJ3BJ/k5/b2Ck=;
 b=Q3/mFQKU9e3m5esiC6DzOK0Fy8LsCL+XwpafDycNsTd0QXFj6QnfOz1GAVOe4LshdjrqD6QQr
 TO3H1laOwEXEkWOLzciLSEY2ii5o9DKVmFRZkQXiND8dpbC1Y7aq1cEDJPK0ADwOx+HDChMclIR
 XI7njoG8hfdMYDBhWHJCVj5CpXXGfcJoJ+N5QwkGVtvyi2G9pYWTk3zPuK3+WfAG3eP+l7j7FyL
 qht/iskQE7u3EtH77kYxZO2cm6aFSH75YzKveQcIyFt5qwAXjpyU4oS4w3zRrkGHhPUscvLOt69
 SuYs81vRNAdRI9Ko09GrJv1JjDEO8PSHMvGqTx3yXd1w==
X-Forward-Email-ID: 67fc17be6900761fb1516291
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v6 1/7] rockchip: binman: Correct the OS prop for U-Boot
Date: Sun, 13 Apr 2025 19:59:33 +0000
Message-ID: <20250413195949.432730-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413195949.432730-1-jonas@kwiboo.se>
References: <20250413195949.432730-1-jonas@kwiboo.se>
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

From: Simon Glass <sjg@chromium.org>

The U-Boot image is currently being identified as an invalid OS in
spl_fit_image_get_os() due to case sensitive compare.

Use the correct lower-case value to fix this.

Fixes: e0c0efff2a02 ("rockchip: Support building the all output files in binman")
Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v6:
- Collect r-b tag

Changes in v5:
- Collect r-b tag

Changes in v4:
- Update commit message
- Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
---
 arch/arm/dts/rockchip-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index c8c928c7e508..e9ed1d4b5738 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -50,7 +50,7 @@
 				u-boot {
 					description = "U-Boot";
 					type = "standalone";
-					os = "U-Boot";
+					os = "u-boot";
 #ifdef CONFIG_ARM64
 					arch = "arm64";
 #else
-- 
2.49.0

