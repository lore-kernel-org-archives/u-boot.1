Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FEFE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 08:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8526A8036B;
	Fri, 10 Jan 2025 09:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QVYmcnyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F9080619; Fri, 10 Jan 2025 09:48:13 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9DBF801F5
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 09:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjwVVvBi9eCivDPXtsRv914NwvH9cAjsD4lpnNA7NghPNRe+LpDeJBxPE93imZZ4G566ODJAkP1b65bXnawyAPypMw4/XG4LMzY3YALQGcFlb0/0KkwWvwtmGKr1/TKMt1ehrg2ZdYTT6/mdtSNWQwVM3vE7wgCMAj5ChymH9tPRAq2hxQXcpe0aqy2sY5zEiqyA+b0i8H2sysMJrplhhYOGp5a08rOH3suKC1qwYMuI4mq+npHrhDuA8vBfj35CYk3VRcm1pVDVrLvBC2FnWkpIAvBbv6nE6AlIUd/fnYiTAoGh6mBRbAVTMTuNpByuvynB+4u1MvA9hRxrXUVrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=812EhLvVp3b132qckwJS71rcOxCP/fDLRJ6HS/kjUoo=;
 b=SmJr3W1/Rz44UsY7Z0RmEpHaCKdbfMU41EojVf45ZV+woP+ixDg5DxPN0C/Hcz9QMcsqxWYsgJ4geiJnBShUicNcSXYIdt/EVhVfGQY48jOCa1KHWHNw0SwE4AzO7dQ50dIDxIoJjFte4U5G8XIV1wqExi8OnQKE+Wf7yHqiSsjtkLZtXPZKWqK2MfhSpL7B4tGMujQjNPgiZ3sCJt8Cvsqnypy39ta9gpPlgV3e7En9hQJA1p3vR3XA6pjTNJCp3LJPf1piqIacKLnCdgpvywZ8TyFq47q5Zl5AWyWwUYHeeOq/WEws0DTk9p6M1GlW/sr6FMw+Vpq+8EEk2jLbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=812EhLvVp3b132qckwJS71rcOxCP/fDLRJ6HS/kjUoo=;
 b=QVYmcnyNo3DoI0rAuTSCSr0HvnV5rEZtUGO6gNSbfb8JtgnOUzkHn7CFcuPggrHX90SDkBGgs12cYPgpum2nc//mkqhwC1txloR46H6QuSUP5dWaH5GSqHL6a86ximmt8/NvpsJihR1p/wuhiuOpTa6lgL0vh+6tDb+OOVtIMh7cSuR9oZYFbaIaBh/9P5NIIXCi0vuOa/W0FPIbcGG1zZ4G8m4GhINY8ZZ7mJNHBmOPt1LHYFFSfgFq/DrHfLv9ECqxcAtNKj/zkEMb7OGUeA5Tybo81WFubucofvQSKz/tzeDoSAFLixWRBv/D/u2+B6BlRnKD5XA06B3+tb8UYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7993.eurprd04.prod.outlook.com (2603:10a6:10:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 08:48:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 08:48:08 +0000
Date: Fri, 10 Jan 2025 17:54:02 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtFWFRd?=
 =?utf-8?Q?_Re=3A_=5BPATC?= =?utf-8?Q?H?= v3 03/17] pinctrl: nxp: add SCMI
 pin control protocol driver
Message-ID: <20250110095402.GB23168@localhost.localdomain>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-3-6744df5dc020@oss.nxp.com>
 <61075a72-7a89-4bcf-8d96-f9fc24dfd5a5@denx.de>
 <PAXPR04MB96440F6976C336998424F176E2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <016aa4e5-c33d-4f77-9a12-c218c4123403@denx.de>
 <PAXPR04MB964470D51ACF7CCD08EE87F0E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <7c7ab649-2bda-4693-8e41-c41c8e820c06@denx.de>
 <PAXPR04MB8459F3B1A250609CE5788F3D88112@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bf669d4c-c0d8-4578-837d-c2f4531273aa@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf669d4c-c0d8-4578-837d-c2f4531273aa@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9d4457-f6bf-4297-bdb7-08dd315381e7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8L44w0+6KoB3ff5YKdV9VKBw7ONXTc899GVIPliEJDcQXyvix5VXRftFG1bW?=
 =?us-ascii?Q?H/Eck3zYzWycB2/GvCQ+t4Q2cxx1holfl9q2jPTqDN1wUK4UTefn209xi3eH?=
 =?us-ascii?Q?50uQZvSyorhnS+njwcSdC0ZLk5dKlZhyUIrgf5Vkmc4XLjwWlX18LdaIB0Rd?=
 =?us-ascii?Q?fKS6pLXRwYzTweohAjPKOQ8ZC907WNzMjB+9kRINX+Ey7QnmzCYSR4F+wzss?=
 =?us-ascii?Q?1fsSEV8mTI35Za7eQCIkaofFx8Fh4EDZGjR0oZsDOkJNgdILhqYK0dIJ30PL?=
 =?us-ascii?Q?55LKta3BYMs7h58ebN3KwBQmhubm6g4JqNYDfzvUPdE3sIqmofySA+7BXV+y?=
 =?us-ascii?Q?JOHjm9KHHxi0faFeSxk+qguSAi6d6LDzQ47bbMD0C2zAJFG0qMb0IXUETt6D?=
 =?us-ascii?Q?3cZWUucKzpkO6duoFPyxLSVarfon8TwKZr+PdIbv7Q44xB63Fg1JqcTqejZj?=
 =?us-ascii?Q?jxEhqF9DBWbJRC+/aAbg4bxxDmwoiE5DEsQboOM8nt7ni7pzwdAA584tanI9?=
 =?us-ascii?Q?ZruLG0wOYe0yFq230jwLsUmQNyiTLIy3GdPPFjivaMP91wpxnvo2m0x+4t1k?=
 =?us-ascii?Q?Ifn7XY1sDNf+tpBLRvXsYixN3EVotPNaLEolVkHXr6/uiaxXk4EZKRWG2zxZ?=
 =?us-ascii?Q?r/dTu/fMbgDuPTU2ASmkg3wKVGu6ZALRcKDe9kWoYeP14aPmDEGwyFOPYXcG?=
 =?us-ascii?Q?93BFyatnaM9Qy0z9dCMlEM7MUX8U4ad4GOU9KsqZzoLQDUQXf45owTOlR7d+?=
 =?us-ascii?Q?aYMZHslsEzaTRhLMEBL3CjpPDnIIedvxMd54caqLKNXCzYDCnRBiXDDCBzjj?=
 =?us-ascii?Q?wdR3PE8g73VvewTg51nY9IGtfHxEC9/dozcQuIXeEQGcvKOlN3V+/b820I0s?=
 =?us-ascii?Q?s40MgGdluAcqmq84S279sA8kv7Fb/Q/C6O+x8rBjf3ss2ZDedNEhcawouQYe?=
 =?us-ascii?Q?uV7gOYlNqqcgXE+HV3+kbE1sIiOwsnOiGHDKXZWOL63Ok1TrFhsTcmAPPbhv?=
 =?us-ascii?Q?Gs66NxHKHhSnY1BF7A37L7URSdtGlD/vBWLD+7DAVnqlWYic3F5GgDTUN3hU?=
 =?us-ascii?Q?dXJx5k8kGBy3YKzKR4AlSNkb9PR3g9w7Q+mjBUWHJJ4qVr0v2n9Hy6A+VbWO?=
 =?us-ascii?Q?iDt3tpzGsCT6poBCDGPIpJusBWEl5crxpknfbtUTwf+4TUh+7IyidXmq0ESj?=
 =?us-ascii?Q?Fy4iXKINRJuHzPiLsP0v4nGUgdVf9/gNS39xbZ5U/B68cZSYn4ntBuWwQ9Hn?=
 =?us-ascii?Q?nbDECytIYdh0NS0POM+dUor4QjXczPcOgR/jOZQbWAjRcTSWDWioLqQ/otQi?=
 =?us-ascii?Q?8Ul+yqI6uw2RjOsRxjiUsLdFi1MQbvgzf1busEUhs3obRDq3y58pebf4SHQj?=
 =?us-ascii?Q?mDA4yT0aAPgGlH9Z5u2TCOnT02PVGHZU8o0X1HuyiB9P6OR2yRlMmIewYGdf?=
 =?us-ascii?Q?XVJ4Vzvb8xpQT7WZsOAQ536Vm2xrRGZp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GEFYaIHIwnecH3sa3loqnx5/ibLnW8gFJWVR/W+RDj4titYWDsxgx+piCStA?=
 =?us-ascii?Q?R+EJA1jf/fTk/6hjAyn6itZQskkGY74rYMmIKhQ+QQgUh546G1QSxIcuv2Xw?=
 =?us-ascii?Q?Sdr6AAqcRNPVFCYHDYOUreaRyB2wgs/icigjsyOuggYCtKVIh5dc0a94r3IP?=
 =?us-ascii?Q?1Jzl65+D3L6fdPjc8gMQ05J3tysYoIYcmIYqDYtJNb8tFXTqaOOrdLNvchqh?=
 =?us-ascii?Q?/HeV8md9qpN5gYcK6KEc3gN8OLsGBqU9jFdAz0F4PwXaDXnfCTJ4jro9M04s?=
 =?us-ascii?Q?yvppKskYyxiz1F8ZATl39E17BXeUEaQXufiJGKM9fkLufAZTomI2kdjD4/o5?=
 =?us-ascii?Q?r45Z+x/nIKTWWiqO1x2U/lRCrNshr2RL86av+S9B23TABp6KH/XjF3l0ZHpv?=
 =?us-ascii?Q?41lnjkjEC24YqttFyu2ECqHvqauqpS4n5ONJzTJlC5hV01ckcZ/8s+p9+Q3O?=
 =?us-ascii?Q?fCWPHlEf47rQy+bLlye3PDi1rU2+fI+F6oskfmHHdgvTZvl6m3pqKlCxtqu/?=
 =?us-ascii?Q?gVh2UGdzSuU++M7iZaw8yfZTFIH2twX8EYI+qWJdJu0gXJxPHnjy1kltDx/L?=
 =?us-ascii?Q?XMitonfb/yTRC4c886ysN1N6DFvVmWHR0fAgSGU3StixDpVoCic4EFkQWxlI?=
 =?us-ascii?Q?6lfe4U7NcLRvbSqv+D/13BgnbJgu6zyGde+MdRR48ytqyHHFN50pToepwSX3?=
 =?us-ascii?Q?nYvL/OYbrjIfB5hzIz85ME8rkBx9/vJEoQ4Kxb2Qojjf9vHBCeMgavKXH4BO?=
 =?us-ascii?Q?Nj+g7hgMhSEPYIZ70R3IECSE+Q+yfZNbLO0yRLg2hZz6NKl/RXEDrml/onG6?=
 =?us-ascii?Q?RaAQiBZrAnrFqb5SMoBtgPoDRiPcG42LzCW+Cq8peoTEmWdIlIOM+12YS0Vx?=
 =?us-ascii?Q?/wbzJgHukHBPMN91Wa6kZCqgPUKzra38GeW9yJU+sd4dADDjGLE4GdYEFTHa?=
 =?us-ascii?Q?klmZ2l9Dva+lLKM8K+nRmC+PU7X4m2ro481osz6zOijY1TKTA+kwJe25k0ar?=
 =?us-ascii?Q?w9gAIKEokNerFuHlIdSTBjF++3szhh8woft4np/LNVl09xyL+aezLZf55X79?=
 =?us-ascii?Q?Zkh7wWgk/3yAOcdiY986JyKFuGUk+NE3XK2p1k3WdY6xuYw5E/mpp5xZvYOv?=
 =?us-ascii?Q?s8NAShUbG7IM04x6Jxlb5kq+rmP0SQtQKiLXSCyyRRlVZwED9uT0y+V2HVX6?=
 =?us-ascii?Q?9Ml/oyNOxHB2lK+RePbQn9TxPYOre1VQhh8CVEif3/O30AZaoToVwhhWb4gD?=
 =?us-ascii?Q?E9fds3AdCs8tDFRPO2QkUOgmtnKrzix2Z5gEanlmL7llOtEASK0uOF+6N45r?=
 =?us-ascii?Q?FUztyt6Cn+hcgs95hZ3Uby9pYYbF80xZ2sdtS3UHT620h9z1f98i4KyjAd3s?=
 =?us-ascii?Q?/9dC47/kb+bSQVdMpUpUfC6yETyNqjE+FxxJn4Rv/ZYaxrn+HUGACbZmnt1A?=
 =?us-ascii?Q?OzzmQvqBHOqNpCjoyvi1JIuRaeniG9ERnZAnwzlI2+dtxCd6zK2bZx+AOjxd?=
 =?us-ascii?Q?43XNXvEeKojeqcLBa/EoTwR54R1Zsl4aZf3ev65rB0+HuEixJ5rhIVNxlm9/?=
 =?us-ascii?Q?jhbmoGNrC9HWaE7puKhE3/rsNr55NVuQNvA6LxRP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9d4457-f6bf-4297-bdb7-08dd315381e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 08:48:08.9486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtSIakMk79YsMZ3hHL0tj6zRJnVNH7wrYyYLZrIey0e9pfYEdA01e6/dPF5lQs2W2iGYELxsRtHKIyJfvKDBcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7993
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

On Tue, Jan 07, 2025 at 01:37:06PM +0100, Marek Vasut wrote:
>On 1/7/25 1:11 PM, Peng Fan wrote:
>
>[...]
>
>> > > You cannot replace System Manager with optee-os.
>> > 
>> > I think optee-os is also capable of being SCMI provider, so I have to
>> > wonder, why does NXP use custom hand-written SCMI provider instead
>> > of something already available, like that optee-os ?
>> 
>> System controller is the central controller of the system, and
>> i.MX95 needs support safety.
>> 
>> We need to make sure when A55 crashes, safety core still work
>> properly.
>
>I think we are conflating two separate functionalities here:
>
>- SM as the always-running monitor software
>- SM as the SCMI provider
>
>... please read on ...
>
>> > And one more question, would it be possible to make U-Boot NOT
>> > depend on SCMI at all and instead have regular clock/pinctrl drivers
>> > which can configure the hardware using plain register writes, like it is
>> > done on MX8M and older SoCs ?
>> 
>> See https://www.nxp.com/docs/en/data-sheet/IMX95CEC.pdf
>> Only one boot mode:
>> Low Power Boot (LPB): only M33 core is running after POR
>
>OK
>
>> You may configure TRDC to assign resources to A55, but
>> you still need to make sure M33 work proper.
>... so, I wonder, can the M33 act as SM, and can U-Boot configure whatever it
>needs via plain register writes, without having to rely on SCMI ?

Technically yes for prototype building, except TRDC and other secure periphrals.

Regards,
Peng
