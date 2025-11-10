Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20515CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 12:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B1983A1A;
	Mon, 10 Nov 2025 13:34:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AybPI2+s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77E3283A1A; Mon, 10 Nov 2025 13:33:59 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D5B88391B
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 13:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtfUVoAP2VjEiXTVTm9ST70HbJThNJofzCEkIg/PVF4+4U0ZQzTnOIiWBcs+62BA8LYgs/THd5mJtrrgouBlfIaYornYVyMMAObD0F54BqyLfSlomAdxdSn/8Z7xignrCITr5DUKS2/vjIGb+6w6ikujxb3rjPRGGpUkVdLe25mw8bumOeeSfeWhv1MT4FhHNkqtt7cPv37uQXAz31dNMtqRTuOqcMRNDbvIyzmCkz3IqRZ5RZ1Lp3BzEW5cM7kNA12hr3Lgcb3w4aWGoHlsn89SB5TD31FoA8sgjeaB9r5zyRqKN1UbwUuyXi4/592Y7BahW68dyJgMXn/cRVJjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXBPpi3h9c8+kPa0kSSymoXvtrN5AHMVFq4GpkqX60U=;
 b=T0Cm/gD9+nizQ22QPYVNcb36A3clAl4fp9CjCCLsE530t58bi9BiHy8EXLt2hvKACAsPBINQR8czck04f3sGzFH6gNOAbFomU8XI6TUhJlps4Quzny/mXo9S1VCcut2X+j+WhLoqqGktxYh3DXDAyTEtxuzleEYVOY3aWd3eFzFeu6E9cEIghMa2l8yAmPDnDIOxqkst8mOKYABok0unTQwKEBZQG89cAGjiO7kT3UjvWNSdNQtjBVQju8S5jpiv0O95eWx1me8kfsS+n//C0VViVmtb+631IKsHniK5w5aGkGVZjqbe0bQavJoiqocKojIeXlCyoo3cQCn+WPlDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXBPpi3h9c8+kPa0kSSymoXvtrN5AHMVFq4GpkqX60U=;
 b=AybPI2+sZdxKXX4lrfR6qXwL4/+rs+BcukqZTUWiRBUhRZsxFJZzcZjzKQA5Xvy/byQ+HzS4awI9JpaO0c0TrS5M0HoSDyA82EG/C+n9rn28psazPs7lYdzfW2Aqowr99dWJEEnGh9Uq2d1i9kvr/cnBO53VztZiDyrVOLiSYbc=
Received: from BL1PR13CA0081.namprd13.prod.outlook.com (2603:10b6:208:2b8::26)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 12:33:51 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::60) by BL1PR13CA0081.outlook.office365.com
 (2603:10b6:208:2b8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.14 via Frontend Transport; Mon,
 10 Nov 2025 12:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 12:33:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 04:33:50 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 06:33:49 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 10 Nov 2025 04:33:49 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Lukasz Majewski <lukma@denx.de>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 2/2] clk: versal: Cleanup driver
Date: Mon, 10 Nov 2025 13:33:33 +0100
Message-ID: <5b6fbcff1025415adc97e3e17eeb18863df4383e.1762778011.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <647f1d2c7d274c1106558a655386ef92e0baf2c8.1762778011.git.michal.simek@amd.com>
References: <647f1d2c7d274c1106558a655386ef92e0baf2c8.1762778011.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=oEa9WiQRbHVWy+XrTSXXOdwkEQBMccSDGmW7gHujhaM=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQK3l7E13rsUPOz7qUfpfSaK03mt33Yf2rb1IfGuz8Jr
 34la6ai3VHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATOaLH8D/J1bawi/3BOU3B
 98/PGlRvP7Cw/MaPu7fDz7NOOmqTx/iFkWHJj4PNT+S9WcM19nA0p72YwfMjf+fOX9v7bwTtCy0
 LTWYEAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|DM3PR12MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c4ab3b-5d70-4582-90f8-08de20556774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?euy1QoAHkGNeydFCMhpuAaSTddzU04mXTKGuzX2Wk1o7VftZ6QVmcxH3RSvw?=
 =?us-ascii?Q?wEgu2Fszp1EVZpmcAb28PGP8i8CjOq65g8YszH7glGEdLRkijO6os7OWHXc7?=
 =?us-ascii?Q?Dk6giv6utdXu12MCR2eirWTo56MD1cJTy+8Rv/jOcg6C2560j758mTLCsGCo?=
 =?us-ascii?Q?eMItcWJafgbOBhzGYLovayK4jjkP+suvDi0PYAJm/wBQv71qEashLZ/ePK8W?=
 =?us-ascii?Q?qCkbM/A6IIFzWDbbxQcyin31f75apDMHeY+yrZshrCXsOR2I9VaCgDBoUchJ?=
 =?us-ascii?Q?Y8UbJQ6EcMIS7buaVQ3oYiXElb5sAKwHKnZ9pjLAcA9qnT1CRLSQQyRthrmu?=
 =?us-ascii?Q?8gZHZrFzfHYXkCg4jcf/l2vhtAbXTQzbGiF5nG7tjbHrmx2pE3WG+b4a03HA?=
 =?us-ascii?Q?O6JDxq1pref6Co2FAiuCKOUIBVR8eyKLi6dqXeFkdgO0rv128olWt4VzbPdn?=
 =?us-ascii?Q?JWVmQAZLasxFUXVw5c+ymwDjM01j/OtiG/lfSQ5Xl+ZHZonATH4chA16UPsa?=
 =?us-ascii?Q?7RWhRj6k4YENFLm/IkQ/5LgwOOpmp26MIQKSzsfWP6+ixeTl7npznVsO72cv?=
 =?us-ascii?Q?y7TIlWjDWVb+cscpRPWlv9FjlvPcoTKWxQXQ1bCvR9iMIIplIditSjXZwEZq?=
 =?us-ascii?Q?fvVulFezSHX3+N5E0R7hexn1uwc+WFOGpYVNDcefdimLU5aBWacdAulY6ztV?=
 =?us-ascii?Q?cfsBXp0hcic3pZ23VdLRyBrMI6aPTvkBNnDP/D+v6LJfe/RQ2lwNkCs2j24Z?=
 =?us-ascii?Q?bakjvvSKw5MAshdGbIHZZgFnIHf78hcgzFgqiiKSrbmCrP73jf1rJgjlEGI0?=
 =?us-ascii?Q?C+nnjqC8u+QtlHQBxFCmJrD2xkYZLof7J3VbbfSJqRmeVfL9P3r1OMUScUPG?=
 =?us-ascii?Q?KnxhWPC16K7gvxECFDl5Oh10YyPjGbVlOEBPIUHl2D2TDJ+VaTWBkVlckq2C?=
 =?us-ascii?Q?Cq9gydpc00YZknY0X0EFT+BQ10aq0G0cV1j2oQiJuqri/o5U6CCbAxLRcW7f?=
 =?us-ascii?Q?lCEzuxRtrYxvGaRIN3p4SoYSU9Mdw9gb80i9B8LeIj97CBHoCJVjUcXCL22M?=
 =?us-ascii?Q?wKbp/dGWDZVxoyrTVNlX1Pap+iYWolwYHDKE7hS31uNkQm47AinBu4PL89I/?=
 =?us-ascii?Q?aJ4f08RWO7661LFBYSd66IvUUcnPQ7xH6+ks0ogQA2OXJrO37j14bVNf1q+/?=
 =?us-ascii?Q?WIxp1OtulfFi8zClj8TaScBp+W8Y2sNv9LosbW/8OEXpog68KKu24ePLQXJI?=
 =?us-ascii?Q?r1vtW94XmDnBc7hb4bvQQ+F/BP9ePyBC9zo2flFgucprPMxpMoywWLmqwYBd?=
 =?us-ascii?Q?Edj4SYbhGSoLDTfgqMHJIw+Hi7mjrAr7zXVPLGKTMYT+zMh+hN7zKVCFGeja?=
 =?us-ascii?Q?NoOCd4kVZQa6z00ILjLUUUm7C4CZsfPIo+McgnuaYuDrUoCRAMmGfkwhUutg?=
 =?us-ascii?Q?w4MHUL+rKs/xgr12laSoZmQq2+r4FmXZLGezkNrkysITlROa5qxrAzrZCYMu?=
 =?us-ascii?Q?Fv/9J41k2+ZdKvKw3jHKu7JM8j5dEr+Yn1OnTilowC/mb9ekRZzeYODNL9zc?=
 =?us-ascii?Q?PXjXRV/g9tubDf/lfXM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 12:33:51.2752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c4ab3b-5d70-4582-90f8-08de20556774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390
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

Remove unneeded debug messages, parenthesis and fix error message.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/clk/clk_versal.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index 139f429d609b..78a2410ca21c 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -738,8 +738,6 @@ static ulong versal_clk_get_rate(struct clk *clk)
 	if (id >= clock_max_idx)
 		return -ENODEV;
 
-	debug("%s\n", __func__);
-
 	clk_id = priv->clk[id].clk_id;
 
 	versal_clock_get_rate(clk_id, &clk_rate);
@@ -756,8 +754,6 @@ static ulong versal_clk_set_rate(struct clk *clk, ulong rate)
 	u32 div;
 	int ret;
 
-	debug("%s\n", __func__);
-
 	if (id >= clock_max_idx)
 		return -ENODEV;
 
@@ -783,7 +779,7 @@ static ulong versal_clk_set_rate(struct clk *clk, ulong rate)
 	} while (((clk_id >> NODE_SUBCLASS_SHIFT) &
 		 NODE_CLASS_MASK) != NODE_SUBCLASS_CLOCK_REF);
 
-	printf("Clock didn't has Divisors:0x%x\n", priv->clk[id].clk_id);
+	printf("Clock has no divider: 0x%x\n", clk_id);
 
 	return clk_rate;
 }
@@ -799,10 +795,9 @@ static int versal_clk_enable(struct clk *clk)
 
 	clk_id = priv->clk[id].clk_id;
 
-	if (versal_clock_gate(clk_id)) {
+	if (versal_clock_gate(clk_id))
 		return xilinx_pm_request(PM_CLOCK_ENABLE, clk_id, 0, 0, 0,
 					 0, 0, NULL);
-	}
 
 	return 0;
 }
-- 
2.43.0

base-commit: 04d178e16e6cf0209efa1b424a86c72067dea255
