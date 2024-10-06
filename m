Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7429FCFB424
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 09:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEDA988D08;
	Sun,  6 Oct 2024 11:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l0WOXLh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0152788D5B; Sun,  6 Oct 2024 11:39:52 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBE788936
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 11:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQ4V+mm6i6NQxDlwC+ewlGcjsJBTDncDti/7jjM6uzzQlsrqoAuUho8MTTQJ70ajwavRE/WjkkkG6hKA2CwRFYJ5TKfqg9Oceq/TGuHg+Th8a3JkbAordg/F+NKRM/pYDq5TsgdRqY27nKn5QVD/8IQf2JW78mj5X/BcvGWJtnIH2GkSPRxOha1RfcTr0TflcNVVri7jzmImKw6wlxx+k7wUrH2gq48o+saVxY7D27lBuRyvslB2m8e5Bhgnfn9WLs7D0eXFmPXUWj09HHhOasItK0muORcaXLaqOmpaFotAeJe5zhlkqdagv88KBh2gxIMP/x4SNqwDadKMMBYvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jInyi9Zr5QUUltFHzV0w40R9554luTWeNTsyIn1aLxk=;
 b=QLRQKOAm1/5nBXjbsZF5hiAqMBZ8uzm4ETrv3cKfZiaS8F2rTxDL6m0YShh+Rh+sc5dxm0GN0Sa/QQvZPsAD7bu2ji0+ly1M8LkkQYUsFGxOotQDcNiwXtcD7e5vPKk+YdZoF9IkdpUt+Lke0CHd9Dsc/hcZqMj764VxO+SRv61zejp3wXT2f0inyUMACdBGF9UREUVvjs7Hx5+EaUvYP23fLqG8z3yF3o2B93wVIa8YpIPpaAyfE9bKbWwZzSBLPqWhknZ31PIwISb8nSn+MhePUCuLp30VxW/kS+Rfdp22Vwt8o62njbViGgXV2L889ZR7J1FRK4rAQrbNUaYKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jInyi9Zr5QUUltFHzV0w40R9554luTWeNTsyIn1aLxk=;
 b=l0WOXLh/nwe/QseYueful9MrSFCltaoqLubR/buas55Q2YcOf+seo3yYUWwpnCf/X3+LmM+EPVXI4P+7GSJ067XaGVjz1lKZNX0WaKmmJ5+ENJEqRt3kA3NEFAPpZlKENTUNBF/ZtOXLtZUEbaYHPKXNMolqsSgwFDkaFxb68EldtnXHtHH5KMoSxGbqAi7BGsIKKS3IeBoHrJCBuM5ERvhhdShG8oSbeQDre6dc9FmWsI2EJa63v+y0imhdZroaD9aNwStkVQ7UxBmkmEtF3TzT7PnvMfMGFUr76Fmvd0uskoTBNWqbwzv815RSeoFffD6YtXKucfXRb9yp2jtttg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7670.eurprd04.prod.outlook.com (2603:10a6:20b:297::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sun, 6 Oct
 2024 09:39:42 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 09:39:41 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: lukma@denx.de, seanga2@gmail.com, trini@konsulko.com, peng.fan@nxp.com,
 ye.li@nxp.com, alice.guo@nxp.com, etienne.carriere@foss.st.com,
 akashi.tkhro@gmail.com, Ranjani.Vaidyanathan@nxp.com, festevam@gmail.com,
 marex@denx.de
Subject: [PATCH 2/4] scmi_protocols: Update parent clock set ID
Date: Sun,  6 Oct 2024 17:38:23 +0800
Message-Id: <20241006093825.2800013-2-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241006093825.2800013-1-alice.guo@oss.nxp.com>
References: <20241006093825.2800013-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: ead76f29-084b-422c-1a39-08dce5eacdaa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V/nlLt50ujVjT6NiH5jHSGnyHJZS9qHsNIE0dCN2roGterVIS9ABGthivOli?=
 =?us-ascii?Q?a5sWubXf8dJCEawpE6NOxtzMMz4Cuw0SJ1gPBBm5yD0g413EnyR3SYBct01X?=
 =?us-ascii?Q?t/XpMp6y855Tzh8HW0ytF8lXojVPLmFKB7MDbT4BqOC7EdcQ4nZrNgrh/r2Z?=
 =?us-ascii?Q?JjGNX9f6sby3Eg9GSy89c1IDgNQMZ9NsfSgBIGnAy+0zMHlgb6GM/90D3v6y?=
 =?us-ascii?Q?27WLm2JkEtPd7Mc6/qJ3ctQ46u+pFlQlGcpI0YK8P2KxP6FJkq7sGlLJYEJs?=
 =?us-ascii?Q?QRtWJvTV3zLKTFwb44gyQ+dFTTHnRkdz3rJmn0nJzJEWfMYcM/668mmMOB6i?=
 =?us-ascii?Q?1kUyd8TjNDyJAvMPkClFeGaH5YuURMmKCtA6eoNWdFVPq25cXQr3p280K15o?=
 =?us-ascii?Q?9m3ePCghDvHfQX20bIA8Jf1+GEcsUGSquiwr5wyZEmpqga0GUKrAs+ONw4GR?=
 =?us-ascii?Q?KZFCgZxGAdRFKLc3Y7fjNz60/yd+CgjZp91YJ1pYpmILVJkngVi/kLPnBcoy?=
 =?us-ascii?Q?oXqBfCbuQJSNkAbCMXKY0CT7VNxCKaWoCNnEbz8oN9iaHPTVteaf97rEOJ9/?=
 =?us-ascii?Q?RfxScXvyM6pNI2s4S9RweglN4yEtFqAIDZBMD0Q3c1SaWgpzPPI+q14EcGfZ?=
 =?us-ascii?Q?JEXY/IZ1AnNOJXGEV3yP5oIhO4wXYvP0YK6jOLKTzV87EIqytMyoilT37egU?=
 =?us-ascii?Q?8ug9O1kLExEBTUta8RDkyuKDSmSaiwYhupPbjFLeH/WVnDUBX2anzwI4zz/U?=
 =?us-ascii?Q?TedIcLKEu3bx3jyeR9nDpreaUd5GEXdnPxUwMMtjo05HTA1QheZUEsW4pf3y?=
 =?us-ascii?Q?fvSk8WpCnJpRIoi0ZuFjyJ7x1HozQ5JQf//cjNeP7U1OzuUNRulK0FDO68qw?=
 =?us-ascii?Q?dVmVB7eqJxOLGEB6hy7H35cOxpip5VV2KxGq4zA8fRRHOQlBwPD4dytpbnbC?=
 =?us-ascii?Q?UgVahsDKQgVG9N+iAtSlp+0N49LBZAbjtL28jDcQGHEBZzbMJQ1oBFPfNHyi?=
 =?us-ascii?Q?01iFPywITom+klPqL7IKRNTK/J3kaGsStUwVfm9af8TFbDu5kWzCB4TF4L7c?=
 =?us-ascii?Q?6eCpR0WV+q4K0HJ+VytxDrkp1eKAfSw15GJFd9OQNfDK22Wn5kNOAPALGMH6?=
 =?us-ascii?Q?7tWi85vv8wVsbqUv7JnJP/FvlHHDOeieYQM4XHSiWaYEs/E42jlk/QMfgXHO?=
 =?us-ascii?Q?TGTGHqKKt5IhtmGuPLzGXWRlj9NpnwBot9XpDxxLO0qYOMAHqPEYVTa3Hg85?=
 =?us-ascii?Q?1QW8tA+eoj3M1F0NHpLDcWP2rkVPYO81BD4vdqulTqDYkyiS5v9XaIpcBIZy?=
 =?us-ascii?Q?AjkA0RVApPFbvXna0V6KubJTolsu5ysKfqUo9mR2Nn5mKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zF9XC7LdRvnBNTvEJPlINE9HTUyBTumVxKRgMRnB+gL0mjIY7phOOrPYFjQo?=
 =?us-ascii?Q?WesKRQhOL3n4RnzYU8x0/fvV730T0Cjq5+lCd4QhAsYHNLmFIYA9rafadTZH?=
 =?us-ascii?Q?R7bmFbN61cc07brms9K5krlPAswrgBQ8hOCbG45zHv3gNbnv/o3j5WWr14Sl?=
 =?us-ascii?Q?5Moi4ycVw05oqJcknIfqmBob6ZEoB66vGLFrACe5wPaellqmawVKggfBPLzx?=
 =?us-ascii?Q?MXLsIHpLKRLz07eHW0AIrjK3CNj0WTiaIj0E4VXSf+YpTh3ZGAO2t1MQtImA?=
 =?us-ascii?Q?Anv6A+I9t+D/B2JoENUKl9TwMsNxtdI9RHhXLKaQEwHzqI7y5mJ34aHEDtT+?=
 =?us-ascii?Q?wyG9nX4Mfp+dhgy4o9Unjde9gx3as9hZqkj0t/8Xyv8wuMGy4Y47cHpM7GgO?=
 =?us-ascii?Q?3RnL005Tw3FY0STSSvezGJh8y3mc9DDS/vSUwporeCu07aJz54+gGx3LcLsz?=
 =?us-ascii?Q?Sv1UpqZLuPWhZoWeOFQi3FoFE/vVqSx1/+hK4WdSrkIMrpqE8+gf0rRZEpFi?=
 =?us-ascii?Q?B3csbG1wHRjqtJZXp4afSxkXP8BZ49SFu70X8G1L5IyNPNtDTAQkfsAkOANa?=
 =?us-ascii?Q?SQ2j0geuzy2e3cYIOd2SYJKZS3XU0YumDWpquNFDg22uiV4x/HvP0z9gh6oL?=
 =?us-ascii?Q?59d40E0XbOemDQU+E5R8zjjad/9/aN7SpRauCENq2XWEmJTG/W4r3QHBBYqz?=
 =?us-ascii?Q?bwLcKAyLzUVR3xBP+wzuLanUnJjwUExPO5pKzyMapN3DIdwE/F3qsWtwRXui?=
 =?us-ascii?Q?HfBAbJaA4kp1qWkpDG8gPGcTT6F3+EE7LuMpKNq3PV8HwDl7gbe/oOn48Xth?=
 =?us-ascii?Q?we1t6iwJi+nLRXnuXTKvXOGa33D5Kb9jmoDtY2G1QLoF1Mh18Zn9gOU/Eper?=
 =?us-ascii?Q?+xbBrI9bDyDfDdvjm2SPywFniq9U69FU0T55XsQAYsMYzVENBPymUi9/W+bK?=
 =?us-ascii?Q?TbrXJwoO8+QMSdWIqkOcwADWMNPsxWOks8RUgHC2Hwi65zhkw1aUpfJFjmS2?=
 =?us-ascii?Q?Z8qVcqkimamI7abZ+C83xrxEtE0Nz9Y4pL8s/5Oe76e8CCA6+khQbTPC9xE4?=
 =?us-ascii?Q?Bmx4m1hg0SipEbCPKZy9SCbItrFcsO+XjlY6HP5It4NMksETZpjBearyGdxV?=
 =?us-ascii?Q?Nm0CxTIZ3k1MDGUlDgxYQvwONeu+UtWTDXNp57/fCMSbZt7MhDtvOqDfcySj?=
 =?us-ascii?Q?bCGVmdn+hbPph3W6LLJwdOelcUwvg9Hynpr/0bOEDJqbigoXeO45j8uG7FKW?=
 =?us-ascii?Q?qU3Qn90duxgwrSyUuHXwl9d9FVVbAVA2fwPQHvQ1R4F3xohwMo7PlddqB6Z4?=
 =?us-ascii?Q?Za2KTNpqDgOtr9iUr51pHbl3UYMWfuzKnoaw/+0mYEyt6AOq1hqsYCTRIDyT?=
 =?us-ascii?Q?BjajG9LlNPNaF3P1BtHuRnIBNPul5XqOKPHtCN1TTOe0XMDRlVphziW4iuXq?=
 =?us-ascii?Q?u0qqwgVNJrEUhILiKo+V+DTFyLujomzt+LlAoUl8vzzFGSgjiuGQF8aHEbNl?=
 =?us-ascii?Q?yYz9a1QZ4YBltOp6M7rqFWSXJkTaB4UViRtMfo1Fv1xYHiAjsd0TjL0/1Ct0?=
 =?us-ascii?Q?zGksmPvtpELwSPwCEYdeUdeyzNhPMLFBfgC2TZZZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead76f29-084b-422c-1a39-08dce5eacdaa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 09:39:41.9056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLg0kaic4UtoZEoGcjepEIda+LyV7EXJriFbev+DDQcBF+7lsmIPH7C3xu8YtBwooONNh5MKxCxGHoVRsAB9Pw==
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

From: Ye Li <ye.li@nxp.com>

According to SCMI v3.2, switch to use 0xD for parent clock set.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 include/scmi_protocols.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index e1e4117e11..36e46f4072 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -732,7 +732,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
-	SCMI_CLOCK_PARENT_SET = 0x10
+	SCMI_CLOCK_PARENT_SET = 0xD
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
-- 
2.34.1

