Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AD0C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 20:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB09E803B5;
	Sun,  9 Feb 2025 21:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="RH8agfgo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 415778083F; Sun,  9 Feb 2025 21:24:15 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B1180141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 21:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOeY5T15Lx8mzAuU/R8rbJECG7dxxobRIF6W9Jy0S6KZ89Pz4wRCeqtiblE8TQwWYrsOz+lK7SvNmN8zOffmiyj97DSKcDvzKe97G02WrsRXOUsxY+C2BbxOvnbNNfq5QtcDmEK6UD6jcj1OFzz53Yv41PDp71lprrjC2nyAOmHfLSiL6jKbPduBxI2uI4+tQ+rSIoTQ6vkdJXeVTWlQ+rTu2X3QxQKQLzEmO9NPsU3YxMLYosH/NES6OmO5wHTn2eC/rBYjql/kWVwpoQbno1PztWqiXJyWMIS/0qp0yzk6PddzOHoiRPxOrUP3pOTKbpCtX+B3XCftcOqhTUx2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NnaxivMzdKGWAQNIyK7tjy4g/mADKNU5Z5f4f7m42Q=;
 b=qmcjWYi3uh2X8xVeC7SR06bnOI7dy4BHmAsD0FuNRpRo/7ZNoZ1tNVEtePprNyHBOmuSSVImquG7BhUlPLtl6QQmR1o9U9/Yyy+lxMf5HVx97hJ5MwNPGeqHnTrD0uuWcniu2tbaBRP0TgaQH2MPnB/UaJQMpJaIVbxVmobxa1qGAP6IZMZLPW0q/RownkiArqzxHQA2nWu/KTNCrWuu/CphXOEr2IuO/kOnJGBnN4LpTbBgwCtP6/e5t98+lPjvaQM4TxyXjpoojyl4ytODVsD9DgcQpWyGHs2kUoE0ZWa1UTS7hqHlWMsIXxInHnHY89DqRi9Fv3eiu0gN1ql5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NnaxivMzdKGWAQNIyK7tjy4g/mADKNU5Z5f4f7m42Q=;
 b=RH8agfgosCXsi0zyLCw8aSoelz7mq69AFlVqp8ei1CMBc7AqX4D5S2A1dR08f0OIih+LZ+exjsWtfrTg2kDOhtIOGhrEXSfy5U5Li494Jur1M2LocjTw1Ip3HOBaaKB8nGbER21z0D7qk8c3ywIdX6CLLORu/6nJkwbI7o21jYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB9865.eurprd04.prod.outlook.com (2603:10a6:10:4f0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sun, 9 Feb
 2025 20:24:11 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 20:24:11 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 09 Feb 2025 21:23:53 +0100
Subject: [PATCH 2/3] mvebu: armada-8k: set fdtfile env from
 DEFAULT_FDT_FILE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-cn9130-board-v1-2-b94ab83e141b@solid-run.com>
References: <20250209-cn9130-board-v1-0-b94ab83e141b@solid-run.com>
In-Reply-To: <20250209-cn9130-board-v1-0-b94ab83e141b@solid-run.com>
To: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 188d44c0-adb5-42b8-33ce-08dd4947b682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGppZnlDSnB3SnVJcHExbFJuLzJlMUc0SWZiWUdUSXJ1MEdSa0Vldjl5bHZF?=
 =?utf-8?B?WGVPU3Rhbkc4TTRSeWFWbjkvQm13Y3l1bkd0N2hiWXFDVkhoeDl6U3pvSk5w?=
 =?utf-8?B?cXFMVHBkUDBoZ1QzdU5jSUllUWgxbTNwekk0OFMzSVFxU0ErZ3d5b1hISkk1?=
 =?utf-8?B?L1NpcS84NnpjQW5Sc2pIamFHZWJHbzkyRTdpSHY4V2lJekw2TmJUbDZpTXcx?=
 =?utf-8?B?NHZpUitCNVpyQmxETy9Tb0xVSm1MOHp5aWtOdTJhdXdScTNDR25GbkRxRGdC?=
 =?utf-8?B?eXVtT2kxeWlzR2d6UEphdFQ2YkNjSGpqRUpCMUtEeExpek9jNERUZE5TalhV?=
 =?utf-8?B?bVZTRnFEbDdRMFlIUElIWDMzRFkvZFo2Zk5XWHRpa2pBRjd0OFlQd2t5cnBO?=
 =?utf-8?B?L0dNTHhVWjRaVjVtWFVFNHNvNEowSFd6aFNuZE9IdGZWNytsNUVGZEtKT3hQ?=
 =?utf-8?B?cmlZclhFTEYzOVBGNFN5TDgreHRJSGE1N05kZjVPUDNidnpaY2ZvRzU4YUg0?=
 =?utf-8?B?MWdsQmlmcnBIY2hYbFdObVFWOFFaTHhYWmNQRXczQmtyaDd4RzZMS1RRSzZq?=
 =?utf-8?B?Zm45WmJJb2hFZDY2N1J1eGRyTjZ1bWhWamRQZG04Y3dYVmwzU2xvMnZucDc4?=
 =?utf-8?B?UWVvWXRVdWF5TGpNY0QrSXRXZ2JUU09yL200dkNHSG1kd2tvU2RvU2l4amlq?=
 =?utf-8?B?QjVzdlg5bW1vYWVEVWNXNWxiVHY5TEtDUW96TUwzM3dST3dNWHljbkRQTzJ4?=
 =?utf-8?B?MXdaVkZvUE16S1pDdlJMb2QxZ2UyNnJ5ZnBldjhlOEhiODd6bVdtT0F6SWVh?=
 =?utf-8?B?MzJkeStBMFVDdXlTbHE5QUNVbHF0V0cyeFRSV0dhZjRjUytsUXU1YlVaMk5M?=
 =?utf-8?B?Vm45NXQzaHlQeUEwaFVaOG83aGlvSm5xQVZEaTFJTk9Lb0FGbWZuWjJJQkhS?=
 =?utf-8?B?azB5bmUweFc4aFl4NVZpTFFlS2lMazlnNlZFRVc2SjJVdStONXAwbUNpenBW?=
 =?utf-8?B?TEU0MGd2ZUNVTzdFZnVZSFZVQ1hPYlhYTWZxY2ZiVVhjN1IybTBEUFUzbmI2?=
 =?utf-8?B?ZWNPREZ2RTd6QU5JenBORDNvcFh5Z1dRMGpmYWQ1WU5PeVlTbDlQUUZVZ21m?=
 =?utf-8?B?Ui9pR0lEQnFEcGxHTE9kTnlUSUtIa1Z0bGxyeVlmS1FMTG1Ob2x3L1pubUlU?=
 =?utf-8?B?WXNCSnA5bEdlV2xoSmM1eU4zeXNtMTd1YWhKeVZ1VWhQMDR5QWNsZGYxY2Iv?=
 =?utf-8?B?VUFuUGVXTGt2TzZUa2VpYkxJd2ZFWDJzNGtQTHJ5QkcyeG9sZ25YYzFOTlNS?=
 =?utf-8?B?dkIrMmh0RnJ1SDRNajErSzhnVkdCNkF0Y3UvSGZ5Q0d1U1VWZDJOSVk3UUpR?=
 =?utf-8?B?OUNWUjFxWGlUTVRCQWhJdGowUU15eFQ4Yk9VWW16WnM5N0ZuQ3FRbmREMC82?=
 =?utf-8?B?Z2hMWVBBY0hZckliMXEzRTFFWlJNeFVJcDZiK1NUS2NaUWorRzRSTFI3Y2VS?=
 =?utf-8?B?RjM0L3JDa2V0S2xuUDdJSjlFVnZqeUNqRG9sb3Q2NHNmQWdFVWVvSEtGTVNO?=
 =?utf-8?B?WHJrWEZ6NzBHL21McGlPRHM4bkdGRXM5eGZIcUlLYit3SlROT3lCYS95RXZQ?=
 =?utf-8?B?T1FMUFBWeVQ4TTR1ZXJDc3hMNnF0SU55ZU5LUUhtbFlqVWNPRzl0UDRKbVF2?=
 =?utf-8?B?NThwOGFNL1BpaFB4MUg2YXhRZXZrWDYzM0lYb2J0eHlxc093b01MbDJaOFgv?=
 =?utf-8?B?K2s2ODhXVHFONVhsZHU2Vm9kYTJSZDdkUnpwTUN6K1cyekVkR3RkMkdYbU9y?=
 =?utf-8?B?WTVIMGZ2NzNURUJmbWR1RDVaOFo2TVZhOENtajRrSHBhUmFJVTN6WmZLRTV5?=
 =?utf-8?B?ZmtWclRiakxVaGZJbEE1RVpWY01sVUlqN1g4ZUY0NzJaaW5xUk5adUd5Q2Jr?=
 =?utf-8?Q?uVO2Uki1qRYP509Rkopm50KMS4oBvJrh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFUwTk9YTnZ2MTdsN01mNmpxWWFMNzMwcUhVa0tWaDg1SFlQdGhzcnVYcnRW?=
 =?utf-8?B?WlJ2WE5zY0p0ckdESlRCL3hrYlo0SDhTWGJ3RGd4aHQ3b0U4RzZpanZUa3BJ?=
 =?utf-8?B?MWxFMm9jYnRKbHgydGx5aVVsajltZXc4R1NaYUFrS2hIVkhOeW10YTR3MUk5?=
 =?utf-8?B?a1ZmTTBNQWhScTBlbWpzcWJuOFR2Y0V0K0VBZ0wrVTJJRExIMExOS1JKVVZu?=
 =?utf-8?B?NHVteDYzTTZzK0d4bmViR2QrWkg0NG1RRTEzUGFsZHlyZ1ZOMW9XV3NvOW5N?=
 =?utf-8?B?dEI0U0RvUWVJK2w3NUNEM0luamlGa0IyVGxzTFpVUnpaZGxhQkxYZGtiZmhX?=
 =?utf-8?B?dzF5SjFRam5ZNnkrUFJkZWZtMXV5eE52WCtJN0FMTGl6RTZGRmlMaVF1Wjhr?=
 =?utf-8?B?d2xTSFFPcG1FbGt5ZnB3Y2w0UHcyYk92V25IeUZiQXJGUUd1TDNoaTNWSzVl?=
 =?utf-8?B?MWlwclRsT1BxRHlzUjhuYnEwZmxCMHpVQk9NZk52Y29qTFYwVlBDcXJjNEpY?=
 =?utf-8?B?Nm9OUU55UmloWFNPZmtZT2sxMVpRNU5Yend2Z2dGUVE1RE96WXlZRDZpNUZN?=
 =?utf-8?B?dnV6QXB3SDNnTmdUTHB2N2oxemxiZk53bmQ0NjRZZUFjcE5kR29kUTdqdzM5?=
 =?utf-8?B?anRsUnNUTHBhbC8zRTQ1V1A5WnYzZG10NTlNOE05eUZxYUxodCt1cGtOelpm?=
 =?utf-8?B?VTZZbXlITUsyNjdoSEJ5Zm1mZExTNEhZbERnV1RXc1lvUmxScWkvV3QvRHU2?=
 =?utf-8?B?YlJwUit3SWxWWTJSa0toSmxrWU5GK2FWejI1ck9qY0NlSEVkRDBLcTdPNkpj?=
 =?utf-8?B?RkVjQUlhZUdHaVVnWG9zblJZQXpyVWFBQTBnLytNR1Y0VHdzNkxMeFZoZVJ1?=
 =?utf-8?B?YVg1Rm42OGI1OFlWaDBGRjU3R3lRZ1NFN1lmWk5uZE9FTkJTeCszKzNvejJw?=
 =?utf-8?B?TUwyTUxleDBzVEpQTGpZeG9ZZTRzL1hOSW0zSTMvUWpWMFdXN1BkdFo1RFBH?=
 =?utf-8?B?ZmRFNkhSRVBIclU1UkQ0cXZIVmsrOVN2NUlYMHBIMlFDQmw1ZjU5akdiOHdx?=
 =?utf-8?B?dHozaUFGdlppeDZCdU9Xc3d4YW15VGhLVUZzSTB2YTloWE1XQkxCRjZ1VDFu?=
 =?utf-8?B?amV5cnI5VWRxbzRUbUx0NkFCa1R1d0RGUkhLcTMxb3lKL1JDcnBJY0VVUk5U?=
 =?utf-8?B?UGZiQ3dyalZkM3NZODdOYUZuNzhmNEsydmpDdzJEdzJwWkhSM1g3WjhiemZ3?=
 =?utf-8?B?UmNQNFJaMzMwU1Y2S0dJZTRkbjk4eHZrM1grT3RRY2RZTUpYazMvVUdOV1Rm?=
 =?utf-8?B?bEt4NElXeWJmYjlzNktkemFnTnJRK25yTVkvQUJuQ0JzNnhOTklhYmY2emVY?=
 =?utf-8?B?clJJbmtBV1dKKzBSSENaaXN0YTRubWtuV0NXbHBTSG1LM1VWS2h0MytZRVVH?=
 =?utf-8?B?enptejdFTVNuc1JlT2JnL3JMMURMazA2Zml4K0tkUDJ4M1ljQ0JNbmFxNXcr?=
 =?utf-8?B?SnZadzM2SmpKZnl0WEZ1RWVPYVppSlliMis5V3htd3ZGdVB4azRmWXdVQkdv?=
 =?utf-8?B?aFMybDNlSVVpQjFlcjlHS1VaOGNSS2FNT3d1TU05ZzhRUk5rb2s5WHFjQWFh?=
 =?utf-8?B?MDdjNW1NcHVGajAyc01vcUJXZTg5U3J0RElVd2VBM1owOGxJdEU5ZWVUMmxa?=
 =?utf-8?B?MkdjMTV3MFRnSGtYN1VxRWszMDE4VndyNTBIRXplN21kQXdOOUhQL0hmZWhw?=
 =?utf-8?B?R21zM0JOeWVCUW1NWndZM2gySi9TdEJyL1JPSlNFdG1KOUJwSERUY1FqT0Nm?=
 =?utf-8?B?WStPTENKN0hRSVZRYS9wOVhOMGgvMWtrVHVMV1RUcW1PeFFQcE9NZmZMWnJx?=
 =?utf-8?B?d1ptQ0YwRnRvcEthWmEzdVZPcHVUWFVtVG1ZT1h5VndPZjR5ZWZEdTVmN1ZH?=
 =?utf-8?B?dHV3WWhKSEI4SW1Ud3VTZmdMZzBwRjBQOFFDVm1HZE9YLzd4QVUvZDVzOUFx?=
 =?utf-8?B?SEU0UGVOVFZFQ0owS3JqZUlxcFhFSGdBWXVlcjQ5NUpxbGdNc3RQR0ZoeTBn?=
 =?utf-8?B?SEE2YTZEeUtrRWowZEFweGJNbmxxZU4vQlZpakdwaDBtaW5QVUkrblBsbUhV?=
 =?utf-8?Q?5T3Y4jqJZoa1ohERdMt10gSbG?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188d44c0-adb5-42b8-33ce-08dd4947b682
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 20:24:11.1025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoTMvtoN/difPsYSePADRCbBN7vrGOkqr+DjXCXUeb4KcybF9sxRp0Xa2sddR9VejRI2p1DE4s0k0bFkMyMqhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865
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

Developers find themselves with two options for defining the default
device-tree for a platform:

1. CONFIG_DEFAULT_DEVICE_TREE deciding which DT the u-boot build will
   use for itself.
2. CONFIG_DEFAULT_FDT_FILE deciding what should be the name of the
   actual device-tree file, when booting an OS.

Armada 8k config file used option 1 while adding a marvell/ directory
prefix. This causes issues when switching a board to CONFIG_OF_UPSTREAM
where the marvell/ prefix would be added twice.

Update the header file to set fdtfile variable instead from
CONFIG_DEFAULT_FDT_FILE. This allows clear separation between
device-tree for U-Boot and OS.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 include/configs/mvebu_armada-8k.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/mvebu_armada-8k.h b/include/configs/mvebu_armada-8k.h
index 6fedbe9ee386269533852ecc07667e77b11e83d6..cf2e92cf125576f6033a142b7ea40ccb19c92919 100644
--- a/include/configs/mvebu_armada-8k.h
+++ b/include/configs/mvebu_armada-8k.h
@@ -50,7 +50,7 @@
 	"fdt_addr_r=0x6f00000\0"	\
 	"kernel_addr_r=0x7000000\0"	\
 	"ramdisk_addr_r=0xa000000\0"	\
-	"fdtfile=marvell/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	BOOTENV
 
 #endif /* _CONFIG_MVEBU_ARMADA_8K_H */

-- 
2.43.0

