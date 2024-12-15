Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4BAE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 01:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 613F6800AD;
	Sun, 15 Dec 2024 02:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nTBPuAzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B19158006D; Sun, 15 Dec 2024 02:05:58 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BFF98006E
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 02:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMXnsO5bmd85F+W5o6bXZFE0bIQhZifFchlQFDWP8nxobyRDV7EmLDSdIdHXOZ3HHj09K4wQhxFv0mxY6Iky+QNLUFY54Nfb7zpDM8CoOymXN7SA1/ieKCzE1rXaDzVpB6XgKIN4AmUCn0wp5GJ34ltUl2s1Mm8CAu0mLp9uaN4S9mvSeqQ18zZkoZrMu/gb8abFC1h2HCE5j2px5EHAGCUFbkAqP36Y170cyJjcOFMaNbu6YRXlDLF5G/8EyLw/Z2OAYsy1IhPaf7Krp1ECBX13g1NJF2QyRCuXcIBWo9hnCdk6Rj0CLNT804ayYoHeS11p50n2szenlg2a150KyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cvbnkdIOFmu1Hry+0zzlj/urDndRQi6xAKcmTRPfKM=;
 b=t7Lkeci5OHPd85y/ZL23Dz5o6TQKS0j0bCNeFdV/U6epQoxZIx1hZ1s/S/UjBKVWUWsuA1jDQka3lxBcefi+3anU7JOepMa9vhR7Px5Aw7eRKK1xyDh4UnOVApL6xoUNaXRvsRc8wrQWn2E2I1uFVe3oZhHAK5CNd1deFRI8Jj5ZdjpOTlnkpRb5hO1Dfm91KpiOs6tU5b+61VS0bigIg7IQiBJxbuf/LuBCrJm1nZ2dqd1BNcQmQsfFBJXn+yZ5W312T8Ogno2bSZQQROlJkh1IqVc4Up69YboaCCzasg96c9O/BFAhlBFfzeX9zPd8lFDybA2d8LjKvSnUj1HwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cvbnkdIOFmu1Hry+0zzlj/urDndRQi6xAKcmTRPfKM=;
 b=nTBPuAzGm2cNa5cwJbu+70EL6hEpgG47hpZ/PBrYs1Zm1pxiOgjWzeMwhd7/tqAyACe6qI2+QeiZH/tqna+3IelyMYOtGm/nNMT14sC/8ea2OwsUi9oCoVV2jbKiWWgHmu7VUhKHZx7ZPLz6QzUvwfsHqTjUeU5E/okAHB9BoynZOymj8SsYi4NhAfiR6NtINLiEvlyFy+u05rbpEvvLo6nzvQsrtimmhi9CJjgBwqqfcvnr5UwlAPlV4irfOR7JFj2wn75Fy0GDGvBGqBKuntByLTfNt/GbvnUIRuPm3s0WSkWFx2uDWizu5VBqYfvo/nkCgxQ66lh+QfVJ+A2EOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7485.eurprd04.prod.outlook.com (2603:10a6:800:1a6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 01:05:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 01:05:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Wei Ming Chen <jj251510319013@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, andy.tang@nxp.com, trini@konsulko.com,
 sjg@chromium.org
Subject: Re: [PATCH] configs: ls1028a: Fix bootefi issue on Layerscape
 ls1028ardb platform
Date: Sun, 15 Dec 2024 10:11:04 +0800
Message-Id: <173422862035.21608.18080324091245216347.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241013072435.1506107-1-jj251510319013@gmail.com>
References: <20241013072435.1506107-1-jj251510319013@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: b7cafc23-108a-4bb1-8bdb-08dd1ca4a01a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmIxQ0dUNVBGZStleFJnQjYrNUV6ZllndTBOdm12STZsV2hCMXoxWmJvTW16?=
 =?utf-8?B?dVd5L3FKQ2JvVWhwVUVyNWhGWVJRVjhTWWVQQkdQSmYvSzZUOGQvZXkwOS96?=
 =?utf-8?B?NEV1U3dwSU1TVGJ3V2JTNVZnQk0wZ0RhcGdheDJiaGk0VVBueFJ1WmZPZ05v?=
 =?utf-8?B?OGY2RjV1em1UaXBONEUyYVRnaUZzRWJpVkJSaGNCZmtZYW1QeUZXSS9Sa2or?=
 =?utf-8?B?aXUva2ErZ0E0ZklWanlPdnAzTlZKUUlwdGhOSWNqUTBMTFdSREIrTWZmM3B4?=
 =?utf-8?B?SWlKY2R1d0xvUER0VzJNTkVCYjB0eHRpYVJuYmNwTTM4MURlS1BmQldhYlhx?=
 =?utf-8?B?OXdYOThVWFhBYkRFdXBHNXlsWDVWSHJMVElldmQydDNFQXlFZDFHVkpUSmM3?=
 =?utf-8?B?VzdFUU5uaHA3K2FMKzQwNlFtWFQrZUhxcXF0TDRRTTlTVm5YblVVRXZoVitE?=
 =?utf-8?B?cHJYUWZCNzZlMXNWRFJxQ1RXQk00T0gxZ0RvM3JBdmZzKzRmTC85VmorNW15?=
 =?utf-8?B?SmVPa0F6bjRYbHQ3ZGpFV0FGcFMwdUh5c1I0U3o5bDdwM1FKbnNUR1FTa2pX?=
 =?utf-8?B?Z203YWx2dWhtZ21SVjlEdGY5WWJUYjJoYkVSTUhBRS9nMTVkQUJmM2cwZHlj?=
 =?utf-8?B?YWEvWExrWmpKaUJFSGdBOVluM2pBbEtxNEVwSUwwaUFPMGVmQUlwd1I1ckhT?=
 =?utf-8?B?QzgzdHE5UDk5cmJ0cENBWllVV2hGV3VnSXRyWmNnYTVCMzVoR0piMUM2aDMw?=
 =?utf-8?B?VzFiQzJyVnhWckVtM1RoN3cyeUx4QlowR1VSb1RIbnlmbEdMK21HMmNGVnp5?=
 =?utf-8?B?UVBYMmovU3dMR2FVREpoQ0sraVpJOW1nd3Uvem5CZmJvL1NFQXFwOGZ1amNW?=
 =?utf-8?B?VllreWZyNFlNU08xNXhIUjFmQUpJNkV3UUxQeUVQNnVIOGpHUTUwVFY4VCtT?=
 =?utf-8?B?aVB4Um5UMXVqYzZpMTRqY0I4L2Q2blo5WWV4SmRjSkszdU15eFNrcm9PNERR?=
 =?utf-8?B?OHFLbEhEc3V4SDFwZjhZV3ZSUjJBY0JrSDRKckJCbUNrWlRzUFUzRlYvbG1P?=
 =?utf-8?B?QytPRFdqNGlmSFB1WFVpT2JtSkZEVHpyenpMRVlvaXR0WUI2T1RrRjJ6b0hn?=
 =?utf-8?B?RDNIc3NtRWZ5SURvV0dyVDU0ODNvOGREbUkycEVLNDdoQWNMU24rUHo3S1pB?=
 =?utf-8?B?RU9wL0hzKzZ0K0Qyd0pnRjJpVHcrVnFlb05rUy9hVmJkS1hVeWx5NzhtYWh3?=
 =?utf-8?B?Rm1QOG4yN1gwcUVYM2szZlQ4OUtMRWNNYmZucTlFQnNuL3NlZy90MXdhWTZS?=
 =?utf-8?B?VGtXaHZza0F4cmxTaEtGd2p6WWIzeHVZeEZ3bjQyRlFsOHh0a0YxSDVBL01a?=
 =?utf-8?B?S0hQdFcyUFQwaEZWYTFzS25MN2tFZ3Z0aGJqZ0pRV0lwdUhVbTdrSzdKSlFJ?=
 =?utf-8?B?d3RzOENKaVdYNFlHbHFXalZFRWI5c3U2S091cXJlVFIzSENHMzlIL3IraHh1?=
 =?utf-8?B?Q3FTRWg3a0NsNVBBMXV0MjFYNlhSRU1vK1hIeWRoMEMyZFNWYlVLYVErQ3JH?=
 =?utf-8?B?bWhMdk42V3Z3dTBoZkp1SkxuRSszR3FTMHhQNTV2cFRSdjlubFhmcWdSQlpK?=
 =?utf-8?B?WkN0dlJoVDJVbTJ6WGVYVFJzTEFEZEQ1R01Dak9jaVFUdnIwQlN6aFFMSlp1?=
 =?utf-8?B?SStsbFBRRG1GSURvelZSMzdMaktGNHJtenVMYTVXQ2tRa252NG8xYTY4Kzhu?=
 =?utf-8?B?cE8wdWR0d1FGbkY3QklXenN4YUpCNE50NEkxZnVpeWFHOGdGdW80N3JrQURY?=
 =?utf-8?B?VWpNM1JGQ3psZXFDaUU1N1pzUGorOTdScDI0eFUzT29aRmk0OUcxazdJSjdI?=
 =?utf-8?B?WXdvMktJbWhsdllPMElYeWp6ekVXdUErblpaYUo2ZlhFd2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm8xb3kvb3BOYmljLzRQUUJyNWwycHN0aVVQTnFhaCs4aW5uYjRSVTgrMGta?=
 =?utf-8?B?L1pGUURrUjEzcDVNTVhibncyWEtFYXhOMk5hTVJaRXc1eFpxWHhKOGJQWlRV?=
 =?utf-8?B?TmJmdXRkd2VWTitWYUJQMXJ2SG43VmVGQ0VnNnE0WTRUK2RNWlZSc2o1c2xk?=
 =?utf-8?B?VXNpaElPUUI5aWJ6Z0VldFlWOXMxMXdoRU11Y21iS1M0SklvOGppU0t4SGY0?=
 =?utf-8?B?UnhrQnZCVjVSSXRReHFzdXJxWUJ0V3lPRjdHZlNPNjkxNkNqazE4RVZmeTRy?=
 =?utf-8?B?bVdLeVRYTnFoS1VQWlZOK0ZYYWgzQ3dUWVVGbDZEbkkzbDJqelgxYnN2UkhU?=
 =?utf-8?B?b2xiWlNWQnF3ZGpuZ3NFRUZNSFZ1TzNjUzFYdFRIclNJTllickxkSGtRbmJ5?=
 =?utf-8?B?MXhDSGtkUXNzdUZ4N3F5SytuOG01MDN5aWhUZTViQzdtaVdOSVFnTnpDKzkz?=
 =?utf-8?B?QWU0YkxZWEJFN254UjljNUhjcXZaM21xS2lVRU9ZMzhIa2cySHkyeFhmdkdL?=
 =?utf-8?B?S21RTmRONGs5dFBzMXgrSmd6NVFReEloOXlUZEkvK3hpUnliVGZ3VDRQdVBR?=
 =?utf-8?B?c2hCS3FOK0ZJSVk0Z29ZUjBFbkRZdnNmKytway9IZHF3QUp1WjhtcnhaM1pL?=
 =?utf-8?B?emgzZUhmdGN4R1F3dzBnMDdCaEVIUmNHYjMzbXpIV2lTRTVXQ045VXYzOVZC?=
 =?utf-8?B?MzB1ZHQzcWJMeDNYRDNKcHJ1VEpwNWtKZFlzdFZKbW1JV0pFZmNCOThMRDhy?=
 =?utf-8?B?Yno2bWtsTE00OXY2ejdSOGlQMlNuSjJtMjhYS3AvcjcxdERJQW83Y1RzMWRZ?=
 =?utf-8?B?YW5QV1c1V09kQXpOcVBkcEU0dWxsSWUrOFNiRFBvb2hGeHVZT2hDOGgwRWx3?=
 =?utf-8?B?Rkx4ZWNoYUhtbkJKUmZ5Q1kyMytqSHg0THlhWTVRNGJqVjZIdEFhTVpuNlZn?=
 =?utf-8?B?MW5yazlWTExseCtWOW0rc0ZCZHBGaStiMElhbjc0MGJCcmVaZk02UlRhcm9B?=
 =?utf-8?B?QW1JdXVEejZHaHVVY2pKTE1HaFpwd25NU05pSFhJQjFRYU1uY1Q5ZW5JdmxX?=
 =?utf-8?B?dFl2NlI4SlpUNXZjSzFSNS8vWXEwcjJJQXNJN1FYRFAwcjNQR3ZVRmRRMjBS?=
 =?utf-8?B?U2pRMUhTZUZlcHZnMVp6UnZ6ZWJUQkEzUENXK1ZVSlVveFJzeGdyNFRQS1BY?=
 =?utf-8?B?SHZ1VjkrWEZzSElhTjFCZ0FUNFVMZitFRHJvQUkrd3lPN250Mm4vZ2ZQcGVp?=
 =?utf-8?B?M2FFU1U3bldmMXd2RWVieVk2cllhRVkwd0RIRVpUeVg0bWlzSk1MTTdMdnlZ?=
 =?utf-8?B?QU9zVTdOQ1VJSm8vajRtTWxSUFVWTkMxZDhiR3N1c2x6cko1bVQwdVE3NFY5?=
 =?utf-8?B?Y2l6NWhrbExnM3ZNM3Q2RDltWnR1TVUyZTFxQUoyTE5sajB1Z20zL1U0Q1U4?=
 =?utf-8?B?Y3pJMS9yTjAvUEFkSTlvcEp1d0lLRzkraEJsK1c5alVIaGkxVkx1YU1VVWJY?=
 =?utf-8?B?NWw5R0ZtRnR6N2dlWFBzZVVGTEx5MWplSVF4TkZibWFHMmh6ZWRVZVU3ZHVW?=
 =?utf-8?B?UXdTNDhsdDQ5NTIrQ0tPSHVpSW10TEtvUFJmY0hGUWRPcDh5UEZVdXNLRDRM?=
 =?utf-8?B?dmdVN1ZsbS9Lcjh6dlRQRzVkV0RFbFNaNWxCNkc2eXVZRXJ6L2hnVUdLWjZW?=
 =?utf-8?B?SXhyaEl5TWpvaTlqR1lhd1Nvd1FYTm9DOXBVN0xFMzBJUjdzQkEvajE2WkRU?=
 =?utf-8?B?cHZCVThuWDd0dktBYU80MDhEeEdtOEI4Yk4rOUpXY1I2aDl2UWZyWFpzT0NU?=
 =?utf-8?B?M2JDVWh6d3d5RjY2K1l3bllGbGZhNy9SWjIyVGJBc3lFYjVySUdIWkhXa2FW?=
 =?utf-8?B?OEFvdld2Z1NwUng0UlQ0SHA5UDZOODVmcFRIWmxHTnJoTm5hZlBOeUdGeUx1?=
 =?utf-8?B?RDk5V3dpNlJYUytZSHRYL1pjcDJsTlpFb09sZXNEbGllenhYb2FpTFhFV2tH?=
 =?utf-8?B?Vk0rU09CMVB3endvaHljbW9YTEJBZnhnVHRxTTNGa21HTTdET21YTnRLOVlD?=
 =?utf-8?B?MmlkUzBkRU9pdGpzVFN0VnppL3BVWHV2QjRLSUl1UkY2Rzd2andIYmFqc0tE?=
 =?utf-8?Q?PMazCoBrk1OBNvLGnipxStf9v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cafc23-108a-4bb1-8bdb-08dd1ca4a01a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 01:05:54.6131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7AEd4eExXFIMFgwyjrIErUvB9yeX5HopyATGtUAxXsQh86dR8SJ3irKLxvpXZbaG+kngLVXKOONxvMogUxtHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7485
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


On Sun, 13 Oct 2024 15:24:35 +0800, Wei Ming Chen wrote:
> Without this patch, there will be error indicating that
> "Cannot use 64 bit addresses with SDMA", and the booting
> process will stuck.
> 
> please see full boot log below
> 
> U-Boot 2022.04-g18185931 (Sep 11 2024 - 13:15:30 +0800)
> 
> [...]

Applied, thanks!

[1/1] configs: ls1028a: Fix bootefi issue on Layerscape ls1028ardb platform
      commit: b4626f3934767e2e40cd56fc4368af835fd94126

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
