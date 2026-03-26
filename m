Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9117D109C038
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 07:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0B8C81E18;
	Thu, 26 Mar 2026 08:35:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uF+rY16H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF62838BB; Thu, 26 Mar 2026 08:35:47 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D4380517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 08:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOZCk0DxE4sEq3wB/j1bfIXGrpncXxhLQe5/rTor6EQ8I4IpnuBDuC8XGN+dJHgCCFqs0y14a2bglk199GoOwaZjvOZRyxk4CDGPm0gMTinlFI6kmnvhJ1VYxJ/dnhIdJPjMnyr6D3WoXcgw8V3CG096ld58b3YFOpYzPWnCqJpx4Vl2tz13A5GDOUlp8tdRLUnwMbTmk/Dc6nYmXtwU2J7VHyzUIpmse0CU0N3s05xcq2LfOXGuSz9TdFtj4rDw1gBfFMGPZTi6WDjFeYC+46bt7XqKx90LDytMbiaM4yHAuWpeTdieFsizcyKdxqYq64sCse7xtRz5gxBtB2YFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yARDG0UaGHAisanPmeWtSzBPMxU1Zncu4LA741RGquY=;
 b=FMICmWLG4MAd4u/7fEerEKlSasIwyqk4K0Ff+zfm22Fmz455zeeUxNN0zDu3zTkPJ/doq50WcrKN5yfrkxlHuomW58hapsFz545tmWMm7Soa9X906Ek9E6Sn4Rt1t1iJ+cG/2Y0HTcnrP2gBLFWJm8r1cw3tvDLPLjwKQPoH0gdSRRZy/wkq+B3iKpMEVITVGBIReM46Pej5z4lwNPpeHMZMGL6ySrATW8iWZv/lqDqYb5GF7/vaU78vOvE2AL+IgMnlqqSJkGrhti6NzyFijRz3XX9VOpvYdkJ8PwBtjWUWQxRQZD0RACVAy/GpHADNZiCw5T9HPU2DuD6bGqOl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yARDG0UaGHAisanPmeWtSzBPMxU1Zncu4LA741RGquY=;
 b=uF+rY16HYo9SwFCPdtY8orm/XZOao41NW28AX47XrfYkIqpUeMjGWy3nPV5MOYIKcXghqBwtQ3+Vj9uTS8XwMklCsoID7OI7YyY7jmvme2IPsOLinlV9ipBtkObgIGzN0eW6YO/G/hLNoKEa2tpzOM0EYGQ5ESz499LWGOElSPHO4rfME7W+gaRyYT+HBEOWhcplPJZyXg5V6/GpBfF7pqqojf8gOoHiriWtaMquZveNYWNonbocqbMfEl3jKcKJRhBCY+IJQrvqgX/O5KmEnEiIfOcfw5vr4KQ9MoH//jZV4lBN9jdtuNcy51nL4hRbqzrrJNP9D/TKbpwWFLkhsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB9950.eurprd04.prod.outlook.com (2603:10a6:150:11a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 07:35:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 07:35:16 +0000
Date: Thu, 26 Mar 2026 15:37:50 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] imx8ulp_evk: Drop unnecessary BOARD_EARLY_INIT_F usage
Message-ID: <acTiTpWbHeKeAMs8@shlinux89>
References: <20260325190036.3428698-1-trini@konsulko.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325190036.3428698-1-trini@konsulko.com>
X-ClientProxiedBy: SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB9950:EE_
X-MS-Office365-Filtering-Correlation-Id: 40044268-17f6-4562-1b06-08de8b0a3924
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0AUem4nnsrpOuW5SsKTlcQD8Xavz1m6bK555+o/VLnXE3E1+n/V7W2o0jm+K3KDmOiG2ScF+5c/S6u2B/1rCj5DnXU9TV3vY5X09d/PnvOIyutQ1kXLN7ZZbJNaY7G5Qu0eRAyU4jKuVkpWLDCbDXlkfGq/53XR1cYVStxDEMGE9WZs2WnEhbrWL59uT9WmsvAXCYx2c356QABdMV56z8dGYnJQVrLcFLzSAiSK2ls9+myS59WpQ6D6tDAnPThlrypcxZxCn5X6b0doA7yQgjv/p9oE9JA6g2WqtR5coHnVXTw54WFTfEQ96lwJ0fLMxQ3u5/BTLN9eyK6gVkFxGVXbT3AYlIpBKqsKC0tSc8po0z651PaTTQ0i2GGCR5qktn3l/Is5Jbb4NZFqECtZGgBs/2k06h8mSAqznVlPlpFMukCXy9SYJUgMk8ilPRXhvI7ko0HKE+30GGyQmeDH2uiPy95hDReGdZhxGJCt5ozu6GYZxLXA5kJWjOfI0mUWjag1ldY5Y8lmRFB91fKVjsl99Q+YSqyOAYFQra4wo9SZfMCz/A5UUgNZex3GaO41wgdfeDcLuO2tTwLeOMUXBXQ599VKqIRdeksrdCsCDQ7TeJcmW6EC6nLlgEHBqenoZ+BlYDp4MoA2Jg2vUYb6fZZ/gRoREAXLOic2Ajv+V95Hrvi18tuMO44RgIR071T5SVocdrrbkT+nsgF7CyrPlnR2c6DIlA24lTkPWdnF7LsxAyFeuAdirS5lWEdlQgrvIFPQPRORZtpnHEnEVzPByqYjEIHL0433SwO5gRE2d9vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9HEbX2wtQ/oBPpAmheXyL61PwWn7ejLYbSXqDxethoUip1ofUTSXuBhSw1yA?=
 =?us-ascii?Q?rxsDysrP3BkjJRU8L84lrIgsz3iDswVJQKqHDYjxqcOTAEvpSub2/3mpjY59?=
 =?us-ascii?Q?kCSvZ23neuw10w/56byulhADArvywRFOOK5Ys/FsKKYpBd7X4LRmbBOuGSBc?=
 =?us-ascii?Q?JdcMlVMXNXpC2JhCG9nPgH0f8cwr8LQOed+c/9UpdE+mI+gPi9B9vqrWe/QX?=
 =?us-ascii?Q?VxgTo1BG3C0j4E5v99oP01P5bRtT3KnNR/aVyYAj3KEKq5yl154d77V57jPf?=
 =?us-ascii?Q?FFlIQvkpdsvIZhsN1Xfh7RfeUkWuEac9KCJY98gjS4lu+lH28KHngSg/v6s6?=
 =?us-ascii?Q?1Y0cB3PM/vrCDvxBNx8BlHAGVxPdYd6Wm+1GAYmAfU6wV0kTl1c5ut0s95g+?=
 =?us-ascii?Q?XPkpHCISiFy+rXQ2by1H58yKvJdbz7gW65eJ51bFdToz9uUQVT4GJ3XF9iDt?=
 =?us-ascii?Q?Tj4dLV7Kibejc4kgHlhAfzsrzhuhcjnPHOvfurEbCbqlLNDDOlJ4JJk4v7KR?=
 =?us-ascii?Q?6VyGQ8vwPZGbfXMpgy4MDLuIDAclKQnnLM9dBpBBpTofEZJEElP6XgUIoyUI?=
 =?us-ascii?Q?s271fYgvsj9DZuah+Ff4usl/Xyx0SSIELgKpYqVN3TV5YxHgwIeaYab/i4GM?=
 =?us-ascii?Q?8gNKBoPZ2i/mTvHZSQa7uXVUuSpxnLypH40Cnehg9Zvr7bLfPo0SHf3gggl/?=
 =?us-ascii?Q?PSmjv+CBFmBAZ6oFUFVm2YnebWp6jl9YuLiDd5hOdG+1DrRVFJ27jc6F/DLQ?=
 =?us-ascii?Q?tUut1nCOhe8OI701P+3pl/HpGk+cPl2PIhP6Vu0ysoYKNFAKPpb/xpk3lpWg?=
 =?us-ascii?Q?vVy5JhYBdv3kknqmKHZcLaqpfZSqh0Nb7FPpV+bZy0b4/YL+OrUIgciPOdye?=
 =?us-ascii?Q?dkWd10KHE1w321UIId6ihc4XPPzMVrZQrOB8ye65zQyvlbU9LLgSzoLivwbu?=
 =?us-ascii?Q?9vB6si7cIxvSg+kEk/Y/166EAEShgzxdfnBXcOOsZVzSt/GpfWVG5xzz0vIk?=
 =?us-ascii?Q?8YrIChsNBFLkwH0W47Iukl3Ri5Xjtl7doB0LY2HaXSkoWvRDpWolMww64KBQ?=
 =?us-ascii?Q?T61wkktx9M6UOyXwIHqlyupLnW9s5+zpfSq0ec3PbaffjszEl6vg5llRDYEE?=
 =?us-ascii?Q?yYOFDbre4QnqbEmpqg6vukX0zbykaC25DRRtTD3mDA8UTU/LQyb+JACy62wx?=
 =?us-ascii?Q?gXVAzw0Fz3Vj1GNQ+rafeAYC6Vi7b3IQ/+G0exJM1WHRA8ShOhoInBqVRNVC?=
 =?us-ascii?Q?NPzPvLn9dlc8xVGGsIyqs18KCXUCxD0pFH15ONPtKjykrcjTfdJKNdAcG+9n?=
 =?us-ascii?Q?TO86ZiT0f3cLdT7LInTcq1cz4+yUgyg339YEu4KEIUkOeaOI18U/685X8AyX?=
 =?us-ascii?Q?w8Jf+aewM8pqxy17y8BpapvzZPFtm1mDAIGfkA6H4+FWfqSXZdX7G9VSfrdu?=
 =?us-ascii?Q?pQB6n+CvcdQsuy9H6L7UqNZ2vIkMSB79wOgUTXhGT552IwkeTQS6A2NwnBhF?=
 =?us-ascii?Q?nVgIoOXO3NGhSBcOwB0WGS+HzI9awnKi32SKlWdLWeiVZXfdeGfReZtKdkSt?=
 =?us-ascii?Q?CrXlzNrwi4PK3iaYCeRsBYGKwk+BBHaN6ZMxdywxiEbAWH3pIC+RctInWkoH?=
 =?us-ascii?Q?DVQ3uufyANZKHafMlciJg7x2nLSx7CTGpTNZigdDS6AU+MG+No4w61faBxc3?=
 =?us-ascii?Q?yDJXebgjywnC61wBnilf7i0nGLXVbfyhK9byrV97ESDM+Hcj/qJ5pw/55tEd?=
 =?us-ascii?Q?JLOF5IyEnw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40044268-17f6-4562-1b06-08de8b0a3924
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:35:16.7343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSs0Tf9QUeWA2ZcoQHtpniDLZFSmpN3zEl4l4gyvmAP4W8+Ms+hfymGUcVtW80HS0TFAeLO6efQyZt1y2ab+2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9950
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

On Wed, Mar 25, 2026 at 01:00:36PM -0600, Tom Rini wrote:
>This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
>do-nothing board_early_init_f function. Change to not enabling the
>option and so not needing an empty function.
>
>Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
