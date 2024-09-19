Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E401CDD563
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ADEF8906C;
	Thu, 19 Sep 2024 02:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dxkbLo0M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB5B88909E; Thu, 19 Sep 2024 02:15:22 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F4589058
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMSToKy9iQ3kMlu5LUUfEA4kg0Kc2iHBQVXPlD8FOscR3GF50JL9+3JFoNEXWQYzMlQWklQ3C4GlnE7D89/0M1F6px1itBoOfe8bur/05VLs71rBWBPi7klGxhvMBTrTFqk2ydz6PDPY8CxTA3ualPuDlBi0fARape5nsOH6MAWRXIobMrx7+IIGx7vY5mVBIo/r2j5hcnbQrRITDJhUzuSLbDQKbsHAGQFlP4ZXfuP7ErhoYBgzLnXxwz3FfwpzLiwlxi/Q8DpOHefGo9eC6cv6ML+v1bvGeQcEy1zEiIRvd1dz9c1VhvfnT9hd3lTPd0QT5YzZmnV2ZdBvReuDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6fnzm0rjhJpueGPrYN4e8wozfwyaiqaL9ngkNfeHds=;
 b=hTZJDAW6aCEbwG72smykzoHeDLTtHFvaiwXj7Ve2U+/tJK10cacdZahd1nigB+GiKRCsCiC/dVUuPLVG4LUJH3o7/yaFU+dBpbDq3u/Ug8Nz9cvLuhoJGANGM82Vf1/nV6ozTzAHKWLAwpY2UHt2/7bpt2D/LtefDIxJdIZKuj/7rP8JFgWjryzxyn7oLOpF2fFjaEyVDNSHEcaTiJkdpG6DdPGt7Mv7c1Yj9y9rLtW6VZHAxXPe32ULrtMeohvnnp+MOapQK8Q4nGq47E7gnZMrSx0/6/gem0n5JzKM7m/mD7xIXGGmzPcMxjVzUG/QGmHpblw7y2DwpGbSiMQn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6fnzm0rjhJpueGPrYN4e8wozfwyaiqaL9ngkNfeHds=;
 b=dxkbLo0MyssCvQvZ3jFDhaO+I8wY8aFdQnZEmSMKcLxScG+Q7Jh1q43y7w3zoJUFKWOTbVDaLLCORIKjQVH6zSU3HSoJSmWI59lUF00hY55Nc/2Y/mf1YCg8qiJvB85BJwi3jqLh9AyNO0mSg7x/FXKR+Ym3QtpNU8W9dfVjogZiicd2BK3Jlp4diqA4WVpTsICHvBMum5ZTIeOBQHGgrUzDc/i/NX/2ln6qh2MokLx+yp2oiZlkDxJcIg1LITI22rc4g3mEBQSTLRtdnoLtcIhYThWolj67Bxc36XL7AQwYbcDPDa6eFK2WhJ1C5z6WVo4WzUqf4mg0f8iD6alB5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7872.eurprd04.prod.outlook.com (2603:10a6:102:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:15:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:15:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:16 +0800
Subject: [PATCH v2 17/21] imx9: trdc: cleanup code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-17-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 79329751-18f9-4cc3-f519-08dcd84024d2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NklFZmNNZy90bndpVW9aUEc3YWgySzFjTXkwZWdGdTgvN2gzVUJIc0QvR0NI?=
 =?utf-8?B?TG5Ic0puWVJnUHdiSVNjZHpsTmMwZUFpSWoxVGF0bG92MUVFQm9pZmVNM0lt?=
 =?utf-8?B?UXhIMEVlblFodlJkdU9ORng4cm5reExpUkhrZUtZd1JobXU3MUZOQUhGaGxi?=
 =?utf-8?B?NGN1dTF3MUNJUVg2blZHRUVWTkVqcEduaFBPUzFtWHFFZXVjaHVLYm16cWlB?=
 =?utf-8?B?eUZQRnRmNUE0dVRrdkdKdUZ6VzBvZFVFS2tZbDZmWnVSRCtCcC82clpXcW1J?=
 =?utf-8?B?YW1FVFYzSUFwaHo2TzBrbTIzWEt1UXNycUN4R1pNRkhhZm1DR1VpSldoMzFk?=
 =?utf-8?B?cGw0Mlcyd1ZXV01DNVlUNGtRanN0ZEpadU5nQ2I1QU5SV3NXN3JZeTc4Yitj?=
 =?utf-8?B?Z25mZUxkTllHNng0aFdLNytiT3dVdjQxUWEzNTVHL0xNRXNmamFQWWhUSnFX?=
 =?utf-8?B?U2J1VXF0V3dTN05VL2hXbWlmOTM2UHdNMCtEUmdyWXBuMDlUREJuS01oSXNW?=
 =?utf-8?B?NWpwZ243T29vcEw1K0UyOHptY0tvN3M4eVZjNjhDSnhNUS9aNXlTbWhhSzly?=
 =?utf-8?B?U3htVnRTb0VkUVU2OHJPVUF5QkJPSlJueEZQVnNoVDFOS3Rwa1VXNlBYNHpH?=
 =?utf-8?B?Mm8rQ0RFdzlvR0FlRVZGUG0xYm9tUTBMU1d4bGI0WTA3dGhTQk9kcnYxR2dv?=
 =?utf-8?B?UE5tZktVNW00anRKNEQyMlUzbXljV3lKbGZFaTVWK2pOQktrZGR1S0FaQVZW?=
 =?utf-8?B?Wk56bXJjOW9EUFQ4SXNJdzFRZWtOekU1UFllY1c0bUdZYjV1SHEyZlI3OWli?=
 =?utf-8?B?VHpyaC9qNWxObnZrTnc2RXkycDhUTEtVWXovcGYyVVFZTDJFM2V6emx6RGVC?=
 =?utf-8?B?WndGaThVMUtOSWY0NzFUSUtLSEJqQ0tCYVFndnQ1cFZTODRoYURIQ0xYTk1t?=
 =?utf-8?B?a2RMdGsvc0JRelhDeEQyNHErcjVaYU9INDZxZE12MUJoTlEyaGpBeUlvcUMx?=
 =?utf-8?B?bDdCYWJHOERVK0MyQUlrT2s3Q2RxS09EWjcxZVdOMEc0OW9QTU0zV1l3aWw4?=
 =?utf-8?B?cWxBMzZNeDNCL2N3Z1E5MGw4bmFYSVExOFJNQTBkNGRZSEI5YVczL2xGeUFo?=
 =?utf-8?B?NGNzdGhQdzBRdWRlTG00aFlhY3ltWkU4ZWJwS2luR054dlh3VmluUlJ2eTYw?=
 =?utf-8?B?TEZqbnhGcjRNWklzMVZaTDFTd1pwSHA3U2ovdzNaNUQ5Sm14SDI1elh4MSt2?=
 =?utf-8?B?SFFIYzFOd3VWRVo3TWlVN01VL3RjTDY1MXA1dlpSNXhrVk5tRHVuZ1d3UHQv?=
 =?utf-8?B?bWF5NTBZQnNNUVFKVURvVEpQUGx3OG9zOS9hbTB2SmhieGd2Q3VucjliOFZi?=
 =?utf-8?B?ZnVta1Rjc0E5bUY1K0kxVXAzbk5jUkdxOFM4VldZVnNSSU00M1VXM3RYTTdx?=
 =?utf-8?B?cnN5aWxyd2lVdG04RG9PSWhaWUVMTTF5RVVnZ1kySEdmZVJlM0ZITVlRU0Rp?=
 =?utf-8?B?VXBMZHIwMnA2b1MyZ0JOQ296RFlZWXRvUzhXOXZWL2Exc0JhMGc0SFFKbGIy?=
 =?utf-8?B?NU44a04vOUNKUm5vcHBVOXdpTTFSRW9CUld5aGFCclh4Z1pvZ1llSDVhM0RT?=
 =?utf-8?B?MmlHeFdmd3JPVEc0YmF6QlBWWWNqT3lJbnRlZ05FN3Q1YTkzRDBrdnU0OUli?=
 =?utf-8?B?UmFWNGkwK2FLekNGdytLamFwOEIzRVg5eWdLQ1F6bkR2TWVOdjhBMWFMbG1s?=
 =?utf-8?B?MUdrREgxNldiNDRvUEZUUDZYZkpoakVxblB2T0w0aEtFOHVFMHV0Qjc0VWNj?=
 =?utf-8?B?WXBHRWEvNnlucEZNd0NBYnJDRnBKNTkyVWtnUG92b2grZ1J2ZnBPOGZ2WEdi?=
 =?utf-8?B?bDUvNUlWVy9qSzQvRmRMK29ENitVbXRZZEZ4ZExSMXRjcGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjRzT0FJT1c1RUhxK09TNHM3b0ordk5rVVhzTnpkVDJoQVlEZ1NGN0FBY0J4?=
 =?utf-8?B?dnBVeSszZXZwK3ViRUh4S3dMZkZvSEVkSkFJS3RkUlhrR1pvUFNSYVdJeHFZ?=
 =?utf-8?B?eVZmTWUyWEY4MERDVFlqSDVWWlNSclNraWV1MHZ5SFExYzFqRmFMTm45U3da?=
 =?utf-8?B?MTJBekRON3gxTlZzdTYzaTNlTk81WXBLcTk2emt4ZFF3c2RDMGxXdS9EalpO?=
 =?utf-8?B?Y0FTMGNIc2ZHdXhSdEYreDQ4TUNQN2xaZkRReVNJY3E4cU1QTnBSWDRUeWgr?=
 =?utf-8?B?MElNWjRNVnkzdGZnUGI4bkRzcWRnVUFTQkZqOVNua3NYNy91YXV6ejFnSXA5?=
 =?utf-8?B?d0ZISGp4dHRaM05pSlVEQWthNC9pQUEyeGJ1c2FDQWdQY05Oa3Z3ZEtwTC81?=
 =?utf-8?B?Yit6VmFaYkt1OENkTU1wQTl2aGsrVmp5RTJ3RVZ6TXZreXludEE1c0pmMXho?=
 =?utf-8?B?c3hpd2IzMURmdUQ0ZmFuN1ZEcS95REdaOXJQZUlzOUZWdldmTkFyaFkyRVhL?=
 =?utf-8?B?STB0YkNnOFNUTDgrdSs1cUJONVdaeENsemNEMnhUMU5ZeHJzV0ppS2NNNjk4?=
 =?utf-8?B?eGljTnhUejFLcjRqOEVsVFVmaEJXdDZLSG12bHpXOUV6UWFxcXlZdWwxSVdh?=
 =?utf-8?B?ai8zUzN4Y2NDYVZVOEYrS0RqWlpNdGVLTlBSZVZGVVpkcmdDSTdxMnhoNmJQ?=
 =?utf-8?B?V28rOWVtMmlLNUVEaU5FU2ZIVE9QYlAzQndzL0ZCWHhmUWFqUlVWejRSMFhh?=
 =?utf-8?B?cWhTTUdzYVFhY3FlZGpEak9hNXExMFNtdjNjdHYwdCtLZ0ppZ3VZbW5wbExN?=
 =?utf-8?B?U2FITDRLMUNkTVhqdncvMUsrOGNCci9Jb0RzWHFIaGRmWWVqTmZHWHE2TDdD?=
 =?utf-8?B?TnFQTkJDSHNSNUhXUUVYZWZCa1o5Y1RqWG40clVFQlBkUEt4ZXZyU1MxRXhq?=
 =?utf-8?B?emx4NVljclp0VFFrdmd0dGY3dlkrMWJrNVpNWml0bXQ1VW5XTnVzVXhyWXJT?=
 =?utf-8?B?d2p4Tk1hd3RoK3V1TGR6MHBlWTk2LzdkOEJWdFhQcXp1NVlYUkFXRkVvN3Yw?=
 =?utf-8?B?aGVWdnc5YVZvbXZvQUl3K3RRVkR1cVlwVmQzV05XLzdiRjQ4czZINGhMdFZn?=
 =?utf-8?B?RFpuQkNxZHFXVFdNZTJrOUUxVVF4S2pIczhSVkFOY1M4aHdwWldscVhGbndr?=
 =?utf-8?B?dEk5TG5YUzBCR3BBWUlhTzVsVUZNZGJIb2VMNVg1ZVIraVNXUG1LOGFmcC83?=
 =?utf-8?B?ZjlZZ0ZZdHgzMWRTeHdXbEtEN0Q1RFRiUTVFRk16bnlRYjUxbkRuZFpZVmtr?=
 =?utf-8?B?Q3dZeFZLR3NZcFdnWi9USVpQeVlCV1lYMW4yV2h6ZGJjcWlaeERRbHBSQlU2?=
 =?utf-8?B?OGVDQ1BrSmx2ZTNuVlV5aUwrVWdyS0xXclhrVXFFL2ZFZ3IvNnpCZ1drN1FY?=
 =?utf-8?B?RlN5YjhubTRpcTFRU2hRU0Y5OTdLekptUkdhV1lmKzY3OW1COVl0Vjl2SnZ3?=
 =?utf-8?B?REd0cndVT3Raa25UUEtUcjdodDhkSmJVVVN1Rm9ZYXlpWGRHbHNqVC9XU2RG?=
 =?utf-8?B?NnhUUXlGc2NOYTdaTkNjTlcrNUU3RUtqdW5QUkErcGx4eklVV3FwN1N1dlAy?=
 =?utf-8?B?RzRjUUJNcEp3VnZJUTdTSTJ2aWcxT0plc3ZFTXR4MVBxa01LWFIxWDMvdjUx?=
 =?utf-8?B?OEVJNG1MZU5FVDNIK0lWNmJpdjdSUTR1UGlqVHcvOGUrODM2SEhTc1NxNWZC?=
 =?utf-8?B?QWxQb0h3ZDd1VGxlN2lEcU1OT3ZFRkxwY3VMUHRwYkxsYk1FRkQ2WjBJMTZz?=
 =?utf-8?B?cWJkTUZmdzAzSktKUDNzcDlSQWw0NUxrRjg1UUpzMDRhRFExTldHVjNnZHJv?=
 =?utf-8?B?UkhSM2l3UE5XcXdaWTMwNis4YTZPaE9GbjBNZjhBREpwM0hUTHdZaGN4bHhr?=
 =?utf-8?B?V0d1N3FLeU56RUJFdW05b0w0V2kxWDlNZlovQ2ptdS80dytFcHE2T3JsS0dV?=
 =?utf-8?B?bTNTaUE4djRXK0s0V0NaSUpFR3RkaXdYclBXVGtyenEzTm1uZ01hbG5ndG1C?=
 =?utf-8?B?UzRZN01hdzdwZzBrUE1nQ0prV2d5UjNFeExhblJvUkJUV3g2OTBQS2NrVUIz?=
 =?utf-8?Q?n3zfsuz3ZQqSecNKJ4y3Dxm3B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79329751-18f9-4cc3-f519-08dcd84024d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:15:18.8095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMqqzCry7grfgH+NYgSA/BDV1P4cqbMEq7ygn2KjIIZc8263d+Sn5wYZ4j7aak5RtwoPcVK4V7MvYaFSJdCBiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7872
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

Replace magic number with meaningful macros.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |   5 +
 arch/arm/mach-imx/imx9/trdc.c             | 156 ++++++++++++++++++------------
 2 files changed, 101 insertions(+), 60 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index cb6b8a59cad..ef9538bd42e 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -50,6 +50,11 @@
 #define BCTRL_GPR_ENET_QOS_INTF_SEL_RGMII        (0x1 << 1)
 #define BCTRL_GPR_ENET_QOS_CLK_GEN_EN            (0x1 << 0)
 
+#define TRDC_AON_BASE		(0x44270000UL)
+#define TRDC_WAKEUP_BASE	(0x42460000UL)
+#define TRDC_MEGA_BASE		(0x42810000UL)
+#define TRDC_NIC_BASE		(0x49010000UL)
+
 #define MARKETING_GRADING_MASK	GENMASK(5, 4)
 #define SPEED_GRADING_MASK	GENMASK(11, 6)
 #define NUM_WORDS_PER_BANK	8
diff --git a/arch/arm/mach-imx/imx9/trdc.c b/arch/arm/mach-imx/imx9/trdc.c
index 8cdb28459a3..ae1a46d1331 100644
--- a/arch/arm/mach-imx/imx9/trdc.c
+++ b/arch/arm/mach-imx/imx9/trdc.c
@@ -4,12 +4,13 @@
  */
 
 #include <log.h>
+#include <div64.h>
+#include <hang.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/types.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
-#include <div64.h>
 #include <asm/mach-imx/ele_api.h>
 #include <asm/mach-imx/mu_hal.h>
 
@@ -19,6 +20,25 @@
 #define MBC_NUM(HWCFG) (((HWCFG) >> 16) & 0xF)
 #define MRC_NUM(HWCFG) (((HWCFG) >> 24) & 0x1F)
 
+enum {
+	/* Order following ELE API Spec, not change */
+	TRDC_A,
+	TRDC_W,
+	TRDC_M,
+	TRDC_N,
+};
+
+/* Just make it easier to know what the parameter is */
+#define MBC(X)			(X)
+#define MRC(X)			(X)
+#define GLOBAL_ID(X)		(X)
+#define MEM(X)			(X)
+#define DOM(X)			(X)
+/*
+ *0|SPR|SPW|SPX,0|SUR|SUW|SWX, 0|NPR|NPW|NPX, 0|NUR|NUW|NUX
+ */
+#define PERM(X)			(X)
+
 struct mbc_mem_dom {
 	u32 mem_glbcfg[4];
 	u32 nse_blk_index;
@@ -364,68 +384,84 @@ void trdc_early_init(void)
 {
 	int ret = 0, i;
 
-	ret |= release_rdc(0);
-	ret |= release_rdc(2);
-	ret |= release_rdc(1);
-	ret |= release_rdc(3);
+	ret |= release_rdc(TRDC_A);
+	ret |= release_rdc(TRDC_M);
+	ret |= release_rdc(TRDC_W);
+	ret |= release_rdc(TRDC_N);
 
-	if (!ret) {
-		/* Set OCRAM to RWX for secure, when OEM_CLOSE, the image is RX only */
-		trdc_mbc_set_control(0x49010000, 3, 0, 0x7700);
+	if (ret) {
+		hang();
+		return;
+	}
+
+	/* Set OCRAM to RWX for secure, when OEM_CLOSE, the image is RX only */
+	trdc_mbc_set_control(TRDC_NIC_BASE, MBC(3), GLOBAL_ID(0), PERM(0x7700));
 
-		for (i = 0; i < 40; i++)
-			trdc_mbc_blk_config(0x49010000, 3, 3, 0, i, true, 0);
+	for (i = 0; i < 40; i++) {
+		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(0), i,
+				    true, GLOBAL_ID(0));
 
-		for (i = 0; i < 40; i++)
-			trdc_mbc_blk_config(0x49010000, 3, 3, 1, i, true, 0);
+		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(1), i,
+				    true, GLOBAL_ID(0));
 
-		for (i = 0; i < 40; i++)
-			trdc_mbc_blk_config(0x49010000, 3, 0, 0, i, true, 0);
+		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(0), MEM(0), i,
+				    true, GLOBAL_ID(0));
 
-		for (i = 0; i < 40; i++)
-			trdc_mbc_blk_config(0x49010000, 3, 0, 1, i, true, 0);
+		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(0), MEM(1), i,
+				    true, GLOBAL_ID(0));
 	}
 }
 
 void trdc_init(void)
 {
 	/* TRDC mega */
-	if (trdc_mrc_enabled(0x49010000)) {
+	if (trdc_mrc_enabled(TRDC_NIC_BASE)) {
 		/* DDR */
-		trdc_mrc_set_control(0x49010000, 0, 0, 0x7777);
+		trdc_mrc_set_control(TRDC_NIC_BASE, MRC(0), GLOBAL_ID(0), PERM(0x7777));
 
 		/* ELE */
-		trdc_mrc_region_config(0x49010000, 0, 0, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(0), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* MTR */
-		trdc_mrc_region_config(0x49010000, 0, 1, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(1), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* M33 */
-		trdc_mrc_region_config(0x49010000, 0, 2, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(2), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* A55*/
-		trdc_mrc_region_config(0x49010000, 0, 3, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(3), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* For USDHC1 to DDR, USDHC1 is default force to non-secure */
-		trdc_mrc_region_config(0x49010000, 0, 5, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(5), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* For USDHC2 to DDR, USDHC2 is default force to non-secure */
-		trdc_mrc_region_config(0x49010000, 0, 6, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(6), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* eDMA */
-		trdc_mrc_region_config(0x49010000, 0, 7, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(7), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/*CoreSight, TestPort*/
-		trdc_mrc_region_config(0x49010000, 0, 8, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(8), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/* DAP */
-		trdc_mrc_region_config(0x49010000, 0, 9, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(9), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/*SoC masters */
-		trdc_mrc_region_config(0x49010000, 0, 10, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(10), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 
 		/*USB*/
-		trdc_mrc_region_config(0x49010000, 0, 11, 0x80000000, 0xFFFFFFFF, false, 0);
+		trdc_mrc_region_config(TRDC_NIC_BASE, MRC(0), DOM(11), 0x80000000,
+				       0xFFFFFFFF, false, GLOBAL_ID(0));
 	}
 }
 
@@ -504,78 +540,78 @@ void trdc_dump(void)
 
 	printf("TRDC AONMIX MBC\n");
 
-	trdc_mbc_control_dump(0x44270000, 0, 0);
-	trdc_mbc_control_dump(0x44270000, 1, 0);
+	trdc_mbc_control_dump(TRDC_AON_BASE, MBC(0), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_AON_BASE, MBC(1), GLOBAL_ID(0));
 
 	for (i = 0; i < 11; i++)
-		trdc_mbc_mem_dump(0x44270000, 0, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_AON_BASE, MBC(0), DOM(3), MEM(0), i);
 	for (i = 0; i < 1; i++)
-		trdc_mbc_mem_dump(0x44270000, 0, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_AON_BASE, MBC(0), DOM(3), MEM(1), i);
 
 	for (i = 0; i < 4; i++)
-		trdc_mbc_mem_dump(0x44270000, 1, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_AON_BASE, MBC(1), DOM(3), MEM(0), i);
 	for (i = 0; i < 4; i++)
-		trdc_mbc_mem_dump(0x44270000, 1, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_AON_BASE, MBC(1), DOM(3), MEM(1), i);
 
 	printf("TRDC WAKEUP MBC\n");
 
-	trdc_mbc_control_dump(0x42460000, 0, 0);
-	trdc_mbc_control_dump(0x42460000, 1, 0);
+	trdc_mbc_control_dump(TRDC_WAKEUP_BASE, MBC(0), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_WAKEUP_BASE, MBC(1), GLOBAL_ID(0));
 
 	for (i = 0; i < 15; i++)
-		trdc_mbc_mem_dump(0x42460000, 0, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(0), DOM(3), MEM(0), i);
 
-	trdc_mbc_mem_dump(0x42460000, 0, 3, 1, 0);
-	trdc_mbc_mem_dump(0x42460000, 0, 3, 2, 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(0), DOM(3), MEM(1), 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, 0, 3, 2, 0);
 
 	for (i = 0; i < 2; i++)
-		trdc_mbc_mem_dump(0x42460000, 1, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(1), DOM(3), MEM(0), i);
 
-	trdc_mbc_mem_dump(0x42460000, 1, 3, 1, 0);
-	trdc_mbc_mem_dump(0x42460000, 1, 3, 2, 0);
-	trdc_mbc_mem_dump(0x42460000, 1, 3, 3, 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(1), DOM(3), MEM(1), 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, 1, 3, 2, 0);
+	trdc_mbc_mem_dump(TRDC_WAKEUP_BASE, MBC(1), DOM(3), MEM(3), 0);
 
 	printf("TRDC NICMIX MBC\n");
 
-	trdc_mbc_control_dump(0x49010000, 0, 0);
-	trdc_mbc_control_dump(0x49010000, 1, 0);
-	trdc_mbc_control_dump(0x49010000, 2, 0);
-	trdc_mbc_control_dump(0x49010000, 3, 0);
+	trdc_mbc_control_dump(TRDC_NIC_BASE, MBC(0), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_NIC_BASE, MBC(1), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_NIC_BASE, MBC(2), GLOBAL_ID(0));
+	trdc_mbc_control_dump(TRDC_NIC_BASE, MBC(3), GLOBAL_ID(0));
 
 	for (i = 0; i < 7; i++)
-		trdc_mbc_mem_dump(0x49010000, 0, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(0), DOM(3), MEM(0), i);
 
 	for (i = 0; i < 2; i++)
-		trdc_mbc_mem_dump(0x49010000, 0, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(0), DOM(3), MEM(1), i);
 
 	for (i = 0; i < 5; i++)
-		trdc_mbc_mem_dump(0x49010000, 0, 3, 2, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(0), DOM(3), MEM(2), i);
 
 	for (i = 0; i < 6; i++)
-		trdc_mbc_mem_dump(0x49010000, 0, 3, 3, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(0), DOM(3), MEM(3), i);
 
 	for (i = 0; i < 1; i++)
-		trdc_mbc_mem_dump(0x49010000, 1, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(1), DOM(3), MEM(0), i);
 
 	for (i = 0; i < 1; i++)
-		trdc_mbc_mem_dump(0x49010000, 1, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(1), DOM(3), MEM(1), i);
 
 	for (i = 0; i < 3; i++)
-		trdc_mbc_mem_dump(0x49010000, 1, 3, 2, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(1), DOM(3), MEM(2), i);
 
 	for (i = 0; i < 3; i++)
-		trdc_mbc_mem_dump(0x49010000, 1, 3, 3, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(1), DOM(3), MEM(3), i);
 
 	for (i = 0; i < 2; i++)
-		trdc_mbc_mem_dump(0x49010000, 2, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(2), DOM(3), MEM(0), i);
 
 	for (i = 0; i < 2; i++)
-		trdc_mbc_mem_dump(0x49010000, 2, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(2), DOM(3), MEM(1), i);
 
 	for (i = 0; i < 5; i++)
-		trdc_mbc_mem_dump(0x49010000, 3, 3, 0, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(0), i);
 
 	for (i = 0; i < 5; i++)
-		trdc_mbc_mem_dump(0x49010000, 3, 3, 1, i);
+		trdc_mbc_mem_dump(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(1), i);
 }
 #endif

-- 
2.35.3

