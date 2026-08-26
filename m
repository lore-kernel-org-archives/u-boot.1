Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB234C61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 08:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A96A405A1;
	Wed, 26 Aug 2026 08:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yElUe845x-IM; Wed, 26 Aug 2026 08:47:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787734030;
	bh=i3iBJ3nQkYXQTnxLgBnVXPAzcqPxqS3lpXUqSAzZy/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qwR0T1SQ3oxx+ITHs/ZzIA4++eLqCPANm5FZQ5YbjDnanCrdJaDLVXF5ktIRJq0Jg
	 gj7ieOOygh4+3iOOPCSvFTNCNbSZ8rP8TDrwdwIWPwurbFdCo7BQX9ifptSvTlj/GG
	 +LzLcuBkI3jZg8DBOFRE1AWTWONXapsMC5W2KOSDJDUJT4ZxT6vIEmMzSZBXa85IkA
	 I61zE/0Nf/FkPr+Pxzw7KCcUkoOibXEcuYQ1+I1EF3Rgjybk5GNWmv1ODxXitgLlxE
	 UFzTViWCaUa+G2G5ZCTbOk9vfwYRJYQHDr2iEIpNbamu2KKOQoTsRaDY6bR4NM0byV
	 oPSfGRSAsQgUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 905654055E;
	Wed, 26 Aug 2026 08:47:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DAAC9118
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C13E980BAE
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 77uTzkhcCKwM for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 08:47:09 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VXsHC0Y2
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD45280B8F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejFWObte1juuDDu06Ld+Mp/LaO+30sJVCZbqrcvxsgrGNlMmaQtRHUWsIwmuKquv7PqXSNeF1a+NQWXicc52l9X+M777+uHtjh5ZlwKvDyU1y4XnUi9M/dZitBysqb6yz/bJaPuWF+pIK0dbuDHMDUN+sxSvU/GJ/hgWWy5RUYvIW6HNy5xMeZMdMbECMrfhzl6UtAf+jcvCl96AHrP5trfh2OuDaDwWM+SWZz7gKNa7o1jO4wcrI0hSuWljnCnD7DNNiq67e1xySondTR6C8grQ/4zFoY8MZu5pPw/GRLtXgpeDSyxmYwarBqhcfbDdRyxyA3GM7/5zaXw3CDXauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3iBJ3nQkYXQTnxLgBnVXPAzcqPxqS3lpXUqSAzZy/4=;
 b=H7VLOfvn7fX9MT4mfeAHsLnYHRT7skosGJtmvpOqfDuuqv0FSincaz+h6azyuP2q9yRtG76YKm4ze7Y70lkHL0dQqX8GcmIhJhAF6WhlHQEJhasNGB6g6LoM2gCqIEwxrJC4tagXkA2MZo5PHC9gQzIYd0aCfH50HXSMq6ED42POoK3u+DVrM5SsqJvkbzrdrgLlb7KTmipAtOOACOWhSrNSrYPThv1MqTxWdIrBSr9p6yBgpFmN0RRpjHRpewtvsXGMKmx/xm50gAcA6Crsxi/j0fxv8jXhE0Y/bTDohEGpLRMta/QU1mSmy9wkKdFy1k76cPGNUQnXD9DuUZVwaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3iBJ3nQkYXQTnxLgBnVXPAzcqPxqS3lpXUqSAzZy/4=;
 b=VXsHC0Y2XgCLbAYBx8BnMuMv4eRK7aF/eQYA4k8PmjTm5TcmGoNjyUsNWBr94gwHGKA/u39gkb2JxMXpaQylmb2I+jcJ69T1kqfjZx3gjoRM085alAbDb/YJ9nMm7fWaAb0iG/iuaIsFx+zH+ygjXdvgYWG8ArQyyPBjdWG22Ju3E6kXtoAoYDo82mEfxLeg6YV9yguC8WqfVL5XkybOHdAriWITF4Me5djuDsCkKl+IYG0ot3sFYfAw14mU2IW+FwXOvDsVCBGHgK25EOJH0/v6hMefd8Ppww3Om8/XxsEMDpMraZ4itClZ74YPwBsOsSEy9O2x3s9VG1Kokax/tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9076.eurprd04.prod.outlook.com (2603:10a6:102:22a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 08:46:59 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 08:46:59 +0000
Date: Wed, 26 Aug 2026 16:44:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 4/5] mmc: Call back to optee after a successful mmc_init
Message-ID: <ao6nc78dvKK60egJ@nxa18884-linux-1.ap.freescale.net>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <ddef88ae1677f4c9b793252483f23eae900b89d1.1787514446.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddef88ae1677f4c9b793252483f23eae900b89d1.1787514446.git.jan.kiszka@siemens.com>
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 919133b9-f826-4eb6-aa2f-08df034e9751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|366016|376014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: cXd5gDO6GFYtTbUjiWJMmqgKqIegr59bu9gGsUaLafG1jdv21tkiaAioJLrvaexg7lTIt/So97SmQ1lt4biaEDyQKu4qfk3GFe+EqSPGXu/Gc+opcNpOOmXBShMHLKoaUa1itGDIcVZSXdozcOuLm4B7B6pAIam+nSSn2kAxvA3VIE+flPbmvRQ0N1hnsaSV8P30vAQbIwEIGvyAqsnil7kygDc2eeAkueEh3fALTcCB+DVb0DyDlPE1shnZYgqCm6gj5QsOt1/yAvcYq31vHuXHo4LKugk7VV4wmNbTkyOdo+aw1wf+nF1Vq0gpL6+a9GOLwQ8/mU/9++qe5ibtXG2Eu9Qjz3cgM3oP4sPQX+RMciDD3Cn5Ee/WAoO2mLt7YurwdzOeOfuWgqP09j1Dasq4dWxAGqXk1QOkqy1gh9rJjQzlO/fKo6v8u1pCBdlIiBqo+lgLaQ6HCFgG8thl2IDxi2B82NV3p2PeLgj0emnrgB6Xz1dUKX7vqMlrOnFx17HELJJDYl670xIctZtduAjD1LWIsxRi5/Nl+WdPjyky+KJIRr/rYorUH8BkR5fD4ZuOb0emTjdvo/eYf5pPUhgYt/GpFONOCNdgUAqNsqp9GZhlwtTDCFDtQs1v/mVpnTJ0icH31YIBkwOPbnfApyjRepO7BzTeq2FEUtqUiVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(366016)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0lulYhyD75n6LufvmarUhQbsktZeQgyu0XwC9Ql9ChTN6OD+MPBNUedwy9xv?=
 =?us-ascii?Q?HU7Ea8xKPq36zJT8R2UjBdCRvjXtp4xzhCDN1/707w7YxL9nIayrjG6T5fr5?=
 =?us-ascii?Q?AV0bYoK/ZTnmlzhpBKORwDP6bP40I1zMlbAY+gUeXO9opAoMk8MPpMbdjxR0?=
 =?us-ascii?Q?l1CvDDimhTJG5gCnNZaxPOSTu2O9qq8FjW39TPB0R3DZ3J1+1+m9pWouTWEY?=
 =?us-ascii?Q?wjpCyYvVbkI95L3lGob5XCS2bF4DRRUQ9WefYUbXVOGkNzkGd5F4Ge3Sbd0g?=
 =?us-ascii?Q?86ahKr2LVb1S/r9ISs5enRGo2tEggEsRgvobJsSybr0XG1RNhIzMu2GXArWJ?=
 =?us-ascii?Q?auvmE7pdW2icSpF0A/wV0m+squtrDhIEAZCU3sEJUZseASmBjSteM0xJHGIq?=
 =?us-ascii?Q?cLgZuFJjlgfQ9WzvZbGhrUmfwDM9Z0mxueiSJNY9pdbOhLqXrUTNW9ahItml?=
 =?us-ascii?Q?+OLARWw+WTXfCXStPwI35lArES6aaNAPm/+9NnA3tlCauouTuBNsnWe/S62p?=
 =?us-ascii?Q?nTUM+wbkSGpriqdT0yM0K9n2ltp+O0o0RR/u4cSXQXlIuVWzO4QDgQAFJKlx?=
 =?us-ascii?Q?xu3Y8/x0xoENyuRxQD/6DsE6IFIx1EgEFdoOpS+BKSgf2z6V7bWH+pCii77q?=
 =?us-ascii?Q?4oVzT+/BE4Fn9sI6iiCuF8/2r7qexC08usZu/RTAQHkR8WoZn3GRCjhp3WBD?=
 =?us-ascii?Q?TVYNpRCjU6r1Fmwa/l2ioheAbZX88Tf8fc2QRnYVvBSHXFoIKIM4pyTSuZNC?=
 =?us-ascii?Q?xldSacU24xaTkndqY2KfEFasIiuPZCA+YBtuG4qsu+8D4gT+pNAEftOmng5p?=
 =?us-ascii?Q?HLGJqDCAp7nfOlrMvwrh0n6A7Q8dAtTqqOcaDHaBJ8KjihQzIKlZy2cPK20t?=
 =?us-ascii?Q?zFOxcb2u6L5wuNj8vgeJiBFhB/trS6aSLwLl7U2CutFsKsJ4u1CU7BMYyRTL?=
 =?us-ascii?Q?u0bxDv7lwpdGuiiwuqI4nfYBaqxuKrCC8EKU5f7VYc7tt4sYSkfruPIsYPYA?=
 =?us-ascii?Q?BUOSiM+yJBybhIy3Ph+MI0ex3QP6cZOG9pNuDicSkqrwND4L7ktAPl+ukFjK?=
 =?us-ascii?Q?i+eqOiKpbBDc8Y+v0c+Fo7KsShkJNj7UWjc3Gpcp6IPc2Drs0dw5MFDqrBux?=
 =?us-ascii?Q?rvYNVUYGd6RQ3B40u+sgpYS9wOYfdzLRW9fmpggWkxHIGYV7IlnLq3mLSnPi?=
 =?us-ascii?Q?U4xskOV4+b96OKqHL1Jmyk7i9H75g00tJbaHvu88GgfHGV6PYFkqNWg6fviS?=
 =?us-ascii?Q?E5FBmQWsevMzcKCAE5yIJTc3DUQCueq+kkNqsdg5FWXsr9kblodewkhheAez?=
 =?us-ascii?Q?AXhti/0dIQyU1mL3WOngDLL2nU1XfFbh2vu7PL8JvU0sWYNHgmC9BuzYiJ5R?=
 =?us-ascii?Q?effju/nW/oVqd3af772gcLCyXnQw5eycCbVqDOdVvarR55hfl9u8lQPPSmSY?=
 =?us-ascii?Q?/ynaEGnYlTZKN5DZ4nciGNG8mY1Q4zvRBDUZlul26bu37cK/YUi8EQMes5qY?=
 =?us-ascii?Q?ptCTHbHzWXmLPyqkPD3IQIfu/MUtAObJlp9Izda8vhA95EUCTsuL/E+pxdh6?=
 =?us-ascii?Q?/oQLjghq9+/l/XKJL6Kh2jrBXVHqu1iOVYssrPo/4QsMcnQv7/eHiL3Exc5B?=
 =?us-ascii?Q?2FCo3u/mVG0JyjPg1BQhYOupVuI+4IIPAUxwgGSccPPN2WzUsM8pPfTfrPf1?=
 =?us-ascii?Q?Cw0KWIZKkFYpjpfcR5JRwHUcoMBLvODsf+L0FNT+NynsZ/UR5AOlSSHuEogh?=
 =?us-ascii?Q?FFqiDlqY2vmIYKGPiMNU4WS9pYcdKuOh2JAdcjk9syQmBcgnpFRB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919133b9-f826-4eb6-aa2f-08df034e9751
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:46:59.2953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tggPjNTzbGkwOnBwhFoODSt0VJthETdCGGUU5ByY1zeAnXJuWwK9wxrdEzQLo37/+YN5Et6J/B6CDiQI4NFkDapclcDl9DYh1AqeabkD78pB8kI8n9FLFaZuQMYF29p0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9076
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun, Aug 23, 2026 at 09:47:25PM +0200, Jan Kiszka wrote:
>From: Jan Kiszka <jan.kiszka@siemens.com>
>
>This is needed to that OP-TEE can re-enumerate services which need RPMB
>access that may have become available now.
>
>Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
