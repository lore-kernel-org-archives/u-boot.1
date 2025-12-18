Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65AAD68BEE
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 08:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CB4083D0B;
	Thu, 18 Dec 2025 09:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="IYf7B6TS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAD7A83D1A; Thu, 18 Dec 2025 09:26:13 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4521D83D0B
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTpPL8Wy8Nq+kb8rYkxmZMnISn1iUfZNsY1u/H9LHLQG/DJHpIOn6psAF5OEbR3mXD9DCg1PPZmMoNNu90FDYqILMoDyVNlpmdOMJrGwWlqlTtKK7AtUR+9UB5bOC8UdTPEqZ4iCJCtq5H7Ty4die/iU8YcyKjcEzjW1ca7k4FZ2Vg/mnLE9B/v3+3lSRRAh/xCVnuW5Gg2HA3bN8PhUTeqg3bwuiaAVRYTGd06LkggCokch2aQ1u7Mb1cM4xxdEu9WYYTA8SjBLN3FtR/0n9syw8mCyq7pP3MVCUKCwlSPQ8iJ1dF4MeAeXgp+/XjfKRqMasEKyiFFKWxbnW/qxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjBU4aCIy3CHbe8ubayzLOk1pNe+6CCTKmJWAgoL0UY=;
 b=mYq/uiV329L34CA4h/94A3RQveBE3wDkctWTEK0ZQAeHYX8SSExtYvWatJWc94TgtbfPE0JrHPyrnBvwM0+hQO/Xv5qNlycDwJ/k2lW7yui++ReS+3KJb0muY/0oNRrKin0tQuOKEy7nv5ucYQmqDPa5y/imCsrP/IJUSMYpHEhCTPw79oF40wIQs5IW3f0FJwNGu4k62NIAB/jdOSSJNpkV+I4DEmMLQln9ftyeZDEW9Y41McF4SRgctg6pQTMvODrJ8/K7swW13DW1viOLOpcu/Z3fZw2vabhl5JNI+/vz3rKGrq4P64hAtvKtA5t69DTV/tjK9m9D88W0N9VXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=denx.de smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjBU4aCIy3CHbe8ubayzLOk1pNe+6CCTKmJWAgoL0UY=;
 b=IYf7B6TSOQhpGSYZlujPID9gENRX/sZgjPIAn/KBA4PHRDRsL2aB0b/wMGhs7xdY63TfJ2nyvol7UnBH7VU8yIi5vVo9/khbsAn7c2VPAuCmO3AiIobh58EDttZuI1p4x7yG9hn//YyV5uSXEE60faoGzku+pONrgs/6TFa1CIlKtgHzNDVlFxHm01V7fb0qW22P2Nh6ox7T+3K7hS7AD0fX0LOtBH3ApT/wz/EkfwfUM5VPctAtbNbZN5qUB9xu7+evc2cvbqCDYO/9QAHG9xXcVWO+brePXnB+Tiou4zQMjnVHDOyhTGVlHy8/foFPIRDJqVotd7E6xajbv1pITQ==
Received: from DUZPR01CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::19) by BESPR10MB9247.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:b10:f1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 18 Dec
 2025 08:26:05 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::52) by DUZPR01CA0041.outlook.office365.com
 (2603:10a6:10:468::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 08:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 08:26:04 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 09:26:49 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 09:26:03 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 18 Dec 2025 09:25:59 +0100
Subject: [PATCH v4 1/3] clk: scmi: Fix typo scmi_clk_get_attibute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251218-sqqs-v4-1-ff95bf2062ab@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8E:EE_|BESPR10MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f743682-e04d-4c46-888e-08de3e0f15b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWRUQndFYytUSit5LzQzMWxROFcyalljeVlyRTVhZWI5bHp5aWVKdU1wWUln?=
 =?utf-8?B?MWJZcVhqaFZCbzl5TmovNUNKd3hCL1JiQStEOEYrN2dBcmJQdlJLbkNFSnJo?=
 =?utf-8?B?NTlVOFZ0ZWJsdHI2a3dnVWp1R3hMWFlYbHlJZ2x0dGVwQ3hqeFFpbDJIblFX?=
 =?utf-8?B?VURVbEVGa2xuUy8wdDROdWlZSGhRL0I3NG4rc0hIaXgzWUZzZzhrWlExQk90?=
 =?utf-8?B?UVZTNlBIajRLRkw4VUhSZUhWT1dUU3RwS0ZYS01WRmV0OFBUSkFNNm9BL1p1?=
 =?utf-8?B?dFBCNG9IMElVZGtheFRQSjhaeVRWdDJtakdsYUtNOFNLRlZJYTJRb2RwL1du?=
 =?utf-8?B?a085c0dpZGRYNVVCSlBZNXZqNlNCblorUy8rWG5hWm01S29RVHB4NVFnUThR?=
 =?utf-8?B?clZibVJQWkJYSVgveFVqWDM3cmhFd09tY2VEMW5iSEFKNUthVmU2cld6bDJK?=
 =?utf-8?B?ZG9jUEFLbVdCUjRvM3FyeGkyVkZRWUxCNG9VNEg2QzlhcTNvSzhhc0ltbllw?=
 =?utf-8?B?QkxLL2pSNk9PUHRkT3JWWktabERHZWFGVjZBRVBSVTBWTlcyL2hpV1J6UnV0?=
 =?utf-8?B?N0V3UHc4VjlibkVweFRkdEdta2RmYzkwdHBHSC9sM1U1cXRzQkpwdW14ZU8r?=
 =?utf-8?B?RjRCWXQwNThMbmU3UWlvd3czdHZiemgzVEcyeHJTdkY1MENSbWwxYlA1NDZy?=
 =?utf-8?B?cUIwdlJhcWwxT1ltNUFsaU5uZDV1cm9MMTkvaTdSN3V4d3dRK2pUZktWazln?=
 =?utf-8?B?QXU1Nkd5MVl2dW1PL1FyWi9MQWgzY3VtZDN3OFljeFJEMDMzZTJCNFVQc3lO?=
 =?utf-8?B?RHlrWjdXYXFCUlNNbFBmWVVzTTdtY09WQm8yWVNSeExaMHNJeWtvbGk4azNT?=
 =?utf-8?B?TG95Q0ZsenZwVkthZmk5a3UwdWY5dDkyNGQ4YmpJZE9BL3dZSHVZUHg3cy9F?=
 =?utf-8?B?UURiMEZUWHJnV0tKaysrbVBPK21CTXB1cjV3amdWMnMrSnFRVnRRdGFvamQx?=
 =?utf-8?B?aHdETlRoL01tMGkycmlZLzBBRmRjMEthRWZrbmUwS1NFVVBjaVlUOVp5bFR4?=
 =?utf-8?B?OU1RL3FpdmpiMU1Id0NtZU1QaUtDUGlnRmRsejB3d1NkbDJhNnFqcm96a1dv?=
 =?utf-8?B?dnBpejFKem9pYmIwZ1hRZ3dDaEpJWVFONU9OZkFyOVNGaUpKQ2dBajJaekFO?=
 =?utf-8?B?cUZidS9TS3lkUkVpTm0xYTdTblVxajFwYzhhUEdFeHZpTGh1U2ZLUHVKZHBU?=
 =?utf-8?B?TzZMVDF4VVJGUXdxdndWZkt2eEwwM3ZNWUU5N3hKZE5lM0hyK1NBM1ZvK0F4?=
 =?utf-8?B?SElmMFBEMStBK2ptSHFBbFBsNCtTZTh1SWtuaEtUL01jSHlUcVpTQy9BUUw4?=
 =?utf-8?B?VStpbUQxN2wxNUpGRWZES2Z5UWVJcTJ2eTdvdnBOZ3BhUlhsMjB0SjFuN3hN?=
 =?utf-8?B?bXFwT3pBd2xuUzNvR0xQWkdVWUprNnoybDFqUEZyVGt5elZZS0tsYm5CT1Nu?=
 =?utf-8?B?VHJhWW9CRDJ0WmhHYnZHSHptMVpiU2wvWnBrZW9NYVo0SG54V2NOL1RtbXcx?=
 =?utf-8?B?Nm9pQ3FTaUV4UTVXUk9NRUxlYzNnbEVFRllNRXY3M0s3RklIeGt4TEdaUnF4?=
 =?utf-8?B?MWZkZkpRY0duM1JHdExoNGFvZmVFc1NtbFFveWRzT2NUZXVQdjhmVEVhS2Zw?=
 =?utf-8?B?VkkxNWpVcTk5ZEVDUHVtekx1QTdpaFY3MUVETkZja1ZQeU56NHNGUVc5ZWJB?=
 =?utf-8?B?VVRmYk1WYlEvZEM4VGE5ZGE4NEhHTmNPcmVrZTRCdjkycjUxc0JxbzhWdjhr?=
 =?utf-8?B?NmRrMGZUSk1hN3FSRkxXTXRKYW1URUs0NDhPNFB6Nzhqa0JjMFR5ck9tMFpa?=
 =?utf-8?B?Nmtaa2Z3VFQxak5tKzZiVEVHR3lteGFjRmNXWW1RZDcyelJqVW5YYmt0OGxw?=
 =?utf-8?B?QVJWUmlUcnNaMndUSzh5cmlZdU9tb3c3TlNhUk1yaUdPdEZWeXk0Tk1IRDN3?=
 =?utf-8?B?NzQvUk9jbUlwUTk1S055NWg4cFZXR2VMNFMzMjYxK2lLRzdMalZwa3FjZ0xB?=
 =?utf-8?B?c0Z6ejNlMnVORlZiWk9vVG1ENzFHSFhVOXJaUFc5YittWFRPam11T3hWSmZH?=
 =?utf-8?Q?2Yak=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: btP/Z8+zsi1zDIka1eHXZlibMIDnmobIeNRIxq8T1tPmlKxe+BnWvGEhW8nDMP4dmB0jclEfyOrU4xvWTFu9MuCPbkGUTfjawD99S+ZZVRt0gJtWFQ7qnL/P2FU0VicOIvSblYxAyFibbNvbLvXWyR7BM/WQIEIMI3CNilB/CT2jnKQzSFTnTIo1MJYiJ24IQncW46iw8uPD5wb53FcB/ENoDgO3dYB/Xgj11MQ/4sMvU85g6njVwgcqks4OjdrdsL9ZY1sZuSiIj3Mobu0Bp9aryExpQQ6JJ7Twa1OC0O0vE8kNJrsDJYt7Fh0lP9gI4HVKE/yZf4MIng33CVsoi4ApO0zQXOUWsF429/ir1IKQoNs53X42HvyS+rpoCESazUfMPD2EF5s6+knAy8UEy+pez0oJXXabmPQNrf6obCU4UAKfPKsf/4dd0nNId4RHAKrLAuslZJ3fzY6poJJ6q78TXQ60m0Fk5IgVAWTeRMg7vvuqCbVE2rfe4lN184RVVBnLyvprKPV3ZZPG+29dEowuA2V3M0KgH5C0E0305z9+Uq6f5XoW08LXMFi6DpPuXEul3OWXdwAJ0Z9rKeRFMoMi3TP6GGWG57WssKnVyL6cyuQJj4dfNvITgr9zhxg/4wrPCRlSbOzxPYbNCbNwb4uT1PDvbzM2SLg5sFGiNrdeEvvGpnZVsyYozP1OkPkHVSN6w1kgvud7P9VwXUp5Tg==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:26:04.1442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f743682-e04d-4c46-888e-08de3e0f15b2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB9247
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

Fix typo attibute, rename scmi_clk_get_attibute() to
scmi_clk_get_attribute().

Reviewed-by: Peng Fan <peng.fan@nxp.com>
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
 drivers/clk/clk_scmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 683ac822a01..f6132178205 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -87,8 +87,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char *name,
-				 u32 *attr)
+static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
+				  u32 *attr)
 {
 	struct scmi_clock_priv *priv = dev_get_priv(dev);
 	struct scmi_clk_attribute_in in = {
@@ -183,8 +183,8 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 
 	if (!clkscmi->attrs_resolved) {
 		char name[SCMI_CLOCK_NAME_LENGTH_MAX];
-		ret = scmi_clk_get_attibute(dev, clk->id & CLK_ID_MSK,
-					    name, &attributes);
+		ret = scmi_clk_get_attribute(dev, clk->id & CLK_ID_MSK,
+					     name, &attributes);
 		if (ret)
 			return ret;
 

-- 
2.43.0

