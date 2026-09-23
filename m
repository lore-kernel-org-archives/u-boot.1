Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6BFC982EA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 09:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9626080D18;
	Wed, 23 Sep 2026 09:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9cUVudVWjZAY; Wed, 23 Sep 2026 09:35:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D8AB480D21
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790156129;
	b=QftS+l31iXWjbSDTV8KKne0LRZzAfeuEnl+AfEjX13b1/cLfooc8eFbqcV00lTWgNsMm
	 loXi3fVLn/4lCRVOQg+tp1bTlqMkHlDMR/jA3DKxh9lH04BtuGc6SyG1BQGcdoxQ+Jvk4
	 9RrNMWBEMUSGC+t199J+Q3HL+MQcOeG4lM+Qf+ydJ/+ac8txdBje1K7p337t3BRYRSrP6
	 +flW30aptC2vxopv3YvV2n/gpullz2ru4LRyalq5SWFPIMFAZrBU6Rl5KCsTSTj2edIQa
	 JGnmKpX5Jyj6SiUmGKnLjDxFqMZ0j6ikG7rgEvtV7q4dCdckqwJJEvIFh4pfP0B53Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790156129;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fKNxdGVp/JtARvET/viUItl85kjHRJLumpt1ENUBwdM=;
	b=oAOYf9mOiWnuxL/aNDL6mCNlIAVOphjSwbQC+Q+w/8iMjWD6qUsZidlTOtVnnU5SuQsA
	 5PXmuVnkiRiAKq1yQILuuzg5J+C2IMIYNmZkYjhYOP/rpmnT7/1XSJ6I1qCPOuwHI8u1K
	 RgkNNn030F7dXmudc9RB/Xi7RKiL9b6+44hLIZMcDl0E/yh9V47pDNNWPWu1kFcviZ/Y6
	 Xcirsse36t8XDeQM8nboAF8LsJ7lxT4qUlNAEAeSdyOSEM+zvDS1/9sb27wl8lSAO90wX
	 XXVF7jHKElqDooV1ouRL0uprx1jbUnVdjBOq+Dco+QoNwQxP2HYuCyLK6tAYjZHGAbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790156129;
	bh=fKNxdGVp/JtARvET/viUItl85kjHRJLumpt1ENUBwdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MJdqnwDIdac6+Y/BCRAShw9jnmtc/CWZA2wmnuJ2KwAXJ+1ZcYt7/ZE97AS3KakG1
	 Ymqe65nOSxQlhblG+aGG6LhscGHu1+UvuyTOmCfJtDn7Ql+gJ/KwZSBgvjXM0deuyg
	 Gzi4bLF+Tml5+qt9fZ6fOjOaW+OEzIUrFj43oDx0aJ++e0Oe8kwbHy4+dVkSgiWl4R
	 OSMq8/wU2LeTRvKybR+TS1mZWQoCeulGyDlnVhhXuH0O6mBfWHV3oDQetqzp793E90
	 +LYea/4g71zjnUD6/4OXQ6ZqZ6L71RdeqaEZd5ik9NpBDRt+TmyK4r++9Fh3WJORYT
	 JtXtLQqxw7KKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8AB480D21;
	Wed, 23 Sep 2026 09:35:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D3CC912C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C59F8404C9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bB9zD5WZRr87 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 09:35:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A20ED405E7
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790156125;
 b=a/yhVTGneGlA/r+4rNFDbZk45KcC12zjeCHM52+4wFc6HJgTNgf7Ymgek1GkWMuhURAV
 kpJO3wrCOV0x7hr7lR0zbBZV5NYCdgF8+xYAk7Y1Kij2smQFdQdD4R5+5pW6zKiV5utnn
 yvY0eKpzaewQP7BoI/4qPLr35fTSi1vDkw4EvR89IE8HTtLpxY7U5LPyyN+DchQ2o7Ecr
 Ka+48KI7BRB9vAsz1zNo/1cpJtsS7paqZSRBb/I9sY3s596PwfADeutq3RXrEES7lD4bh
 w2NYzvvaEWoQY2ZtblV1VEXYxBTD4jbNrip4NjAwBrKJuodrwizlslDcXjSZyq+LAOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790156125;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=fKNxdGVp/JtARvET/viUItl85kjHRJLumpt1ENUBwdM=;
 b=nbHAt4c0grnd5DGQHMYXdeopdiKrS1gM2jPzbxCLEfLbzhYrWgADXE2+uBnfx/QWPvC8
 00unhD2+hPWyDgw6ejWn8dn5JIR1X+GFfbn9LeN7PWdPZi9WXcIve9oKr4m+Apobn3WJ8
 fKYPKwGGEUdInds5u27uYYXzx/Jq8APQQi9DN9Cgpran0ofr7ifK+LdFcR4GI3xe9w02m
 fk2kMIeO9vAcdeS3vYMxBUTh+QFA+fvute971dq7uU5vJUDkwumXWYBWHVlb5jvzWa9QB
 N+Df4kFq+/iEwpBbIjXgqqQLV/iRkv+W7mLfj4b6Ls89nMyiA83u3nUtwd7qlAEcDTw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cCCARouM; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cCCARouM
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A20ED405E7
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00F1841379;
 Wed, 23 Sep 2026 09:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A981F00893;
 Wed, 23 Sep 2026 09:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790156124;
 bh=fKNxdGVp/JtARvET/viUItl85kjHRJLumpt1ENUBwdM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cCCARouM+tzC1U/ROJiKMa/dfnc7Qs4SzksL0+I8sVF4aMnUXw+VdWB/1KH4PkJvl
 i1dJGDXCJC4IGAoqVGy7kn4HmikWgCxRftlfTMmC5DgHYWXaowbB4CuUsvNZOqNd3h
 bVHy70O/5j1Ch//roqgrZW/zLDeHtsfUz8syb9x0nCfTWOH2auWgET/VXseQrZBAwF
 ZMUtDPZIBQCjX7VFJXYLXGiZOnEMBnmziQdU5dsfrnGBp4kZgxRk+d1sk65ihKMgrI
 71MxxIRaNeBps+uJI1Zi8Q0IJkPa2KnufMc5uC3YCNyity0Ndko8b8d0o1Z5zdWcjM
 o73zX4QupcBZA==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 23 Sep 2026 09:34:31 +0000
Subject: [PATCH v2 8/8] reset: spacemit: Add SpacemiT K3 reset driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-01-k3-clock-reset-support-v2-8-6ec0abb1c7b5@kernel.org>
References: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
In-Reply-To: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21565; i=dlan@kernel.org;
 h=from:subject:message-id; bh=T4PQI5q3JsW4IXc+SsVW/BS8l523vDjhK2/bl2oWteE=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs509btljFEEKDuBUfGDHdc+c1n7yKTn4DCKKU
 AomQ1rUpFqJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarOdPRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2sAg//cEuMu1VyvSgHxExs1yNuHbd6MneuhkB26e6SOx1jUapdWgDPTinLv
 2y/tLdfDsPr1zIIosw1559BtKSrbwka8fp2Hc+gqFs4SPVHATAuFJI2qz+wbCbLZkKTUTrTlzyw
 6jNJsEcYFqyki++ISIhI/VaFP5xzW6Q0ZVs2znLAO/KFp4NO7JJnPgFkM/LsjtNV2VmaAPG8hEH
 v7wqXgLFiGgMjFT3kuvahfHrB1+UiwF3au4uBkD9D8lRwboxVC1jdKOSq7jWTI0aqsUnKJFSaqB
 h48hk7inhzyEoAN+RMnNRUAlBGCCwtA5T7jznSVKTksrau3CBSFdNrkVj44GjMQ7tsvSyx9pStG
 t2FYMMOsNvu0Aa3+e/R82HhCQL/ncG9MH3q+9Pw8GCr2sNv5tjR8hq3bTOsOsANOxajS5/hbCBd
 f62SWeXySYu2eX80Lb/+0Oeqs/oJtWJTkNIotKdmuhCAzOfGIPT4rYfZGcKS9rmOXUOzGDEz9Fn
 kY6Zoyl1E29BAyoOZlFcayLoOOFDsLjh9mL8U+sT7MBS3w86c1MUObyVWnzhmdIS/wjx6u/iI/w
 uksEx3t0LLmLIfBx4KZNRunQ6eJICLrd1IiGIcyghXCUBA2P2ILsGm90TTOaNdJFUL9DkMx13sI
 nBkxnkzad3o6BoT2f6SkIs4wL9BCwk=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Based on upstream Linux:
  938ce3b16582 ("reset: spacemit: Add SpacemiT K3 reset driver")

Add support for the SpacemiT K3 SoC reset controller. The K3 reset
driver reuses the common reset controller code and provides K3-specific
reset data for devices managed by the following units:

- MPMU (Main Power Management Unit)
- APBC (APB clock unit)
- APMU (Application Subsystem Power Management Unit)
- DCIU (DMA Control and Interface Unit)

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/clk/spacemit/Kconfig               |   1 +
 drivers/clk/spacemit/clk-k3.c              |  25 +++
 drivers/reset/spacemit/Kconfig             |   7 +
 drivers/reset/spacemit/Makefile            |   1 +
 drivers/reset/spacemit/reset-spacemit-k3.c | 242 +++++++++++++++++++++++++++++
 include/soc/spacemit/k3-reset.h            |  21 +++
 6 files changed, 297 insertions(+)

diff --git a/drivers/clk/spacemit/Kconfig b/drivers/clk/spacemit/Kconfig
index c305f433871..a782426fe0f 100644
--- a/drivers/clk/spacemit/Kconfig
+++ b/drivers/clk/spacemit/Kconfig
@@ -24,6 +24,7 @@ config CLK_SPACEMIT_K1
 config CLK_SPACEMIT_K3
 	bool "SpacemiT K3 clock support"
 	select CLK_CCF
+	select RESET_SPACEMIT_K3
 	help
 	  This enables support clock driver for Spacemit K3 SoC.
 	  It's based on Common Clock Framework.
diff --git a/drivers/clk/spacemit/clk-k3.c b/drivers/clk/spacemit/clk-k3.c
index 3191654ea72..f4f1bb7bf04 100644
--- a/drivers/clk/spacemit/clk-k3.c
+++ b/drivers/clk/spacemit/clk-k3.c
@@ -9,6 +9,7 @@
 #include <dm/device_compat.h>
 #include <regmap.h>
 #include <linux/clk-provider.h>
+#include <soc/spacemit/k3-reset.h>
 #include <soc/spacemit/k3-syscon.h>
 
 #include "clk_common.h"
@@ -1955,6 +1956,26 @@ U_BOOT_DRIVER(k3_pll_clk) = {
 	.flags		= DM_FLAG_PRE_RELOC,
 };
 
+static int k3_mpmu_clk_bind(struct udevice *dev)
+{
+	return spacemit_k3_reset_bind(dev, SPACEMIT_K3_RESET_MPMU);
+}
+
+static int k3_apbc_clk_bind(struct udevice *dev)
+{
+	return spacemit_k3_reset_bind(dev, SPACEMIT_K3_RESET_APBC);
+}
+
+static int k3_apmu_clk_bind(struct udevice *dev)
+{
+	return spacemit_k3_reset_bind(dev, SPACEMIT_K3_RESET_APMU);
+}
+
+static int k3_dciu_clk_bind(struct udevice *dev)
+{
+	return spacemit_k3_reset_bind(dev, SPACEMIT_K3_RESET_DCIU);
+}
+
 static const struct udevice_id k3_mpmu_clk_match[] = {
 	{ .compatible = "spacemit,k3-syscon-mpmu",
 	  .data = (ulong)&k3_ccu_mpmu_data },
@@ -1967,6 +1988,7 @@ U_BOOT_DRIVER(k3_mpmu_clk) = {
 	.name		= "k3_mpmu_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= k3_mpmu_clk_match,
+	.bind		= k3_mpmu_clk_bind,
 	.probe		= k3_mpmu_clk_probe,
 	.ops		= &k3_mpmu_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
@@ -1984,6 +2006,7 @@ U_BOOT_DRIVER(k3_apbc_clk) = {
 	.name		= "k3_apbc_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= k3_apbc_clk_match,
+	.bind		= k3_apbc_clk_bind,
 	.probe		= k3_apbc_clk_probe,
 	.ops		= &k3_apbc_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
@@ -2001,6 +2024,7 @@ U_BOOT_DRIVER(k3_apmu_clk) = {
 	.name		= "k3_apmu_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= k3_apmu_clk_match,
+	.bind		= k3_apmu_clk_bind,
 	.probe		= k3_apmu_clk_probe,
 	.ops		= &k3_apmu_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
@@ -2018,6 +2042,7 @@ U_BOOT_DRIVER(k3_dciu_clk) = {
 	.name		= "k3_dciu_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= k3_dciu_clk_match,
+	.bind		= k3_dciu_clk_bind,
 	.probe		= k3_dciu_clk_probe,
 	.ops		= &k3_dciu_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
diff --git a/drivers/reset/spacemit/Kconfig b/drivers/reset/spacemit/Kconfig
index 20e4cc6e4d8..66ab5f85333 100644
--- a/drivers/reset/spacemit/Kconfig
+++ b/drivers/reset/spacemit/Kconfig
@@ -13,3 +13,10 @@ config RESET_SPACEMIT_K1
 	help
 	  Reset controller for SpacemiT K1 (MPMU/APBC/APMU/APBC2).
 	  Bound from the K1 CCU/syscon devices.
+
+config RESET_SPACEMIT_K3
+	bool "SpacemiT K3 reset support"
+	select RESET_SPACEMIT_COMMON
+	help
+	  Reset controller for SpacemiT K3 (MPMU/APBC/APMU/DCIU).
+	  Bound from the K3 CCU/syscon devices.
diff --git a/drivers/reset/spacemit/Makefile b/drivers/reset/spacemit/Makefile
index 56f9fd1ab20..f89d068e1ca 100644
--- a/drivers/reset/spacemit/Makefile
+++ b/drivers/reset/spacemit/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_RESET_SPACEMIT_COMMON)	+= reset-spacemit-common.o
 obj-$(CONFIG_RESET_SPACEMIT_K1)		+= reset-spacemit-k1.o
+obj-$(CONFIG_RESET_SPACEMIT_K3)		+= reset-spacemit-k3.o
diff --git a/drivers/reset/spacemit/reset-spacemit-k3.c b/drivers/reset/spacemit/reset-spacemit-k3.c
new file mode 100644
index 00000000000..358211a2f88
--- /dev/null
+++ b/drivers/reset/spacemit/reset-spacemit-k3.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SpacemiT K3 reset driver (syscon-bound).
+ *
+ * Copyright (C) 2025-2026 SpacemiT Technology Co. Ltd
+ */
+
+#include <dm.h>
+#include <dt-bindings/reset/spacemit,k3-resets.h>
+#include <linux/bitops.h>
+#include <soc/spacemit/k3-reset.h>
+#include <soc/spacemit/k3-syscon.h>
+
+#include "reset-spacemit-common.h"
+
+static const struct spacemit_reset_data k3_mpmu_resets[] = {
+	[RESET_MPMU_WDT]	= RESET_DATA(MPMU_WDTPCR,	BIT(2), 0),
+	[RESET_MPMU_RIPC]	= RESET_DATA(MPMU_RIPCCR,	BIT(2), 0),
+};
+
+static const struct spacemit_reset_data k3_apbc_resets[] = {
+	[RESET_APBC_UART0]	= RESET_DATA(APBC_UART0_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART2]	= RESET_DATA(APBC_UART2_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART3]	= RESET_DATA(APBC_UART3_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART4]	= RESET_DATA(APBC_UART4_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART5]	= RESET_DATA(APBC_UART5_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART6]	= RESET_DATA(APBC_UART6_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART7]	= RESET_DATA(APBC_UART7_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART8]	= RESET_DATA(APBC_UART8_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART9]	= RESET_DATA(APBC_UART9_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_UART10]	= RESET_DATA(APBC_UART10_CLK_RST,	BIT(2),	0),
+	[RESET_APBC_GPIO]	= RESET_DATA(APBC_GPIO_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM0]	= RESET_DATA(APBC_PWM0_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM1]	= RESET_DATA(APBC_PWM1_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM2]	= RESET_DATA(APBC_PWM2_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM3]	= RESET_DATA(APBC_PWM3_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM4]	= RESET_DATA(APBC_PWM4_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM5]	= RESET_DATA(APBC_PWM5_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM6]	= RESET_DATA(APBC_PWM6_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM7]	= RESET_DATA(APBC_PWM7_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM8]	= RESET_DATA(APBC_PWM8_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM9]	= RESET_DATA(APBC_PWM9_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_PWM10]	= RESET_DATA(APBC_PWM10_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM11]	= RESET_DATA(APBC_PWM11_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM12]	= RESET_DATA(APBC_PWM12_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM13]	= RESET_DATA(APBC_PWM13_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM14]	= RESET_DATA(APBC_PWM14_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM15]	= RESET_DATA(APBC_PWM15_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM16]	= RESET_DATA(APBC_PWM16_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM17]	= RESET_DATA(APBC_PWM17_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM18]	= RESET_DATA(APBC_PWM18_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_PWM19]	= RESET_DATA(APBC_PWM19_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_SPI0]	= RESET_DATA(APBC_SSP0_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_SPI1]	= RESET_DATA(APBC_SSP1_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_SPI3]	= RESET_DATA(APBC_SSP3_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_RTC]	= RESET_DATA(APBC_RTC_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_TWSI0]	= RESET_DATA(APBC_TWSI0_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TWSI1]	= RESET_DATA(APBC_TWSI1_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TWSI2]	= RESET_DATA(APBC_TWSI2_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TWSI4]	= RESET_DATA(APBC_TWSI4_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TWSI5]	= RESET_DATA(APBC_TWSI5_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TWSI6]	= RESET_DATA(APBC_TWSI6_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TWSI8]	= RESET_DATA(APBC_TWSI8_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS0]	= RESET_DATA(APBC_TIMERS0_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS1]	= RESET_DATA(APBC_TIMERS1_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS2]	= RESET_DATA(APBC_TIMERS2_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS3]	= RESET_DATA(APBC_TIMERS3_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS4]	= RESET_DATA(APBC_TIMERS4_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS5]	= RESET_DATA(APBC_TIMERS5_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS6]	= RESET_DATA(APBC_TIMERS6_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_TIMERS7]	= RESET_DATA(APBC_TIMERS7_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_AIB]	= RESET_DATA(APBC_AIB_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_ONEWIRE]	= RESET_DATA(APBC_ONEWIRE_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_I2S0]	= RESET_DATA(APBC_SSPA0_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_I2S1]	= RESET_DATA(APBC_SSPA1_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_I2S2]	= RESET_DATA(APBC_SSPA2_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_I2S3]	= RESET_DATA(APBC_SSPA3_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_I2S4]	= RESET_DATA(APBC_SSPA4_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_I2S5]	= RESET_DATA(APBC_SSPA5_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_DRO]	= RESET_DATA(APBC_DRO_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_IR0]	= RESET_DATA(APBC_IR0_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_IR1]	= RESET_DATA(APBC_IR1_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_TSEN]	= RESET_DATA(APBC_TSEN_CLK_RST,		BIT(2), 0),
+	[RESET_IPC_AP2AUD]	= RESET_DATA(APBC_IPC_AP2AUD_CLK_RST,	BIT(2), 0),
+	[RESET_APBC_CAN0]	= RESET_DATA(APBC_CAN0_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_CAN1]	= RESET_DATA(APBC_CAN1_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_CAN2]	= RESET_DATA(APBC_CAN2_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_CAN3]	= RESET_DATA(APBC_CAN3_CLK_RST,		BIT(2), 0),
+	[RESET_APBC_CAN4]	= RESET_DATA(APBC_CAN4_CLK_RST,		BIT(2), 0),
+};
+
+static const struct spacemit_reset_data k3_apmu_resets[] = {
+	[RESET_APMU_CSI]                = RESET_DATA(APMU_CSI_CCIC2_CLK_RES_CTRL, 0,       BIT(1)),
+	[RESET_APMU_CCIC2PHY]           = RESET_DATA(APMU_CSI_CCIC2_CLK_RES_CTRL, 0,       BIT(2)),
+	[RESET_APMU_CCIC3PHY]           = RESET_DATA(APMU_CSI_CCIC2_CLK_RES_CTRL, 0,       BIT(29)),
+	[RESET_APMU_ISP_CIBUS]          = RESET_DATA(APMU_ISP_CLK_RES_CTRL,       0,       BIT(16)),
+	[RESET_APMU_DSI_ESC]            = RESET_DATA(APMU_LCD_CLK_RES_CTRL1,      0,       BIT(3)),
+	[RESET_APMU_LCD]                = RESET_DATA(APMU_LCD_CLK_RES_CTRL1,      0,       BIT(4)),
+	[RESET_APMU_V2D]                = RESET_DATA(APMU_LCD_CLK_RES_CTRL1,      0,       BIT(27)),
+	[RESET_APMU_LCD_MCLK]           = RESET_DATA(APMU_LCD_CLK_RES_CTRL2,      0,       BIT(9)),
+	[RESET_APMU_LCD_DSCCLK]         = RESET_DATA(APMU_LCD_CLK_RES_CTRL2,      0,       BIT(15)),
+	[RESET_APMU_SC2_HCLK]           = RESET_DATA(APMU_CCIC_CLK_RES_CTRL,      0,       BIT(0)),
+	[RESET_APMU_CCIC_4X]            = RESET_DATA(APMU_CCIC_CLK_RES_CTRL,      0,       BIT(1)),
+	[RESET_APMU_CCIC1_PHY]          = RESET_DATA(APMU_CCIC_CLK_RES_CTRL,      0,       BIT(2)),
+	[RESET_APMU_SDH_AXI]            = RESET_DATA(APMU_SDH0_CLK_RES_CTRL,      0,       BIT(0)),
+	[RESET_APMU_SDH0]               = RESET_DATA(APMU_SDH0_CLK_RES_CTRL,      0,       BIT(1)),
+	[RESET_APMU_SDH1]               = RESET_DATA(APMU_SDH1_CLK_RES_CTRL,      0,       BIT(1)),
+	[RESET_APMU_SDH2]               = RESET_DATA(APMU_SDH2_CLK_RES_CTRL,      0,       BIT(1)),
+	[RESET_APMU_USB2_AHB]           = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(0)),
+	[RESET_APMU_USB2_VCC]           = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(2)),
+	[RESET_APMU_USB2_PHY]           = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(3)),
+	[RESET_APMU_USB3_A_AHB]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(5)),
+	[RESET_APMU_USB3_A_VCC]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(6)),
+	[RESET_APMU_USB3_A_PHY]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(7)),
+	[RESET_APMU_USB3_B_AHB]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(9)),
+	[RESET_APMU_USB3_B_VCC]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(10)),
+	[RESET_APMU_USB3_B_PHY]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(11)),
+	[RESET_APMU_USB3_C_AHB]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(13)),
+	[RESET_APMU_USB3_C_VCC]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(14)),
+	[RESET_APMU_USB3_C_PHY]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(15)),
+	[RESET_APMU_USB3_D_AHB]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(17)),
+	[RESET_APMU_USB3_D_VCC]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(18)),
+	[RESET_APMU_USB3_D_PHY]         = RESET_DATA(APMU_USB_CLK_RES_CTRL,       0,       BIT(19)),
+	[RESET_APMU_QSPI]               = RESET_DATA(APMU_QSPI_CLK_RES_CTRL,      0,       BIT(1)),
+	[RESET_APMU_QSPI_BUS]           = RESET_DATA(APMU_QSPI_CLK_RES_CTRL,      0,       BIT(0)),
+	[RESET_APMU_DMA]                = RESET_DATA(APMU_DMA_CLK_RES_CTRL,       0,       BIT(0)),
+	[RESET_APMU_AES_WTM]            = RESET_DATA(APMU_AES_CLK_RES_CTRL,       0,       BIT(4)),
+	[RESET_APMU_MCB_DCLK]           = RESET_DATA(APMU_MCB_CLK_RES_CTRL,       0,       BIT(0)),
+	[RESET_APMU_MCB_ACLK]           = RESET_DATA(APMU_MCB_CLK_RES_CTRL,       0,       BIT(1)),
+	[RESET_APMU_VPU]                = RESET_DATA(APMU_VPU_CLK_RES_CTRL,       0,       BIT(0)),
+	[RESET_APMU_DTC]                = RESET_DATA(APMU_DTC_CLK_RES_CTRL,       0,       BIT(0)),
+	[RESET_APMU_GPU]                = RESET_DATA(APMU_GPU_CLK_RES_CTRL,       0,       BIT(1)),
+	[RESET_APMU_MC]                 = RESET_DATA(APMU_PMUA_MC_CTRL,           0,       BIT(0)),
+	[RESET_APMU_CPU0_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(0),  0),
+	[RESET_APMU_CPU0_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(1),  0),
+	[RESET_APMU_CPU1_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(3),  0),
+	[RESET_APMU_CPU1_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(4),  0),
+	[RESET_APMU_CPU2_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(6),  0),
+	[RESET_APMU_CPU2_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(7),  0),
+	[RESET_APMU_CPU3_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(9),  0),
+	[RESET_APMU_CPU3_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(10), 0),
+	[RESET_APMU_C0_MPSUB_SW]        = RESET_DATA(APMU_PMU_CC2_AP,             BIT(12), 0),
+	[RESET_APMU_CPU4_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(16), 0),
+	[RESET_APMU_CPU4_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(17), 0),
+	[RESET_APMU_CPU5_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(19), 0),
+	[RESET_APMU_CPU5_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(20), 0),
+	[RESET_APMU_CPU6_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(22), 0),
+	[RESET_APMU_CPU6_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(23), 0),
+	[RESET_APMU_CPU7_POP]           = RESET_DATA(APMU_PMU_CC2_AP,             BIT(25), 0),
+	[RESET_APMU_CPU7_SW]            = RESET_DATA(APMU_PMU_CC2_AP,             BIT(26), 0),
+	[RESET_APMU_C1_MPSUB_SW]        = RESET_DATA(APMU_PMU_CC2_AP,             BIT(28), 0),
+	[RESET_APMU_MPSUB_DBG]          = RESET_DATA(APMU_PMU_CC2_AP,             BIT(29), 0),
+	[RESET_APMU_UCIE_IP]            = RESET_DATA(APMU_UCIE_CTRL,              BIT(1),  0),
+	[RESET_APMU_UCIE_HOT]           = RESET_DATA(APMU_UCIE_CTRL,              BIT(2),  0),
+	[RESET_APMU_UCIE_MON]           = RESET_DATA(APMU_UCIE_CTRL,              BIT(3),  0),
+	[RESET_APMU_RCPU_AUDIO_SYS]     = RESET_DATA(APMU_RCPU_CLK_RES_CTRL,      0,       BIT(0)),
+	[RESET_APMU_RCPU_MCU_CORE]      = RESET_DATA(APMU_RCPU_CLK_RES_CTRL,      0,       BIT(2)),
+	[RESET_APMU_RCPU_AUDIO_APMU]    = RESET_DATA(APMU_RCPU_CLK_RES_CTRL,      0,       BIT(3)),
+	[RESET_APMU_DSI4LN2_ESCCLK]     = RESET_DATA(APMU_LCD_CLK_RES_CTRL3,      0,       BIT(3)),
+	[RESET_APMU_DSI4LN2_LCD_SW]     = RESET_DATA(APMU_LCD_CLK_RES_CTRL3,      0,       BIT(4)),
+	[RESET_APMU_DSI4LN2_LCD_MCLK]   = RESET_DATA(APMU_LCD_CLK_RES_CTRL4,      0,       BIT(9)),
+	[RESET_APMU_DSI4LN2_LCD_DSCCLK] = RESET_DATA(APMU_LCD_CLK_RES_CTRL4,      0,       BIT(15)),
+	[RESET_APMU_DSI4LN2_DPU_ACLK]   = RESET_DATA(APMU_LCD_CLK_RES_CTRL5,      0,       BIT(0)),
+	[RESET_APMU_DPU_ACLK]           = RESET_DATA(APMU_LCD_CLK_RES_CTRL5,      0,       BIT(15)),
+	[RESET_APMU_UFS_ACLK]           = RESET_DATA(APMU_UFS_CLK_RES_CTRL,       0,       BIT(0)),
+	[RESET_APMU_EDP0]               = RESET_DATA(APMU_LCD_EDP_CTRL,           0,       BIT(0)),
+	[RESET_APMU_EDP1]               = RESET_DATA(APMU_LCD_EDP_CTRL,           0,       BIT(16)),
+	[RESET_APMU_PCIE_A_DBI]         = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_A,    0,       BIT(3)),
+	[RESET_APMU_PCIE_A_SLAVE]       = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_A,    0,       BIT(4)),
+	[RESET_APMU_PCIE_A_MASTER]      = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_A,    0,       BIT(5)),
+	[RESET_APMU_PCIE_B_DBI]         = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_B,    0,       BIT(3)),
+	[RESET_APMU_PCIE_B_SLAVE]       = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_B,    0,       BIT(4)),
+	[RESET_APMU_PCIE_B_MASTER]      = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_B,    0,       BIT(5)),
+	[RESET_APMU_PCIE_C_DBI]         = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_C,    0,       BIT(3)),
+	[RESET_APMU_PCIE_C_SLAVE]       = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_C,    0,       BIT(4)),
+	[RESET_APMU_PCIE_C_MASTER]      = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_C,    0,       BIT(5)),
+	[RESET_APMU_PCIE_D_DBI]         = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_D,    0,       BIT(3)),
+	[RESET_APMU_PCIE_D_SLAVE]       = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_D,    0,       BIT(4)),
+	[RESET_APMU_PCIE_D_MASTER]      = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_D,    0,       BIT(5)),
+	[RESET_APMU_PCIE_E_DBI]         = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_E,    0,       BIT(3)),
+	[RESET_APMU_PCIE_E_SLAVE]       = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_E,    0,       BIT(4)),
+	[RESET_APMU_PCIE_E_MASTER]      = RESET_DATA(APMU_PCIE_CLK_RES_CTRL_E,    0,       BIT(5)),
+	[RESET_APMU_EMAC0]              = RESET_DATA(APMU_EMAC0_CLK_RES_CTRL,     0,       BIT(1)),
+	[RESET_APMU_EMAC1]              = RESET_DATA(APMU_EMAC1_CLK_RES_CTRL,     0,       BIT(1)),
+	[RESET_APMU_EMAC2]              = RESET_DATA(APMU_EMAC2_CLK_RES_CTRL,     0,       BIT(1)),
+	[RESET_APMU_ESPI_MCLK]          = RESET_DATA(APMU_ESPI_CLK_RES_CTRL,      0,       BIT(0)),
+	[RESET_APMU_ESPI_SCLK]          = RESET_DATA(APMU_ESPI_CLK_RES_CTRL,      0,       BIT(2)),
+};
+
+static const struct spacemit_reset_data k3_dciu_resets[] = {
+	[RESET_DCIU_HDMA]	= RESET_DATA(DCIU_DMASYS_RSTN,		0, BIT(0)),
+	[RESET_DCIU_DMA350]	= RESET_DATA(DCIU_DMASYS_SDMA_RSTN,	0, BIT(0)),
+	[RESET_DCIU_DMA350_0]	= RESET_DATA(DCIU_DMASYS_S0_RSTN,	0, BIT(0)),
+	[RESET_DCIU_DMA350_1]	= RESET_DATA(DCIU_DMASYS_S1_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA0]	= RESET_DATA(DCIU_DMASYS_A0_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA1]	= RESET_DATA(DCIU_DMASYS_A1_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA2]	= RESET_DATA(DCIU_DMASYS_A2_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA3]	= RESET_DATA(DCIU_DMASYS_A3_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA4]	= RESET_DATA(DCIU_DMASYS_A4_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA5]	= RESET_DATA(DCIU_DMASYS_A5_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA6]	= RESET_DATA(DCIU_DMASYS_A6_RSTN,	0, BIT(0)),
+	[RESET_DCIU_AXIDMA7]	= RESET_DATA(DCIU_DMASYS_A7_RSTN,	0, BIT(0)),
+};
+
+U_BOOT_DRIVER(spacemit_k3_reset) = {
+	.name		= "spacemit_k3_reset",
+	.id		= UCLASS_RESET,
+	.ops		= &spacemit_reset_ops,
+	.probe		= spacemit_reset_probe,
+	.priv_auto	= sizeof(struct spacemit_reset_priv),
+	.flags		= DM_FLAG_PRE_RELOC,
+};
+
+int spacemit_k3_reset_bind(struct udevice *parent,
+			   enum spacemit_k3_reset_syscon syscon)
+{
+	const struct spacemit_reset_data *table;
+	size_t table_size;
+
+	switch (syscon) {
+	case SPACEMIT_K3_RESET_MPMU:
+		table = k3_mpmu_resets;
+		table_size = ARRAY_SIZE(k3_mpmu_resets);
+		break;
+	case SPACEMIT_K3_RESET_APBC:
+		table = k3_apbc_resets;
+		table_size = ARRAY_SIZE(k3_apbc_resets);
+		break;
+	case SPACEMIT_K3_RESET_APMU:
+		table = k3_apmu_resets;
+		table_size = ARRAY_SIZE(k3_apmu_resets);
+		break;
+	case SPACEMIT_K3_RESET_DCIU:
+		table = k3_dciu_resets;
+		table_size = ARRAY_SIZE(k3_dciu_resets);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return spacemit_reset_bind(parent, "spacemit_k3_reset", table, table_size);
+}
diff --git a/include/soc/spacemit/k3-reset.h b/include/soc/spacemit/k3-reset.h
new file mode 100644
index 00000000000..e2ae12e2edc
--- /dev/null
+++ b/include/soc/spacemit/k3-reset.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SpacemiT K3 reset driver — header interface.
+ */
+
+#ifndef _SOC_SPACEMIT_K3_RESET_H
+#define _SOC_SPACEMIT_K3_RESET_H
+
+struct udevice;
+
+enum spacemit_k3_reset_syscon {
+	SPACEMIT_K3_RESET_MPMU,
+	SPACEMIT_K3_RESET_APBC,
+	SPACEMIT_K3_RESET_APMU,
+	SPACEMIT_K3_RESET_DCIU,
+};
+
+int spacemit_k3_reset_bind(struct udevice *parent,
+			   enum spacemit_k3_reset_syscon syscon);
+
+#endif /* _SOC_SPACEMIT_K3_RESET_H */

-- 
2.55.0

