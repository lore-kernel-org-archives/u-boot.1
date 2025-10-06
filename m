Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CA7CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 14:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B3183C6D;
	Mon,  6 Oct 2025 16:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FJ96A+9/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD0583C91; Mon,  6 Oct 2025 16:25:33 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E376183A45
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 16:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ft33RXYBxGaDvQKhUo/Glz3S5LBstk+9EE/Mp6AGP3Mm2/A6KeFWt4s+AoNK3tCVaeRK2cOOmTN1iJkOwxxRiKpOaBgEidZxliOGU9GGMfTFI1tlJfy7jfJ78Yvmqs+SD+rj2G897KGQG4zdzZxIgYCTZf+vCGky9BrXif0bHCpEm0bgMz+ELndUenbB49ewz/NYtQD8xOYEBkagXWMK1G7W3/fR1Ncm6IxBP+9htc1FadrE4GXMoXyJnhW1Qv1V0GI66Hs3NUFr9HmKXHVUB0kXsTk5nGVTLgGwOMAgzxcStmiT5fKn+/Uo/9v4Z1yQqt+E5KnXhznrGhw9f1ZCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xW5+wEbbQG2XJVo8cRlxk/0H1D8gImVewmc8xZJrsM=;
 b=MlpQT7GhlEaaEJYZDkHO8WtZEC3zGSBXapFnAbDv244pqgyloTKnr7xuDAMRvgqC3hnL6AYCrdw5MGg02L07T+JOXnrK5kM1CoZC7nYEJgZvZnoHKOx3sLVehyMc/hGyMSzhoypLTCQAey5/PdRz7Ch0QDbnSMuoM3DV1peLNNt16OYDrlW+5NveXMaKDYCRV5qSsmH2nPF8KCInAdP6SUOPnKF/yAm0B+QoX+VQPRuPOAQIqtk4nE/gTSX2SZ+S2rh3CIPUur7thn8orCabxPiDhHG9dWyioX2ZV3ArasGIXxiyf49A0U7hiLOumZD95J0a1K+GJLrMKEHwrrojKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xW5+wEbbQG2XJVo8cRlxk/0H1D8gImVewmc8xZJrsM=;
 b=FJ96A+9/H1h6qWfpxx1EowOXTqPeEFQqBt8p77h4cjHiahifY59o+h30Ptm/ndFyU4TvqOVa5fknvBj/Ofveq5x8f7VqPJGOmYX7dtr2X3Db73nJo9sugwS8iPnq+niVRH/ocI7r9fhBlOPke0cvQMbP8j4cDFTG4PISOlqCbnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8084.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:25:23 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 14:25:23 +0000
Message-ID: <eb6b9109-1f68-48cf-ba79-e37fe70d73dd@cherry.de>
Date: Mon, 6 Oct 2025 16:25:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tftp: make TFTP ports unconditionally configurable
From: Quentin Schulz <quentin.schulz@cherry.de>
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, u-boot@lists.denx.de
References: <20251002-tftp-port-v1-1-96d04556b35c@pqrs.dk>
 <fbe74df2-e608-4781-800c-c415409f6e26@cherry.de>
Content-Language: en-US
In-Reply-To: <fbe74df2-e608-4781-800c-c415409f6e26@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4dcc93-0a8b-4f88-7659-08de04e42fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MllCQjlEanRBaDE2cFpsZ0d6Qk1nK0lrc0xUanp3aGdOdk5ING9XQjMxTFJO?=
 =?utf-8?B?ZHZpQXVXd0R4RVRYWjNXNWFRWW4xVjFncEkvV3V6bFRrekpER1ArUS8zT1Mv?=
 =?utf-8?B?QXhTcmVYYlQrUW02N091aVRiUGhRb2hrU3YwT2c1Ym1vNGNsNHJjdlVlZFpC?=
 =?utf-8?B?QldGbkVsTzAxUDRmbGpvN2R2SzVCbytKVVVXYllXVDQ0RVhVZTdTM2xPbUN2?=
 =?utf-8?B?cWhsSEdZSEFMT0VpOXI0Qlh6M2ZIVVZCck4yS3c3ZVF4LzBBWHRIYnZ2T29n?=
 =?utf-8?B?RUxaNm5ZY3pNdktvVHlBWXh2aVlWQUNZQTJrQk1qNERJRjVxUTVUdCtjeVVt?=
 =?utf-8?B?cCt2ciszUmxBNlBIQkFONW13TWRHQWMxcWtTQVdPb1REQ1ErNENsNVJLaWpE?=
 =?utf-8?B?SGJObzlqZGl0ekh2NVB3NG5Od2xGZGJyUFVOK1dBamxGUW83eG5ZMkkwQVpi?=
 =?utf-8?B?S2c3OTFCKzFWWkxuY1JiQmdXQkU5c3Mxb2lJMHZ0dHoyUlVGand5S0EralA0?=
 =?utf-8?B?Z3E2ZW92Qi9DZWhSSzhOZjRsM2VYWEZ6TnpEclJlNUk3SXlWcmJDWHhvMFh0?=
 =?utf-8?B?NTZ3WkVLRXdnN2psTUdEVTVFejNZRGVTbnlucitGMzgwSTBVM2hCT0crVU1z?=
 =?utf-8?B?LzloU3VEUm9MYU4ySklKZklqRFRXeEQ5SytvaElBUllJWHhnUktKT2tnY2xV?=
 =?utf-8?B?VlRQN0lRVVVaY3NNYTR3cHZpVjVneHM3Vk5wWjluQUdxbUlsb1VvUVpQYkRo?=
 =?utf-8?B?SlBLWU5KK2dVc3dKQXE0T29IclhVYmhGeEk0VDNsalRpL3JBTzlVcE1lK2dZ?=
 =?utf-8?B?VVdWOHRhdk5xM0c1dWY0eWZVQ1B5cG1lSVUzNHlXWXd3a1BsQjZraVNvajky?=
 =?utf-8?B?RGR1RXMyQW9IM2IvNFBSeTMrSDhNazNVcVFRc3JIQWM3RWRRSUlqUTFTdnh1?=
 =?utf-8?B?N3JnSXVkQUJnYXFQOVl6NkxxdDZmdmlBV0sxWFJuRHE1N0JPOVh1eFJzeFp5?=
 =?utf-8?B?MHVlaktUdmZoaW1iVmVZczZZZld1RDVMOVA2NkRyWmRpOXlVY092RDBwdWdx?=
 =?utf-8?B?c1hodG1WdmlIT0h1Y1gwVndxWmx6ZFVRZ1Rmd3VucEZyU2NDN2F4L3VPWGU5?=
 =?utf-8?B?Z0Z0dmlPU2pCMEpSSVNXT01UNVRjUlEzQjg2UU9EU0ZuY0ExcUNUUWNxSzBS?=
 =?utf-8?B?Q09NSlJrR05sejNLNUlKK1YzTy8zQnBHZnNaeHM1cmoycm1MTGhva0pzVUp6?=
 =?utf-8?B?c2poaEdqZitYaktkb0hXYXE4Vm1OdmN4U0dFU2FHL0JPczRhWk9DZTlLU0pF?=
 =?utf-8?B?cE5xdEY2Ulozb3dhaUtocXN3S29XSGlGOHBweHQ3K3doSjBXdHJoZWhqTHFJ?=
 =?utf-8?B?S1lUNCtLRlZ6VjJYWWJmdHVpNkFyc0NEbnVtTjcvNlA3ZC80TU5VYVNQd3lt?=
 =?utf-8?B?MWM0di9MWTMwaGFVNThuODRKUTBWb2JycEovWTBtV2hKbDBQcUIwSW9sTFVy?=
 =?utf-8?B?M0c4M2tONTc2UUNFM2JiT3RIUGo5dEtBVXE5QXZkZStIOVZ5U29Rdis1RGJU?=
 =?utf-8?B?Ym4zSFlTb3VTZThEN0Z1UmFHWkRxUUZldEtqem85d1ppbkV1bHVoZCtCc21X?=
 =?utf-8?B?MVU1bDRabVUzaGNyaTlEd0tPS3ZjMW5ZeUkwaHordTFvdFZZQVBvVE1YVVgz?=
 =?utf-8?B?U3p6V0RkTUF4S0t6Zk1iZ24ranlyR2ZoZHcwQjNPYmtuZXpRR25PYmV4S1Fy?=
 =?utf-8?B?NkZZdHVYdDJrTHVEZFIxNlRITjFiRFRtSVBIVWRuOVp2ZDdQS2ZxQThSMjJQ?=
 =?utf-8?B?ZFBFT2xXeDVzd3E4Z25NOGRaK3FaUmwraEhOWDZwUXdqcjJOVGs4aUhPTkpX?=
 =?utf-8?B?N3Qwa0lTN1d2NEZrMitIR25qRXlyWGxRSnUvcEVldjZid3hwTXlpeWxtSkZU?=
 =?utf-8?Q?wYUv/HDKpy9nt0gELINnUa1h/Yard2l7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW5nOFUzSE5abUg3d0krdmpHRzNzVU1UM2hrbDZ6SG4yb2VkbkFrbW4vV0Ja?=
 =?utf-8?B?MVlXYUczdDZnYmRVdno2bFpqbStzWTF1TU1nQ29qS3dIc1RIZDYxeklUZ3pt?=
 =?utf-8?B?SmhjL01oSmVvYUhSLzRqRVhGTnIwMEdJR0d6YndJY3ZSbUF6M3dmT3UxbzRU?=
 =?utf-8?B?dG1OMWY4MXlCMUJzVU9XZjJsMEt5dHpNb0g0cGMrcytkRUg3Vi9janNmN1N6?=
 =?utf-8?B?OFFDRWdqMHE1M0pWL1NncjkrY2VlMndUcThVTk90SVl0TUFXOWxJbFo4YTZj?=
 =?utf-8?B?OEVMNGFBbElRYWZzT3NvZ1dDN0JqYWgvYi9mM2h6QnFOaWtLbHVCVytzWjgw?=
 =?utf-8?B?Q1E0RFdEajhHT3VmZ3ZBOHR4UXVoeVdjSVB0eTFoMEpiekFJTWRrYU0za21n?=
 =?utf-8?B?YU5ZUnhDcTl0RkZFTkg3R1Y5emg1QlBOanNrbnRTM1F0T3pZZ1NibkRUODho?=
 =?utf-8?B?UEZrR0dzMjBPWnFrMkliaFpZSC94NE9GSE5LcWYrTXE3RTM3STF0aVZEekZH?=
 =?utf-8?B?S1U4RlV6VU9DYXQxcFNVRm9lSnJ2K3dVaXZBeDloc2V6endXUXZGZVdpalYw?=
 =?utf-8?B?NkJNeCtpUFQzbTJLamlsQWxWOWswV0s2dmlSR3BzNXpzSlovQzFZL0IxcnBC?=
 =?utf-8?B?TXg1ZzRxS3lNRmJkVjRFVVAxMWVtM0R4c21FY2hKMHp2MXBoS0EwUVNhcDRJ?=
 =?utf-8?B?dW1SUFovYzFRRjR1YUhQeFRzSUkxY2VxU1F3OW92dWhHdE40VXh3NTA4aHlk?=
 =?utf-8?B?NndEblNSTDZkQytnS0VSclBiUE1nWmVLQUZmZzM3ckkyR1UvaHRVMFR0eTRy?=
 =?utf-8?B?ZTF1S0VJUmd2SkxaQk1tYUdSeEFkbnYxRjJnQU5HUUtCRjROenNXcEUyVEd5?=
 =?utf-8?B?WnJYYWJzNFVZZGMvZVl2dkRja0h2NkdBbm1xNGtuZXlhdHNpTGNuT1h5UTlT?=
 =?utf-8?B?T3FTT2xWK3plUGMvZTJnL3N5NGIyV041SGU4WGJ2Z3pRRERmcTJRNHVRYUFr?=
 =?utf-8?B?TzBNNDVyNUsvandhZ2dHUVFoS3dPZGZ0U2Rnek5hWDlkRU45V3VxL0JPaGhE?=
 =?utf-8?B?WkxjbGJUZlVOUkdpZTRPVXViOHRJNHh6dnhya1Z1S004bktvQVI3dHFrUW5z?=
 =?utf-8?B?T3pPR2F1Z3NJeGZQWTlEeVRHUlZUcGdyQU5Ld2p4aCs1M2U3cWNvZU5VS0ky?=
 =?utf-8?B?Qmk5c0ZnRmt2QXB4SFUrcW9XOS9zaHYzOVVWNFB5dmFjcUZyVmRqOHlKTnYy?=
 =?utf-8?B?S2VRMU5jNjVETUhnYzFTOG5RVmhZQjlnZFFKWWpjTXBVcnRITFFXMXlvV1ZT?=
 =?utf-8?B?YkJUaXF2djdZVXp1SU9TWW54SThPY255bFNiaGd3aTd2Y1FTUkhrZXpZcFB2?=
 =?utf-8?B?SzgyMkV1UlZ2QXgraW5FNGVWeWJaV1RGOUtjYzV0N214ZnRuaHBGQlpiK3p5?=
 =?utf-8?B?RjJWQldraDVsMitXdlZXRGxSMWJVUEN1di9RS04zZHpVMktBVVpCYmk1L2Jt?=
 =?utf-8?B?cEhwZndaSklHOHM3V3lhRlRBaTJLVjJIZmtoZGVIeTBBdE85QkZFbDloQ2J3?=
 =?utf-8?B?VEpFZVZ0QVJGY2thRHp1RFFFSVRXcXFPN0pqY2J1MXdoUlNoOVBzSFNOaVZz?=
 =?utf-8?B?SXBRVUlFVStwUWpBQWJqd2JTNVFmMnZ3YlVlWkh6NWFiQXFPNFp5SkZxUCtU?=
 =?utf-8?B?aEtUYnhhU2FEemxjTVhGY3BxTmg1RVF5MkF4ZEI4UTFxc2kvSjFhMFZKeG9E?=
 =?utf-8?B?VkU2Z1pWL1Bzb3phZTlzU2YzdUR4ek8vd0UrOGltcFRpRHplYzYrR2RReTl1?=
 =?utf-8?B?TXZML3VXWU5hblZ3UUtVMG1vZWR1ZTdJVFN3YTVKWEI0S0JvakdVcWd2ckUy?=
 =?utf-8?B?b3ZmT2RjekRMQzJJRWtQQmpReTFCVTRydXQ3V2VWWkZHNUF4bk5qNUlONXFC?=
 =?utf-8?B?LzJRUDV3NXdiN2JqakZYeW5GVHU4WDR0bjVzc21zb0F4UUJpalkvREdZcnJs?=
 =?utf-8?B?ekdxZzJ1eUIxN25nSlYzUkx1ZVUvc3JtQ001M29IZnRwK3FxUDY0dU05NFN3?=
 =?utf-8?B?bllQcXF0eDhNcENrUlpZYmczUzJZakdYTFdaUEF6eVhsK0RISXZRRWJkc1Zy?=
 =?utf-8?B?bkhvYzlRQ1lBMjdmUzIrOWs5b1RKYVUzZXd6K1h4RnQ1SDB0Z2VLOW52aEdJ?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4dcc93-0a8b-4f88-7659-08de04e42fd8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:25:23.6088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeWb4cb5WdpoyZMEiUwjLpAkI39J+L8OhvE9JCKznWAdh1St11l2zOQmcJ1kAEPVtjKU29P8eBJKyAAsu+KZgan5QfnTJg97a3qF2gzFyQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8084
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



On 10/6/25 4:22 PM, Quentin Schulz wrote:
> Hi Alvin,
> 
> On 10/2/25 11:43 AM, Alvin Šipraga wrote:
>> [You don't often get email from alvin@pqrs.dk. Learn why this is 
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> A few lines of code being guarded by the CONFIG_TFTP_PORT option seems
>> an unnecessary restriction on the TFTP support provided by a vanilla
>> U-Boot image. In cases where the TFTP server cannot run as superuser -
>> and hence cannot run on the well-known port 69 - this quirk incurs a
>> full reconfiguration and rebuild of the bootloader only in order to
>> select the appropriate destination port.
>>
>> Remove the CONFIG_TFTP_PORT option entirely and make the tftpdstp and
>> tftpsrcp variables always have an effect. Their being unset will mean
>> that U-Boot behaves the same as if CONFIG_TFTP_PORT was unset. Update
>> the documentation accordingly. And fix up the single board which was
>> originally enabling this option.
>>
>> Signed-off-by: Alvin Šipraga <alvin@pqrs.dk>
>> ---
>> ---
>>   configs/gurnard_defconfig |  1 -
>>   doc/usage/cmd/tftpput.rst |  8 ++------
>>   net/Kconfig               | 18 ------------------
>>   net/tftp.c                |  3 +--
>>   4 files changed, 3 insertions(+), 27 deletions(-)
>>
>> diff --git a/configs/gurnard_defconfig b/configs/gurnard_defconfig
>> index 
>> bde531a6003a2d7167767b3f509876137c7da1a8..85643f249aed65071005a157658c3dc11f44c619 100644
>> --- a/configs/gurnard_defconfig
>> +++ b/configs/gurnard_defconfig
>> @@ -42,7 +42,6 @@ CONFIG_ENV_OVERWRITE=y
>>   CONFIG_ENV_IS_IN_NAND=y
>>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>>   CONFIG_NET_RETRY_COUNT=20
>> -CONFIG_TFTP_PORT=y
>>   CONFIG_TFTP_TSIZE=y
>>   CONFIG_AT91_GPIO=y
>>   CONFIG_GENERIC_ATMEL_MCI=y
>> diff --git a/doc/usage/cmd/tftpput.rst b/doc/usage/cmd/tftpput.rst
>> index 
>> 351c9faa38b9d8357c0e200d8cebd1f90344e0a6..2bcb3032cb2444926da28454eefdb2b128a7389f 100644
>> --- a/doc/usage/cmd/tftpput.rst
>> +++ b/doc/usage/cmd/tftpput.rst
>> @@ -19,9 +19,8 @@ Description
>>   The tftpput command is used to transfer a file to a TFTP server.
>>
>>   By default the destination port is 69 and the source port is pseudo- 
>> random.
>> -If CONFIG_TFTP_PORT=y, the environment variable *tftpsrcp* can be 
>> used to set
>> -the source port and the environment variable *tftpdstp* can be used 
>> to set
>> -the destination port.
>> +The environment variable *tftpsrcp* can be used to set the source 
>> port and the
>> +environment variable *tftpdstp* can be used to set the destination port.
>>
>>   address
>>       memory address where the data starts
>> @@ -75,9 +74,6 @@ The command is only available if CONFIG_CMD_TFTPPUT=y.
>>   CONFIG_TFTP_BLOCKSIZE defines the size of the TFTP blocks sent. It 
>> defaults
>>   to 1468 matching an ethernet MTU of 1500.
>>
>> -If CONFIG_TFTP_PORT=y, the environment variables *tftpsrcp* and 
>> *tftpdstp* can
>> -be used to set the source and the destination ports.
>> -
>>   CONFIG_TFTP_WINDOWSIZE can be used to set the TFTP window size of 
>> transmits
>>   after which an ACK response is required. The window size defaults to 1.
>>
>> diff --git a/net/Kconfig b/net/Kconfig
>> index 
>> 40ec6bbce7614afde5a2a9f90d431f19a3654a41..7ba64d43b398415825921e7b61dc4c81e986618a 100644
>> --- a/net/Kconfig
>> +++ b/net/Kconfig
>> @@ -60,24 +60,6 @@ config SYS_FAULT_ECHO_LINK_DOWN
>>            this option is active, then CONFIG_SYS_FAULT_MII_ADDR also 
>> needs to
>>            be configured.
>>
>> -config TFTP_PORT
>> -       bool "Set TFTP UDP source/destination ports via the environment"
>> -       help
>> -         If this is defined, the environment variable tftpsrcp is 
>> used to
>> -         supply the TFTP UDP source port value.  If tftpsrcp isn't 
>> defined,
>> -         the normal pseudo-random port number generator is used.
>> -
>> -         Also, the environment variable tftpdstp is used to supply 
>> the TFTP
>> -         UDP destination port value.  If tftpdstp isn't defined, the 
>> normal
>> -         port 69 is used.
>> -
>> -         The purpose for tftpsrcp is to allow a TFTP server to 
>> blindly start
>> -         the TFTP transfer using the pre-configured target IP address 
>> and UDP
>> -         port. This has the effect of "punching through" the (Windows 
>> XP)
>> -         firewall, allowing the remainder of the TFTP transfer to 
>> proceed
>> -         normally.  A better solution is to properly configure the 
>> firewall,
>> -         but sometimes that is not allowed.
>> -
>>   config TFTP_WINDOWSIZE
>>          int "TFTP window size"
>>          default 1
>> diff --git a/net/tftp.c b/net/tftp.c
>> index 
>> 1ca9a5ea7cf6bac562006e2506ebcb17996a8c36..1760877107faef57107cb04c484157750ff63602 100644
>> --- a/net/tftp.c
>> +++ b/net/tftp.c
>> @@ -926,14 +926,13 @@ void tftp_start(enum proto_t protocol)
>>          /* Use a pseudo-random port unless a specific port is set */
>>          tftp_our_port = 1024 + (get_timer(0) % 3072);
>>
>> -#ifdef CONFIG_TFTP_PORT
>>          ep = env_get("tftpdstp");
>>          if (ep != NULL)
>>                  tftp_remote_port = simple_strtol(ep, NULL, 10);
>>          ep = env_get("tftpsrcp");
>>          if (ep != NULL)
>>                  tftp_our_port = simple_strtol(ep, NULL, 10);
>> -#endif
>> +
> 
> The only worry I have with this patch is the security implications of 
> that. Indeed, if I manage to get access to the host (root not required) 
> where the TFTP server is running on port 69 AND the environment of the 
> board, I could set tftpdstp to point to the TFTP server I (an attacker) 
> just started on a non-privileged port.
> 

Thinking about this five more seconds, I guess at that point, one could 
replace the command calling tftp directly and point U-Boot to a 
different IP for the TFTP server or do other nastier things.

If you're blindly trusting the environment from an external source, it's 
your problem anyway, simply allow importing some variables to be 
imported from other environments and limit the exposure that way.

So I guess it's fine as is for this patch,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
