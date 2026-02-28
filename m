Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46811048922
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 01:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A18A583E81;
	Sat, 28 Feb 2026 02:42:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="km0J9j4x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5C8801BE; Sat, 28 Feb 2026 02:42:50 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB2B283E81
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 02:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4U2BPM0JcwM5oNizFcVVQgomhPZQ2zxB+DAFPm7neVspMxk/YjuvfId5GbiakBF1TFKZNYqQRqpL8awMCYicCfGLy7++I96QpsKQFoMme0Bfa8Tkk37QhrQzUUNG3RVLR88LDZZDuSxSuOcI+BjNt7gSsta1yXKg2jyagruUqi/1ITujyKdZjChxB1sBBcn1Se+cRZdJyvpa6c8jvGE8K2pao10XE94xXzfRdNLFqw6ntjd+3Q90T/IoWg3HMssRKDiUHs6EteQ3pUrmPMy7UUrzwuaOkPgZcpALlUeQugf6ra7PfHMsgPJjDF1a5MsMBIptrNJXQo+d9Bhp1/NlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ih/rtWFpWo+qG+5Gc0VXIZ+VOAtxeN5Oq0dAVhf20Hw=;
 b=yZ5/fdKz6HW55qAE4ssz3D+EozIJhYyONy2UNd8XN629sST3pvxXDBkaUQ+ok3wZyZfXIY9KtGc7zuqsUlu9NX+dUKgidzrtsyMqNSA+DTfCM9lYGt0MtlgON8YNzAzwFA7o5Nt19fzsNA6vlv3VnC5zHmmpsdNTcEfAqBplfDu+rxdRRndYLwm/6CZuappfaRmbhbPTRWyCqE8hUChEIsSzY5FNIOT4B6Pwst5F9GIHm+uGHzicRv4IgvLA+cDbWxFrMytJ//Va39FT4MWJxB1sX0bKKG36ws2WBAtcRG/RqoBZBBerwXwGgPOXs7jkbU4CFzJSn7vCNTR2AT197g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih/rtWFpWo+qG+5Gc0VXIZ+VOAtxeN5Oq0dAVhf20Hw=;
 b=km0J9j4xmbIbQIR1Xae3z2Ka2nMSfj5gK3rtgUTaXKHXIgZmdyEEDbCdtgDJrDXeXQednCSLMKJXKh7NaeRnbgEWeX3k22rscqoNxVEWm3yyMpXbSVG1ldBHS71lTIfFiwPHa/HZESHWTLKM1LJaCCTjLOkUUFIupV6Lu0uyKht3YX7DzY6uIudQp2xThZif9BaINQ2k1szSZTzmV0Bta40KV5vA5kfOthp4ssgqnhmzSwBoiNpRasHTJ5klk60UzXxjVS/IbUw8QIqy6e+sKaAY6R1DZg+7fxxTQq9eed65MTWF4Pz3Lwl0dSIxauUV5BfVr3TueHBWiYKesP1ofg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by MI3PR04MB12440.eurprd04.prod.outlook.com (2603:10a6:290:75::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 01:42:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 01:42:46 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 28 Feb 2026 08:22:19 +0800
Subject: [PATCH v2 01/13] imx9: scmi: Get DDR size through SM SCMI API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-imx952-v1-1-0a360e7e8cb7@nxp.com>
References: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
In-Reply-To: <20260228-imx952-v1-0-0a360e7e8cb7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Jindong Yue <jindong.yue@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|MI3PR04MB12440:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1a61b7-090e-400b-ed81-08de766aac05
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: 0czuTRo7xUSjdfYSDuIY7wB4sdtn+eGX1BWZkG64nkhEAGW3cWxvh2bl8fyjdo8Ri8lQZPxGg4gZE/P3GEYI3ajmDyeJB0DnKZmzKrI8EyDXfajHkTwxzY5fOtBpYB9FxyYG0tpgUVyHmAn+Vouyc9gOYY7eh+W1IvkqMHfVTAvN8nk6L9wiFqCs8lfs1IAKQqZo1W0h7njka9xp6Y9VizSYymEYmK2Khq+ZhrGpOBzHFXUXbb5swNhqFSASReBhWwpIp2VkGj4vNtGhmAMqmlE35YvM+G51Iq3GilgEvqJU/z5OmI0lbRps00Bdw41YyKmtnQcKpnVzjwS4qeaIJQCAytAoxO74azlmPuWk4xMzHRGQtsvPPP9e5u8duF26HfR4XhZfY2hHCLsFxCy3OmJ4fsWsokFZQ5jr95pZe/kBg0Q6kXny74OlTZvA+UZM6YmwdunbrYAAqyQfULCdB9JwtbPV8YEnejDsJTya6MirNAWqB9NziyY0LtKQ8xOEhitpV9f2AqKi5KqZqwIf33aKrUV+KqqosZ1LwNEdWbOK+rE9ieOG/oiK4mRklMIXq+xwry8NBX6gWfVqhp0BDHJ38SyWfFzRArf+nW20mW3E2NKOmx2hqah+clod9AIbLZctBdSvs02zjMD5FU16VzdL+oiAdXt/PbIcFaDGL1MCuW86924Or09tAoSeQJ/azUGE7/1DajboIzZkn3wwdz3CysWlQlM6LkTP14bXczjPnlN5quBrwrOd30wKGDfPAfSLgE4zLmlZaIF4jKLi4QACtmesRCQ42pd8lqmE4+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU8xTU5GTmZNbk1mSXNQQXRkSXhyY21wMkdFNG93UjJjYW8wSG9UYTVUTlUz?=
 =?utf-8?B?UWUzMGdkdTV4TmhhdFczVmVQTWd4UjB3NVBlLytZQXBHNXRtejdzL1hGMmxv?=
 =?utf-8?B?blUxMmFqVUZBYWZZcm41d3d1M1d3QUpCb2pibUdOZkhqQk1MWFc5ZUIzSHhy?=
 =?utf-8?B?Q01RenU1Vm1oTEpybjJFWmlaU3ZER3FWNnNJV0xrZXNXNm9ZZDZCZWhKbDVp?=
 =?utf-8?B?M3dzSWh2TkdDMTVWRWQrOGdkVmZ3SGVlQnppWE9JQ0sza0hJcVluZkZRQlFL?=
 =?utf-8?B?RjNSTkFkamo0dXcxM0JtQzkwY2I3UGkzb1NDb3lDbVJCdWhaRW9SUEFRQjcz?=
 =?utf-8?B?TDlZbmM3OTI4aFU2SGF4YWdUSjhFUVhIazJVVWVuUnpMZVhtcGlTREtib0Ra?=
 =?utf-8?B?WGU3VkwwRWcxZU8wWWdlUWh2TmV2bTVPeCs4TXFQTzdwRythdk1PMk1ONFU0?=
 =?utf-8?B?RGcyYnFHcmlDZEsvaVY0eG5wVXlHUmVyTUZRSzFXTERZa05JNFgvaW1lYS8y?=
 =?utf-8?B?V1YvSnFBaFkzNVZDRzlwZGFtNkFUeW12YW9KUGtKNkptd0VMbDB4dG9iYkJD?=
 =?utf-8?B?WC8zdi9RNEdMclA0QnlkQkdIUXozUFllK3k5eUJqaDBmcFEvWXNLQWJWL2pw?=
 =?utf-8?B?VllOY2FBcnlUaWRhOUkwU1RJd1hIT3JibFRoVTdHVWJleHhnY3NMcjdvZDlS?=
 =?utf-8?B?dVl2VGxZelVielZncXl6RmVhTC9QYWtsQ0VNemNvTnlIWlR2UVcySzMwTmJ2?=
 =?utf-8?B?Qm4zYW1JSmR0dEd6akNVYVZwci92WURoRzRaTEZOcXlLeXN6UG93OHd6WjRr?=
 =?utf-8?B?aUlrRFhYcDRtR2swMElDd3c4T1FQQ01Pd3VOUUFQY2JQS0pTZGxwNmlVREN6?=
 =?utf-8?B?ZkR4ZGcxZWMxUEZmaWZZVEFmWDdNNi9YMFFKcCtjWE95a2hVN0N5U1RPRTl3?=
 =?utf-8?B?Wm9OdUJjU0kvQnZRRW50YmRtcWVUVG5uSUQwdW5UNkxOczlxdVNjaThtN240?=
 =?utf-8?B?bGpsa05sOE5ldmFzWkN2K250eWc1UDVuUVFob0NxdEx6dndHUTVndVFwQ3l5?=
 =?utf-8?B?NjJ2TUxXbXZBQnhVdlpTbW43TGVrUDh1Q0FHRUpFRnhSazkzQ3dEc3FMZ1dQ?=
 =?utf-8?B?ZXBMR1hPWHpsU0U5N3BVUjY3eDZYNEVKUW1DY3BkNmZlZy9RTDc4MHQ5dWs4?=
 =?utf-8?B?RW9mRDBHckgzeGtwSWpIbVRJdm1IL0xKNjZsQ2w4ZWdqVUE2R1pROU5VUWhJ?=
 =?utf-8?B?ZkRMYm5PMGRtVStzY1pieHVDbThxelUrdmVRT05NcWZheWZnUS9FVmhlNGQr?=
 =?utf-8?B?cHlLektNaUpyb3A5UlErYTVsdHBnd3h4Qi9HRHh3NmVSNnRpR1JXUGs2SDBB?=
 =?utf-8?B?VFdNa2V6VjdTanN5MjhWY3BYbnBaSFYvQkgyemJscm14clhvcmRYZjFFSmZJ?=
 =?utf-8?B?Lzc0cE52aXdZTllHWVZJcHQzUGhmSmk1Tm5QMkNrT1IyYnA3a0haeUhWRkhC?=
 =?utf-8?B?MTBWQjBlUWoyV0tYSG9FY1F4KzVNRlFwVEpIWFVIS3pjb3gxamlzaFM0RERF?=
 =?utf-8?B?akVoMjVZV2M5eitGTm1ORnFodStuNmNpbkxUSXZJU3g4Y3J2MzhjNXFhWmJF?=
 =?utf-8?B?emJjc2poQVNHdEhkaFk4SmJ6d1RVZUVzRnhKOXdVYUg3eE9vNHRaQ3pHV0xv?=
 =?utf-8?B?MXcxMnYzSWhxSUxLWlhjUjgvcktzbGZpSmxvT0lvSG5kaWJwWW9IZEtGMlky?=
 =?utf-8?B?Q2s3aDdTTDRIYXNMQXpRSlBLRDl4cWE3NTJuMFdyTTl6WC9nUG5VZXN2eFdS?=
 =?utf-8?B?eTViUTJhS3d2bVl4cnhVd2ZheGpwck1FemZ2UEsvT01MTUdFT2FwaDNpSkVK?=
 =?utf-8?B?SHZieW9PbHplcFJGemNpQlVCMy9YZExDM3Yyekt1NWJob1ZhK3RMWnVpb3hJ?=
 =?utf-8?B?cFF5V0UwUHZaRlg4TW9PZmJ6aGVlOU9SWlRJczZGNDRUNWh1Y3c1QkFqWW04?=
 =?utf-8?B?L1k0UG1Ta2VYQWMrdWlvbVR3bDUwSjhiemR4cVU5Y1Bwd3FLMHZ4SjdkQitJ?=
 =?utf-8?B?RWpzQi9KL3ovdEJlZ0pKVlVEM05pYlhWS01FZ3RVZWdsL25tVzFhTFA1L1Np?=
 =?utf-8?B?OHBUdEI4V3Y4V2kzMFY3QnQ2RFIzeDBIY1Y4eFFyVlBmMlNJcUJ0eHNvcVhy?=
 =?utf-8?B?Q3VkQ3hHRjdZRHNFOW5jUlg3UnMzNWxXUEFkRFV4dlNrazBhTGRwSlh1bHk4?=
 =?utf-8?B?Z01mclRLcTVadXU5ZDNIbTMrMlZUdEdmQXVJMU9UdU1uckwrS0IwbVJLa2pz?=
 =?utf-8?B?Rk41R1FWTTJ4d2h0MkJhenVsQk5ndytKcEpSOXBRcHdZU0QvenU1UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1a61b7-090e-400b-ed81-08de766aac05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 01:42:45.9273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qN6fHaXlF1R8UrXDclElSEA6K5ZhkQppgLBf45ZntsmW1+l8+/GppUH+l9Zl1NyVdciCk51Z1SIU/aubua8dWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12440
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

System Manager(SM) has implemented the MISC protocol to retrieve DDR
information. Using this API, U-Boot can obtain the DDR size dynamically
instead of relying on static configuration macros.

This change addresses the DDR ECC enabled case, where 1/8 of the total
DDR size is reserved for ECC data. The scmi_misc_ddrinfo() returns the
DDR size with EEC overhead already deducted.

Implementation details:
- Query the DDR size via scmi_misc_ddrinfo()
- Replace direct REG_DDR_CS[0,1]_BNDS register reads with SCMI call
- Switch from PHYS_SDRAM[x]_SIZE macros to runtime detection
- Secure memory size is set to 2GB (0x80000000)
- For backward compatibility with older SM firmware, fall back to
  static PHYS_SDRAM[x]_SIZE configuration if the SCMI call fails

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/mach-imx/sys_proto.h | 37 +++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c         | 75 +++++++++++++++++++++++++------
 include/scmi_protocols.h                  |  3 +-
 3 files changed, 100 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 46da7a1eff5..13857b921a0 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -254,6 +254,43 @@ struct scmi_rom_passover_get_out {
 	u32 passover[(sizeof(rom_passover_t) + 8) / 4];
 };
 
+/**
+ * struct scmi_ddr_info_out - Get DDR memory region info
+ * @status: Error code
+ * @attributes: Region attributes:
+ *              Bit[31] ECC enable.
+ *              Set to 1 if ECC enabled.
+ *              Set to 0 if ECC disabled or not configured.
+ *              Bits[30:18] Reserved, must be zero.
+ *              Bits[17:16] Number of DDR memory regions.
+ *              Bits[15:11] Reserved, must be zero.
+ *              Bits[10:8] Width.
+ *              Bus width is 16 << this field.
+ *              So 0=16, 1=32, 2=64, etc.
+ *              Bits[7:5] Reserved, must be zero.
+ *              Bits[4:0] DDR type.
+ *              Set to 0 if LPDDR5.
+ *              Set to 1 if LPDDR5X.
+ *              Set to 2 if LPDDR4.
+ *              Set to 3 if LPDDR4X
+ * @mts: DDR speed in megatransfers per second
+ * @startlow: The lower 32 bits of the physical start address of the region
+ * @starthigh: The upper 32 bits of the physical start address of the region
+ * @endlow: The lower 32 bits of the physical end address of the region. This
+ *          excludes any DDR used to store ECC data
+ * @endhigh: The upper 32 bits of the physical end address of the region. This
+ *           excludes any DDR used to store ECC data
+ */
+struct scmi_ddr_info_out {
+	s32 status;
+	u32 attributes;
+	u32 mts;
+	u32 startlow;
+	u32 starthigh;
+	u32 endlow;
+	u32 endhigh;
+};
+
 #endif
 
 /* For i.MX ULP */
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index c1458ccca3c..2ac2a93e796 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -58,6 +58,34 @@ uint32_t scmi_get_rom_data(rom_passover_t *rom_data)
 	return 0;
 }
 
+int scmi_misc_ddrinfo(u32 ddrc_id, struct scmi_ddr_info_out *out)
+{
+	u32 in = ddrc_id;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_IMX_MISC,
+		.message_id = SCMI_MISC_DDR_INFO_GET,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)out,
+		.out_msg_sz = sizeof(*out),
+	};
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret != 0 || out->status != 0) {
+		printf("Failed to get ddr cfg, scmi_err = %d\n",
+		       out->status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
 __weak int board_mmc_get_env_dev(int devno)
 {
@@ -335,25 +363,44 @@ void enable_caches(void)
 
 __weak int board_phys_sdram_size(phys_size_t *size)
 {
+	struct scmi_ddr_info_out ddr_info = {0};
+	int ret;
+	u32 ddrc_id = 0, ddrc_num = 1;
 	phys_size_t start, end;
-	phys_size_t val;
 
 	if (!size)
 		return -EINVAL;
 
-	val = readl(REG_DDR_CS0_BNDS);
-	start = (val >> 16) << 24;
-	end   = (val & 0xFFFF);
-	end   = end ? end + 1 : 0;
-	end   = end << 24;
-	*size = end - start;
-
-	val = readl(REG_DDR_CS1_BNDS);
-	start = (val >> 16) << 24;
-	end   = (val & 0xFFFF);
-	end   = end ? end + 1 : 0;
-	end   = end << 24;
-	*size += end - start;
+	*size = 0;
+	do {
+		ret = scmi_misc_ddrinfo(ddrc_id++, &ddr_info);
+		if (ret) {
+			/* if get DDR info failed, fall to default config */
+			*size = PHYS_SDRAM_SIZE;
+#ifdef PHYS_SDRAM_2_SIZE
+			*size += PHYS_SDRAM_2_SIZE;
+#endif
+			return 0;
+		} else {
+			ddrc_num = ((ddr_info.attributes >> 16) & 0x3);
+			start = ddr_info.starthigh;
+			start <<= 32;
+			start += ddr_info.startlow;
+
+			end = ddr_info.endhigh;
+			end <<= 32;
+			end += ddr_info.endlow;
+
+			*size += end + 1 - start;
+
+			debug("ddr info attr 0x%x, start 0x%x 0x%x, end 0x%x 0x%x, mts %u\n",
+			      ddr_info.attributes, ddr_info.starthigh, ddr_info.startlow,
+			      ddr_info.endhigh, ddr_info.endlow, ddr_info.mts);
+		}
+	} while (ddrc_id < ddrc_num);
+
+	/* SM reports total DDR size, need remove secure memory */
+	*size -= PHYS_SDRAM - 0x80000000;
 
 	return 0;
 }
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index ecab021b472..555ffa0a61b 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -54,7 +54,8 @@ enum scmi_discovery_id {
 };
 
 enum scmi_imx_misc_message_id {
-	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7,
+	SCMI_MISC_DDR_INFO_GET = 0x22,
 };
 
 /*

-- 
2.43.0

