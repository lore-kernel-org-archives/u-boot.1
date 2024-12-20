Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A7CE77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 413418034E;
	Fri, 20 Dec 2024 03:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XwaOC8RH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A73C080352; Fri, 20 Dec 2024 03:55:26 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3EC78037B
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrcpoDMF2h27qYigh+L3t3N41lARowBowRKCP1pwU7252k/wKJf1Re6UtqZ2Cop7v5UXgyQq0lENflA4RxOnlvsOR28sKtsYPG/4WsD1WqpIZwzDXbrM+JLrJTxgkmVILaw1667SO3ULl+TnsAp18YQUFeDBMMr7VDk+tPWJsXbVxQhgK3gAsC6piFKVMFKV9O9y4NS3Lz7QUkZPzZvWV0FNS8CGFQ2E35kkYTLAziQxws2beKZCfZNPtKzqoZVncKYyXP6dZ6lpDixoXfvBkd19vmWSSe6/Z0RoU9auYpZUbFsfyjIvFd8vdHQNEyG773Z0ksr0gGK8B9SM98f+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ27QUNb4XMZA14luYXRGGDYS+j7R3pB5YLFWAgcKe8=;
 b=J3KmqzTTqkohr64/1Rjq/vD8FcZ8dMR51GMOCWw1k/Gn/go+sskpDpp/wM4UJODqMUxTnjYyNjoKzt5f7LkY5yOB/9pxcVZYsfCf0PtDU6GIs8s253ozLBYpU92mXMKWC85KBaYVFsDLjWy4wA46DaIeT5FuDEtZdI4LgMeU1ErlfJAVtBYUF84fF45IdG2wUxLd7rTJvjCyTWWWac169xIZ7A0n+MV01sfVrNST2FTIvHp2XozyXXtmUJPaTm+D6LKXM6V3iObXpPbN1pdf6wmqhxtSkN6hDUiHce5N9NLCEZr71REP01yEgrifDdJMSgXhXxMTmv6j4caZSbEYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ27QUNb4XMZA14luYXRGGDYS+j7R3pB5YLFWAgcKe8=;
 b=XwaOC8RHnjJAjQeGLgOXQ/JkcOn0vr3cfrS7VwMQyBXcmoIaOargTEOV7ApmjABB3xwGLQk/BroHga/pK2TVXhAu46m96fg9bI6ee6ksX9fFvBlB4ydkFcC0r4b9rgVDVLXUjC+bYT2yAOlK9083avHAJXNFnVL1HRGT3L+s6J9fTq6bCYlc1fsSekuh04p6AXz4OPrMdnkBUc5zceuj/a3XOP4NaSZqjU2FVge/2oUmJWWKA7H3Dr1rbrYxjSClPgAhOm2++IzkH6cPjtiV5heAjXseMr/PuwmdgeZkkRyfFbp4DpQXInlmDTmnE8pZdwY1m/2svaTy9Qv+U2X7uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:55:21 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:55:21 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:02 +0800
Subject: [PATCH v2 04/17] scmi_protocols: add SCMI misc protocol
 protocol_id and message_id for getting the ROM passover data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-4-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=1124;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=EB3jfllXXxvcutkNsraldgKBWYZpnS1lCbBAdD2GLIY=;
 b=pmWt15sDNILl0aQ7ev3NNrgIk2Tfe6QfTZV7EvK6kpaibizC/+9BxPhCvX2aYd7YlVrHm6Lai
 7N6QCazi9GQDMfd/VIHmibIL/m8XjyPLfgCbTTG2F5Fr6+dWs7LPZGF
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbb0625-3b43-4edc-b495-08dd20a1be5e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TU1hNGg3RjlCUVJHZisyNW92S0svc09BWWhYa3V4d25laG5wN2NxbExUYzV1?=
 =?utf-8?B?QlMxWVFjcDIzbHVNcnp6NWdiemg2T3kyTFVEVkViNVZhSFlpWllERnhvY2kz?=
 =?utf-8?B?cHpUUW10RGEvOFlnU3hUcDlzd3MwaDJaMzE2U1daSUZEUXE3cC9WQjZMQzdG?=
 =?utf-8?B?bk92d2pWQnlJSS95azNRWi9nbmNJUE55ZHhxczJZank0R3hNL1N1bDh5eHJq?=
 =?utf-8?B?NTJSY2RRdithcWh0UTA3dnZmcVR3ZU4wMllnSUF0ME9XZ2thNm8ySzI3RjhQ?=
 =?utf-8?B?NGV5cDk2LzVSU2d4UGx1M0NScGtodEpmQkZ4b0diN1VXclVGY1RPOW9LOS81?=
 =?utf-8?B?Umk3RG1ZbU1qeDRGVyttTE1RdS9MdXA2TnNNUjYvaWZqd1hhcSt0dE02Ylhm?=
 =?utf-8?B?N2hWck1FWHg2KzlrMFg3ckVYcnhOTGlSZGpnMTFUeG5KMHFsazd3UEtSZm1E?=
 =?utf-8?B?QjhpdHExa1lXeUhNZHdtZWJvU1hQT28zNFBveEJBTFczek1IQ0t0Y3JZY3ZJ?=
 =?utf-8?B?TmtIK2lSZnJOSDZvSzRleEl0d1l2RUd1a2xvTW16YmdHWjdnZDd5WEdGOTZL?=
 =?utf-8?B?MHFwRyt5ZFVGT05mblpEVWsxb1Ryd21PYzhsdU9BMmFxZzI3NTkwU2o4Ukps?=
 =?utf-8?B?RmQ4MFlsYXVPQWs5dXhoWWEyd1pWR3NzWkdQNExKNlhkMHdxdXJ4K3c2TVlP?=
 =?utf-8?B?NStma2RwQ2N5dnpyYUNpbm5DaWxUVDQrTlpEVGdkbjQzbXk0VEs2TitDNjlK?=
 =?utf-8?B?NG9ZQzdjN1Z6MEYvUlp3d3hNd2VrTFRvaWFHbHFxNlpJeGZnSlpKckMrbUQw?=
 =?utf-8?B?SmlJZ09QcG9UZXFSUFFYSHhZd0hhUGNoaVlRMW9rOTBXZ1RVVytvbS80US8y?=
 =?utf-8?B?V0V3cXZBVE5HdUQ5eGZjdm5lYWlvRmU4dWVoL1FENSttQk45TDZYb2llVVRU?=
 =?utf-8?B?UE1Xc29sQ2JraW42WXhqUUdTSEdQUzJiZDFVUHZtMlZuTDMwUWZ2WGdjdU5k?=
 =?utf-8?B?U1lQb0FmaDhOaGYyTDNWaGErRGpnSFRRWUh4TlFEMGlZbUttaDhvT29vYTFB?=
 =?utf-8?B?VzY3TitUemNrSDEyZmdzM3lrWkNrNVVXUjBTeUtOeUFOYW5Sd2FGMmNVbnZm?=
 =?utf-8?B?RWRXU0dveDNzNXk2WXMwSTBoM2Y1eDhOdDlvb0pQV0R6VXhiSmh5cldUbFMw?=
 =?utf-8?B?NjdHZktEaWpjVXVqcWVkdU1iRE9kNVMzZW5vNUF4bzhaTzhtb1lSUDNyb01m?=
 =?utf-8?B?U1RTSDVJN0hEZGc2ZVlDZU9tRzNyQW1NVkFqZzdrNmtmc2ZMWkEweGZlV1Nj?=
 =?utf-8?B?MVB6R21RWXRIWHdFNVMzR3dnWXJpbjhzZjVuaEt0M0RQd014ZHFVNVp4OFJV?=
 =?utf-8?B?bER0WjAvY2ZQYlRzbURlaHo5dW82aG1qNHo4QW0wdTdiV1dMdW8zNm94alJE?=
 =?utf-8?B?cE1nTXRJUlB4cTdrcW0zZWgyTHU1SDExSzk1Q2NqMUs2WjRuL1Z1V2FKKzZS?=
 =?utf-8?B?bDN6ZDJhRjhrUzZISFMreG4yaWNjNUE0Q05zZ0NNSHQzam84UGRBa3BzZG5X?=
 =?utf-8?B?K2F0SjZXRVVlWjYwMTZBZFpqMmZNdk1hdEJ5dFBzejhpM3V6NTB2ejd3eGln?=
 =?utf-8?B?UFl5bVQ3K3BuRXZsa3U5bm1pV2NJd2V3clBKMW1OdGJhTndrR28wODVoL3F0?=
 =?utf-8?B?Wk05aUxPVGZ0OG5DaGRQMk9sRURjOGxmcEdZUnRZdGVCL2ZJVXZuVTNmVjkz?=
 =?utf-8?B?OGYvSTZpQXliZCtsV3lNQ1d3bU5aeC95SnMwZjZFMGx1Qlc4TmF6WE5RYjlN?=
 =?utf-8?B?bXhwVjhaK0VWNHIyeGZBdENFMm92RVErMmJ6UmRtT3htTUo5VWhsZytGaFgz?=
 =?utf-8?B?ODJsNXFjSEo5eXdBcVovazUwRVZLU290M0NHc3AzUFhCdzJaaThZSXFaTFhY?=
 =?utf-8?Q?iSnYndJ0/xXAm1x3QOUCoxVvlvJHW8lk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkJVOWplZm5ieFFhclQrVzFzeGNXZnB6OWRZSU0rSFhyc0h4TDUwNXY3UjNM?=
 =?utf-8?B?Z29ZYzlHMnJIdXJvdmM3NHRpaXRpYU1zR1d4UVJkQ2RJRHh0c0xlb1hxTklE?=
 =?utf-8?B?Zm45K1hPakZIUE9hWC9yYitGSXBkNXRCdDhERE9vNlF3R01BanVuNTBOU1I3?=
 =?utf-8?B?VzhuQWs1aUxEZC9xZUQ1OGdWQmdrQlg5Vjdhak9rdWV1OThNREZyNEM5bExu?=
 =?utf-8?B?VTRZSlkrK3Q4dE5HWE9QMFlXUVRFTXRFYllZcGI1UzZBbEoweTl6NENPb3V3?=
 =?utf-8?B?Zm55dHdlYXVZZlFUczd6Y1hqWU8xYllsa3lrRUtrbHVxaERWMEJFb2xCN2Rw?=
 =?utf-8?B?bG9YU1E0SkFGWW9EWDNsVkVvNWJRbzh0b0tvaWNMeFUrTC9SRGtZcHhxTVRs?=
 =?utf-8?B?b1ppOVAyd0pUZk1YY3JSOGFxRmJuZURYWThSMEtMMkIybnpNYmgrTytuZ2dU?=
 =?utf-8?B?bmU1bGFjY3ByVkFobFVYSjlSUGFJc2tuc0FpNWx3UTdwWUlFTDVmWk9Ibnpx?=
 =?utf-8?B?Wi9IWUJvNGI0MmFabkR5R3VvVWVvN2dDbFRJOXJTTVNHWERNZXRRemRQMFRD?=
 =?utf-8?B?cmp6SFlJOTV4SHFoWTh2eWFzbHVrV3IxMzB3eG96ODVkbHhnTm1La2lVZTJE?=
 =?utf-8?B?eEpHbHR3djRGazgzWU5kc3VIeTFXb1Z5UWlna1VaYjg1MXFLMWJuZGNaQUhn?=
 =?utf-8?B?SWl0QkN6OHBORmthUExDdGpMUjJsekUzWlFDWHBpU05qcTYyeHUyYXV6MkJs?=
 =?utf-8?B?M0h6a0w1WTM2cFZ1R0JyT3phNTJFK2RPaFNsS2pFaHF6ZjRhQWU0Y2NDd0RN?=
 =?utf-8?B?VG9qbWJOOHM3cjcyODB0ZUpCYW8xM2txdUh6YnZ4eFNoQXZkeFpGdmRoa1BM?=
 =?utf-8?B?L2FEMGNUWFZ0SCtrUmJZQ1BiZjBFeUs3OVFQZjRlSEd0MnRPWS9RMEV1TmJG?=
 =?utf-8?B?b0dkNGwzemgyK2xzMGZRcldiRkI3ZkdQdExsbU95ZlV6ZVJhMzFheDNMSlZT?=
 =?utf-8?B?TlBZb0ljMk5SdlV4dU5jMjJqNWpNRFBXZ0JyblZWeVM2cXlTVGwrRVFiVkIr?=
 =?utf-8?B?RThydlV3RWdSdEFoYXV3V1JQWFJJTk1JVVRmRG5aUVBwYnhaNzBqWEJCdFRS?=
 =?utf-8?B?OUE3UWRHdmlvdkYwdDdXaVVjYVJ5Vm50c29zL1VZQXllT250a2hhSndJSkFW?=
 =?utf-8?B?aUQxUVV2RzRTdVQwRmVpUWIzYzdNVnRlRmxsVmhzTUhHaHRDN2psaWM0blNT?=
 =?utf-8?B?Q2pTUnVhWmtVZkZWdUlaUzUvcVRzU0xYZUFGVFVFRGE2T3lDaWVDZkdQRWI4?=
 =?utf-8?B?djZoeVJJRmlFUjJqWTZoWXZPN3UwcWlSVkgxek9BUmIwZU12d21EN1Bwc09N?=
 =?utf-8?B?MnpjUWlkQnZXZEV5YUhLSTdUUDFMTjBNYnBidkkyWHYvZ2FzT29UcGhyUzYv?=
 =?utf-8?B?N2pjcVo5OU9qWXNaOUNaeDIwR0lOY1I3KzFhT3VKd2NzMVBTbWg3bnFrS3Yz?=
 =?utf-8?B?c25nTFVMSjQyR3lVVXFBT21YZkxjVkNuY1h5Y1pqd3UzRXFkQTFHa3RIOEd3?=
 =?utf-8?B?ZGFnRTM3SkRENWZtTVlJVFNySExlTVV4TnRrd3ZPOTJYbjNmdVdlcXdWYU9r?=
 =?utf-8?B?NkY2VzNXZVRSemQ0WkVKTHc5cDhkR2RySFVmU1J0SkNTS0I1bVNINHRoT2ZB?=
 =?utf-8?B?VnFrdVNIWWJNMlZ3WnArTnh2THYzUmRwUDZIZkNnc1FBRloxQ2NlNDVDV0Rt?=
 =?utf-8?B?OXJ2M0hLMG5rYVR3bXFOd3NheXBjUWhQTmlrQXJINE83a3JudmJKRzlHdGhU?=
 =?utf-8?B?VmJmWllTdnEvaTlSQTNDdFJocjBaa2QyVXNUTmlBTWlDQ3BMY2E1UUFFbzB4?=
 =?utf-8?B?UStBdzdDS05ObTdqcXUvUGJaOWdlcHhjUzk3WTAyRGN4enhMcnF5bE9uZlZU?=
 =?utf-8?B?dHdMTDI4N0s1aThmeE5jZjg3UC9hMzVMQnBUR1A5MTlyemxGUjhYYUUvUmxt?=
 =?utf-8?B?LzM0MjRpcXVCcDFlbkN4amhEaUV3K2R6VzFTZEdyNmc5VVd3R0pnVVJnZVUy?=
 =?utf-8?B?emNDYkQzbjExOFRpUTJkbkpWKzh5L1Z5R1Bkbkw5akFoN1BlYVQ5bFJTdlpS?=
 =?utf-8?Q?yy9Fo86O6GG0USliIfaWeW6vW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbb0625-3b43-4edc-b495-08dd20a1be5e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:21.3330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xTyWJ4yyU/UGWgIkHd81B/PSJaMxiq6Jbajg1vKUUgolWONPJjQI0R6i7rJYmilBWcmKD11sWTMEXjgknjcJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

SCMI misc protocol is intended for miscellaneous functions which are
device specific and are usually defined to access bit fields. This patch
adds SCMI misc protocol protocol_id and message_id for getting the ROM
passover data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 2367467512a6b65253317e51bea71de396aa96f9..6cda1f00df1f6baf6db65a28b4cab114f8540a4b 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,6 +25,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_IMX_MISC = 0x84,
 };
 
 enum scmi_status_code {
@@ -50,6 +51,10 @@ enum scmi_discovery_id {
 	SCMI_PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
 };
 
+enum scmi_imx_misc_message_id {
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+};
+
 /*
  * SCMI Base Protocol
  */

-- 
2.34.1

