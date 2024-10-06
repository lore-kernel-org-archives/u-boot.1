Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFED7CFB424
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 10:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C272886B1;
	Sun,  6 Oct 2024 12:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w0A+loGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A74078897F; Sun,  6 Oct 2024 12:19:18 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3904886A7
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 12:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9A0qld6W6TgW+gOwjiQzh8hfWx3TVaGpSqgq2Vj9JSTjf/Jzt8bv0nwpCFLF3q1UU0eunoYYBt0rJuJTO8fzEZgzy9ohiK5HGzG9HoZyFPP/HhGIraip6e+geHtfaTJCUvM8IBXnwir7S0FaCxkzlngf+KZOIfdPtb2R7n/HK6f2jqz3xs+YaUZNN0wWOsKbwC+403tqy2alFOvF1TUgsti2ChyPC9HVv35PStnkE6f5Zu6+PZO+lGRdVRxZxJrTZAS/SDiaeLhptyHML/lAxGpDXXXm+X7voBCTrFwmHTlR2mGPotoa0CoykA6f74SbDUlhNbLoc0BVhzRr/o2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8bc8ZTHA88pc11wTjGyrj5AHFgIToTBrQ2dulKkquo=;
 b=xc26XgrGEzRdNLn3BKW76e1rB9nPVr08Na/2I1JEOu86QNbL8K9BdOIlt+IPeYuVq7PtabdvvCFiN1/W2I1f4GXeUy0u12ySItlFq1C5mrZAfUVhPpdMykNR0EHRv9kBlse0MknAKQ7JKnK1znvF778SwnnKD9Y/+slMwssWGLcA+Y9k/v9B3v2GrnvCcrB/KLT//gZ6K8NHkWonmtywv8cthwwQMb7fyNdqOwMRdSMTbNBafzQCr4kBDxbZYp4MZgT72DSgB17A3i1if2q/MoEVk/Rr7ZIbvvNW17NgkIt+hymI27rsgd5Cn52wIoeXE81GJuN5ZbQR28x9GQCcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8bc8ZTHA88pc11wTjGyrj5AHFgIToTBrQ2dulKkquo=;
 b=w0A+loGC0yX5EBwLifmgbyTYrN98iTWWW9ALcmkPBF99w0N5BEbTAggOa46pCUVF+DFVEegz8PWzWGvzOb5O+n2oN4HEgHlic6MMzkQBV2F1xQCZBqO8gEUK4g/1vFAEJB1qflYHhFAJYnOqbNffk8g7Wz+wbKyLHpcYO8ulm94JfyIg2skbLgGkihBsCkwsWM2M20W7QoIr6TjufHttj6d8Dv/SczfPGkGWbhZz2zVjCaHabexw7/58kDnci+aon0sIeuB/ll+JqWXRIBsKpizt1Kt6CnmHiuzLfGQ9JtDla+U45pnsEh2P+Ssv3xUV/Gq2Xby7eEWXy8OQ3nDhPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7670.eurprd04.prod.outlook.com (2603:10a6:20b:297::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sun, 6 Oct
 2024 09:46:16 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 09:46:16 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, alice.guo@nxp.com, ye.li@nxp.com, peng.fan@nxp.com,
 akashi.tkhro@gmail.com, sjg@chromium.org, festevam@gmail.com, marex@denx.de
Subject: [PATCH v1] scmi_protocols: add PERF protocol ID
Date: Sun,  6 Oct 2024 17:45:22 +0800
Message-Id: <20241006094522.2800354-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: c73d6f4d-6811-48cd-8bb8-08dce5ebb91a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w70Js9PwUTryLRm2h7kJTW23tYIjqbDWBLo6svZKSTMOtk5OETMOFhmD5USm?=
 =?us-ascii?Q?MZ7g0txd+K+SNZrbf/I5+2YdD5AXj3BEXpriIHxhQUa2D+trn/ipcc6fqWfX?=
 =?us-ascii?Q?h9Pc9AHzjV+7MaNAzQYsafCWOh3cxbi6YJCjxCZZLF+JIqgJrhg3uRiTFycC?=
 =?us-ascii?Q?9e8vBe+2iYW9Aj3kvdJWmR8gXN7ygp8o9PBV2sVzzdxyJrAWoPhCl2yGiXvk?=
 =?us-ascii?Q?/N0JY27yNWHelEi5tskzTglbkBkvRVsX+h3dw/aJBsvdo8hiNiTLvunwCWZ1?=
 =?us-ascii?Q?o7MXIfaAV214yUfu7akBwkNepZdYrFsC9TuW3ZAV/9KU/QaXpaLfa8QBICxH?=
 =?us-ascii?Q?8mmUIEleXywewU28rrEp9KoOGmhg6zL8ic1/8bTBY2QBVV1mWnBVo4Oofr7P?=
 =?us-ascii?Q?qmXK8sZ6bOrhNviUTlWDfKzlhVVark+216Frht1pHtRZuHu/8Qb/l3pObxMD?=
 =?us-ascii?Q?ia1Fkf7PV0v2zZmd2gbjkLQVGw5mMIZSKbw1Kp6oxes6oNVCRhy3qO3h/Eeq?=
 =?us-ascii?Q?NZBRW9LeLnGLKHKNaRefmvmLEpHy+6O6U2qE9i4YBZE1+qFlUb10PsuRPtOD?=
 =?us-ascii?Q?gd7qIm+JK3Ab34cfV0KI/ioa9O5V7stMdaRrMCuV8iWbetIwCHxseFSFB0Lj?=
 =?us-ascii?Q?mx0XiVP0zkXMTV+ZWtcjeNAc7WokdAjWNZ6crsSC6Sjd7FuL2IG7CXa/0+h1?=
 =?us-ascii?Q?D6EuKWJP2cqFyU1LY7pOqJjcGIkpLLy97QndFeVDIXjvFi8Ylpv0PHfQV99S?=
 =?us-ascii?Q?oMxuhazamqSNI+wF7NVX3lL3ISFS77lq2yOuBUwVhExb2IhYGZWdgmDGeZOV?=
 =?us-ascii?Q?TlarUGlTw+s+ZPSemIImjtwaQ0/eJ8oMZHCbvWWna9lCFpRn3wfOyp1ATpwv?=
 =?us-ascii?Q?LbXe/apj4qT7d0gjJyfxAvBqqWYckgWXd9I875VHjtgEDSLaxIpCH3qTQYQW?=
 =?us-ascii?Q?UsKF3zNTfw7dj/rg2GpetLilgnJIa94aiSmDfWv5fFEtPLv/jXsgCgWhk7YQ?=
 =?us-ascii?Q?j3NA557z4oxA2V3xUYwjId2xPH5aaKQPy/WJpkJ2GqCTnHuWB+EKhrz4gzZQ?=
 =?us-ascii?Q?RTniAIZAELaeLcQNytmUOmsfl1Tp8xmWS1LmSY583v6hhfjRLedq8fv/ZAYa?=
 =?us-ascii?Q?yhv8nW9dZlFGmToIxBk0EH5Z3vo0l3hcsZiHTEHbHBFNcL/tKyawPIQAdpHg?=
 =?us-ascii?Q?yEsQ+fqPDRecd3RHgzsOr8hPCIMCTTSzMCKPrKpkm7UJABhvYNeE2P4hPi/R?=
 =?us-ascii?Q?6MA7qvZyM81aYq5wwuD2Jyh7oMHwivyAcERu0gAcgmQtjgkS5bUa5Gpp6vQd?=
 =?us-ascii?Q?aoNGOwY/4C9U/m7Ai3bzUAeq05qxdCEG7Rsuc+i2R1IyHQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?807YzbqwnCzSRh0lYiQYGoh9Lb+mahdBnA0rnumItI71eLBOTM5F/0rbbQSO?=
 =?us-ascii?Q?8tWkAYc1pDDXPBnZ+mHVuVF2flW7eecu4pgBTQ82G7nEUHuRSiTE2S7xdPGN?=
 =?us-ascii?Q?t+HT2a8snZ13CTdRoOSWlZqK7wbUjcZeuk9YQjCjJpR/fulbi6Y48iNdFgnX?=
 =?us-ascii?Q?FwZYdbJEUtsdxOYVsEm2oiKiYznnCTxom/XYzGUWRT4sPQcjtiamrasODQPL?=
 =?us-ascii?Q?3XwacgdUccfL4Zvpv1N38ZZ1CyNYTZ3BI4FdH9KbM2DpxEqpQj2Tbwsu/WtV?=
 =?us-ascii?Q?Hjb+NUKOjncHnyXVCcC7C7OFBEHJvtyFKamF9XfUg77kDAWB5/S0Rgsk+1k0?=
 =?us-ascii?Q?ljde7VGEBd9j97SLPPHCsEDAiI1/adVNO4X7jY5Q6GbpWdwLdmvsNKfsQdcR?=
 =?us-ascii?Q?sG9eWqvSQuOFbbqMTzkJbNz4ouANVdoB8IXcqXyXvoFnwEqSES+402PZJ05M?=
 =?us-ascii?Q?sReUq5rrElZLWdUQzUhhYpCn7KASKNnOIaZVHF8cEqXn1SDmYYC4ejzZDkX9?=
 =?us-ascii?Q?nzhkER2A9AMf3MjBWVS5HZP4LEdy6+HO9vVAlWYbzeL6lQGfSg1ve7i2UEQU?=
 =?us-ascii?Q?frwRm8hXF0e+vhf2cZhKs/NhL+bo4qiQ73m/gLBH+SR9q/0/3WddfBrlRQmz?=
 =?us-ascii?Q?tvF1HmPfFO4x3efdFEdU186ozQqcwgKEY4bByH3njZnnHCHQy7e4eWpsoiRo?=
 =?us-ascii?Q?2c0sy96lRGz2cGQBiXPBLBAanm0fGQnQUP7uSB3dZIaCzKNc5oF9FFXasSv3?=
 =?us-ascii?Q?d/tHL7cho+LRUz/7ixF51P7xHgLVuUI1TqPVIApsz2mRtNN3glwZ7CD8VCJd?=
 =?us-ascii?Q?Vavsz1Ma4GSl4Nn2uysSYNx2wQwSPZxxCswByfDUF+t8exBJDz+aKxsNUiGY?=
 =?us-ascii?Q?Y2AudynTWeVAuX0Gkz5CEWEJ6BHU/OV3nzZWIY+Hg5akCCOp8VDL31OJ6mxK?=
 =?us-ascii?Q?Cj7MKfY3g6/CT4w+Y25hboc06NQbPgnqMLEtruV/jIUog1zSVDVwqPm2S9kA?=
 =?us-ascii?Q?VHy3l0ZKVEszqSOxFbJcFl/7C4figYK52qOmu8Qs/PnhZCcPNOgjOG0NaeiE?=
 =?us-ascii?Q?grVVcP14g/yqEvdHEY486FDJR1emhIfeDucKrevEd95dT7c7Z2UAAAiu4NFT?=
 =?us-ascii?Q?+/C5oScKEXsB/VIlcOwNbxEHohwqjwxwHobjHuAuu8dIqbNBcVqkcE8rDL0n?=
 =?us-ascii?Q?87/98EHsYhiI6jOaNYOMWzZinhv9qARbnO7vCGZXWrKq2RBoTG6bKibZMudb?=
 =?us-ascii?Q?V3Lvffz+N6ea7vzbr/RRJWa2Fx21WMsv6oQhs4GmwPOlKJKzGlhXubRi8alb?=
 =?us-ascii?Q?5zat5AeXufbV78LIqToRinHsjcqRJiYfJ86a+rxXtmTe4wTpA93ZSZ+QPPz8?=
 =?us-ascii?Q?fPnd5q1KjYUuZDHqNsWNCGS2o9MHWH6PVRV2QoKbi0CshmA1zjxYy9s9iep2?=
 =?us-ascii?Q?N4PZoSuSsrmgUbVmvcZM9HroevnVBawsSUgs7iN/FiO8GyZ3YiRhiNiWqT9M?=
 =?us-ascii?Q?BOb/vyA7j2idJdOMEjyK+X7puLEuI1J6qMSz3LfFdpFP9DGzOoxTidpIl3FZ?=
 =?us-ascii?Q?b7ZW5adClnmT8wAmNk0lmzXpKUnuabeq5yxw5E7r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73d6f4d-6811-48cd-8bb8-08dce5ebb91a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 09:46:16.8127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTrPSMvInhZa4UngBDy1Jq8RLm8EpkuDR8srGhuFlRYaM8NsE6RkMqUQ2sUYT7g9a2VjMrMN1MadFXpE4FpTag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7670
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

From: Peng Fan <peng.fan@nxp.com>

Add PERF protocol ID.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index e25d94ab5b..43b66be00a 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1058,4 +1058,22 @@ struct scmi_pinctrl_config_set_out {
 	s32 status;
 };
 
+/* SCMI Perf Protocol */
+enum scmi_perf_message_id {
+	SCMI_PERF_DOMAIN_ATTRIBUTES = 0x3,
+	SCMI_PERF_DESCRIBE_LEVELS = 0x4,
+	SCMI_PERF_LIMITS_SET = 0x5,
+	SCMI_PERF_LIMITS_GET = 0x6,
+	SCMI_PERF_LEVEL_SET = 0x7,
+	SCMI_PERF_LEVEL_GET = 0x8
+};
+
+struct scmi_perf_in {
+	u32 domain_id;
+	u32 perf_level;
+};
+
+struct scmi_perf_out {
+	s32 status;
+};
 #endif /* _SCMI_PROTOCOLS_H */
-- 
2.34.1

