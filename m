Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A69FB5EBB
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 05:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 892588401A;
	Tue, 17 Mar 2026 06:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cd4GFdAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05BBF84027; Tue, 17 Mar 2026 06:04:25 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B47A83FDE
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqU2JIIV4n3qYsWwE6JaEsWo7CLvRLrWiALOqQb6T7F4FMC8Fkefg2dc/RUbmDFUFKrXYPbMDBbTh8WM4+YIBcFd/lPgy6Koh9sGIsFHHzdMVoJ4T2BBbfaT+X0PR6zU7/wH9tm4JAtDmD1bh1BPO/cztUQzmpeM8NQlbioI80FuTXITmBH0TvrIFpCVVY4nOGAY0T3p68WVSkEIy09vBDMj1izzo+WTzSlxcgfaZ9uymbUCTRX/P5AD5PnaZJq1TZ0Cf79cWpkUZpx3r8eQxecZGQZDPlkxFVvWZoOezAlsAlI38ZGmeoWxaL7EpxfkBFzhzMVQdA1x4N1bmXSpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B0qD7fY5njdBYP9zH79rit6xWttXP+fiAMVwnqRIN0=;
 b=WprpTaBBfAW5sSENm4YBNtwljp6izjwuzMrsE61xkLHP/IpNElh2Yf0KHcKuugQmXjwt1E2RliYTDTwFfZvhTKNSQLb/MI+gQXJG7b3qqKzet3VXo4ym9JmCMv0fXHVtBcP4jxLIxdNOVIBzYvJ/CKL/NuSp3iREOG3xEYJzwJbe1FxtYHdVvLFBHJjS/7D7XR4rD7CSr/+US47ykpqHBMhgcEjSaKrH4BhlDFGOnbLJAnfTVzHWZOyBbz94v8Jn/MV2d9vDNcYgFUejtax3k3wCSkCSoBbaG9RApEqP9wZXemwh1Elz3iVoZgX6oI2Tmd0GSGgfPlFzScLgyFMePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B0qD7fY5njdBYP9zH79rit6xWttXP+fiAMVwnqRIN0=;
 b=cd4GFdAnksXdSezUatGYl4oyHfKgnxUOnZHJE73wjy8h7aiZIufejGwW9AzqIJmxmsaO3JaSO3TKYy+vI1Myehw6NRHPrs+sv5SkdRFgnikfuess+iV66ouGgsw57eRmih0Bdw+V9EGvR5wRcCYGegW8jhCU80YmOJKKPID3QqAfqZ2bvpQZCzR6y/FK8ji/dP2nLXLNBiZjMXDGL2bi1jgm12z2tALpSezMwjw0sNRvYpinhLAI9WkqLW9fySmreWtgCUFXvragDnCNoO4FOEIwJ8ReJMjp3qviYCUd/bGX5iXB0agECWsDaI6DJgsPrqFYNMc7hWePT72JHVJJkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by FRWPR04MB11175.eurprd04.prod.outlook.com (2603:10a6:d10:171::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 05:04:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 05:04:19 +0000
Date: Tue, 17 Mar 2026 13:06:24 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Ye Li <ye.li@nxp.com>, U-Boot-Denx <u-boot@lists.denx.de>,
 Alice Guo <alice.guo@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: OPTEE on i.MX8MP
Message-ID: <abjhUDlPRbB1SHrv@shlinux89>
References: <CAOMZO5D3yqFaDgriO2x3fnCrwGm0oV-chLsy3eOR2O3yg_MvNw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5D3yqFaDgriO2x3fnCrwGm0oV-chLsy3eOR2O3yg_MvNw@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0191.apcprd04.prod.outlook.com
 (2603:1096:4:14::29) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|FRWPR04MB11175:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc82320-d769-44f9-9192-08de83e2a501
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OtqnyTfYmnvLjZCXHRfEyzdZ1znP5Zi1m2B0Y/uTdfUdJ9WFbjYzvCULkw53+wgK/xsZpKL2906M1Bm+JjcxtMqr8msI9NId6K8HTCBSkwA1LXM1dDFoRp3DG5WdboHYq4dnCR/iQ//5uP1pZgrENAfMgttA+Y4sTxSn4MZX5nDMsX1obfoGO0bvI5/F5SpGa6HRTUzc+dQZ3RCEh/BW4pN//Jk8WtXAlFIJJ72yHYeVwyH/dn/6uCFjqyZgDiZa7z8jLaRc4Tw56+R1dY32HLJhsk9pjTFA3JNNkHKn7E7kahF3SONpRnDeBDIel17MxXm0LEq7DF1a142xzjqN+aPKE+gx7HAbTXlhAA85UV4gTay217/bKrRZwarYqJACNZcpy6wjndc2p9T2pTC9Wy5XuZFoNzjOts+yjH73poD0zKVMfx25ACT3BYcuUdfSu2CG5MFzmiA4Eo9DRKx8NELRXnDgINE1qXQ0kqDWRBTfBKPya8GaVQcpJkPLB/oo4aQ5dcRpN6u3N0+MY2CjxcxWsLBiRWzT5u5rEwvrRc12QJC27jtnntTJFDpyt+2PpYcChI6SkwKzdWWeJf15LeC2cNF3fvmtap/o9dPD+Z9XslLdIPNyRDRtr/boM0rYKgXgnnVL0sMreilwDsd6LYyIQA5vUaxGB2JUAJqkKacqXp1RM9WhwELylQSa6TVl0yWYrX9QYwTuLE8vH8P52w+MPhZbhIh1CSpNMY3qTiP4rNvlE2kVui/QIp8BS2enIVJbXYvjpgvuO8LHUmwlgqyddonu3wKj+/m9Y3aK+w0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/9gT8LOmamV19h8XNoRyAv0UNKThrTSN3uWgw1fSLytIP5Td15bwSzl843V6?=
 =?us-ascii?Q?FS+WuWbVYTjUVVgi/F+fsbneMfp4dop98ce9pfb4OoUs6BPfnmH5m4epTOfy?=
 =?us-ascii?Q?aqDpuyL2eEg/+TSW8Z6qqpn5OjM4GaMwN1LKh+fx2uSYQPiYn3uh1LWTKB/Q?=
 =?us-ascii?Q?sNe35Ccuc0viojs/2Z9NxmkROcuF2Mxay3j0ztyNfjI35uQSV/dFaOhX37Uo?=
 =?us-ascii?Q?CqSfffxYwq0RIncBGoixlEEu2rbHx7+Qeo59bsT2xnYZHzlajsEjhmscoQKB?=
 =?us-ascii?Q?b8BsUpTjTAUKAu4SLCEs2XNjWfceAJUgWumCqSp4k/n2jwfo+MXnkKF/pTPF?=
 =?us-ascii?Q?l3O1B70u9g8hgpVAvochlGLEzCXwTZ2/peAZUzg4sJ4wSstNZguNY0XOkqn/?=
 =?us-ascii?Q?1/PA7ctWT8aEzVTd3ecahZri199cEmJEXK2PyfJgBbb4zn6DFJSN9m8B5XTE?=
 =?us-ascii?Q?WPUmjPHVOTmsSEO/JBYvPFx0+8AawV5WYy9Qi6yZXQypUDYaZANqd+amNpWP?=
 =?us-ascii?Q?8mt0AvwiyUloIgOgKmh/g/KCFP8T41VpncHtHEpX6tEd/Kac26LnUjcUNXSB?=
 =?us-ascii?Q?IjXIk0buzhMKAyRYSHYCSxbPWPPb+h0z+4zN2FkyfNWT76qeYeKheDYDWgGE?=
 =?us-ascii?Q?0cj8Ps8Aps2c7ZVPfHcMsQSSRT1xgInGs5P68SWpg0cWCMhQpZn35K1na2Zu?=
 =?us-ascii?Q?6QFtBfDSjERLDcwRXt+dexZmhIWgOXbMxP7XSRiF2ZuTsfyAWTyIHliM1Xku?=
 =?us-ascii?Q?0rVKQqichZJM4HdA9uk/ghltykGfsbS8CaKTfpSwbBYpdsJoD2lqKMo0EJkN?=
 =?us-ascii?Q?+MhqqLI5Z+vHvM+yiHfOEEyyZGNfXHycc2uVMWlvkqtTU58k16zi/t1iiKkR?=
 =?us-ascii?Q?JQ5FxofPbZz1b/dQvpcWsXum6D4ybcBRzGM+x1TMaoMJTV6wxbthdS6DNTm+?=
 =?us-ascii?Q?r2xhTm8D80y5uFeWP+qe7KXv3Ao5Z4N8xHpFyaleK1zpbyEfOmtjdqDKQSq4?=
 =?us-ascii?Q?cFmFGlvnYYM+glTmysl/JIpU0RFt6cMloH99qS1NYVHVpzC/Ruh2g8kD/2/7?=
 =?us-ascii?Q?3SdkvMawEGQymxoaFRlVWGRE2QWcHgtt6r5AE9TuI8DHAbdm+Pjk1+6WPxlj?=
 =?us-ascii?Q?FKZpyA+n5yemfGWi2YqW431bUdQqZA2JigdG56nyKcwa15E5eUbIHkDhkuWO?=
 =?us-ascii?Q?01kHjqGeqgIEthwN2U6VpArENl1WBFia4lTPqMXC85VLNp0kX1sp6H3lP0mV?=
 =?us-ascii?Q?IAD1Db8Ap30rUhn2O/1DAsFoBwEbcWq9jgCVOp5vC4rYbmSWmuN4PsAL7yLk?=
 =?us-ascii?Q?7065azotq1yb7bB2Od1ZD36OCKD1GAyH4jg6z++hXhYziIKx0MAqAJ2eWB6J?=
 =?us-ascii?Q?X5RqZkrgqrFyBdGsyTIKvzveU0Qe1t3Gv+xsXMGM9aZUcZkNWyph2Ppz+M8v?=
 =?us-ascii?Q?jb0NRfrGU1Bm+o4oZczu05IcIwtBmsqS11lLAJlEYXcZIUo4aRezDUvKIeC3?=
 =?us-ascii?Q?BjxqKGE0jh10o4oMnSrYCpNS3m0re0TR+3x1M4ewtZ3xIdT04OXwem0jmDdw?=
 =?us-ascii?Q?omnFYX/OPcEuIpsSuDCr3jHA/hr1vJM0rNXTsKNS0B7BBF/SQYPAihjGXv4c?=
 =?us-ascii?Q?SPcoQ1cDd8GkAlmqmpsaWt6urXOjhcQvuWatuMFKQxgCO/Bd1/8LwnmphYPv?=
 =?us-ascii?Q?OeSn8jYVmyiQDztkAhAhp4/3M3sImlk+O6lPM4Wd+i0+0W5GUxdiUjuv23JP?=
 =?us-ascii?Q?e++DInnWhA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc82320-d769-44f9-9192-08de83e2a501
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 05:04:19.5120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3/G7XnaSFyQW5LrzqcijT6eyIbiUZtoaS+z/TBrAyf5S+cOxVnRW54AOVpngndfBSvJfmY/xQy0CWTx/KDrWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11175
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

Hi Fabio,

On Mon, Mar 16, 2026 at 11:07:54PM -0300, Fabio Estevam wrote:
>load_simple_fit: Skip load 'tee': image size is 0!

Not found tee?

>***************************** Tee image is not found
>NOTICE:  Do not release JR0 to NS as it can be used by HAB
>NOTICE:  BL31: v2.14.0(release):sandbox/v2.14
>NOTICE:  BL31: Built : 22:19:21, Mar 16 2026
>ERROR:   Error initializing runtime service opteed_fast

optee initialization failure.

>
>
>U-Boot 2026.04-rc4-00006-geefb822fb574 (Mar 16 2026 - 22:53:30 -0300)
>
>CPU:   NXP i.MX8MP[8] Rev1.0 A53 at 1200 MHz
>Model: NXP i.MX8MPlus EVK board
>DRAM:  6 GiB
>optee optee: OP-TEE api uid mismatch  ************************* UID mismatch
>....
>
>Any ideas as to why Optee fails?
>
>Does anyone have Optee working on imx8mp?

Are you using upstream ATF, upstream OP-TEE?

Regards
Peng

>
>Thanks,
>
>Fabio Estevam
