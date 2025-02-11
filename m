Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B71C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 13:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69262803CC;
	Tue, 11 Feb 2025 14:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="J11IpJMk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D40D1807F3; Tue, 11 Feb 2025 14:42:41 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63A3380077
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IepUHv9ubKS/jAe+k1zX98Abzdpowlb4yvzjaNbim4JN/ZPDvXTG9YgOmUUnZlukn+cjIv/mBCZYULkGikzxKceAIUGwTdBjy13+1o7peuK/8LVDd3j5g7Lm6tsi8Cu3LXWvYNN9DPqRzSKCP0zxrH/LQXAgcPk2SsyNQIZbUdtWi3Dm6fRxSyx4m9fkvUkQiuN66afNAEtrjC1/yH2Q2IbKI3Z4QKoeOtJ4chm0/E0cbw1wVgldvHWyLv2yMqzsrJJiMEFWevEkBXKK4OvTPxm6Q219joVnzBF0+HduF1A/kCUi17PoXhY26/lBjk7KEEaeWSLoMaaq71M2c27pjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRCSDBWxsEUIMaY3zWKbTJT3btQR7tT0gUUjT9pF23M=;
 b=t8aaIyB/cRllK+FeJpdrUJir+SNw9ww248c8v5uwg72ZIA1E7ADz2Wr8d9Fco7FTxKawQFZTPK4on7B5smsHUrSTK5MgbNX5nsmoR+Smu6/hqUnbz1K3ahdRy2y3D5Nu4aOr+MbwuknAYVvDbyaEy9dzG9sblBnRr1SYVw/JV2EUASobQNhUPKWqlYIUlY9g2gyb1CENevhAa6kSB2AQpcAIEyTgyC0K/tyR7QTeDgxKYEVW/wlBhPV1+wmGhKO8zjWuVpD8ACWhIY/I1H+EuPPXGUOelgNZFUTMQUXHqChSZjSRUbVDkX5tsbs098wXESO0YkkJ/EIG6YU+YeKJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRCSDBWxsEUIMaY3zWKbTJT3btQR7tT0gUUjT9pF23M=;
 b=J11IpJMkf8dsahaq4wOm09Y1B/6JaLJeALkLD8IvgYd6W1sikFNcKZUYtEcVdMcvrb4k9DE+jkWds03kdCN4dwOg06JGCNbBZjYiXKNUfn7kVYJblv/JvBEriassYrCwi4BZL/alKLD7CjswwP1forr7F7Msu+5OeFtJfEMDjx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DUZPR04MB9726.eurprd04.prod.outlook.com (2603:10a6:10:4e3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 13:42:34 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 13:42:33 +0000
Message-ID: <1b826160-660f-425f-bb75-e1ef1e0c4f06@cherry.de>
Date: Tue, 11 Feb 2025 14:42:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rockchip: Fix SPL link error for Radxa ROCK Pi 4
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 marex@denx.de, dsimic@manjaro.org, jonas@kwiboo.se, benwolsieffer@gmail.com,
 a-dutta@ti.com, mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, s-vadapalli@ti.com,
 bb@ti.com, ian.roberts@timesys.com, sumit.garg@linaro.org
References: <20250211043335.92538-1-naoki@radxa.com>
 <20250211043335.92538-2-naoki@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250211043335.92538-2-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0095.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::24) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DUZPR04MB9726:EE_
X-MS-Office365-Filtering-Correlation-Id: 7658e7af-84ec-49a1-e8b7-08dd4aa1f03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmxDNVd1UCttZ0h4bjkyQzVqeVZ5Ly9KMkcydzRNM25VTENHR0VXR1NLVFdn?=
 =?utf-8?B?RThIZEdlQ1hJaFo0ckh3L0hHb3N2SU5yK1VXTlAzTHZkMnlYbU9XRUc4WDMy?=
 =?utf-8?B?SWtOMVRUODM1UE5jZDRJUmQ1R0RpZStFWS9neXJQd1ZQR2JWbVF5OUZpajhH?=
 =?utf-8?B?QmdCQnRSa2lRLzViRlhsS00zUzFRaDJMOUJzQnVZUS9rS0ZOL2FaTVUwQjEw?=
 =?utf-8?B?V0RUZnU0aXZvSUxzK0o1K2pXQ2FsVWR4Sy9RK2IzY1pGODIycWEwWlJ2QTlp?=
 =?utf-8?B?VTZMZ3REbUtxZjhpV2F1T3NlUUJrQW5DelVpemJ6Nm9XdElHbEhacGhqS3h6?=
 =?utf-8?B?NERpa2FpNmtlSW9vd3lGZEhRbnh2dUtkL2FERy8wZE9WSExobGdUKzhqZnpL?=
 =?utf-8?B?MGczYU50QXE1eFJlZm9Oak9saXdJUFVST3NsZHhGN3prdVZ2cWVwdktGbmlT?=
 =?utf-8?B?NlQxeFJ6eXJFV3B4Y0h0d3VlTXpENWZnL2NycFczTWlrTzBYSC9EK1lyb2xI?=
 =?utf-8?B?T29tMjNyMVlDL2MxMkw2RkdXdENUbWllS01oOWhaWHlqQyt1YjhOT3NubTYv?=
 =?utf-8?B?UlJhVW13cDJySm0ydTBjL3c2b0g5eEpUZEFFT0hkZ1BrVHplYnVLbTIrRExZ?=
 =?utf-8?B?M092NnVPMWNvUUloSzZYM0JOQjh3bGFhM2N0RDBXZDFSNDJDUm04RXgyTzF4?=
 =?utf-8?B?QjNPOVdaak1hODl0WURULys0UFdYY3dFczFvckhHL05RbUJtdmExQVNiZkkx?=
 =?utf-8?B?bkZ5VjRqTURaWVA1enY3Zyt1bWRQU2JZalJXZzhFSVJCUFZmU09WRXhWMFFP?=
 =?utf-8?B?Umx2dVVVQWJPTUMyTDI4clprRGF4aTc5NGJ0VnovNkpIdU03N3ZXU0d6Z1hS?=
 =?utf-8?B?Y0hMNFc2aFZZSGtBNnRTYm1YcG5TZWdMNXdEb0V0QXVqanFZZVNoTUg4REF6?=
 =?utf-8?B?K1NsMElrTmFZS3JIYnVHZDBYRXk2eE1vdTUwWmZhTjQ5dEI5WGJWekp5b1hn?=
 =?utf-8?B?YWtJNFhWakZveCt1RVIrU3JNQVlSb2ZKMWwyc0JtY2tpZlZWcGhxa1A0WFNP?=
 =?utf-8?B?am9HWCtNWERiUkI1UzA3Vlg1QnNxQ0FCSFQ2M0h4eWhsQlNTTXpvdTZuWC9m?=
 =?utf-8?B?bElRU0FYZU5Gc0Y5NzY0aUU0RzVyOUorV2UzMjNkdENGMkZhYnRTdHRBMnpa?=
 =?utf-8?B?dWRPWHpZQk1vWWpnT3VDeVpGRGhWTUt2bmZtTGZsL01aTFhReFhmdXdqNDBR?=
 =?utf-8?B?VmZPRW16Si9yVUtrb1ZNWUY5V0YyeFIrSkZYYWptVUx1SmtnSnJBbFJDenI3?=
 =?utf-8?B?R2wvNWJCRlNwVlpsVGpxa0grR2VLUEMwN0hLNTQxekc1dEZCM1VYY2pxSHFv?=
 =?utf-8?B?aHRydndpUFJVNitTZ0lUczlpR2ZRNFhHRERRTXlSSi82OHBCbGtxS0NmQW5I?=
 =?utf-8?B?RTdVaW9JVVRqT3N0aTlac0E2SmU4MjJFUm01RDZzNXdyLzluRGVtM3JZNEd5?=
 =?utf-8?B?Rm9DMUNTYVRBUm01S2ZJNEFqcUxoWk5KcU5hazM5WGUzcXNwQmdmQzVscWUw?=
 =?utf-8?B?NHE1NDNiSXA3YXNyOGtqNi96dDZmYXUyV0gwbjFJWkJXdVZCTVNnREg3SWpk?=
 =?utf-8?B?bnhoK2wvcnplc2J5ZGZEQmhxbU9lbkhjcEowdnhjMzMzM3gzK2JSTEF2Syto?=
 =?utf-8?B?NjVERENxMG55STZRYTBEOHQvQXlvL2N4T1drYXNiRE5VV2JzMVdvODJ2Q2Y3?=
 =?utf-8?Q?6xNAX0OGbP9UiyplJAKebwHTwmEMKO4v/A9VZni?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHYrVyt1bDBVakhuUnpFcTBhWnJYQjlFVlc3VzhGcnM2VTNpTU01cVoxQkRn?=
 =?utf-8?B?YmJyVXJvQ1VOM09FanhxUjJBcyt4MGNCWDhkbitkc05YSTBuUnhhU3RORlhS?=
 =?utf-8?B?aW11b0s4SXNtYlVWa05vMFJjL0MreTNTNkJHblRWSUdhWmdkYVdqelgyb2tp?=
 =?utf-8?B?UXhndTdYSmxCWVBZTWI5ay9HbUoyaGloc1ZWMFhoV3pvZ0MyT1dkVXM0S3NZ?=
 =?utf-8?B?ek80U05hY0huSC9wTnh1dlplNkJCUlpzUGplZnpCMnlJb0cyZXlQQXplOXNR?=
 =?utf-8?B?OHdTbEpvWFNGVFR1bVpRWHVaMlA0bjh1MmJVd2dBcE9PbE8waGUrUEtqU2hJ?=
 =?utf-8?B?VkZiMWZSN2VPVVM4NitGSUdCN3dYYlV1MzlCeTBTTXY3bENmM2N1WDYrS0hD?=
 =?utf-8?B?bnlKeXEwUlN3YWJ3bW1aM2x4Ylh0b2xzR3g1WE02bU5PbVBVTllwNDZSR3JU?=
 =?utf-8?B?MTd0Mm0zcithQVlxRXJtME9BTTJ6RlJaT0U2S1d5VDlnaEFiNSsweGErR2JB?=
 =?utf-8?B?ZTM4Rk4yOWtQU1V2U1J5ZW5ycVBKSkFPeS9PcjVSWm1wOW9TWEpNclBZZWdC?=
 =?utf-8?B?aXBoNGE0OW5zUHhCejNaZGdaTGMzWlJJMkNqaGpId2c5Qm1pYVNoaGxUYmFR?=
 =?utf-8?B?d2pEVnhHOGE4REhCRlZtVGs3a1hGRkxjcG9yM0pZdE1Oam1Fd01OOXdHWVIr?=
 =?utf-8?B?cjdrdU9mMUYrUUgyTkxQM2NOSVd1S0xtQzlCOUtZUjl2ZDBtSTVsRkRXYTZK?=
 =?utf-8?B?QWdacnIzZ3NlZTRNR0tQZkVPczlUUkxSUE9xd0VFcit3aWtNZ2VYbjIzNnpP?=
 =?utf-8?B?aW5oRG1wL0JmUVhhZTR5M1RjZW9lV2gzK2Nqek9WR2ZGaStJVzZLaFl6YlEy?=
 =?utf-8?B?cEM0RER1dEFOR0Qrc1JXblVxSXNnZW1Ca1VNa0o3Zi9idEJST2ljSUNtdUlU?=
 =?utf-8?B?UEhKYmlJaTJOSmh5bU1WUjNkQUxmS2VWNVNRLzBVcnZUbEorUlowbTdBRGsw?=
 =?utf-8?B?QWc1QTVoUmU2anYrUGE0OE9Hdms0aXBVK0hVU29FODFjVXVYc01uS3hQbXBU?=
 =?utf-8?B?WG40RWtXNFQrU3FNbzk1V0NTTGkrVS9KSlVzUTI5OWtMRlNOdkgwS01WYm5r?=
 =?utf-8?B?SjFiODY1RXd4NzFhZ2tNSkNXZWQrVHh0TFdUSUJRS1JNaFlNMTlEOWJoSlZD?=
 =?utf-8?B?ZzBNTE1PcXphbGFzYWNtelpHMXlPQW0rRW9ubUk5anZMTWxEd0h0QWxDZTE1?=
 =?utf-8?B?ODlxT0I2OFhFODM0SURGdjdFV2tVV1N0NXRSeUxVS1RkZWw1N2gxK3JGNFJW?=
 =?utf-8?B?OS9zd2NPWncvMndEQ01xV0Vyakd2bWFVUGo5RTVNNE85N3M4a2ZJRUJ5ZmNo?=
 =?utf-8?B?NmlFeGhoZlVWYzZmaVZBTGVOTWhMYzJrUXZqeE5EUS90K1haZnJCT2UvOFQ1?=
 =?utf-8?B?RFJYN3MyeGFpTjRRdWNLTGVBMHRaSlRjOHhxb0hDZHlSVkYrTXl3eWltS3RX?=
 =?utf-8?B?NG4yUGRtMHowRXpmZW9nMjU0MFZTSU5WaHVJUjN2WHZiMXdXVENnVWpMek9w?=
 =?utf-8?B?aWFaR1lVa0tQUWRCY1RHT01jZDVNM05McFlSMThTbVBTSUY1L2phL01zWExZ?=
 =?utf-8?B?SGxtZFI5KytCOUdJVEhxZ3FmVXpYL0dpWWM2ZVd5a0l0dnBxYkxiak4vQVU3?=
 =?utf-8?B?MzhyUm5uKzFERlJ4ZXBGVlI3U1Nub2ZsanJNenBMSElJOUlMR202R25MU242?=
 =?utf-8?B?UFBTTHVLbXFmMm5JYjdvbEFHeEtTck4zcVdwVTA1RHNRVGRhMDNER05qdFhM?=
 =?utf-8?B?UFNRdkdob0FSR1NwRmt6Ty9vbjZEVUk4c1h1eEJKdzllQjhPdlF6NmNRMTcz?=
 =?utf-8?B?dXFDNFBqOXVPazFlNHJraWRLSExTbWFJY2pSekhRYWd4UW9mY0N2S2FrSytC?=
 =?utf-8?B?dFRnUW1oOUoxMFlqRjBLMHRDWjJYOXJFdDVXL2ZQU0JYNkltQ3lLdDZNZkVE?=
 =?utf-8?B?TTNBakVaaGRoaE5FVDlZL2ZqZGxialp0MnFSV1oxQUtDWVJHSmFJaStyOFJs?=
 =?utf-8?B?WmRDTlJmRVM5aTZkYmhvUVVZcnBGL0ZKbGRJaW9kQ2VkVlBJbGNOYWZtNldt?=
 =?utf-8?B?MlhJeDI3UTk2K3lVamFnUmhyUFBrZnRkSzZWRGZLazBzSW0ybU9IcHpiVFRD?=
 =?utf-8?Q?7sC6SscchIgi9U30K8dDD7A=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7658e7af-84ec-49a1-e8b7-08dd4aa1f03b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 13:42:33.9174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYiVln1nSyRnyEC/Ov9yAIDiPaqqSi2M2wGqY50kKDrE1KikpYDHzJpk4lnXgxyZnZ0McgfMzEXWqRyE6VxcX/V9/oij51MiZRODrzD3tbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9726
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

Hi Naoki,

On 2/11/25 5:33 AM, FUKAUMI Naoki wrote:
> If CONFIG_EFI_CAPSULE_FIRMWARE_RAW, CONFIG_SPL_ENV_SUPPORT, and
> CONFIG_SPL_DFU are enabled, linking u-boot-spl will fail.
> 
>    LD      spl/u-boot-spl
> ld.bfd: drivers/dfu/dfu.o: in function `dfu_init_env_entities':
> /home/radxa/u-boot/drivers/dfu/dfu.c:173:(.text.dfu_init_env_entities+0x24): undefined reference to `set_dfu_alt_info'
> 
> Separate the EFI specific parts from board.c into efi.c.
> 

The issue here is not EFI, it's SPL_DFU. It's because set_dfu_alt_info 
is contained in board.o which is only ever compiled for U-Boot proper.

> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
> Changes in v2:
> - Separate the EFI specific parts from board.c into efi.c
> ---
>   arch/arm/mach-rockchip/Makefile |   1 +
>   arch/arm/mach-rockchip/board.c  | 165 --------------------------
>   arch/arm/mach-rockchip/efi.c    | 201 ++++++++++++++++++++++++++++++++
>   3 files changed, 202 insertions(+), 165 deletions(-)
>   create mode 100644 arch/arm/mach-rockchip/efi.c
> 
> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> index 5e7edc99cdc..cf66a507c8e 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
>   endif
>   
>   ifeq ($(CONFIG_TPL_BUILD),)
> +obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += efi.o

Please have a separate commit for moving the code into efi.c but keep 
compiling efi.o the same way it is done for board.o and then in the next 
commit move efi.o to SPL only.

If I'm not mistaken, you simply need to move get_mmc_desc and 
set_dfu_alt_info in a file that you'll compile only if 
$(CONFIG_$(XPL_)DFU) = y.

The "issue" here is that you need get_mmc_desc also for EFI, but nothing 
that cannot be fixed by adding some stuff to some header and removing 
the static keyword :)

Also I would assume we still want to compile EFI and DFU support in xPL 
phases, e.g. for using DFU in SPL to boot U-Boot proper?

[...]

> -__weak int rk_board_late_init(void)
> -{
> -	return 0;
> -}
> -
> -int board_late_init(void)
> -{
> -	setup_boot_mode();
> -
> -#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
> -	gpt_capsule_update_setup();
> -#endif
> -
> -	return rk_board_late_init();
> -}
> -

I don't think you should be moving board_late_init and 
rk_board_late_init to a different file, especially since this new file 
will not be compiled under the same rules as the current one. Therefore, 
we may now be missing board_late_init for some boards for example if I'm 
not mistaken.

>   int board_init(void)
>   {
>   	return 0;
> diff --git a/arch/arm/mach-rockchip/efi.c b/arch/arm/mach-rockchip/efi.c
> new file mode 100644
> index 00000000000..5173a7c1b4e
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/efi.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2019 Rockchip Electronics Co., Ltd.
> + *
> + * Copyright (C) 2019 Collabora Inc - https://www.collabora.com/
> + *      Rohan Garg <rohan.garg@collabora.com>
> + *
> + * Based on puma-rk3399.c:
> + *      (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
> + */
> +#include <config.h>
> +#include <clk.h>
> +#include <cpu_func.h>
> +#include <env.h>
> +#include <dm.h>
> +#include <dm/uclass-internal.h>
> +#include <efi_loader.h>
> +#include <fastboot.h>
> +#include <hash.h>
> +#include <init.h>
> +#include <log.h>
> +#include <mmc.h>
> +#include <dm/uclass-internal.h>
> +#include <misc.h>
> +#include <part.h>
> +#include <ram.h>
> +#include <syscon.h>
> +#include <u-boot/uuid.h>
> +#include <u-boot/crc.h>
> +#include <u-boot/sha256.h>
> +#include <asm/cache.h>
> +#include <asm/io.h>
> +#include <asm/arch-rockchip/boot_mode.h>
> +#include <asm/arch-rockchip/clock.h>
> +#include <asm/arch-rockchip/periph.h>
> +#include <power/regulator.h>
> +
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)

Considering that almost the entirety of this file is guarded by this 
ifdef, maybe make the rule in the Makefile for building efi.c only added 
when this is the case, e.g.

ifeq ($(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)$(CONFIG_EFI_PARTITION),yy)
obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += efi.o
endif

?

[...]
Cheers,
Quentin
