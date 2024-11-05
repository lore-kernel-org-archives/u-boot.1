Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AB7D3176B
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 17:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89582891CF;
	Tue,  5 Nov 2024 18:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0AF8891DD; Tue,  5 Nov 2024 18:22:15 +0100 (CET)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fa9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87BE288C44
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:22:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XjZs01RBHzW2F;
 Tue,  5 Nov 2024 18:22:12 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4XjZrz4YJWz14Q; Tue,  5 Nov 2024 18:22:11 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 05 Nov 2024 18:21:58 +0100
Subject: [PATCH next RFC 4/5] ram: rk3399: merge two consecutive ifs with
 same condition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-rk3399-dram-init-v1-4-1e29acdf0966@cherry.de>
References: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
In-Reply-To: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Nothing changes channel_mask in the first if block of the same condition
so it is safe to merge the two if blocks with the same condition into
one.

No intended change in behavior.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/ram/rockchip/sdram_rk3399.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 5a82c7ccbdf161526f0d1450dde6881441e59543..d953dda13cd3daa689fa362dc511c372db454064 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -811,9 +811,7 @@ static int pctl_start(struct dram_info *dram,
 	if (channel_mask & 1) {
 		writel(0x01000000, &ddrc0_con_0);
 		clrsetbits_le32(&denali_phy_0[957], 0x3 << 24, 0x2 << 24);
-	}
 
-	if (channel_mask & 1) {
 		count = 0;
 		while (!(readl(&denali_ctl_0[203]) & (1 << 3))) {
 			if (count > 1000) {
@@ -849,8 +847,7 @@ static int pctl_start(struct dram_info *dram,
 	if (channel_mask & 2) {
 		writel(0x01000000, &ddrc1_con_0);
 		clrsetbits_le32(&denali_phy_1[957], 0x3 << 24, 0x2 << 24);
-	}
-	if (channel_mask & 2) {
+
 		count = 0;
 		while (!(readl(&denali_ctl_1[203]) & (1 << 3))) {
 			if (count > 1000) {

-- 
2.47.0

