Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB2FCA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 11:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F33C383AAF;
	Fri, 15 Aug 2025 13:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="vCBkEV06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB7D283AAB; Fri, 15 Aug 2025 13:11:04 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFD8083AAB
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 13:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzL3HP3d8t+Vy8chIdfmb6y1i0s8wu9Vffb4QbEJzy2Hu9YQkJ3EBRR+Fyt7uID8cGhra1DACpodViNUl9leJGk+ioOvb1NF5WmmKe39JGlYEvegHchMz7mBDrZvVBW2mZlhxHNrXP270z1M+KRUPUc83Vnj9GtEYT60Qc1emrgyrpuIK2y0EwaqlC7SPMocZz/ME4ixot6yycCAfkaKytkqVF2hHjEOML0Bf6oIOYwrKDfFKc2S+7d7BQc5E1N+AZGEvTlhFrGSzdMNXkroO0OBFxZztRcd69D+WrNy3n6XzJLKdgqOALgn4+kcjW2dUS+nF29qt2JvLtJpga8NZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjkB7BNvqgJZo3yp7tR8fpw/U3mAbiBzI98oDBSTU5Y=;
 b=oh1NcdnhZ6zu6jYD5PTatYPcu2b0Wo0CJDGjt3Bax1fzimSp9RQJwb1nsTNP7P7dog6SfOQUqwpgXdKG8ia3q2Q37U7U/S4u559w0oBtOqw/X/Q/cYK4BPkezNZK7D+ngfv736GKbO697EuWjxJ6RLKRWo3Pi/f5L3lxMbCEiFtppaZBZVV/fDlCIdIIN3zIG9+m9T2jBEUjhcKtQBP+VGY3NwKCpArX5Z2/Eu9iKSSQehalzZZuMlM0QwTtEXF2T0oYaWy0c1ts512ANSs+fXLu90Hfk5ABH7+h+aGH28KGFJN3TqSWvQ1PZcg4fWAFZeTDRGG7HJ/DNmwTPeEvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjkB7BNvqgJZo3yp7tR8fpw/U3mAbiBzI98oDBSTU5Y=;
 b=vCBkEV06FU8eHWyFtkNDnxEvbimO2fB+XfheHBkIKsJ4rBdGM12ynRYja+09e91g6S7BPG+Asf6cpZbz4AOsj6NU7RdVtMmbAuHer97eSRd1GsSPKU8fVcKjD1qSinprFrFUmhWjw9RSFZHe+AOcAjfSyNx5+IUCA/Krgkn+lIETOVDoclzn8GYJeiQsZW6hUp7SjlCS3CZOLpjoLiWaIuuaItMR6qyJeUHFzEo1JMiHeNmIJfzguaIQSR3Tvu84ee2VZcUdw+8diJS/VJZLiIlBC2pwi82HLZs2X0j/OXSahNo+PJs4/Yr+purg3D20sYtxtyiTG/K8EdJ4FrgedA==
Received: from AM0PR02CA0188.eurprd02.prod.outlook.com (2603:10a6:20b:28e::25)
 by PAXP195MB1607.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:281::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 11:10:59 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::ad) by AM0PR02CA0188.outlook.office365.com
 (2603:10a6:20b:28e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 11:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 11:10:59 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 13:10:58 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 13:10:58 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <d.schultz@phytec.de>, <ggiordano@phytec.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 0/4] Update SoM detection related code and configs
Date: Fri, 15 Aug 2025 13:10:47 +0200
Message-ID: <20250815111051.2277173-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019A:EE_|PAXP195MB1607:EE_
X-MS-Office365-Filtering-Correlation-Id: 14953981-f699-476e-f595-08dddbec69f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Wd1zgfaEfGidtOXFwUV3jhCzVbpkogCGk2ZapRV62jspqYbaSFhl4di6spN?=
 =?us-ascii?Q?MHydjQMrnTlki9B48D4SCpQSueXxyZb3bjygI8286wo7sA/FN8yUk17OdA7V?=
 =?us-ascii?Q?DwipTfUMl2AGwHSspcKWWjMKa8gMzYFHHZWokk7mE5IpMpz7ppXMB+G0/1iC?=
 =?us-ascii?Q?qMQ3EWDXLb9oHR1gYIOCRiiEtj+/6SH96gemw1ePvpwSk0GyC30Go9f8Cgtf?=
 =?us-ascii?Q?GIQQX4lQs+UKJ6jqGbQOk9DgdjnEreDnqtAxdNy3mme+c2+p9QC96uqecZrK?=
 =?us-ascii?Q?l2YstyDit5YRpnr+oJI28dWzWC4HBY/qSZ9PKiuPVTMzsWy6Tw149sRe+pPB?=
 =?us-ascii?Q?IFMqSCIO8uT4mn5o58MALVIU+FqxSokA6jtDet3Va6ibsKI7WBTXX6S6HTip?=
 =?us-ascii?Q?A/ukAOxWx326KtiYaybICOv2UOhWL5VtGYf70Bb1QqLbLLXKcXMb44ELoJ8+?=
 =?us-ascii?Q?5O0SkEn/hER4b9q38a//yKyft0AQkddnY9UfUET6jkgwKUWcqEEc5e64rfUw?=
 =?us-ascii?Q?C4I7zEk/2v44QCUJEEucJcpfkm3SRixmPjhG5AK8EhdqBPXwDSH4L2HDiRpl?=
 =?us-ascii?Q?n48Zl/SJ8mTxkNniLbKV5Z15EEEO4DQ770DcE3Ig1Tx2VGhUpmEa8i9sU2Gl?=
 =?us-ascii?Q?HY+rIE1d1daD84W8oIE6vFGXFhcoj6j7aKTNFyb2jjggA52IFdyRcGkI7Wwd?=
 =?us-ascii?Q?tDSRGEsgSbOzKuyfCGtXiLpKZOEsls+IGCX9f3uJRhTGhj40ciIHlCS+HAfD?=
 =?us-ascii?Q?NWOt5HOmiB3WVorW6vNHcD6ni/Ywi7e126ZbEpnBPu/y4t2HAfjqnS75lNcL?=
 =?us-ascii?Q?TenxXUv/OJYnX9igtw2xJQOSexzkWj9y92TUOWUN3nW0GY7MAZsGmi87v0qB?=
 =?us-ascii?Q?sSN5O/F4PdWaaOZ1nVO0qT38o58WHCh+ynkKRpf7t9952UG/APlxsNolef9H?=
 =?us-ascii?Q?c3L3ULNk89dcaTqxr3yJGqkUWHV+NQrjf4ZPWXOxkT3zG6XwCzSI02gU700C?=
 =?us-ascii?Q?WnmCk9XL/PO29a10XBvF3rL8qZsiRQU78D3XB6Up1gPyhTemW3z9VcVsi8e5?=
 =?us-ascii?Q?1g7Rarp0V3PF4azu5gBLP+vVW5jcWBgLMyvYHeQyxTj77OtnX2emkSz4JOBj?=
 =?us-ascii?Q?bo5wMZXecAj4/TsDyKMsp2JWxjqx0Ue9GLk1X1YiEQGq2BglVyMCNGv8P1Fm?=
 =?us-ascii?Q?pM8XukiCJjSUMk0e27Ao07HtOJ6dqzRuXewdSln3AkGJK8B3jNf/LrKyzuQR?=
 =?us-ascii?Q?V825/+rG9+V1aphoLKKCRPWeaeArTRxyA9yDwkFG0uzcIR1zYMqYnuOw7/Qr?=
 =?us-ascii?Q?t6Eah7FxWZu4xYLklczMN0I6My8+/rIZvcR1zS0LLYvLT1zJwmqeIInojdJK?=
 =?us-ascii?Q?0tlBLZDgAEduXcnEDkmr1IxECwHTWIIkdjaGtPimfoQdonp/3kPPFKtQZPxw?=
 =?us-ascii?Q?qa8278yArLENFwJz3tiZ0Vk0fn5gNWbQIs4NfmTL6yDSr3MnZK5tL95KlKb4?=
 =?us-ascii?Q?bSoWdC9IiFSHUlHJrrinPUvMbxLaek8O/xSo?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:10:59.2708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14953981-f699-476e-f595-08dddbec69f9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1607
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

Update Kconfig options for phyCORE-AM62Ax to align with other boards and
prepare common board code for the upcoming phyCORE-AM62L which has the
SoM EEPROM connected on a different bus.

Dominik Haller (2):
  board: phytec: common: Add PHYTEC_EEPROM_BUS to Kconfig
  board: phytec: common: k3: Use CONFIG_PHYTEC_EEPROM_BUS

Wadim Egorov (2):
  board: phytec: phycore-am62a: Update SoM detection Kconfig options
  configs: phycore_am62ax_a53_defconfig: Resync after savedefconfig

 board/phytec/common/Kconfig          | 8 +++++++-
 board/phytec/common/k3/board.c       | 6 +++---
 configs/phycore_am62ax_a53_defconfig | 1 -
 3 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.48.1

