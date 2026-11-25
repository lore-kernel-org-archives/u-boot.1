Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA8606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 00:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yIDJN8Xq;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AGiVJrhz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C47880CFE;
	Wed, 25 Nov 2026 00:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vostJ6zJw_-R; Wed, 25 Nov 2026 00:34:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8666280CDE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795566876;
	b=hlHNAU63cGDhYBoYoRNnrKwvceb9lP9q6YnFYnk/NJIbGOtnSrJdZtMOiASxWatNuH1H
	 A+90jKE3LSdoKZHbpMjJiy1YFYLA9WMYdHRqT3WVNVTFBudwbrUr3X3qqD32wVi85smRt
	 2OwZ4A7Ebt3JC1tDntbTpOHiFccVMeY7MPj1iujCDL82uWY/VhpvkngqQ18JQzuUD2sSB
	 1QSrWEZ8CBap5mtyjR5SE2qgaufDUavAg/BfpSMqMaU+nmogvdyiYJ73s19PV2JzFv175
	 s5RdnHlseV5x863qehiOS99AUze8h9ya4aQM/1gKckpxh3+oJCCi/WnBiKGbIXUv1wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795566876;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=9bZ9TFPWCfyAAnmvn3iVYjwMBtnNsLaUg7vcdYp0ZbA=;
	b=Qfj7feXoZIrloKLB8Xe/EhUoJ8HBUZu+RXX+FFAZPtwCP9zTkowhUrcImgQj8oy9IXwh
	 CA6W0vrkkOpkVkGGOR0XKB8ni2wFuwBd0I5sYLuccXXow+chP7Nv6IN675EVq0Q0QexKh
	 AaqL3g6SjL/yGasaXarDpHu+pBA+6qrNTYIYwGAU4uPCjh+w60WWr47SvDh+fuDxjKCS4
	 0DhjXvY8yaH2/RShvlEiByonNOSrXAc9WfV1XoWYM8Hrw0UdTEo7O0hXeDT2R2usKzkmM
	 Rgfw2ewYnV+hw4BtqZFk4JvYWDTf5PoRJ2FVErhw1liGjueSLfTetsbUjJ5s3q+JBZg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=fail header.from=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AGiVJrhz;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795566876;
	bh=9bZ9TFPWCfyAAnmvn3iVYjwMBtnNsLaUg7vcdYp0ZbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yIDJN8XqlRA5fs4VUpC4IO43fN31vTfaMSZhw0GAN7feTy3irZHRJ5IhJDR2P7vHQ
	 IT8kDbmPblc2mZE/0vm8LhoMxPblAwmjfNzgODuLeX9eQPTor8Kvkvc+G4zpSfzrDP
	 lDOmlkXzBnFNxUYAeAlLGr8ogvUS7zhsalUSsBGTKysIE0+tn9LjcIaxjTxHP+25py
	 U638x4gMY+KR/WvHY5Or3k+PodGeSXgAtAulaAGpAEmme6WfszoSNV42lDMbQgdv5d
	 RiPI9RWrOdQ02TdOoVy+hb+IibotJXyg7IJpPAOGnEZZhnJGKbciDChvtD2Xxc/l7X
	 i5ELaS2nKcJIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8666280CDE;
	Wed, 25 Nov 2026 00:34:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B515C10B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 00:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9AD3280CDE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 00:34:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_L2oO5ils5v for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 00:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE82980CBC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=AGiVJrhz
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE82980CBC
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 00:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bZ9TFPWCfyAAnmvn3iVYjwMBtnNsLaUg7vcdYp0ZbA=;
 b=AGiVJrhzOhWgTn2uHNqsURzygTo0eu/73uhhcuS8AAukvAn3uvdqOx8Ld8Lqye6+Bz4Y8jBHMDIeRFZ3936smW8GRs1+3MVoGs/f/6Aql5CwGF/JGFzNWp77q0N/yI5tQ2AKP0Zvaz3rrqK7nlRGPRzUdSagM/AvHitK150M+wRhfHk83J9GC2pDmiHlIwZ6iqFVPRB9DiNrJmgIm/O0LvZyjE4wXCLJqkZMgVPICSYnQ4SHuCLBc1JqB6MxDU15w3dgzVs1PZFsXCHk+Qf+Y+IAlvu4wQ8CMbfRXY8umttB4WRMJHbOFxYbDDSSsPAahvksDwA7CRAXV6T19gzuCg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI0PR04MB10418.eurprd04.prod.outlook.com (2603:10a6:800:231::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 00:34:28 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 00:34:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, u-boot@lists.u-boot-project.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 02/25] clk: imx8mn: register the main_axi,
 noc and gic clocks as critical
Date: Wed, 25 Nov 2026 08:31:28 +0800
Message-ID: <20261125003129.18729-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261121123451.2471185-3-dario.binacchi@amarulasolutions.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI0PR04MB10418:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef78704-1210-4313-1df7-08df4a8bdccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|19092799006|376014|7416014|1800799024|18002099003|261009223027099003|22082099003|261102123227099003|261028144727099003|56012099006|11063799006|10067099003|261026121527099003|261022105027099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: fPXUJKECdlYXZ98vlECbG2H+hm+bw2fATyGIirlFXfSOqBBTadsEj85zWyKCNqaRqjpXhDPBGOQZp5hbA5+4UMxqLVOJcQX27eaYeg/iXokdc09QAzyCxeJP66ZhktWWSPSvgh9c96LL/TaiMwx55eDm4KwVSgfIphXr10gRa1P6UlWRzZxxbhpCMwRiVHCS8VcoEEQhkJxH8ram00nSie6EXqh87Je9aH7sz57Lr8L7VC8iLxbXMuBmFVKHHwGGppGE7woVzxWZU6G61mLdtLH2Ic9YWDNGTKgUlSwKmBMEX9NrgnROqjAVMm0sdNoOQe/w+2tQkoLSQ16qjbzCvQU+T3xBS627h9sPnkdDPa4vg65c+pcU8dOfF9eK7xU38wJ9xPHKCaYuQt6GO2XT2L3aadLXPvBznPjF/Gqk+GDEHM8JL0MIz897sG5U6WtMqA8gSRQqjHeMBQr4cZqjwLlDi6bbjtcgbOmdmrdxGi+lFR1veA5nf58DqfVQtWZcZ+HshLHWQsuXGg6w0aMc42RUOOSzHTJrgE2QwpAUagoxAGkmvd8EX/jOcOn2ZGoXMPxfXzMyX8Tlc5a7onIy6bSdvDEBhMc7S/zzlwsMVVxMmcQNVMzj/HYXeBV8eMIQQDf06wgqCCyVF4WjdNqkWJ/1vYFj8vfWlQMmoFjgcj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(19092799006)(376014)(7416014)(1800799024)(18002099003)(261009223027099003)(22082099003)(261102123227099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(261026121527099003)(261022105027099003)(261026140227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0wNr0fX51qegkcJ5iVeaqw0CH9QVoWkfBRVT1p4dpPTXe05a4AhYAwGOVBvt?=
 =?us-ascii?Q?AwcJoRQx2SF8HmNaIQ7dhGMzduYOWd5P8aZB/J3n+DgvhFlGh1I9Ipuu9MV3?=
 =?us-ascii?Q?TA7nsz6EPk7CoU419jCYCQejYLs8K9c6+rHAVEpz4M3ZXjBN1adnb846eKld?=
 =?us-ascii?Q?D5MtAYvixoJYDUMKAF1c5wstwYcHTVXd2iK3iu22F4wYkPRVilKVm8l6ibrW?=
 =?us-ascii?Q?+hSYXdtssiDjpYR/o7g1B6ekXNdNNX6iNCtznYkwp3/0A7OJsnOZHP4kJsEi?=
 =?us-ascii?Q?QkwM0LV683+HpNUNjJPSG7f3LoJx5CQMTl4vFDdSYyXSIu3Zk9F3bWi2epYj?=
 =?us-ascii?Q?tZXCL/JPD4toU1Y+9XFMbED8Mdg09EP/hzCBsFKLihOTslyds1G47UGpALVo?=
 =?us-ascii?Q?5S4tszguR+V+6SstdC3qhGBbhfYkdG+sa2WwAt1DoGZJOB/PVeJ42tnkQWJp?=
 =?us-ascii?Q?Xxi1WKyZSmQdX1lo45EIne9R1BKwbHjDQss+1UQpZyplPBq2eVPe5mbssx9x?=
 =?us-ascii?Q?JWk/LNPbBG1luO33nLtrMINg0hQzNhuryX6aLE68RskgMVT81OJWZCy8RNV+?=
 =?us-ascii?Q?kmDhEaMBC5NaQ6rLIWUNKTQeCPJxxaULayHO69/Sk+h/Iqd81LxgERm31Y7M?=
 =?us-ascii?Q?xAYeu30y7QXZcXmFEtLhBbZB3KXeAZDVnrXKJUXv8fFw7X/2QHN6LS1eerFH?=
 =?us-ascii?Q?a5cflASecYqYNQGW/zbrLG48WLLj6MTIjmaKmR1IWZTq4DRBKWYTH2mWvfQp?=
 =?us-ascii?Q?Juxvlwu9PPouFw+lCA/PFdAafzHZlZ2exJ/bK7E7T83QVxG1S3FxuT5CdJpa?=
 =?us-ascii?Q?zbv2NIjsT3Gk1FYoscwLt8l0SbzFSdCi5STnSETsyvUQtUIldBu4de7qNzt0?=
 =?us-ascii?Q?oaNXLhhC301ph6KZeqIYJCQbx9rWQuS5pB4NjYeBVI0J3sgnrvP/ouWC1fA/?=
 =?us-ascii?Q?fxiaQ6itRkVAFEWiH/qsnao4b22pfiB8hb4HA2Vmm3wOkKI2gplc1T/VUIQ8?=
 =?us-ascii?Q?HUC66wWvjlNMfaphQs9i81kXPvIcq8kj0OFBKg2RwtZLnGmYmfSJenidUfYe?=
 =?us-ascii?Q?Acoocj405xSqEfm8Fj11Y/NGSOg9fqFL90Eu7+FFC2bKj5C2/YhakYBqGMNL?=
 =?us-ascii?Q?5t6UlVm9KAnE+lY9DOoD6kdHrAcKavs+lQxSCiR2pMGeGpqaVSX8PVdIKacI?=
 =?us-ascii?Q?6Eam8L06fmm2kQiAmUfWKpIfQq28+XT5lKDKtudEkSLtlRjdT/WLT3fpp92H?=
 =?us-ascii?Q?fB0VjYv4yFqqtzVoloJmyL0Bt5VSWvX3SQfQEpSLIvnYMoYdteQmt4eoX/4E?=
 =?us-ascii?Q?2GmGa8rKzoCRi2YPeanjyq5VGVvO0f8wEQHvX4b3fDuP5oFiixZo+toGgEB6?=
 =?us-ascii?Q?6+h297SIllseZaXgl5x5PCHgx2t8La1Oj/9fNRISw91QqqOcqTPMmQJxlay5?=
 =?us-ascii?Q?af5loStjQMGVRo+4CwCYHykTJk2rqpPsEK6wkvtjC/nFDAilh3nn4V22fohv?=
 =?us-ascii?Q?/4zU77EIvSCgWKgIc0nLIvxl2cTYiyTAEJzhQv50HdbJ1p+59BI4xHbeHWaF?=
 =?us-ascii?Q?PI4Iki2WbnnbqnQ5Yx8ZytUgBuu15PQu0fanXap98YSl1oUIATtw7ki+Ct6l?=
 =?us-ascii?Q?l377PgPcCmOE3dshLnWtGvON/gkZBD4B7bRMYTCzwfWFVEl6e5wLv8cQ6VIA?=
 =?us-ascii?Q?qwfA8EztJLdXWF+Zw0gA8Uf7bMKDEXsevbs/7fRP/sqXO6YNkf42dNuHIyju?=
 =?us-ascii?Q?I0ILQG4/iF7GFoZU4kPCMT2a1Ix0v+ZA7uCSzzerk+CLe2CvXR6z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef78704-1210-4313-1df7-08df4a8bdccd
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 00:34:28.0490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjTFThq/gP+xyRVFeALdewJQCT5YC2EoERwtyEAaTt4UFs38jz8U28Y2LNe3z8crGQPCVRe2cRWVY0UhKNEEKBqVnnmkpdhaWv645hxdhapqxFMHi1LsjQmhTFV13UWV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10418
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	T_SPF_PERMERROR,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 21 Nov 2026 13:33:52 +0100 Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:

> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> The main_axi, noc and gic clocks feed the system interconnect and the
> interrupt controller, and must never be gated. Register them as
> critical, as Linux does, so that their parent PLLs are kept running.
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> Changes in v2:
> - Reword subject and commit message to describe the change
> - Fix the coding style of the new clocks
> 
>  drivers/clk/imx/clk-imx8mn.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 2dfa860bf375..56d44192e35e 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -29,10 +29,19 @@ static const char * const imx8mn_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pl
>  					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
>  					       "audio_pll1_out", "sys_pll3_out", };
>  
> +static const char * const imx8mn_noc_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll3_out",
> +					       "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
> +					       "video_pll_out", "audio_pll2_out", };
> +

sys_pll1/2 are fixed clock. I not see the point of switching mux for noc/gic/axi to other parents.

Regards
Peng
