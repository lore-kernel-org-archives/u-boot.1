Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4BF109E556
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 07:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21BF483CF5;
	Thu, 26 Mar 2026 08:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j4FsXfbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E4F683E76; Thu, 26 Mar 2026 08:36:03 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0087780517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 08:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSPYqmCiqgG4Wj+gf9UqQnnOkDoQdtpRT4Rr9zAnDav+fLTQSJBUjQhmAq2lRb5/gBbEo3kGspBVT3hu8H+r3kEyxnH1tAf/bhZmbWcbqokEySSqbYK8WjTyByZ/R4gon9qMS2SUAwYs3qXY+8cioFMD0EyPZ1U6SwJCjCKRs3WX9dRe7W7k7bFQD9KdIE+KxylD/nJFcR8pV0H7OiomkgiXuu/rd3T75KGCfJHrPeyS33GAocBnPS94TnLlljInOBWwxB58aPku5rM1fh3ZXuqvoPZy1xcBmoEAG2LEUi6u6a39feFgtMIRxw2SWXVO+kkJUNZMlx+cQyzYOMYn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTTEEpl8+IfeRSf8PwnZ6TgnoqlFE8HzX4Y3BpZ2EOU=;
 b=YQjF7e7flRAzKQV4C+hJi82zjYVR2LuT9mydGtIbFO3AgvfiivkcRIqSGHnHVUAfIfnCZSmnD0bYHGmivRMRg+yn73ZHbRkGJEUhUswSWxFoLXa/zM3kaTDY62t/T8AWoZ/V9j0wQRonCkqPB2ztRIP1ISGt96DSam8h+fx3R8foYXf4koY92bv2AeJL4kk5t5+R6oTuo9LQo0oUM9P2rh39D2NO3CUErrjWStAUE3HPLQswKk6KU9TZeFg7O7APod6qX0p0NF48ZQMPnySExFC1jfJCS3gRI4BFgMIvv8SaOz1k5/B45eNBlKfothzdKTqYrLJ+imf6J+fAj3PwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTTEEpl8+IfeRSf8PwnZ6TgnoqlFE8HzX4Y3BpZ2EOU=;
 b=j4FsXfbnTcYtv9VAmvH+pwZL2Pg4lDC1scJDDNYcL55V2z0gKDjlggQ3M52lit2/GFek8FPc4oRSf7zwEHJmiaI1Nc50m0dHm01odJ1Y/WP3DjdC/oRrbr0FqHqE4zQo4UvyF4JJdGFqDwH+sxZKUvOlx2jGaolYFifH1PSXbNbUq3uk1+jxdpdqIv5iKHmyff9G3V64zGag9yaZN2js3PXruChoHuLXLL3G0nL2Z98DkCgskgRsPcq8sE/5VOWpDbGdtlm2I8pbtMW1V1SY4eloakD2jLey7XffMTKJk2nFYqTH0t22/3P04DzHll5wiVrY+eOEz77Lpbm/2IiuuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB9950.eurprd04.prod.outlook.com (2603:10a6:150:11a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 07:35:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 07:35:36 +0000
Date: Thu, 26 Mar 2026 15:38:14 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mx6sllevk: Drop unnecessary BOARD_EARLY_INIT_F usage
Message-ID: <acTiZtyScWRM+ytj@shlinux89>
References: <20260325190039.3428728-1-trini@konsulko.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325190039.3428728-1-trini@konsulko.com>
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB9950:EE_
X-MS-Office365-Filtering-Correlation-Id: 040a6d49-52da-406e-a0eb-08de8b0a452f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: /uV5k5Npx2vb2r46Ljx7konSv2oIFdWDJKBUHmlrgsOLuJn7SkDkYRVF5hn9J6w1VFlWN2FyzGzbo+Ht7JiZRZEeHRMay8g6XXvS8l20dnootRoZL9BLrf3u1hYoQfZ+Gm8bL9JaD/evfY9JniI9t9xgajzlTDHOm0aJBVEd+lDa2HU6/KKBm42uCJ2+yKmN0VB/PQTprnLBsiDXqU5X8+9DTpQlTn1/IzbNGa2kqXaQ/IBSt/fJNz1fkuEE7QF3E4zh7KqkMC+IcfELmfSf5AMFkZTA3HExsHnRwvkr1PEJjtOABo75rLjRP50KM2AzzdA4Dk1L+wLd9/7K3diFMSPiPT0LMltaOw66wVu591vfIbEiJYPF5Art2TGNZL779h2ZLNhYibENNzoB4LXzo+TZZA9cREH7nldmpof/dqmtzjll+pMTkKW6kew+f7ByGFBls9T2mm1laKePsjF14ze6pBTdLRkrxfW5wW8pjPudug8oXkk67yIGAxx1GS3ll1FX092KMjTJ41qEGT6Tob7iI9kmbifHA+0Q7uMGpk8CDL3vgBTjI2Hh4R5BuJ10YytPNfl1rP5ApQP/kiNoihUtemd8AyWZQr2v48eIIR+Ie61+ljwimAJ1ePDIYFQuWFbqAidvKdWR3O59DORSoCjtiRoAgol38c1sawbRpnelH6HuZcHJZ2xnHphP//KmiLR3hV2Eedv663JzTgYRarRuD4ELi+wWyNHxvAP2cii2zwynvI85toHN7DZYkaRAYdmUAYeV8jjqIfWci5o/+nxf6aFM2z+0v9pT6mVPjkA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RymU8lIPlYOMXj0hqlXAmX0Hn0bYH4e9BSdqBRkTA45GcWlVdrnrDIOepteN?=
 =?us-ascii?Q?115MADFPfOfrXCFPIzqM4AEOA0mlepwrxUtUsYT8XrBIdd4OyiiC3KU97btK?=
 =?us-ascii?Q?idG+u3En+ggoERV0Z1Axpg2eBnHxaEPHq8zeUrDNuFy5jbLBJH2/KYFyVVJZ?=
 =?us-ascii?Q?qNJOnimrmanxT31bBxwteExTGEf7GWqOZy9xA1ur8hFgR0Mhr2THDKQy33/O?=
 =?us-ascii?Q?Wtd5PKp+q5rzgDAQooz1l4hEG7QIsMRB8QQ/3b7DRR0sh3U6CQOGe9ZzI7Nu?=
 =?us-ascii?Q?oAryOumyEPMZozHXiAIPayGAbHqnOazrQPcaTrnGCRZT5T4fLxYb65wVWKjY?=
 =?us-ascii?Q?WPEyOK0cugNKzzG33uyRr8ZzmHPOv7QcW1gJROHfelTNkR+T7M73QxHHbCOm?=
 =?us-ascii?Q?QCMpbHp34W3btZV4YC1h1gfxJAXgRguulpHC0OGfsnP7uyNT5GvxXGwOmeZb?=
 =?us-ascii?Q?KGi9neV/RLAUEL49OpBqlgjMtNy6nhIKPj3rMdP7mj17+r4YAeE4eaxQQvYm?=
 =?us-ascii?Q?MSdfeXKsFP33xdE00nkTtYBxaGDE+dCuL9cFMsQPiNrEhZncNubmRotf6hr3?=
 =?us-ascii?Q?OCJ8cexDLpVXk+cMAK7xwD+8ciUauLgThu5ekmZMUvrhiRoChJo6n7+e1Llt?=
 =?us-ascii?Q?bAq2TJ+ydA9MBCEbBMUQHcRN0Kj+inZo+bc1b9g4WtbC2UU8wd3+EwspcaQH?=
 =?us-ascii?Q?d3okG+ozwKzufjfCJuSpVXcek3W/kq0k1sEOGs7pVa9JUYiT5bVeGbFSUchO?=
 =?us-ascii?Q?1W9j2MePnYOGCqA7AHBbMl2jZXR5XET7zTVpq6vb3s+FfPZDWSIOEVenoEc1?=
 =?us-ascii?Q?9HHQooGO41mDeFREuUof6otIpiOLrmfAxKIxteGidcaHN7+SVMdF5Uyv5zij?=
 =?us-ascii?Q?eG2Os5e6H/6ApgOkGaGq+O4L9Ue8Gbo1ZPX9CY1WAXJOfp4sDbQ5z/gjHLaO?=
 =?us-ascii?Q?ijhpEZYqsf4GXaOmArmhUiDrHnCT3O8oBqR1HhLk0M+It/U3Zb07S9NOwBY1?=
 =?us-ascii?Q?97WZICmyGK7FldKUdQlIA7PvV+g5WO9ii+cU7AZqC7wT0jSIiy9A6Qp6i4Uw?=
 =?us-ascii?Q?Ocw02/V30QFedXg0zLB6gLIx0R/9t47soEsPjnyT/TLudXWHnb4uCQLZ6CBw?=
 =?us-ascii?Q?8Wd5uD6iYTEgb6ds5wLkDbqU/SPDjSTDPuo1JTY1ORUwpxoASGnq7KdBaG1K?=
 =?us-ascii?Q?lvyaLsnBQhkgi7MZiBan96f4AJNixoOGV2BTgaRQlL6O3Uvh7rWDZ4O2BNTw?=
 =?us-ascii?Q?QFzyap779mxVkEdlBIhSayeItLlorYng8DnPN0K694kKx+AargVIzt5Qjgkj?=
 =?us-ascii?Q?0lnGBd14Jlxcg90DegWj7MP38lC63JHq/ImlaWbv+Qg+b91uTYC1zcYoEiD6?=
 =?us-ascii?Q?fd4aV9/AqcVRZNy7zrOzpB4lLiYpXFfBM1WRGApPuWX162mtuw0U1GCtXwOx?=
 =?us-ascii?Q?W2exwDd2WdxfaMudfdgQS26rvHZchvVgh5NGG/z0bIk+N7p4NUiIWbmSsMnJ?=
 =?us-ascii?Q?IejT6YB4YzMXuVy8XWNNkuQ0whwALO90TZqx75X3+jHvxlyCctyUw27CSJTx?=
 =?us-ascii?Q?4zlk4+2KPueZDc3FMxpIX/R9qO6Kof9ep6KqQP8f1b7GsiHufkRZmqIColWR?=
 =?us-ascii?Q?oa+hW2Vp45Q6/dORXFeciMQiRO5RTlZAaeKaqmTHPyiUYyNGWnKPZhQcHT6F?=
 =?us-ascii?Q?+/lHYIb7GwQN6ZPbUPlyYeoqNkn+uvH/nlGvM61tlt9sJZuHkaqYZkcpq421?=
 =?us-ascii?Q?hCZonSyJ6g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040a6d49-52da-406e-a0eb-08de8b0a452f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:35:36.2294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SODe/k/AfJfA95jahdn5AVL3Qsgp52+RCz4nCLVF3bJ42Y2JT12GnyHKUaR/8bICBoWW3pB+X5vxmIcNRUkygg==
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

On Wed, Mar 25, 2026 at 01:00:39PM -0600, Tom Rini wrote:
>This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
>do-nothing board_early_init_f function. Change to not enabling the
>option and so not needing an empty function.
>
>Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
