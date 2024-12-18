Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088EAE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 17:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B1B080274;
	Wed, 18 Dec 2024 18:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Tj0rEJpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E405F80283; Wed, 18 Dec 2024 18:47:50 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9929F80269
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAKnFZiNcMk1dzw4loKvNTkzOn++jnf4/NGVNLRN5UJZte0IwyglMyCikeykhYyXoaqWuaKcUhcKaoxvNJ/LE2VaZz3JkpHaUuW/0mH5gsVooWlXLl7pHjDnN2xBCL28NTpB8c3+cNWu6gdwfZwCgWe+856XUYlyKLVFVHtw4HyG6pL/0LdehcJUcRagH/LL6XfDyJoug9VRY+5X+Ej4yw7vhGdSxajR7QnHItly1nQb/G+cg/2jnjPMcC9ERG9xp03YhyjJPbpKNkczcR5vkXygzym4SVzqRb8KZrcjXU69bkMekK5fvH9iFSZ+zI6DRPqnWB43emKX86rCJtTlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvFMEnvxYS3CHVaLTYD1YFQ+Rce+piAwTLSAOdSlkC4=;
 b=PC0+g9qeL1pQu4Kinji+AiyfuzIXKDQAN7/1NiK8n/qm1HVypEH6IGnZNnxKIJb1ySoNaQItq9tVCGmiPuzon2GjBu+2bl0pDYDq665CrnLzIre5ZuYl2wXbWXiRsmgfS5zuaVGmlL22A9+V/y3/Wv5c7gE8sEzyCeNiJbeQiXBdaejktnW8Js19eeaBZJ1w1HMG3L0P1xqOPtt07XEXhwlSDFiKnoQrBOejVKnqBzWfCakCqEwfaAY0aYYMIx2PhNQuAqlzKtHBXavggB4auZlycdO/LqzMmonObath3CoB0xGjAVjpHrjdfzyc2jzVwUONjg0cIylRbJL76fm7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvFMEnvxYS3CHVaLTYD1YFQ+Rce+piAwTLSAOdSlkC4=;
 b=Tj0rEJpwk2Th8dqM9K5eAzY8cnNaf1N5EjXIETx4HTlsy2iWrrlx69+prGgp043Ci3nzX4nZ02sQoqjKAsoFlYLtvSzvLS6BQ5tjH8VyVftQcDDbTbthZVyubXysvuPYcaLbjSxdq0tLfULSvqi7i3i1V/X4Dlg2wKBiQQmKUGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA2PR04MB10471.eurprd04.prod.outlook.com (2603:10a6:102:41f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 17:47:46 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 17:47:46 +0000
Message-ID: <23608512-7271-407c-bc5d-a21231667ab4@cherry.de>
Date: Wed, 18 Dec 2024 18:47:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] board_init_f(): use static calls
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>, Jonas Karlman <jonas@kwiboo.se>,
 Devarsh Thakkar <devarsht@ti.com>
References: <cover.1734537135.git.jerome.forissier@linaro.org>
 <252364e53d56fab1c77bda74563b24ad8a17d635.1734537135.git.jerome.forissier@linaro.org>
 <fd8470e7-4527-4024-8477-63248a7cc6de@cherry.de>
 <bbcffca1-39d2-4f10-ac7a-fa15c2ca7522@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <bbcffca1-39d2-4f10-ac7a-fa15c2ca7522@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0379.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA2PR04MB10471:EE_
X-MS-Office365-Filtering-Correlation-Id: f48de872-faca-4305-01c7-08dd1f8c14be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXVCRGtzRGRVaDNkYzc1elNyZXVqTUVVSW9BNDljNXpKeWpOeTRseENHSEp0?=
 =?utf-8?B?cTc5ZXpyc2xQWDBIZmd6MnBQT3hxU2prOHBJS3hmU0prWkQ0MG9EN3phQVdj?=
 =?utf-8?B?RUdkT2hnaldiRW84NHVVUWd6SXI3WmVVWU5XSUZTSnJ3eVhOMWtQV2lVVmdW?=
 =?utf-8?B?cklVOHZyc2s4bkxWaFBjaSt3NUVCQjV4dUdIYUZacGYzcHF3dStVRGlQZmxr?=
 =?utf-8?B?Z2UxTi9xUVBZWkNaWDJ6dzlWc1JWTDVPdTNNWnYyOWZ5YUtESXlYMW5rR1Nv?=
 =?utf-8?B?a2pOVTdTOHJzZ0pxdmlEOG1lS0pER3VhS2tmODhSRzlOSy8wWDJDVStGTTdG?=
 =?utf-8?B?cEx3aVlWYzkvZEl5aDluWWlwOWlrUE1zYWo4eWtwV24vODl0UVY4NXNoZWRi?=
 =?utf-8?B?R3J0MUNzY1BvQ1FsUk9kdUxSUTZNUWxTYTlnVG9BWHZrSmZPWEZDc3NrTHpD?=
 =?utf-8?B?VDdEdHQ3Um5ocjJpV3hDQVJVMnhYSXQyT09od2QxOE1QT3A3VHpQVGRGM2Fp?=
 =?utf-8?B?d0hVSUtOZlVEVS80dUF0WUNTVzJPbW92QXRXdGZSVE9mdG84a0l0VHVocVJP?=
 =?utf-8?B?TlBKRnM4ekc0UERpa056VnZRYkpHb0FoME9CUlc1TkN2cGlqMU8wc21lTDNw?=
 =?utf-8?B?QXEwMVdxS0N4RFAzeDF3enRxbm80SGlIVDhXQ1JPOHdMVHdLMExjV01sbnBR?=
 =?utf-8?B?Qk1MUnovUDF4OWZSVmdNMFZISmZabVBnWUNQaGJ6amFibFo2K0tBNEo3Wjdo?=
 =?utf-8?B?OXJJaGhKUkYxV3g2SDlNMWl0N2JVSWp0SUQ5dm5BTXczai8wTC9RWW5objZG?=
 =?utf-8?B?cEV3RmNFOWFRR0x5bUdyNllWMEkvbXFoc1publpzaEE0cWFDYnFIbnlhVkN1?=
 =?utf-8?B?bnV3bHQ2dFZJY1BnalErRHpiT1RSRm9YbzlMM2U4UDlMclFiTVpXbWgyeWdS?=
 =?utf-8?B?ZXg1dThTd3VuTVZLZWxUYnVxc1lWUHR3dk9iOXlKR1NqWGpQM2dUWEx0UXJk?=
 =?utf-8?B?c2ttanRWSnJTU1VpdnRVSzg0TXc0a2xzdlBFZm5lamFpUjNyT2NPNmxFalBV?=
 =?utf-8?B?ZGdqWDRiKzRnNWw3RGVsVnRCZGJ4ZmNSK1ZJTHdtVDNEcUxqR1J3SzNUbExY?=
 =?utf-8?B?aUNWTkplMmlHRmNvNXhyZWdGZHc0SGJaV3BTU1ZnUy9BQmFwdnh1b1dxM0hS?=
 =?utf-8?B?OTZhZnlJZnhTSUYxUFJCNCs2MUxMS2VKZmNUZDFIdlMwWnBCVWN0WlA2QUJu?=
 =?utf-8?B?dTV0NlhjTU44VDlTUEgxRTFaK0VJbVNtQWxwMnpzaUV6ZnhMUzQxakt1QXR3?=
 =?utf-8?B?RzVkVDVQTXZEbG54SDVKaUNjcENZVnp5YnF2S3pSeElHYTZ4bEdTSFZOOVhV?=
 =?utf-8?B?SUhpNk8rYTdGMUtUK3dlZ3oxVzNvRFR6dlZPb0lvZWRWU3k5ZnJqVGxsdUlD?=
 =?utf-8?B?VGE2bVJURWJBQXBBQXgvaEtGeGhmdElpNDlvYUtZOWppSUpITHlLRTFiTXE3?=
 =?utf-8?B?UGhSL2dyem9tc2tqV0FkSEhYeHA5ejVkeWx2bHdEeWYrT1hCRVpkSjdHOGE3?=
 =?utf-8?B?QllHMjFHM2JQK3dHaUttSndmSktiU1lPWVh3YzNoS2NRUXVEK2VEU2YzTWVn?=
 =?utf-8?B?ODUyK2x6RHBxaXd0bXF1ZXFZOThyek9GTjI1WS9kRkZZbzBzdmVBYnhwK1dY?=
 =?utf-8?B?RTdqWFJSOHU3SzErMXZDaG9nRmQ0ZHcvMElkTm9GdzNSL3ZiaTdiN1Q0OEZt?=
 =?utf-8?B?dFlzZzNtcUhnaW1lWXJJL3YvMzc5R3NiTkNQNzlaV2JUMXhWYWUzZElHY3JW?=
 =?utf-8?B?NDJVTHFYVEV4dFJ3T3BxdC9teWZpQkp6VjhhdjFXZ00xcEI4TEdQUkg1YmM2?=
 =?utf-8?Q?feq3I60cX4HY1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVN1OGNkbVBkcjNrL2lDR09HZWVhY1hxLzAvV3REUVBhVWI2eEJiUkMyRUdn?=
 =?utf-8?B?NjV3Wm1Qdk5qY01kQkJ2MXRVTjFIME9HQzBVem9GQWRHbjUyVWN1bTF0eExP?=
 =?utf-8?B?RElHSENIRWUybkk3a2MzMHI5SHdNOEo0dVdtSFFvUFd3dXpUN2M3VG81SUwv?=
 =?utf-8?B?MjdUb1F1NTJhbVZsRXBUZXFjVGJQOEgxOVFia3o4RUM4NjdwaHlkRmh0TVNw?=
 =?utf-8?B?TXRlcm9LUFhuK21xTE1XL1lieFRETkU4bWkzTDhWQWNvUm5mRUt3VEtkMVhP?=
 =?utf-8?B?TGZoUTdJSGNhS2lzam9DQ1BtOGk0T0djTU9oNld3cVJxSW1nM2lWTFB4SUZD?=
 =?utf-8?B?dlNlUC91NEw0VzBrK0crbC94UXpUOXc1Wjh4bjI1NHNIRFdOcUNmMkhxQlVu?=
 =?utf-8?B?a0lPYjY2VXFwRzJ0S09oaXJFYnFHVnVnVE00dHdMZndHTWFvT0lhREFRQlBR?=
 =?utf-8?B?ZzNVYStIemlXWWc3T0NvU3VWK3Y5Q3c3MzdHZkgxU3cyOXRJS24rYzVta2gz?=
 =?utf-8?B?eHU1SFpHcGd6cnVWTXY0WkxYOXRXUlUzZEcreFNCYWF4TGh4M2dsQmVwQndo?=
 =?utf-8?B?V05yb0xGVTRybS9wVzlRUUxWNnNjRUtvd3ZIbU5zck1xWDVXY25sM05nY3hS?=
 =?utf-8?B?NHRZSnU0ckRvNjVLVHFDbmZNZlAwb3Q2WklDdkxwUU9WVFJUeVVFZ0FVVk1D?=
 =?utf-8?B?YVpvaVNKRGxmaHQ3SENjU2drMFliMmdUUlBMQ1NzazdaWXVWc2p3QzVVQmZr?=
 =?utf-8?B?L3Q1d2NrcVJrWDU0ajJVbFZCMFRkbVVENXMvZnNlaUhzRUNWWjZwZEVFck1x?=
 =?utf-8?B?aGZER2dpOWg3Q1FScWNrcTRaOE8weWx6RkV2clRHNWJ2cjE1QkptTWh2b3Nx?=
 =?utf-8?B?d1ZIdGgxaDlPU3kvM3JzdW9jQlhFUVJ0eWF1UnVoTVBONEJNczREaXRoaWwz?=
 =?utf-8?B?cDdvWERjK1RuL01yUndqUTVOSzFvM00rMHlsMy82T3dmbmh5S0trckx1WEZ3?=
 =?utf-8?B?bFludDdTN2tDUEJXNW1Ca1BsbVhpMlhEYytncUdnMmhDTDdWdDBYRHZ3aDZP?=
 =?utf-8?B?TUZPcGI4aE1XY2tHbVVMYzMxblBaSXNJbU1Cc1ZhMG1KYmhVaG5NRmdyY1pr?=
 =?utf-8?B?Y2VxNkNwdnZxWEd0b1FyTTVrd3NzSU0zNUZ0bkxDeVprbFZYMlpSMzFkUVFL?=
 =?utf-8?B?QXJ2N0xyZWVlNk1kZUwrclRQM09oMUxQV2R6ZXNhTC9mbXN1Z0p5eDhFeHBQ?=
 =?utf-8?B?elJyWnlBVm5lbW80MjJsWGRtVDZnajVlem43b2FINjI2VXdrS29nV3lJeWha?=
 =?utf-8?B?eStKTFZiR3NhaGxiQzJIMU9RazhFUWNvTld4RENrRTIwOVc3TmNXL1g4NSta?=
 =?utf-8?B?Y2xaVnV5K0xUT2tiODVXdm8wa0FyKzdRdUtDcWgxWEtNTmdnZExMQ2xLWGJi?=
 =?utf-8?B?UndHRm5HMXFETVREQnJzZjVBWHE1VDFVRFhFM28vaHpCeVpScHdBWGp6MlVF?=
 =?utf-8?B?cTMwQmRic2lQZHhOSVJGS21pcDllSmhPQXJnTDhDUHBtZ21ZcUh1bkFIeDU3?=
 =?utf-8?B?ZTRSQS9IendFMVJmVjMzbWRRSmFwZTlQdE00aVdpQXhwY1Q4TzF3VVBCVUpZ?=
 =?utf-8?B?RkVacW1pMmdTcTJ3U3MrYTBWd0p4WDVScTk0SkYwV0l5WkVBQXZ4WlpZMzFp?=
 =?utf-8?B?YmRTR2Q2cGVOSHdScG5FWTFQVFNVK3laejE4a3RSZUZFRTI0VnZ0ekttL092?=
 =?utf-8?B?Zm5JTTczYjJYYThQR0dCb2RWYXJtTkNjR2pNU1YxOVNBamhNT1BudWVCVjFh?=
 =?utf-8?B?dDNoOHA5aUtsU0crV0dMeTRvRUdnV1d3S05VcTRIUXhIT1VCZ2g3VC9XK0tE?=
 =?utf-8?B?Z0lxRXZGZElQa1ZHMlcrUzcvV2hTRnN5bWhsOHdNbW1sQVBXMEFHc1oyK2Yy?=
 =?utf-8?B?YlVFT1prS29IVFhPRjljdi9hUWVldmtpVlhrTjJJMXNMdmlwUDNqWlE0ckR2?=
 =?utf-8?B?T3Nqelo5R1U2QUVWSjF4NlVnUEVNajZmTVo4Qng1VTlhMXhGWTFCK2lzMllF?=
 =?utf-8?B?Tm9nOHpmTGtxSG1vaWRBei9nbzN0WU9PSmxFTUhWRSsvdkZxZkFlTEZucDh0?=
 =?utf-8?B?YVRMaVE3MnBTeThFRWZvQW5jb3FqUVZiVm9zS2pXa1BRaFNDQ1JEcEZMVDd3?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f48de872-faca-4305-01c7-08dd1f8c14be
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 17:47:46.1960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqfS8R8ZP9Kv9pM8ZPGtcDFE+Rfld0aRdwQJZ7f6AMLPJ6ziql4dXVSiWSHkPGAJG7z8hWrmG9aV8XNPqTo33gBjOuEdHQFEK7WSGTzZiM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10471
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

Hi Jerome,

On 12/18/24 6:38 PM, Jerome Forissier wrote:
> Hi Quentin,
> 
> On 12/18/24 18:27, Quentin Schulz wrote:
>> Hi Jerome,
>>
>> On 12/18/24 4:53 PM, Jerome Forissier wrote:
>>> Make static calls instead of iterating over the init_sequence_f arrays.
>>> Tested on a KV260 board (xilinx_zynqmp_kria_defconfig).
>>>
>>> - With LTO enabled, the code size reported by bloat-o-meter is 1200
>>>     bytes less (-0.11%)
>>> - With LTO disabled, the code is 594 bytes smaller (-0.05%)
>>> - Execution time does not change in a noticeable way
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> ---
>>>    common/board_f.c   | 165 +++++++++++++++++++++++----------------------
>>>    include/initcall.h |  27 ++++++++
>>>    2 files changed, 110 insertions(+), 82 deletions(-)
>>>
>>> diff --git a/common/board_f.c b/common/board_f.c
>>> index a4d8850cb7d..cebed85ed4d 100644
>>> --- a/common/board_f.c
>>> +++ b/common/board_f.c
>>> @@ -38,6 +38,7 @@
>>>    #include <spl.h>
>>>    #include <status_led.h>
>>>    #include <sysreset.h>
>>> +#include <time.h>
>>>    #include <timer.h>
>>>    #include <trace.h>
>>>    #include <upl.h>
>>> @@ -870,58 +871,60 @@ static int initf_upl(void)
>>>        return 0;
>>>    }
>>>    -static const init_fnc_t init_sequence_f[] = {
>>> -    setup_mon_len,
>>> -    CONFIG_IS_ENABLED(OF_CONTROL, (fdtdec_setup,))
>>> -    CONFIG_IS_ENABLED(TRACE_EARLY, (trace_early_init,))
>>> -    initf_malloc,
>>> -    initf_upl,
>>> -    log_init,
>>> -    initf_bootstage,    /* uses its own timer, so does not need DM */
>>> -    event_init,
>>> -    bloblist_maybe_init,
>>> -    setup_spl_handoff,
>>> -    CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F, (console_record_init,))
>>> -    INITCALL_EVENT(EVT_FSP_INIT_F),
>>> -    arch_cpu_init,        /* basic arch cpu dependent setup */
>>> -    mach_cpu_init,        /* SoC/machine dependent CPU setup */
>>> -    initf_dm,
>>> -    CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F, (board_early_init_f,))
>>> +static void initcall_run_f(void)
>>> +{
>>> +    INITCALL(setup_mon_len);
>>> +    CONFIG_IS_ENABLED(OF_CONTROL, (INITCALL(fdtdec_setup)));
>>> +    CONFIG_IS_ENABLED(TRACE_EARLY, (INITCALL(trace_early_init)));
>>> +    INITCALL(initf_malloc);
>>> +    INITCALL(initf_upl);
>>> +    INITCALL(log_init);
>>> +    INITCALL(initf_bootstage); /* uses its own timer, so does not need DM */
>>> +    INITCALL(event_init);
>>> +    INITCALL(bloblist_maybe_init);
>>> +    INITCALL(setup_spl_handoff);
>>> +    CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F,
>>> +              (INITCALL(console_record_init);))
>>> +    INITCALL_EVT(EVT_FSP_INIT_F);
>>> +    INITCALL(arch_cpu_init);    /* basic arch cpu dependent setup */
>>> +    INITCALL(mach_cpu_init);    /* SoC/machine dependent CPU setup */
>>> +    INITCALL(initf_dm);
>>> +    CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F, (INITCALL(board_early_init_f);))
>>>    #if defined(CONFIG_PPC) || defined(CONFIG_SYS_FSL_CLK) || defined(CONFIG_M68K)
>>>        /* get CPU and bus clocks according to the environment variable */
>>> -    get_clocks,        /* get CPU and bus clocks (etc.) */
>>> +    INITCALL(get_clocks);        /* get CPU and bus clocks (etc.) */
>>>    #endif
>>>    #if !defined(CONFIG_M68K) || (defined(CONFIG_M68K) && !defined(CONFIG_MCFTMR))
>>> -    timer_init,        /* initialize timer */
>>> +    INITCALL(timer_init);        /* initialize timer */
>>>    #endif
>>> -    CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT, (board_postclk_init,))
>>> -    env_init,        /* initialize environment */
>>> -    init_baud_rate,        /* initialze baudrate settings */
>>> -    serial_init,        /* serial communications setup */
>>> -    console_init_f,        /* stage 1 init of console */
>>> -    display_options,    /* say that we are here */
>>> -    display_text_info,    /* show debugging info if required */
>>> -    checkcpu,
>>> -    CONFIG_IS_ENABLED(SYSRESET, (print_resetinfo,))
>>> +    CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT,
>>> +              (INITCALL(board_postclk_init);))
>>> +    INITCALL(env_init);        /* initialize environment */
>>> +    INITCALL(init_baud_rate);    /* initialze baudrate settings */
>>> +    INITCALL(serial_init);        /* serial communications setup */
>>> +    INITCALL(console_init_f);    /* stage 1 init of console */
>>> +    INITCALL(display_options);    /* say that we are here */
>>> +    INITCALL(display_text_info);    /* show debugging info if required */
>>> +    INITCALL(checkcpu);
>>> +    CONFIG_IS_ENABLED(SYSRESET, (INITCALL(print_resetinfo);))
>>>        /* display cpu info (and speed) */
>>> -    CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (print_cpuinfo,))
>>> -    CONFIG_IS_ENABLED(DTB_RESELECT, (embedded_dtb_select,))
>>> -    CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (show_board_info,))
>>> -    INIT_FUNC_WATCHDOG_INIT
>>> -    INITCALL_EVENT(EVT_MISC_INIT_F),
>>> -    INIT_FUNC_WATCHDOG_RESET
>>> -    CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (init_func_i2c,))
>>> -    announce_dram_init,
>>> -    dram_init,        /* configure available RAM banks */
>>> -    CONFIG_IS_ENABLED(POST, (post_init_f,))
>>> -    INIT_FUNC_WATCHDOG_RESET
>>> +    CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (INITCALL(print_cpuinfo);))
>>> +    CONFIG_IS_ENABLED(DTB_RESELECT, (INITCALL(embedded_dtb_select);))
>>> +    CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (INITCALL(show_board_info);))
>>> +    WATCHDOG_INIT();
>>> +    INITCALL_EVT(EVT_MISC_INIT_F);
>>> +    WATCHDOG_RESET();
>>> +    CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (INITCALL(init_func_i2c);))
>>> +    INITCALL(announce_dram_init);
>>> +    INITCALL(dram_init);        /* configure available RAM banks */
>>> +    CONFIG_IS_ENABLED(POST, (INITCALL(post_init_f);))
>>> +    WATCHDOG_INIT();
>>>    #if defined(CFG_SYS_DRAM_TEST)
>>> -    testdram,
>>> +    INITCALL(testdram);
>>>    #endif /* CFG_SYS_DRAM_TEST */
>>> -    INIT_FUNC_WATCHDOG_RESET
>>> -
>>> -    CONFIG_IS_ENABLED(POST, (init_post,))
>>> -    INIT_FUNC_WATCHDOG_RESET
>>> +    WATCHDOG_RESET();
>>> +    CONFIG_IS_ENABLED(POST, (INITCALL(init_post);))
>>> +    WATCHDOG_RESET();
>>>        /*
>>>         * Now that we have DRAM mapped and working, we can
>>>         * relocate the code and continue running from DRAM.
>>> @@ -934,48 +937,48 @@ static const init_fnc_t init_sequence_f[] = {
>>>         *  - monitor code
>>>         *  - board info struct
>>>         */
>>> -    setup_dest_addr,
>>> +    INITCALL(setup_dest_addr);
>>>    #if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_OF_INITIAL_DTB_READONLY)
>>> -    fix_fdt,
>>> +    INITCALL(fix_fdt);
>>>    #endif
>>>    #ifdef CFG_PRAM
>>> -    reserve_pram,
>>> +    INITCALL(reserve_pram);
>>>    #endif
>>> -    reserve_round_4k,
>>> -    setup_relocaddr_from_bloblist,
>>> -    arch_reserve_mmu,
>>> -    reserve_video,
>>> -    reserve_trace,
>>> -    reserve_uboot,
>>> -    reserve_malloc,
>>> -    reserve_board,
>>> -    reserve_global_data,
>>> -    reserve_fdt,
>>> +    INITCALL(reserve_round_4k);
>>> +    INITCALL(setup_relocaddr_from_bloblist);
>>> +    INITCALL(arch_reserve_mmu);
>>> +    INITCALL(reserve_video);
>>> +    INITCALL(reserve_trace);
>>> +    INITCALL(reserve_uboot);
>>> +    INITCALL(reserve_malloc);
>>> +    INITCALL(reserve_board);
>>> +    INITCALL(reserve_global_data);
>>> +    INITCALL(reserve_fdt);
>>>    #if defined(CONFIG_OF_BOARD_FIXUP) && defined(CONFIG_OF_INITIAL_DTB_READONLY)
>>> -    reloc_fdt,
>>> -    fix_fdt,
>>> +    INITCALL(reloc_fdt);
>>> +    INITCALL(fix_fdt);
>>>    #endif
>>> -    reserve_bootstage,
>>> -    reserve_bloblist,
>>> -    reserve_arch,
>>> -    reserve_stacks,
>>> -    dram_init_banksize,
>>> -    show_dram_config,
>>> -    INIT_FUNC_WATCHDOG_RESET
>>> -    setup_bdinfo,
>>> -    display_new_sp,
>>> -    INIT_FUNC_WATCHDOG_RESET
>>> +    INITCALL(reserve_bootstage);
>>> +    INITCALL(reserve_bloblist);
>>> +    INITCALL(reserve_arch);
>>> +    INITCALL(reserve_stacks);
>>> +    INITCALL(dram_init_banksize);
>>> +    INITCALL(show_dram_config);
>>> +    WATCHDOG_RESET();
>>> +    INITCALL(setup_bdinfo);
>>> +    INITCALL(display_new_sp);
>>> +    WATCHDOG_RESET();
>>>    #if !defined(CONFIG_OF_BOARD_FIXUP) || !defined(CONFIG_OF_INITIAL_DTB_READONLY)
>>> -    reloc_fdt,
>>> +    INITCALL(reloc_fdt);
>>>    #endif
>>> -    reloc_bootstage,
>>> -    reloc_bloblist,
>>> -    setup_reloc,
>>> +    INITCALL(reloc_bootstage);
>>> +    INITCALL(reloc_bloblist);
>>> +    INITCALL(setup_reloc);
>>>    #if defined(CONFIG_X86) || defined(CONFIG_ARC)
>>> -    copy_uboot_to_ram,
>>> -    do_elf_reloc_fixups,
>>> +    INITCALL(copy_uboot_to_ram);
>>> +    INITCALL(do_elf_reloc_fixups);
>>>    #endif
>>> -    clear_bss,
>>> +    INITCALL(clear_bss);
>>>        /*
>>>         * Deregister all cyclic functions before relocation, so that
>>>         * gd->cyclic_list does not contain any references to pre-relocation
>>> @@ -985,12 +988,11 @@ static const init_fnc_t init_sequence_f[] = {
>>>         * This should happen as late as possible so that the window where a
>>>         * watchdog device is not serviced is as small as possible.
>>>         */
>>> -    cyclic_unregister_all,
>>> +    INITCALL(cyclic_unregister_all);
>>>    #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX)
>>> -    jump_to_copy,
>>> +    INITCALL(jump_to_copy);
>>>    #endif
>>> -    NULL,
>>> -};
>>> +}
>>>      void board_init_f(ulong boot_flags)
>>>    {
>>> @@ -1000,8 +1002,7 @@ void board_init_f(ulong boot_flags)
>>>        gd->flags &= ~GD_FLG_HAVE_CONSOLE;
>>>        gd->boardf = &boardf;
>>>    -    if (initcall_run_list(init_sequence_f))
>>> -        hang();
>>> +    initcall_run_f();
>>>      #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX) && \
>>>            !defined(CONFIG_EFI_APP) && !CONFIG_IS_ENABLED(X86_64) && \
>>> diff --git a/include/initcall.h b/include/initcall.h
>>> index 62d3bb67f08..9398a3ec7d5 100644
>>> --- a/include/initcall.h
>>> +++ b/include/initcall.h
>>> @@ -8,6 +8,7 @@
>>>      #include <asm/types.h>
>>>    #include <event.h>
>>> +#include <hang.h>
>>>      _Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
>>>    @@ -35,4 +36,30 @@ typedef int (*init_fnc_t)(void);
>>>     */
>>>    int initcall_run_list(const init_fnc_t init_sequence[]);
>>>    +#define INITCALL(_call) \
>>> +    do { \
>>> +        if (_call()) { \
>>> +            debug("%s(): calling %s() failed\n", __func__, \
>>> +                  #_call); \
>>> +            hang(); \
>>> +        } \
>>> +    } while (0)
>>> +
>>> +#define INITCALL_EVT(_evt) \
>>> +    do { \
>>> +        if (event_notify_null(_evt)) { \
>>> +            debug("%s(): event %d/%s failed\n", __func__, _evt, \
>>> +                  event_type_name(_evt)) ; \
>>> +            hang(); \
>>> +        } \
>>> +    } while (0)
>>> +
>>
>> initcall_run_list() currently prints (printf) whenever an initcall fails. It's happened to me a lot already while debugging/bringing up boards to have an initcall fail on me and that message wasn't really enough to put me on the right track, but at least I had something. Now I believe this would just hang without notifying you before. Is my understanding correct?
> 
> The debug print is still there, the line just before hang() ;-)
> 

It's now a debug() instead of a printf() is what I meant. So it's not 
shown by default anymore I believe, unless we have #define DEBUG in the 
file?

Cheers,
Quentin
