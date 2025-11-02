Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE88CCF9E3
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 17:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A29838A5;
	Sun,  2 Nov 2025 18:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MrKB2OVh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CeikX+Nb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FE1B838A5; Sun,  2 Nov 2025 18:35:09 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F746830A0
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 18:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d020p3MWKz9tJ6;
 Sun,  2 Nov 2025 18:35:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762104906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rvUsQzUrCgUNApm0xmpWXKFvXzfYTDiUw+5c/UzzAUU=;
 b=MrKB2OVhbfDL6OEVpzpahHwC5LHZY48nPdHDCUZQ8cecKRfb+r4b5ms2Jz4IjQwjaWfv7D
 /l4tW8S2j+hHdwUz42Ldgj8ulrDNVfCBlHxgXZ1fA/T5dIHkK5YCRbTHl1cVkWI2zoQPwd
 57eeM7dzgcEEHQWmWsC1lqpCi3JAnJglMj/DWIooQWj5vbNNFo2XA9PZrkZNopDQOsXpj4
 Nw/KC0cVVsUxml8HQ2MpYRfhykV1BkGgU/mtbOGlGWVtAV49hAbj0W/kme9YyBKTE9hQhj
 /B/WCnVn1g8acEILqpxOEZu2eD0ie2R18nEwccnf5E/n30NiHRDOLhac+X+XrA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762104904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rvUsQzUrCgUNApm0xmpWXKFvXzfYTDiUw+5c/UzzAUU=;
 b=CeikX+Nb5y1oB/KEXiT1SUoEj275CY2XAYogc5VNxOnjUmUXl+BSvRD7dIphiDY+wE56HT
 dgcpycB5+9DD6K/yUPIgIyD9smTC6WyNGJES2owXtknQsDDaqbgErcDjQQ6ViyOZBdi7Rs
 v5UjkbC0bsncdr6K921Mi2CXUusqk6jwbAOd+JGKvjQZPbkoFo/LfupN285R0BPcqlTEar
 CmZk1yFbA+vYE/pmtZa1+fAriCGMkCBh0Ls29vZ0U7l3MLEUohPcGHLb3XHYilVuv3AxIM
 l2gXVVqWy9OmakLDF741sowq/nX/DkRNVKjQPcsYZ4C9vTK1kzhWNQeZsx4qdw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Jindong Yue <jindong.yue@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH] imx9: scmi: Drop parenthesis around enable
Date: Sun,  2 Nov 2025 18:34:37 +0100
Message-ID: <20251102173459.80904-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fcpqd6fsmmuum9ouownseronbti1pukd
X-MBO-RS-ID: a9cfed96bdc73fd02f9
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

The 'enable' is a single variable, there is no need to have
parenthesis around it, drop them and change the implementation
to simple !!enable.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jindong Yue <jindong.yue@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
index fc1d5d77799..9030dbf600d 100644
--- a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
+++ b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
@@ -12,7 +12,7 @@ int imx_clk_scmi_enable(u32 clock_id, bool enable)
 {
 	struct scmi_clk_state_in_v1 in = {
 		.clock_id = clock_id,
-		.attributes = (enable) ? 1 : 0,
+		.attributes = !!enable,
 	};
 	struct scmi_clk_state_out out;
 	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
-- 
2.51.0

