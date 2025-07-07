Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A71C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 07:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A439782FE1;
	Mon,  7 Jul 2025 09:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oo07EaSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6522A83015; Mon,  7 Jul 2025 09:37:11 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BAB082FC7
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 09:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DG/2oiy0nMdwCMX5xRHPuoaXZHIStXgDaTbTt7wQu+cvbQtZeh30V6OMZtBf0MkaM6dU7CPMDemDEP6v7zwEMQV1ggb1zKC9TykWp/WLYThDMEpKEykaCthPRpxvdeahTwLOOh5kydXqWtjAemBLLvEMTRF6bpHURbYC7LXX93DFtBQxqxitDYi2zd2NkUiepvLtAZQdwd7LR0tiOnT87UjQi02BgOZzA5tPZKdXmCof6sQacpoiM3cmGly/f8NWa2Xb2UFAX7fFRD17dImHOFQsytwuFrnRWq8iZF1nlnz4Ect/kqaXLtaybbG6jZiZQSXUULtyesKBHxlGbD/ZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2JvmeaEVjfwfF0Ebs5XWyjwpDvh8Koow3+iNfOIpJY=;
 b=KyCMMxt2qaraxF49t7nKi03lA/8SVekwUqGipDSN3a+/uBB3WAj0ptgEke9fRuvnVEKF8w/UHEqVhD+TJc4chJz6A6G0NYZz1NvFRm5EBgakTxYRTd8dw6sztmVWagNcAItItxHKffNXjKINyb5b+79OPAzwwi1QUZlJJ0IT/4upwL42RG/IcuBJRQ+NXp4ASw/ng5ZalZt/lq3DJ29gIpbJpoozNXu7yTneE+LfZJQoUPi7Pkik7GQ7FGT2ETkkb5W+nXDrzx5mpdoS6ILAIfsL99Z0tnCA5O57C8cnGCiI7JjgVfYDtaZEYZn2LAp4N/BrfML9Hy+Nhn5aXqAl1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2JvmeaEVjfwfF0Ebs5XWyjwpDvh8Koow3+iNfOIpJY=;
 b=oo07EaSF7amtdwOQygANPXmZQDv5uFnnmTReG6sfV5x+91A0OgKFUewq4WuaxhJ1HAnC1a/xX6DOePl8qJSxQSqONoWd1/3wor5yNFxWm8ZJvZgciQq/h37Y/eowv0iQ7QfGziO9GeyeSwx+XV44VKPf571ZzlGDDN3bASVy0hDam4erjbvuiZy/+oU9+dKWbwdq0xQ+IgvwbgB8xobf0FllWSbn1AZiYY7zVlNw5oocTLWlpt8E5JRh7AobPV8OXe++zgpN4WoZgNzb3yA84sQ5bWxUIA2W7mppwfPGaXEP+0jXBMtRFtFk1eXAdzM2R4MX7KTDFI1RjBHDdqjyXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10319.eurprd04.prod.outlook.com (2603:10a6:800:231::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 07:36:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 07:36:58 +0000
Date: Mon, 7 Jul 2025 16:47:11 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: Take cleanup path to free memory on error exit
Message-ID: <20250707084711.GD11488@nxa18884-linux>
References: <20250703-mmc_driver_fix-v1-1-4fc57fded698@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-mmc_driver_fix-v1-1-4fc57fded698@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10319:EE_
X-MS-Office365-Filtering-Correlation-Id: cda4aa86-869a-4dc1-34ad-08ddbd290db5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tFTX758PJ7iV+1c6fMZaSVa4Lnf4t0s0XCK4GJkD2Wjx0miDU3mpO2c6W7A0?=
 =?us-ascii?Q?CcemsKEa7lwitWp2gGvyGCdzyfRvb95XdQcjzv5urpifw9VX2WYFYg+BnMup?=
 =?us-ascii?Q?MOg8E2Vfz34KnHL4X46KqMvtV8rLXU/v0kHakV5wfTeLTyvzAptlcXYaHm1n?=
 =?us-ascii?Q?4Hk5KOvNWXaDC1VB1gDGtPcLada44hMM6AEGM5YZueYGrBFrdhKXwLrZTA/8?=
 =?us-ascii?Q?uvHk7VvsInEpVlcRcombCuy1zSh26GB5nTCYwUN27axeB7wfGuf9Z9OOS+Zk?=
 =?us-ascii?Q?1SAZT1v/u2zwOF2XbVJnOlRBV+KHEwG8QTDdT/sggsxLLsM5oc9W99kskE+X?=
 =?us-ascii?Q?zMgxtOq8gFaLdw7SMuzsvS4aHYYYFIoJU5FGe0xkx9lQfqk1TKvgjfd7LOH+?=
 =?us-ascii?Q?j6m1w03UTYzEVCDfStuBot1UBgxOmRjmeXE41FxluzjM+715Y51/MOQwF6by?=
 =?us-ascii?Q?ADz79zP4JWHsihHk2kecZQ2aEdcXvBm4O6/MdO0VqDsHdnTwwfZu1Xt9WWIz?=
 =?us-ascii?Q?S3Li/lj9bpk4RW7wQBY8Tc3Qbjql+P2OhFsPhDcVuLyNNBL2oklwQPnum4Pg?=
 =?us-ascii?Q?iST4Ue6KR0JHq5MTR2JAsoD2K6yO+OS6va3I5FLj1i2JQ2OGHCt/z3/baqGH?=
 =?us-ascii?Q?/ey4pyso8YjITIIt7L0yx+zwOguZ3LTnlGJTpDoUnecYdpTtxsZbytki8cFJ?=
 =?us-ascii?Q?rWnsvfdOqKx6c/pCVlN7eTNSArfOoHU8VcihSF8vsSwtfGw+bEBT5GFu8Oqx?=
 =?us-ascii?Q?mm/uviTsIhQhDUgiDm1ou7gVRsgcVtktYTKG7GjSlPEzTeAfKoYY1K/gW5Ik?=
 =?us-ascii?Q?/j0gEpVHv7/fZ+fwDywUeFicg3NYnwSETTbfU+nZOOe4kSw85nX453DF9DoH?=
 =?us-ascii?Q?w0tBmwQCp1+QfgQEs7pc9w+FpjNuxThW2/iWzyccUuifkIg4WddFHazFCmM+?=
 =?us-ascii?Q?bB8+Uw/3J1STls+8BKuamLkPc9mQRMwPyvdZQV6DKHPfX7YnETW2OHVkt4RO?=
 =?us-ascii?Q?vpHwUG62P3JvtfAFi//28nriMcV+MTcfiOAvDQGAUSlucOi2QHkMF3O75x8r?=
 =?us-ascii?Q?FUgNONKmGatEQHn5AXxlXPPgpo4BqL/AoGEoJqnqmNIPqCpjcsRIWzrT0s6/?=
 =?us-ascii?Q?vRpFS2Pz3sWcPMeYfHxKYpJdq1M0TV+aFAkKdCXdwPBRwWlicRhOK34MMF1h?=
 =?us-ascii?Q?Yc3tgikcR9nzIlzLgFLf5zDwuhgfv9oSk2bnBE77tTqkcYuoeG8tjFRwsTsL?=
 =?us-ascii?Q?i8aDn+bLKSmjHj5Zw756JQ/8BSc7S7e3vYYy99P1WpJYlKIdQJc+Fi+mgRsN?=
 =?us-ascii?Q?pVt982LXPLwK5OeP4haDQ0R6K79vShtgarHkQjV5IFsyzCNhqVDbu5H9FzEu?=
 =?us-ascii?Q?GKxOVF7ki+oS75TgKa1eFBSPVI2rcJf/PNYkutNX1jQncFWj+FQgogrVtfL1?=
 =?us-ascii?Q?eGF3tZOKgc/FuyoNMupPTXj015b2hQ+o63LQrMdCBVJWLOhyreG7vg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rGwcJVBGsfZypJFyjJy+PeUdCnDtE2XNCCWuwyeXE0exlU/jNm1pkK14yDWQ?=
 =?us-ascii?Q?Gw3LJRZnITpRpHGZ29NhuENv1tb+h+u/fUXhSp7BX/j2i4TjjgBGaYBd+ZVF?=
 =?us-ascii?Q?38dMCnUhGNJPqBdjwjX5eInqNAt6svYBpaVhQyYBofoWRoAPEk+JX11iaiWT?=
 =?us-ascii?Q?PaO1VtYP69aAx944+0RKiKzO9ml+fsj+LiakcJ7eMHi6xa4d+eo1UEdpvfau?=
 =?us-ascii?Q?nPuiYtahVrFJqp0IhHCwPrzp4XgjcIvt0U9jyfT/iDr8RW3VsWoKb6PwDtpJ?=
 =?us-ascii?Q?t3foi/aAcsZ245mgWvtrYUH68MhRtg1fCllks1qfO0dTsIHQ0j1IGTdqmQ0U?=
 =?us-ascii?Q?vyQpDFrjsBZlVlT9mI6FwZ+IMAXPooaCu5lpu6kw9EBz8qZO5nGdL5ITksre?=
 =?us-ascii?Q?MgEElGSa+rU5xpoR68j1EUfgN6M+DTkR/sJ2dRDQckj0tMpq4Q/l7+EN2bk0?=
 =?us-ascii?Q?jFHzzYlBYOVMFaD9VelCbIRyzD6L+lJfdKJ5ifbph32uKjdzPlkU4O1wnhG9?=
 =?us-ascii?Q?+D5geIJ8hrSyw+GY11DARPRgEvlv8BncrArHLbR0Ev2hOMGt6+PINMy7+1Da?=
 =?us-ascii?Q?97ho8MbyCsl25BDWssG6rftR2E0tApXkQTfe8CEtr7SBejp+PyTBacr1iGpl?=
 =?us-ascii?Q?xKDHrusHZ2Oqv5Y3AbOnlkuT3r5mYflPXqcz+cw/3CFoafTMVcwGW0jzNNJf?=
 =?us-ascii?Q?KTmCrEteqygfrg/1wB778cXBYhNes+AMHBCimjKxh6+/kmz/XmoJz+3sDuo7?=
 =?us-ascii?Q?K0R8HQ9s6z9FqxXilfho5jvISe/duxEc2tDg8iynCOlATaCRmx0mmodKqcNN?=
 =?us-ascii?Q?/AGHthr5xhadEO9I2iY6TKa0bEYbadEdklAYhmA1WNT5P9pQNqZSjpZrS/MB?=
 =?us-ascii?Q?DYUmROMYP6O2aTeO2mt9ciTjSplFS2SJz9v4UlQHQZFeOH9+6I3beAj8aFnZ?=
 =?us-ascii?Q?NaPoCU7VD0T2bZQdXrvzjo6Q3g9ckvWlMnlgQXKB0SpWdPRj64txU3Qzvsxm?=
 =?us-ascii?Q?uTOocb34nAwa5vXFgAgqzRzgd7kQO7p4AaaSc+45J2/i1s1GHrwUCEhoELuu?=
 =?us-ascii?Q?qjC8BgQrq77Np0BG93Tb7LxzDysHFC59jnWzyMksYKEelskSLnITxzrJe+iU?=
 =?us-ascii?Q?L0WhDhW2E8r+BUuGHUFhhDGb4ZVR6dzgI9lWzfI3ZzP573lgvOJ3knmsYXwt?=
 =?us-ascii?Q?kOV2dTogqHHH7C5H+CfG5AZi+Cg7zHmarrcWU/2PoW8rl8m4Ra96KFIYb0cC?=
 =?us-ascii?Q?C40GlXNDPysURwX6W/7XSc2xRI/XSQLtqgBdDfGS1b0luns5NY38srJLn5zi?=
 =?us-ascii?Q?R3X6GA2IbRolj6qvQ1hcKPTm0rFP1sjQ+nmcmLaFyP4FWu5H8w0HkbQZuaav?=
 =?us-ascii?Q?AuDbSynXb6JkJ+2xcziIzspEeOQocouz2wGR5W5FbanYBFcXzbH3ECC+oM2Q?=
 =?us-ascii?Q?XmgZMzKIe8b2bw7nPSYY4zdXOLcgt5oh3pJU/fb9+8D0e8oJl3/8RhhCJ0t2?=
 =?us-ascii?Q?GoWGeRM41wEs1oj8B/ibNIwiaqMOYo/kTFq3xiTDf7x/Nli8eoSQgTpLosCj?=
 =?us-ascii?Q?pCipkQnvC5S+GJk4TGCpsC9AqPA/xR7Q0fOmwjkf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda4aa86-869a-4dc1-34ad-08ddbd290db5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 07:36:58.5662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JZMyrE8R3H9Se9uKzykED3fZgOO6Scw0QfB3Y2YAYOZ0yXKyLpxMAVHJtiNm+E9iTQstUjFYBxnNpi8vsXYZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10319
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

On Thu, Jul 03, 2025 at 03:03:30PM +0100, Andrew Goodbody wrote:
>Instead of returning -EINVAL directly which will not call the cleanup
>path to free memory, fix the code to set the error and then goto the
>cleanup code.
>
>This issue found by Smatch.
>
>Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
