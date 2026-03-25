Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE56103A9A7
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 11:26:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5989F83F86;
	Wed, 25 Mar 2026 12:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R/YiEYKf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F71483FD3; Wed, 25 Mar 2026 12:26:24 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D8F380517
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exX0RbC/pGhLe3hZtw/kHkvUyLnPIYlo9KozAVCwDjRI6AQ2Cbhek3HHKxo3/tKpZ5zZpReA0FJEUTFoexdQ7Q5NLJpb4l6iYTv1GPDRs7Dvik8LfR050QHIxO2D7oHM3Xm/NfFYZGH3e8SKnOjGBm/0wbRzAE5nS768gW6GnxHXVvSEeYhvOKmaFoY8PGyJRP8u/XaoIc6V6Ec10KVYdKUvqEJ8Mr/0ej7j+QZRyMudw2CqdsfO+AgylWR8PuCouiX+npk9MvWmGHYTf6uk8jeWbhl5sM5A8zDTuEfPxnnH4OVS92QGAiLPzdUdNe1PZuwRb7b6h4TCqbJov6eSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7PbFXC3fJnotDNEtg3oMwG1HgFTGCUNbaRBejrt15c=;
 b=fbjAzQF3iZg2riyMxZKjQpn96UIFG6zynAjRwHQ5YoY4y0OFpJRsQsWIGizOFHm0T9184UqA58OY0cJgopRW1Ry/RSiDAaW4LOGW7U9JcOZQczXgyuAkffsaPoaXxLR8Af/xc6TO4raPqDQPtBeyseg1n0MYjoKBUPGFiLlEicjHzJpyGLUKGVV3WAP1DLZFxBaqFfRNjsRwMzb/3IRpLdFCjL7iKSb5cC2ar5LaT+e92BjnfH3/rFCSK/O1kVHtSTaoxw4gXkB9xwlihT1AU+/BuAWqHeEoZnGXCCVmv97gr+YvuVinh/2dpddSHpoASC9zfWO5psWHJHhamS8BSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7PbFXC3fJnotDNEtg3oMwG1HgFTGCUNbaRBejrt15c=;
 b=R/YiEYKf8792HkjFSKwBFbThZR8skpVtERYQSKGbKQ8yDYJb2f+h5Igw3TIDvBHvQArJBMwgmksrGs2iHy3iuANvUlsiOaAkZXmZiHwIBOXrH1fnryc4WwpBA2J6al5qd/wOlXVYTuIg6XGwvNoovROsJOQ9zJQ5pYaa1CcOcH5dZ7AxGZngmAPc/bMvj/oORpGLKzjah7mMFiXd8TtRR3qMZLWDmtzJ1vh7Eaq/Qe/T4WIsmvbjlyFPtyCWHhXpEbVDnJZ1/TLFT+Jt3NkTXyQWDI0TGmZRkKnv4sIxuGLM7iHye4Km+8inGSLlObIfJNjAaVedcHcvt3ByFNGVlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:26:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 11:25:59 +0000
Date: Wed, 25 Mar 2026 19:28:32 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 7/8] configs: tqma7: add defconfigs
Message-ID: <acPG4FQkQ58QK5uB@shlinux89>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
 <20260325095801.47706-8-Alexander.Feilke@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325095801.47706-8-Alexander.Feilke@ew.tq-group.com>
X-ClientProxiedBy: SG2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:3:18::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a35629-7e4c-427e-9a57-08de8a6149dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: 1cX50BicDtM/cW1zAezHQOozRlre6TnAIAtaBhsedV1HaEmeJx5bL1KTc0D36T9cNvHzLxAtt1emt1X/KYVHPLyz2AT9kz75R2U3MUGR/OPYRKkEHAx7vnwJ9p+023uq0ffN4VHp6WS55cxZ7ObmMAch6F7+90FF2cFKyywIIpqjgsr+Wy+159jkuWBClCiFxljqNkY5aRxY218GDpxzNtVBVH0fxlQiwdPBvPe9puiI1iK3CcLj6b1bfmdWSzxCI1gsZ6/pWSzgW7Xn04uB/EW77jjOBqL3I8kfX3BPHT4q+/t8yPPiDqemjF+VG1ofOXvnF0u/BSiHbPo9Ce7Qh1AEBOjTWf3EJJfUnZBR3ET0YiTL0tUrRt5htiNczOLk0aaWUiJbhwuyjpEqIkGKrF7lcmR9V96asE8Qf6aYiVRvPQxTjnjBkfvO0h01Wrf7ESWBxmCIZPC8iUJ0wmhu1oyuYJIzG7Pk4lYR16JSTjcs99CNFizIRW1/5DNprwAfLtGeBczS9fTwj42P0EuBzqPsXnQzlkTehIvIphfiLMRcmv+YTqUvLv4lvjgyWe30VxEfmkNY36IInrSi5NQ8h2kLe6qUSoDoqxnrRRc0OxWavXQxTkIrhuNpOY5sZk/1tIUZ27FQABvkfvFI7kKgS2dpJbAFJdCTz/LRtVzZAOM//jHuFGDtg6kMeNYkRqABnwML1FDpWEeWi4SC9R8Uzrx6AeF3UhLatTwx9kR80/G5gS6VqqQXc/WY6oWNwklIJ9An/PXa0Bk0evYnuap7yB33DFBEYOl28UCdWcxf74Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XXsjDjjzUhLJm2eA4Gs8HLI806hOMqHBCx2uR4UoB9s0vCoQUYZJ6ZAm2GK6?=
 =?us-ascii?Q?49mVUwg1dJiMUEsaELOuFM1MGO64p2Asce+4JPutULxXPKnrbvPS8p4+SVN3?=
 =?us-ascii?Q?URjJWlLd+pfPVKI9F5SuO6U7moiv5RP4u8ToM38rirWExlX475zK8JVes26O?=
 =?us-ascii?Q?ZXap32/nShRiX4cX9yiSVPzAKLZnkTgWbcjRhgW9NtbbLM7tlIbm2qo2N7up?=
 =?us-ascii?Q?LkvP7WwD/Xdbyv5ZhKmajWsYvRpyanjx0qgqeVTmdW5Pbqq/9MBbpgI/CS6d?=
 =?us-ascii?Q?7x2VfbBsFkPjNeWE+Yu5DoMuYgOGoAkGHxb4QT9lQjn73wdLGiovPyQ48YGB?=
 =?us-ascii?Q?/dQ9FHeDCOCAGn0dGaVBjCD3sc4vZV+mEdzwpqTbyUtxo6wIEQrd5NuWmkP7?=
 =?us-ascii?Q?RiZD25YYWSfEW3PXtVtRDidReMsJzi+fNDImAxOgBKqHbuDwtz9ivX6A+Fd4?=
 =?us-ascii?Q?8BDQfJ6eFLllbb51v/h2BhjKJTHnAUDQwbeDrvAnexgpMYCz3nG5pJEa7oua?=
 =?us-ascii?Q?/A33lxX6PUxsbOqdh/Dl09sgT3oCbpF1w11ejL99FST+dJP2mZReOBcBozlx?=
 =?us-ascii?Q?EnTyaJyt+nD0Bk+8lSmqR+SY3dwlxsn+LtoAIq9RDD2EIzdXl9gu4mvBVqav?=
 =?us-ascii?Q?g+too4o82U7MJ7HHBA6rva+h6ZuLrwQlXz506BQLuWU4PfC05y+x/axoeq4X?=
 =?us-ascii?Q?9wRlXqcOiwYIaulkUmcSdeBeXBU2WRDo1KnFLHnYggqXda/UmwJKTx+BAmgm?=
 =?us-ascii?Q?O5ARRhkn77z7hwrHJvOGhO7Gl2qZ/CO/xMz9OSF0xGC9YP8vpi4XAaSyuNk8?=
 =?us-ascii?Q?tyn4Jhx+SzXZIO3nzdyiLum38aFGlOVstOUchZeEoZQUc0IdoLcQnc/VjFWH?=
 =?us-ascii?Q?gF+xjKY//F1rcs7FTv6bsfQ3NhN9g5ZanZQgLEI1iAwfBd0iEw5kf6QiRAev?=
 =?us-ascii?Q?24bOeSXmR+unnYqln5A9k8mND4bIT0Da+f5nGAIsY+PcXRgtIHbnn7VK+bud?=
 =?us-ascii?Q?uAiZZ3vJMXFIbEZVdfbdVYPkQL3lnQ1YOSZo2q8rIwGl8mOX1mI4Gr3GgfXm?=
 =?us-ascii?Q?2SCT8Hpit1PVABm63t04HRQJl92HbvxjVb1Le7wfWUzyqSFhuioXeozJ4uED?=
 =?us-ascii?Q?FgjP4rcFFnhaKy6+eM6OiLEeEeYbCRfuQjFVKHRITpTV6cj5ll/knjULRkvT?=
 =?us-ascii?Q?yJQCmkt3F5Yl46MJzP7G2BgHxrnj054Qmp53GdBF6APCIJOvzcB6LgV9/nOf?=
 =?us-ascii?Q?YI3AvMFpPosEgXEyVcs9AeomYE++dGz8F6gWEe7njhYC4g3clqBcxgv0gs+9?=
 =?us-ascii?Q?xtW8+jyeZpnQSwsSLSixxdk2EeY74F4B1VVed26Wv+F2ZtUvHNe5r04ugeIZ?=
 =?us-ascii?Q?xZLseMYRlmX2JmW2GxJb7MRbKs7WFO1LwXSIK75yUbMzPcpZdWfpm/7TmOiZ?=
 =?us-ascii?Q?mP5o2oZw7oGKY7ZDvrk6KMzlPWn8m6golcIaAV1bwlyQPFwFT6sdH3Cg7OOq?=
 =?us-ascii?Q?7AUsBbAs/s/0BV3SEfzrsKleO4uxI/blhsvfv/ibmj+xitIVN7zziix+D+Bn?=
 =?us-ascii?Q?hQQRlnny/AhvwCsQdJDGCOA8yy2X0ja77yTCGol++lbpiQU9imTRs5PzrcC8?=
 =?us-ascii?Q?f0AeT4/x6oIoavqq/SNBS+QJBkWMr5Rj1Okb4HCb0IXOnF7qMAkZaEGn74bI?=
 =?us-ascii?Q?PDg3MicJ+bmC9CSDtpJna0012XxI5lg6ZJho6I8XT3I4hOSFBdI22JHQAxkL?=
 =?us-ascii?Q?TVZLqQ/oHw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a35629-7e4c-427e-9a57-08de8a6149dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:25:58.9943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8KuqQHVo/19wOvUWjhUTLsoD3kKUsWntSh/opiNBnUU5NRxRuUr3xdm6qoVNuqCOY4pJRoztQb5MZgO+FPkaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893
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

On Wed, Mar 25, 2026 at 10:58:00AM +0100, Alexander Feilke wrote:
>From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
>Add general shared configurations for different
>boot media and variants for every RAM configuration.
>
>Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
