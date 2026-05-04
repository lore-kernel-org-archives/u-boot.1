Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11617CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 15:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4EA845E3;
	Mon,  4 May 2026 17:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="shTFM8ZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B68983EF9; Mon,  4 May 2026 11:35:09 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6238E80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 11:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=juuso.rinta@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeK8Pdlc7mc5FOt359wTKBAVpIdobkbCYaH7xn6rXlFmJYT59oz5UgMic6kpaO0Ez1Piq3cjSg66k6zS6QoakDZQGxk3DMt4aQC3rDJKAufk/VbiBVXMRWSZzKmcskoVGKvdA/G10ta+A3r74iGcroA/LjRLSLiSVqDlpeVA4X73k+64RvxuNxL66IdDjvBHRa19pOW9R5Uj4ni79mHLwlrHAhTKq8X9BiFD6QnQbE2xBKqXCS6ILoegJtO0Kid9zcaDXzoGgc9do+JseH/8O6lVSMgoSHJ3QlZJxZgJqoF3COqqpg5zEmt5UGQzyaCmHfOLopTsVg1yIlQra+rETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBtIFgbf/m2ah1f5EFvkwf3CMtVp/sSaqpbqctyfpcE=;
 b=FxdN2LIZoQhtciNjOvhkOX47vezWvkEThdq2x1dImRA39N4HHxZgGs34itKsqbhFh7j5Cm1EF3ZJl5tISAudjZR35FvacW/cwLG8L/MnsJCC5ENe6eVLxUhk/xpD6wy/QFihWwviGgGwPHjups1+z23oTqy1sf1NzSIkWav/hl++0uE4tRLz1itlTG7vnkO3tfrWiy25SS3wPj5oFZj+bthkF9TyOqLNosUaoYYzVpJPn/3waUqdMn15cRFrN/XTXTLSBKZyk/v+3jO7dhxNu6XS4eHckQgl5Xoo6EupSfWrytYtFMi3y5u0fx3SfIKTDDtvRMewVxy2WXJop+omnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=foss.st.com smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBtIFgbf/m2ah1f5EFvkwf3CMtVp/sSaqpbqctyfpcE=;
 b=shTFM8ZCQaseFnwEtenr7tk6aglhCMtx0mSE64b9ikEszo9Vl9riqpJesuAoL4asogndUOSt/+zRlNY7l8PXFTSSIefZQCJzoocqAHt8+8g+JGkL80HiphtH2AZBQt7UNaMagQI4S3xRyRUQqdZzmqDCm75ESWYnA3sDAdVQz9BbLG8UhcQoSOuEt0vh85V9wLyaIS4yprslG+eQTeS3CT9hqQgJoFdIcqR71Eldg891L9OAJ/Kp5xR3vyQH2wnN89LFw9IqT4cq5WGxZluHlcjWKTuBrY0vatMR3mEMhQ4gCxgZnP3f79SHCOoxiV3gfGvoenKeIsKb0R+9Zp13Ew==
Received: from DUZPR01CA0254.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::26) by DB9PR07MB7132.eurprd07.prod.outlook.com
 (2603:10a6:10:1fb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 09:35:04 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::3) by DUZPR01CA0254.outlook.office365.com
 (2603:10a6:10:4b5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 09:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Mon, 4 May 2026 09:35:03 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 42BF8236AF;
 Mon,  4 May 2026 12:35:03 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Mon, 04 May 2026 12:34:34 +0300
Subject: [PATCH RESEND] watchdog: sbsa_gwdt: clamp WOR value to hw max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-fix-sbsa-timeout-overflow-v1-1-87de9b44112f@nokia.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777887303; l=1757;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=A7/gLgMnLyVuCKj0UGJ3KvvFP0xGj5k3qWSdWY4f1hs=;
 b=sYV/PrsBn6ie0dUKICqSxyb/mKFtAOXnzPsnKbWGyhw4q0wwuXEDskV1Z+Whq1gqkKlSXyRkQ
 hg1Ttkj454PCg0GEg3Uq/CI28tMSsUE1gx/6+db9tPBIoD5+xPukavg
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|DB9PR07MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: f3843cc2-f4c3-404b-fa6e-08dea9c06baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: tcIXVgUoOuV9w3hyxnDLmDg6H+05v86SfHxPTUKESbwXQ+YuhpcZsSKojkhv0coYQyEuMcoQlHF8LODMKNOtWYnptQH6HD0h1XodDAjWSCFtb8w4rtX9qUumik4UHyhL/b00jD/w9ZPvJkCCt9JLNmVTXffh3kqJfvk0FQq2TC4vWSQJe9Cf3Eg9K8Mgf/INRAI8kNsFS/DBTd/wByjrWGu1n6buLq3pKq4/+0QVg/N/O5XF05dHBK7mK07dALEzr1CDYsjrm/vomH5x4dJANRTwAlFrb0kmauStGeQCnIPnoR+NhF09vEJwVgYwLm95AZEOi0JafomD7EnHWi9DWxDj0fGPTczpdtgqTyNsiEE5x50314m/A9ATuc5agouprQvT6t7bKklP/lR/aEu52td2+AZuEHz7wbB0nioKo45zwiPpgc4fSzSswM7WBt9Ac5uoA16PhpLoVqz5IyavUwJHjEY1d3SfgCIogg6adiFflKvtWPkeC4oBegw72wPwsZ7fGTyQIMOrThO3do65SclbtsMA7GS2dKdhU9ypymcC5OgT83+OkaEdydgxlGWnSKIU3uZH4BWP2jB/aJ2TH2T+5epJE/dCwUMoWyaMST3P5FuftH46Q+BeiPqrp8stZQ32Id/ZifZ66x0+DkTomJguv/wiSk2l9he8bFs/nY92c4qPX3NEbSZBKeYB8XI6A8j/ysnMKg8f7dCrEuU78vpWJ1QHCSZpk/wOF6AV5Fg=
X-Forefront-Antispam-Report: CIP:131.228.2.240; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0735.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h8bc3r0O5dnLDQ4vGhWWJLA3V8HHzkF/oe4d1g9VNZ4tGTLjKzZdrJJ8CO8ZSW1Ru7UyX0rDxjgZgdYqMgxv5OaXEsoIRFD3MvEwQ+VX0Rv+X9h16Gnr3tnRMTqlB//GWNRz5xCPOaLmDKWKlgcbNiVaqwcMEaOJpw+Osd44nI6Ff8/M37OXc0Oj28VKHMEZI4zbPkPzNx+0UW4qnC4C+cnXCgKKox930F8+vKDaTPe5Ry8Zd7fgtrH6TsPuzHrm/fyzCxuVQkii4gVRL2SAAW1rld/9HBPKR/LD78DEuru10aWAYKk3YIQhlZjo38UTMbkpBMcj/frdqzv8yCt6qd4gNpTtY+K2aAmvDHcnRhs+sqlzvS9CYFzZjhALTH+dmqx4ACq4AoBX+9oAd8nPhYxwkr6al5qsvfE1RG3cAe7FcPwIys0PeOvPG9rmt33X
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 09:35:03.7293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3843cc2-f4c3-404b-fa6e-08dea9c06baa
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.240];
 Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7132
X-Mailman-Approved-At: Mon, 04 May 2026 17:52:48 +0200
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

The WOR register is 32 bits, so any tick count exceeding U32_MAX is
truncated by writel(). A large requested timeout can wrap to a small
value causing the watchdog to fire sooner than requested.

Clamp the calculated value to U32_MAX prior to writing the register so
over-large requests will be set to the maximum timeout value.

Found by code review.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/sbsa_gwdt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 807884c5bc7..3a924cb2b9a 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -50,6 +50,7 @@ static int sbsa_gwdt_start(struct udevice *dev, u64 timeout, ulong flags)
 {
 	struct sbsa_gwdt_priv *priv = dev_get_priv(dev);
 	u32 clk;
+	u64 tout_wdog;
 
 	/*
 	 * it work in the single stage mode in u-boot,
@@ -58,8 +59,13 @@ static int sbsa_gwdt_start(struct udevice *dev, u64 timeout, ulong flags)
 	 * to half value of timeout.
 	 */
 	clk = get_tbclk();
-	writel(clk / (2 * 1000) * timeout,
-	       priv->reg_control + SBSA_GWDT_WOR);
+
+	/* if requested timeout overflows, clamp it to u32_max */
+	tout_wdog = ((u64)clk * timeout) / (2 * 1000);
+	if (tout_wdog > U32_MAX)
+		tout_wdog = U32_MAX;
+
+	writel(tout_wdog, priv->reg_control + SBSA_GWDT_WOR);
 
 	/* writing WCS will cause an explicit watchdog refresh */
 	writel(SBSA_GWDT_WCS_EN, priv->reg_control + SBSA_GWDT_WCS);

---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260428-fix-sbsa-timeout-overflow-20cf84fa8a6b

Best regards,
--
Juuso Rinta <juuso.rinta@nokia.com>
-- 
Juuso Rinta <juuso.rinta@nokia.com>

