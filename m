Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C479CC87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 02:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72EA83102;
	Mon, 28 Jul 2025 04:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mQEeih9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C629830C8; Mon, 28 Jul 2025 04:14:30 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32EFB830F6
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 04:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jvi8lMAOK0jL5naQEuTBU8vSMqGMlUnnmqQMLMNu1uWat5dqYdAJZETWO0W9fZE2dnfWMln50a1GkZYwC4QAvSH7oxyS2CaHZwhBD2t6nx8D41PVlFyNWuou/gnWJC7z4aOFDY9scF1wyc7xTGvs8uLMOna7DoSQRZBe/Xix/GwUwYk6IoRc77W5/nKfyWDUfFuMFsU66Ulk/Dmm1W6mbiktrbaaZN0LqUKsi/v0F7uWlbkQR9AOU1OBI3c2Ox+gxoq8nQ7msHATlkkpDO7ZrLSAMN4LYWwWQa1JVJoftuwNZEtm+6UoLFzO8NK9h54fwb1SwjKp0j/LuC0W15jOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Z05glpCFSJvSzLGDmiF5c/f69KwTpqPnVGl9dGYTD0=;
 b=VMSfLXaEAJC8vyiIKxry/s5e/ClnNcIAa8njUnIcpEftHuH9OUh5N7CYgqVI3nna0hNaaZ/KQWCARhrPZAHBvLdvF/CV+mkanwJQcuo4y/lHxdyEK5PorjjNm4UKjAqIeiJsH9N8TOe0JunfBuk5aFCJg7L/BI2Z0ZbPcRI07KSujSee/KciMPnTGSCFV9frZ9nDXp0ATfgO5hWDBBV5ewG1dY452gRTeUmycaEHb3rHC95ZmTJXNU+Ho1d4XVEtCLqpD5MXMqCLviv3PwWlRrk+jN0N3MKKrhwxXxTiCQitOKppnqrKPGf4mez5l4FYiL7wkpxIyemfgwwLwABL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z05glpCFSJvSzLGDmiF5c/f69KwTpqPnVGl9dGYTD0=;
 b=mQEeih9NyxVldGvZGi0A0t7QotfA7NFbghbLUwY241VgVXlGH6h0ZsTHHKx7u4V/vdM/cnG34G9Z8mssTDJYsd0ymcCwKNLSfmgEimveH3frEgfL6lTGq/60KkxXLPBIWu6clUYUfDsF4+pQ516kt16amHUFLgo4q8j2YluPlbG2hAGrS7V/dSx4R99R2aTU+iaz+LccNiGLVqT1J8CO/cHYMA9T8+mWCy65Jm2jvnU6ZYCXD2DL55Zrca9WVl9rP50nFpJlqNiaLk1dt4miIAVEmDOW6ANtIz+aSq//CFIar1DY3oUt69rwiWGo6bw5EaUTR2bEEf3HJzWsLuXITQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 02:14:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 02:14:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 28 Jul 2025 11:24:49 +0800
Subject: [PATCH 3/9] ddr: imx9: Wait until dram initialization complete
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-ddr-imx-v1-3-73da75bb33d3@nxp.com>
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
In-Reply-To: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 "Tom.zheng" <haidong.zheng@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f70c7da-7261-4a45-451c-08ddcd7c7a39
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L25HTmlFM21YOWN4Rkp1M0twNXVSdVFEMXVoNWVEWXdJK05rTU1qZmNUUlVP?=
 =?utf-8?B?T0RHR3IxQTBERWN2V2draWhPYUZTWjhHZ2JIdlJqWU1jc0RnVFA2alNyNlJB?=
 =?utf-8?B?K2pvQVAySWVCYmpOVy9zL1JVY0lIRXUvOEt0Yk1vTXIxZkluaThNb01Sem5N?=
 =?utf-8?B?NlhiVGlmZmRWSHdnbDJTRzV2bXZLUlhVMzVPVk43U1J0dTN1a2pIUXVtTDBj?=
 =?utf-8?B?WXM2RmVmcmJ6Y2ZnMitqVFZrNmNRQTA0WWZqbzVRVXFWb014eXlGZnlYbm41?=
 =?utf-8?B?OVVhZFI2SzhsNEhKMy9aZlhDd1h6enJUUXByWUptKzdPUVVrRmNhaDNpMi9V?=
 =?utf-8?B?TjFTOE5ldmg4REhQa2QreWVUUzJFemp1VTVpQ1hiamdqMzZIcmZ4QllhME01?=
 =?utf-8?B?SjBWaHo1eXd1MVdiUWZpTmhNRDBVcEtkSVltbHJyb01Zci9ZQzF3enQvbE5Y?=
 =?utf-8?B?ZHk5N3VXbXdYK01ySXZJQm9JVEh5dEtBd2xBcWV5N1BQcGxqa0owMHAvdWhT?=
 =?utf-8?B?QmRYK1ZpaWhkclhUQW5SVlp2UC9nb01TMjN3TlFXTmZtKzBHQ1IwZ3RyVURN?=
 =?utf-8?B?dTd0eStoekM4RGFTTGhrQk9rZHJPdllVelVDYm5DdnJZb1d1ajNVU3BKRFZ0?=
 =?utf-8?B?RTYxTnpyNTlycDN5dzBhckdYQ1ZPMGJBNjRTR0pzVDU2NXFMNVBPaDZITDcv?=
 =?utf-8?B?WTRkVkhIem9Ja09TRHc1NVJRT3Y3Tnk4eUxxZTNadk9DT2VSS094djNncGVa?=
 =?utf-8?B?dStrcWFnWUR6c3duK09adjJFODM3ZWZsanQwNmpGUXB1TlV4cE5MMHloVFl5?=
 =?utf-8?B?dmo5VmVuNk1mQ3c1NEVkc243ZlcxUE13bUF1WW5xZ0tDZ0NJaWVZUzJzQjVI?=
 =?utf-8?B?a0NxWmNrSGtkWXlOMGRsemtidHNCd2VCaXU4ZEo0cTJuNEdIS0syY05zM3l2?=
 =?utf-8?B?d0VhTVV1TVk3VXlxTmxMeklLTHpUNjBsM0x3TElZTHF5cXJESkFCMFJYNDlM?=
 =?utf-8?B?ZkFDbVY4TE9EU2lVQnhWRE1LbkhVcDArSVU4V2p4cEhQYzFTMmEvYm9SK3B0?=
 =?utf-8?B?eUhXMVJuZEFIVHFud211dTd6U0crQVB6RlZIbTE0WkRsUnprc3lIN0MzNzZh?=
 =?utf-8?B?QlJyY2E2VTZRMmR5UkxvTkVzbzRjZElLckhVRkhNQjdNK3hZWFl1UG1oNHgv?=
 =?utf-8?B?dGxBZG1uT0p0K0VlNmk5RTcyRjRIekFDcTZVaGpQM1BLcWtYdUQwUHkyQkdJ?=
 =?utf-8?B?VHpFLzV2M01IamJmTDIxWlQzZmtubnQ1ZmFkODM0UWZkUkxlS1ErUGFYQU1z?=
 =?utf-8?B?eGhXY08vTDgrcEZJUldhNHN4S2Y5Rk9MQWsvb2hQbkxiTEdsVDdZRkVVYjZO?=
 =?utf-8?B?ZTNsQ0dIcnUrSWN1bWVpaUgxQ3FTOGFhNXRUZUxINGJCUDRGYWUydFl0ek9R?=
 =?utf-8?B?WDFXUFhqSDMwYm1DZUc5YUhaRDh5TGVxZGxGR2o3QSt6dkIyUnVQSURiSysv?=
 =?utf-8?B?UVhDZmJuSlo3WHE3OWIycGkzM0lEcGRwbFZBYWsvc2YzNUYzT0ZmSnQyZ1F3?=
 =?utf-8?B?ajFjTGVjOHNvMTQ2cnovL2ttQVhQci9KZnFBenV5NjdNRS9FYlNwUXZXcUxM?=
 =?utf-8?B?NDliMGpERlpUS29aOXBFRDBSckEvUFR2dGs1MEZjRUFabjZSakxoTmRXdG9K?=
 =?utf-8?B?Uzc4dkRFMkVLS0FLRktZMGd5aW1pS1lKR3JrK1pGQjd1YWFBdFo5WkZtRGQ2?=
 =?utf-8?B?Zm9KZk9NUi9FMGdZQVB3VEE5eVBTN3E3M1N2ckg1VVVraXYrVlVIWWoxT1VW?=
 =?utf-8?B?bFRPZFQzWFh6V2RULzQ5UnhmaDI0SlRxZGR0cnNqLzBqQmhkS3BMNjQyYmtu?=
 =?utf-8?B?WkY3cEQ1dnc5Qkk5RXA3dklhWlgzVENDVlMvY01sY203VXpvUTZ1cVRrd0ta?=
 =?utf-8?B?Z2FwcWxoKzlTWEFlYlB4TnZlN3ZNYmdFdnNnRTVMckcrbDlTQXVCV2VwdFZF?=
 =?utf-8?B?VklLN3BLSTB3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak5jclA1TE4wMnhwRzJNb2dTbE1yeTI1QVF0U0FjRmFjMFg1cGRsekEvS0Q1?=
 =?utf-8?B?WVNlNlhmWGkxV0VRckFYNFJ1Y3FGYkZZNHhJZWdGaFFrdERaSVJ1NWlnRzJH?=
 =?utf-8?B?OGhTTjhSSjhVMm0xdDdvZEtmbmx5cmYrRVpzaDBKcExCOVNpM0xhYVIweUNW?=
 =?utf-8?B?V21Oc28vUGtqV0ZPVzkwSTRId0FybjNURUNmbGEvb3V5WUJRbDEzN3Y4UFZP?=
 =?utf-8?B?aWNQQTEwdEt3VkdtMHJNQ29kenNETTIydGc1emVkOTVHclJBOElqNURGRkVK?=
 =?utf-8?B?cnk2Tk4wNFNOSnZhUnAvT1k3MUp1ZHp0NWliWE41OTZ2UWdHeFNWR1VQTGo0?=
 =?utf-8?B?WWI1TGpDMFprOGRoT3ljaXJObEk4bk9IaGE4TU0xMEhNbjFwWEplcHVWcXV0?=
 =?utf-8?B?Yk5ocmxHekpvQUJjWUxSZ3lRemg3T1FnejAvbzRsTXdnTGxrZ3JQU0xTRk9z?=
 =?utf-8?B?RUhpMWJ6WGVVODBjK0M3NDluaEZaeU9mSmplUTh0ZGR6a3hsSTBEbXV6WHll?=
 =?utf-8?B?T093WXU4MHdTL0YrZW9mclhqMTc3eU5YdTQxRVIzSTVoRThCTGhZMWZPZDd4?=
 =?utf-8?B?RUVYc1YyU3JpYmVkdWxZMllBNHgxNjg1YUozVGZubWhPNTlST0hHUFlHRkhS?=
 =?utf-8?B?RklPUVFOcE8rQlR5cXVFU01COWoyU2NIZHNxN0lZL01qZDZlczhLYnZ0aFMv?=
 =?utf-8?B?OHU1MGNqaUEyV2E3M3JDRTRaNTFkQmJZSlg0RE5yNTVWTEpuRWlDS2kxckR1?=
 =?utf-8?B?OEEwaXlxbnpkVjdudy81ZUJKWXRZWUNnNmxwRVFMdmdRTmc5THdsb1NjM1Rw?=
 =?utf-8?B?ZDhMSCtMQjBGc3dBVHFyNDljVTdtN2hmZ0F1K1ltcG04WjY3Tm5kTGhmczRR?=
 =?utf-8?B?c29CV3M0Nk1RbXAzRENPMjVXcTNFNW44dXMxSjVxcTlqd20rdVNhZEtSWXRp?=
 =?utf-8?B?cS9LMmtsVEZHc25qQkZFRWlkS2pGQW8wMFM0YnlnUnFYdU9EeE51R2FSeFcy?=
 =?utf-8?B?ZGFncERZVm9pNU9ZdnFtTXNvU1dVeWN3Rm9yUk9DdFRaL2hwN0VnQWtic1hF?=
 =?utf-8?B?dDM0QUYxcWg5K2JSTWpveDJFc05hK2NrL0xyc3Nodkk0NkZFTlg2QjFvL01F?=
 =?utf-8?B?bzV5U3BvZDhzRzd4Q2dMWndZL2Z1SlB5UExPb1RWREpkSFBYY1VaZWt3VWxq?=
 =?utf-8?B?TW5laXJjbVYxN2hBQ1llVTBZNjBLck1teWwyb3h0SGJzODhYMmp2TXFoZyt5?=
 =?utf-8?B?RkUvODlmbVVZcUJxZmpNQkttelhUN2pTRjkzVkc0eGVjVHBKaDdCTStMQy80?=
 =?utf-8?B?S0szaDUxNDNkREIyZFJ3TmdaZnBVU2VCUnI1U25hZG0va3FKSmdpZjZoM2Yw?=
 =?utf-8?B?OTZsVitzaVBnY01jNnVXOXQyY2wzS3k2RG00cGN5V0FGSFp3VmdQZ3kxVkxz?=
 =?utf-8?B?K0NhVm1VQUh0U3hTdHpOdjBHNDZKOW02UEk2QjVqeGlqTTUvN1BzZzNTTWsv?=
 =?utf-8?B?Qis2M01TVXJpYkF3MnVBVWdCTCsvUEtIWHlKSktLTjRTMmdUKzZRRmVlTHpY?=
 =?utf-8?B?VVcwMDZ6dzJhUk9UZCtON3o4UWUzcWMvS1Axbm1mRldSaG40a0g2c1ZUVUtl?=
 =?utf-8?B?ZzY0Q1BkNmdMNUVyVjZGSVI1VGZ6NXVHZUtHT0tBTlZ5SGNCdjg4Ym9GRGgz?=
 =?utf-8?B?c2Z4b2orM0NJRitBbjgyMTZzMUZlQmwxODZtcXNNd01sVlF5UkpyUjB5RUF1?=
 =?utf-8?B?dDJjZERVK0JIOEtIOTJoM1dzeTZOWFp1UExMaWw3OXF2QWN5M29BZUpOR2NM?=
 =?utf-8?B?WlNYOUdGN1JYdWNzWWdpZnpDNnVrblF0YWVTcUttMWdMNExpQXJKUnQzQWUw?=
 =?utf-8?B?Q0FwYWE2clU0dDVhOTRqcHpuLzZsZDF0U1EvZXY5b3ZPZzdkSEFzVDJnazdM?=
 =?utf-8?B?RXdrNkpHRkxaVHJtYkFVbmV2Q0lBOW0rSW9wY1dWYlZEKzFKVXdHN050d0Fu?=
 =?utf-8?B?UlU4YmRnU1JUN3ZOMDc3dHp6VTRFTlZFSDZHcThOWHd0OVFpREswVDdZc1pL?=
 =?utf-8?B?Qm5yTHFBN2hCb0c0OUkweWlWaFB6QU45cmxNcE5pcU1hZFhra2YyVVBCejdJ?=
 =?utf-8?Q?GzX6OG1VaxxWTqSTNXqepyxwE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f70c7da-7261-4a45-451c-08ddcd7c7a39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 02:14:26.8707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IS3i44fRB2P6AyibUAhHNjAtRWQsiwpBiiVwPtnu+qWb3huc0CREUfb7XBptzDEkU/BnvbodcoMEwX7mizwv5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
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

From: "Tom.zheng" <haidong.zheng@nxp.com>

If the DDR data INIT bit is set, and ddr is running at low frequency,
need to make sure DDR initialization complete before continue.
Otherwise, unpredictable behavior when inline ECC id enabled.

Signed-off-by: Tom.zheng <haidong.zheng@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/ddr.h |  1 +
 drivers/ddr/imx/imx9/ddr_init.c      | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/arch-imx9/ddr.h
index a8e3f7354c7b3557b14e6f81c93d7c719171aa4d..31c420198f667f0dd334c896fe9ab0b06797641e 100644
--- a/arch/arm/include/asm/arch-imx9/ddr.h
+++ b/arch/arm/include/asm/arch-imx9/ddr.h
@@ -19,6 +19,7 @@
 #define REG_DDRDSR_2			(DDR_CTL_BASE + 0xB24)
 #define REG_DDR_TIMING_CFG_0	(DDR_CTL_BASE + 0x104)
 #define REG_DDR_SDRAM_CFG		(DDR_CTL_BASE + 0x110)
+#define REG_DDR_SDRAM_CFG2		(DDR_CTL_BASE + 0x114)
 #define REG_DDR_TIMING_CFG_4	(DDR_CTL_BASE + 0x160)
 #define REG_DDR_DEBUG_19		(DDR_CTL_BASE + 0xF48)
 #define REG_DDR_SDRAM_CFG_3	(DDR_CTL_BASE + 0x260)
diff --git a/drivers/ddr/imx/imx9/ddr_init.c b/drivers/ddr/imx/imx9/ddr_init.c
index 7bade70bd0a1ca4d205ff4fb8525511188cb504f..5a134dda78a331c21d4a75b2369c5b9314028bbc 100644
--- a/drivers/ddr/imx/imx9/ddr_init.c
+++ b/drivers/ddr/imx/imx9/ddr_init.c
@@ -342,9 +342,11 @@ int ddr_init(struct dram_timing_info *dram_timing)
 	unsigned int initial_drate;
 	struct dram_timing_info *saved_timing;
 	void *fsp;
-	int ret;
+	int i, ret;
 	u32 mr12, mr14;
 	u32 regval;
+	struct dram_cfg_param *ddrc_cfg;
+	unsigned int ddrc_cfg_num;
 
 	debug("DDRINFO: start DRAM init\n");
 
@@ -387,6 +389,20 @@ int ddr_init(struct dram_timing_info *dram_timing)
 
 	check_ddrc_idle();
 
+	/* if DRAM Data INIT set, wait it be completed */
+	ddrc_cfg = dram_timing->ddrc_cfg;
+	ddrc_cfg_num = dram_timing->ddrc_cfg_num;
+	for (i = 0; i < ddrc_cfg_num; i++) {
+		if (ddrc_cfg->reg == REG_DDR_SDRAM_CFG2) {
+			if (ddrc_cfg->val & 0x10) {
+				while (readl(REG_DDR_SDRAM_CFG2) & 0x10)
+					;
+			}
+			break;
+		}
+		ddrc_cfg++;
+	}
+
 	mr12 = lpddr4_mr_read(1, 12);
 	mr14 = lpddr4_mr_read(1, 14);
 

-- 
2.35.3

