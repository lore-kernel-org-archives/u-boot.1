Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507D8F531D3
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 21:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C54839D5;
	Mon, 13 Apr 2026 23:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="jjvXEMJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B081984198; Mon, 13 Apr 2026 23:16:21 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22F88352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 23:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaES7JLbLp6wItK7WncuvnoaNDRnZDHztySRMI0mUBg0VelhzLHZT07wqpkgAgd/1WFiEsB0wQuTtEngC0Lvx7g+l8IwIUsaHHlGgF6qQIa3w/acPSNH541SszCkimJlouWPOFQ555U0P4vdEysJd22yy3eooLYsoH4eNoZOCSQK6+VDvnxVNpY9LDXcPxuGiBawItP1EhKLGG2mRBYg61D8lI4YhpFPcMctZNrju0v/sZhm+uD7XZKEaGJgxOyxMUgLif2LRGaiiA1mHRUiCFO5aEwvoTR2V2JRuQzVv2l2lqwPrkpPfVaRLKSCtzKhF27RTPc4DkRd/T7hO23fpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbOJITxJdWonj78UmHSutTCyB157+iu+CoKzMixetJw=;
 b=QpFjHWFmMNNUr9WsLNzbe/3mOKMJ+071/iBDu0RT4bZvG7Tle3PfN6E6XfODqMc1QoNIyxvKgfK75NicYXo+0OGYxtTSZw4fZxv0jH4I5Y+hkkQeBimZpMkz1pCqHVt3j/gDor5CWtY0yTMLcgBYCOLJL2tnJnO7nrn4uNohSkVKJPAmiaEhe602+UpAWvrWrMZPH7M0HBx/pp5pobACzzbODljF0qpRpzxJ0F/kCVPVdpMg5f9fGZQPB3Mc2fpzyWxM4CgcWO0A+3uvxszCuASe+qJ4UNuVnql9Lda3wUiPhqBTJLRLvStNQ6KznVdy03sX/oN0LWMHCOpif3iIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbOJITxJdWonj78UmHSutTCyB157+iu+CoKzMixetJw=;
 b=jjvXEMJ2bMHONOanzGzz0IUGCQd+iVrp3jaj2GvQubr4UNUUq2POuzCKzU9c4ar4Rxcp2Ihmz8MLfrxa67lwelXgXnBVlWgeY4EYx3hZC2v7FFpzWu4uqeMmu5V3MKKkmh8tKJWDDbQf60e6yJJJD/HFVW0PbgT4czTopKHkuOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAWPR10MB7198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 21:16:15 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 21:16:15 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>,  Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,  Adriano Cordova <adrianox@gmail.com>,
 Greg Malysa <malysagreg@gmail.com>,  James Hilliard
 <james.hilliard1@gmail.com>,  Marek Vasut
 <marek.vasut+renesas@mailbox.org>,  Philip Molloy
 <philip.molloy@analog.com>,  Richard Genoud <richard.genoud@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,  Tien Fong Chee
 <tien.fong.chee@altera.com>
Subject: Re: [PATCH v4 1/2] kbuild: Move U-Boot .incbin rules to
 Makefile.lib-u-boot
In-Reply-To: <20260413131541.2091541-1-sjg@chromium.org> (Simon Glass's
 message of "Mon, 13 Apr 2026 07:15:37 -0600")
References: <20260413131541.2091541-1-sjg@chromium.org>
Date: Mon, 13 Apr 2026 23:16:14 +0200
Message-ID: <87mrz6muht.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0023.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::12) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAWPR10MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 542c1b50-5de9-4195-dda0-08de99a1e580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +dLJViKb5dsNFwvlOZpQTQEMMuzJEFbmZ/1EmEkzSd2UK5eYi529wgFCk/lVEusObcf+V4L8GBkmkz/bpMU1jRxnimQosrCX7hTgKi8LRvBHnivFHzG54ZwA+6S0twC0IvyYMn/dguhXdQtRIgzoAtt+CKsbgIgR6EOnDgfO9jGG1M0RTRbNIdijdbNzSv2BSKfvbjIxHEPbczB0W0VsG0wNIHbPSNxbWqkLw9OeEY2F0U8mucQ/iUXsb8GB2B6tWkEr+FmzCYwLfi6WeNX5Z6TP2KOUQ3AUKHn6Ct5HfuvgvsCeWdbksSBLYKn2h+ozCN2HFa2SDjwFEXw5X/vFXHg0vUTTcwHyyaLil4cdjucfJ1sjbw/ZBv44IBtoodVKnWpo0coL/5Y7qDc+mtWcobCkoyqcAKWd6r2tFttTBsxXImqf4b89Hl+j/Bl0kjw0CIb7RkxwBL55D7nlYQJjSknT6t6MlrqwABjT+ITBAEGdQdTQ/rFfjJPl67PDiCBb2msW2w57iEgkas5pQBQYCJgXmNLkuWcnWmpzi2yMaS/Skw53btpX5YkSQ+ehHFLj2J16PBdNeeFDhRh/pU3WfAYhadGClO0qzrddRxY4Qm2Uk600O4COj9caq1Pj5vhNU+wUA7cQd/dvpI6LHPWv7T7Ndxw5Vc3KEZaNYg6pJU/DyN+NVuylx04XT9xHn+GeULGn1lGz1+P1D41c/6m2awKso4cefkOOSs954kB44fi+MV1SjJ7XyJ3GIkKJ0hO8LVb+VIigGzLIvX1o6LCIBDQcaIvFYiLFfu7ZkVjZkLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hXiYQZxk4QCfSUksYGWIGNQ36uKnPRblFICB6Dgd2CbGevIYmhJ73fTISO0N?=
 =?us-ascii?Q?QDJsZXiyvzsLvh79gRAZT1BN9O5N4DKi6P5L6rchBIjYs9rK6CMwgZtnpU/M?=
 =?us-ascii?Q?/Sbyf8m3CNMrtW29jPHbROMetQowStRG3qZaTYtA+XTqS58jju/1jSBkL1lE?=
 =?us-ascii?Q?Ckfaw4WOBHUCNIeGQOkUSGFmWjmB0kEFJlzObWFKeL/5ptilpHUWEK979fBm?=
 =?us-ascii?Q?xkmRUNbM3e5GeFJvx/QJcQrJGIosP2KDG2tl7P8H5DuNFIyhNHNlunnY47cV?=
 =?us-ascii?Q?oE4jMWObqLjtdQ45t5TxW1umltaLohfO8VR4BBT++Q8JLSun5l5VsAA7L9IL?=
 =?us-ascii?Q?16VrQJdptPHMnkokSmCCsW0EegFGmf3KFOXlz4lW+x7PQ+MNgT8aNPLDEauv?=
 =?us-ascii?Q?N8EuLiKlcfwIABKNTAFL15btmy1MdgBemw7CAcvOONVNCFJDrshcG3iEDUOY?=
 =?us-ascii?Q?eH/G7k+ah1SexTiDrHYvZUeDolyJ1lCoE5zTVl3G36ivnSPvrlHH+58i24om?=
 =?us-ascii?Q?sALrfz5ufIoZVLRB/ta4kV8ZCbhqqv11cCKfOFuDIjHdMR2J59WISlYMkdZf?=
 =?us-ascii?Q?jucemjP+KiKDjcrb5IFah1rZSahsr1anRB1IoxBt8yxoYRhdWqMSKqJ5WPuT?=
 =?us-ascii?Q?rgC1rdiJAZ7KCf7A9haUu4hJe7gsYxYgaP1N+I/qIGPe2wiTtMpVhQKCUlKB?=
 =?us-ascii?Q?Eo0nIaSmipyuw4AxQBbzgLlWJkrlNlBe6gfzyL/MVJADnBZs3J2NBZILWUah?=
 =?us-ascii?Q?ia1U1+T3QUHQawBPlNf6vNyc5WBBJtvC3MhpY50lJKwPHB28fA5ebfRxziSf?=
 =?us-ascii?Q?EYkWc1IHS2KT5bt4MC9t+/gA2t7MCH95bAwLiJ6s+tt65O+H5/A2Mn1R3idb?=
 =?us-ascii?Q?raAl2+Q+P9IWflneeD2URCO2Ra3gifKKW5c1cb8dZBtoxQE5IJL1k06f7/6L?=
 =?us-ascii?Q?gnDyi3UQaLb0SeaKxdldgd1k05/MdsPjtzJMtD6y9cDip3RbTvAVToPmi+1u?=
 =?us-ascii?Q?eKCx1FAYAWOhrctnRCWAHjTGIPAxB3/XHimhNqE9Xwnu/JNVnfp+L5DOUWaW?=
 =?us-ascii?Q?AWmgCocnJLcyJJevWxoIf1exU5yXYEsTwxySj2+fiI1MFWYX8BJ3nAH8ARDU?=
 =?us-ascii?Q?7MnQlGU3WWKpoxZ2HpHGoOK/cH4LjxEBxKw8T+j4j+bk/u6YLnmK0Kd7qIKj?=
 =?us-ascii?Q?umGDIzmisve6W46mr++zz8ImPf3gze1/wpvqWTyUIqITG1z3JFDJ5WLGTQD5?=
 =?us-ascii?Q?YIjlwGLSWXxlq9OFSWXf7slM38birxEKEoRt5dduv7xhDuAF6YZS6iZUcLlb?=
 =?us-ascii?Q?TOhAE8VC2MMEybpO0wDx5ccQfklAuWuvfkW5nGh13ydgqI+FryfaOlvY3Nh5?=
 =?us-ascii?Q?DKi8KepPAxx6GQEBlzp3z7oed0a9gHnbdxPmGw5XHImaJc9bAF3y4fgecCCI?=
 =?us-ascii?Q?6jjQTVd6rJhdeapUh08Wp3bHw15eloMZMtENY5MNk+NwkDD4qb4A0ykNCGy5?=
 =?us-ascii?Q?19sS0AgNTHMIV/M3f4pvqVp5CsVERDfm46YFPA+Ch7pSWWhT8h0hIwmseXPZ?=
 =?us-ascii?Q?ajbP01C+Mz5SKjjeeVDg0/eexsMTADUDF86xbEr1nahJHEd2FB11xjFDaMPi?=
 =?us-ascii?Q?HxFu9kKfxSxZAMHt1wDqJAChLMOo8GkgovixRKweiLDUwZEhJ3q1kMeOEu2F?=
 =?us-ascii?Q?r+qtCXq9B32MQNswF0U+08KKWyJylpcEFxaIug2Bhr/RaFEQIErV12BtGdzF?=
 =?us-ascii?Q?guxe8yPGLuwLP35Ehp5Wd1XqM4f8Uzw=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 542c1b50-5de9-4195-dda0-08de99a1e580
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 21:16:15.3994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CffELTvkRiAmZmO7f3CFGxutHZ/gv6bQUaI3LqbpFpcCgq+fDJyZkCML0QyUqdRDn+JbbSFSe6lif9FSH9vwX7ZZ6pQNQX7cftcjSb/UsUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7198
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

On Mon, Apr 13 2026, Simon Glass <sjg@chromium.org> wrote:

> The font, splash-screen and EFI .incbin wrapper rules are U-Boot
> additions that do not exist in the upstream Linux kbuild. Keeping them
> in scripts/Makefile.lib makes re-syncing with Linux harder than it needs
> to be, as every sync must manually preserve the U-Boot additions.
>
> Move these rules into a new scripts/Makefile.lib-u-boot and include it
> from Makefile.build and Makefile.xpl, right after the existing
> Makefile.lib include.
>
> This is a pure code-move with no functional change.
>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Rasmus Villemoes <ravi@prevas.dk>
