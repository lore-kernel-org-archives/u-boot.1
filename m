Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FECC2BA1B
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 05:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66802807D9;
	Wed, 12 Mar 2025 06:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H+xfpnY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E4B581197; Wed, 12 Mar 2025 06:17:23 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF0180756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 06:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7JHIV6AZrBOprfMtCMcCSIUBL3O0Iltb5eox316A0F4CsLuhUgmDxdS/RtMxzQFtCtXyBDRygc7TbPExyvVnNLLs/mXoJsCp81cgp0Z3qj6uwP1SfyzN17hddBcgRSv86dcVOjo8HRM1ox81dbn0rOcMaxMpaJiZUNry5S8ZyAYP3aDEc+IHxMutsBZyvUtll6mUrRUFY7hItWbsCZ3yAyOpLcg5uF6YmRkn0ANWIBdiUiQ+JCyAXtgRtDR11cUaZ8tIguD0+oohRCWi0apl2uN3sqBI250FU5ig9WFWJR1G+Wid/pY5Ycm+w8czCGDS+JhN/ICfvicp0VXGAKk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDJ0GhnHuaqeyAkVHmMl076IGRNFrDX/FIzWHA22lOk=;
 b=KvlcMYBXod0mcHCPTHWhL0r1xJmYNpi9n+fzTwKw9qf3nUiAYXVJ9h+jHKVT6j/4DbBD0RxhWOh1J8vL+cQI3VYIEuWb7mYaCzJFNVv+kVW1cvdzo+1i8Tkz2O9ugAR3cQLEhpMLEtmwJrNIgGg9LlWTiAjnyTctW36zDsDqKNj79QKlKJB7ZnWH/MPRUhn0QR+AID3CnsKKX3ZQoxUY7r3TOGx1dxy2wVuiikkU4kXOeG8V1NY6GwP7LkaSe0xShX2MLY3LpGfigkkdHweNOA4spFv1q90gknyAwh02MyPxda2+7/0y/wkW9XrlTNLrwWaUeOkQ+Ia+u/+DkZCrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDJ0GhnHuaqeyAkVHmMl076IGRNFrDX/FIzWHA22lOk=;
 b=H+xfpnY+yuUZS6X70qDOk/QCPpARo6ifo+1sfZbsHoQXSBimkgr5UkICTUzszDMnvTwydnyCI+bodOYtwL+Wd3ZXxcue55XwfxYinv2xCwyea34VlOSNrJAxA01ov7S+uwO148FdGBXz0kUQ0Ur87AOYFAoLjlUptijpfgQoq/z3LMMTcMFtiueO6skTjOql24fr9r56FoMf88dk5JUGdpH/ZqTXvzjYKCl0nRbQGE9Nkpx4TgJVXDXGf/Ei9NAwUYXLt6+AP7zWN2Nlt1Khs/CP4UbXcIumvEmmFd/UUi1jrEpDLUJhth6ceSVQdzZ+AiSvMxIAo5OyVfNOSrLivw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9404.eurprd04.prod.outlook.com (2603:10a6:10:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:17:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:17:19 +0000
Date: Wed, 12 Mar 2025 14:24:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH V2 05/10] serial: mxc: Support bulk enabling clocks
Message-ID: <20250312062458.GD11991@nxa18884-linux>
References: <20250312003041.110023-1-aford173@gmail.com>
 <20250312003041.110023-6-aford173@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312003041.110023-6-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4384a4-7fea-4a28-d39a-08dd612528fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Muo6UHX14KcBWyTQFYZBlpFAm9o/uDc7wV+1ptIkDJlMOXfqxSEuNy1kRl4h?=
 =?us-ascii?Q?lwJMhK8Y1eRjNJ67brwUab/3ruzpOir06USLp9O9sei/eVg7XWCQTMoSIYrf?=
 =?us-ascii?Q?1m4nTBFPsOQrN8vg9H4M8b9NnaHbcemyJCkB3oHOaqLRAzm4Um7Ps8EoEF4Q?=
 =?us-ascii?Q?sCqA7YU4f8sGZmw9GlTpw+Ii6+ZpDAC8AwvlGe9zo6Gg92URLglym8KPaQtc?=
 =?us-ascii?Q?fnKEbmABWg+6Glvd76C0ZLYrzPQ2gWW5pIQrujVegqQv7ShRb7hfchKM2iIu?=
 =?us-ascii?Q?2QYJqWQo/HZkTHe217Iwtzj+LSu4cIwbTyQEFkEYyyWHsa9pca9ZdrJOTCeb?=
 =?us-ascii?Q?dnlTFSrLEeQprn283++9IUYE6i/cDurF38pOoanfpDVrEn2XA3gUsD7joeU+?=
 =?us-ascii?Q?GP588OsESOZ1wIA1pkIbNvrh0yUQND79jeZZBhRr++WTvaLLeKSOeOrxcyMj?=
 =?us-ascii?Q?+WGk9LMnwrBFRgQIPLswmh7HeKtspOrefF/AVtZhm2rEcWKfiLpLYXU0Xcpg?=
 =?us-ascii?Q?xovYPG+bg+GBDJBlDlF8aJST0whRO44be3N5tb34IZIitHIN8SIhFExj8SXA?=
 =?us-ascii?Q?/UNQhRtPwinumtM8qzkakOON+u2iT3yau4k3gRO8ta7WtMl3mqzIPBPYa6fP?=
 =?us-ascii?Q?RGmPM6ZFIV/zg83GN0kpetXF/ijWsncEBnWgPqu/JR/Qav4wFW5+f+qJEjZC?=
 =?us-ascii?Q?CPirAF/CzjyUUyZftkYXHNoTMNnOBb6vCVxyPxXroE4zpUGU5/hurh9TPvzM?=
 =?us-ascii?Q?oljk/k0Hv2urYuBvEnjPnVOjY6Je5jzW1U06t5WJIFlySD0E50tKipOWS04c?=
 =?us-ascii?Q?eW4KUhJZ8r5IhEKk04rmD96TCZcpAVEpO4b79zWCnJzSjm/IpJPXT5JwNNko?=
 =?us-ascii?Q?nMgzLI7ugsdgTu/rGkKn5asNjHxatx7fP5h5tu2+GYh5qi5YK2xVIDjvBnW0?=
 =?us-ascii?Q?gdqG9QMqPEUyHy/A6tMAMwzZiMCxmBhHIPkF/UAa3RvGrT7UkIF6aLh7hMr1?=
 =?us-ascii?Q?8vhf/smOLwuw4Cn4C6H4uj8zkn12+0cvVaZwyQRAxhPEeo30IxNbNEao8C/x?=
 =?us-ascii?Q?MAIQpWsdLIZWf8pWowHLMz8f3xkvIJ2AP4GwA0if83cgvLEr9Cv34lrgX3N/?=
 =?us-ascii?Q?ws7w7vpbhlWsBF8c+0AcNILIi7ZVKahZB+cEL4+23/iNYZrAVCQ0+XZEryZJ?=
 =?us-ascii?Q?OCCPTV3QN2f9Sa2zkVt8dqqW2A7VzntjTDb9HVHUwOAaXsDQzjtf/ZuAP3Wl?=
 =?us-ascii?Q?wQH81WLyj7nEO/EUFW69Aj/1bl4ch1aYxO3inXd3Et3DikCo+xFKd0vnR4KI?=
 =?us-ascii?Q?BHFc2UrT3doUPUgckmKg4bJUHxttR4EQR/K1yQ45mxIPhHMjNe/buxwuEwML?=
 =?us-ascii?Q?Srz1TEsMoZqlWVjd7X0WFqVsu+bAjIqamOifIj//cW0cmwD13wl+i4wwKex4?=
 =?us-ascii?Q?ob97TjL26CKJ+yksp297Ykd0ln6NmCZn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yip7jxVEj0SiGI/204QnaBvSYhw8x0fDIg1v+bIClfi9OPRAB4xfEs2tBQTL?=
 =?us-ascii?Q?LkMithGAbuZIvUwNYrgZmz/MSLNjBVpwmLuwzzHGQyaWmmyRaV+fPBRzhl5g?=
 =?us-ascii?Q?gfTRMZLvXVqcG/vX2+gdXmLE0/RIpu9Wh5i8WIKgyeo2e8vB81iaCkPFcEiq?=
 =?us-ascii?Q?Wa3f2LaBWF7Qc5qE4JyEAgHGNQvQMjdY48b00Yvn4Q1gwHY9g1boLaricSUC?=
 =?us-ascii?Q?x3aqXj6O4Ks5Us561nSRufMcDvkx3+6KPPM2fo8O7ag63raHTRKRx75ATCbg?=
 =?us-ascii?Q?BpKNPP25o0dC4NubTZNm1d4QBD3C4NTNU/8u0qqEy9kAjCvVudD56+mjyq8w?=
 =?us-ascii?Q?vPyOHWoXThyKzKQy+AjzaYwBgQRfCfzCi2QW1sqitTF0pzTwTtfQWr6mOw6F?=
 =?us-ascii?Q?wQzM4lRvMg18Xz0+Ab7UJ4+p2NsRZ7vOy7WJovLmSLdpdzk9soJdEuNHEllC?=
 =?us-ascii?Q?6cv/0Vgq17lSGDymn4nq4gVhS7wsvEDwqpvkxonFmTZWt9fXcQ//S3nGFGiM?=
 =?us-ascii?Q?MkZ37kVPtFTaUV+kiCT0Xe4FStk/OHr4uq2EF+CFPqWfkc2vBE4JumspVise?=
 =?us-ascii?Q?+9livTKhGchBhYumiY+VLpbFYpi7/en//W9Ff4nBU1gu6mmoTHFH3demgjOl?=
 =?us-ascii?Q?Ga5jUHTZ6keBjdljAjONeLwd18EVudaycARzio6R/PqQn4ls7YpmODe7CUnl?=
 =?us-ascii?Q?uWL3+EEz5BVbjKuMqI+fQsxK38lJVgNQ2+YRfbHzT1WB2DSMH2nc1T2xDi+C?=
 =?us-ascii?Q?9KtkaB+58XO/dr4mZxJLC4Avce0r4vXFow0Q2vZwNDirPFpsd4NIvIfA9MdR?=
 =?us-ascii?Q?cIkjsKcPu3rlLJm5PjWgFKGyjuyufvULBGtoh+BzTrMSyt911Cq9h6lhZaJW?=
 =?us-ascii?Q?Iqi0nNFBa7IDYOyxHbRzoSR9lGC5CadIJG31RI2e5YFOTWOBCVRrkxD03BKd?=
 =?us-ascii?Q?yFE2e588EQ09+C+8yHvFuX1hAMfuX8qWXCJIGSh1sjFC9keifys+el2vj3pI?=
 =?us-ascii?Q?TIixdoo8o4xxkQwT53/LxDMszy848uOaIlWHZODXVaXflKgx8gHL8Rt2tiih?=
 =?us-ascii?Q?QcaYas6O7ThVny1CPG7ecqetaMi2CgnYaUh+lO2BBHOgZ4kU6l/R5xEu/d1B?=
 =?us-ascii?Q?Y4CdEcoGit3OXd5C6Jm2mjO7LPZ60BfUOlb6yoEWyr7boti603d3VzM3S+HC?=
 =?us-ascii?Q?FgQjE1FLoV3zDhC+L/gH9MgPlLpJsSVpaKwMi8IaV6qozKc2IZD+CCvZhVzb?=
 =?us-ascii?Q?oH3x/YZoTtC+u/Rg2jXfXnMdcss755F/rxM2ValSoJL5cGr3KItF+SBN3kP9?=
 =?us-ascii?Q?8yYXkX/4Zn53LMuGVfZ8W4h+UoVmJADzZ+aOdPbgyfyK/4WU6UhOODuHMbyY?=
 =?us-ascii?Q?Qc3sCV8n9ZV29LGP8oACOSs8yFhc/0+Wlg7eQsOxernBuRIo5thOuHvE/Fpl?=
 =?us-ascii?Q?pWKPjRYgUn3abraHrF21/lgzmYKOUkXy6SgapuLnyKBE+ZDhqS04p01CYnGn?=
 =?us-ascii?Q?chhA0RzvIEihRMn2VtAqUeTPS4duPSrhcxguCd5Ivd5xUfyBR87fXb143ZPO?=
 =?us-ascii?Q?jXPNWL0j6IFQOZNLkRiD9eZ7rHVPIR6Nsjt8TgPB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4384a4-7fea-4a28-d39a-08dd612528fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:17:19.2916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWKbaSdWgi4wN4GB0Z1SufOvQc6CwFx3y16WS1MyiVa06QE6g3NAU/0ywyvI/eCrlqpuV/MNFA1Lg63gDTsLqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9404
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

On Tue, Mar 11, 2025 at 07:30:25PM -0500, Adam Ford wrote:
>Depending on the platform, there may be multiple clock sources
>required to enable a UART.  Use the bulk functions to get and
>enable the clocks when the UART probes.  This can facilitate
>the removal of functions to manually enable the clock.
>
>This is made dependent on CLK_CCF which is used on imx6q,
>imx8m[mnqp], several imxrt, imx9.  If/when the UART clock
>registration is done for older boards, this limitation
>could be updated.
>
>Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
