Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAD3C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A380809A5;
	Fri, 28 Feb 2025 11:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="u0tWXIpf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9AE9810F5; Fri, 28 Feb 2025 11:54:40 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 908C0807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aARzDQ1F35f1s8oohQg+qGFa7DcMc5Vd1C6Rq3HI1/Fi2J2VYshwtlYchB/JedoLK45pniYeUDm5Zb1F8PQU03TSl1u+0/rLLgS595pxx4wu0kts0BHt6dF6vW0JElMEfn9k/D3CBFzsBy85AxZDYNqh/7Cvt7SmjA99rQmE9VO2LczdWT9t3y5f/8ZLWehOjLwlM3EmQfyqzDsYvQdptISLbH+WhOE+XsttX5spJ3utJVEEKS1RUyIFoI0UlyEChRbWHgplROlwgiLwZfUNG6IpKPrfjz3yewj/9p+XOMkiLxcIFa3LexvZUGUGpkixDa1Ahz26C4/ZfkXDkDCJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJdzLrOFqoXxsGLrLCI7ipu0Hb9YBsUo0oWra69PDH8=;
 b=COEsK4vwH2ZmsnlPIYBvCNZQk+3txCbQEYbilb9+djBzX397wmjE12VY6qNnAc8EUIkkWSeCm4enRKC4GgYxmblY/FsCkdDrsRt1Yw2cD8sCKuXpnlonoyM4tr4fZsqFySb49xdMhZPVnBX01AdxSB1XQd/ar5CEsPn2ZW/Osr6Qesu0Qj0lf17URiPt3J1sQjdH8YDfua8/9CSgaFZ5TN4/YfWoYvke0gtw2rjPrsFzZI1VEIbSnCW3vlvvgIXua8L2hh1d7Dtk+ANHQXVVEDgkLqCWzF7cTRYJ/1CrjHSPr6zlC0o0bdel5QV1G3iEUUhQs718QsKS3nVCGdn0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJdzLrOFqoXxsGLrLCI7ipu0Hb9YBsUo0oWra69PDH8=;
 b=u0tWXIpfNvQQHWRMKjzOS4F2luSkSqKqLQHhUQlFjhdaNg8ZDcGI0NP85zgAtctunI8LRxyW2SXMnV8DHRJ4BKdmXq+YPDl8SeFKTE0LrBRTdIObzHSC3D3EtwJUBwds8FhbMxfx+7y4y83QXs5hQjB0q92sC7NtAL/+/ig2MDeA+7n0FSkozu+qxLlXmX4FBOafST6jrF5+vdSJLQ8iltLS86bISeREepdFY3ylq2uXXQjsnQIuEc/oKEwPcTWx9CL8HTd8IsfEQ3ddyxxIyr+xIJaXydYTRjNfdLWv7DUI5RKvQ646Y7GfNDYh3Csh7rVyw4q9sSDLECxYGi084Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7116.eurprd04.prod.outlook.com (2603:10a6:10:127::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 10:54:37 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:54:37 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:53:52 +0800
Subject: [PATCH v6 01/20] mailbox: add i.MX Messaging Unit (MU) driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-1-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: f21abd0d-e01a-464e-c24f-08dd57e64af2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V01zcDBZNnVqWkFOUmFxN3h1VmFsd3hINDYxQlRwL2FKaTd0cjNuNHZDTVlH?=
 =?utf-8?B?UitCeTV0UFM2N1NLaHoxdldURGlFb1JiWHVmbVdYUk52RmE4K0hqam55RU9U?=
 =?utf-8?B?UGlIbHd0aHNPL3Q5QUp4NGNNWG0vdzAxMkRSY0JjaHpVR2dCTWlmWkZ1dUVp?=
 =?utf-8?B?K2I2U2U0dHZLT0M3Z1ZIZUpFdHRsSGZuWXJIRW1xOFNXTElBdHdVL2pkWVBz?=
 =?utf-8?B?SjFvaVRBWWJGU3JqcXd3Ly9uU1V2VHlWdXhXWk1TZHUvc29tRktUTU95SEJ1?=
 =?utf-8?B?NXFJM1JaclptdFB3bjFaR1c4TW1La3A5U0VXSDdPWU9WYWhZVFNDSi9Kendn?=
 =?utf-8?B?dXE4MEU2Ykwzc0dBODAyZ3ZBWUlVajhoa2NpTW5qTG1IdDNQZENGdWpJVjhu?=
 =?utf-8?B?cGo2SzRrRFRaT3J4NG01RWVQWG83OURXY0pIVGR5TnR5V2Z6MXhnQ0pxS0Uv?=
 =?utf-8?B?aHNSOFQ1bGJaWEdjcy9UUW5PbWhSUjRrc2p4UVNTanI3cnR1cTgxajZwekVY?=
 =?utf-8?B?LytJSzg2MFA1aHB2R0t4YWI3ZGxzT1FJaVlVcE92VWx0RnhJc0tMRFdsbi8z?=
 =?utf-8?B?MmNPUU13NEtCbWhPSjVrRE9Vb0QzTGJYSmphaTFuaEoxQUxmNkY4MDljTDdx?=
 =?utf-8?B?T042Y1RWN2hrUkU3L1pvWUQzZEpPSVdEYXZ3YkdkUERpU1BGWGcwME5RY1ln?=
 =?utf-8?B?N0IrUWlaM3ZGM3gxaUJrcTdGeUVwQnZGREhLMXV3SjBsczN2ZDVDdnRYYXlI?=
 =?utf-8?B?SHg0TGdWWncvWkMxVXk4NXBzeXZVVUNzc2dJSEdKSXNua1YzSHJYVUdvczht?=
 =?utf-8?B?QVkvaGJsaTZ4cTFVRlM5ZGdPMWU5UUdxVmFGTUJGdXRrRGZVNTNvQXhGdXAz?=
 =?utf-8?B?dkJuZFRmRktHdjVkbm52ZzV6OTFBeWdnN3YyY1NHb1BhSXFxLytyczdRc2tn?=
 =?utf-8?B?a3N2T3VhMHl0WlNmZ21qSjRTNFpRSWx0NURuMSs1RjZqdm0xeXF2ZG1mdloy?=
 =?utf-8?B?UmtuaERhTG1PaHUrTkhDWkl3T090ejRHc1loMVVWZDVXM00wRXFWL29DVUZG?=
 =?utf-8?B?SmZrZkZhemdhaGlpYzU3ME1ZMlE1d1JKTnBJTjQvRkZmVzA5cUdRZXZDaU5v?=
 =?utf-8?B?eFhFdFJPL2RJSjZDbXVlQ2ZNM1RkS3JXSjdDd09VNFRWNndyWTZzYlBlWVBq?=
 =?utf-8?B?YVdDZk80Y0JhTjVsN0lEZ3FybVZ2MlRmR2VIZW83S044bC9HTmkrS09nNHBu?=
 =?utf-8?B?cjFsZThhVWhKT0xBUUNjdnEwNXVlNGc4dGlZMzhiQ2hYdU14MUtGOUQ5UFY5?=
 =?utf-8?B?UExBWnZQQmpmemhOaWNLQkp2VFlFc3QyV3VvMmZIbnlwVGRPWUhabFQrLzRs?=
 =?utf-8?B?aGlDVWVxR21vVUhuL012Q00rWDNLMm54LzBOcUhiUkFjQzBUL1ZuclRUcS9D?=
 =?utf-8?B?aVdCQWZaenJLeGJwWnZlV1BiMTFHZnJoUUVxd2NUSCtlN1VqQ0tCSVFyUWsy?=
 =?utf-8?B?ZmxHODdrWkRjOUFZWEJLWHBxL09WVHE3QUN2MTMwVUgyWjRDLzBYSnRMV0FY?=
 =?utf-8?B?V05MMGRDSkxYc3puUnhIOTkwZUp1ZHJCTWkyZnhQaFA0R1NKZVFHUk5Qa0F0?=
 =?utf-8?B?M0E4OUxQbWlQekxURUZtUW5GM2JwZkRZLzJFZmtVaG1BQ0U0SG5lcDdRS09j?=
 =?utf-8?B?TWI0U2RaUFhrM1dTdUM1MTVzcUlKNUcrK001QnpDZ0tKMU5iMnVNQnlESTIw?=
 =?utf-8?B?VTJ4alo5c0ZsY1JIRHp5VlRsMkpzb3lxVHFMUkxvNi9BbE1vQ21wVWl1cUZz?=
 =?utf-8?B?dkZrMzZBTGxidUFaQUlDditjSmF4Q0UwSlJHb3VNWUJQWWtZOG9iTk1Lbm5P?=
 =?utf-8?B?QW1Tblc3b3BibEpjWEJkUFpkRkJiOXMxdzE4ZFZ3T2Zkb09DcDl4eFg1SlY2?=
 =?utf-8?B?aGM4QlROSWpzcE4wQ0Y5N2lEWVowOHRVQ1pDMndqOW54bloxRWlLVm9RRzQz?=
 =?utf-8?B?M0FOYXVORy9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRjSGtHWXNSY2NVcmVwSmtRWkpkWFdTZ1dibUY1YVk2QmtZUHRKL2FLQVMw?=
 =?utf-8?B?YXdRbnZXNmZBSHJ2YzZ4RXJxcUFYWEFLaXN4SE4zaWZzMXFqazhRZHl2UGQr?=
 =?utf-8?B?UHV3SkllcTVtM3ZZci9DbG9RMTBndkM1dHJyeUVYVnZucld1aE4zdjd0V3Q4?=
 =?utf-8?B?VG9OSjQ3VldGY3c5TzRQV0dIOFFoVXFmSTIrVnR0QVBJRmtLOXE1dTEwa2Rn?=
 =?utf-8?B?VGRpRTVSMXd2Z1d4bCtjK2hoOWxmY05vM1gyN3hnY0F0dFlYZ2JoZ29ORnF6?=
 =?utf-8?B?MTY3M1pPRzlIK3Fuc3lyVVRkSkd0M1ZWei96RTlVL1JYUjdHL09uMGNvQ2RX?=
 =?utf-8?B?T3hJYnN6Y25aWktBZVRhNHU5MFRpR3ZSRHpuNXlsSENQRmNScGJMQ2xWQUdC?=
 =?utf-8?B?YUN1WDVYZDZWWmgzcUtQNVViOW5PTTdxREExR0pDZW5JTml3N1R1YkU2MlUw?=
 =?utf-8?B?SmpiWTE5eWNxTU50ZXpCanhWb2h5YVZFMlVqM2p0ZXRoZStzRjBxZmgzY0FU?=
 =?utf-8?B?UVFXbFArQUU0b2hoUjdTU1FsM1NZbXpoeFAwZ3BLMk40MC9kcFRSV1Y5ZUdy?=
 =?utf-8?B?KzNJYWhkRFJ0VEJmam9FTUVuM2ZGSldWTGpRejNhaXhtTkJ1YWw3ZU03U3Fq?=
 =?utf-8?B?OGQ0b0hnL1VYem84NktvRXcweDQ3S2J2ZzZnSHBObDladnphSmR1ZEw2ejRC?=
 =?utf-8?B?TDRNNmVJbEpiOGd3WFJSeVc5bm9zOEs3eUNMZTV6dXBkQWFITkxkT2lTYTRp?=
 =?utf-8?B?S0JONUhrVk1PM3VLeDJ5V2JYeG9RSXExdTZKUTdReDFJUlNRSDY4RXBBNWNR?=
 =?utf-8?B?azNhaVkwYVhVakVGTXlvWkpWUGNzTjd4YUVxSzZiWDRjejNkSTJ1QktvVkt3?=
 =?utf-8?B?T0pKSjdmb29IOTZGL2l2bXdwbUREaGZTTE9xTG4wdVQvR2Qva2E0eHhzWVB3?=
 =?utf-8?B?ck84VTEzOHlsaGpWY2cxUXFIaWlBMmEzTHgrNmpRek0ydUk1S2o1WkZhVmhh?=
 =?utf-8?B?bnVPN0RLWE5QUUoyYmEvU3JjRC93Vjg3UWlWTlJIZVl4SW5DbFJSL0FXRDlq?=
 =?utf-8?B?OW1pelhNdzBLdjcyZFJrSzJmRWlteVJzSVNkM3VjT2NhY1dsY0poNVNFeTVi?=
 =?utf-8?B?cWFpRXRLY0g3YXBIbURQUkthbmczVkhKTnRwL0U5TzVhWDR5L1RjM2VrUDRO?=
 =?utf-8?B?dGtGV2hpVzF3NE5HV3RXbmcvTTJTQ1VKelRtTE1aVWFDZlVHbzErNDZOYjNL?=
 =?utf-8?B?M2ZGa3I3S2lEbGMxcnMrZjhxeXBwRUdqb284UGEvUWk0Y1FaeHA2WFZQdGhY?=
 =?utf-8?B?dVpQc1VSUUdETWRDQVR6aTJUd1IvbmgxWHlycHl6TGlYdld6VW1BdVpTSks3?=
 =?utf-8?B?U0crdTE5SkNrNXBSTlo4bW9YMDJXUkZOMnV1NGYzZUN1Qm9LQUYzS2VkMEow?=
 =?utf-8?B?T2xlUDVORlNIR2tqTkszaVQ0Rzg0SnU1MUxad2pLUmxNU2FhMmtXM09zR1o5?=
 =?utf-8?B?WThaOWNFQVlJY1hlRldlejBXQzM1YVJQZnVpTEVxS0o2R1RYRGhYL3lMYTlp?=
 =?utf-8?B?YmtRK3pudlU2MHJaNCtuV3Q0RmVnTzA4V2JLSVBISVNJL1Nwd3pkVXA1VFlC?=
 =?utf-8?B?WnZ4dGpiTyttMlArNzUxUUxYNUtVY2ZsenN3S0Q4elcrdnMvMnJnbVNDRlp2?=
 =?utf-8?B?N2t1blpwb2x1VXBSQy90b3lEN25NdGRoMXMyc3BRVWlVN3oxTi9hZ1ZqVlU3?=
 =?utf-8?B?d2JoQ3Y1YjRGdFlSMHFJUWVvNW1zTUNXWEJWenpWN28xMDZoM1ZGTjZudDc2?=
 =?utf-8?B?OVJXWlRMVFI4MXRpa2dUSjJLUzhkZE1OWjdndG1CYWNFYUZRQWZYa2t3OEs2?=
 =?utf-8?B?VEdvSFgyWERldU8ySkJTZXozZVU4SXZkbGx2Y0V4OTM5ckpsc044RWl0WHk2?=
 =?utf-8?B?amdTT1ZVdzk4ZEE5NG9ucGpxSXNPK24wWUNZR0tTdmxYdXhtS3FHMFZpQmRy?=
 =?utf-8?B?UXZQSGdPN2dRWDY2UWQvN0JFVjFFT2F6eFVrK1dzNGY0SnBkRG9uMjQ1YjIy?=
 =?utf-8?B?YVozSm9DTlZpeERLcnE2cWw3UVhSR2xmTmtjalVZUUxkcksvTDNwTHlLQmhQ?=
 =?utf-8?Q?+OXQXJnmShGdB+H4mMAwAlRQ+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21abd0d-e01a-464e-c24f-08dd57e64af2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:54:36.9511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKKfc52HPm8bj0K/P72QHYgYxSDMoM57pjdIg1y48u+T9qMvR1s4nOFADFm+oYY57Hu92NolaW2o+OZ6SItejg==
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

From: Peng Fan <peng.fan@nxp.com>

This patch provides a driver for i.MX Messaging Unit (MU) using the
commom mailbox framework.

This is ported from Linux (v6.12.8) driver
drivers/mailbox/imx-mailbox.c. Its commit SHA is:
39d7d6177f0c ("mailbox: imx: use device name in interrupt name")

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 MAINTAINERS                   |   1 +
 drivers/mailbox/Kconfig       |   7 +
 drivers/mailbox/Makefile      |   1 +
 drivers/mailbox/imx-mailbox.c | 430 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 439 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 687262b355..f13629bc87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -315,6 +315,7 @@ F:	board/freescale/*mx*/
 F:	board/freescale/common/
 F:	common/spl/spl_imx_container.c
 F:	doc/imx/
+F:	drivers/mailbox/imx-mailbox.c
 F:	drivers/serial/serial_mxc.c
 F:	include/imx_container.h
 
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 67d5ac1a74..4d9f004eba 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -21,6 +21,13 @@ config APPLE_MBOX
 	  such as the System Management Controller (SMC) and NVMe and this
 	  driver is required to get that functionality up and running.
 
+config IMX_MU_MBOX
+	bool "Enable i.MX MU MBOX support"
+	depends on DM_MAILBOX
+	help
+	  Enable support for i.MX Messaging Unit for communication with other
+	  processors on the SoC using mailbox interface
+
 config SANDBOX_MBOX
 	bool "Enable the sandbox mailbox test driver"
 	depends on DM_MAILBOX && SANDBOX
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 6072fa1956..574add6000 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(XPL_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
+obj-$(CONFIG_IMX_MU_MBOX) += imx-mailbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
 obj-$(CONFIG_STM32_IPCC) += stm32-ipcc.o
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
new file mode 100644
index 0000000000..a33356ea7b
--- /dev/null
+++ b/drivers/mailbox/imx-mailbox.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <mailbox-uclass.h>
+#include <linux/bitfield.h>
+#include <linux/bug.h>
+#include <linux/iopoll.h>
+#include <linux/compat.h>
+
+/* This driver only exposes the status bits to keep with the
+ * polling methodology of u-boot.
+ */
+DECLARE_GLOBAL_DATA_PTR;
+
+#define IMX_MU_CHANS		24
+
+#define IMX_MU_V2_PAR_OFF	0x4
+#define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
+#define IMX_MU_V2_RR_MASK	GENMASK(15, 8)
+
+enum imx_mu_chan_type {
+	IMX_MU_TYPE_TX          = 0, /* Tx */
+	IMX_MU_TYPE_RX          = 1, /* Rx */
+	IMX_MU_TYPE_TXDB        = 2, /* Tx doorbell */
+	IMX_MU_TYPE_RXDB        = 3, /* Rx doorbell */
+	IMX_MU_TYPE_RST         = 4, /* Reset */
+	IMX_MU_TYPE_TXDB_V2     = 5, /* Tx doorbell with S/W ACK */
+};
+
+enum imx_mu_xcr {
+	IMX_MU_CR,
+	IMX_MU_GIER,
+	IMX_MU_GCR,
+	IMX_MU_TCR,
+	IMX_MU_RCR,
+	IMX_MU_xCR_MAX,
+};
+
+enum imx_mu_xsr {
+	IMX_MU_SR,
+	IMX_MU_GSR,
+	IMX_MU_TSR,
+	IMX_MU_RSR,
+	IMX_MU_xSR_MAX,
+};
+
+struct imx_mu_con_priv {
+	unsigned int		idx;
+	enum imx_mu_chan_type	type;
+	struct mbox_chan	*chan;
+};
+
+enum imx_mu_type {
+	IMX_MU_V1,
+	IMX_MU_V2 = BIT(1),
+	IMX_MU_V2_S4 = BIT(15),
+	IMX_MU_V2_IRQ = BIT(16),
+};
+
+struct imx_mu {
+	void __iomem *base;
+	const struct imx_mu_dcfg *dcfg;
+	u32 num_tr;
+	u32 num_rr;
+	/* use pointers to channel as a way to reserve channels */
+	struct mbox_chan *channels[IMX_MU_CHANS];
+	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
+};
+
+struct imx_mu_dcfg {
+	int (*tx)(struct imx_mu *plat, struct imx_mu_con_priv *cp, const void *data);
+	int (*rx)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*rxdb)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*init)(struct imx_mu *plat);
+	int (*of_xlate)(struct mbox_chan *chan, struct ofnode_phandle_args *args);
+	enum imx_mu_type type;
+	u32	xTR;			/* Transmit Register0 */
+	u32	xRR;			/* Receive Register0 */
+	u32	xSR[IMX_MU_xSR_MAX];	/* Status Registers */
+	u32	xCR[IMX_MU_xCR_MAX];	/* Control Registers */
+};
+
+#define IMX_MU_xSR_GIPn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xSR_TEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+
+/* General Purpose Interrupt Enable */
+#define IMX_MU_xCR_GIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+/* Transmit Interrupt Enable */
+#define IMX_MU_xCR_TIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+/* General Purpose Interrupt Request */
+#define IMX_MU_xCR_GIRn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
+/* MU reset */
+#define IMX_MU_xCR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(5))
+#define IMX_MU_xSR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(7))
+
+static void imx_mu_write(struct imx_mu *plat, u32 val, u32 offs)
+{
+	iowrite32(val, plat->base + offs);
+}
+
+static u32 imx_mu_read(struct imx_mu *plat, u32 offs)
+{
+	return ioread32(plat->base + offs);
+}
+
+static u32 imx_mu_xcr_rmw(struct imx_mu *plat, enum imx_mu_xcr type, u32 set, u32 clr)
+{
+	u32 val;
+
+	val = imx_mu_read(plat, plat->dcfg->xCR[type]);
+	val &= ~clr;
+	val |= set;
+	imx_mu_write(plat, val, plat->dcfg->xCR[type]);
+
+	return val;
+}
+
+/* check that the channel is open or owned by caller */
+static int imx_mu_check_channel(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	if (plat->channels[chan->id] != NULL) {
+		/* if reserved check that caller owns */
+		if (plat->channels[chan->id] == chan)
+			return 1; /* caller owns the channel */
+
+		return -EACCES;
+	}
+
+	return 0; /* channel empty */
+}
+
+static int imx_mu_chan_request(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp;
+	enum imx_mu_chan_type type;
+	int idx;
+
+	type = chan->id / 4;
+	idx = chan->id % 4;
+
+	if (imx_mu_check_channel(chan) < 0) /* check if channel already in use */
+		return -EPERM;
+
+	plat->channels[chan->id] = chan;
+	chan->con_priv = kcalloc(1, sizeof(struct imx_mu_con_priv), 0);
+	if (!chan->con_priv)
+		return -ENOMEM;
+	cp = chan->con_priv;
+	cp->idx = idx;
+	cp->type = type;
+	cp->chan = chan;
+
+	switch (type) {
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, IMX_MU_xCR_RIEn(plat->dcfg->type, idx), 0);
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, IMX_MU_xCR_GIEn(plat->dcfg->type, idx), 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int imx_mu_chan_free(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) <= 0) /* check that the channel is also not empty */
+		return -EINVAL;
+
+	/* if you own channel and  channel is NOT empty */
+	plat->channels[chan->id] = NULL;
+	switch (cp->type) {
+	case IMX_MU_TYPE_TX:
+		imx_mu_xcr_rmw(plat, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, 0, IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		break;
+	}
+
+	kfree(cp);
+
+	return 0;
+}
+
+static int imx_mu_send(struct mbox_chan *chan, const void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	return plat->dcfg->tx(plat, cp, data);
+}
+
+static int imx_mu_recv(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+	u32 ctrl, val;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_RXDB:
+		/* check if GSR[GIRn] bit is set */
+		if (readx_poll_timeout(ioread32, plat->base + plat->dcfg->xSR[IMX_MU_GSR],
+			val, val & BIT(cp->idx), 1000000) < 0)
+			return -EBUSY;
+
+		ctrl = imx_mu_read(plat, plat->dcfg->xCR[IMX_MU_GIER]);
+		val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+		val &= IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx) &
+			(ctrl & IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		dev_warn(chan->dev, "Unhandled channel type %d\n", cp->type);
+		return -EOPNOTSUPP;
+	};
+
+	if (val == IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx))
+		plat->dcfg->rxdb(plat, cp);
+
+	return 0;
+}
+
+static int imx_mu_of_to_plat(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -ENODEV;
+
+	plat->base = (struct mu_type *)addr;
+
+	return 0;
+}
+
+static int imx_mu_init_generic(struct imx_mu *plat)
+{
+	unsigned int i;
+	unsigned int val;
+
+	if (plat->num_rr > 4 || plat->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	/* Set default MU configuration */
+	for (i = 0; i < IMX_MU_xCR_MAX; i++)
+		imx_mu_write(plat, 0, plat->dcfg->xCR[i]);
+
+	/* Clear any pending GIP */
+	val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+	imx_mu_write(plat, val, plat->dcfg->xSR[IMX_MU_GSR]);
+
+	/* Clear any pending RSR */
+	for (i = 0; i < plat->num_rr; i++)
+		imx_mu_read(plat, plat->dcfg->xRR + i * 4);
+
+	return 0;
+}
+
+static int imx_mu_generic_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	enum imx_mu_chan_type type;
+	int idx, cid;
+
+	if (args->args_count != 2) {
+		dev_err(chan->dev, "Invalid argument count %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	type = args->args[0]; /* channel type */
+	idx = args->args[1]; /* index */
+
+	cid = type * 4 + idx;
+	if (cid >= IMX_MU_CHANS) {
+		dev_err(chan->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n",
+			cid, type, idx);
+		return -EINVAL;
+	}
+
+	chan->id = cid;
+
+	return 0;
+}
+
+static int imx_mu_generic_tx(struct imx_mu *plat, struct imx_mu_con_priv *cp,
+			     const void *data)
+{
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+		imx_mu_xcr_rmw(plat, IMX_MU_GCR, IMX_MU_xCR_GIRn(plat->dcfg->type, cp->idx), 0);
+		break;
+	default:
+		dev_warn(cp->chan->dev, "Send data on wrong channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx_mu_generic_rxdb(struct imx_mu *plat, struct imx_mu_con_priv *cp)
+{
+	imx_mu_write(plat, IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx),
+		     plat->dcfg->xSR[IMX_MU_GSR]);
+
+	return 0;
+}
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V1,
+	.xTR	= 0x0,
+	.xRR	= 0x10,
+	.xSR	= {0x20, 0x20, 0x20, 0x20},
+	.xCR	= {0x24, 0x24, 0x24, 0x24, 0x24},
+};
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx95 = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V2,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
+};
+
+static const struct udevice_id ids[] = {
+	{ .compatible = "fsl,imx6sx-mu", .data = (ulong)&imx_mu_cfg_imx6sx },
+	{ .compatible = "fsl,imx95-mu", .data = (ulong)&imx_mu_cfg_imx95 },
+	{ }
+};
+
+int imx_mu_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	return plat->dcfg->of_xlate(chan, args);
+}
+
+struct mbox_ops imx_mu_ops = {
+	.of_xlate = imx_mu_of_xlate,
+	.request  = imx_mu_chan_request,
+	.rfree    = imx_mu_chan_free,
+	.send     = imx_mu_send,
+	.recv     = imx_mu_recv,
+};
+
+static void imx_mu_get_tr_rr(struct imx_mu *plat)
+{
+	u32 val;
+
+	if (plat->dcfg->type & IMX_MU_V2) {
+		val = imx_mu_read(plat, IMX_MU_V2_PAR_OFF);
+		plat->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
+		plat->num_rr = FIELD_GET(IMX_MU_V2_RR_MASK, val);
+	} else {
+		plat->num_tr = 4;
+		plat->num_rr = 4;
+	}
+}
+
+static int imx_mu_probe(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	int ret;
+
+	debug("%s(dev=%p)\n", __func__, dev);
+
+	plat->dcfg = (void *)dev_get_driver_data(dev);
+
+	imx_mu_get_tr_rr(plat);
+
+	ret = plat->dcfg->init(plat);
+	if (ret) {
+		dev_err(dev, "Failed to init MU\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(imx_mu) = {
+	.name = "imx-mu",
+	.id = UCLASS_MAILBOX,
+	.of_match = ids,
+	.of_to_plat = imx_mu_of_to_plat,
+	.plat_auto = sizeof(struct imx_mu),
+	.probe = imx_mu_probe,
+	.ops = &imx_mu_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.43.0

