Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD1BCD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 15:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA668464D;
	Mon,  4 May 2026 17:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="AWMQ3W5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C12708394E; Mon,  4 May 2026 11:37:12 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A61E80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 11:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=juuso.rinta@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZLSajNkZI2bUv5W1wY9w8KhqB0ZbFIpOtrfs5obIaS5+6383rKvHpQFhRtKOw0c8Sua0vinkroXc/0mdLl6LaO1CO65wRaeAiyqLPYAfxTzcqHmbNr9BI4Oaxtti7eDj2UCZo13tFrxKfAs1igL7Gkh9lCZ450ke5H5hCCIP2im+c/WmUORA49qTAOwwqkYnzug/5e8FC2NkWYisTbEdW5t33EdKlLnK+YB1DSBX2XXxA2EbKZD4iumwFYM7/MGLFYp3dTeTWW11XLSBuK+HUwPHn6Oei78n3jK9859TBKaISiGz7kkxVhmBuqQwzPKt1KQJ/PE+hj0ZMihsVbO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7MAYgB+HLBOecQOqUZHr43y3DEOn7301CQ7RoQN/JI=;
 b=XdMAh/gO1SlINhXYCh15qCDda4S4fYsp0CLurehCN+Dx4Juyd83gXaI8ECelByzrYHN+GaXtvv3zvhWCRLMmIIbSSLkAm39obzGyicKh9ptoQTXCQcM8zfwCh3T1eu/phHG0FmAzHRkicHu+CPFy6I1BoUtRgdKw9431/Is4WqZBbrB8Tlb/8iiDXq/0925LPPmGZgK28j69dMNDBKMnrgadlY70wSBrcodGj4hgGARAzpULbxm5UFB6MOfXN9cmMquxFMseBJkmBX/bvBPdjqKiQSHV1EYiG3fUqHbWpULITPWOTJpTkBmBGGiFLWMnJXjSCrr4ljaymfEF5G+bHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=konsulko.com smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7MAYgB+HLBOecQOqUZHr43y3DEOn7301CQ7RoQN/JI=;
 b=AWMQ3W5ynlWBT4ft0FJN+hIqF4Hsy3k/JQCijNHjW3+N1+NG4su3Jk/TniPquOIeUj1WUa5EKfzbHMbNJHVxByTneHhVTT3LryJ52TThAy3rCUKanX/D1Tao/f+x309NRSvSTbLSDu1GF1bpA1mLqgtQFN+fzL8HEFbw1UXo38tO15SS0Pzteq9sd4kaCv/Z/poqTTsDPOYxdASISR25HEqNHtyQUOMTFzSkG40c3RHg10wHRb2E4tm9RaNcee6lpKOg665td7GFG26B0SwhuhE22zF0RzRub9ZqJgvLdp3WQ0j6trSqNeFq0Hb9LEZJ1AStHCVpklRMA+1nBEA3YA==
Received: from AS4P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::11)
 by AM7PR07MB6373.eurprd07.prod.outlook.com (2603:10a6:20b:13c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 09:37:07 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:20b:5db:cafe::34) by AS4P189CA0023.outlook.office365.com
 (2603:10a6:20b:5db::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 09:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.100; helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Mon, 4 May 2026 09:37:07 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 5D6A0680034;
 Mon,  4 May 2026 12:37:07 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Mon, 04 May 2026 12:36:58 +0300
Subject: [PATCH RESEND] watchdog: octeontx_wdt: fix DT matches to Marvell
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-rinta-octeontx-wdt-compatible-v1-1-660f3800d33a@nokia.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Juuso Rinta <juuso.rinta@nokia.com>, 
 Aaro Koskinen <aaro.koskinen@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777887427; l=1572;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=UtMY16NX1UY7vcnmYfyQ5lkDwiO88KqpnnormKBAXWw=;
 b=+B33htj6O5gygZGMmYbav7RDKaaq9gmMqicSM5PcWy2sJabm5IM75PL52xDLQIfUjML3yYYPU
 zD5HuB7+7XnBmdHftrwx67hXQ7K/QRJGAwWUOdlJk4prNak4YhSA6Em
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|AM7PR07MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 711a2f2b-298f-471c-a77f-08dea9c0b594
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: sKec7lcA3nxd6XLtPKiyeIVk4xKGqUMZKYbRTCmt1MdFXRBMv52oaOoIF6GQEowZRDEzCJIKBWbRzV8FRB8nGD3cWPozTCeUBvvXEPpkMb1c0Hfizc2qBmUZkKoLduV/B4v5FyOq1rRIktwpIcMzoP5NqVJYaOQlNpUIGjBSxOcuE5F8FRKF12CdL0CxURTLvaZVT+mcKaeFz6l2Bh3QeKAoApFtfbgcwJYntvcvAmoIYilNsnWezP1HWkq9cGNsOLFNujVEQLpunj00P0iUEWhq9t3+ZI/B4OHqhm50ddAIhGUj8JLwljq83j3WUhQuRhoXLoQFfc4EEwiM9bAfOlJmUw4E9u9M3s2wbxsyKOZyE+fCXWaZkAYh7coZxMYAQJ4VMC4StT5HxcDaA7BlKfTGITehXUO3KFhnxQa3FoG+12/RWQsKKZj4/JP70WJ4TILkWF9QRtOP3ijrqwOeuwL935GgxdFwlhiKM3WgQoFpZJrEIImGKFdOBQdFPB5LVwKc/43VlI0Tu6WJG/Hw1YZALzzi2JZG7wBgUIaYnozekUDU28fT1I5SGGy2Gmp+lvtWmMKobrgQwmOaNmcu/QIKyQPXLZy18CzLO55ByZB2YLyy1knhIDeINIyGfGNWICgaXomlneHMXDRHWJyJEBaUAZ4V3HO1+R1WZmys1QLAMrVYQY7sH3mvyFpGzxT+h4LI5sn7NFICWcKtfswBJFZHG+ugXydoyTlGwXgx8Fs=
X-Forefront-Antispam-Report: CIP:131.228.6.100; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fr711usmtp2.zeu.alcatel-lucent.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u1A4Pq4DUmk10dm5esHfWXWTuP69xY4RICXT7RiHJo2TShETznkGvrZdUNf7YOluwpdnqhcZqC+3OkOKzVRrwixGrOUwewYQzyWzhpG8IAZX4HdQ743jMtRMTozYfQHabRy5Q2jH2EhT9OSEm1LheBBjBGwtNvm7gzlBMhYevQFYwncwaUsGkukyJ1zX0p0xpgLiZoiz25DR/L7EvFZxhZiNUXeKIUcIIroB7Dcg82Uz2RaPb+ZkGYtL1ioLzHAPxLObzB3EXKA3d45LPpJoCf3mzCklDy4W5M1/H1dVAbFkM14KiC8O7OY0nisGcejHtOd3mtjubbxmR3V4WVZxNQW3MVU6dPP4Ktq0N8PHvuwA+GIbPQvw3HLqV4pBrxcrCkPJW+H4VPa8MQ0rr3b2TxF29Y29S6LuB6zzfkj7wpnrWoqvvgEdHd83pLVZsfVO
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 09:37:07.7540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 711a2f2b-298f-471c-a77f-08dea9c0b594
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.6.100];
 Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6373
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

The OcteonTX watchdog driver currently matches arm,sbsa-gwdt.
On systems with multiple watchdog devices this can be ambiguous since
arm,sbsa-gwdt is a generic SBSA binding.

Replace the SBSA match with SoC-specific Marvell compatibles
marvell,cn10624-wdt and marvell,cn9670-wdt.

These compatibles align with the upstream Linux device tree binding:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml

Reviewed-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/octeontx_wdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/octeontx_wdt.c b/drivers/watchdog/octeontx_wdt.c
index c79d9539c13..7299a9f9739 100644
--- a/drivers/watchdog/octeontx_wdt.c
+++ b/drivers/watchdog/octeontx_wdt.c
@@ -159,7 +159,8 @@ static const struct octeontx_wdt_data octeon_data = {
 };
 
 static const struct udevice_id octeontx_wdt_ids[] = {
-	{ .compatible = "arm,sbsa-gwdt", .data = (ulong)&octeontx_data },
+	{ .compatible = "marvell,cn10624-wdt", .data = (ulong)&octeontx_data },
+	{ .compatible = "marvell,cn9670-wdt", .data = (ulong)&octeontx_data },
 	{ .compatible = "cavium,octeon-7890-ciu3", .data = (ulong)&octeon_data },
 	{}
 };

---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260428-rinta-octeontx-wdt-compatible-0ca7b83e634e

Best regards,
--
Juuso Rinta <juuso.rinta@nokia.com>
-- 
Juuso Rinta <juuso.rinta@nokia.com>

