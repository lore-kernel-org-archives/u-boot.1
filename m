Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD4ED68BEF
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 08:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB0C83D13;
	Thu, 18 Dec 2025 09:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="fiyL/YaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EFF383CF3; Thu, 18 Dec 2025 09:26:12 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3937E83D07
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cd0m4srHc8snHH/ixcb9lnA4DqXWA1Dqkr5AQREVPRi8Uv4XlzWIAlmy3raPI454JhziTLh2tZ62uz5Bs8EU1WVuH5zJALx9laX2KfQvEnM4Z/cLmN0Hzrql9B327SA9K6Lm8hBzlBkfs4qGjTot4M9QI4jsT1iN2zlf1swnQuySCPSQmLp/OYZCUlXfGoyYbHFLb8+JMD36kgsTqIumZ9Zko1eOn/CU0TjSRBhutEFgooAOse56uV7K2EvwHcKvMkP7lS/PT4mtI+81bsS4EUzATmFGeLoxDrfP4YLDyfkzuIGVkZOUkwe5bIqmXLAw5xNNONjYQK+JmVVFu6o/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQwkQ5jgCuB+7dvmFu5Bv+IhT87P4gS2fOwZPBlrcZA=;
 b=Sp6sCyWq9Sugnx/xi9vQ3MO+iF+0pu7rWd2nqwCKiw5qwbDf7si0n1HXvYgcpcZ8zQ2n3aFZlZbI1K1HslowibrF4TWDJdGmuDkRsrGuQB1anaZE0+6A/yXP8wyjUW6YjjUF4/o0ypLpZBowk0UPjgkg16VAy8cEOTyLTBtemlwfCjlGJQXSCpSwHIsqEODVVOLb8CKKqT+V/sr7eSYcLtOMtdxAVdfybDfR/TOT+c9w2tjm+6fv53QZMOwKC0QUfG7a2LuMtHTtVJskD8NJk5E80PXcLiOBrMEuIWx0saiQrNBNSPfMjriTxk3JZP4nru/9Bd/exdYUhNnSiLyehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=denx.de smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQwkQ5jgCuB+7dvmFu5Bv+IhT87P4gS2fOwZPBlrcZA=;
 b=fiyL/YaTkFH0pxgoCJyJmO+HSilKaGiT12zxAqzSOn94skpNiieZkepnoJNgR+3BwU0+Rl2Wuk8IwreXFWpiUFT1pAWa4BPFQAJAGNV8p2EBhH4AMQ9PBxW18EPCknVOBeDnD+4x/ejcxjBTrVosM/ZgD6zkMVjdx9yRK4TxLYZmBECrMJlFq8BxJyGuLYXVeuF90P9l0DSYg8eMMA59g3+8leHfh295hILXOj/6G4Eniw9LAm4O87uPpWC3wRv0Xxy3GCoc3SD1eVVbGG7cuvjwZo8P+W/gw0iuPgAKzaM+RRdoKpYhGAX/b+YQFh21C+Lf2mwmXyJFfTuaIjTKFg==
Received: from DUZPR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::20) by AS5PR10MB8055.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:650::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 08:26:05 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::62) by DUZPR01CA0045.outlook.office365.com
 (2603:10a6:10:468::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 08:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 08:26:05 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 09:26:50 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 09:26:04 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 18 Dec 2025 09:26:01 +0100
Subject: [PATCH v4 3/3] clk: scmi: Remove duplicated
 scmi_generic_protocol_version() request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251218-sqqs-v4-3-ff95bf2062ab@foss.st.com>
References: <20251218-sqqs-v4-0-ff95bf2062ab@foss.st.com>
In-Reply-To: <20251218-sqqs-v4-0-ff95bf2062ab@foss.st.com>
To: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Peng
 Fan" <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Kamlesh Gurudasani <kamlesh@ti.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8E:EE_|AS5PR10MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e4450f-cc3e-49d6-5014-08de3e0f1688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzZuQlQrbTlweVBLTCtpRlI0Unlxb2k4WjdWMDBXM1p0YWhRQ2swSmtueCtT?=
 =?utf-8?B?RVEzYkVMT3J4MVd0NU1rYVJBdndwSkE3SEdSYWM3QzZ1NThvK3Qvcmd4bnRI?=
 =?utf-8?B?T3pYZWpobTNhTEtrSXhoSi95NGlFRTZJcTdFbFFLcGNHdnpzUjczSVM3UzFu?=
 =?utf-8?B?eWk3LzZZOG9UQ1pCTmtHM3ZwMktXMGhEK3B6S1lMKzF0OXZVQ0pKeElTNmRo?=
 =?utf-8?B?NlY5SXpIblVnNitTeGpNTUpMdk12UTlTditSNUpuYytPc2JGNjNQOElMbW0r?=
 =?utf-8?B?MXE2VnRkc0FzdFB3NmNEb2Rub25BaVBDQ0JPN0pQbVBPaEpxS2FQUmRxTXNM?=
 =?utf-8?B?L3NwZWVBYVpJV05pZkwvZnFEQUliUHQ2K2tmRzg1N1VXS0htNW5jbUFWNCt0?=
 =?utf-8?B?NmI5RXJBc3hJYnhyU3k3VVp3SkMwdW8zRVk4S1dDM1pvWGsydWtxdWNQZ3dn?=
 =?utf-8?B?VkllTStoYjJ4b09LNVVNaDNpWFpLb3dCczd4TGpWRlBYUjBSeXF0THk1VE83?=
 =?utf-8?B?N1VPa2NyOW1YZ0o0ell0UWU3Nm1wWUMvc0hwNzBYMThYb3YzK2FrNE9jUWU2?=
 =?utf-8?B?UWQ2STFUc1M2NUpPOW9VNXpldHByRnhDNGFuaGF5RDVvTTRPalhudXNaM09o?=
 =?utf-8?B?aCtzYjZaZklRdmFiL0M4bUhhZFBGVzF0SC91QSt4SFNMTi8vL2I1SDFUUEdC?=
 =?utf-8?B?UkJvZlFuODhtYzRWR2NLeXRENW0vNHgwL2xORUs5RGNYNkR0Sld1Ujd2aVNj?=
 =?utf-8?B?c0pNeG1ubW96ZGtRRnJyNEhucU1taHVFb2lzMVhBamhKOG9CeXhEdkg5NXFV?=
 =?utf-8?B?UFVySDZaTzBBMkVHZHVsc2EwZlRPQU9TQUdVRExkYjhQV3hJYkxqTWRNMlFm?=
 =?utf-8?B?WS94WGxDb2xVQnpqMjRNd3JDM0JGWlJyaFJVTjR0Skd0ZVM1b2ZUeXpMZGxG?=
 =?utf-8?B?ekZmMklYTHA4Y0Y3ZCtMTkZqbUJMbldrVnEyeGF3T1Eva3hsSnRxWWhFeFYr?=
 =?utf-8?B?bjJub3MvUytLZ0UzZ1dleE5LNGpwd0ZxMlljM29PRjcvN2Z1KzVIZG9WT2p3?=
 =?utf-8?B?V1NlTFVxclhDamN2eHllanpHdHZvWFpMdFVYQUI2bzVpb2FSZDVTbGt5eVhi?=
 =?utf-8?B?bjFEL3RSVGJ1NCtaWVhaVk1taXMyWXhCN0dGZU5xS0ZUdnJFQVZ0aUhNVHNL?=
 =?utf-8?B?T2IvNWlHVTdCeE1pM1RybmViQ2RaWmR4M08xUmhpZFhoY2QvZnNSaWxxNmMr?=
 =?utf-8?B?N0sxRHFMdUtMZlltZmpuZ3NsOXlleFY5dWM3RS9scHJ5eHZZVW9JZVhjYkJx?=
 =?utf-8?B?ellPaDF0NE1VOU1BTVNWQTdrOFZob1crZ09VRGZUS2UyL2F2WHNxb25LMXVH?=
 =?utf-8?B?bjdjaUtqUEEyaXJuNjBva0tSZGxOVTVpNkxFclRrWFpTQ3pPZDd2RTNJLy9m?=
 =?utf-8?B?KzlTckxKU3R4eTN5aFhVWm85b1daQnR0cGlxUFJsTjIxL204b0ExbFJlNzdT?=
 =?utf-8?B?LzU2cUR2b1M1SngzZXJUOTQ3MmpPUjByN3NMSStQTm5MMVRSWlZhaVFDSTlr?=
 =?utf-8?B?OVlac3ExV05zU3JudWFPeG1NSERMNGZzV2N5MTRKOGNWdE5STFBTblhsczJK?=
 =?utf-8?B?M1VzQ1RxbmlvRC96UnRRSURPV0wraGljKzhweDFsM1N5aVplRDlDZkRpM1l4?=
 =?utf-8?B?QkRZMmdDbDhYSkVmUVFpUlRlTkRodHFQQ1pleTNqNFlNK3MwV0tQTEljQ1JH?=
 =?utf-8?B?OFg0WXJ6Wjk3dXczRkJta0E4dnVmdTh1d0dwVnhHV0NPWXdKTlI4Mzl4N2ZU?=
 =?utf-8?B?SkdFaW1seHk5MEFQWURydXB5U2RCZXVPY2x0NUFwYTRlYXVKSWFaaTZlcHNu?=
 =?utf-8?B?VENjYnU3c2VhWm5BVUkyMDNHOFFMbXZXWEFwbXNtV1B0YVg2SGFnMWM0UjA5?=
 =?utf-8?B?S1B5cWJsYUJzV3NOb3lpQVN2dlJmVU56ZFRzVzcrN1N6QjNSVHdDZHhxeFMy?=
 =?utf-8?B?R3g1eVpvcmJRQ3VYYWQ1RXFDc0FqZVQ0WHZUZFFIQVB6YTVQbXNPY3BtZDJk?=
 =?utf-8?B?QmJ5TTh2V0FyeTR0bHdaV0xvcmcwK3VuTllXak9zd2JqOEprc0UxaFBtajUz?=
 =?utf-8?Q?TQx8=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YdeDXivA1/hhoVrIR+lmT5TLe3Ici3c4QA2mvm/7bWOjiuPTCwPjTlUz+iLOD1ersRtwilpZyfdsQAll2HSvad5BPLrYKAUaVMP/WaGFXELb4v2Dqz2YCr+jfOkRbrLdJGpTGOx808Zt48QcQJhOcpy3VVWdbLj0DIUEJ1fFQBf0Otots8S0lUMPS+GYH/Xf2WTZpF8WZsp0up50adWpjxuA2JoAOpUiLygHx+SzPpKzmJZDqawvLAm6UWsSUXX63oDt1G6nrG78G/st1uaMMam1sdwnkvNXnHqez+4TQvVtpDwbuKRd/wY3ZAbexU5LsJFf+PqhSdegenfusPlax+h+pwuWacxDWbBy9S75i2qYA1NJ5V/G+9dNlvmm9+oX2jEQZ/05kpeurjDFce9CIGQOdbwo4gjAqafPNu8OQXgGNZX4Jx7bgXU3u5tKtZJ4e4ELXoxnH+vUAPVMrP3KJi1/qtaRATxpb45tVbJaI+PkqXemlLWIFEdGHrd4cD6JtNnuT+GuXimd6E5/zKniVrC/BgOWyv1ZQZlaEMggMTo11iQBnqRXvk1yptfOvJTnqy8ayJUpKSoJSN9F7vsV9wQ+IunjZ8iVP1Lw5PFvQGe/wdxojaUaNNnFDjtcg1qGY8ODWlT+/5KMvcRDgBd2QY5EFIsBpY6CUEfl/gRxUbCxKVrkn70PCbwT9MRorQDdOfk9ijho6jehKa+ZRb/GYQ==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:26:05.5375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e4450f-cc3e-49d6-5014-08de3e0f1688
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8055
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

scmi_generic_protocol_version() request is done twice in scmi_clk_probe().
Remove first call which is useless.

Fixes: ae7e0330ce22 ("clk: scmi: add compatibility with clock protocol 2.0")

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/clk_scmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index a4fc4f8da89..ee237ed6337 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -344,9 +344,6 @@ static int scmi_clk_probe(struct udevice *dev)
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return 0;
 
-	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
-					    &priv->version);
-
 	/* register CCF children: CLK UCLASS, no probed again */
 	if (device_get_uclass_id(dev->parent) == UCLASS_CLK)
 		return 0;

-- 
2.43.0

