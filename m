Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7D9CDD56B
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF42589062;
	Thu, 19 Sep 2024 04:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MCxc8UHa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A46789098; Thu, 19 Sep 2024 04:58:55 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38F6289057
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLG7avIWq2min7uwr9QJltnlAG8a4L/JOTFruNaUxdHEZHxvne0VWjjXxu4mmQwXTccNqM7n6MxNMkSVtst0zzF6dZcoohavkiZpIyIaQLaafTfR6XNk0k+GE1Dq74OGvVCZV/WfmmtuGtORUwaSnUqetdFmThJevvB3ZxpSsgstzH6fdDiSf/AJ8WNW0gSTzlmhc5YBUOH6MQYQDAwg1WMM/fFh2NhW/eOD9jLNAHK75ncrYERo5u32pjldrIdVJpfDm4J/fPcR1xN4Yfo2R3ch4d4BGe7+rFQ/TeFjz4EK/T8oKuT11cI96B4SLswFCNT24YkW62HF+/tlmrNzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYLgxBcCgvFVhLCk0CE1dak0hYn6A3h9u/Pjwah3V7U=;
 b=wiEiXpu2V/qNpqjrW/+jAlHevy3ZU1gVQkjZ/0pyeCqS7EvOsAYwDXco8yCh7edpEvWwz3WMD0Djmi6F+poIrLRnxXO0IYINN6qOYfcgl5CdRvreoFXwu/c1TDSOTADtYNI2PMRCZkg3NInsbwLdQ5w4emjADWwRWlvxuBov/vZaNObLZ2SxgqNpy+1aAWjSfbKBHAbXexXo5wYYW5c7VBuoulNfzGb7g7zmx0ABVXVObmNzXX7QWmvQ/20vPYTwQtSv2AEdGt4MEgsqWxhOzy7b2zI2Xwysh0HG9SHLoC5/UsSVQfXU+YLe2qeKGgMUKqbk6F6Xfp8+/0275pObMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYLgxBcCgvFVhLCk0CE1dak0hYn6A3h9u/Pjwah3V7U=;
 b=MCxc8UHaKR4eqx8cED39J7y9HFQ3BNWLshJjjw/f2qoTHu/ypBYiXg5a+SZV9ynqjj0nLdTkG+91IR2+AB7mgOZEzWjnq8dbZgu0qOBoZrUST+zoq6OvhIfRDZAGoPUMsPI+QQD5VCVOUK6xBjjx4i+663vezC01ZogT63lOxce58UPoZqpywKxVj4vVXHjVWT6rMoOu6oL0lDGLou5rWust+7s0A2MFQnPnZ0M/kyjcIBCVBqs/N+LubNV0QUc4yPVBrVkrLORv/dp8Gf+Li8SV2TtrPlssZVmv+OAR7sGcJGSvtGAoV9IRm5LXkXwCOH0zBJKEvmtsKfJjsaoHYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8867.eurprd04.prod.outlook.com (2603:10a6:20b:42e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 19 Sep
 2024 02:58:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:36 +0800
Subject: [PATCH v3 18/21] imx9: trdc: introduce trdc_mbc_blk_num
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-18-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 37daf648-1f02-45dc-ec0d-08dcd856fc7c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGJYdUlxcWxlUWhOdzN5K1I0cTNaK1JhNzJKTjcwZzNhaEdJN2pEeGxRT3JR?=
 =?utf-8?B?UXdZZFNmMWRnOGttcGRoSHR6ME9ZZ0N0OTNyUFdQZlVld3RMQTkwdnB6eUVh?=
 =?utf-8?B?bE5GVjFCdVFIMGU2STlydVJOY2FEclo3c2g3MGZ2Y2VjSkh0RHNTV2tLSnlU?=
 =?utf-8?B?UFF0UGtkSUNqckE0ZklHakUxRkVXNTllNndscW1jcU4xMW5MWEo5YTQ5Qkky?=
 =?utf-8?B?M29HWmpING9FcitubUhaSXdFTVNIVVROWVJqTUl5c3hBMFEzZzJDZzRDajdD?=
 =?utf-8?B?YzdmMjVoV2owZmJ3U3VOTXkvcTBDYnBHN2lFbDA2aTduMEVMSFNBcFZLWmNM?=
 =?utf-8?B?ZmtvQ3NpYkpKOGJLeSt5cGJDUGMzQnZVNFUvN0RXeFh2MCtnc2J3bXlXb1Ev?=
 =?utf-8?B?UmNMOGRXelMyaWRjTi85UXI1ZW5kS2dXVkh1dkJMT2t6U05kaFlSbGxHUWNy?=
 =?utf-8?B?eEN0V0ROR2FwVm5pMWMzVHhWWmIyM055YjFMK3JnVzZsQytGSVk1V0xNWWFy?=
 =?utf-8?B?OXQzS3dnNmtRYjZidnh2ZlQ2alNnK3ZwTE1EdlJlbVJNY2VoSE1Id1R0M2lX?=
 =?utf-8?B?Y1JxSlM5Y1RxVTNKVERwN1lLUGlnZUphWDYwV1AxbUNDWFd6bDVHVFBaMXAw?=
 =?utf-8?B?bE4ydVN3c2VSdUR5b1R2NlBXRFNybWt5QmpLMTRzRnN0N2FIMTNwWFRHbnE0?=
 =?utf-8?B?ODNmSkVab3Q5ekxzcUJtWTd6MG1rZmZ5ODhYNHoybDRJN01xNC9aUzVua3ds?=
 =?utf-8?B?SkRUWU5LbjJuMys1Z291WUNzck10bG9zalkxMnF4TEE2OHZmSlBiUVp0clZR?=
 =?utf-8?B?bFh0a1p3bXJPT3VZZjAvK0JWWXRKVC9CZEhidE14RnVUYlZuMW1xa1RmT2Ju?=
 =?utf-8?B?WUpCdkJlNmhaWTY4Y0xaa3FXc0VnTnl4b3YwdGIxYkZlTDVLdm1vOFpMVWpm?=
 =?utf-8?B?bnQ5Z2VZbTNKN0VURklBdVRCcktCR0NEOFM1RzJBOVRCYUliRmgwRlVsSDBl?=
 =?utf-8?B?NWRUSTViMDRDOC9UVmQrMkJ6ZHBLOGV2S0RUU0k0N0R3ZlArdXcvd1ZpYUZn?=
 =?utf-8?B?QkJMMk9DeVRCWkhJVjJlMHd3SXl2cFI0eGtTUU0zd3BhVVh1TkhHaEFncjA2?=
 =?utf-8?B?ejQ5NzNPc29oYmxUQWRYL3BEQ1pVY1hkd1lKOW9HVVVJWnpxRUhJR2pDNXU2?=
 =?utf-8?B?U2F1WTBLUGx0MDY3SjF0R0ZsTXJKeTU1d0I4dlRHcWNITUdTTWJmYWUzaUkv?=
 =?utf-8?B?TCtpUEpJMVhMWHVsNzg3NWkvVnd1UTE0SGpPZmZWRDJiTjB5RlgvQk5UVEkr?=
 =?utf-8?B?SnRFdW95M3NWN0RQcjBxZHVwNS8rTm9TaGFrajVnL3ZVb3N5N0FERklzQ0J4?=
 =?utf-8?B?WERlSERmQVRNbnUxZ3BOL1ppcEt0NzlmNm1ldllGUndIQnNmK0JFeTdHUFVN?=
 =?utf-8?B?SndMaW1vRkpWOXU4NzFFaDFJaEw3UzR2eDc3T1BLVElqUENuYmNGbEhkdloz?=
 =?utf-8?B?ZkMzSDR6dFlpeDQ3YmJQV05vZlY2cG45K2h4Q2cycDhnWGZyUXNwNWVDdm1P?=
 =?utf-8?B?UURGeG13UGcxSmhyMjh6SzM5c1dnelMrQXhYL0lkY0RCbEs4eHFFdzJBazZV?=
 =?utf-8?B?bmZBSnA4UC9xM1BObHVqQWtBTXNudURBZVVGMlRCRWhtelcra1ZTWTBsYnVk?=
 =?utf-8?B?UXFHbmttUERSS3ZrQmtGVkowK0NwalJuUE5mUEhOOVZtUHNHUjhFV1pGY3dB?=
 =?utf-8?B?VFI3eER2SnFjVlJETHdNYWRBVWdINytqdy9yYzFBVnpYNkFlcXQ2enZzTmhB?=
 =?utf-8?B?NU52QUIvdzN0QS9IZi82S3k1VjVLTkpUcWNIOHorRXlCTzVjSG1CVXJNZXU1?=
 =?utf-8?B?dHdtUUpVWEVvVURYL1BUcGpHTTJ6SndJZHNGZ0pJVzlqVEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Znp4bzA0UHV6eE9lWE4yUTBOemw2RmVWM2lzL3ZzU001UzVUeDBzQ2g3MHE3?=
 =?utf-8?B?VTVOaEtCQXpIL1EzV2dzMzVjRGtucTdLaEowNjJRNlJyM29hWGhpS1VUdERN?=
 =?utf-8?B?UkNCMnE5dnVIakFqMi95UUprekpMOE1zU0grWVB5am01RDlwZm9WeTc3YVlJ?=
 =?utf-8?B?bi9aODlvSmJudzExUEN1VFAwbWtvV2dYK0FLbWpOVGlVcWhNaDZVblNXVEh1?=
 =?utf-8?B?ZVA5bzcyTE5hbDhnMksrTHVGTXBmaUptVGEwSzdweEZPSG9qVDNNUHp1NmNV?=
 =?utf-8?B?cStWbEpSZGI4amxkVE5jUXd3dDZzbXkweVRJdmNMMmtGYXdiTUlzZEVqRmJ6?=
 =?utf-8?B?YnVTN0tLeVMycVJWeWRoSW1BaXBLZDM5VFZrR21RbHFrQ2RORjUyajBackFq?=
 =?utf-8?B?N3FIb25wWHJMd2p2aVNOLzhkTHFiaFdwQjBIQlY4dTNrZU1NVldqSU5vc2oy?=
 =?utf-8?B?R1FhWXpYTFVJNzhIdTUvRUpocDRGSGxjZnYvRDdWTk5XTEFhNHFWNnN1RzAz?=
 =?utf-8?B?UDJzcUlDWDVVM1Y5bmF2Z3JtRWpVN3FjU1czczRmS0dQbkdYNytOcEJwYnpa?=
 =?utf-8?B?VTFJN0hKQ3JtUVhqLzZDMFF0MjBUaEFSNDJWdGNWYVRhMnI2d1ZNVHhlcCs4?=
 =?utf-8?B?VFA2bE5jZzVidjdvWk1FUlVURGovb2l5SWRTclg5aC9RdXFMUHJIVjFBYWtD?=
 =?utf-8?B?UkxKMlFKMFQzWk1UQ2ZPUDNybVhaeWVjdG5xc2czTTRNNU54VVZVWGpSSE5T?=
 =?utf-8?B?ZWpiK01rQ0RTN0VQaTlDQmE5RTdwY2JXUkR6djM3UW1aSE5VWnhVTVY3QXlM?=
 =?utf-8?B?ZE9XQU1Mc0c3QVU3T1c5dEZGTkNXTUhRN0JSZlAwS1RXU3ZRb1JBUTdNWTcy?=
 =?utf-8?B?cU5FM3RjbDdlaDZaYzZ2MmVzd2ljanI5RXAzMEczcnRsQ0pob2piajBjdnB0?=
 =?utf-8?B?R3M4Y1RxbnppTGhvakZkRFdSSWpDRmZmNGpzMUJOMFhrOTBsd2xwSTN1ZlN2?=
 =?utf-8?B?dVdxdWozM1Z2STZkVFpIUVpySit6VTIxUXlwbktBNnBQWVZlQVR2b3g5dFRy?=
 =?utf-8?B?N1BXaHFGRDNFbGxLNnduZ3JVUWx1dHBEQ0w5QldhZFUyYVlsUUhvQ0ZrN3Zh?=
 =?utf-8?B?YTlOb2dFUk9YSjZUcVhYUDExdHZWVzdTV21IZHBUWEVpWVRKcHN0Qm84WCtH?=
 =?utf-8?B?WjZDYzhDZSt3aWxlS0xyWjJyNXErWERZd3Y2Q3p3bENLaGVxWVArZTBtK0c2?=
 =?utf-8?B?bzd0MEtLajZsVVBzZnJhSkFOUFlmb1Jrb01xdjZZRUcvQUtoLzNyOFZ0RG1p?=
 =?utf-8?B?R1laSXdFZ3FNb1l3Y3JBVHE3azBZRnIrNlMrUW9CNEJIdTMwUW9GQk55dHZS?=
 =?utf-8?B?Y3BEeTc0NHhJOFpyMlQzWXRaZ0pOR2VEbGFHZXpnMlp5enp4S1dRT3NuczVS?=
 =?utf-8?B?emJwV2NEUXNyaGJncWhOVjlYTWRjUmN6UUErVW5YOWxnRnBLbFJMTmt1TWlh?=
 =?utf-8?B?T1poTzB2enhoUlQ1bXBXeDhHbmFNampCaDRKMGVsUEQzVWw3d3R2dTV4MFVI?=
 =?utf-8?B?eUZFRm5hdlY5S3RKRmp1YUZVWTVGajh6cFpNRjY3MWRhRkZhY0hRN0pkWU0w?=
 =?utf-8?B?bW9nZzUzTU04dU5FZmJaNUgyWmdPa0k3U0dYVHpXWlJ1dDF3SWlaZlArL1VH?=
 =?utf-8?B?WE5MQlZ2Y2lnckxKUjJHcWdETnNNMzJ3L01nek1lOHkyOTEwWncxU0lMV1Js?=
 =?utf-8?B?dDZ2a08zL1lzQWxjUVRQNkJia2NwZkVwSkxOU2NuQVBDQk9MUldZcFZ1TzlR?=
 =?utf-8?B?VVJRamc2c0FVWXI3L1JLbmRMcHBib3VTbjYvOGMvNGdoWUZPRmtEM3JQOFcr?=
 =?utf-8?B?VXFtVHBLQzJacGt4OW4xN0VBS1hNRmM1SEprc1RTSEcvaTlJNExIYzBhV2xL?=
 =?utf-8?B?MlB5d25FSjNHWUVoeVJXNDEwL1RKNUF4b1MreExYY3FxbHROT1I4elp1OVhQ?=
 =?utf-8?B?aVA1WWUyaEIxL3FtZW1tZUxjOXI5aEF3N3hONHRZOWNwb09tOXpQWWQ3NmZJ?=
 =?utf-8?B?ZURWWnRVcnZPamE1bjAwTlhUcDhJUERKeVNHR1dxaEJ5dU43bVpHTG5JNHY0?=
 =?utf-8?Q?Wfonylxi4fim2TfOgHQtN5IeI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37daf648-1f02-45dc-ec0d-08dcd856fc7c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:49.5695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gi46GaYdgfE44E8BoBse39fpXjlAQInikk2Qv02qwVf1Akx+XwVC6i1isvVARxymMx0CRPbQ+0Zkg0fXoFfT7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8867
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

Add trdc_mbc_blk_num to get num blks in a MBC mem slot, then drop
the hardcoded value '40' for NIC OCRAM configuration.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/trdc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/trdc.c b/arch/arm/mach-imx/imx9/trdc.c
index ae1a46d1331..ef0f8b52a4d 100644
--- a/arch/arm/mach-imx/imx9/trdc.c
+++ b/arch/arm/mach-imx/imx9/trdc.c
@@ -19,6 +19,7 @@
 #define MRC_MAX_NUM 2
 #define MBC_NUM(HWCFG) (((HWCFG) >> 16) & 0xF)
 #define MRC_NUM(HWCFG) (((HWCFG) >> 24) & 0x1F)
+#define MBC_BLK_NUM(GLBCFG)	((GLBCFG) & 0x3FF)
 
 enum {
 	/* Order following ELE API Spec, not change */
@@ -154,6 +155,22 @@ static ulong trdc_get_mrc_base(ulong trdc_reg, u32 mrc_x)
 	return trdc_reg + 0x10000 + 0x2000 * mbc_num + 0x1000 * mrc_x;
 }
 
+static u32 trdc_mbc_blk_num(ulong trdc_reg, u32 mbc_x, u32 mem_x)
+{
+	struct trdc_mbc *mbc_base = (struct trdc_mbc *)trdc_get_mbc_base(trdc_reg, mbc_x);
+	struct mbc_mem_dom *mbc_dom;
+	u32 glbcfg;
+
+	if (mbc_base == 0)
+		return 0;
+
+	/* only first dom has the glbcfg */
+	mbc_dom = &mbc_base->mem_dom[0];
+	glbcfg = readl((uintptr_t)&mbc_dom->mem_glbcfg[mem_x]);
+
+	return MBC_BLK_NUM(glbcfg);
+}
+
 int trdc_mbc_set_control(ulong trdc_reg, u32 mbc_x, u32 glbac_id, u32 glbac_val)
 {
 	struct trdc_mbc *mbc_base = (struct trdc_mbc *)trdc_get_mbc_base(trdc_reg, mbc_x);
@@ -383,6 +400,7 @@ int release_rdc(u8 xrdc)
 void trdc_early_init(void)
 {
 	int ret = 0, i;
+	u32 blks;
 
 	ret |= release_rdc(TRDC_A);
 	ret |= release_rdc(TRDC_M);
@@ -397,7 +415,8 @@ void trdc_early_init(void)
 	/* Set OCRAM to RWX for secure, when OEM_CLOSE, the image is RX only */
 	trdc_mbc_set_control(TRDC_NIC_BASE, MBC(3), GLOBAL_ID(0), PERM(0x7700));
 
-	for (i = 0; i < 40; i++) {
+	blks = trdc_mbc_blk_num(TRDC_NIC_BASE, MBC(3), MEM(0));
+	for (i = 0; i < blks; i++) {
 		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(0), i,
 				    true, GLOBAL_ID(0));
 

-- 
2.35.3

