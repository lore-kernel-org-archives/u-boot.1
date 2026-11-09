Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD7D606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kBsD3uok;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BH+7igXb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70FA980EA3;
	Mon,  9 Nov 2026 06:29:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id czg610tRJUMh; Mon,  9 Nov 2026 06:29:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AB48780ED9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794205781;
	b=G+Q7bZu3H2YE/93Zi4A5RDP0Hq7EBK/e6Sqirswogq8LlZM/o3cpz+SbsToDF8u5mPo7
	 a1VOYsBsAI1NxLVzw6uEMT0tBXMdpAVXcMhYBfOFFQF+V8fwM04D6Uqqzp0W5ooKPxz4G
	 uzX5zhrMxuBdgOLGxI1iw2odoDrXHaujTifS/M4aAa21znJZ8nKmck9tTjxYJTYtKLIBI
	 8W0zCdghgPLiYcebk1Sf3xLl6iQ5KA5zaWiPLliIGVX/ZlPtc0Kym8EWKYYxgUMCUDk4M
	 0rSHSgGpmg1tJLdem9FMu0eHQ/heeWBLIXJ3da5PXCvIdDg2tcFtH5pHXdhZdmillEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794205781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cDsxsYlGPBfQ9sRnuDzYkaK/jhg1wnNPzGYJOxy3RQg=;
	b=bzw/63fVemIQjJhENv+83WW9ty+/ueW8xPijsHNJCeGKhnnLsyq9igV2oocd2wvcXtcF
	 7GSr41IEd/crnv5CJcRRfuQfHBltH6lyB+ZWYG/0wcB7c3YdgFqEEUyXzG/BhCZGP4z/c
	 16kHhrea5MAYJfCNuWOzgUGPVzdHGpD6vWHGfE/ebVUaqY0OCKuwh0hQPfSO4OAwumOcE
	 b6TxEq4XrgY2DF+4ZZ41T67GYWpBFNwFm3HVFPF0tEkhbH6eSicG99i5Yjv3M3IPE+i+r
	 HIhUbLr7yoFiyiqyb8srnpX0Y7n0cacHyCihq6FSJ99dF6wEyTGkmU80f5JsjzTlcow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794205781;
	bh=cDsxsYlGPBfQ9sRnuDzYkaK/jhg1wnNPzGYJOxy3RQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kBsD3uok51s1pviQ6uRxV8KxjMbGAIb2Qzn3Hj+RJDlsq6H8kQjBOrr0cViq0m09k
	 cVNxyNnxu3L7IIznaGceRoUK+RFl1powWjt1jGa815cDK+NQ9KUkmIeQLFs9w8vlVg
	 1HtXu40eqHi4msmoRk5n5GtQSgy6wJInkCmMCMx6+Vhxxgf6RpntcW10NR7/2NKZBu
	 LMsdEj4YZS1CJTaZ0I0i6W5B96FdLkYy2teZ3b6jqenTKvT3BZi/xe+kgGGOD8GctN
	 +9DpyT66eH43wPmdx+jL4gYibTCa2tqqQPkKzNcZHac3Q6KECyNwtwrF3l7QA8TcGS
	 bfKPKTwtz64Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB48780ED9;
	Mon,  9 Nov 2026 06:29:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 210AE1A6
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 06:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1DC5C40636
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 06:29:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cps57szYka5D for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 06:29:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 17C2340624
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BH+7igXb
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17C2340624
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 06:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDsxsYlGPBfQ9sRnuDzYkaK/jhg1wnNPzGYJOxy3RQg=;
 b=BH+7igXbs2Tb8ip8ejwHsNbg3fk12qSm4Nm9+0XhINNP4dPowLM26f31KTdaIQVFRPE24WpnQpk9cOOKN1myrYOCHLLWi049SNU97Cj0rLBQlquViwVGj0BFzWYaBeGOqG/NdTG/nG+aJMluh7ViL6ZL/AOYbd1aqiF/bHAI63Gc9QPfhuT1hh9r4aLjljSXXXrLcshXau9gQAZ7748FW3TNaXhz9ITePDvicPmLXJwxKXSta113vxRp9m+Otf9g++f0FNElFESLPP56p2xkXrCPynhtm+Bgw+5+JCRyPZXUfXPUeHnpMP9WS7C0MPAA0i/VazFxnVzFCoRrI5TKTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV4PR04MB912432.eurprd04.prod.outlook.com (2603:10a6:150:40e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 06:29:35 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 06:29:34 +0000
Date: Mon, 9 Nov 2026 14:26:04 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH] imx9: soc: read the SoC information after relocation
 with SKIP_EARLY_DM
Message-ID: <avFnfOtoqFJk75sV@nxa18884-linux-1.ap.freescale.net>
References: <1Bx.ZqLe.4vhwbiJKX2M.1gy2pN@seznam.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1Bx.ZqLe.4vhwbiJKX2M.1gy2pN@seznam.cz>
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV4PR04MB912432:EE_
X-MS-Office365-Filtering-Correlation-Id: 212657de-2dcf-40f0-a53c-08df3e2ad241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|19092799006|11063799006|56012099006|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5pndl5Ib1Ss9xB0oPrq7CiStAG1yIOHTwgq7PYD1oHhFRkVnH2XOBhHhToxBJjDJHt4cNtNpjxxBgqLKUgbKQ/4bmHFGDUd5nhylxILQq1V3zSK0Pdkzulj+lfYb4qrGf2JqMGGMpPFdpp5p2mC/HYZBFYAKS/uczUpFA6JzDN2wVfJHXDVM2y1xPQlKKNTObIE9vcMhfSBiuHZiBiDiN71Qhr40NI3e7i5usewU/HSxd62MmoP3F94lhahBvRjpl1FfdxYwWn6sBeXRIiiyE9q5MGP2jWecx+R2xqep+4fC9kQQgTmhcgjRWcJsyG1PVwc7MaJhchfb6n43I2itSMxQ/zYKxn1qntVoQT2AOk6/ZmkgXnUBNW/gDtlQNruaynvbPgd+OlI8+6XTMlw7mXtGqqRYQeM0FiouIl/s8LgeVyQSCJtlL5Mi33OSvRn39DCK4MSyXVHKPXRoZZ40rfPAS/VIaxxFYt67ErgfR/tAmbstbCHxU34rVjrngTmP13qyBM2E+Ycu8VyMLJUMMjskARY7Wfd5Y/C9N1giQxm8rhXfudWeCwRvsoeebddM5+iCvOxTjcr9wrs4saCGr2bsikdgcCvImfHPhV6btsgNep1fwsEUczv9yqUggYGTRr0jvC5Gxl7c1htzdHGwlfBq6T9mbXnRnju4xubvlE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yk0/UDi8BljhlqGbujzjfo+bz39OU5WD0x9p0NoPo9ZJHdciSfunSVgtHY3a?=
 =?us-ascii?Q?3/Ikr+h4x4P0oKICQVvHOTSqnYBczOUjTwdSMrCO7yHVB1Bjtbqui/nEhVdj?=
 =?us-ascii?Q?DDxkq1vLZQjr0lMSOmHIvQAiJ8md9FaqfStArBFMB2qyFFcZq+XrrVIMZ8JL?=
 =?us-ascii?Q?SjVNgL8qBscd+KT7XbPU64uqqhm2ig0+07McVaq7FmthdTXLGdZUdYYm7i4g?=
 =?us-ascii?Q?0wxnDGjQAshFi3c2lExUb5806Wd+USTBy1oZGav/q4qpPVTyLYXUD8mzfhv+?=
 =?us-ascii?Q?oOViTG99oeq/YcEhwZ1KeYNFm0V/FLgh5O5ufgjWQi8NFI6T5GibTjY1RUYU?=
 =?us-ascii?Q?LgUlaB/DlNyyHRBm1ialK2gFZ6gc9aZ8KMrAiZK5Sn1nNbbDc0K8Ze+uMCK+?=
 =?us-ascii?Q?8oOaI3qzF0tA+dGzDR/DoqIm/L0gLAmZmplZpBnDahAPYr80/IFKt1bGGh1M?=
 =?us-ascii?Q?KynmrUaf1aFkAt0bW3FjojMDXb/A+st4WJ54ObOwXck6vC6OKC2zQhqtjNzS?=
 =?us-ascii?Q?yDh7fDSWfb4PwqGeW1iN2YMhvh472ToHHZ6Rk+/1qZSCOCWcLq6TNgXic+td?=
 =?us-ascii?Q?vNPrVyeYRskL5DvEw+UgCK1INndVtxuawQ5k97zBmTk4pvip2hbu39quZ1H4?=
 =?us-ascii?Q?qoDDLYAVQNNYQrOvaoWPU1BTRc/EqBmDsG4l/A4UjWcl0ngJQhJdFr2lEaxI?=
 =?us-ascii?Q?N1jcYvVafyqTjZi1fK9y0Fy3PjOltHxiWzvJ3fu0zcXhiD5On2FmYymEzJns?=
 =?us-ascii?Q?9GLigp1cJL61P9X3DSk5C5Q5I2d7DEGst0Rn2W1fImScqflitmc0Cspz9ZNs?=
 =?us-ascii?Q?okAknInf92GvbE1yM6l+8f2wSdazXf1S54n8N5tgjB8WmLJdhJP8/lQHhG6u?=
 =?us-ascii?Q?VVLdesFSSiDoqshnBY1+H/wkMVfkV+eWip+Rcr7wMHhlf16SaTsm9DC4/lli?=
 =?us-ascii?Q?FKmJVP9QvT0X+GmcKCrc2d79Ln7x3M9zxqE61fNgrk/C24DgIULEuO/oisYH?=
 =?us-ascii?Q?I3taFSBxCxIG6QoueeSmykgMnp8kG6gIe5adSu69+XVsk64XhNtKWB3Jf9oF?=
 =?us-ascii?Q?EvpQ0B6LtD+3kDWFp1e+zl0bHBYpwoi2/MBT9aMGyR2rseQT/UmgmCDSATKd?=
 =?us-ascii?Q?d9lWQBfHkeygM8hRrECv0iZ+t5HyLD7LNgtfBpwWS9J0XBXut7Vrrsp4llBp?=
 =?us-ascii?Q?EV5W/XtjKarWuB7k2c+Ki8/1ushlo85jRRvwyxNR8rmH2xVPzqMjbwrjH2X4?=
 =?us-ascii?Q?n3Q3QYYDN/2gWKl+E8JAF9N/8vcxUHtiParcJJXcB4suOmL/RiCEe6toMpdd?=
 =?us-ascii?Q?FMMYL3Nf1gy43bDU/Jw37Djobn1UHbPQR6yxkvBrLu50gam2PODP1SIViVWO?=
 =?us-ascii?Q?url0BaroR+VewsV8I58ikeNx9ETz1AcN2qDW60h8bNqnqofCaobYZHN7sNVK?=
 =?us-ascii?Q?XZujMwEGMp2Fl4sSj8LpDcmZ9G8Kfgj0W5+CdHhEzHk63AtNVfs6BfindzfL?=
 =?us-ascii?Q?2n9+ue0MgvXUSWSsAHinCJ2oRIXHgpAYH25jOI9AHGct7IJPYDcMjsOSrhPi?=
 =?us-ascii?Q?OusDr9t7YzFMEBmsmAEtcaHyBFHwKuSHyvywEpKNk4J/Gyl3a7UhmA16Pf8V?=
 =?us-ascii?Q?nyelE3ZaLj5RAwalCMr7xz9Zc1aBGke+UJQbqSKxxaesuAKiOLGxQVSq2OEH?=
 =?us-ascii?Q?wwGyE7Bd8DTpkDlgBSnuE9wue4bYlb3fr9QWvqwowBHMCuz3LPitzGfX1eEh?=
 =?us-ascii?Q?b/7JqKt+GdGsEkCfUl6ohR9ZpA+8IARToMpoX+pk0N9Pqh5uWsQG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212657de-2dcf-40f0-a53c-08df3e2ad241
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 06:29:34.8417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5zKCGrHjSSpDoicdgourWlBkqFBxgZUuwA+mj2R8hXCmNB+S8YRc9u0bT6ysZcMmMnsJCYR3Y3DOfoBcPadypi6lqNJo8WO0j7Mt+rMUdEI1DOB10L0FOjz/PVr35OL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB912432
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	T_SPF_PERMERROR autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 09:03:35AM +0100, Tomas Paukrt wrote:
>imx9_probe_mu() reads the SoC information (type and revision, lifecycle
>and UID) from ELE before relocation only. With CONFIG_SKIP_EARLY_DM there
>is no driver model before relocation, so the information is never read
>and gd->arch.soc_rev stays zero. get_cpu_rev() then returns a bogus value,
>is_imx91() and is_imx93() are false and e.g. the FEC driver accesses the
>reserved MIB RAM registers, which ends with an SError on the first network
>access.
>
>Read the information after relocation if SKIP_EARLY_DM is enabled. The
>data cache is enabled at that time and ELE writes the data directly to
>the memory, so use a cache line aligned buffer and flush and invalidate
>it around the request like do_ele_info() does.
>
>Tested on an i.MX91 board with SKIP_EARLY_DM enabled.
>
>Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
>---
> arch/arm/mach-imx/imx9/soc.c | 14 ++++++++++----
> 1 file changed, 10 insertions(+), 4 deletions(-)
>
>diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
>index dcf2fff1aa6..b7e90e160b5 100644
>--- a/arch/arm/mach-imx/imx9/soc.c
>+++ b/arch/arm/mach-imx/imx9/soc.c
>@@ -9,6 +9,7 @@
> #include <cpu_func.h>
> #include <init.h>
> #include <log.h>
>+#include <memalign.h>
> #include <asm/arch/imx-regs.h>
> #include <asm/global_data.h>
> #include <asm/io.h>
>@@ -742,7 +743,8 @@ int imx9_probe_mu(void)
> 	ofnode node;
> 	int ret;
> 	u32 res;
>-	struct ele_get_info_data info;
>+	ALLOC_CACHE_ALIGN_BUFFER(struct ele_get_info_data, info, 1);
>+	ulong end = (ulong)info + roundup(sizeof(*info), ARCH_DMA_MINALIGN);
>
> 	node = ofnode_by_compatible(ofnode_null(), "fsl,imx93-mu-s4");
> 	if (!ofnode_valid(node))
>@@ -752,14 +754,18 @@ int imx9_probe_mu(void)
> 	if (ret)
> 		return ret;
>
>-	if (gd->flags & GD_FLG_RELOC)
>+	if ((gd->flags & GD_FLG_RELOC) && !IS_ENABLED(CONFIG_SKIP_EARLY_DM))
> 		return 0;
>
>-	ret = ele_get_info(&info, &res);
>+	flush_dcache_range((ulong)info, end);
>+
>+	ret = ele_get_info(info, &res);
> 	if (ret)
> 		return ret;
>
>-	set_cpu_info(&info);
>+	invalidate_dcache_range((ulong)info, end);
>+
>+	set_cpu_info(info);

If mmu/dcache is not enabled in SPL, there should not issue, right?

Regards
Peng

>
> 	return 0;
> }
>--
>2.43.0
