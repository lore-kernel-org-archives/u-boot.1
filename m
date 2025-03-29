Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696E1C3600C
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 15:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20214809A5;
	Sat, 29 Mar 2025 16:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KdyiwMSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A762809A5; Sat, 29 Mar 2025 16:07:05 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71BD805C8
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 16:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1dca=WR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743260821; bh=laBcCxVL/q2PEylrEChY8jEOgr2VM+36I787y/8VsXw=;
 b=KdyiwMSLeInVg9O3VHERBUIJNAuwqD1obKtLCqQQeRjEd2UVeQyOPighwpMc3pvSqUpjy8KAU
 0uVvh01h8NVtYu28fi/IEavkIG/3RGRMcVSLvtuJYE3RYvCohI0AqGbXgebi2zJfyDN4VgGY8a+
 Jo8FlM0FG1ZorwZhXTKN53Qu2nXgXhmLt3i5OtYGO/FIkWhd4+6TP+J1zPHVmfXcDn3hH36gkTZ
 KNuHsqKvuL30hGEucO+hsc0Ek2UwBtTOR8Lv/Rhs5LuHJ/tdE29D57dGJ3MemlgDkI5PXnkfoFT
 f4zrmM0HmtskdmKOqpDEgk5NlbRF+SMFr0dcaDSguoFg==
X-Forward-Email-ID: 67e80c9421787eb134711fa1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 08/10] rockchip: binman: Use the skip-at-start prop in
 simple-bin image
Date: Sat, 29 Mar 2025 15:06:11 +0000
Message-ID: <20250329150626.2879942-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250329150626.2879942-1-jonas@kwiboo.se>
References: <20250329150626.2879942-1-jonas@kwiboo.se>
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

The simple-bin image is normally written to MMC media at block 64, which
is a 32K offset from start of storage media.

Set the skip-at-start property to 0x8000 (32 KiB) so that fdtmap and
other embedded binman symbols in the output binary is referencing image
offsets correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v4:
- Drop defconfig changes
- Split from "VBE serial part H: Implement VBE on Rockchip RK3399"

Changes in v2:
- Move this patch to the end of the series
- Drop 0x8000 offset for SPI
---
 arch/arm/dts/rockchip-u-boot.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index fb38b7b80c43..65b81bf58626 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -154,6 +154,7 @@
 	simple-bin {
 		filename = "u-boot-rockchip.bin";
 		pad-byte = <0xff>;
+		skip-at-start = <0x8000>;
 
 		mkimage {
 			filename = "idbloader.img";
@@ -178,7 +179,7 @@
 #else
 		u-boot-img {
 #endif
-			offset = <CONFIG_SPL_PAD_TO>;
+			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
 		};
 
 		fdtmap {
-- 
2.49.0

