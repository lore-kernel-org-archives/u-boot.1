Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302EBC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4FEA82CA6;
	Mon, 26 May 2025 09:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lMsO1R0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1F5082CB0; Mon, 26 May 2025 09:11:04 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF30B82B2F
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHlpI1p+QBG9bk5bTOvoA3p5emFTZeuxd1pZPSRBT+/HT9Tx5WCHTd0grtRFvup5JWePG9yb1uDG8VPx2R+0efj/1bHwJFjx/WUz/S6lnn/9wsS3NPNTAzFiy0kIFQ71IDjDTETaYekPx3lU/zJxK+XKK4KQYUTA+HB30JE1hd126Hdw06FgyNzRa8ImRnHzidk3V1wQCosaOD2YAqOHwfMRwZFF2vM+2w0RgtiFtg6frjKCh4PDIg4uILd1cJyVH35bf88Mca8GVr5EfXgRx1QKjOoHS+28a9C3PRn/uRKFMGmxp0N1cqO6Acb7xw3hXbrjeXqa4PU2fpkbPz90TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va3rRZLq+cGaPTF0gFM1ztMu5DfH6+CyGzr0RP+EQ00=;
 b=BotERfUsYvPB8x0463yzlhpjocCYC1CL/kFhsKdY65C4ha5XEafg1i2yw8Eh2AsQg0z0s2vjSTpIgKZJ8EQEBRnhVBQJCPaKgytKuPbyfbyOv/GeHGzC/9u+8H+xA5NRq0MPynUQ4MwUrZydxeega1H5EWWLciSYYgEiliTANKyjLBqukgrCsObDVxbf1EnqSgKnRD56yyvsb89Gl5wGocAV5Am4Riv3vT8Pu0R9lyrJwzqcSdhF2vOQLASLZZo6ShQPTjt3ZTl4nuR9Abpqf4uJUaLcnrFi0tLaYgDJEDCCqO39tAQBeWUO35tFaslt+ky3H4BKITluaMwFqBaixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va3rRZLq+cGaPTF0gFM1ztMu5DfH6+CyGzr0RP+EQ00=;
 b=lMsO1R0pp35dt2IRKCAV6ucQwxCgf7RHgPVzzEEzG3PeQCACOvtB1zdkS4KBy2KHat4dSqpNK1ooV0JJqbKB7B1zbr1UyG/lT3U5NDZCUhfW9Mw/rafUW3gKZYdPZX8Qpw3uPVxMZ1vh886+vRnLF5E30t3mzzkf1HVFPblOzwEOWjkeXGgdm2YyGapctXpSwSfrbvgNYQxjtcm1pqAGz42dOlrGS1roxowAt3/VhLrZa7dys7vZc2YXIjDq7v8svnYm6tV9zWivO2npX/ZsSz5I0jgw7ZkRhmyc43cjCbxJYf1vRKs+PXiOoqrGOwsq/JZMi33ZROI2QpBfHlwAOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7570.eurprd04.prod.outlook.com (2603:10a6:20b:281::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Mon, 26 May
 2025 07:10:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:10:58 +0000
Date: Mon, 26 May 2025 16:20:45 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 04/13] board: venice: fix dram bus config for
 GW7902/GW7903/GW7904
Message-ID: <20250526082045.GL19264@nxa18884-linux>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
 <20250523172018.4164647-4-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172018.4164647-4-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 5678237e-b4d6-42a5-bd59-08dd9c24771a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DaOxwwzgT8XZzozzKMbGSrQqlpD1OO4ObWtghSbbXmiA4vm1MLnzi6pfF9Oa?=
 =?us-ascii?Q?gOglIjkVRJ9XS7fYDNDjpF00QeVgeppA8H/YTooOa2bNYGE5ts1vfRexbsFh?=
 =?us-ascii?Q?M+LIl+Sq95oVbi7SrLVDzCfA2e903nO42KMpBKKpS8k/emfd7pOyALIUYakX?=
 =?us-ascii?Q?AOUs+Ww1rJitsz7c1dSBlv1SaRJ4ShN4clBk08TIjiL5g2HXBzKyir12H8t8?=
 =?us-ascii?Q?8BqHMZLJN3wfvK8A5BfJi7EmYb0p47WEur9wQ6HUK1YEbDszOrsYrFSFo/tU?=
 =?us-ascii?Q?LPfUQDQ+xjucjYSeTLadF0S+ALKRt1OX0IIiJ7v4/noNMqfWly8etfvOEffO?=
 =?us-ascii?Q?mD72GMw3v/gpiJMS6S7gH8Ro2nTRE4W86TibJ6s0ub81rTTcnOEeeTzAKA6e?=
 =?us-ascii?Q?dnnRviXwnkTKHpfBbipe2tEDinNVBO/VIGlHHQp6WSIYp34u0mNKIc26g2Wq?=
 =?us-ascii?Q?4rE/xh0QT8CE14v0E+p4bn9tEf2CX/K0alvQLkYuItlAkBVUqtzSs7SBAYvT?=
 =?us-ascii?Q?BpAZ/xtoYiWu+n0aMEmpPlrwZVDaw5912sOv8xoCD0rQiLHb3b4UcwgrIfn2?=
 =?us-ascii?Q?tkUaejIDZaWbC2Pc7KDlXGmkAJ2pil8fKcN4jdDOFP/cenngrRyNImw6YvvE?=
 =?us-ascii?Q?ADuYpqMAzDlIlo1i2cJXgbfZ5sB3CwrdXtDt/HYTgQYD1IbykLf41j96FtaN?=
 =?us-ascii?Q?wdKDihOA0QNump/toP93cAnvV9abChqwWzXhWkvyJx4MUX6BYkxX/FnPxwa+?=
 =?us-ascii?Q?CgHYbpWqjkZJnuybOLqfMHpcV4zJDz/kNcU2XUjIpUpDkAHrPXVMixnIgH21?=
 =?us-ascii?Q?w195ncLJn1cx7PYhp3/g17t7Z7peV4GABO4uvI5ZthuHf9IfNFLq0zanRQVE?=
 =?us-ascii?Q?P1UGv5kctqUwsWvJtVOugNx5io657CxkGrsU7w3wNgvAWcZjm/2a9yB768Jz?=
 =?us-ascii?Q?xx0b+lTvinX7GPV/v/asmDFmyGakpPFD6AI/7ozBztDGGzWnRSPGUOOo3Z1m?=
 =?us-ascii?Q?y8ezypY+oTlhRPix2qvGqdaPgmXMqS0fC9+E+Jk92YyfqIm67i6fsZYhm7Ng?=
 =?us-ascii?Q?WU/eVYHEaUpHNyOoadFvFD8qfXMwBVTPNmvvu0CfLHW2Tko+FHhHjsF3zOmZ?=
 =?us-ascii?Q?mpZMyFSPdfW4CcFqSTEq3oKhmi9Tor/YzMUyaAanveNKS6WfAivBMoTz04pV?=
 =?us-ascii?Q?cN2Zyhh25OXf5/N89mJTH4iTB2sEqQnTTlDaWt4N0cbNsCtS8HFm7UdIS+3R?=
 =?us-ascii?Q?TRdk2OuvkDR/nbByB4CmbroF6i6vF4nNt6OLV8xzIOs8wGNM+/vMm9JISTDX?=
 =?us-ascii?Q?nKnKYDmWrliQP6P8jXvAquwwFdR1odPT/VkRECB1X3+/ja3BoTe2k34igEat?=
 =?us-ascii?Q?CqYWWbVxfggS84GXlZYIeG4qPW1N2/WYifDYDT/Zud03WnHTcqJ8ghL3pmox?=
 =?us-ascii?Q?Da8JV2CLhmVODuu+5PNFhAHrohYotHO4NLz8YCp/wUA574z0kYgyvw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sMq6so/MG0N2KsrAW2hIIKBprBNLQAcW8UI3K5EI4CiKSEcHn+a3diE2nY6Q?=
 =?us-ascii?Q?vEX4NvS3wANCox0p0mo+KQmoMWg1pNLigGtVSJ1GvsuHtPUiFasshqb8FSPi?=
 =?us-ascii?Q?SpCufY6r7MgIY+nJlm5wIGUjqz0JXXcFBycrhj2OS2GlFRURRk3d4yrQt9mO?=
 =?us-ascii?Q?OAotxHFvDCWLYeMton9HsPb8nuEQfV7ckqB2BXEZtez2DaaT/UtqHrgorSHX?=
 =?us-ascii?Q?PuiRgvIqWJu0aMmz+wM2RMUsajIf8QGOdl2AXZ6dpnelrzcLKgDKux9GHzrq?=
 =?us-ascii?Q?yBTe1oxS9WDZslG5ZzJiF1VqWUeVhnABtb4WbPvVclNeezLjZpdPHgoRtwXz?=
 =?us-ascii?Q?9AUrxsB15Tln2BqiCEgfgMQqfMMEpoDbjmzutx72Sfl5D5CfyAznSP23mjsL?=
 =?us-ascii?Q?KapGtrMHuFQS65nDwDILnhOqxsDOTy85XxaVwybur+C9nAXMkvmqOsLKuBw6?=
 =?us-ascii?Q?7omUarEFM7QXeHTP55n3QnU1TpMwVX0iW4Vw/HB6O+dMfjti8S5o5FtZW5WE?=
 =?us-ascii?Q?aJnpYtaLVacV/ziPyg8E3PuQecKSHf3+qBehHAZk+zGr+x6j5xWmKLxJt1c1?=
 =?us-ascii?Q?3q953VD7r5pC3rBJe3KWfQm85oKFleWHm31UQrGmDN7IzkruAZWHJ6bM5RSV?=
 =?us-ascii?Q?/dTa+SmH00SiZHauFM0kJUezr0wcxnoE6l/EZ76j8FRIpo8zZngGHeRjov3G?=
 =?us-ascii?Q?PjfpcQvAC5quJTCP0a37rGQP1JSK5MAhceYiWRu+XWD5ObrVBOUjNdhwn0vM?=
 =?us-ascii?Q?BZ/sQj7J4DGxxZKa2CjzAjc7D69yPe6GdQDrv3H27YYN7HNFz19k039ZzSd5?=
 =?us-ascii?Q?WKQbta1VAUy0+E/t8TcvDtp2YHmSgitLEqWJbQiQILLROoQaLCiFfOO4k+2+?=
 =?us-ascii?Q?Mi5KqvcHCluNWVxkmMDN1nm9wgrymvdKTVtPnVMVtE0RhfZnHnGNFzDjk+dn?=
 =?us-ascii?Q?sTto+D6HcxCIbNHq1rFuDiK0EtC6zvLfLC2FWJSu09jsROJ04gapYZed0UzL?=
 =?us-ascii?Q?gOjJUBk2ggv+hWYxsWp+X4KqFpQKZAu4NewbCbbavXGXBZP0tsiBUFhuMucV?=
 =?us-ascii?Q?k739UJnXtw5Db+4h5SJFI0L+DcEwj0Wa74Mk1GsETw5/mQC/E7vkHe3lhKZM?=
 =?us-ascii?Q?g2lsUM6UJn/VgOnVArU18tAKFxmZm0Vn+DgbKkSBKJGx7Ao3fsTgRD+s8Xha?=
 =?us-ascii?Q?WIoiSurtvU43iqFO8ZY+dvNlz+a1xs/5wUtViZmN3l5MuzWx12VMx2zTmOxy?=
 =?us-ascii?Q?ncNjmvyip7VdnHtUvsvBsBd0AMSOAyPGc84BsxdaHnT2SpGqpD/LOoTHa3Fg?=
 =?us-ascii?Q?Axv57IdF4Lu290MeqVgJ7LwsKV3K59LE7sDpjqntMwaaig1PA5f/PHffV80F?=
 =?us-ascii?Q?YpHEtDKWYDl3X70L5Di02Qk7Ofu7r+rcutw8MsqQRaqH8i59My2yw6Y+7rRc?=
 =?us-ascii?Q?o2gcECbeKpoVSQcwNx5fcKeA2jrwWsBRhzd6SHEVJHLElY4kPgtvUn5Czrb5?=
 =?us-ascii?Q?F3t2zu4+4pi8TU0fysd520nPjLDyZbrIoGKHcZVn0DxyrI8BsSwxz8Zlp09g?=
 =?us-ascii?Q?y7A6n3MCHevx6k3TLvAEJ9QoR22dWOvFH7Mt9xpa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5678237e-b4d6-42a5-bd59-08dd9c24771a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:10:58.8442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFPWTXiLTFwXmirZj5i/xQFYxQ+IZpluihvHOAgkOQuEVpBlxOkbVApFWoqslQ/h+2Ruhcz0/zSjKc/aqp7OiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7570
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

On Fri, May 23, 2025 at 10:20:09AM -0700, Tim Harvey wrote:
>The GW7902/GW7903/GW7904 have an alternate databus layout affecting a few
>of the DDRC and DDR PHY registers.
>
>The 512MB configuration used this alternate bus layout. Change
>the 512MB config to the standard bus configuration and add a generic
>function to patch the DDRC/PHY configs for the alternate bus layout.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
