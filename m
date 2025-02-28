Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9459C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B85EF811B3;
	Fri, 28 Feb 2025 11:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YnHhZlgs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9EB0810FE; Fri, 28 Feb 2025 11:54:48 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B1E4807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UriLh4FXIsUpgKQVjVasr3yoWRKSa80JP0wtISflmdOXvKnMi6glfKzc93/7mC1OiLrVpJOg56cGz0Hjgl4XjNejkgKSBYD7dWbcRCbD2ZON5pKs1yCX4aqQQ4PIiPmpbIvcF/4BvOgXfyH4Md5brNhz37zVSfRoxzHfNyxBjBsSx8EqcZIcZMbOkG/l0gsZX26NCgV7dr5gx/SdFZEiZVnkapIFdILnHKOHbPmGtUeaMFH/B2uTY+pbZ+yaxVhg19lbYTuSh6uHnHOCSMbhM/z60UPzy9PJqU6p8XMjsTnd0Iu/BKrPniRCDO76LhqvVIIAGFGcnyd/BXAJjqKeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnN7BEcSzN3RyCsCKwdqxadyJYuFg5HITzY1SxKREC8=;
 b=GRa3sLkyi1agMUZPaCBZ9AVai/ibFrtjRevdjLcSVYEqo6WMPqtnkzMhAoCzxkVogmxr7p0LQTwj2XoSB8AjDCOJGrEqHyJq57hOXMDYiEzscfBaxy/Ym0zHkfGMlJsmv+1Fd4yHrJimaBfUBsAuwoyJO/3Vi19eAUEjg1jusDepD+HQtl4gmqe2uQgkIrYfK1MfCM0/MyEcSI8Pjn8icrF92Na4c1TszKLLuOCbCnc6+3SBjYsEECHEGiifeat6HX52I+98JPqPUUXshWg/O8DSL8crz5D0F5Ida3g+BN3+p5DXMPoObo0K/j9yHpqf6YYw+qczgz3FTyjTi/o38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnN7BEcSzN3RyCsCKwdqxadyJYuFg5HITzY1SxKREC8=;
 b=YnHhZlgsArh7ze3wRQTubaou2nP2WShEBpyNpd5xUHcWDb4Io+aefwxaFfJTiHkf+KRfgI2pYxb3P6RySNwFMkWYGND9Xp+Z4cRnN7S4GDkX3PRcHV0CVzcDoPB9cMO4po0QamrVb0nv/fxBMqMZVtffDhJjLIMWN4x39XQXRrKynGqoaXUOfnTuC8kJKuGaqIJLs+U1FRu/TveqLbLhPkeoZxMjv0C9nxj8cavTdK/a4/cgOfXnD09kq2Svwc96bqoMQpKxvLWU2OEyfziJdYXjNUENf2zHxcu3taCAycNMG1Hd5qAJHaiqBHnehVFsuLTy9WwKuWuCZCqHgmBKDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7116.eurprd04.prod.outlook.com (2603:10a6:10:127::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 10:54:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:54:44 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:53:54 +0800
Subject: [PATCH v6 03/20] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-3-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: b63f2728-07cb-473e-3238-08dd57e64fbc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czRjL1BoeVdkSzgwc2lvZlFUR2F1OFdPbCtxc0ZMb3Z1bVBOOGlkMi9KUlQx?=
 =?utf-8?B?L3JjVDhFMW9VVDFLVENaQnZqdFJkblRGUGNHTmswRE05SmhCT3RraGUvNkRD?=
 =?utf-8?B?c1hzbFZKZlJPU296NVpOOE5YUXZ1MytrWDYxRWdTMXcxQlA2SFVlUmNlY0FP?=
 =?utf-8?B?YkZKSFlDQWRaRGNZWEtzdU5ZMVZMZGRQUFpMd3JVeDVWZU1DQ0lOZmU5NmNJ?=
 =?utf-8?B?NVpUTXZkTUx6K0N0YXMrSHR0cWhFSit6UUpIdE81MjdOTlV4d3JxdWxLbkxQ?=
 =?utf-8?B?dXdGSDVtRzVGTkVjd1pvbmt2bFpic1JvSkROWDROTEJyYnpscWxsQXdReUpw?=
 =?utf-8?B?dlVXZExCeXlxanJwaDJMVkdmdzc2aTYrazNoeFhsUVVxTFFYbWtTTXFkeVpY?=
 =?utf-8?B?TmcrZmwzcGxST0RqSGR1OHIrSklyQnVGVkZoa29SMTRBQ2o4aCtwNjRaMWxR?=
 =?utf-8?B?RG83Z09XYkV4allSaGNPV0UwVlhBUEd6aFRaUWxKajJVRTNtYlpyaEE0WGtw?=
 =?utf-8?B?MUpEblR0eW9oK1hMRzNqOU5sN0NSZmlKcXZndXJnL3hvZ0lWM2gzZkFGZklG?=
 =?utf-8?B?ZURGTCtxeGxBd2JUSkIzU3M4QWNpU2gxQnMzLzJVN2YzZ1c2MnRFUGIrVkhn?=
 =?utf-8?B?a1BpaG1tTC9OU20yaFNmYnA5QkJjWGxpMEoxL1BSNjRnUVQ3S0N4V1BRY0pn?=
 =?utf-8?B?YStISFlKTC9WMXdJR1ZlT0lPNXEvdC9CSVB0WGpWRk9XQjNaR2l4eDF4bHBJ?=
 =?utf-8?B?TndoOU9sS3crVG1xNmNFcWtzMHRSQ2V4MTVXZUFjSG5KRytRdmJDbDNqanFP?=
 =?utf-8?B?ZU5Za2lHemhLYUtHb2p5YlFMRWpXZmJNMjF1aEZaOWQyaUhKTnhqaFNpTkFD?=
 =?utf-8?B?OCswYnVKM1VrZmhDZGc3cUhXQmdjN2FQN1lhT2dpTEVvN1hVb2FXYUtpNUlP?=
 =?utf-8?B?NFlXMHZ0N3h0YkxJVWx0M3p6SEgyaDRUZkMzd0tIMlhxdkJvd2JwdW01NTVu?=
 =?utf-8?B?TENteHVDdHc0aWNHZW9PaTIzdHc1QXBlL2NZNmhXZGhaUVMweDZEY3ZRU2VO?=
 =?utf-8?B?ZUJUSXR0amhMb0hBRUJrZFd2K3JiZGJRcHNVeXlDV1NCSWlCMW5FTVhTZTdD?=
 =?utf-8?B?RXRCQmM2VDRQaWh3bFdOWlUvajNvMFJUY3h1NE9JcDBJVHhxci9GSjVrUHpM?=
 =?utf-8?B?aXpRSlJaVmpERUROd2FGemtQRE5welZDMGo2UE9UUDJTNHpaUXNXekhSL0N1?=
 =?utf-8?B?NlJpYzlpOTIvZzN3amcrYW04dTQ2ZXhPWFlJVjNOU1ZxTEd3eHk2R011Qkdm?=
 =?utf-8?B?cUExeVhEcW8xb3g0VXlxMVQxRHIwd2svZktyTUM3SUREbTdJblY5SVVtT0gy?=
 =?utf-8?B?SS9sY3JnN3pHZERrYUdjMktIQzFqU0M0dEV0bGhwWHE5bzZLcW42ckpVSDlL?=
 =?utf-8?B?UUg0RHY5dVRVenY1RGMrMlNNOEJvVnNHVzZSaVlGRENGM05IY3EzSEo1dEwv?=
 =?utf-8?B?UStHaWF0M1lrNG5hYTNtQ0lkczU4ZGpycmRueEhnMUtyWHlIai9lS2RGd1RR?=
 =?utf-8?B?UiszVXZWOTlPZlRVOHZ6OCtLakEyTXdGRVpYVXA5MTVwVHk4TFJobHhoWFk5?=
 =?utf-8?B?RCt6bkZZZDV5bVByU0RKbWpxVE9MOFhUbmpScmNJL3pWSVZuelJLeDg3VWcz?=
 =?utf-8?B?Unc0YVN5QzhvQW56NlNIOFlTMElUZUhlZzhXR1hScVRKTmprb3FGY09PQWZk?=
 =?utf-8?B?bmNyd3g4QXd3T0NsSzNpUk9EVkpWajRiRzdMVlliazF3SWlBcmIwdjR5Kzhw?=
 =?utf-8?B?RExGOHUrQUZzN3lndlQwUExXSDB4Q2xtQTFpcER6YTNFTjlPTSszc3NuTmJp?=
 =?utf-8?B?bzNpUUJCejJVbitHdnJIY2s3V2JkWTl2UU9YWUJpbmFHQ3RKVEZLL1dtVCts?=
 =?utf-8?B?ZGdybGFMVEtxTXJnWW5PZjkwZ1FjcHpWb3YyYmpma1haUmFVdXN3N2ROZEU0?=
 =?utf-8?B?a2RXNWU5SWJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TndRUjlYaHdONU51SyttZ0xwRGlTUDlwRzdUU21qNlJWWHFONzAwL0Jic01p?=
 =?utf-8?B?WFd3ZGpyN0VSZ2tSd2RSSzhuSEtJQ3pCOHc0OTZoVUc2NHE3VlhUNFYrb3Nt?=
 =?utf-8?B?TjVGNmR0ci9TcXRzSzZXNXE3MnBSb0VpMHB1eHhRTGZkOFdUMXNSeTNmN2Zh?=
 =?utf-8?B?SXNRZGxJc2tzbHBDMllKY0p0VWV2aEtja3hscmN6ZTRERXZlbFN4QWJkUzhk?=
 =?utf-8?B?NXMwVzAxUDhYSUs4ZmtsRzVCdC9ZN3l5aU4wZFJNV3pudVVRdVlGY0c3VGRv?=
 =?utf-8?B?cmxsK2R1RmRrUnVpekJYb0IvUTBXdTR6TUpxWkc2OHZncnVxOHV6L3g4RHJH?=
 =?utf-8?B?Tkg1V2dML2gwWVQ3MXRhZGJ2N2F1bWZJZi9ZV2txR1VjaWRXSjlMR2pMZjZI?=
 =?utf-8?B?VHNSZkJvN1dKdXNLUEd2c2lVRTcySnlsMTEwaHBnZEl4MXZaNTlsV3VmaXdj?=
 =?utf-8?B?NWxudXg2eHBQV08yM21ZWm5pdFNXRDd0TUx3UkhBcXdPZlF6bGNjR1JCc25s?=
 =?utf-8?B?TUZBcnpGT244U2o2ZHRPb1FoYnArU1oxYWQ4dWgzN3pRcU9sMjF0YVRMUDRj?=
 =?utf-8?B?Q3c5NXpGc28xMzRLbnQwRmlGR1hCdlVjTFkxYTNlRnFUOVByMHE0QlRYS1pT?=
 =?utf-8?B?TkxndmNOdURTN28rbmdweVRkS3p3TGQ0cEFCeStWSVFQMlpwcXFoU3hzVHNi?=
 =?utf-8?B?SnU2NHY2NWxURUZ0V1pOQVNPTXhheGVBdC8zbUJGYTNKVmJ1b04wRzQwVXpD?=
 =?utf-8?B?T0VBNFU0T0c5WTFCUWc5WUFNOXZvVDBXalhnRk9tcmlsanZaWjNoSXlzejla?=
 =?utf-8?B?WFZtVzh6Zm5IckV3MjBneTRZTmV6Rk8vaXhaRW16Q0JzNUF4NnF0ZGo4TUZ0?=
 =?utf-8?B?M0cvU3o2akVFMWxiMFBqSmNrNWhiT0ZqN0RNaTBVSzRPbWJ4Sk9SMzlFYmtX?=
 =?utf-8?B?QlBLNVFvdjVRVW9nVWlBcUg5WnU0ZUUxbzJIcUN0d0YzSE1rMmNkbGFTeThz?=
 =?utf-8?B?Tk5IeXRybzgxMEVBUUJFaDE0YnNlTExHREE5WWEydUhhUkJwc01aR29yNDhp?=
 =?utf-8?B?aWdhVTc2RHR0MzE5NlViQWFJdW5HWmdiSG1IaklwTjA0WGxtS3NuOE5KYlFr?=
 =?utf-8?B?V2VYbk1MdUJoSDVJTURDcExvMFF6TFFzQXJwanQ2SHZKdmliclQ2QjM2ZTRG?=
 =?utf-8?B?eGZscW9EOVZDdENZdXd5dGs5R0Z3VUQzeUlFNG5oZjJBRGZDbkgvMm9xTjY1?=
 =?utf-8?B?Y1RpSHJPVHQyR3p3TFJ6YnJBT3VGSTN5MkR6blJhaU1CTmJ6ZGJTMnRvbG8y?=
 =?utf-8?B?cFY1WEFSc25RaDB2c3lWSVNuZzRiaTJ3Q25GSktlWEYwWW5Sb1ZQT3ZwdWRF?=
 =?utf-8?B?L25Va29BcWdMamVwaDdRSTdLNU1ZdEIxRzJNaXdlQUtpTEtXVWJSd004TTg5?=
 =?utf-8?B?MDV5M2VmWFRiNHBvcDYzdlpqZDRtKzRjVGJweG5URmxGWER6YUp6UjAzY1Q0?=
 =?utf-8?B?TTNEcjQxZlo2c1NvcktBSFJabE9kcU45R2NKRXBvYmN4Wk96emxHK2RSR3Yy?=
 =?utf-8?B?N09KUXV0Nk1GaDZyMjI2QkxXK3JTR000YmFycjFFN0FCMjVWZUYyRnExRmRk?=
 =?utf-8?B?ZnpNenZGTGc0c0psRkxBSXBVbUZJRjdGaTVKb2YzTGJxMGZRSTVzcHhKMTlQ?=
 =?utf-8?B?MnZvOTRHM1E2b1REcU5vMDd5a0c1TEdHcmY3RkhoVXFqcjBza2ZXU1JVWDVk?=
 =?utf-8?B?M2xyTGNWM2tGNFhvUTRtb3hGelE0WFpVUEJpRHNVNWhPRWU5UWpLSHB2UXcy?=
 =?utf-8?B?aGhNU05JdFBRSmh0TmZyMzlIbFViVHcwVVBHL1lLdExIMTAxT0R3ekVLZ2xn?=
 =?utf-8?B?bzZYVGM1YXZaTlJwYWxYamdWUEIvM0Zud0VaOGVEK0ZJcStLbHozejZZMkRP?=
 =?utf-8?B?STZNZThLSnovZHEyNmErYklvdW5NaEcvb3Z5ZUZ2T2kwQTNMQWMrQTRpS0ll?=
 =?utf-8?B?ZS8xd2gvTElrNnVnWStnUmF1SnUrS3lPbU90VG9OMFJHNTAxeGpqdEJkUmth?=
 =?utf-8?B?TllsRGdMZlBrZVIrOVFudzFkNEZCMURsYnRJaUNIR2ZnRG9XM1gyK0NjMnZI?=
 =?utf-8?Q?GhadWPydSCfT4Iie+YbH4ys0A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63f2728-07cb-473e-3238-08dd57e64fbc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:54:44.9447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t86Pk/oj3w3lyhITPzZAUcinDnKMPfrHrVQuxiGFdJUgeqHPZ7C6TA01+kgVJJh27o5NkBB5XCR+WDnJbbsRXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7116
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

From: Alice Guo <alice.guo@nxp.com>

This patch provides a pinctrl driver based on SCMI pin control protocol.
Currently, only the PINCTRL_CONFIG_SET command is implemented.

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/pinctrl/nxp/Kconfig        |  13 ++++
 drivers/pinctrl/nxp/Makefile       |   1 +
 drivers/pinctrl/nxp/pinctrl-scmi.c | 143 +++++++++++++++++++++++++++++++++++++
 include/scmi_protocols.h           |  36 ++++++++++
 4 files changed, 193 insertions(+)

diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index d13c5f2a6d..84d9a3641f 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -139,6 +139,19 @@ config PINCTRL_IMXRT
 	  only parses the 'fsl,pins' property and configure related
 	  registers.
 
+config PINCTRL_IMX_SCMI
+	bool "IMX pinctrl SCMI driver"
+	depends on ARCH_IMX9 && PINCTRL_FULL
+	select PINCTRL_IMX
+	help
+	  This provides a simple pinctrl driver for i.MX SoC which supports
+	  SCMI. This feature depends on device tree configuration. This driver
+	  is different from the linux one, this is a simple implementation,
+	  only parses the 'fsl,pins' property and configure related
+	  registers.
+
+	  Say Y here to enable the imx pinctrl SCMI driver
+
 config PINCTRL_VYBRID
 	bool "Vybrid (vf610) pinctrl driver"
 	depends on ARCH_VF610 && PINCTRL_FULL
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index 44e37c631e..9ef675d18c 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_PINCTRL_IMX93)		+= pinctrl-imx93.o
 obj-$(CONFIG_PINCTRL_MXS)		+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_VYBRID)		+= pinctrl-vf610.o
 obj-$(CONFIG_PINCTRL_IMXRT)		+= pinctrl-imxrt.o
+obj-$(CONFIG_PINCTRL_IMX_SCMI)		+= pinctrl-scmi.o
diff --git a/drivers/pinctrl/nxp/pinctrl-scmi.c b/drivers/pinctrl/nxp/pinctrl-scmi.c
new file mode 100644
index 0000000000..4a791b7e95
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-scmi.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/io.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/pinctrl.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+
+#include "pinctrl-imx.h"
+
+#define DAISY_OFFSET_IMX93	0x360
+#define DAISY_OFFSET_IMX95	0x408
+
+/* SCMI pin control types */
+#define PINCTRL_TYPE_MUX        192
+#define PINCTRL_TYPE_CONFIG     193
+#define PINCTRL_TYPE_DAISY_ID   194
+#define PINCTRL_TYPE_DAISY_CFG  195
+#define PINCTRL_NUM_CFGS_SHIFT  2
+
+struct imx_scmi_pinctrl_priv {
+	u16		daisy_offset;
+};
+
+static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 config_val,
+				u32 input_ofs, u32 input_val)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret, num_cfgs = 0;
+	struct scmi_msg msg;
+
+	/* Call SCMI API to set the pin mux and configuration. */
+	struct scmi_pinctrl_config_set_out out;
+	struct scmi_pinctrl_config_set_in in = {
+		.identifier = mux_ofs / 4,
+		.function_id = 0xFFFFFFFF,
+		.attributes = 0,
+	};
+
+	if (mux_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_MUX;
+		in.configs[num_cfgs].val = mux;
+		num_cfgs++;
+	}
+
+	if (config_val != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_CONFIG;
+		in.configs[num_cfgs].val = config_val;
+		num_cfgs++;
+	}
+
+	if (input_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_ID;
+		in.configs[num_cfgs].val = (input_ofs -  priv->daisy_offset) / 4;
+		num_cfgs++;
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_CFG;
+		in.configs[num_cfgs].val = input_val;
+		num_cfgs++;
+	}
+
+	/* Update the number of configs sent in this call. */
+	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
+
+	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
+			  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret || out.status != 0) {
+		dev_err(dev, "Failed to set PAD = %d, daisy = %d, scmi_err = %d, ret = %d\n",
+			mux_ofs / 4, input_ofs / 4, out.status, ret);
+	}
+
+	return ret;
+}
+
+static int imx_pinctrl_set_state_scmi(struct udevice *dev, struct udevice *config)
+{
+	int mux_ofs, mux, config_val, input_reg, input_val;
+	u32 *pin_data;
+	int i, j = 0;
+	int npins;
+	int ret;
+
+	ret = imx_pinctrl_set_state_common(dev, config, FSL_PIN_SIZE,
+					   &pin_data, &npins);
+	if (ret)
+		return ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		mux_ofs = pin_data[j++];
+		/* Skip config_reg */
+		j++;
+		input_reg = pin_data[j++];
+
+		mux = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
+
+		if (config_val & IMX_PAD_SION)
+			mux |= IOMUXC_CONFIG_SION;
+
+		config_val &= ~IMX_PAD_SION;
+
+		ret = imx_pinconf_scmi_set(dev, mux_ofs, mux, config_val, input_reg, input_val);
+		if (ret && ret != -EPERM) {
+			dev_err(dev, "Set pin %d, mux %d, val %d, error\n",
+				mux_ofs, mux, config_val);
+		}
+	}
+
+	return ret;
+}
+
+static const struct pinctrl_ops imx_scmi_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state_scmi,
+};
+
+static int imx_scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+
+	priv->daisy_offset = is_imx93() ? DAISY_OFFSET_IMX93 : DAISY_OFFSET_IMX95;
+
+	return devm_scmi_of_get_channel(dev);
+}
+
+U_BOOT_DRIVER(scmi_pinctrl_imx) = {
+	.name = "scmi_pinctrl_imx",
+	.id = UCLASS_PINCTRL,
+	.probe = imx_scmi_pinctrl_probe,
+	.priv_auto = sizeof(struct imx_scmi_pinctrl_priv),
+	.ops = &imx_scmi_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 7abb2a6f36..279ebbad44 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,6 +24,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
 };
 
 enum scmi_status_code {
@@ -1005,4 +1006,39 @@ struct scmi_voltd_level_get_out {
 	s32 voltage_level;
 };
 
+/* SCMI Pinctrl Protocol */
+enum scmi_pinctrl_message_id {
+	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+};
+
+struct scmi_pin_config {
+	u32 type;
+	u32 val;
+};
+
+/**
+ * struct scmi_pad_config_set_in - Message payload for PAD_CONFIG_SET command
+ * @identifier:		Identifier for the pin or group.
+ * @function_id:	Identifier for the function selected to be enabled
+ * 			for the selected pin or group. This field is set to
+ * 			0xFFFFFFFF if no function should be enabled by the
+ * 			pin or group.
+ * @attributes:		Bits[31:11] Reserved, must be zero.
+ * 			Bit[10] Function valid.
+ * 			Bits[9:2] Number of configurations to set.
+ * 			Bits[1:0] Selector: Whether the identifier field
+ * 				  refers to a pin or a group.
+ * @configs:	Array of configurations.
+ */
+struct scmi_pinctrl_config_set_in {
+	u32 identifier;
+	u32 function_id;
+	u32 attributes;
+	struct scmi_pin_config configs[4];
+};
+
+struct scmi_pinctrl_config_set_out {
+	s32 status;
+};
+
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.43.0

