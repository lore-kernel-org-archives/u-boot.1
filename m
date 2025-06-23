Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AC6C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 05:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7433A82D21;
	Mon, 23 Jun 2025 07:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NR0FdG2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D463F82E25; Mon, 23 Jun 2025 07:52:32 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4C7A82D17
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 07:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmivsOvGG+P9y3XZ1yKvSwMlTzoxVDTSh6vHD/fBjvQ0F36L4JXeBnLCQcgxZKtbJBJPKCowKkPF9ZumePB0/cJAxTS7tf0lmKKCEmS/gs81xjtVoteciinwU2kKpqE9hCF1iWxmEHrRSTk27H2X3675jR8qN54bud3276R/GN2b60Eg20VWCY5v2QREtBemk6YrcqaKv8vh65/M2d1m7S/7JP4fkie5r738sRaWUjawIcsaTxstEcfc3nnjeKikiO/Ff7DujyUbTfSznMqNLLTZHSVmTpRjp8thNBfAjODk6cBU1UgDuMP1Wid/ezznv7ZniENakcdVoBknTlaZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quE++ZyGIB7hDaSa/msKEAVscF1Lu4UnJEHa1ryn7HI=;
 b=skDdfl0c00yg+BYVNIuEfl8bnCrI0LjkuuzJ8bypeTTOPVDULlg4o2is5YMSahZxcaOCjU5XxZurvUl0QA2358Bj+pGiNGmysLDeDmeLtLx70LAbRUwlzTmBTRWScQ4UkCmxlN7TrZo1H6b/OC9GiDh8dISsFghwqOQB3XM1BOvJp6HR7HF7MVSE66KXqlD4BfM5kuiLL8+mYhBRZ7iBzn5Lr+Hjg1MSteKEPjfjJud9DE7eZTr3bVZx/MY5BkO8oR9NwY5OCUO7lradAR5z6KhDGcecqiM8/eT/fCtScc50Vy4LjKJqsDjHQZKgcI4IT4HCTy6wrq0C6CSY/sDtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quE++ZyGIB7hDaSa/msKEAVscF1Lu4UnJEHa1ryn7HI=;
 b=NR0FdG2Icc+mRAGBRMR0283hfOajCdWxRxY2/OuLZeHJ6RFkZ+gbdUn/SMUcEGtWDMa/fof3y+VgK6O3EiFYxD60CuJDjrHiHVDUn25iHVzmxZIFD7tWL+//kII3bTyjRGVHqKSp97S1k9isB1Up4aJXRwsQsVGhGcNJodut0QSYTMFKLpx6BhSNRmJnvBAxR8DE4w0KjKs14SwjdDeBZkNB7iicwXjrjo5UvNP9g0djNLYQTAblxhNXD7/KMiUJ1Z/4pQJ6yC8Kjx+ZUkHP7n1K4RN6PHrKJ7R7ezbDJNyZeoUcH2+eNAe9EtUvFy6GRInyTQGMI4LM3/ET1j9zdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10671.eurprd04.prod.outlook.com (2603:10a6:10:582::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 05:52:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 05:52:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 23 Jun 2025 15:02:33 +0800
Subject: [PATCH v2 5/5] imx8mq: evk: Add support for capsule update
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-sr-v2-5-e97fc53f0f8d@nxp.com>
References: <20250623-sr-v2-0-e97fc53f0f8d@nxp.com>
In-Reply-To: <20250623-sr-v2-0-e97fc53f0f8d@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10671:EE_
X-MS-Office365-Filtering-Correlation-Id: de07839b-8794-4f5d-4346-08ddb21a2390
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckFiSVpOakJ1R1FFUmxsRitrekN0QUdoeTFtVFR1eVh4SnZnNXdlZ2dEQVZ3?=
 =?utf-8?B?MzNqaWRnOVlDSTJob0hJTmVKZmFBbEthZkJDVkE4MTVYaTZ5QUl4N3hKSnR2?=
 =?utf-8?B?OFIyNCtvRnNNVXNqSnJJRHUweG9mSUh6cUZOV1VlUW5oTHZhcFBrWEJQYUpi?=
 =?utf-8?B?ZEhOalNqK1dzUHRHb041SDA0bjZXYmh4T2dETDlDUWY4Qi9IMG14bnZTd0Jy?=
 =?utf-8?B?SUlGcWM3WVJHSE9lYjRXak80M3hEMkJRUTArY2xtQkh3bHBXTVlOSVgrdHgv?=
 =?utf-8?B?dHJvUjkzcENodXczbUtCVllQV2pJcytGQmxKWEhuc0haTlZUK2xFd3R5bEdH?=
 =?utf-8?B?TGxkMG5jWWVReU9aamRaSGIxdTlUQTVkK0toUGc5YndrMWVjbWZZY3E5MXhj?=
 =?utf-8?B?SlVodUk0M0htUm8vNEIzbmdIaVBHZjlWdjkrZ01RbmFCRlpXbEFxSzBEaXRI?=
 =?utf-8?B?NGhNWW84b2hTZ3IrUnNaSUlTeTNpZkwrWnQydHNkYmg2bXMxQXhQdlVSM3pY?=
 =?utf-8?B?OW1zQVQvazhYdm14S29UMFA0aFhNUVBMUFZqWGtQWWcwTm5rWFgxU3dEakRW?=
 =?utf-8?B?QnM2QWtrSmtYVHJ1ejUwTVJaSG9QYXZoMCtnN3JsM2E5TGxwcjhxU2Yvem1u?=
 =?utf-8?B?RzE5ZlBpVWQ2MDZLelNNY0ZyMlJjYk84eW5yQnk3aENrM1JFOFlXV3V3QzAz?=
 =?utf-8?B?VzNuQ1BYdjRqUmFzcWM0ekUxNExQME1qNjcrRzJJQ1RqeG94QUpvSGpkbm83?=
 =?utf-8?B?c3pCUGpuK3JJUzNKMlM2dHU5dzBwT29CbVkvZktVblNnZjBHMElkWTRGT1VW?=
 =?utf-8?B?SGUxZjVlWTU5ZEc2WW5wMDc2VlZudVAwZEEwQWQ5dk96STFudHcxemlqUWg1?=
 =?utf-8?B?bGlKdGtGTG16SktRNmViZlZaOFpNRkkxeXVWdk93eDVsNGRiTEt2Ryt1akd5?=
 =?utf-8?B?MkxlODFUczBHaDk0M2dJMjRNa0lwOXQzL3NZS3lsWkdmYWhpMXRZSlNnYnpj?=
 =?utf-8?B?eXJRTHkwTVdwaEcyc3ZJTTNadnY4RzBWTHI4dEw5a0lyZVhEL1kwM2NDVlh2?=
 =?utf-8?B?UEhqN3hFN2JncUI3YnlXRGxwU0s4TzJPTG5YcEpaWFRVOXo2MzlPNEM2aGJp?=
 =?utf-8?B?Z3VGMGpYRjZFQVpKU1FCRkNCR0ZnblltWlBudTZWejF6MjZ2M2hWWnRkTEJ1?=
 =?utf-8?B?MmVLelVmSHhMYUdoNmtGdEVNVmlucjRUVEFwY2plU0NqWUJHSnBFbjNzd1JB?=
 =?utf-8?B?K3pnUDV2ZnYxaWxnaFE1VC9TNXU4eWdHYU02UlZHalZmY0xvRmQ4cXF1RjA5?=
 =?utf-8?B?dEpYK0xtU3lvWHJoN29lOFY4OUN5ZVNvQ20zeENReVFMR3JrZVZ5NXFHaGlR?=
 =?utf-8?B?bWRVbjhUZUJVRnZGQmVzbjg0empvdVJPWGFPRnFlMXExVE1PbkVjaUFkOStB?=
 =?utf-8?B?MUxoczBnWi9YT1B3blRSc1poUWVMU1NyNFUwd2NKVzZYaklJV0pBRHpCOU5K?=
 =?utf-8?B?dTBuSTY3b1dXalNwcGZUU083K296SnYyTWtxTTZkZ1BlNlozcGttTTZyQTEy?=
 =?utf-8?B?dXdELzFad3RMdkVjKy8zMlVhMHo0Y2YvWmpNYlBsdmxCSHNxZzIvblU2anJB?=
 =?utf-8?B?VDArak05MlRMSENEOGdhbWd6T1ZLcEVZVjk5YmR2N2QwblpuZjN5a1VZZzBO?=
 =?utf-8?B?Uno2aDNSd2JPS3lpRmFpTEhNb3pSYUhaSkg3ZmllUEY4TURpaWRTSVUrclI0?=
 =?utf-8?B?L1p3YXZnSjdJcmxWQVU2NFZBb2F4bFAzVGNVd2pvL1prSTVYRVNxYTlYamFW?=
 =?utf-8?B?Z085UU9yWXE4MVVOR0p5eG83MVVQWXJ4M1JuTUpBVGxPQTM2OHh4YjZveHVX?=
 =?utf-8?B?Y0poQmM1KzhmL0pHYjVqZGIwQ3B0cVlFL0NHWWJWdjJzM3Z0MWxQbTBWN2Ro?=
 =?utf-8?B?bVpQSHpNZFgwUk9Hci84OWNNWFJUUTFhNzMyeGtxSEZ1bzA1bi90TWd4UFVH?=
 =?utf-8?B?R29Id0xPK1R3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGlUcVBUU3FzdVo1azlLQk4rSGFUajVBOUpsWHRpOFpEeGlINnJYaDlHZ1A1?=
 =?utf-8?B?Y3oxdTN4dnFWaEU2dVVBTytpZ1VYNnovMzROWGI3U1YvKytsUFZUWXpBUWlO?=
 =?utf-8?B?S1A4MUthMWQvR2MxL0p2RTQ0VVRKS3FZcG5lMWNzMVI4bmhHaDFZNGZsOXhH?=
 =?utf-8?B?TWdNdXdyRzF5dzFrbW9xM2dHc3BDUy9iUlNYbUJSb1hyQm4rT2ZIVStUSE5Y?=
 =?utf-8?B?RWhncmM4ZllhU1NoWFFvRzZ6TVROSy9JbWkyTmRLbkNGQ2FSQXBLT0J2VGE4?=
 =?utf-8?B?SVFqVGkvOVpxYUJick9tV05yVlJjTVpYYzl3aWN6dkxIL1I3M0FvV2xUbWtX?=
 =?utf-8?B?YkVhWncyZTVPZnc4UlJ3NzdBOWNGTTJGTnR0MlUycXFzY1pKa3V2Y0ltR2k3?=
 =?utf-8?B?OEd1dkUrOXNwcUxQZXZTUlVDRllTQTZkZG1Fdnp1bmRtT0EzTEN2UjcvZStu?=
 =?utf-8?B?VFlZdEo2K1Uya2dWeExDYU9KZ09uSnF1bUJxUkR5ZnQwQzJZQ1huTzJNbDNN?=
 =?utf-8?B?SjBwSWM5Y244eHZ0UlhTZ0FCa0ttc0p6U3VpdnZFTEZiWm9jditHNWxIbTdK?=
 =?utf-8?B?WU9RS3JLdU9KeWVqd2h5TXdwZ3JzUG1mUEcwTHF2RlpnODA1UXFOQ3Nvbkxn?=
 =?utf-8?B?dEVTaVA2QW9KZG9rN0VuS0hUeXJ6eGtoeWNEWTErQkZVT3lQZnFSckMrZEwx?=
 =?utf-8?B?WXNSRGZLSFRjbm0vYlJlUmhzdE1RS2ZRMVppU050Rm1ic0FIUUEzS0xOVGI2?=
 =?utf-8?B?VFNtMHprampTaFRHUGcrKzIwczFKVzFiVllRSnhnZE5halgwOS9QOHZybDRa?=
 =?utf-8?B?TTAyZUFnaE5jaVRSY0pYMzN0YnVBQnBldHc5NENMRmhFdHZ2dGhPTmtrbCs4?=
 =?utf-8?B?dzN1c295ZjJ2Skd5czVGd1BQQzIydFJnVlVqai8zV0Z3RjNYM3JUejlId1Nu?=
 =?utf-8?B?V2tKTXU3aVpUUVpTaEdwM2tqQzVjcitEeFhiMGlmSUFuZXppZzExdFNPVVUz?=
 =?utf-8?B?dEtyN0ZmL3dRSGVET3paQVdpUWRwR0l1dzgrQjFRYXdtOWM0WlRaUFN0UG1U?=
 =?utf-8?B?MXFZSmJ4Zk1UUHcrQW8zbkxYTXcxUG1JVGpsanhXUGZkU3RuZ2xlWkErTkVK?=
 =?utf-8?B?dDlTcFlwWkFwQWFqZ1BIWElOaEhDS1JiK0RvcVhuWldvbWpvZE1VSEl3S2hm?=
 =?utf-8?B?ZjJVT2RFR2tWLzA2YkxBc2JSVGtFcldXVDlKem15MmwvVXVGdjZ3TnFXTW9H?=
 =?utf-8?B?ME8zWmFZZVpUY3pEa3dnTWdna1JQSVhPRktvaXlPVDlNUmc4aUJTNElSM0dD?=
 =?utf-8?B?ZEFEMWY5aHdleHdUOVdveUlGZXRRbEJqM3Q4RHNWejZKMjdHRXlSVk50ek8r?=
 =?utf-8?B?RjVqMVNYZVZmd2ZGbjgrY3JhQWlDMnBZa1QwSUNFL3pYRmdpSy9SSGRXQ1dq?=
 =?utf-8?B?Y0loY3g3ZFdUQmRxaDA5VHBsZ3hTNlNuMDZjRzM0MG1WdEdSNlZHcGlKK2lu?=
 =?utf-8?B?RlNJZGFVS0hxM1NYSC95d09tN2RDbXhDQmt4Uit2WmlUUUE3Q2ZjTmZ4bUNn?=
 =?utf-8?B?M0NrMFhyVjFTL08yeE9yOUF5TkI3T0k0ZCt2SkFnbnRVOCtzSng5MU1uQ3ly?=
 =?utf-8?B?RWU4SzBUNjIrR3lXS0dXdTVjeXNvclJTY2xUU2FsK1NFNUJBMkRsbDFVT0k2?=
 =?utf-8?B?a1lZR3BkcWZ6TjJzZi9OWk5LSUNhSjVQeW1DZmFSWkpIVmFXdEJOWGhpRzc3?=
 =?utf-8?B?NjU3Nm9pTkV5L3RqU3VtTzVzWVQ0NDVTeEtVSlNCd085Z1htT1JOWjhFZWxU?=
 =?utf-8?B?blBRMVRXektpazNURXpWZThTMmRSbTZBZG5rTFM3cFBUT1hrcWJoUFdVWXlr?=
 =?utf-8?B?N2NzUFhaMnZuODdGYlU2MnRPUXhyRFlZWXpVQnZLaUd3bWl0UGtVblI1KzhI?=
 =?utf-8?B?SEk5VlBHYjVIcHNGaUNlN0J6aUlIQVp6d0VTcGVCR00wL3U4WG0wSlg1QWNh?=
 =?utf-8?B?Ti83QkQrWjJ3L29vT3VBS045ejdzaDJhYlVJbyt5dG1OR252K01rM3VJWjk0?=
 =?utf-8?B?NkwvN3A3OGZkVHE1QmpOdm9jWTNveno0MStJaXpSSEE5eVJTTkVUYU5taS8v?=
 =?utf-8?Q?TlSjC8EIS8fG78nWcKh64qL+f?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de07839b-8794-4f5d-4346-08ddb21a2390
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 05:52:29.3106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKgg2wkKYcRPsLUJ5uE7klvBxYl7IR2r9BISs8dIS4BbOLmV/58DRN5OuUfuDgq8XkhePlH/3cjMo+WZZaz2PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10671
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

Capsule update is EFI based firmware update which is widely
used in various OS distributions. This feature is required
by ARM System-Ready compliance test. So
 - Define image array and GUID
 - Select configs for EFI Capsule update

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mq_evk/imx8mq_evk.c | 21 +++++++++++++++++++++
 configs/imx8mq_evk_defconfig            | 13 +++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.c b/board/freescale/imx8mq_evk/imx8mq_evk.c
index 18e83d90a08d653dd629bb773ffd11f50532f4b9..e90c56c33ffd4764b3408df7a154436f05949e19 100644
--- a/board/freescale/imx8mq_evk/imx8mq_evk.c
+++ b/board/freescale/imx8mq_evk/imx8mq_evk.c
@@ -7,6 +7,7 @@
 #include <asm/arch/imx8mq_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/iomux-v3.h>
+#include <efi_loader.h>
 #include <env.h>
 
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
@@ -22,6 +23,26 @@ static iomux_v3_cfg_t const uart_pads[] = {
 	IMX8MQ_PAD_UART1_TXD__UART1_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
 };
 
+#if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
+#define IMX_BOOT_IMAGE_GUID \
+	EFI_GUID(0x296119cf, 0xdd70, 0x43de, 0x8a, 0xc8, \
+		 0xa7, 0x05, 0x1f, 0x31, 0x25, 0x77)
+
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = IMX_BOOT_IMAGE_GUID,
+		.fw_name = u"IMX8MQ-EVK-RAW",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 0=flash-bin raw 0x42 0x2000 mmcpart 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
 int board_early_init_f(void)
 {
 	struct wdog_regs *wdog = (struct wdog_regs *)WDOG1_BASE_ADDR;
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index a2a6991bee28d2e6747a5461093a7c034a88e95a..61ff01c09093cff418d556d8ed4789b1659769f2 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -27,6 +27,10 @@ CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_SPL=y
 CONFIG_IMX_BOOTAUX=y
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_MM_COMM_TEE=y
+CONFIG_EFI_VAR_BUF_SIZE=139264
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
@@ -53,15 +57,19 @@ CONFIG_SYS_PROMPT="u-boot=> "
 # CONFIG_BOOTM_NETBSD is not set
 # CONFIG_CMD_EXPORTENV is not set
 # CONFIG_CMD_IMPORTENV is not set
+CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_OPTEE_RPMB=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_MDIO is not set
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
@@ -72,9 +80,11 @@ CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
+CONFIG_DFU_MMC=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_PHYLIB=y
@@ -96,8 +106,11 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
+CONFIG_SHA384=y

-- 
2.35.3

