Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2A8E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 07:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BFFC8072F;
	Tue,  7 Jan 2025 07:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GV0qmcDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4348580609; Tue,  7 Jan 2025 07:59:48 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE9D80690
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=um+LpBCGVSQxhd5NyPoHSxKGR9aR2YgBykY3Iy32SSAzl3YBoelF+wooc6exa4rjGsSaogU/pv+UEl6Y9hXCh8khHrtEqgrfByaw/ZWQv5ujz2gmTB6YCdTe1cUifuKkvYgbhFlKOiWIttlsLLoN6b4KAMeza31wFEF/BOVaCfFDBssK9D2PO34CvJObG2IzgQ825VJaLZZxMfELewbBMIxoukZ0ocM+OBMywjgIDigbNFtFO6xokCaqYXtlAZdLpQNBK0P2pjE9RuQqmt1bibXoFZ6Xih3zar3hnuQJYmE10D3hy6aaNSU/HWlbbd2v4UObDT0U7Razv2tjs1mypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTb+kSeGKDT4vK6FTZOlVglI7ToUOWTKnAL9mF4UjFw=;
 b=YxuDWSoyPQssvl5Y5aLBMKb46PjB3UekpAAXFGerFPcbh1ykxB4MAmSZ6JZvtPLRfQkoKip5lW+NjNUSub0wq4xg6+04KuREQYSUeFqO50cxRUPjVWKBOS/0Em2REJtA7aVm17idEc9eLk1ndBHU0i3+D/Hi9g+h4Cs30goLV7E2FXWwYFHNHAGYd2u7DMYCNioKw5Mbu9MPFIG+hNblMQIOqjTr7le2/XHC04YFY1UqriG8e4pU0LClJozTPkPS0lZhKLNod+a++kOHgUL9rx3VGJPvQTeRvl7xZsGm+j+v1u89UnYDUYgA/rtxzgo2BkE/wbe2N6rDbG3ln+TNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTb+kSeGKDT4vK6FTZOlVglI7ToUOWTKnAL9mF4UjFw=;
 b=GV0qmcDffVixAM6oxAXtzBpHeDm/LIyhrvWbY/Jgz3nBEK22YUwQueqbqui2YVjyz5zlrlyUk8VuplaXZ5pWeUX595N3ZSWKnQ2oOpnahLevAQloM2ODlPHQNPIImU459u6iAjbcDwvEwAeEUob0LoleZJGWCyLnZJyD5aas+nxxtODVmJTWJ7KyC0R4l3lGV+OQuKA1NmmTnxBpOJbaSgzMEdzOb2mlx8PZy8SjQkRQeBWGPgY9AF5p0ZG1fDa/okZ/sEee9fUS5q+gj1PPPKNShPjyhdCqHcH9olsWh0bvedYKeUVaf5pkt7jiuUKw2UbSpd16beVt40708OtyPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:15 +0800
Subject: [PATCH v2 15/16] imx: imx8mq_evk: Switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-15-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c293871-c64e-45bb-284d-08dd2ee8d9dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU0zcHd1TGZVMklNMTJhUEFmYklneWZwNFdjMjNFR3BUOXg1UTR5TnhJeXAy?=
 =?utf-8?B?bUVmQzIxM2ZuRzdNTzhMVWw3bFpxRkZaUzdHWm1WdlRGeU5oa3NRck5XUXd4?=
 =?utf-8?B?cGE4MmNaSDAzTm5TZ2dMY1BxazJ3V0pqNWZmSG8vWG5rVnpuQitCZTlmNTA2?=
 =?utf-8?B?ZXNIeEJDVkNBbHU2b0JrS1BIays1SnM4VlFCWWlZU0YzTDNxdVg3cUxEbzJJ?=
 =?utf-8?B?cWl5Z3k5TWlzaEZUUW5ZanNKME9sZURFSFdSbGtjakVpYzlVSmVmRENwWVRC?=
 =?utf-8?B?eFNjeEd6OVNnZWhaSVNjUGQ4WTdWR3IzN296Yi84YkVINEY2Ym9RK3lEZ2t6?=
 =?utf-8?B?MHp6dlRsejRGWk90M0U2VE5XN1JkdkNmdW1lOFBJaGFUL1k0RVc1SDQ4VGND?=
 =?utf-8?B?SC80dE1sdVBKYks3cVBycGh2K1o3OURSVWNUQ0ljeldVTkw1RHBCUk9yTmxU?=
 =?utf-8?B?bGVPdmJrNTNvRFNSWWowM3VWSTIvT2Zxc0g1RGZXRjE5VzN5SGU4ZEhyRFhK?=
 =?utf-8?B?UXJ3TDNBaXJpQ2wwSXMxd2hWZDdSdk4xYnE5eW0vUUY5MklRZVZZL3ByMDlI?=
 =?utf-8?B?V0F5NnBuelVBTFRpdWZpWFRSMlVnd0FHVkg4cVo0S00vZWtodHNnU2tBUENN?=
 =?utf-8?B?QVMzMUJzd0U0eTd2Zjd5Uk1YclhtOHN3WWlqU2xpQXhudDdZMVRQNlIxT0tn?=
 =?utf-8?B?LzNnY0kraW43NjN4aHpBdkhCbE9vZHIwM1dJYzBoeFV0QTlaYUhKazFjSzNP?=
 =?utf-8?B?RjYrM2p4UWlORHdsUC9KRUxBMkVSb2dSTkg2Q2piL1piWVJWSU1uZktrSlpL?=
 =?utf-8?B?dlBialArbzJqR3RKbkhSR3JIdzZwOW5lNVBEVG5KRUNCV2pFZFM2Mms4MVNM?=
 =?utf-8?B?eFZ3bVVNUmZUOFl6cHcwb05IaTkrL1ZxcVNZQUtVR3NHQ1ZBQ3NleDhQbnRX?=
 =?utf-8?B?eHcrZ0hYZWhjVGtzWHd0Q21UdkE0c1V1MFJSTkNyOExqRFZHakc2Q0w4TGdl?=
 =?utf-8?B?bnQ5UVJ6QVNpWDR2ZFZBUVBHaWM3T0djY0tzeE9vYjM4YmdLNUN0cW54U013?=
 =?utf-8?B?YkF6YzJhekVXU2hmNlU0NlNVOFFzMmwrUXJDOTYvQUdSR1htRzFPKyttVmZI?=
 =?utf-8?B?eXluNGpRWkIvZmdUZ1lxOHpSSVY1c3R1Q2k3UlB1KzRDODloeG1KTEJvaEhE?=
 =?utf-8?B?RW5JYU1WQ29sTVZBMjRSc1dyaUdzOXlvZEYzMWZhOVBJeXc5SGsxSzBGdVNT?=
 =?utf-8?B?dWZWK1VVN3oxbU82em1oY3kveC92b0FZMUxkWlVNQnphbW9rbkRzc09nM2JJ?=
 =?utf-8?B?a1ZmekZ5bExsSUFxajNaUXN0QkMvemJCQU5xWVQrU2lBc2pJRHJwZ3JrZGtH?=
 =?utf-8?B?d3lDYW1ZeFdjd1psb3QrNksrVWJNUytrakZPOGRjUk5TcWp3VVRMcVNtWXBz?=
 =?utf-8?B?Z1hHTGkzVmZDVVZISkVBZXBETHh2aGZSTU1MbEpJb3BVUzY4VnhFZllWamtZ?=
 =?utf-8?B?VS9CcEUwUEpkZTBOZHBhdHBudHZOZjJMd0FmM2JqZy8zSHhuRkRXeHRScHky?=
 =?utf-8?B?dG9DaWdmdUE3NG83OGVEVGRuVlgzV3VhbGQ0ZFlFT3g4Wm5OaXlvWGNDQTdv?=
 =?utf-8?B?YStvVEMzSWN0VTQrMlVaUzduc1RMNUdRT2syWmhsU2p1VG5KS0piaGpxL2J6?=
 =?utf-8?B?TVlRbWJmWWdyQURpM0ZqSkl4clJPVTZhQTVRZnFZbmtmckxxUDhtUVpkKy81?=
 =?utf-8?B?ZUNaQU5RbW5jdFc4bVlYaHE0MkFvSFJFYjM2YnkxVFVlQkRHOW1Ybm5sYjJj?=
 =?utf-8?B?bFBPM3V6aExLbmhrRWdLUUZkTDFFSlBJRDhNdGEzczFqWEs1Y29HZzV3Uml4?=
 =?utf-8?B?MWNidi9tZFhicS8yZk9ocnQ5V2tRNEZYdU45Z2JUWUlrV0RKbVl4cytURGc2?=
 =?utf-8?Q?zhqkPF5lGElXgTHWL11JPpjUq9rldoLi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDYwTmM2dFQxcUV2T21rMTJvQ2VIWmEySFFIbCt0eE5ENzBiUlpIdkVIbks0?=
 =?utf-8?B?by9HeUFPTUJFLytTRldGQnEvREYrRUZvTnFCRFhBbi9VTzh6MXNMR2J4eHY3?=
 =?utf-8?B?MHZOTXVaU2NGOUxIVHRzMGk3aVZxaEVmakhlbkx1S0ZreE9CVkxQSjR6d2dP?=
 =?utf-8?B?SkIzekFWT24xNlhYY3FwdWV1MEloMkF0MHczWHF0SExYQnQ3bzg2TEd1UFhl?=
 =?utf-8?B?a2hiTmYvdkZkaUtHZld4cEdNcTg3ZWxWdkplby9QeFpVNE1IVVJaVzVoSG5C?=
 =?utf-8?B?eDEvbmxMbHU5QmMyKzMvYW5qMzZrMUZrUnlnM0JLaVhsSlpTaUJDM01MSmFF?=
 =?utf-8?B?emlxMkt2QjNvbmQyQWwrcWlrWmQvS3RUMytxSGN0WHZCeUhQSFo1dFRFNlh2?=
 =?utf-8?B?aUVSL0c3eFJGd1BFOXpWb1hTWVNreXIxSnovSjc4UEVTWFQ0eE5PZ05WdjJC?=
 =?utf-8?B?c0U2b3N3QURDMVduSGowNjF1R29jS2tyNDBUTHhZWmFNYWkvRXNxZ1JrUnFZ?=
 =?utf-8?B?ZEpMYzhWa1ltSjRRaXNLYTR5OGMrWEtPdFFsQmo2UFk2WEhhYTJ0VDNLUW1T?=
 =?utf-8?B?b1E3R2Q5T0VTNmh2ZWxUUFlJUTczQ3dPZ1pKNENMd1RWRS92YXVsZUxWSnYv?=
 =?utf-8?B?bXpPRy9ZZFVVRDh5dGJTZUJyUWs4OGQvazdWUTZUVnpMMVdzSjg0UE1odTBi?=
 =?utf-8?B?NU1zdUN6ZktxNDJtV2RtbC9NL1RWZ2t2elU1ajJTbWRwaCt1ck1sRXZWTHJh?=
 =?utf-8?B?NDNyTHoyd3pMdkZtZjBNa2xFZGFFeEIrZ1FnYk1OU21iTDZGR3cweHFVTjl2?=
 =?utf-8?B?RS8xbDQvMitOQUpDdkErdWlyVFoxSVlXSkFOMzlybS9rTDVJYUZuMFFEMlQz?=
 =?utf-8?B?S0RUVGU0ayt2THZ1Q3BtL01RN2RWWEszTUlrQnB5R2c3MjhnN2JySkJXL2Zr?=
 =?utf-8?B?UVNUdkw2NVlyMys1QkZzMjdRWVA2SEIySEFEV004aW5jVmdFRnBoUm9rekZP?=
 =?utf-8?B?YVJPTG5XMEJuVlJReTZWbjkxTUlRZjBMS3kzU1JWd0lRZ2xyREh0RlRnOEJp?=
 =?utf-8?B?bUxVSEJrR0ZxT0RDZXdETExmZitRWDhmZUI1VnhnQWtKK2dYb3JnRkxGRWNL?=
 =?utf-8?B?YTJpNVpEVm1HRGE4K2p2Z3pQZnVDMlRyZjRPN0FKeFV6S2o4V1pwMmx0S1Az?=
 =?utf-8?B?U2ZCaXoxVW56VW14VlBhNmpzbmFuU3pNUmw0cit3STVabjdtTVNyZzhReVo2?=
 =?utf-8?B?dDRZeUFwS1FxdzFPUERFcnBUQlc3TzBWQ0UzR3NlckdtUlpFVlJxcjZwdlha?=
 =?utf-8?B?VHVtYmNzcS8vNzF6cmxlSFRpSDZjQzlPbEtBa2t0dFNDNUJPdURQRXAvN0lB?=
 =?utf-8?B?YzY0ckhFb29LTnFhL3I0TVpvcHdHd1hXNmk5cWY5RGl5V0ZmZmpLbFhlM3FW?=
 =?utf-8?B?ZEhZZHAzMEVYcHpCNWFtQ3hlQ1lCRHovTEhueGpqQlJoL1hRT1U0c0hOelM1?=
 =?utf-8?B?VUF1SmxPVFRyZTdiWnNvZzBvSTdPUjczMmdSajNabHhIQ21yTFQwdWtFbnJz?=
 =?utf-8?B?MWxYZkhUTlZaNUtTREkxWHZBNzkzWHVUcXo3NFIwNjNuVDlNVVVJQUMrc3Vo?=
 =?utf-8?B?OENENTYwQjZvbXdheGZYaVJtYmNVVHcxQmZjMk5qZ2RzbVBldnE5UllFYUJR?=
 =?utf-8?B?STEwalV4d1ZUbWZpQnFTaUIra3doeE9zSTRyNVNEalpiMzRlZjYrNkNtTFlj?=
 =?utf-8?B?dWVSV3ltcis2ZDhOam0zUWZPSy8vNnBvYUZGcUxncnJ5bHRhNlVsdTgybHRC?=
 =?utf-8?B?MzhNV2VNWlZrYnovZDF4Vk54TEd2Zm5JNHNvKzFDTXlzRFJMTExHNWlER1BG?=
 =?utf-8?B?Q3Y4bWJySTBseURqMmRhMFBUVURyS0luUXlwbXlManhiWlhHU2twMmdXTW5M?=
 =?utf-8?B?dGtYcSs1dGp3MVJ4QjZLdWorM0VhQ1VZVDhPZmkvYVFzaW1ja0EzSTlUUk5G?=
 =?utf-8?B?RUZrbFA1eG5icWVFTzF0ZVFaS3VkQi9nVzJXVDVsZ1g5a0FNNzJkaGZMeTRC?=
 =?utf-8?B?TVI2SlFEd1Zzb1U5MjdyZDZYZW00TVlwUE9PNVBDRHZETmo5SXdTc3BxeWJL?=
 =?utf-8?Q?1x3nugVqmUbCpnNejJmhl+wnL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c293871-c64e-45bb-284d-08dd2ee8d9dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:38.0065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSBD7Js8cdfihHucgIImyFSkOLgZ9mbn9vBwknZQjq/C3/ITO273gnixmBHERTQzJggeMKJsSlkM4WoZHOD0hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10523
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

Move env to imx8mq_evk.env
Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig           |  2 ++
 board/freescale/imx8mq_evk/imx8mq_evk.env | 60 +++++++++++++++++++++++++++++++
 configs/imx8mq_evk_defconfig              |  3 +-
 include/configs/imx8mq_evk.h              | 22 ------------
 4 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 28be6a22bf07e1341ec841bace149cdbb871fac0..76a8be7798c5d80a0384b1f28b1f18eff7b34e43 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -54,6 +54,8 @@ config TARGET_IMX8MQ_EVK
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX8MQ_PHANBELL
 	bool "imx8mq_phanbell"
diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.env b/board/freescale/imx8mq_evk/imx8mq_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..dcfe1c2f2d4118e5af01078e2e4402f60c2b7f6a
--- /dev/null
+++ b/board/freescale/imx8mq_evk/imx8mq_evk.env
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_fdt=try
+boot_targets=mmc1 mmc2 dhcp
+bootm_size=0x10000000
+console=ttymxc0,115200
+fdt_addr_r=0x43000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+initrd_addr=0x43800000
+image=Image
+ip_dyn=yes
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+loadaddr=CONFIG_SYS_LOAD_ADDR
+mmcautodetect=yes
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+prepare_mcore=setenv mcore_clk clk-imx8mq.mcore_booted;
+scriptaddr=CONFIG_SYS_LOAD_ADDR
+
+mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+mmcboot=echo Booting from mmc ...;
+	run mmcargs;
+	if test ${boot_fdt} = yes || test ${boot_fdt} = try; then
+		if run loadfdt; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	else
+		echo wait for boot;
+	fi;
+netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	${get_cmd} ${loadaddr} ${image};
+	if test ${boot_fdt} = yes || test ${boot_fit} = try; then
+		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadimage; then
+			run mmcboot;
+		else
+			run netboot;
+		fi;
+	fi;
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index a3a2333c98268d17942cd76c654bad63406099a8..97ef352dfb866830b228e3e4ae77d78afe01ea8b 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -30,8 +30,9 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
 CONFIG_SYS_PBSIZE=1050
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
diff --git a/include/configs/imx8mq_evk.h b/include/configs/imx8mq_evk.h
index 666f46ac105be6a7828bf54c388afad14ee1d1cf..2a86240e2c6dbf3e86e626a2b4a2c1311c68e8a0 100644
--- a/include/configs/imx8mq_evk.h
+++ b/include/configs/imx8mq_evk.h
@@ -26,28 +26,6 @@
 #define CFG_FEC_MXC_PHYADDR          0
 #endif
 
-#define BOOT_TARGET_DEVICES(func) \
-       func(MMC, mmc, 0) \
-       func(MMC, mmc, 1) \
-       func(DHCP, dhcp, na)
-
-#include <config_distro_bootcmd.h>
-
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
-	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"console=ttymxc0,115200\0" \
-	"fdt_addr_r=0x43000000\0"			\
-	"boot_fdt=try\0" \
-	"fdtfile=imx8mq-evk.dtb\0" \
-	"initrd_addr=0x43800000\0"		\
-	"bootm_size=0x10000000\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000

-- 
2.35.3

