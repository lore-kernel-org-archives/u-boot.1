Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF17CDD56B
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0462088FF7;
	Thu, 19 Sep 2024 04:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t5aXsrID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F5B688FE3; Thu, 19 Sep 2024 04:58:36 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7160B88D4D
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLhDXF9yLeZTp3b6jZcMcSd4cawWYkGI1SDkwgW/quZ5r4W4iMR6BCQTbOglWeihmzdaws6wb087GkeKn9d0wF1Bmt49URfduUJMb+78fUYrYZWzSVfKHor2ck5jIlTxJz+ziDZ4XvzRXQJvst0mvblF9QZxadESdHQhuKT4KsEpbl9RY6mpswn6vbNYbmxqaAwmDFvvn6JdKuA3N0ZbXhPtja+2qbcC+LuH39Ms4wWoarSmnA3/vpZ9U/DYwbCfIadqT2CGXd05PFFpWOeSh8u3vYewHKgcRXuuiIUZec0ay1vK1CxbCt9tJ59xp4hFfqbffmTjy/661/sKKD/eQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym7glaHqf5tRgAWf3Zop5kKcoOQurd3OX6hQyHSYWSA=;
 b=iuqPoqoy+hr6I7DLxribRsSB7py9P70lqlAR3UgPqpT8j8KiihsfOWqjdaM7Z5p8ytru1jEhHsymbttPCAKmZy4GKwye9CxXoZXR3MKyM48yNDtzX9kMiyAUgfpWyWqtb16et11aKHqC2ASE62PKPvwO3NbhHtEf6pXwsrPhgfIo5hnH31EHdMw4snTDtYFl9/GaHm9lwB6BF4UOUXRC972Tn1XbVKIzcnos4AgDjyKlC8ESeZQegdl6/+YRDZoGI94OfGPPvqFVlNE8rpfx4Td0J6ZStbYyv/FH+F1io+pjO+ckg3NBZX8uW+6MDcSlU4xcRRC9qvQe7xWNHdVTzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym7glaHqf5tRgAWf3Zop5kKcoOQurd3OX6hQyHSYWSA=;
 b=t5aXsrIDMwZKcOsybd9os7s0q+oQ8tYzvnzMDMHXAheIsREzvJLGRmix0Lm7cKt/CmGv8Bn+nvjRpkTYTiemp4D67SPTPooSOdWM1y+O0BfGcDv6Wb1xlTdi03mtUjMyduIlIjrBN4NAC2z9j9afTpC7M4f2ugnLEL7GTogMy+t9nqUkMbZyN7k8UxFfRkfwLZhW6XHyVeialbT6Q1LxME616Bf8er2pU+QtZ9RRkKz61rk4DoTNpnRZ4fzt2x65mR40MW7g+ELEdRmlUNBnuUg8pc+rKQkpfVn+bY1+zw0wYwnXK+VlgdnLlwv7DdOfSdMwVhBQPGt8Hqg/ZWOz3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:58:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:29 +0800
Subject: [PATCH v3 11/21] imx9: Add 233Mhz DDR PLL frequency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-11-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6fe3f8-aab3-4d01-a2fc-08dcd856f27b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WThHazYvTE41V2k0OXhPRDYraW1IT3Y5Nmdlb0RwRkRBakh6NEVFRHl6TktK?=
 =?utf-8?B?SkxmdWo3aWE2UnNFWXhudnQvNEY4Q29pZkVnb2JsQzdGQm5sUFcxdWZBd3Jp?=
 =?utf-8?B?VFFTUFdIdWYxM0Vja0RKT0NuM01VbU9OcEFaT0N0NlEybUIxditraWsxL0RE?=
 =?utf-8?B?Tzh6VndFcW5nemZRRnhCaW14WjNNbzc4NFgxMU54RUhKMk9lT3BXWmRGamZn?=
 =?utf-8?B?RXZEUWt5dHpTdkNadWlCNEtOVy80bHE1WXNiNVRveXhuWHRNYVJoMGdhcWVC?=
 =?utf-8?B?MUc0NHlibCtCRFRzSXBPd0x6MjRxZUVyYzNCcjJrUjVJUW52a0ZWRktBZGRu?=
 =?utf-8?B?eGpmbzhVYnhSWXNpVXNjNXo4RUY4UkYrb3FaTDczQzZYdlJiYzJYME84SG9E?=
 =?utf-8?B?OWJreWJXUm1Ec3gvVlczcmJqYkR6cDFjTmExUGNndlQ0ZVQ2U3gwc2w2SG9w?=
 =?utf-8?B?SUNRNDM4aHVwdHkwQ3pkVFFIY2k1b2NGUlM4WDk1N1BXK3dGeDRmNzFhb0d0?=
 =?utf-8?B?eUZRNkY2NW0yM1c3R29UYnQ5clhBSG1sOEExTmU5SFlzWmJQeHVwc3ZiRGxu?=
 =?utf-8?B?M1BkRVdhelpOTXVCT0g5RWU2WFpNbE0yOHQ1UW1qb3Z1RndjQUlRenJqNTVr?=
 =?utf-8?B?enkyQlVKb2VSVW80VW5wazVCY284aVF4dDcwR0owNklpODRFaFpadTUrUUhT?=
 =?utf-8?B?cjhxbndoNS9oR2MrWE9Kd3JBbFdrY1luQUVzVUlMRGZiZmtuN3JtT241QnNi?=
 =?utf-8?B?S1prM0Z6c29hWERIWHdQNXlXOHRNOEZvL2VLWjZVY05zTklJSytQWGJNV2l0?=
 =?utf-8?B?V0JwSWJvS251dExLMGl4U2ptZnNaaWdNckRiRC92UkNRdkpaU1QvNWU3V0N1?=
 =?utf-8?B?Z3pkYTkrL1JadUd2MXpiWGI4MDNqcjlXdEZFV05ZKzY0QUp1U2V3M3ZvOGxD?=
 =?utf-8?B?NkNocmtoejhvbyt6dTl4ZGZOVnJ6MitLdjBHdzNJMXlQd0JYQzE4RFhlaDla?=
 =?utf-8?B?OTNDUldRNkhYTXQ5elhhRitUNjJ0NEJVOXpCQVhxVWt0dnU4b0locjBSNTQ1?=
 =?utf-8?B?SStPUjRqeDR2K3Fqb3o5c2daUGxDOW5lQmdpQ1JLZHRhUVhRVkQxRUhnbDFz?=
 =?utf-8?B?ZVVYaU5rSnJKRnBQZURUWmk0SWNydHgvRHg0MkhLUDZCdkhhTDNRZEZ1QWR5?=
 =?utf-8?B?RGl4Yk53Y2xERjBHVmZCeDhYVG43WkN3dTBYZ3hqWjZQM0dHV0MwUURhcm5I?=
 =?utf-8?B?eDcvakxXSEFIelE3UHRHVGt1d05OdkkzMi9RNjE5N0JjMDltQ3Brb0M0ZHVR?=
 =?utf-8?B?K1NhT1YycUtFZE11L2U5RFdIbGxER1Nzdm9KaXVGVG9QSFRNWEdtV29KZDFY?=
 =?utf-8?B?bmx6a2ZPWTg5ejF5aS96Y1RkSGNpbGczaHdycU1zUFU1T2xvV2U5TjRpNnIy?=
 =?utf-8?B?dnpTTGlBcVJNQ01qOTZQb1BsWEROM09yS0VrZmc3UWhmQ0xKMzFBSEVLcjZU?=
 =?utf-8?B?eTZxaTJPUDgwM21lNm53VXRqRHJmaStvZjBBRVVPb2MrWXg2QmtpTFpEczln?=
 =?utf-8?B?VW5ZOTFHNTZBOThRbU5nM3FDVDN4YlE3VHlFZkZMVjVkT2psRVRwY28zM0RS?=
 =?utf-8?B?cnM2dW1RZy9rOXhHV25wTVpSQ2hnejRVdGZVVzhobnR6SzJmbTZLZ1dOVDJq?=
 =?utf-8?B?ZkFTZ1VOWDFVM25RNVVSczVhWWNScUsxbTFwUmNXaHZqQ0o5SnZOcmdwd2k0?=
 =?utf-8?B?b3RLTGdSL3ROd2RVSTNGalFNQkdUcldpejdVbkQ3eFBYK29zeVAybTlLdjZF?=
 =?utf-8?B?dStxbHFUYmZtZloyMUtWakl3Tnpka2F6QlEza2sxek1TSnNFczVUb2R4Wlg0?=
 =?utf-8?B?ekE5UDY5MTZHalBnQnZ3VCsva3NmeWFhWk9LOTZxYS9OYXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGJITDR3ekhNcmFTaW1wYXErSTVIaTljNGtrTGJCOXlJQUE4NHdCeS9jSFNG?=
 =?utf-8?B?eS9vOFpuRVVxWEQ1Yi9UaHFFOFg4dkh2VnNxeVBPc1dQQXJDTE1LOU9MblRD?=
 =?utf-8?B?Q1p4dTNXNmFMTUx3QmlHdDVDREtrc0JML1dtZnk1WitrV2hKRnJJWnRHSXFN?=
 =?utf-8?B?WUVJVXQyODF3NE85Nkd3MFdaT2tlcmRXZS9DQnNISWZOdlpjYk9IVXRuUmYz?=
 =?utf-8?B?ZFFjYm1xSEFkNXIzUEtsUTRRYzJKQWtCbTlTTWJYTDluZUljUi9BdGtBakpV?=
 =?utf-8?B?aGxqckNuSVVsZ0dKNllBVmVvOVhRMUdRQ1B2dW8wQ2Z1QWFOYXdsalVnaExq?=
 =?utf-8?B?VnczVldGTlJ3T1ZhMEZCY29pNktkc3kvK0pTZzhDbEJ1bFo5VzhEWWdnLzVJ?=
 =?utf-8?B?dUdUaEJEaStEVUEyYnU4UVVYVU9qTmRDbTIyditiSmdaRjhZUXIzS1IyeWMr?=
 =?utf-8?B?QS93NVlRbGUrdGdpNW5zYkRtTUw1UlNrRG85SGMwclIyUXdUc2FKREFWRzJO?=
 =?utf-8?B?RmtCVHpTZ1p6di95cGxEejVZRjFwaEUvMk9vVUlBSVYralNHNndnMERmS1hL?=
 =?utf-8?B?M1hSZ000RWtFb01XYzl6MmU5akkrYXVpWnYzNHZxOURMUU5tRm1EajJqK3dl?=
 =?utf-8?B?amxFZWlSUG40ck54YVRLVXFqeDJNRFZXVUY4SVR5bmE3SUYwU2kxRndUTTlv?=
 =?utf-8?B?MisvUHNuYUl4UVI4VXEzMUIrMU9ZNWlOdldDeXdWdldlU2pHU0lMbytyN2Nu?=
 =?utf-8?B?SWhEcGMxRTF3S3Z3NFVSNzN4RUkrTStvSWNZRkJmVTI5THRkdGRuMGNvcDMy?=
 =?utf-8?B?QkswU2QwbERncVIwUjFtbDFkbUZuRnV5VzVwSDEzcnZvZ3doY0RzZitpaFdT?=
 =?utf-8?B?V1ZRUy9lRkRoRjhRVGc3b2hEQW91ZlA4ZStQaURwVE5hQVBIUHJkWG5reDk5?=
 =?utf-8?B?MkdYVDVMWUMvQVlzR0hDSStTMkFMQmdvZzBlTGw1SVhaOUt3eWd4NXJ5THg3?=
 =?utf-8?B?ck9JdDQybnE4Nk5PVW04WXZtamxDRjZFTktCdlBFNEhBR0lQdmJsaVVFdTJp?=
 =?utf-8?B?Q0pDV1FwZVNEUE1JazZ5VmxvekhMTm8rWXI1Zk84NlJyY05YSndwajV2YWhQ?=
 =?utf-8?B?RThMd1lkNGNuM3QrOXB4eXlUNmZSVGIxa2NVWjNCSVcySU12SFpkZmIxV0Z4?=
 =?utf-8?B?WEVJdERNY0xveXhrdkcxK2hXUDE4OWkzQWpKeGdWQ3pBRHRzM0FHbDhidk43?=
 =?utf-8?B?cDJ3YWR6TDVpd0hUSjRCNC9Pek1mVXY0QVdIZ0xTR053SjN1UEIyemJZU202?=
 =?utf-8?B?SjVnOEF3T1pJTzhRZ01jbTE5U1p1dmE4QkczK0VRYUJHNWw5OWw1MlhIdlBG?=
 =?utf-8?B?L1ErWlp0UFEzd1ZnaVdmVHg4cGZrQTFJcXZpYi8zbm9Ud2VKQVJkV0VzNjJ3?=
 =?utf-8?B?QUpEV2VtVGplQzRVZFVvdWNJbDhZMzBVckJldzhFZ1RQeStMR2tIRmhtckxa?=
 =?utf-8?B?SFRERmFGUzMzc256Y3FnNzZ5OWovOXNGTzZ4cUVaRXhVSVpCc3o5azRCa3dk?=
 =?utf-8?B?WkFpVDUwN3V1ak9vdjVVQnFjcHlmT0FaaG5DbmhpU2xnNU0rQ2ZIU2JqbXdt?=
 =?utf-8?B?eXVoSndmMGcrYTNIWmE4a2VxZ2dObzZYY1Nxb3o0MEdiQldjM3RhU0FyU0pu?=
 =?utf-8?B?aUtxMG9rai92WWRXbkV4WlRPS054cGwzZ0NJWEYrbkg4c0JOS2E0Um5jbXM5?=
 =?utf-8?B?OTN3bHV0THlLUkJRbjUzYkRJWnVlNjM1L0JxOHZLL1g1T2NqbklrTVJDUEdt?=
 =?utf-8?B?dm1tMzB6VFFJSW9DQmJ2YVdBandnQlBqUDk3OUhQY0I4d1UrRlpQVWFMaTJW?=
 =?utf-8?B?VStuWXVjTGNGK0FDV2RySDR3enVxQU00QVQ4bzNiMWxnbXZKQjJmc0ZwbnFI?=
 =?utf-8?B?STBQQmZ4bU4wNzlHR05tSTNHZ092eVNpTTFUUEJQSDhXM29UcFR1WDBZMGcz?=
 =?utf-8?B?QmptcEZRdWdoZUg5VW81cHVDd0tja08zYjlRaEloRW1QM0R0Y1hnRFgrQ2tT?=
 =?utf-8?B?VS9kS1M4WjZEYUYxVnM0R2w0U0hZcys1enhMQ203dm1HdmxYcXVyeFhOUEda?=
 =?utf-8?Q?yenb9Yj8JTYVWlslxeqPRJ7BE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6fe3f8-aab3-4d01-a2fc-08dcd856f27b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:32.7668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9t8O5cD/i7tDeE+3tjo03tU+j0u4koH425KaRfwgOsrscxEgZzZo1eWce9hEU3LSmQsl3RyPzW3+lVZQ3V7ZYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986
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

From: Ye Li <ye.li@nxp.com>

To support 1.866GTS LPDDR4x timing script, need to add 233Mhz freq
to DDR PLL for second mission point at 933MTS. Otherwise DDR training
will fail.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/clock.c     | 1 +
 drivers/ddr/imx/phy/ddrphy_utils.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 76d19f1cba3..12685f970de 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -41,6 +41,7 @@ static struct imx_fracpll_rate_table imx9_fracpll_tbl[] = {
 	FRAC_PLL_RATE(466000000U, 1, 155, 8, 1, 3), /* 466Mhz */
 	FRAC_PLL_RATE(400000000U, 1, 200, 12, 0, 1), /* 400Mhz */
 	FRAC_PLL_RATE(300000000U, 1, 150, 12, 0, 1),
+	FRAC_PLL_RATE(233000000U, 1, 174, 18, 3, 4), /* 233Mhz */
 };
 
 /* return in khz */
diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrphy_utils.c
index cf5bdad7abe..14278f5ad8f 100644
--- a/drivers/ddr/imx/phy/ddrphy_utils.c
+++ b/drivers/ddr/imx/phy/ddrphy_utils.c
@@ -148,6 +148,10 @@ void ddrphy_init_set_dfi_clk(unsigned int drate)
 		dram_pll_init(MHZ(266));
 		dram_disable_bypass();
 		break;
+	case 933:
+		dram_pll_init(MHZ(233));
+		dram_disable_bypass();
+		break;
 	case 667:
 		dram_pll_init(MHZ(167));
 		dram_disable_bypass();

-- 
2.35.3

