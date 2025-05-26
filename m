Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11797C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96CAD82B7C;
	Mon, 26 May 2025 09:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Qo3qti2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D06982CA6; Mon, 26 May 2025 09:10:15 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD3082B26
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KerMCWBGUD1vPD8CCvdXSncQiXdZMZahe/+kph0+aDjFtrOqhBuEKV0ZOStq407kbG2up6P3X9Leb3mw848VSmlvZZ9+LpCDmdmww0W9TlxRyCzcrh4CDWVrUTamDwDD0gWnhLHeU1FIGHkHojiDKEsTBUIGQu2f0iKJ+l9EjtdR6Pg3PurLjpJiLIc+sXO/kEqQftaBxLw+ZAxHmNu6zzUTlhYCC8d5SZPC21PLOUcfCf9XnXP6Q0f6GJqK2pQtVnOvOFLUc8sYY0e2vkjujPc1mNuXnG+Em/3VnhY0zet+2fUxvE6ZgGFUAyTt1cgUT2VJ8o4MxjOaJgHSUntzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tugVefUceHqfehT2QkGWrJYjRb0MkS9hq7MIOHQZxRc=;
 b=s91buhbrHx/QKmf607BS43lCOhwSqqhV03tGpu4WaYp/lq7187f2iBp45g1q4fCiTnPhlw45nfQNxmGaLi5howfBwAOHdjsUzFUOio0PlkWyNm40KnMeOsA2HKLQYHg5qFrypU6kSeb8WB8jIoOT/zCNniFU70EqEpY+3wsXKPB20zbz+LPaK1Y7vLONQ1CkkUL1wwQl/hwdX7Sctg4EV+uY7VSPLzCd6kbsoGPxAVCoES/9dT2rpJxCwx0iupzP/CmbrMfQ0kb+FghmSGz5AAxNNZJirVQbE+S223iR1uwRYfrOyIMkq40g/mOGsYWqdM0EkPV//y9c84/3Kuv/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tugVefUceHqfehT2QkGWrJYjRb0MkS9hq7MIOHQZxRc=;
 b=Qo3qti2t8hs9fIGuNegN8usdm4NI90PPUFDnH56YsGFJkC5NJR+xH2jmy4SUZPshslS13wWPVt9kMwcyVURt/N9voM0jDWjvAfZGykx/sjIoz6N1BfLmea7lClOmjPYfgPKlpZg3hXn2ZAjvlesl56EESki7ihrMonFL3jqN6QHpbW6gqQDoMJt5JLnGdkgJ0SV9jxpRQ3IYVh4bu19fBZSdEZSFQEZN8p9wlEBAVtwmzcCG7dCbWFrsOV0HCCN//TPP1uFhu+nwk9t2ayCG9E78Q8X2ITZlE6mQusZYdD+ELPETlmYrljO9UVHlRx9ZVvqwnwpNZGPcgK5okT8eRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9934.eurprd04.prod.outlook.com (2603:10a6:102:380::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Mon, 26 May
 2025 07:10:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:10:11 +0000
Date: Mon, 26 May 2025 16:19:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 07/13] board: venice: use SOM model for PMIC adjustment
 on SOM
Message-ID: <20250526081958.GI19264@nxa18884-linux>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
 <20250523172018.4164647-7-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172018.4164647-7-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cd1eed-b77f-4241-d6ae-08dd9c245aad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZPBjtdyxfiUhZj61aj2DtZxTKyyl5Q6G+LfH6q49fDeg0w7G/P0+3V8yVRL6?=
 =?us-ascii?Q?l8f/eH1YehewHdo6ts94EPG9RSQPlK0TxZNLtIQfsBk5qYzHc0TzFHEoSHbE?=
 =?us-ascii?Q?oCugL59NsDDhtvIXhqOk9pxyv72bR7cwcIOeM4Dg2tnzePD3sgrQWyuAdBh6?=
 =?us-ascii?Q?HBukWnh1Uk8xFz2D2eg+ueYK1nqKQ2w62wXRYdhxH/5vsRF2Gfwka4MafCbx?=
 =?us-ascii?Q?1V5TDcqcGElVhRMHUMTsXyIUcBS2OmszGFqkLWYmqqg9ecDpcB+7x8FfLPeX?=
 =?us-ascii?Q?zPZZm95yVbRxKzZNdU07lmz6NvH2/fzP9hgTUDLjJv2s3DVPR8KrpKclsE/e?=
 =?us-ascii?Q?qqj6NnDMI5OhcZGcmwAH1hUi9Jzm3yY3vHTeUAalPi2PcCMyzMo/Q62Q1C5y?=
 =?us-ascii?Q?c4tTyexeObcirjEdOyz3aXhj3pHARVyt9L0vUs7NcIzKZ7tLBfvG60EkYNT0?=
 =?us-ascii?Q?2jXTWL7dHjLwgRPRMK9js3Qi9y1ISIoyiJp0ZAUDB5wocBlK7oavaDyiIqXV?=
 =?us-ascii?Q?/KF2jTiksRgBaDUn+XSEhyZGEvH+17D3SpbAXy6UCGgO+ZcZEUN7/kVqyXBP?=
 =?us-ascii?Q?YQhTG/K64Ogz9XNzbbjAyS+ARnfrUwTgXX1LA4o8jOHmiYHnLOVZZZAMpBMK?=
 =?us-ascii?Q?qskloI2tpy7i20qXP3kEDzk/+FecSywqK+1MF9CCwYHehNjnr+4hawq4g+K1?=
 =?us-ascii?Q?Kzt9Mx/ERD48ovilEErh7XoKZ5Azn1EZsftwRVKNdjVlzD+XIZkouUryaFFq?=
 =?us-ascii?Q?Psa3kbZfyrxOOmJfd4H5ZWW3jVKGyshXeZbW35sP1L3hKZ3hJoQ9PYO9e1wW?=
 =?us-ascii?Q?c9DPjVCgQwU/tfRLtwKxdGx6oHt0lJXAuaonvitTT8XcY3+WX6fU0glooGM1?=
 =?us-ascii?Q?N97+AQc8pKMIvXi4nI4+/UAAAGMsjZQEZS+hJ48K+A3px9/RGASYKTm5pDQq?=
 =?us-ascii?Q?ff+XsiRyszvtMu/1EX2f8P2cZmzpkx4oZBtN3rp/XgBYyzVTIA7RIQsmxcEQ?=
 =?us-ascii?Q?o+1/LBnJA+562cxxByG1IVHH9RNrT60/qrvkJNfnIeeYc+Lvtf7AbC2X/Aae?=
 =?us-ascii?Q?1VKU6ugmBqqT4SxYUvrlrPjvLum0w4xbgd9yUyE4hDZjzzeu05lRLAnFLads?=
 =?us-ascii?Q?D18MP96yuFAXU3WwLxsZVChaAyisxOv0IB1CgQOy72ZP3j2LxFV2RCFlYFrX?=
 =?us-ascii?Q?ydhKUZeyxFxMVUzSlGkCyoxZ2UCl79rGDSmBo9eIGCasx/LezyVAkYxJtu/w?=
 =?us-ascii?Q?Hu5/jVcyxvCS/z+wTO8kWKXhfF05yHJDBPXsy1QSpI3+ozYmLdrTl2ImZ537?=
 =?us-ascii?Q?VoXddIeEGYHDjtHiFyyaUDxNVyeL87vhY7u7kGaYoUbvJUCGAAX6fEdu1h6j?=
 =?us-ascii?Q?ugzIaXhGUnjR4M1SM340UDUUGhnjpA57xCZAKF3ZNFgn0+sTRkqGAL7Tr9X1?=
 =?us-ascii?Q?I0/RqEd8hzGCh7cxFdL7vToXfFvh45PQ1UZLNgiiN5108+IhOFbONA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XKbf3/YvAPpFJm9xW6jXXL7uuw6PCPIhwFYytrdYV3hs/UyvonD73gBOle3V?=
 =?us-ascii?Q?wC/d7gV2ucOiP9IJ6DpNa1loHa+AKPbzqkQGSQrgZyc+bKQTYJVJOyVNfxQu?=
 =?us-ascii?Q?2FO37ol9ZvVdyYAxg+ConlOxWGTGvCh/Y1B5XImKYWvBGtq4yCPa3OHb06Za?=
 =?us-ascii?Q?87Oe8J2c/JNlw3c/ueBrOJI/FRghY9FdVEGx1eEVjmkPIXMv03MmxxtAvkSl?=
 =?us-ascii?Q?0uoYIWd+lJdrI9rGXIozz1eigrvmV0fLWkdPwmncnwBYdSL6ve3Ov9ltfiDH?=
 =?us-ascii?Q?V/u6Z8FNDqsOr/rQxWkvhk1buakIrwwzxtp3mqS4QpQrp9WQa9JVP5Apj9gd?=
 =?us-ascii?Q?5AbJLqJ46/tgM2QAFuAsqyvftVK42PexvbTy9ziaF5b9GTVlfw2w7iVgqzMg?=
 =?us-ascii?Q?dAWTIRZwBV/Q7wT+eXagoIATpYpl+X/toHyf+Nc1VQ8oXWLkWwnvpV3uuU4S?=
 =?us-ascii?Q?3YS4YUIltx/YJuA3eJwp8jPpPF8R+wO6EKPDgSzGxvhQiIAfFLFrvhvhgVG4?=
 =?us-ascii?Q?WY7zITZyCiZVMUyyDC91TQsQADdhQTnZ0e9bPxoE/YMiyb6IZBzy1OCJEwP/?=
 =?us-ascii?Q?qxg0LSY8uoO9K4CLDPdw6QmQ1S5tOryI/XuvcrgzikIgr57hL70kbleYdYn3?=
 =?us-ascii?Q?eZVBj18gbGBGF7+/LMYw8jMofekG+pTN+wbN8kFbR5KqW5CQDrtPV65lDGb9?=
 =?us-ascii?Q?zh6wuxAlPriUO3+eapt70FlzczFTYn4oXz5gZmLooKTtNZaTmZZBdRco4Ubt?=
 =?us-ascii?Q?NpwO5sZMu9YewVax9jEVpq05vVBqyyGE+VOwtpq5rRoRrCU9BTJkGSc9NZiR?=
 =?us-ascii?Q?oZqxJXtrJF0hSYmXT+fF917Fv8uffMdNOsTxnqeyj2ylmomRrOaifieEgd+n?=
 =?us-ascii?Q?IU4QS3wEVA62NZLn5A0zk+0tgOKwrMuLCo+35QbK1F7vl3CXxXdva7txOMsH?=
 =?us-ascii?Q?dI2sZxB5PEqkF33qUqW6WJ2QYw3et6t37rqXPuWnlpo3BZW35PA2s8QSS5S6?=
 =?us-ascii?Q?kIBPigKTsfMrXjoySPfBQXUw/P5ZkotdleaI6KAfdYmv/1AHkgWeufI3fvcv?=
 =?us-ascii?Q?wcNDpUi2cwfQQFvzrwHmFcU5qPNlmktfAZ0bFbM7piW6hCJ+QbLYrP9QuFvr?=
 =?us-ascii?Q?dtzPACbxd08xWY/A6KU+3bL+6hBYksC8KZvSVwOyGcx9uXUNkpzjdOpkb9WW?=
 =?us-ascii?Q?cIfDjku8e2kyaS3/S/a/o86vmxf1WCVa0+RbG+ulkJH8HZ+CcP6M46LOT/xq?=
 =?us-ascii?Q?HqIkPAuXVMNaWZPU3Y4HzmM4vRLsM5xe90QrZFBw681P3XpuXJ9HJCnjXqK0?=
 =?us-ascii?Q?+3hhUdSV/Ir9ouvSr5DQOqeNvpTWamDV3TX08Lkzr2o0xGnUBhisXel7ooXn?=
 =?us-ascii?Q?a0cxBmw18BE9xezdIi1CgmPNsu4X7e3kzTzLdeNXK6KTPX/QnTvrRilvzQ6C?=
 =?us-ascii?Q?SWpi1oNa/uwJB58n3Hqf4sn6y1veqO2aTsap8ITcT3awIpstj8I//oExn4vZ?=
 =?us-ascii?Q?M03qZlCR69N5C13/7KRMcxLZLHiFD22jkfz2F+2YOKXmqAXmN4I/BXf6A/pq?=
 =?us-ascii?Q?nx8yrJbB+t/7jGfg9hKh/MXctvF2hzBx+X9nfQjW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cd1eed-b77f-4241-d6ae-08dd9c245aad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:10:11.1717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIMvJp3bAgYjHPgcwCn2WNTLD14aRDtw758qg1W3+kux+qIEXdqBFu5BnDFvXAxTpUNJ0FaIpcmn8vrXcxFE4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9934
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

On Fri, May 23, 2025 at 10:20:12AM -0700, Tim Harvey wrote:
>Use the SOM model to adjust PMIC settings on SOM's.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
