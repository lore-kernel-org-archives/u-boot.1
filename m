Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09D9C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5620780F88;
	Tue, 18 Feb 2025 13:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JkThf4FZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E62AA80BA8; Tue, 18 Feb 2025 13:07:41 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E991880F56
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEGqpZJQCQkcOULEaNlVaszeWowslPqKu7i4kQWXiVaXdiBd4bAVnf+XgTLZcR0D7KMuHwcC4uxD9LemdyfFoNna2PwMvzYhzeeWCjttU5m9RntGtq3ZMLwKWjq/NuI937DjAPGSQnSaYfjGNdx7HdPEZ5eoIDWV3WCAyNGngfBeHB5L+1hvNp6Sm8nA+4UK4PKgOcnbea1VjttgsGckFojyRzLcMZEfx4PpVDA6YsFMaC9r7ybIJaZyvGfO9yA5n7JcY4BiY5MYjVzj2v7AgnEmjbrKOsPeJ6chtqzik8vCwhqmMYP6eo8KUJi+g8VSX95f9Dtaa1sPBWNjvHYezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuAbHoTak7Y5/joAS8CkJFI0a0e3P97zQIMJ0n88lhg=;
 b=yDgldJ8xkHRU/ofnGvz8QmebVJ0P1/MJxWaIEhru96ig3rf+9RWt4Nk25zls1uA4NOXJocDcTG+7VocJPiEXFX88O0g1J36F1nhZQULhi97JBPtA1fah1cS5sW2rCsKE85zQ8IaagAIgcJwp7VxRZ7jws3T3DcwmcsHvPHKdGcEGopBNCDw+BLtWYwpGD6Xnx11dnjNLHoKPq81FLluSvALNcc0tlj/P80MdG5jS8P79YUzxzzWCo9O2nwFgsteudYe8eiHsof9oYjAN/WjxH1tdSIFYpW0VFTlGFf7ZBNEcV0fR1eWNFkne6LLChgGEAndwfNZJNW2/n4EiPvm1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuAbHoTak7Y5/joAS8CkJFI0a0e3P97zQIMJ0n88lhg=;
 b=JkThf4FZOLLkZPmg3MvnYbi71ixlFEECDUlhEGs6neL0RumIsyhFL0nB1W15KZqV3PBEtNKvMpkdvmlVg0VpEIcP8HZ62jbr8ZFMJBNm5J3LnIQDl/ZKyIO04I7ya+KGdJlEFeG5FSnmiacTPClCpATXG8w0NXiNllHWhyW4oy5UZhsHizE65ehhd6Ot+Ut6EKySC0MzT8mTxh9tkpJzFHENKSULs2b91r+S2Fpn4kavC1PAtF67IjlFj9cx6sqWkSK6Lxe+x5nCpRihRxQdNz+r70uwSB8YZOTOA8mFwcND4Pke7dKX+fl34Jx34o2GKpXdxFrIiAL+MuXPS1p3UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB6912.eurprd04.prod.outlook.com (2603:10a6:803:134::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:07:38 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:07:38 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 06/20] scmi_protocols: add SCMI Performance domain
 management protocol message IDs
Date: Tue, 18 Feb 2025 20:05:43 +0800
Message-ID: <20250218120559.451678-7-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5e2c2a-f5f3-4fcf-0619-08dd5014d62d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R/e33CPWwQNAp3drPv50naeAKnkcs9TF+f1ivLxKmpkUnNu8GPw7e7DRkMdk?=
 =?us-ascii?Q?7GA2vCsBhY7WzBxfFa/7/b6h8YG8Tps5smZAzyA/2u+FjU+to+ILv4aDAOL+?=
 =?us-ascii?Q?5E0Pk1ghzHz3etajFBr4i4ZdEVZNv/dcg2GaA+H13CdBu0XGYGlSB5eESwez?=
 =?us-ascii?Q?a2XfmmTk4Rk4301aPB/BtOHn+04hSYRSqdtf8+M6TBnvCOh1gdv2+vV82Zo8?=
 =?us-ascii?Q?+OXVvu8Nwm+6iyRxRT5+QMfYyxgap6SRYeUeJa2wqFlMGrElhFHuhzRxR/kc?=
 =?us-ascii?Q?pGmvhNo8WadIAYuj7sOfieK0bH7cBPFef2xNx2nuT0wDpVoxjPdxXxYfBmxO?=
 =?us-ascii?Q?Djfeik0uUvod6JZMDWxxJVI7Iow68hCJeJ6wNkLmeV21mkiZU672a2B0xYOQ?=
 =?us-ascii?Q?7luir3z9FpH0FGFszCZS5JqFTN+xaE2pNylJj0NxD4s2EMWW4mUg4oTODnZL?=
 =?us-ascii?Q?10eiX3uF7PPL1842hXoJ/PYAHv5T4oe/jp+RWJPfyQOFlWDD1rIyZ5u+2daw?=
 =?us-ascii?Q?MaDs25PU9J7g82onEFBl2vOqotsy10nYQbD+a0RDl5HDjdZcLl2ML+hwhl+R?=
 =?us-ascii?Q?G51ygGPUpQUnpcXoA0G9dMk2lEnxZMeTXzHSRr/jDBEmoUWTqFwLSO4OXB3j?=
 =?us-ascii?Q?gRRZMQnk1/6gUQPjkYpvAuqKM8evOYdoxVcCV62vtsNzSu5vHDRZ+P5j2M8W?=
 =?us-ascii?Q?pJ9+Ev/cW2e3FMOJLaYD7GF3QfuWeN+My79pImjweEe1ch1mEbHtpe9hdjNh?=
 =?us-ascii?Q?po4RK981hX0CbFDB7cuVEk298I33swYcIB3ZPtNjNaU4ycsuyRQsrTu1FNCn?=
 =?us-ascii?Q?e7Q0r+lm0fuxXyICKuovXeeetdnFhNZ1RUyQZJsZ1cEjNMOpYN3BKX9G4Cvb?=
 =?us-ascii?Q?H5gujevvG+7jjIyERPiXioBKPIt269mN22t5Ag8yImjZZ+zQKtcIYJ3l1ndt?=
 =?us-ascii?Q?G1pTJ6cTvQl7Eia3AfokHNkukZ2oxAgAPogoNSe4fUivIgSpMdfUHSDaIn+w?=
 =?us-ascii?Q?rekd0AVMWFLstY3L1nlrf+THGgUCiGIUsJOAI+VHBFk65mulgGAK4pZSOHZX?=
 =?us-ascii?Q?uZrfFlFiSIHROPdNR6sCBkXazNAeZ1Zcsju7b22GQxrkFM6wjTbhSFGe03A8?=
 =?us-ascii?Q?60MZigR/uoCQIBzSBLxgqMRMM8pi98II51ShYDEdWwsRCVz0pwZAJWuiAz/T?=
 =?us-ascii?Q?/OIGtRpdRFusQRldfbOTSvPmTnLI2T15vjssBVmMj4ts7GGBspqi5mChOIUH?=
 =?us-ascii?Q?0BWxdUQq8UDam8B/qgsmhQrgJQp1AILAQZo2N2hrJV9UNeec/1SdrKsRwDqn?=
 =?us-ascii?Q?3jNEjHTO4RdBhb96srWLYCJuFUig4+XIZWhfLGGQKWpAvmNO2vNXH0TGJVsK?=
 =?us-ascii?Q?+rYmpXmyFj3/Khw05tNHHtEpZi4Oe+d/RJyuijYQRyzG2WGVcmieeMjE09Kj?=
 =?us-ascii?Q?3tipdIO0iAhVy7xGWb1WhL3DkcJH8vnW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xgsPHHdtbKk2NjHUmb84H6QDGgmZuhQNKHU5zcP6O8+L4ELViOhK8bEnLbVG?=
 =?us-ascii?Q?NzC+XXLeDW5qYvdS0TlqD9D4OOZfLtkiJ8+BThcBQAvLj1see2rQjzhxUdnk?=
 =?us-ascii?Q?cDL0LWrldT5O0MI8KUNiJ1fKh957LVRPTosow3QSGi+rmAd9hJIDT2hqivS6?=
 =?us-ascii?Q?oGofqz8M+RPLEBr3nrbNpFl3QaL3PZ3ombW7vsXCIVSQ/XqVP0HJSyLI8uCC?=
 =?us-ascii?Q?zLNGuA6qWCCeCFD/Yo8Ww3cokrdI1g3SONf/r87wSfNgzfHQ8c0IBzOQCfKa?=
 =?us-ascii?Q?A7ZLAqeAmGKzuwPFI6GEoq4Q4D/8vydrhgvMNbEB2m7jROUhT744+kJS27g+?=
 =?us-ascii?Q?WtVad8F8hO9XWGSznDAy+UFL8naPrtDd0ynnRmj1An608v/yauZbdtzZzjlu?=
 =?us-ascii?Q?qEe3Ujh/b/KLjstBB3u2Mh6Js6UpGAKzZBKr1XuD5GK8iP4z1ufOTFkv1arn?=
 =?us-ascii?Q?ZHmEyL1KIsHKbF46ThA5MEOl4A4k4dxZvzN5us/5AxgI/6LjVTUSFMbVqfyg?=
 =?us-ascii?Q?LEYhpylJ2OR8W0114hYn8QXwzXnoxVxOq3atkXNDJJuP7o8Awvk86BODhhBJ?=
 =?us-ascii?Q?EeCUwvMS5sE1kf7ZEH6/Y/pjkIWDUU6re7sy9zzF0C8Nhxq5kItd5XKLDW7z?=
 =?us-ascii?Q?Mkmi/WVFKZBs+2rmCdvEij8hWjs4TmzH5xWN1lhJSwJoG+h3bO6wK0k5aIRb?=
 =?us-ascii?Q?XuY8XSk1eztAMcOYJWxrLIf6TkQcrmjxH6sfjYUf4k65u5l+/sb4kjU5QbqA?=
 =?us-ascii?Q?88lkwzEOvambDikT96ogIWaf1jIpuGiYiem+tduTzPaQ87ormokX3WDbnJuK?=
 =?us-ascii?Q?x4/mA9sBoKadXlvuDHeZd8dWQBw8uvdbokKe4I3kdY+pazE1bb9Gz97OPiaY?=
 =?us-ascii?Q?cS0I0ak8vDelA0OklwvSYNh2RTNoevDobArYZz6k6oRWBxte9hD8lO1kplB1?=
 =?us-ascii?Q?0bEOrKU3CezhauDjT4rW47g7MdZaLC8Lz+EuivEZs4G329YHjHIglI4nFr/x?=
 =?us-ascii?Q?Ui/lTz3jX/45wczrTJam7peTflU/3UiM6j7zd4pBN1nOm98fTWjZFqSYR1WI?=
 =?us-ascii?Q?6Q42j9r7l92YiDYMAEueohvEA9fUlqtYEQWDI7EaovfDITK1MoxcJfbSfwjI?=
 =?us-ascii?Q?yIwOUPbmfiNICdk55gD8LQu5Nss4Ig3uC9+FNrmsoe2hUazuOlnqaMxmUOiI?=
 =?us-ascii?Q?+Obvalb8AB+H8RDIDD7/xl7scqXPbsih0qxfB9SC9wq5nsBxREMdlUV7VxIA?=
 =?us-ascii?Q?5QZHGIyagZ6zTYXSNko95gAk5YYzPBaHUWp8nKO3avANjFsJHWZ8D8o5Nt5/?=
 =?us-ascii?Q?0EwPYP08zt8KN1jWU69RvS2pgfQGn/qPw0vYB4jMH8/1OcvsGmmk22DjZy/D?=
 =?us-ascii?Q?6a1PmS/3YvuUx9E9GTsSj7o5ZASYPpXQoQecQEA8PzJC6Q4xXKiAr58IIdDA?=
 =?us-ascii?Q?HZTWkzwjqUxSjxJMRm4nRYxrvNkeoRtuoWLfszpug7J+66kYh3J9K1SAlIPZ?=
 =?us-ascii?Q?W99GnUfGdivBUZ3f9JAHbkRn79lo39SMjTrpDbaMhWdwsJh2vj0VIkHiAHMN?=
 =?us-ascii?Q?KlF8BwEYPy+bcwQs/sQWcnYlWExyGWnKIGWlo50E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5e2c2a-f5f3-4fcf-0619-08dd5014d62d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:07:38.2820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46uVDm35VFKz6ocQAH/k34i4KjMUQGAts1bgW4/16xYcA+3JuncTrrHsU8GqNGrkaYOyp3mcLTQwo1t/G9URtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6912
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

SCMI Performance domain management protocol is intended for performance
management of groups of devices or APs that run in the same performance
domain. The functionality provided by the callee-side can be used by
passing the corresponding message_id.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 06de4a601f8..34f272c448c 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1046,4 +1046,22 @@ struct scmi_pinctrl_config_set_out {
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
2.43.0

