Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE403103A9BB
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 11:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD1D83FB6;
	Wed, 25 Mar 2026 12:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="imOg/YCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF0683FD9; Wed, 25 Mar 2026 12:34:40 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B662183FA7
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga0Sy3TbY6VnDylGRS8AD2qC5t968UX6JPpZbYZc39VrbK75a6e7taVZPf1bibm7eEkAIZN8XMEu4txrK3G7sWFlduX2efx71qnoX2QDs3JBzNExcrRJFUEh3uwNxHO0ZZkVCRdkfjETYLjbZlhTNtmYem3g+g8Qmj85WjfRbF5/OYYn2Ui7cTZxH1GGPiC/aupqSBye8aw1x7FBy4UQINCkIKUtjDugudsQsq7TKPk/fftHM3jy3/dz0/iRLNGBGHIA6M6pUe/+WsXe1mIvW4sSPNt53QQlZ1xSK/lm6v/QX7jDcRN1HDmOSi5HB5LFDmuCyw5mHD8lHLWqwasxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1NCJMyZQFQJcrULyBJup3i3PGkxbwQcPE+VPKBLauU=;
 b=L8GsAh9NiI1RnpXJJrMen8XGTYDCGVx9selJA2O336Osk5lP4eso6oESWAPd+y0peCYjU1EojyYf+0PU+p0ZGpfM65ihwR43BmxJlcjCwuXmoQw7cTNTbyDpXh2l3XyueR4bBT6fpTvkNhAUdP0J662nBrCni0ZU7jTv6dcy7+LF/QXmwtSXU8jaWGHZBM76jqV6iZMwnrpimbvjruleTkCeF1srwUJtxBF1z6ybc40PUOSZo+G9LgonRaQpQ/r3y9C+Zl/dIEgCK92+BnZ3prnERKJ/ZofZ5A9/xrdOpw+aazRn/qcBP0Fd7opKE/NjAjHA7EAPIzGQj26YNKHZVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1NCJMyZQFQJcrULyBJup3i3PGkxbwQcPE+VPKBLauU=;
 b=imOg/YCfGrSUjAqCnFYfop1Qf66PQok36zXAXBg+Nk9KAgQMZ3kytqCESUyWW/mnjTJW9ZQbKNSsy8tuwTcbzGM4SmfaYNb+R8TaqUUuneVmJ0hRfeTTnVjKBpXOAo31R5dYwOL1YPm+nY1rq583fbJ8enBzf7XC2oeZJ369CWSP2pb665jeNbnLckxgYs+vBS4ZT2J66X+QJcrtMyVR8eJyLK/IhX4PkvKenc1pSCpQvMl6rkaf+E5M1bPjmTaqNY5kdOGAantIcCm5e2ID611zKZcXzyc39mz2LBg5e6D+CeA1XIuy9u4yVVbvtB8YY7b0IHAbVVfS+ES5Y+ughQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11047.eurprd04.prod.outlook.com (2603:10a6:800:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 11:34:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 11:34:14 +0000
Date: Wed, 25 Mar 2026 19:36:48 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 6/8] board: tqma7: add code for u-boot with spl
Message-ID: <acPI0KNbOC32SUYX@shlinux89>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
 <20260325095801.47706-7-Alexander.Feilke@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325095801.47706-7-Alexander.Feilke@ew.tq-group.com>
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB11047:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e1d9d5-9f54-4bab-ffb7-08de8a6270d4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: VT0yDU5RYIQFmKEOttlXfGkvLmhAWuv1AJSHen5nrkvhAIMOhOWsgYyYIIJ1rH2gj9QeTqrPhOP0H7+a1Fci0elcMErYalr5pocqoBKi9UNbo/B7Cy1iE/zrirjE1nmI2eY7fRxzIBfqonAcS9o3gRZnQp1zHVu9qLFZLetuznyiGpImm1NRFx8yIEQHW4/NRz3BJTFyYwakykgRdcBgtK0RoiHKc5CfLK+zckEE1gW9eapc8Z9chUQaTwrJRuhAxnSF+0RrBt3ejJmIj0QHdVlJfUV6dmHUMOzkMhvU1XGAcj/ry6JnSUqKB0+zXJomHAAvmB5oLLwRh/E7rbJji+l4K0GNEFi0raW9Uo+wm8JRHg03ZKsR/HRE07u6AgTh5BerHd63eVqSl7/IFeFBW0RwVa8O/YGjb1bot7SIq4G7BRjMokRuucf+PopvjyGEktfNS+gLFujKOdXyjaCPsQCR/LxK/ril1Tf8n6mfKWBsvAhCNLjd/aGsYWsdTHwIoq09ikKVuW4vRij3TxdZNWySl56aV925NE0+j6Jnt16xLNdG/leuYXNddVUfuJfDXLNY1lxlLxZa/fHFGNJDSOuWXjNqjAP6iMCz/L55ypn0EfUllJsYGdP35YQNRh/VyWyKV1vNcoICb0U3ONHkEcmzfe86NHmxOmsNp1v1JIZucbXNjN3/01b6/dBrkgYlwogDwhiXdbbt7rDzigeBV3edj9K1SFXyWZOVvZ3ENgqxW8oP1sZAvFTSQqASS/hLJ+LIXNIuF5peEGf1HBtyhwJDKC4LB9pTTkZgxzAlqVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OOwP9vgrfl/wkP/bq1rcgl9dDcXhkL58XStecVPrsokbSoDkyGq9waVllUx8?=
 =?us-ascii?Q?Bi18/vZFhoNe9cDnoJme8xoIXqjJOsDDOWex7yaF80M2YCk4MIthC/sgQjBD?=
 =?us-ascii?Q?fzo0kvrCR8rc7wr7vUg60eP81ahzpRKO3LB5WKxPOsPvyBBUEIbxnXjj2fuB?=
 =?us-ascii?Q?868PED8B2LbYrtviGphShvO/NgUQuVt7lYopnDDo9C1+eLM9E/UKEXMPcTW+?=
 =?us-ascii?Q?y8Z7l8goGogols3dQfrRVYGRRRG/93pMgVebw79Uwg0rIU8UieGBxwnzkOzM?=
 =?us-ascii?Q?PGD9vHCL6GAtkm9Ba6i7qKAM33O4+PRQVnsI5iAwAVCkKb7IwRxMFld7BWA8?=
 =?us-ascii?Q?L3Q7T12BBN4Te0m73cY5CwzxK2OnJXz72r/ug46RMrHDUph6PX+KaRC4RpjC?=
 =?us-ascii?Q?VzMDzekmz+MAsma8odhgCSA2+REGg3hQYhAKRjWQsL6PgM0eaPO9wyNimKge?=
 =?us-ascii?Q?oX9axydQEbwHYvRJrpHrhxa8lS88B1DJyWBd7fOXwnPYZcgHpWjTW8HhVp3H?=
 =?us-ascii?Q?QyRGanaFYjm/3HJhvlKjQjubykokfd0uL3sAfkTBZt7FRswmguhytqwFtvmx?=
 =?us-ascii?Q?05dYmDlpHTtmWaa/ygLWPN4sxCAO0oYPhdCvVkpPfYGYhSofcfMQQ1FxCzV2?=
 =?us-ascii?Q?IJ25YN/XJKb5TiTbI0fpfcH7E+oZAVdSzsX53q1b6WoENc7/L6sPOhDPiX69?=
 =?us-ascii?Q?sI0VxROOBB7kZfze2CWjM4zRnBmND1f/mSRKvPkws8bSkVnRNPTOBJsT0Qj5?=
 =?us-ascii?Q?bTBHqLWXUxMoV/VUpcEvKvjTqCylutblJI4McdPruziJ7YoieHSwcMpp3B9b?=
 =?us-ascii?Q?k3R0tHM/IjLMakUhpErE0PVWhrczXwAp6eC138X+4VIiDouJFOQwn/6t1VqO?=
 =?us-ascii?Q?TPiczjTvQ78buacLxDeIjpZZz+zC9E5b49Na1Qv9VUVZLQAgm6kXalQAWRQ1?=
 =?us-ascii?Q?HyAFyMuJDp0W7gG7lyQKckj0oBDUCvwR7LryOF8KR98pX13eZ5WOomt2GLkl?=
 =?us-ascii?Q?TzF0tJHw26EYOOlvYSCnbkpo2K4eWMslTxbLQQyrirbaJkAIUpJWuw8rlzls?=
 =?us-ascii?Q?pWhm11BQpwOBthMWDhEiCbXRJQpHanKJe0ggbpkq5CI3n4jtjYlJd9Hgy6i7?=
 =?us-ascii?Q?v+ta86TjG497QVWeNyKp9Z8QIq7Igxis0QIr35vC5OuD4x12uynZTMZf7XJW?=
 =?us-ascii?Q?2hZBdHphYjclO/wGPw7VZRKSngMGQcGiRVXvNTqTyna/EaTGHvWDm53isljA?=
 =?us-ascii?Q?Yx6oZdOViBYZl36AiRCXoOfatYIq5UyQSu8Bb6EnU6tzrgM8xxwxp1Jeqpsl?=
 =?us-ascii?Q?U9jKx/GUJCHiTrPvMgEM88itowqfD+rwP6ptKK3YUersQUb4L7znJD10RwsP?=
 =?us-ascii?Q?8TSO3f/C8iAELG3BJ9NsNUBt0ttwQGaftbfMBeLyzxLcBtFdwFBigCuvS4D6?=
 =?us-ascii?Q?fewlP28/bIv5lfDe1scob4jrA7dP1Yaezln7Y0rmBsfwh6apkdR6YNFbjYND?=
 =?us-ascii?Q?Z16Mu7Q3vtl7IMmgqe7FDMVFWRyByPzIbff+TC2nyJEvDEJrhvuwTAAjKZ4V?=
 =?us-ascii?Q?v8CPjGAKtU6+08TEPGEoVmwFRWtARxSiyaz1YLFL75xN3IQvYEPfDFypibeQ?=
 =?us-ascii?Q?WMv4wn1TaTXUIyR1iJ3qUZiPD1pfheMK1Vbj0qnXP8h7GlyGqN5UxLksdJ5+?=
 =?us-ascii?Q?SlXaxsRmJSqcU/TUNAP3svId71Vauv47pSGzjzMwUS82XCBCQrX2cGjpNZUL?=
 =?us-ascii?Q?C69bqwSNRQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e1d9d5-9f54-4bab-ffb7-08de8a6270d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:34:13.9208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uubtESUUStvE1QrlVABotTaB0ypvg8PJyK6mPGvxdS2dx0cVryMpBZUofOVUIPSlT9oObup28D9sGZ7o6uAAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11047
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

On Wed, Mar 25, 2026 at 10:57:59AM +0100, Alexander Feilke wrote:
>From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
>The TQMa7x is a SoM family with a pluggable board connector based on the
>i.MX7 SoCs. Add support for the SoM and its combination with our
>MBa7x carrier board.
>
>Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>---
>> struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
>
>One note on this cast here: It seems weird to cast fsl_esdhc_priv to
>fsl_esdhc_cfg here. This is done in many i.MX boards though. Just want to make
>sure if this is the correct and intended way to access the sdhc_base address.
>

I know i.MX7D only has 128KB on chip RAM, so for a FULL SPL DM + OF enablement
, it might not be enough. Not sure you tried it or not. But in general, it is ok
from my view.

Acked-by: Peng Fan <peng.fan@nxp.com>
